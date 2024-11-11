import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.accountNumber,
    required this.onPressed,
  });

  final String accountNumber;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/defaultpp.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(
              accountNumber,
              style: subtitleTextStyle.copyWith(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
