import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';

class TransferCheckoutScreen extends StatelessWidget {
  const TransferCheckoutScreen({super.key});

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

    return Scaffold(
      appBar: topBar(),
      backgroundColor: const Color(0xFF222222),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 32),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        label: 'Insert an amount',
                        hintText: '0',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: 'Additional Note for Rei Mizuki',
                        hintText: 'My part for the dinner last week',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 32),
                      CustomFilledButton(
                          buttonText: 'Transfer',
                          onPressed: () {
                            Navigator.pushNamed(context, '/pin-verification');
                          }),
                    ],
                  ),
                ),
              ],
            ),
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

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;

  const InputField({
    super.key,
    required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: primaryTextStyle.copyWith(fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: subtitleTextStyle.copyWith(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFB0E8C9)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Sora',
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
