import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';

class FinancialPlanCard extends StatelessWidget {
  const FinancialPlanCard({
    super.key,
    required this.title,
    required this.target,
    required this.timeRemaining,
    required this.monthlyTarget,
    required this.onPressed,
    this.isCompleted = false,
  });

  final String title;
  final int target;
  final String timeRemaining;
  final int monthlyTarget;
  final void Function()? onPressed;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border:
                Border.all(color: isCompleted ? primaryColor : Colors.white12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: isCompleted
                  ? primaryTextStyle
                  : secondaryTextStyle.copyWith(
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
                  '\$${formatWithComma(target)}',
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
                  '\$${formatWithComma(monthlyTarget)}',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonFinancialPlanCard extends StatelessWidget {
  const SkeletonFinancialPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: Colors.white24,
        highlightColor: Colors.white24,
        duration: Duration(seconds: 1),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Plan Title',
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
                  '\$1000000',
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
                  '1 year 1 month 1 day',
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
                  '\$10000',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
