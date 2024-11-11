import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/auth_provider.dart';
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);

    handleSignIn() async {
      try {
        setState(() {
          isLoading = true;
        });
        await authProvider.signIn(
            emailController.text, passwordController.text);
        if (authProvider.isAuthenticated) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Sign In Failed: $e',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      'I Forgot My Password',
                      style: infoTextStyle.copyWith(fontSize: 12),
                    )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            handleSignIn();
                          }
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: tertiaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultRadius)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16)),
                        child: Text(
                          'Sign In',
                          style:
                              secondaryTextStyle.copyWith(fontWeight: semibold),
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
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          side: BorderSide(width: 1.0, color: tertiaryColor),
                        ),
                        child: Text(
                          'Create an account',
                          style:
                              secondaryTextStyle.copyWith(fontWeight: semibold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
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
          ],
        ),
      )),
    );
  }
}
