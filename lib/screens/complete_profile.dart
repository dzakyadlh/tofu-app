import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final nameController = TextEditingController(text: '');
  final birthDateController = TextEditingController(text: '');
  final occupationController = TextEditingController(text: '');
  final phoneNumberController = TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Text(
        'Help us to know more about you!',
        style: secondaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
      );
    }

    Widget profilePictureField() {
      return Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(50)),
            alignment: Alignment.center,
            child: const Icon(
              Icons.person_add_alt_1,
              size: 80,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Upload a profile picture to help us identify you',
            style:
                secondaryTextStyle.copyWith(fontWeight: regular, fontSize: 12),
          ),
        ],
      );
    }

    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomInputField(
              labelText: 'What is Your Full Name? *',
              hintText: 'Mizuki Akai',
              controller: nameController,
            ),
            CustomInputField(
              labelText: 'When is Your Birth Date? *',
              hintText: '29/02/2000',
              controller: birthDateController,
            ),
            CustomInputField(
              labelText: 'What is Your Occupation? *',
              hintText: 'Software Engineer',
              controller: occupationController,
            ),
            CustomInputField(
              labelText: 'What is Your Phone Number?',
              hintText: 'XXXX-XXXX-XXXX',
              controller: phoneNumberController,
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
                    Navigator.pushNamed(context, '/onboarding');
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: tertiaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16)),
                  child: Text(
                    'Done',
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
              height: 32,
            ),
            profilePictureField(),
            const SizedBox(
              height: 16,
            ),
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
