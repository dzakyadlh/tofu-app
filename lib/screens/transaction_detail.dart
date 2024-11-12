import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> transaction =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    IconData handleIcon(String category) {
      if (category == 'Top Up') {
        return Icons.credit_card;
      } else if (category == 'Electricity') {
        return Icons.lightbulb;
      } else if (category == 'Payment') {
        return Icons.payment;
      } else if (category == 'Salary') {
        return Icons.attach_money;
      } else if (category == 'Investment') {
        return Icons.show_chart;
      } else if (category == 'Grocery') {
        return Icons.shopping_cart;
      } else if (category == 'Business') {
        return Icons.business_center;
      } else if (category == 'Self-development') {
        return Icons.person;
      } else if (category == 'Enjoyments') {
        return Icons.tag_faces;
      } else {
        return Icons.question_mark;
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

    Widget header() {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Icon(
              handleIcon(transaction['category']),
              color: primaryColor,
              size: 48,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          transaction['isOutcome']
              ? Text(
                  '-\$${formatWithComma(transaction['amount'])}',
                  style: alertTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 16,
                  ),
                )
              : Text(
                  '+\$${formatWithComma(transaction['amount'])}',
                  style: primaryTextStyle.copyWith(
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
            '${transaction['method']['type']} ${transaction['method']['accountNumber']}',
            style: subtitleTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    Widget details() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Detail',
            style: secondaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
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
                '${transaction['method']['type']}',
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
                DateFormat('h:mm a').format(transaction['date']),
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
                DateFormat('d MMM yyyy').format(transaction['date']),
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
                    style: subtitleTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: transaction['id']));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Transaction ID copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.copy,
                      size: 16,
                      color: subtitleTextColor,
                    ),
                  ),
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
              transaction['isOutcome']
                  ? Text(
                      '-\$${formatWithComma(transaction['amount'])}',
                      style: alertTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                    )
                  : Text(
                      '+\$${formatWithComma(transaction['amount'])}',
                      style: primaryTextStyle.copyWith(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  header(),
                  SizedBox(
                    height: 24,
                  ),
                  details(),
                  button(),
                ],
              ),
            ),
          ),
        ));
  }
}
