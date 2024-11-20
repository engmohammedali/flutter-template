// import 'package:flutter/material.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:dars_app/core/constants/keys.dart';
// import 'package:dars_app/di.dart';
// import 'package:dars_app/providers/auth_provider.dart';
// import 'package:dars_app/services/storage/storage_service.dart';

// const defaultLocale = Locale('ar', '');

// final storageService = locator<StorageService>();

// final localProvider = ChangeNotifierProvider((ref) => LocalController());

// class LocalController with ChangeNotifier {
//   LocalController() {
//     _init();
//   }

//   Locale _locale = Locale(defaultLocale.languageCode);
//   Locale get locale => _locale;

//   void _init() async {
//     final languageCode = storageService.read(languageCodeKey);
//     if (languageCode.isEmpty) {
//       final res = await authService.getSettings();

//       final langCode = res.mobileLocale?.langCode ?? defaultLocale.languageCode;
//       _locale = Locale(langCode);

//       storageService.write(languageCodeKey, langCode);
//     } else {
//       _locale = Locale(languageCode);
//     }
//     notifyListeners();
//   }

//   void changeLocale(Locale? locale) {
//     _locale = locale ?? defaultLocale;
//     storageService.write(languageCodeKey, _locale.languageCode);
//     notifyListeners();
//   }

//   final supportedLocales = const [
//     Locale('en'),
//     Locale('ar'),
//   ];
// }
