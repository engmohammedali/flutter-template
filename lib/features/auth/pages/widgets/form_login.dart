import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/data/models/user_model.dart';
import 'package:template/features/auth/pages/Password_reset_screen.dart';
import 'package:template/features/auth/pages/widgets/check_is_visibility.dart';
import 'package:template/features/auth/providers/auth_provider.dart';
import 'package:template/providers/auth_provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
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
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Consumer(builder: (context, ref, child) {
              final isvisibilityState = ref.watch(authLogin).isvisibility;

              return AppTextFormField(
                  focusNode: _secoundNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_buttonNode);
                  },
                  controller: controllerPassword,
                  isObscureText: !isvisibilityState,
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
                  suffixIcon: CheckIsVisibility());
            }),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordResetScreen()));
                  },
                  child: Text('Forgot your password?')),
            ),
            SizedBox(
              height: 30,
            ),
            Consumer(
              builder: (context, ref, child) {
                final result = ref.watch(authLogin);
                if (result.isLoading) {
                  return LoadingWidget();
                } else if (result.islogin) {
                } else if (result.isError) {
                  showErrorSnackbar('Error');
                }
                return AppTextButton(
                  focusNode: _buttonNode,
                  backgroundColor: AppColors.blueColor,
                  buttonText: 'login',
                  textStyle: TextStyle(color: Colors.white),
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      await verification(ref);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verification(WidgetRef ref) async {
    await ref.read(authLogin.notifier).login(UserModel(
        email: controllerEmail.text, password: controllerPassword.text));
    ref.read(authNotifierProvider.notifier).login();
  }
}
