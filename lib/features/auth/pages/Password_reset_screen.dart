import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/router/app_routes.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/providers/reset_password.dart';

class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  ConsumerState<PasswordResetScreen> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<PasswordResetScreen> {
  final TextEditingController email = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final key = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailFocus.dispose();

    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgetPasswordState = ref.watch(resetPassword);
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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
                      autofocus: true,
                      borderRadius: 20,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (_) async {
                        await submit(forgetPasswordState);
                      },
                      hintText: 'enter email',
                      validator: validateEmailEnglish,
                      prefixIcon: Icon(Icons.email),
                    ),
                    SizedBox(
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
                            onPressed: () async {
                              await submit(forgetPasswordState);
                            },
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

  Future submit(AuthProvider resetPasswordProvider) async {
    FocusScope.of(context).unfocus();
    if (key.currentState!.validate()) {
      await resetPasswordProvider.sendEmail();
      if (resetPasswordProvider.isSuccess) {
        showSuccessSnackbar('Active email has been sent');
        context.pop();
      } else if (resetPasswordProvider.isError) {
        showErrorSnackbar('Unable to send email');
      }
    } else {
      showErrorSnackbar('enter email');
    }
  }
}
