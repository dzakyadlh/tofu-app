import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          Text(
            'Forgot Password',
            style:
                secondaryTextStyle.copyWith(fontWeight: semibold, fontSize: 24),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Enter the email associated with your account and we will send you a link to change your password',
            style: secondaryTextStyle.copyWith(fontSize: 14),
          )
        ],
      );
    }

    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomInputField(
              labelText: 'Email Address',
              hintText: 'johndoe@gmail.com',
              controller: emailController,
            ),
          ],
        ),
      );
    }

    Widget buttons() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/signin',
                      (_) => false,
                    );
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16)),
                  child: Text(
                    'Send me an email',
                    style: secondaryTextStyle.copyWith(fontWeight: semibold),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header(),
            const SizedBox(
              height: 8,
            ),
            inputFields(),
            const SizedBox(
              height: 16,
            ),
            buttons()
          ],
        ),
      )),
    );
  }
}
