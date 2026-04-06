import 'package:ecoms/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'secure_storage_provider.dart';

//theme notifier is a statecontroller
// so this notifier manages ThemeMode state
class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SecureStorageService storageService;
  //initial state by constructor
  ThemeNotifier(this.storageService) : super(ThemeMode.light) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final savedTheme = await storageService.getTheme();

    if (savedTheme == "dark") {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      await storageService.saveTheme("dark");
    } else {
      state = ThemeMode.light;
      await storageService.saveTheme("light");
    }
  }
}

//bidge of theme with Riverpod provide je kore
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final storage = ref.read(secureStorageProvider);
  return ThemeNotifier(storage);
});
