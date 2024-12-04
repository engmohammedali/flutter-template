import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:template/services/local_storage/storage_service.dart';

class LocalController with ChangeNotifier {
  LocalController() {
    _init();
  }

  late Locale _locale;
  Locale get locale => _locale;

  final StorageService _storage = StorageService();

  void _init() async {
    final languageCode = _storage.read('languageCode');
    if (languageCode.isEmpty) {
      _locale = window.locale;
      await _storage.save('languageCode', _locale.languageCode);
    } else {
      _locale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);
    await _storage.save('languageCode', languageCode);
    notifyListeners();
  }

  String get languageCode => _locale.languageCode;
}
