import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class CustomFilledButton extends StatefulWidget {
  const CustomFilledButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
  });

  final String buttonText;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: FilledButton(
          onPressed: widget.isLoading
              ? null
              : widget.onPressed, // Disable button while loading
          style: FilledButton.styleFrom(
            backgroundColor: tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    ]);
  }
}
