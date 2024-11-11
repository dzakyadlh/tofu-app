import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/custom_editing_controller.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class TransferCheckoutScreen extends StatefulWidget {
  const TransferCheckoutScreen({super.key});

  @override
  State<TransferCheckoutScreen> createState() => _TransferCheckoutScreenState();
}

class _TransferCheckoutScreenState extends State<TransferCheckoutScreen> {
  final amountController = IntegerTextEditingController();
  final noteController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
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
              'Transfer to Rei Mizuki',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget header() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'From',
          style: subtitleTextStyle.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        AccountCard(
          accountName: 'Finplan',
          balance: 5000,
          isSource: true,
        ),
        const SizedBox(height: 16),
        Text(
          'Transfer to',
          style: subtitleTextStyle.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        AccountCard(
          accountName: 'Rei Mizuki',
          accountNumber: '12478128912381',
          isSource: false,
        ),
      ]);
    }

    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              labelText: 'Insert an amount',
              hintText: '0',
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            CustomInputField(
              labelText: 'Additional Note for Rei Mizuki',
              hintText: 'My part for dinner last week',
              controller: noteController,
            ),
            const SizedBox(height: 32),
            CustomFilledButton(
                buttonText: 'Transfer',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/pin-verification');
                  }
                }),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      backgroundColor: const Color(0xFF222222),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              inputFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String accountName;
  final double? balance;
  final String? accountNumber;
  final bool isSource;

  const AccountCard({
    super.key,
    required this.accountName,
    this.balance,
    this.accountNumber,
    required this.isSource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (isSource)
            Text(
              accountName,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semibold,
              ),
            )
          else
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF323232),
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isSource ? 'Your Balance' : accountName,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    )),
                const SizedBox(height: 8),
                Text(
                    isSource
                        ? '\$${balance?.toStringAsFixed(2)}'
                        : accountNumber ?? '',
                    style: isSource
                        ? primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold)
                        : subtitleTextStyle.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
