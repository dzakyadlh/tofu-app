import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/screen_provider.dart';
import 'package:tofu/screens/add_financial_plan.dart';
import 'package:tofu/screens/complete_profile.dart';
import 'package:tofu/screens/financial_plan_detail.dart';
import 'package:tofu/screens/financial_plans.dart';
import 'package:tofu/screens/forgot_password.dart';
import 'package:tofu/screens/landing.dart';
import 'package:tofu/screens/main.dart';
import 'package:tofu/screens/onboarding.dart';
import 'package:tofu/screens/signin.dart';
import 'package:tofu/screens/signup.dart';
import 'package:tofu/screens/splash.dart';
import 'package:tofu/screens/transactions.dart';

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
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/complete-profile': (context) => const CompleteProfileScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/main': (context) => const MainScreen(),
          '/financial-plans': (context) => const FinancialPlansScreen(),
          '/financial-plan-detail': (context) =>
              const FinancialPlanDetailScreen(),
          '/transactions': (context) => const TransactionsScreen(),
          '/add-financial-plan': (context) => const AddFinancialPlanScreen(),
        },
      ),
    );
  }
}
