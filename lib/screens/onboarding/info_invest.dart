import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class InfoInvestScreen extends StatelessWidget {
  const InfoInvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/invest.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Text(
          'Investment Insights',
          style: primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Make smarter investment decisions. Tofu helps you track your portfolio, analyze growth, and manage risks',
          style: secondaryTextStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'With Tofu, you can plan your financial future with confidence!',
          style: secondaryTextStyle.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
