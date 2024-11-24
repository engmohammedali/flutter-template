import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final forgetPasswordProvider =
    ChangeNotifierProvider((ref) => ForgetPasswordProvider());

class ForgetPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isError = false;
  bool _isSuccess = false;
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

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  bool get isError => _isError;
}
