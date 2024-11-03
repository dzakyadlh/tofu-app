import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final confirmPasswordController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });
      try {
        await authProvider.signUp(
            emailController.text, passwordController.text);
        if (authProvider.isAuthenticated) {
          isLoading = false;
          Navigator.pushNamedAndRemoveUntil(
              context, '/complete-profile', (_) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Sign Up Failed: $e',
          style: alertTextStyle.copyWith(
            fontWeight: semibold,
            fontSize: 14,
          ),
        )));
      }
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
              isObscureText: false,
            ),
            CustomInputField(
              labelText: 'Password',
              hintText: '@jOhn511dOE.',
              controller: passwordController,
              isObscureText: true,
              obscureButton: true,
            ),
            CustomInputField(
              labelText: 'Confirm Password',
              hintText: '@jOhn511dOE.',
              controller: confirmPasswordController,
              isObscureText: true,
              obscureButton: true,
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
                    handleSignUp();
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16)),
                  child: Text(
                    'Sign Up',
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
                    Navigator.pushNamed(context, '/signin');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    side: BorderSide(width: 1.0, color: tertiaryColor),
                  ),
                  child: Text(
                    'I already have an account',
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
              height: 32,
            ),
            buttons()
          ],
        ),
      )),
    );
  }
}
