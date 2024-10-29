import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/financial_plan_card.dart';
import 'package:tofu/widgets/monthly_cashflow.dart';
import 'package:tofu/widgets/transaction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/tofu.png'))),
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
          Row(
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
                      Text(
                        '125,050',
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

  Widget financialPlans() {
    return Container(
      width: double.infinity,
      color: backgroundPrimaryColor,
      padding: const EdgeInsets.all(8),
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
          const FinancialPlanCard(
            title: 'Financial Freedom',
            target: 1000000,
            timeRemaining: '10 year 3 months',
            monthlyTarget: 5.0,
          ),
          const SizedBox(
            height: 16,
          ),
          const FinancialPlanCard(
            title: 'Financial Freedom',
            target: 1000000,
            timeRemaining: '10 year 3 months',
            monthlyTarget: 5.0,
          ),
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

  Widget transactions() {
    return Container(
      color: backgroundPrimaryColor,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
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
          const TransactionCard(
            title: 'Electricity Bill',
            date: '20 October 2024, 3:15 pm',
            price: 250.00,
            category: 'electricity',
            isOutcome: true,
          ),
          const TransactionCard(
            title: 'Monthly Shopping',
            date: '20 October 2024, 3:15 pm',
            price: 125.00,
            category: 'grocery',
            isOutcome: true,
          ),
          const TransactionCard(
            title: 'Freelance Payment',
            date: '20 October 2024, 3:15 pm',
            price: 512.00,
            category: 'salary',
            isOutcome: false,
          ),
          const TransactionCard(
            title: 'Fine Dining',
            date: '15 October 2024, 3:15 pm',
            price: 50.00,
            category: 'enjoyments',
            isOutcome: true,
          ),
          const TransactionCard(
            title: 'Business Expansion',
            date: '1 October 2024, 3:15 pm',
            price: 1000.00,
            category: 'business',
            isOutcome: true,
          ),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: backgroundPrimaryColor,
            child: Column(
              children: [
                topBar(),
                const SizedBox(
                  height: 16,
                ),
                miniPortolio(),
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
                financialPlans(),
                const SizedBox(
                  height: 16,
                ),
                transactions(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
