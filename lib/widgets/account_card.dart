import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.name,
    required this.accountId,
    required this.onPressed,
  });

  final String name;
  final String accountId;
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
                borderRadius: BorderRadius.circular(50),
                color: subtitleTextColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semibold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  accountId,
                  style: subtitleTextStyle.copyWith(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
