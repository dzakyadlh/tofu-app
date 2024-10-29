import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key, required this.buttonText, required this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
                backgroundColor: tertiaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius)),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
            child: Text(
              buttonText,
              style: secondaryTextStyle.copyWith(fontWeight: semibold),
            ),
          ),
        ),
      ],
    );
  }
}
