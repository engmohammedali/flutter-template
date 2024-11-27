

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/data/models/user_model.dart';
import 'package:template/features/auth/pages/register.dart';
import 'package:template/features/auth/pages/widgets/check_is_visibility.dart';
import 'package:template/features/auth/providers/auth_provider.dart';

class FormLogin extends ConsumerStatefulWidget {
  const FormLogin({super.key});

  @override
  ConsumerState<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends ConsumerState<FormLogin> {
  final key = GlobalKey<FormState>();

  final TextEditingController controllerEmail = TextEditingController();

  final TextEditingController controllerPassword = TextEditingController();

  final FocusNode _firstNode = FocusNode();
  final FocusNode _secoundNode = FocusNode();
  final FocusNode _buttonNode = FocusNode();


  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    _firstNode.dispose();
    _secoundNode.dispose();
    _buttonNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _firstNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(authLogin);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(color: AppColors.ligtGrayColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AppTextFormField(
                  focusNode: _firstNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_secoundNode);
                  },
                  controller: controllerEmail,
                  prefixIcon: Icon(
                    Icons.email,
                    color: AppColors.ligtGrayColor,
                    size: 22,
                  ),
                  backgroundColor: AppColors.white,
                  borderRadius: 16,
                  hintStyle:
                      TextStyle(color: AppColors.ligtGrayColor, fontSize: 14),
                  hintText: 'enter email',
                  validator: validateEmailEnglish,
                  inputTextStyle: TextStyle(color: AppColors.ligtGrayColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.blueColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(color: AppColors.ligtGrayColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AppTextFormField(
                  focusNode: _secoundNode,
                  onFieldSubmitted: (_) async {
                    await submit(loginState);
                  },
                  controller: controllerPassword,
                  isObscureText: !loginState.isvisibility,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.ligtGrayColor,
                    size: 22,
                  ),
                  backgroundColor: AppColors.white,
                  borderRadius: 16,
                  hintStyle:
                      TextStyle(color: AppColors.ligtGrayColor, fontSize: 14),
                  hintText: '**********',
                  validator: validatePasswordEnglish,
                  inputTextStyle: TextStyle(color: AppColors.ligtGrayColor),
                  suffixIcon: CheckIsVisibility(
                    islogin: true,
                  ),
                  focusedBorder: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(16),
                      // borderSide: BorderSide(color: AppColors.blueColor),
                      ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //       onPressed: () {
                //         // context.pushNamed(AppRoutes.resetPassword.name);
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => PasswordResetScreen()));
                //       },
                //       child: Text('Forgot your password?')),
                // ),
                SizedBox(
                  height: 30,
                ),
                loginState.isLoading
                    ? LoadingWidget()
                    : AppTextButton(
                        focusNode: _buttonNode,
                        backgroundColor: AppColors.blueColor,
                        buttonText: 'login',
                        textStyle: TextStyle(color: Colors.white),
                        onPressed: () async {
                          await submit(loginState);
                        },
                      ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have an account?',
                        style: TextStyle(fontSize: 17)),
                    InkWell(
                      onTap: () {
                        // context.pushNamed(AppRoutes.register.name);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text('Register',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.blueColor,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future submit(LoginProvider loginProvider) async {
    FocusScope.of(context).unfocus();
    if (key.currentState!.validate()) {
      await loginProvider.login(UserModel(
          email: controllerEmail.text, password: controllerPassword.text));

      if (loginProvider.islogin) {
        showSuccessSnackbar('You are logged in');
      }
    } else {
      showErrorSnackbar('Check the fields');
    }
  }
}
