import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';

class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    Widget header() {
      return Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white12,
              ),
              child: Icon(
                Icons.sync_alt,
                color: primaryColor,
                size: 48,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '\$350',
              style: secondaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semibold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Transfer to Receiver',
              style: secondaryTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '1234174198724',
              style: subtitleTextStyle.copyWith(fontSize: 16),
            )
          ],
        ),
      );
    }

    Widget transactionDetails() {
      return Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Details',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white12,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  'Completed',
                  style: primaryTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  'Finplan Wallet',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  '12.00 am',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  '15 Jan 2024',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction ID',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  '1234567890',
                  style: secondaryTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white12,
            ),
            SizedBox(
              height: 4,
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
        ),
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
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              header(),
              transactionDetails(),
              buttons(),
            ],
          ),
        ),
      )),
    );
  }
}
