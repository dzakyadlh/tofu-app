import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/firebase_options.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/financial_plan_provider.dart';
import 'package:tofu/providers/screen_provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/screens/add_connected_accounts.dart';
import 'package:tofu/screens/add_financial_plan.dart';
import 'package:tofu/screens/complete_profile.dart';
import 'package:tofu/screens/create_pin.dart';
import 'package:tofu/screens/financial_plan_detail.dart';
import 'package:tofu/screens/financial_plans.dart';
import 'package:tofu/screens/forgot_password.dart';
import 'package:tofu/screens/fund_transfer.dart';
import 'package:tofu/screens/landing.dart';
import 'package:tofu/screens/main.dart';
import 'package:tofu/screens/onboarding.dart';
import 'package:tofu/screens/pin_verification.dart';
import 'package:tofu/screens/signin.dart';
import 'package:tofu/screens/signup.dart';
import 'package:tofu/screens/splash.dart';
import 'package:tofu/screens/top_up.dart';
import 'package:tofu/screens/transaction_detail.dart';
import 'package:tofu/screens/transaction_success.dart';
import 'package:tofu/screens/transactions.dart';
import 'package:tofu/screens/transfer_checkout.dart';
import 'package:tofu/screens/update_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => FinancialPlanProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(
            create: (context) => ConnectedAccountsProvider()),
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
          '/create-pin': (context) => const CreatePinScreen(),
          '/main': (context) => const MainScreen(),
          '/financial-plans': (context) => const FinancialPlansScreen(),
          '/financial-plan-detail': (context) =>
              const FinancialPlanDetailScreen(),
          '/add-financial-plan': (context) => const AddFinancialPlanScreen(),
          '/transactions': (context) => const TransactionsScreen(),
          '/transaction-detail': (context) => const TransactionDetailScreen(),
          '/transfer-fund': (context) => const FundTransferScreen(),
          '/transfer-checkout': (context) => const TransferCheckoutScreen(),
          '/pin-verification': (context) => const PinVerificationScreen(),
          '/transaction-success': (context) => const TransactionSuccessScreen(),
          '/top-up': (context) => const TopUpScreen(),
          '/add-connected-account': (context) => AddConnectedAccountsScreen(),
          '/update-profile': (context) => UpdateProfileScreen(),
        },
      ),
    );
  }
}
