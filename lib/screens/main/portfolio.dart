import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/income_pie_chart.dart';
import 'package:tofu/widgets/outcome_pie_chart.dart';
import 'package:tofu/widgets/yearly_summary.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    Widget topBar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/tofu.png'))),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
              ))
        ],
      );
    }

    Widget miniPortolio() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Consumer<ConnectedAccountsProvider>(
                    builder: (context, connectedAccountProvider, child) {
                  return Skeletonizer(
                    enabled: userProvider.isLoading ||
                            connectedAccountProvider.isLoading
                        ? true
                        : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Balance',
                              style: secondaryTextStyle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$',
                                  style:
                                      secondaryTextStyle.copyWith(fontSize: 16),
                                ),
                                userProvider.isLoading ||
                                        connectedAccountProvider.isLoading
                                    ? Text('123456789')
                                    : Text(
                                        '${userProvider.user['wallet']['balance'] + connectedAccountProvider.totalBalance}',
                                        style: secondaryTextStyle.copyWith(
                                            fontWeight: semibold, fontSize: 20),
                                      )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Last month yield',
                              style: subtitleTextStyle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '+5.58%',
                              style: primaryTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: YearlySummary(),
            )
          ],
        ),
      );
    }

    Widget incomeStream() {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: backgroundPrimaryColor,
        ),
        child: Column(
          children: [
            Text(
              'Income Stream',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lifetime',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: secondaryTextColor,
                  size: 16,
                )
              ],
            ),
            Consumer<TransactionProvider>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ));
              }
              return IncomePieChart(
                transactionData: provider.getLifetimeSummary(),
              );
            }),
          ],
        ),
      );
    }

    Widget outcomeStream() {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: backgroundPrimaryColor,
        ),
        child: Column(
          children: [
            Text(
              'Outcome Stream',
              style: alertTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Lifetime',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: secondaryTextColor,
                  size: 16,
                )
              ],
            ),
            Consumer<TransactionProvider>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ));
              }
              return OutcomePieChart(
                transactionData: provider.getLifetimeSummary(),
              );
            }),
          ],
        ),
      );
    }

    Widget transactionsList() {
      return Container();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: backgroundPrimaryColor,
            child: Column(
              children: [
                topBar(),
                miniPortolio(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                incomeStream(),
                outcomeStream(),
                transactionsList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
