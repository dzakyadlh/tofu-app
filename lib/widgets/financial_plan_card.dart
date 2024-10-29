import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class FinancialPlanCard extends StatefulWidget {
  const FinancialPlanCard({
    super.key,
    required this.title,
    required this.target,
    required this.timeRemaining,
    required this.monthlyTarget,
  });

  final String title;
  final int target;
  final String timeRemaining;
  final double monthlyTarget;

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
        onTap: () {
          Navigator.pushNamed(context, '/financial-plan-detail');
        },
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
                    '\$${widget.target}',
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
                    '+${widget.monthlyTarget}%',
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
