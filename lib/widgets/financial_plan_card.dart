import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class FinancialPlanCard extends StatelessWidget {
  const FinancialPlanCard({
    super.key,
    required this.title,
    required this.target,
    required this.timeRemaining,
    required this.monthlyTarget,
  });

  final String title;
  final String target;
  final String timeRemaining;
  final String monthlyTarget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target:',
                style: subtitleTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                '\$$target',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time Remaining:',
                style: subtitleTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                timeRemaining,
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Target:',
                style: subtitleTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                '+$monthlyTarget%',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
