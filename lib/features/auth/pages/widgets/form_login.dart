import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/data/models/user_model.dart';
import 'package:template/features/auth/data/sherd/sherd.dart';
import 'package:template/features/auth/pages/widgets/check_is_visibility.dart';
import 'package:template/features/auth/providers/auth_provider.dart';
import 'package:template/features/home/home.dart';
import 'package:template/providers/auth_provider.dart';

class FormLogin extends StatefulWidget {
  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(color: AppColors.ligtGrayColor),
                ),
                SizedBox(
                  height: 10,
                ),
                AppTextFormField(
                  controller: Sherd.controllerEmail,
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
                const Text(
                  "Password",
                  style: TextStyle(color: AppColors.ligtGrayColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer(builder: (context, ref, child) {
                  final isvisibilityState = ref.watch(isvisibility);

                  return AppTextFormField(
                      controller: Sherd.controllerPassword,
                      isObscureText: !isvisibilityState,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.ligtGrayColor,
                        size: 22,
                      ),
                      backgroundColor: AppColors.white,
                      borderRadius: 16,
                      hintStyle: TextStyle(
                          color: AppColors.ligtGrayColor, fontSize: 14),
                      hintText: '**********',
                      validator: validatePasswordEnglish,
                      inputTextStyle: TextStyle(color: AppColors.ligtGrayColor),
                      suffixIcon: CheckIsVisibility(
                        isvisibilityState: isvisibilityState,
                        ref: ref,
                      ));
                }),
                SizedBox(
                  height: 50,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final result = ref.watch(authLogin);
                    print(result.isLoading);
                    if (result.isLoading) {
                      return LoadingWidget();
                    } else if (result.islogin) {
                      print("Done");
                    } else if (result.isError) {
                      showErrorSnackbar("Error");
                    }
                    return AppTextButton(
                      backgroundColor: AppColors.blueColor,
                      buttonText: 'login',
                      textStyle: TextStyle(color: Colors.white),
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          await ref.read(authLogin.notifier).login(UserModel(
                              email: Sherd.controllerEmail.text,
                              password: Sherd.controllerPassword.text));
                          ref.read(authNotifierProvider.notifier).login();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
