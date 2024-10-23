import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class InfoConnectScreen extends StatelessWidget {
  const InfoConnectScreen({super.key});

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
          'Top Up with Ease',
          style: primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Link your bank accounts, investment platforms, and financial services to Tofu. Enjoy real-time updates and a complete picture of your finances in one convenient app.',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Tofu provides secure connection with your financial accounts!',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
