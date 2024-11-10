import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider = Provider.of(context);

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
              'Your Transactions',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget yearPicker() {
      int currentYear = DateTime.now().year;
      return SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            int year = currentYear - index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedYear = year;
                  transactionProvider.fetchTransactions(selectedYear);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  '$year',
                  style: (year == selectedYear
                          ? primaryTextStyle
                          : secondaryTextStyle)
                      .copyWith(
                    fontWeight: semibold,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    Widget emptyList() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You haven\'t done any transaction',
              style: secondaryTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Invest most of your money and transfer your money when you need to',
              style: subtitleTextStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomFilledButton(
                buttonText: 'Transfer Fund',
                onPressed: () {
                  Navigator.pushNamed(context, '/add-financial-plan');
                }),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    }

    Widget transactionList(List<Map<String, dynamic>> transactions) {
      return ListView.builder(
          itemCount: transactions.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: TransactionCard(
                title: transactions[index]['title'],
                date: DateFormat('d MMM yyyy h:mm a')
                    .format(transactions[index]['date']),
                amount: transactions[index]['amount'],
                category: transactions[index]['category'],
                isOutcome: transactions[index]['isOutcome'],
              ),
            );
          });
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            yearPicker(),
            const SizedBox(
              height: 16,
            ),
            Consumer<TransactionProvider>(builder: (context, provider, child) {
              return provider.transactions.isNotEmpty
                  ? transactionList(provider.transactions)
                  : emptyList();
            })
          ],
        ),
      )),
    );
  }
}
