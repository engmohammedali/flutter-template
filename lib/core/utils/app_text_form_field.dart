import 'package:flutter/material.dart';
import 'package:template/core/themes/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final Widget? suffix;
  final bool? isReadOnly;
  final bool? autofocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final void Function(String)? onFieldSubmitted;
  const AppTextFormField({
    super.key,
    this.autofocus,
    this.suffix,
    this.isReadOnly,
    this.keyboardType,
    this.onFieldSubmitted,
    this.focusNode,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.prefixIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly ?? false,
      autofocus: autofocus ?? false,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        suffix: suffix,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.ligtGrayColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.ligtGrayColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        hintStyle:
            hintStyle ?? TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? AppColors.primary50,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
    );
  }
}
