import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/providers/forget_password.dart';

class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  ConsumerState<PasswordResetScreen> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<PasswordResetScreen> {
  final TextEditingController email = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _buttonFocus = FocusNode();
  final key = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailFocus.dispose();
    _buttonFocus.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgetPasswordState = ref.watch(forgetPasswordProvider);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I forgot my password',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please enter your email address',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'To send a verification code',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextFormField(
                      borderRadius: 20,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_buttonFocus);
                      },
                      hintText: 'enter email',
                      validator: validateEmailEnglish,
                      prefixIcon: Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    forgetPasswordState.isLoading
                        ? LoadingWidget()
                        : AppTextButton(
                            backgroundColor: Color.fromRGBO(76, 181, 237, 1),
                            buttonText: 'next',
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            onPressed: () async {},
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future submit(ForgetPasswordProvider forgetPasswordState) async {
    if (key.currentState!.validate()) {
      await forgetPasswordState.sendEmail();
      if (forgetPasswordState.isSuccess) {
        showSuccessSnackbar('Active email has been sent');
      } else if (forgetPasswordState.isError) {
        showErrorSnackbar('Unable to send email');
      }
    }
  }
}
