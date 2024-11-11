import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';
import 'package:tofu/widgets/loading_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String? transactionId = args['id'];

    IconData transactionIcon = Icons.question_mark;

    handleIcon(String category) {
      switch (category) {
        case 'Top Up':
          transactionIcon = Icons.credit_card;
          break;
        case 'electricity':
          transactionIcon = Icons.lightbulb;
          break;
        case 'salary':
          transactionIcon = Icons.attach_money;
          break;
        case 'investment':
          transactionIcon = Icons.show_chart;
          break;
        case 'grocery':
          transactionIcon = Icons.shopping_cart;
          break;
        case 'business':
          transactionIcon = Icons.business_center;
          break;
        case 'self-development':
          transactionIcon = Icons.person;
          break;
        case 'enjoyments':
          transactionIcon = Icons.tag_faces;
          break;
        default:
          transactionIcon = Icons.question_mark;
          break;
      }
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
            ),
          ),
        ),
      );
    }

    Widget header(Map<String, dynamic> transaction) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Icon(
              transactionIcon,
              color: primaryColor,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '\$${transaction['amount']}',
            style: secondaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${transaction['category']}',
            style: secondaryTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${transaction['method']} ${transaction['methodAccountNumber']}',
            style: subtitleTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    Widget details(Map<String, dynamic> transaction) {
      return Column(
        children: [
          Text(
            'Transaction Detail',
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Colors.white12,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '${transaction['status']}',
                style: primaryTextStyle.copyWith(fontSize: 14),
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
                'Payment Method',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '${transaction['method']}',
                style: secondaryTextStyle.copyWith(fontSize: 14),
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
                'Time',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '12.00 AM',
                style: secondaryTextStyle.copyWith(fontSize: 14),
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
                'Date',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '15 Jan 2024',
                style: secondaryTextStyle.copyWith(fontSize: 14),
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
                'Transaction ID',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    '${transaction['id']}',
                    style: secondaryTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.copy,
                    size: 16,
                    color: subtitleTextColor,
                  )
                ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              Text(
                '\$${transaction['amount']}',
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget button() {
      return Container(
        padding: const EdgeInsets.only(top: 32),
        child:
            CustomOutlinedButton(buttonText: 'Share Receipt', onPressed: () {}),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: transactionProvider.fetchTransactionById(transactionId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Transaction not found'),
            );
          } else {
            final transaction = snapshot.data!;
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      header(transaction),
                      details(transaction),
                      button(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
