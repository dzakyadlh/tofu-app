import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/financial_plan_card.dart';

class FinancialPlansScreen extends StatefulWidget {
  const FinancialPlansScreen({super.key});

  @override
  State<FinancialPlansScreen> createState() => _FinancialPlansScreenState();
}

class _FinancialPlansScreenState extends State<FinancialPlansScreen> {
  final List<Map<String, dynamic>> financialPlans = [
    {
      'title': 'Financial Freedom',
      'target': 1000000,
      'timeRemaining': '10 year 3 months',
      'monthlyTarget': 5.0
    },
    {
      'title': 'Financial Freedom',
      'target': 1000000,
      'timeRemaining': '10 year 3 months',
      'monthlyTarget': 5.0
    },
    {
      'title': 'Financial Freedom',
      'target': 1000000,
      'timeRemaining': '10 year 3 months',
      'monthlyTarget': 5.0
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-financial-plan');
                  },
                  icon: Icon(
                    Icons.add,
                    size: 24,
                    color: subtitleTextColor,
                  ))
            ],
            title: Text(
              'Your Financial Plans',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget financialPlansList() {
      return ListView.builder(
        itemCount: financialPlans.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: FinancialPlanCard(
                title: financialPlans[index]['title'],
                target: financialPlans[index]['target'],
                timeRemaining: financialPlans[index]['timeRemaining'],
                monthlyTarget: financialPlans[index]['monthlyTarget']),
          );
        },
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [Expanded(child: financialPlansList())]),
      )),
    );
  }
}
