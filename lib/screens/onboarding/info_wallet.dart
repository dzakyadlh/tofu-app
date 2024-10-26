import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class InfoWalletScreen extends StatelessWidget {
  const InfoWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.only(bottom: 32),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wallet.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Text(
          'Create a Wallet',
          style: primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Track all your financial transactions in one place. Add your income and expenses, and monitor your cash flow effortlessly.',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'With Tofu, you’ll always know where your money is going!',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        )
      ],
    );
  }
}
