import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/account_card.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class FundTransferScreen extends StatefulWidget {
  const FundTransferScreen({super.key});

  @override
  State<FundTransferScreen> createState() => _FundTransferScreenState();
}

class _FundTransferScreenState extends State<FundTransferScreen> {
  final targetAccountController = TextEditingController(text: '');

  @override
  void dispose() {
    targetAccountController.dispose();
    super.dispose();
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
            title: Text(
              'Transfer',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget topMenu() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Scan a QR',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Bank Transfer',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Multipayment',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget accountInput() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: CustomInputField(
          labelText: '',
          hintText: 'Type a name or account ID to send',
          controller: targetAccountController,
          padding: EdgeInsets.zero,
        ),
      );
    }

    Widget accountHistoryList() {
      return Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AccountCard(
                  name: 'Rei Mizuki',
                  accountId: '12314811242131',
                  onPressed: () {
                    Navigator.pushNamed(context, '/transfer-checkout');
                  },
                ),
              );
            }),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            topMenu(),
            accountInput(),
            accountHistoryList(),
          ],
        ),
      ),
    );
  }
}
