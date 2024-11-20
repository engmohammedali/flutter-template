import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Screen'),
      ),
      body: Center(
        child: Text('Welcome to the onboarding screen!'),
      ),
    );
  }
}
