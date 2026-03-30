import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _themeKey = "theme_mode";
  static const _authKey = "auth_status";

  //for AuthStatus
  Future<void> saveAuthStatus(String status) async {
    await _storage.write(key: _authKey, value: status);
  }

  Future<String?> getAuthStatus() async {
    return await _storage.read(key: _authKey);
  }

  //for Theme
  Future<void> saveTheme(String theme) async {
    await _storage.write(key: _themeKey, value: theme);
  }

  Future<String?> getTheme() async {
    return await _storage.read(key: _themeKey);
  }
}
