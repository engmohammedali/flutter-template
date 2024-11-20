// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:dars_app/configs/app_configs.dart';
// import 'package:dars_app/core/constants/constants.dart';
// import 'package:dars_app/core/errors/failure.dart';
// import 'package:dars_app/core/helpers/snackbar_helper.dart';
// import 'package:dars_app/core/routes/app_router.dart';
// import 'package:dars_app/di.dart';
// import 'package:dars_app/models/user_model.dart';
// import 'package:dars_app/services/network/auth_service.dart';
// import 'package:dars_app/services/requests/register_request.dart';
// import 'package:dars_app/services/storage/secure_storage_service.dart';
// import 'package:dars_app/services/storage/storage_service.dart';

// final authService = locator<AuthService>();

// final loadingProvider = StateProvider<bool>((_) => false);
// final authProvider = ChangeNotifierProvider((ref) => AuthController());

// final storage = locator<StorageService>();
// final secureStorage = locator<SecureStorageService>();

// class AuthController with ChangeNotifier {
//   bool? _isLoggedIn;
//   bool? get isLoggedIn => _isLoggedIn;

//   User? _user;
//   User? get user => _user;

//   AuthController() {
//     init();
//   }

//   Future<void> init() async {
//     try {
//       final res = await authService.getUserInfo();

//       if (res.data?.email == AppConfigs.mobileguestEmail) {
//         throw 'mobileguest';
//       }

//       setAuth(res.success);
//       if ((_isLoggedIn ?? false) && res.data != null) {
//         final user = res.data!;
//         _user = User(
//           id: user.id,
//           name: user.name,
//           phone: user.phone,
//           email: user.email,
//           emailVerifiedAt: user.emailVerifiedAt,
//         );
//       }
//     } catch (error) {
//       setAuth(false);
//       // storage.clear();
//       // secureStorage.clear();
//     }
//   }

//   Future<void> login(String username, String password) async {
//     try {
//       final res = await authService.login(username, password);
//       if (!(res.success ?? false)) throw res.message!;
//       setAuth(true);

//       final token = res.data?.token ?? '';
//       secureStorage.write(token);
//       _user = res.data?.user;

//       notifyListeners();
//     } catch (e) {
//       showErrorSnackbar(e.toString());
//       // rethrow;
//     }
//   }

//   Future<void> sociallogin(String provider, String accessToken) async {
//     var context = rootNavigatorKey.currentState!.context;

//     try {
//       final res = await authService.socialLogin(provider, accessToken);
//       if (!(res.success ?? false)) throw res.message!;
//       setAuth(true);

//       final token = res.data?.token ?? '';
//       secureStorage.write(token);
//       _user = res.data?.user;

//       notifyListeners();
//     } on Failure catch (error) {
//       if (error.message == 'ERR_020') {
//         // go to registration screen
//         context.pushNamed(AppRouter.register);
//         showErrorSnackbar(
//           error.toString(),
//         );
//       } else if (error.message == 'ERR_021') {
//         // go to confirm screen
//         context.pushReplacementNamed(AppRouter.confirm);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> register(RegisterRequest data) async {
//     try {
//       final res = await authService.register(data);
//       if (!(res.success ?? false)) throw res.message!;

//       setAuth(true);

//       final token = res.data?.token ?? '';
//       secureStorage.write(token);
//       _user = res.data?.user;

//       notifyListeners();
//     } catch (e) {
//       showErrorSnackbar(e.toString());
//       // rethrow;
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await authService.logout();
//     } on Failure catch (e) {
//       debugPrint('e: ${e.message}');
//     }

//     // Clear token or user data on logout
//     await storage.clear();
//     await secureStorage.clear();
//     await _deleteImageFromLocal();

//     setAuth(false);
//   }

//   Future<void> updateProfile(User data) async {
//     try {
//       final res = await authService.updateProfile(data);

//       final userData = res.data;
//       if (userData != null) {
//         _user = User(
//           id: userData.id,
//           name: userData.name,
//           phone: userData.phone,
//           email: userData.email,
//           emailVerifiedAt: userData.emailVerifiedAt,
//         );
//       }

//       notifyListeners();
//     } catch (e) {
//       showErrorSnackbar(e.toString());
//       // rethrow;
//     }
//   }

//   Future<void> deleteAccount() async {
//     await authService.deleteAccount();
//     // Clear token or user data on logout
//     await storage.clear();
//     await secureStorage.clear();
//     await _deleteImageFromLocal();

//     setAuth(false);
//   }

//   Future<void> _deleteImageFromLocal() async {
//     try {
//       final documentDirectory = await getApplicationDocumentsDirectory();
//       final filePath = '${documentDirectory.path}/avatar.png';
//       final file = File(filePath);

//       if (await file.exists()) {
//         file.deleteSync();
//       }
//     } finally {
//       // TODO
//     }
//   }

//   void setAuth(bool? value) {
//     _isLoggedIn = value;

//     notifyListeners();
//   }
// }
