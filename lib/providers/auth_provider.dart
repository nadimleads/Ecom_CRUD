import 'package:ecoms/services/secure_storage_service.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'secure_storage_provider.dart';

class AuthNotifier extends StateNotifier<bool> {
  final SecureStorageService storage;

  AuthNotifier(this.storage) : super(false) {
    checkLogin();
  }

  Future<void> checkLogin() async {
    final value = await storage.getAuthStatus(); // TEMP reuse key

    if (value == "loggedIn") {
      // trigger 3 things
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
