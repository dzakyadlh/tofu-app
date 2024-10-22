import 'package:flutter/material.dart';
import 'package:tofu/screens/complete_profile.dart';
import 'package:tofu/screens/forgot_password.dart';
import 'package:tofu/screens/landing.dart';
import 'package:tofu/screens/signin.dart';
import 'package:tofu/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelme',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LandingScreen(),
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/complete_profile': (context) => const CompleteProfile()
      },
    );
  }
}
