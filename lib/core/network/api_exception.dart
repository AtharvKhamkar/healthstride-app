class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.data,
  });

  @override
  String toString() =>
      'ApiException: $message (statusCode: $statusCode, errorCode: $errorCode)';
}

class NetworkException extends ApiException {
  const NetworkException({
    super.message = 'No internet connection. Please check your network.',
    super.statusCode,
  });
}

class ServerException extends ApiException {
  const ServerException({
    super.message = 'Server error. Please try again later.',
    super.statusCode = 500,
  });
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Session expired. Please log in again.',
    super.statusCode = 401,
    super.errorCode,
  });
}

class ForbiddenException extends ApiException {
  const ForbiddenException({
    super.message = 'You do not have permission to perform this action.',
    super.statusCode = 403,
    super.errorCode,
    super.data,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.statusCode = 404,
  });
}

class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    super.message = 'Validation failed. Please check your input.',
    super.statusCode = 422,
    this.errors,
  });
}

class TimeoutException extends ApiException {
  const TimeoutException({
    super.message = 'Request timed out. Please try again.',
    super.statusCode,
  });
}

class RequestCancelledException extends ApiException {
  const RequestCancelledException({
    super.message = 'Request was cancelled.',
    super.statusCode,
  });
}

class TooManyRequestsException extends ApiException {
  const TooManyRequestsException({
    super.message = 'Too many requests. Please wait a moment.',
    super.statusCode = 429,
  });
}
