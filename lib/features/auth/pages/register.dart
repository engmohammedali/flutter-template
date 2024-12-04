import 'package:flutter/material.dart';
import 'package:template/core/utils/list_countires.dart';
import 'package:template/features/auth/pages/widgets/form_register.dart';
import 'package:template/generated/l10n.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          ListCountires(),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).register,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              FormRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
