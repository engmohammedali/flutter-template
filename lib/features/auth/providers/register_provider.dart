import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerProvider = ChangeNotifierProvider((ref) => RegisterProvider());

class RegisterProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isRegister = false;
  bool _isvisibility = false;
  bool _isError = false;
  Uint8List? _imgPath;
  String? _img;
  bool _isUploadImg = false;
  bool _isCheckAcceptprivacypolicy = false;

  Future<void> register() async {
    try {
      _isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 5));

      _isLoading = false;
      _isRegister = true;
      notifyListeners();
    } catch (e) {
      _isError = true;
      notifyListeners();
    }
  }

  void changvisibility() {
    _isvisibility = !_isvisibility;
    notifyListeners();
  }

  bool passwordverification(String password, String confirmPassword) {
    if (password.trim() == confirmPassword.trim()) return true;
    return false;
  }

  void updateAptprivacypolicy() {
    _isCheckAcceptprivacypolicy = !_isCheckAcceptprivacypolicy;
    notifyListeners();
  }

  void uploadimgPath({required Uint8List? imgpath, required String img}) {
    _imgPath = imgpath;
    _img = img;
    _isUploadImg = true;
    print(_img);
    notifyListeners();
  }

  String? get img => _img;
  bool get isLoading => _isLoading;
  bool get isvisibility => _isvisibility;
  bool get isRegister => _isRegister;
  bool get isError => _isError;
  bool get isCheckAcceptprivacypolicy => _isCheckAcceptprivacypolicy;
  bool get isUploadImg => _isUploadImg;
  Uint8List? get imgPath => _imgPath;
}
