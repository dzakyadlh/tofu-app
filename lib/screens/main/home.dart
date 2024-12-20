import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/financial_plan_provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/financial_plan_card.dart';
import 'package:tofu/widgets/monthly_cashflow.dart';
import 'package:tofu/widgets/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

    Widget miniPortolio(UserProvider userProvider,
        ConnectedAccountsProvider connectedAccountProvider) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Skeletonizer(
              effect: ShimmerEffect(
                baseColor: Colors.white24,
                highlightColor: Colors.white24,
                duration: Duration(seconds: 1),
              ),
              enabled:
                  userProvider.isLoading || connectedAccountProvider.isLoading
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
                            style: secondaryTextStyle.copyWith(fontSize: 16),
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
                        'Last month growth',
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
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: MonthlyCashflow(),
            )
          ],
        ),
      );
    }

    Widget featuresMenu() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            onPressed: () {
              Navigator.pushNamed(context, '/transfer-fund');
            },
            style: FilledButton.styleFrom(
              backgroundColor: backgroundPrimaryColor,
              side: BorderSide(color: tertiaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              minimumSize: const Size(80, 80),
              maximumSize: const Size(80, 80),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.sync_alt,
                  color: primaryColor,
                  size: 32,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Fund Transfer',
                  style: primaryTextStyle.copyWith(fontSize: 8),
                )
              ],
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: backgroundPrimaryColor,
              side: BorderSide(color: tertiaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              minimumSize: const Size(80, 80),
              maximumSize: const Size(80, 80),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.show_chart,
                  color: primaryColor,
                  size: 32,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Investments',
                  style: primaryTextStyle.copyWith(fontSize: 8),
                )
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pushNamed(context, '/top-up');
            },
            style: FilledButton.styleFrom(
              backgroundColor: backgroundPrimaryColor,
              side: BorderSide(color: tertiaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              minimumSize: const Size(80, 80),
              maximumSize: const Size(80, 80),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.credit_card,
                  color: primaryColor,
                  size: 32,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Top Up',
                  style: primaryTextStyle.copyWith(fontSize: 8),
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget skeletonList() {
      return Skeletonizer(
        enabled: false,
        effect: ShimmerEffect(
          baseColor: Colors.white24,
          highlightColor: Colors.white24,
          duration: Duration(seconds: 1),
        ),
        child: Container(
          width: double.infinity,
          color: backgroundPrimaryColor,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SkeletonFinancialPlanCard(),
              SizedBox(
                height: 8,
              ),
              SkeletonFinancialPlanCard(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/transactions');
                },
                style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                child: Text(
                  'See more',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget emptyFinancialPlanList() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You don\'t have any financial plans',
              style: secondaryTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Create a new financial plan to help you manage and grow your wealth with us',
              style: subtitleTextStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget financialPlansList(List<Map<String, dynamic>> financialPlans,
        Map<String, dynamic> user, int totalBalance) {
      int currentBalance = user['wallet']['balance'] + totalBalance;
      int monthlyTarget1 = 0;
      int monthlyTarget2 = 0;
      if (financialPlans.isNotEmpty) {
        monthlyTarget1 = ((financialPlans[0]['target'] - currentBalance) /
                financialPlans[0]['monthsRemaining'])
            .round();
        monthlyTarget1 < 0 ? monthlyTarget1 = 0 : monthlyTarget1;
      }
      if (financialPlans.length > 1) {
        monthlyTarget2 = ((financialPlans[1]['target'] - currentBalance) /
                financialPlans[1]['monthsRemaining'])
            .round();
        monthlyTarget2 < 0 ? monthlyTarget2 = 0 : monthlyTarget2;
      }
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: backgroundPrimaryColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Financial Plans',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (financialPlans.isNotEmpty) ...[
              // Generate cards for the first two financial plans
              if (financialPlans.isNotEmpty)
                FinancialPlanCard(
                  title: financialPlans[0]['title'],
                  target: financialPlans[0]['target'],
                  timeRemaining: financialPlans[0]['timeRemaining'],
                  monthlyTarget: monthlyTarget1,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/financial-plan-detail',
                      arguments: financialPlans[0],
                    );
                  },
                ),
              const SizedBox(
                height: 8,
              ),
              if (financialPlans.length > 1)
                FinancialPlanCard(
                  title: financialPlans[1]['title'],
                  target: financialPlans[1]['target'],
                  timeRemaining: financialPlans[1]['timeRemaining'],
                  monthlyTarget: monthlyTarget2,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/financial-plan-detail',
                      arguments: financialPlans[1],
                    );
                  },
                ),
            ] else ...[
              emptyFinancialPlanList(), // Call the empty list widget if there are no plans
            ],
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/financial-plans');
              },
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              child: Text(
                'See more',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      );
    }

    Widget emptyTransactionList() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You haven\'t done any transaction',
              style: secondaryTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Create a wallet and then top up or connect to your bank accounts to be able to do any transactions with us',
              style: subtitleTextStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget transactionList(List<Map<String, dynamic>> transactions) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: backgroundPrimaryColor,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Text(
              'Transactions',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (transactions.isNotEmpty) ...[
              // Generate cards for the first two financial plans
              if (transactions.isNotEmpty)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/transaction-detail',
                        arguments: transactions[0]);
                  },
                  child: TransactionCard(
                    id: transactions[0]['id'],
                    title: transactions[0]['title'],
                    date: DateFormat('d MMM yyyy h:mm a')
                        .format(transactions[0]['date']),
                    amount: transactions[0]['amount'],
                    category: transactions[0]['category'],
                    isOutcome: transactions[0]['isOutcome'],
                  ),
                ),
              if (transactions.length > 1)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/transaction-detail',
                        arguments: transactions[1]);
                  },
                  child: TransactionCard(
                    id: transactions[1]['id'],
                    title: transactions[1]['title'],
                    date: DateFormat('d MMM yyyy h:mm a')
                        .format(transactions[1]['date']),
                    amount: transactions[1]['amount'],
                    category: transactions[1]['category'],
                    isOutcome: transactions[1]['isOutcome'],
                  ),
                ),
              if (transactions.length > 2)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/transaction-detail',
                        arguments: transactions[2]);
                  },
                  child: TransactionCard(
                    id: transactions[2]['id'],
                    title: transactions[2]['title'],
                    date: DateFormat('d MMM yyyy h:mm a')
                        .format(transactions[2]['date']),
                    amount: transactions[2]['amount'],
                    category: transactions[2]['category'],
                    isOutcome: transactions[2]['isOutcome'],
                  ),
                ),
              if (transactions.length > 3)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/transaction-detail',
                        arguments: transactions[3]);
                  },
                  child: TransactionCard(
                    id: transactions[3]['id'],
                    title: transactions[3]['title'],
                    date: DateFormat('d MMM yyyy h:mm a')
                        .format(transactions[3]['date']),
                    amount: transactions[3]['amount'],
                    category: transactions[3]['category'],
                    isOutcome: transactions[3]['isOutcome'],
                  ),
                ),
            ] else ...[
              emptyTransactionList(), // Call the empty list widget if there are no plans
            ],
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transactions');
              },
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              child: Text(
                'See more',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Consumer4<FinancialPlanProvider, UserProvider,
          ConnectedAccountsProvider, TransactionProvider>(
        builder: (context, financialPlanProvider, userProvider,
            connectedAccountsProvider, transactionProvider, child) {
          return Column(
            children: [
              Container(
                color: backgroundPrimaryColor,
                child: Column(
                  children: [
                    topBar(),
                    const SizedBox(
                      height: 16,
                    ),
                    miniPortolio(userProvider, connectedAccountsProvider),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    featuresMenu(),
                    const SizedBox(
                      height: 16,
                    ),
                    financialPlanProvider.isLoading ||
                            userProvider.isLoading ||
                            connectedAccountsProvider.isLoading
                        ? skeletonList()
                        : financialPlansList(
                            financialPlanProvider.financialPlans,
                            userProvider.user,
                            connectedAccountsProvider.totalBalance,
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    transactionProvider.isLoading
                        ? skeletonList()
                        : transactionList(transactionProvider.transactions),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
