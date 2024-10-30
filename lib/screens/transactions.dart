import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Electricity Bill',
      'date': '27 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Salary',
      'date': '25 October 2024, 3:15 pm',
      'price': 10000.00,
      'category': 'salary',
      'isOutcome': false,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
    {
      'title': 'Electricity Bill',
      'date': '20 October 2024, 3:15 pm',
      'price': 250.00,
      'category': 'electricity',
      'isOutcome': true,
    },
  ];

  int selectedYear = 0;

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
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedYear = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  '${currentYear - index}',
                  style: (index == selectedYear
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

    Widget transactionList() {
      return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: TransactionCard(
                title: transactions[index]['title'],
                date: transactions[index]['date'],
                price: transactions[index]['price'],
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
            Expanded(child: transactionList()),
          ],
        ),
      )),
    );
  }
}
