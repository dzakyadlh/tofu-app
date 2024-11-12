import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/financial_plan_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/loading_screen.dart';

class FinancialPlanDetailScreen extends StatefulWidget {
  const FinancialPlanDetailScreen({super.key});

  @override
  State<FinancialPlanDetailScreen> createState() =>
      _FinancialPlanDetailScreenState();
}

class _FinancialPlanDetailScreenState extends State<FinancialPlanDetailScreen> {
  bool isLoading = false;

  Future<void> completePlan(Map<String, dynamic> financialPlan) async {
    FinancialPlanProvider financialPlanProvider =
        Provider.of(context, listen: false);

    try {
      await financialPlanProvider.removeFinancialPlan(financialPlan['id']);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to complete financial plan: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final financialPlan =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    handleCompletePlan() {
      completePlan(financialPlan);
    }

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
              '${financialPlan['title']}',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget progressBar(int totalBalance) {
      int progress = (totalBalance / financialPlan['target'] * 100).round();
      if (progress > 100) {
        progress = 100;
      }
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$progress%',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
                Text(
                  '${formatWithComma(totalBalance)}/${formatWithComma(financialPlan['target'])}',
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
              value: (totalBalance / financialPlan['target']),
            )
          ],
        ),
      );
    }

    Widget planTarget(int totalBalance) {
      int neededBalance = financialPlan['target'] - totalBalance;

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
                  '\$${formatWithComma(totalBalance)}',
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
                neededBalance > 0
                    ? Text(
                        '-\$${formatWithComma(neededBalance)}',
                        style: alertTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        '0',
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                        textAlign: TextAlign.center,
                      )
              ],
            ),
          ],
        ),
      );
    }

    Widget planSchedule(int totalBalance) {
      int planCondition = 0;
      int initialTimeSpan = (((financialPlan['deadline']).year -
                  (financialPlan['createdAt']).year) *
              12) +
          ((financialPlan['deadline']).month -
              (financialPlan['createdAt']).month);
      int initialMonthlyTarget =
          (financialPlan['target'] / initialTimeSpan).round();
      int currentMonthlyTarget = ((financialPlan['target'] - totalBalance) /
              financialPlan['monthsRemaining'])
          .round();
      double difference = ((currentMonthlyTarget - initialMonthlyTarget) /
          initialMonthlyTarget);

      if (difference < 0.25) {
        planCondition = 1; // On track
      } else if (difference < 0.5) {
        planCondition = 2; // behind schedule
      } else if (difference < 1) {
        planCondition = 3; // off-track
      } else {
        planCondition = 0; // Can be completed
      }

      // Define the progress conclusion message and icon based on planCondition
      String conclusionText;
      IconData conclusionIcon;
      Color iconColor;

      switch (planCondition) {
        case 1:
          conclusionText = 'On Track';
          conclusionIcon = Icons.thumb_up;
          iconColor = tertiaryColor;
          break;
        case 2:
          conclusionText = 'Behind Schedule';
          conclusionIcon = Icons.warning;
          iconColor = Colors.orange;
          break;
        case 3:
          conclusionText = 'Off-track';
          conclusionIcon = Icons.thumb_down;
          iconColor = alertColor;
          break;
        default:
          conclusionText = 'Can be Completed!';
          conclusionIcon = Icons.check_circle;
          iconColor = primaryColor;
          break;
      }

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
                      conclusionIcon,
                      color: iconColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      conclusionText,
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

    Widget recommendations(int totalBalance) {
      int monthlyTarget = ((financialPlan['target'] - totalBalance) /
              financialPlan['monthsRemaining'])
          .round();
      monthlyTarget < 0 ? monthlyTarget = 0 : monthlyTarget;

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
                  '\$$monthlyTarget',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            monthlyTarget == 0
                ? Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: CustomFilledButton(
                        buttonText: 'Complete Plan',
                        onPressed: () {
                          handleCompletePlan();
                        }),
                  )
                : SizedBox()
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer2<UserProvider, ConnectedAccountsProvider>(
            builder: (context, userProvider, connectedAccountsProvider, child) {
              int totalBalance = userProvider.user['wallet']['balance'] +
                  connectedAccountsProvider.totalBalance;
              return userProvider.isLoading ||
                      connectedAccountsProvider.isLoading
                  ? LoadingScreen()
                  : Column(
                      children: [
                        progressBar(totalBalance),
                        planTarget(totalBalance),
                        planSchedule(totalBalance),
                        recommendations(totalBalance),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
