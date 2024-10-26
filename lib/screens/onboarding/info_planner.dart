import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class InfoPlannerScreen extends StatelessWidget {
  const InfoPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 300,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/plan.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Text(
          'Financial Planning',
          style: primaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Set financial goals, create budgets, and plan for your future.',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Tofu helps you stick to your plans and make progress towards achieving your financial dreams!',
          style: secondaryTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
