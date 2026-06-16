
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String registerVerifyOtp = '/auth/register/verify-otp';
  static const String registerResendOtp = '/auth/register/resend-otp';
  static const String registerCompleteProfile =
      '/auth/register/complete-profile';
  static const String refreshToken = '/auth/refresh-token';
  static const String syncHealthData = '/sync/health-data';
}
