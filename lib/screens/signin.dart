import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomInputField(
              labelText: 'Email Address',
              hintText: 'johndoe@gmail.com',
              controller: emailController,
              isObscureText: false,
            ),
            CustomInputField(
              labelText: 'Password',
              hintText: '@jOhn511dOE.',
              controller: passwordController,
              isObscureText: true,
              obscureButton: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: Text(
                      'I Forgot My Password',
                      style: infoTextStyle.copyWith(fontSize: 12),
                    )),
              ],
            )
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
                    Navigator.pushNamed(context, '/main');
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16)),
                  child: Text(
                    'Sign In',
                    style: secondaryTextStyle.copyWith(fontWeight: semibold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    side: BorderSide(width: 1.0, color: tertiaryColor),
                  ),
                  child: Text(
                    'Create an account',
                    style: secondaryTextStyle.copyWith(fontWeight: semibold),
                  ),
                ),
              ),
            ],
          )
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
