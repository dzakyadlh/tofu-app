import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/screen_provider.dart';
import 'package:tofu/screens/complete_profile.dart';
import 'package:tofu/screens/forgot_password.dart';
import 'package:tofu/screens/landing.dart';
import 'package:tofu/screens/main.dart';
import 'package:tofu/screens/onboarding.dart';
import 'package:tofu/screens/signin.dart';
import 'package:tofu/screens/signup.dart';
import 'package:tofu/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenProvider())
      ],
      child: MaterialApp(
        title: 'Travelme',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/landing': (context) => const LandingScreen(),
          '/signin': (context) => const SigninScreen(),
          '/signup': (context) => const SignupScreen(),
          '/forgot_password': (context) => const ForgotPasswordScreen(),
          '/complete_profile': (context) => const CompleteProfileScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}
