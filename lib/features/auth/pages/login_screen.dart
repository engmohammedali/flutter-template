import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:template/core/router/app_routes.dart';
import 'package:template/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Login Screen!'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ref.read(authNotifierProvider.notifier).login,
          child: Icon(Icons.add)
          /*  
        () {
            ref.read(authNotifierProvider.notifier).login();
            // context.goNamed(
            //   AppRoutes.home.name,
            // );
          }, 
        */
          ),
    );
  }
}
