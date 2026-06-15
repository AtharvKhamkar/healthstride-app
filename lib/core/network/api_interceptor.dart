import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:healthstride/core/constants/api_constant.dart';
import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorage _secureStorage;
  final VoidCallback? onSessionExpired;
  Completer<String>? _refreshCompleter;

  AuthInterceptor({
    required this.dio,
    required SecureStorage secureStorage,
    this.onSessionExpired,
  }) : _secureStorage = secureStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for public endpoints
    final publicEndpoints = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.registerVerifyOtp,
      ApiEndpoints.registerResendOtp,
      ApiEndpoints.registerCompleteProfile,
    ];

    final requestPath = options.path.split('?').first;
    final isPublic = publicEndpoints.any(
      (endpoint) => requestPath == endpoint || requestPath.endsWith(endpoint),
    );

    if (!isPublic) {
      final token = await _secureStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    // A refresh is already in progress — wait for it, then retry this request
    if (_refreshCompleter != null) {
      try {
        final newToken = await _refreshCompleter!.future;
        final retryResponse = await _retryRequest(err.requestOptions, newToken);
        handler.resolve(retryResponse);
      } catch (_) {
        handler.reject(err);
      }
      return;
    }

    // This is the first 401 — start the refresh
    _refreshCompleter = Completer<String>();

    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) {
        await _secureStorage.clearTokens();
        onSessionExpired?.call();
        _refreshCompleter!.completeError(
          DioException(
            requestOptions: err.requestOptions,
            error: 'No refresh token',
          ),
        );
        handler.reject(err);
        return;
      }

      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['data']['accessToken'] as String;
        final newRefreshToken = response.data['data']['refreshToken'] as String;

        await _secureStorage.setAccessToken(newAccessToken);
        await _secureStorage.setRefreshToken(newRefreshToken);

        _refreshCompleter!.complete(newAccessToken);

        // Retry the original request that triggered the refresh
        final retryResponse = await _retryRequest(
          err.requestOptions,
          newAccessToken,
        );
        handler.resolve(retryResponse);
        return;
      }

      // Non-200 response from refresh endpoint
      await _secureStorage.clearTokens();
      onSessionExpired?.call();
      _refreshCompleter!.completeError(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Refresh failed',
        ),
      );
      handler.reject(err);
    } catch (e) {
      log('Token refresh failed: $e');
      await _secureStorage.clearTokens();
      onSessionExpired?.call();

      if (!_refreshCompleter!.isCompleted) {
        _refreshCompleter!.completeError(e);
      }
      handler.reject(err);
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String newToken,
  ) {
    requestOptions.headers['Authorization'] = 'Bearer $newToken';
    return dio.fetch(requestOptions);
  }
}

/// Retries idempotent requests on transient network failures with
/// exponential backoff. Only retries GET, PUT, DELETE — never POST/PATCH
/// to avoid duplicating side effects.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Set<String> _retryableMethods = const {'GET', 'PUT', 'DELETE'};
  final Set<int> _retryableStatuses = const {502, 503, 504};

  RetryInterceptor({required this.dio, this.maxRetries = 3});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final method = err.requestOptions.method.toUpperCase();
    if (!_retryableMethods.contains(method)) {
      handler.next(err);
      return;
    }

    final isRetryable = _isTransient(err);
    if (!isRetryable) {
      handler.next(err);
      return;
    }

    final attempt = (err.requestOptions.extra['_retryAttempt'] as int?) ?? 0;
    if (attempt >= maxRetries) {
      handler.next(err);
      return;
    }

    final delay = Duration(seconds: 1 << attempt); // 1s, 2s, 4s
    log(
      'Retry ${attempt + 1}/$maxRetries for ${err.requestOptions.method} '
      '${err.requestOptions.uri} in ${delay.inSeconds}s',
    );
    await Future.delayed(delay);

    err.requestOptions.extra['_retryAttempt'] = attempt + 1;
    try {
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (retryErr) {
      handler.next(retryErr);
    }
  }

  bool _isTransient(DioException err) {
    // Connection-level failures
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    // Server-side transient errors
    final statusCode = err.response?.statusCode;
    if (statusCode != null && _retryableStatuses.contains(statusCode)) {
      return true;
    }
    return false;
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('---> ${options.method} ${options.uri}');
    if (options.data != null) {
      log('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('<--- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('<--- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}');
    log('Message: ${err.message}');
    handler.next(err);
  }
}
