import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/providers/financial_plan_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/financial_plan_card.dart';

class FinancialPlansScreen extends StatefulWidget {
  const FinancialPlansScreen({super.key});

  @override
  State<FinancialPlansScreen> createState() => _FinancialPlansScreenState();
}

class _FinancialPlansScreenState extends State<FinancialPlansScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> financialPlans = [];

  @override
  void initState() {
    super.initState();
    _fetchFinancialPlans();
  }

  Future<void> _fetchFinancialPlans() async {
    try {
      AuthProvider authProvider = Provider.of(context, listen: false);
      FinancialPlanProvider financialPlanProvider =
          Provider.of(context, listen: false);
      await financialPlanProvider.fetchFinancialPlans(authProvider.user!.uid);

      setState(() {
        financialPlans = financialPlanProvider.financialPlans;
        print(financialPlans);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

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

    Widget emptyList() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You don\'t have any financial plans',
              style: secondaryTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 16,
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
            const SizedBox(
              height: 16,
            ),
            CustomFilledButton(
                buttonText: 'Create a new plan',
                onPressed: () {
                  Navigator.pushNamed(context, '/add-financial-plan');
                })
          ],
        ),
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
              monthlyTarget: financialPlans[index]['monthlyTarget'],
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/financial-plan-detail',
                  arguments: financialPlans[index],
                );
              },
            ),
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
        child: Column(children: [
          Expanded(
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Show loading indicator while fetching
                : (financialPlans.isNotEmpty
                    ? financialPlansList()
                    : emptyList()),
          ),
        ]),
      )),
    );
  }
}
