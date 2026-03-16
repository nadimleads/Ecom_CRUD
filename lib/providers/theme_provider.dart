import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

//theme notifier is a statecontroller
// so this notifier manages ThemeMode state
class ThemeNotifier extends StateNotifier<ThemeMode> {
  //initial state by constructor
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

//bridge
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  // When someone asks for themeProvider create ThemeNotifier
  (_) => ThemeNotifier(),
);
