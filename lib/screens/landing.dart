import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/landing_img.png',
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                'Reach your financial goal with us',
                style: primaryTextStyle.copyWith(
                    fontWeight: semibold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'We offer you the best financial features and most secure system to help you grow your wealth',
                style: secondaryTextStyle.copyWith(
                    fontWeight: light, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: tertiaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16)),
                      child: Text(
                        'Sign Up',
                        style:
                            secondaryTextStyle.copyWith(fontWeight: semibold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        side: BorderSide(width: 1.0, color: tertiaryColor),
                      ),
                      child: Text(
                        'I already have an account',
                        style:
                            secondaryTextStyle.copyWith(fontWeight: semibold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
