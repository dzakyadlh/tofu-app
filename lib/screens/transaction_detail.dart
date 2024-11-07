import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

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
            ),
          ),
        ),
      );
    }

    Widget header() {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Icon(
              Icons.lightbulb,
              color: primaryColor,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '\$350',
            style: secondaryTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Transfer to receiver',
            style: secondaryTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'VISA 12345678',
            style: subtitleTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    Widget details() {
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
                'Completed',
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
                'VISA',
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
                    '1234567890',
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
                '\$350',
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
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            header(),
            details(),
            button(),
          ],
        ),
      )),
    );
  }
}
