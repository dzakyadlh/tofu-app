import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/custom_editing_controller.dart';
import 'package:tofu/widgets/connected_account_card.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  int selectedMethod = 0;
  final amountController = IntegerTextEditingController();

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
              'Top Up to Tofu Wallet',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget methodSelector() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select a method',
            style: subtitleTextStyle.copyWith(fontSize: 14),
          ),
          ConnectedAccountCard(
            name: 'VISA',
            balance: 1000,
            radioValue: 0,
            radioGroupValue: selectedMethod,
            onChanged: (int? newValue) {
              setState(() {
                selectedMethod = newValue ?? 0;
              });
            },
          ),
          ConnectedAccountCard(
            name: 'VISA',
            balance: 1000,
            radioValue: 1,
            radioGroupValue: selectedMethod,
            onChanged: (int? newValue) {
              setState(() {
                selectedMethod = newValue ?? 1;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add another method',
                    style: infoTextStyle.copyWith(fontSize: 12),
                  )),
            ],
          )
        ],
      );
    }

    Widget amountInput() {
      return Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: CustomInputField(
          labelText: 'Insert an amount',
          hintText: '0',
          controller: amountController,
          keyboardType: TextInputType.number,
        ),
      );
    }

    Widget submitButton() {
      return CustomFilledButton(
          buttonText: 'Top Up',
          onPressed: () {
            Navigator.pushNamed(context, '/pin-verification');
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
            methodSelector(),
            Divider(
              color: Colors.white12,
            ),
            amountInput(),
            submitButton(),
          ],
        ),
      )),
    );
  }
}
