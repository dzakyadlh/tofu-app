import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';

class FinancialPlanCard extends StatefulWidget {
  const FinancialPlanCard({
    super.key,
    required this.title,
    required this.target,
    required this.timeRemaining,
    required this.monthlyTarget,
    required this.onPressed,
  });

  final String title;
  final int target;
  final String timeRemaining;
  final int monthlyTarget;
  final void Function()? onPressed;

  @override
  State<FinancialPlanCard> createState() => _FinancialPlanCardState();
}

class _FinancialPlanCardState extends State<FinancialPlanCard> {
  bool isActive = false;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: widget.onPressed,
        splashColor: primaryColor,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border:
                  Border.all(color: isHover ? primaryColor : Colors.white12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
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
                    '\$${formatWithComma(widget.target)}',
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
                    widget.timeRemaining,
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
                    '\$${formatWithComma(widget.monthlyTarget)}',
                    style: primaryTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
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
