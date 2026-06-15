
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _userKey = 'user_data';
  static const _biometricEnabledKey = 'biometric_enabled';

  final FlutterSecureStorage _storage;

  SecureStorage()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

  // Access Token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  // Refresh Token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  // User ID
  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  // Future<User?> getUser() async {
  //   final userString = await _storage.read(key: _userKey);

  //   if (userString == null || userString.isEmpty) return null;

  //   try {
  //     final Map<String, dynamic> jsonMap = jsonDecode(userString);
  //     return User.fromJson(jsonMap);
  //   } catch (e) {
  //     return null; // Optional: handle error/log
  //   }
  // }

  Future<void> setUserId(String id) async {
    await _storage.write(key: _userIdKey, value: id);
  }

  // Future<void> setUser(User user) async {
  //   final userJsonString = jsonEncode(user.toJson());
  //   await _storage.write(key: _userKey, value: userJsonString);
  // }

  // Biometric
  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricEnabledKey, value: enabled.toString());
  }

  // Token Management
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      setAccessToken(accessToken),
      setRefreshToken(refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Clear All
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> setDeviceRegistered(bool registered) async {
    await _storage.write(
      key: 'device_registered',
      value: registered.toString(),
    );
  }

  Future<bool> isDeviceRegistered() async {
    final value = await _storage.read(key: 'device_registered');
    return value == 'true';
  }

  Future<void> setDeviceToken(String? token) async {
    if (token != null) {
      await _storage.write(key: 'device_token', value: token);
    } else {
      await _storage.delete(key: 'device_token');
    }
  }

  Future<String?> getDeviceToken() async {
    return await _storage.read(key: 'device_token');
  }
}
