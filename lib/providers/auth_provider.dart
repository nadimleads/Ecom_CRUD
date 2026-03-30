import 'package:ecoms/providers/theme_provider.dart';
import 'package:ecoms/services/secure_storage_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<bool> {
  final SecureStorageService storage;

  AuthNotifier(this.storage) : super(false) {
    checkLogin();
  }

  Future<void> checkLogin() async {
    final value = await storage.getAuthStatus(); // TEMP reuse key

    if (value == "loggedIn") {
      state = true;
    } else {
      state = false;
    }
  }

  Future<void> login() async {
    await storage.saveAuthStatus("loggedIn"); // TEMP reuse key
    state = true;
  }

  Future<void> logout() async {
    await storage.saveAuthStatus("loggedOut");
    state = false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthNotifier(storage);
});
