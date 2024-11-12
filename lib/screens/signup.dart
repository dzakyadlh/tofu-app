import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    AuthProvider authProvider = Provider.of(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      await authProvider.signUp(emailController.text, passwordController.text);
      if (authProvider.isAuthenticated) {
        setState(() {
          isLoading = false;
        });
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/complete-profile', (_) => false);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign In Failed: $e',
              style: alertTextStyle.copyWith(
                fontWeight: semibold,
                fontSize: 14,
              ),
            ),
          ),
        );
      }
    }
  }

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
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email address cannot be empty';
                }
                return null;
              },
            ),
            CustomInputField(
              labelText: 'Password',
              hintText: '@jOhn511dOE.',
              controller: passwordController,
              isObscureText: true,
              obscureButton: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            CustomInputField(
              labelText: 'Confirm Password',
              hintText: '@jOhn511dOE.',
              controller: confirmPasswordController,
              isObscureText: true,
              obscureButton: true,
              validator: (value) {
                if (value!.isEmpty || value != passwordController.text) {
                  return 'Password confirmation is not the same as the password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                CustomFilledButton(
                    buttonText: 'Sign Up',
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signup();
                      }
                    }),
                const SizedBox(
                  height: 8,
                ),
                CustomOutlinedButton(
                    buttonText: 'I already have an account',
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    })
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputFields(),
          ],
        ),
      )),
    );
  }
}
