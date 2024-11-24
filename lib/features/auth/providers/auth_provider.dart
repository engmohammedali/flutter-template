import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/auth/data/models/user_model.dart';

final authLogin = ChangeNotifierProvider((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _islogin = false;
  bool _isvisibility = false;
  bool _isError = false;
  UserModel? _userModel;

  Future<void> login(UserModel user) async {
    try {
      _isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 5));
      _userModel = user;
      _isLoading = false;
      _islogin = true;
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

  UserModel get user => _userModel!;
  bool get isLoading => _isLoading;
  bool get isvisibility => _isvisibility;
  bool get islogin => _islogin;
  bool get isError => _isError;
}
