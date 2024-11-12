import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class CustomOutlinedButton extends StatefulWidget {
  const CustomOutlinedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
  });

  final String buttonText;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              side: BorderSide(width: 1.0, color: tertiaryColor),
            ),
            child: widget.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    widget.buttonText,
                    style: secondaryTextStyle.copyWith(fontWeight: semibold),
                  ),
          ),
        ),
      ],
    );
  }
}
