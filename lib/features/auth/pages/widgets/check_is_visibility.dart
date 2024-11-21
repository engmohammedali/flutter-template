import 'package:flutter/material.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/features/auth/providers/auth_provider.dart';

class CheckIsVisibility extends StatelessWidget {
  final bool isvisibilityState;
  final ref;
  const CheckIsVisibility(
      {super.key, required this.isvisibilityState, required this.ref});

  @override
  Widget build(BuildContext context) {
    return isvisibilityState
        ? IconButton(
            onPressed: () {
              ref.read(isvisibility.notifier).state = !isvisibilityState;
            },
            icon: Icon(
              Icons.visibility_off,
              color: AppColors.blueColor,
            ))
        : IconButton(
            onPressed: () {
              ref.read(isvisibility.notifier).state = !isvisibilityState;
            },
            icon: Icon(
              Icons.visibility,
              color: AppColors.ligtGrayColor,
            ));
  }
}
