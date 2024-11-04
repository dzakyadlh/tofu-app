import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';

class FinancialPlanDetailScreen extends StatefulWidget {
  const FinancialPlanDetailScreen({super.key});

  @override
  State<FinancialPlanDetailScreen> createState() =>
      _FinancialPlanDetailScreenState();
}

class _FinancialPlanDetailScreenState extends State<FinancialPlanDetailScreen> {
  double _progressValue = 0.0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _progressValue = 0.0;
  }

  void _updateProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        _progressValue += 0.01;
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          return;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final financialPlan =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    PreferredSizeWidget topBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            backgroundColor: backgroundPrimaryColor,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: subtitleTextColor,
                )),
            title: Text(
              'Financial Freedom',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget progressBar() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '15% Progress',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                // Text(
                //   '${(_progressValue * 100).round()}% Progress',
                //   style: secondaryTextStyle.copyWith(
                //     fontSize: 16,
                //     fontWeight: semibold,
                //   ),
                // ),
                Text(
                  '125,000/${formatWithComma(financialPlan['target'])}',
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            LinearProgressIndicator(
              minHeight: 8,
              backgroundColor: subtitleTextColor,
              valueColor: AlwaysStoppedAnimation(primaryColor),
              value: 0.15,
            )
            // LinearProgressIndicator(
            //   minHeight: 8,
            //   backgroundColor: subtitleTextColor,
            //   valueColor: AlwaysStoppedAnimation(primaryColor),
            //   value: _progressValue,
            // )
          ],
        ),
      );
    }

    Widget planTarget() {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Target',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Target',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$${formatWithComma(financialPlan['target'])}',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
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
                  'Current Balance',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$125,000',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.white12,
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Money needed to reach target',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '-\$875,000',
                  style: alertTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget planSchedule() {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plan Schedule',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deadline',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(financialPlan['deadline']),
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
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
                  'Time Remaining',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${financialPlan['timeRemaining']}',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.white12,
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress tracking conclusion',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.whatshot,
                      color: primaryColor,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'On Track',
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget recommendations() {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Balance Target',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$${financialPlan['monthlyTarget']}',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
          child: Column(
        children: [
          progressBar(),
          planTarget(),
          planSchedule(),
          recommendations(),
        ],
      )),
    );
  }
}
