import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              side: BorderSide(width: 1.0, color: tertiaryColor),
            ),
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
