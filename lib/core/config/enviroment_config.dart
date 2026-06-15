import 'package:healthstride/flavors.dart';

class EnvironmentConfig {
  final String baseUrl;
  final String guestApiKey;
  final String xApiKey;
  final String xApiSecretKey;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  const EnvironmentConfig({
    required this.baseUrl,
    required this.guestApiKey,
    required this.xApiKey,
    required this.xApiSecretKey,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
  });

  static const development = EnvironmentConfig(
    baseUrl: '',
    guestApiKey: '',
    xApiKey: '',
    xApiSecretKey: '',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
  );

  static const production = EnvironmentConfig(
    baseUrl: '',
    guestApiKey: '',
    xApiKey: '',
    xApiSecretKey: '',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
  );

  static EnvironmentConfig get current {
    switch (F.appFlavor) {
      case Flavor.dev:
        return development;
      case Flavor.prod:
        return production;
    }
  }
}
