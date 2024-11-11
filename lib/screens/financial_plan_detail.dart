import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';
import 'package:tofu/widgets/loading_screen.dart';

class FinancialPlanDetailScreen extends StatefulWidget {
  const FinancialPlanDetailScreen({super.key});

  @override
  State<FinancialPlanDetailScreen> createState() =>
      _FinancialPlanDetailScreenState();
}

class _FinancialPlanDetailScreenState extends State<FinancialPlanDetailScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final financialPlan =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

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

    Widget recommendations(int totalBalance) {
      print(financialPlan['monthsRemaining']);
      int monthlyTarget = ((financialPlan['target'] - totalBalance) /
              financialPlan['monthsRemaining'])
          .round();

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
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(child:
          Consumer<UserProvider>(builder: (context, userProvider, child) {
        return Consumer<ConnectedAccountsProvider>(
            builder: (context, connectedAccountsProvider, child) {
          if (userProvider.isLoading || connectedAccountsProvider.isLoading) {
            return LoadingScreen();
          }

          int totalBalance = userProvider.user['wallet']['balance'] +
              connectedAccountsProvider.totalBalance;

          return Column(
            children: [
              progressBar(totalBalance),
              planTarget(totalBalance),
              planSchedule(),
              recommendations(totalBalance),
            ],
          );
        });
      })),
    );
  }
}
