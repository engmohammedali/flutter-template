import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/features/auth/providers/auth_provider.dart';

class CheckIsVisibility extends ConsumerWidget {
  const CheckIsVisibility({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final loginState = ref.watch(authLogin);
    return loginState.isvisibility
        ? IconButton(
            onPressed: () {
              loginState.changvisibility();
            },
            icon: Icon(
              Icons.visibility_off,
              color: AppColors.blueColor,
            ))
        : IconButton(
            onPressed: () {
              loginState.changvisibility();
            },
            icon: Icon(
              Icons.visibility,
              color: AppColors.ligtGrayColor,
            ));
  }
}
