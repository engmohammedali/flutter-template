import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/auth/data/models/user_model.dart';

final isvisibility = StateProvider<bool>((ref) => false);
final authLogin = ChangeNotifierProvider((ref) => loginProvider());
// final authLogin =
//     FutureProviderFamily<dynamic, UserModel>((ref, UserModel user) async {
//   final rusaltUser = await loginMethod(user);
//   return rusaltUser;
// });

class loginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _islogin = false;
  bool _isError = false;
  UserModel? _userModel;

  Future<void> login(UserModel user) async {
    try {
      _isLoading = true;
      notifyListeners();
      _userModel = await loginMethod(user);
      _isLoading = false;
      _islogin = true;
      notifyListeners();
    } catch (e) {
      _isError = true;
      notifyListeners();
    }
  }

  UserModel get user => _userModel!;
  bool get isLoading => _isLoading;
  bool get islogin => _islogin;
  bool get isError => _isError;
}

Future<UserModel> loginMethod(UserModel user) async {
  await Future.delayed(Duration(seconds: 5));
  return user;
}

bool checkLoginState(WidgetRef ref) {
  final loginState = ref.read(authLogin); // الوصول إلى الـ provider
  return loginState.islogin;
}
