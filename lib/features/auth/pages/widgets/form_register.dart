import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/components/loading/loading_widget.dart';
import 'package:template/core/functions/validators.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/core/utils/app_text_button.dart';
import 'package:template/core/utils/app_text_form_field.dart';
import 'package:template/core/utils/snackbars.dart';
import 'package:template/features/auth/pages/widgets/check_is_visibility.dart';
import 'package:template/features/auth/pages/widgets/custom_chech_box.dart';
import 'package:template/features/auth/pages/widgets/custon_img_picker.dart';
import 'package:template/features/auth/pages/widgets/phone_number_input.dart';
import 'package:template/features/auth/providers/register_provider.dart';
import 'package:template/generated/l10n.dart';

class FormRegister extends ConsumerStatefulWidget {
  const FormRegister({super.key});

  @override
  ConsumerState<FormRegister> createState() => _FormLoginState();
}

class _FormLoginState extends ConsumerState<FormRegister> {
  final key = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerUserName = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfrimFocusNode = FocusNode();

  Uint8List? _imgData;
  String? _imgName;
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerUserName.dispose();
    controllerPhone.dispose();
    controllerPassword.dispose();
    controllerConfirmPassword.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passwordConfrimFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _userNameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustonImg(
                  img: 'assets/imgs/avatar.png',
                  getImgData: (imgData, imgName) {
                    _imgData = imgData;
                    _imgName = imgName;
                    print(imgName);
                  },
                ),
              ),
              Text(
                S.of(context).Username,
                style: TextStyle(color: AppColors.ligtGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              AppTextFormField(
                keyboardType: TextInputType.text,
                focusNode: _userNameFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                controller: controllerUserName,
                prefixIcon: Icon(
                  Icons.person,
                  color: AppColors.ligtGrayColor,
                  size: 22,
                ),
                backgroundColor: AppColors.white,
                borderRadius: 16,
                hintStyle:
                    TextStyle(color: AppColors.ligtGrayColor, fontSize: 14),
                hintText: S.of(context).enter_username,
                validator: validateUserNameEnglish,
                inputTextStyle: TextStyle(color: AppColors.ligtGrayColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.blueColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).email,
                style: TextStyle(color: AppColors.ligtGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              AppTextFormField(
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_phoneFocusNode);
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
                hintText: S.of(context).enter_email,
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
              Text(
                S.of(context).Phone,
                style: TextStyle(color: AppColors.ligtGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              PhoneNumberInput(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                controllerPhone: controllerPhone,
                focusNode: _phoneFocusNode,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).password,
                style: TextStyle(color: AppColors.ligtGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              AppTextFormField(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.blueColor),
                ),
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (_) async {
                  FocusScope.of(context)
                      .requestFocus(_passwordConfrimFocusNode);
                },
                controller: controllerPassword,
                isObscureText: !registerState.isvisibility,
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
                  islogin: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).Confirm_Password,
                style: TextStyle(color: AppColors.ligtGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              AppTextFormField(
                isObscureText: !registerState.isvisibility,
                focusNode: _passwordConfrimFocusNode,
                onFieldSubmitted: (_) async {
                  await submit(registerState);
                },
                controller: controllerConfirmPassword,
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.blueColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomChechBox(
                isAccepted: registerState.isCheckAcceptprivacypolicy,
                onTap: () {
                  registerState.updateAptprivacypolicy();
                },
              ),
              SizedBox(
                height: 30,
              ),
              registerState.isLoading
                  ? LoadingWidget()
                  : AppTextButton(
                      backgroundColor: AppColors.blueColor,
                      buttonText: S.of(context).register,
                      textStyle: TextStyle(color: Colors.white),
                      onPressed: () async {
                        await submit(registerState);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future submit(RegisterProvider registerProvider) async {
    FocusScope.of(context).unfocus();
    if (key.currentState!.validate() && _imgData != null) {
      await chechFeilds(registerProvider);
    } else {
      showErrorSnackbar('Make sure you enter an image');
    }
  }

  Future<void> chechFeilds(RegisterProvider registerProvider) async {
    if (registerProvider.passwordverification(
        controllerPassword.text, controllerConfirmPassword.text)) {
      await checkIsAccetPrivacypolicy(registerProvider);
    } else {
      showErrorSnackbar('The password is not equal');
    }
  }

  Future<void> checkIsAccetPrivacypolicy(
      RegisterProvider registerProvider) async {
    if (registerProvider.isCheckAcceptprivacypolicy) {
      await registerProvider.register();

      if (registerProvider.isRegister) {
        showSuccessSnackbar('The operation was completed successfully');
        Navigator.pop(context);
      }
    } else if (registerProvider.isError) {
      showErrorSnackbar('error');
    } else {
      showErrorSnackbar('She did not agree Accept privacy policy ');
    }
  }
}
