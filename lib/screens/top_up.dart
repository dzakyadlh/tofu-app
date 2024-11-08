import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
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
  Map<String, dynamic> selectedMethodData = {};
  final amountController = IntegerTextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    handleTopUp() {
      int transactionAmount = amountController.integerValue!;
      Navigator.pushNamed(
        context,
        '/pin-verification',
        arguments: {
          'transactionType': 'Top Up',
          'transactionAmount': transactionAmount,
          'connectedAccount': selectedMethodData,
        },
      );
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
          Consumer<ConnectedAccountsProvider>(
              builder: (context, provider, child) {
            if (provider.connectedAccounts.isEmpty) {
              return Text(
                'No connected accounts',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.connectedAccounts.length,
              itemBuilder: (context, index) {
                final account = provider.connectedAccounts[index];
                if (index == 0) {
                  selectedMethodData = account;
                }
                return ConnectedAccountCard(
                  name: account['name'],
                  balance: account['balance'],
                  icon: account['icon'],
                  radioValue: index,
                  radioGroupValue: selectedMethod,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMethod = newValue ?? 0;
                      selectedMethodData = account;
                    });
                  },
                );
              },
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-connected-account');
                  },
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
      return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: CustomInputField(
            labelText: 'Insert an amount',
            hintText: '0',
            controller: amountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty || amountController.integerValue! < 5) {
                return 'Transfer amount cannot be less than \$5';
              }
              return null;
            },
          ),
        ),
      );
    }

    Widget submitButton() {
      return CustomFilledButton(
          buttonText: 'Top Up',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              handleTopUp();
            }
          });
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SingleChildScrollView(
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
