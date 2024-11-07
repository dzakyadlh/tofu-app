import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/number_format.dart';

class ConnectedAccountCard extends StatelessWidget {
  final String name;
  final int balance;
  final int radioValue;
  final int radioGroupValue;
  final ValueChanged<int?> onChanged;

  const ConnectedAccountCard({
    super.key,
    required this.name,
    required this.balance,
    required this.radioValue,
    required this.radioGroupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(radioValue), // Makes the entire card selectable.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ListTile(
          leading: Image.asset(
            'assets/images/visa.png', // Ensure the path is correct in your project.
            width: 50,
            fit: BoxFit.fitWidth,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Prevents Column from taking full height.
            children: [
              Text(
                name,
                style: secondaryTextStyle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${formatWithComma(balance)}',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          trailing: Radio<int>(
            value: radioValue,
            groupValue: radioGroupValue,
            onChanged: onChanged,
            activeColor: tertiaryColor,
          ),
        ),
      ),
    );
  }
}
