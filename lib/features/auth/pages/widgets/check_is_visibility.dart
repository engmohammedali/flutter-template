import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/themes/app_colors.dart';
import 'package:template/features/auth/providers/auth_provider.dart';
import 'package:template/features/auth/providers/register_provider.dart';

class CheckIsVisibility extends ConsumerWidget {
  final bool islogin;
  const CheckIsVisibility({super.key, this.islogin = false});

  @override
  Widget build(BuildContext context, ref) {
    final state;
    if (islogin) {
      state = ref.watch(authLogin);
    } else {
      state = ref.watch(registerProvider);
    }

    return state.isvisibility
        ? IconButton(
            onPressed: () {
              state.changvisibility();
            },
            icon: Icon(
              Icons.visibility_off,
              color: AppColors.blueColor,
            ))
        : IconButton(
            onPressed: () {
              state.changvisibility();
            },
            icon: Icon(
              Icons.visibility,
              color: AppColors.ligtGrayColor,
            ));
  }
}
