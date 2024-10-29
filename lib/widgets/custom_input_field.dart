import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isObscureText = false,
    this.fontSize = 14,
    this.obscureButton = false,
    this.padding = const EdgeInsets.only(top: 20),
  });

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final double fontSize;
  final bool obscureButton;
  final EdgeInsetsGeometry padding;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure =
        widget.isObscureText; // Initialize with the passed isObscureText value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.labelText != ''
              ? Text(
                  widget.labelText.toString(),
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: widget.fontSize,
                  ),
                )
              : const SizedBox()),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureButton ? _isObscure : false,
            cursorColor: primaryTextColor,
            style: primaryTextStyle.copyWith(
              fontSize: widget.fontSize,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: widget.hintText,
              hintStyle: subtitleTextStyle.copyWith(
                fontSize: widget.fontSize,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1.5,
                ),
              ),
              suffixIcon: widget.obscureButton
                  ? IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure =
                              !_isObscure; // Toggle password visibility
                        });
                      },
                    )
                  : null,
            ),
            validator: widget.validator,
          )
        ],
      ),
    );
  }
}
