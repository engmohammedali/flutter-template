// import 'package:flutter/material.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:template/core/keys/keys.dart';

// final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
//   (ref) => AppThemeModeNotifier(ref.watch(storageServiceProvider)),
// );

// class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
//   final StorageService storage;

//   ThemeMode currentTheme = ThemeMode.light;

//   AppThemeModeNotifier(this.storage) : super(ThemeMode.light) {
//     getCurrentTheme();
//   }

//   void toggleTheme() {
//     state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//     storage.save(themeKey, state.name);
//   }

//   void getCurrentTheme() async {
//     final theme = storage.read(themeKey);
//     if (theme.isEmpty) {
//       state = ThemeMode.system;
//     } else {
//       final value = ThemeMode.values.byName(theme);
//       state = value;
//     }
//   }
// }
