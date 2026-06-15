import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:healthstride/core/config/enviroment_config.dart';
import 'package:healthstride/core/network/api_exception.dart';
import '../storage/secure_storage.dart';
import 'api_interceptor.dart';

class ApiClient {
  late final Dio _dio;
  final SecureStorage _secureStorage;

  ApiClient({
    required SecureStorage secureStorage,
    VoidCallback? onSessionExpired,
  }) : _secureStorage = secureStorage {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.current.baseUrl,
        connectTimeout: EnvironmentConfig.current.connectTimeout,
        receiveTimeout: EnvironmentConfig.current.receiveTimeout,
        sendTimeout: EnvironmentConfig.current.sendTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(
        dio: _dio,
        secureStorage: _secureStorage,
        onSessionExpired: onSessionExpired,
      ),
      RetryInterceptor(dio: _dio),
      LoggingInterceptor(),
    ]);

    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> uploadFile(
    String path, {
    required FormData formData,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException error) {
    log('=== DIO ERROR ===');
    log('Type: ${error.type}');
    log('Message: ${error.message}');
    log('URL: ${error.requestOptions.baseUrl}${error.requestOptions.path}');
    log('Response: ${error.response?.data}');
    log('Status Code: ${error.response?.statusCode}');
    if (error.error != null) log('Raw Error: ${error.error}');
    log('=================');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.cancel:
        return const RequestCancelledException();

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      default:
        return ApiException(
          message: error.message ?? 'An unexpected error occurred.',
          statusCode: error.response?.statusCode,
        );
    }
  }

  ApiException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode ?? 500;
    final data = response?.data;

    String message = 'Something went wrong';
    String? errorCode;
    dynamic errorData;

    // if (data is Map<String, dynamic>) {
    //   // Backend wraps errors in {success: false, error: {code, message}}
    //   final errorObj = data['error'] as Map<String, dynamic>?;
    //   if (errorObj != null) {
    //     message = errorObj['message'] as String? ?? message;
    //     errorCode = errorObj['code'] as String?;
    //     errorData = errorObj['data'];
    //   } else {
    //     message = data['message'] as String? ?? message;
    //   }
    // }

    if (data is Map<String, dynamic>) {
      final errorObj = data['error'] as Map<String, dynamic>?;
      log('📡 [ApiClient] Received error response:');
      log('   - Full error object: $errorObj');

      if (errorObj != null) {
        message = errorObj['message'] as String? ?? message;
        errorCode = errorObj['code'] as String?;
        errorData = errorObj['data'];
        log(
          '✅ [ApiClient] Extracted: code=$errorCode, message=$message, data=$errorData',
        );
      } else {
        message = data['message'] as String? ?? message;
      }
    }

    // Never expose raw backend messages for server errors — they may
    // contain SQL errors, stack traces, or internal paths.
    if (statusCode >= 500) {
      return const ServerException(
        message: 'Something went wrong. Please try again later.',
      );
    }

    switch (statusCode) {
      case 401:
        return UnauthorizedException(message: message, errorCode: errorCode);
      case 403:
        return ForbiddenException(
          message: message,
          errorCode: errorCode,
          data: errorData,
        );
      case 404:
        return NotFoundException(message: message);
      case 422:
        Map<String, List<String>>? errors;
        if (data is Map<String, dynamic> && data['errors'] != null) {
          errors = (data['errors'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
              key,
              (value as List).map((e) => e.toString()).toList(),
            ),
          );
        }
        return ValidationException(message: message, errors: errors);
      case 429:
        return TooManyRequestsException(message: message);
      default:
        return ApiException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
          data: errorData,
        );
    }
  }
}
