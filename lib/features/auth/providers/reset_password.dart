import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resetPassword = ChangeNotifierProvider((ref) => AuthProvider());

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  bool _isSuccess = false;
  bool _isCheckAcceptprivacypolicy = false;

  Future<void> sendEmail() async {
    try {
      _isLoading = true;
      notifyListeners();
      await Future.delayed(Duration(seconds: 5));
      _isLoading = false;
      _isSuccess = true;
      notifyListeners();
    } catch (e) {
      _isError = true;
      notifyListeners();
    }
  }

  void updateptprivacypolicy() {
    _isCheckAcceptprivacypolicy = !_isCheckAcceptprivacypolicy;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  bool get isError => _isError;
  bool get isCheckAcceptprivacypolicy => _isCheckAcceptprivacypolicy;
}
