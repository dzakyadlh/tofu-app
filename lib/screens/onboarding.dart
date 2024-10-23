import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/screen_provider.dart';
import 'package:tofu/screens/onboarding/info_connect.dart';
import 'package:tofu/screens/onboarding/info_invest.dart';
import 'package:tofu/screens/onboarding/info_planner.dart';
import 'package:tofu/screens/onboarding/info_wallet.dart';
import 'package:tofu/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int totalScreens = 4;

  @override
  Widget build(BuildContext context) {
    ScreenProvider screenProvider = Provider.of(context);

    Widget contents() {
      switch (screenProvider.currentIndex) {
        case 1:
          return const InfoInvestScreen();
        case 2:
          return const InfoPlannerScreen();
        case 3:
          return const InfoConnectScreen();
        default:
          return const InfoWalletScreen(); // Default screen when index is 0
      }
    }

    Widget stepIndicator(int currentIndex) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 50,
              height: 8,
              decoration: BoxDecoration(
                color: index == currentIndex ? primaryColor : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }));
    }

    Widget bottomBar() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 64, top: 32),
        child: Column(
          children: [
            stepIndicator(screenProvider.currentIndex),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (screenProvider.currentIndex < totalScreens - 1) {
                        screenProvider.currentIndex += 1;
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/main', (_) => false);
                      }
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: tertiaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16)),
                    child: Text(
                      'Next',
                      style: secondaryTextStyle.copyWith(fontWeight: semibold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if (screenProvider.currentIndex > 0)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        screenProvider.currentIndex -= 1;
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        side: BorderSide(width: 1.0, color: tertiaryColor),
                      ),
                      child: Text(
                        'Previous',
                        style:
                            secondaryTextStyle.copyWith(fontWeight: semibold),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child:
                    contents(), // Content takes the remaining available space
              ),
            ),
            bottomBar(), // Bottom bar stays at the bottom
          ],
        ),
      ),
    );
  }
}
