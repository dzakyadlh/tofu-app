import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class InfoInvestScreen extends StatelessWidget {
  const InfoInvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/landing_img.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Text(
          'Investment Insights',
          style: primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Make smarter investment decisions. Tofu helps you track your portfolio, analyze growth, and manage risks',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'With Tofu, you can plan your financial future with confidence!',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
