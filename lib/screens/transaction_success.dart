import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';
import 'package:tofu/widgets/loading_screen.dart';

class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Transaction Success',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
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

    Widget buttons() {
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            CustomOutlinedButton(buttonText: 'Share Receipt', onPressed: () {}),
            SizedBox(
              height: 4,
            ),
            CustomOutlinedButton(
                buttonText: 'Back to Home',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (_) => false);
                }),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Consumer<TransactionProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return LoadingScreen();
              }
              handleIcon(provider.transactions[0]['category']);
              return Column(
                children: [
                  header(provider.transactions[0]),
                  details(provider.transactions[0]),
                  buttons(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
