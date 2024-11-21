import 'package:flutter/material.dart';
import 'package:template/features/auth/data/sherd/sherd.dart';
import 'package:template/features/auth/pages/widgets/form_login.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    Sherd.controllerEmail.clear();
    Sherd.controllerPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     onPressed: ref.read(authNotifierProvider.notifier).login,
      //     child: Icon(Icons.add)
      //     /*
      //   () {
      //       ref.read(authNotifierProvider.notifier).login();
      //       // context.goNamed(
      //       //   AppRoutes.home.name,
      //       // );
      //     },
      //   */
      //     ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 1)),
            ),
            FormLogin(),
          ],
        ),
      ),
    );
  }
}
