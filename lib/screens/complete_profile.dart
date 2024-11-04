import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final nameController = TextEditingController(text: '');
  DateTime? selectedDeadline;
  final occupationController = TextEditingController(text: '');
  final phoneNumberController = TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> completeProfile() async {
    UserProvider userProvider = Provider.of(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });
      await userProvider.updateUserData(
        nameController.text,
        selectedDeadline!,
        occupationController.text,
        phoneNumberController.text,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete profile: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDeadline ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDeadline) {
      setState(() {
        selectedDeadline = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    handleCompleteProfile() {
      completeProfile();
    }

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
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'When is your birth date?',
                  style: primaryTextStyle.copyWith(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context), // Trigger the date picker
                  child: AbsorbPointer(
                    // Prevent keyboard from popping up
                    child: CustomInputField(
                      labelText: '',
                      hintText: selectedDeadline != null
                          ? "${selectedDeadline!.day}-${selectedDeadline!.month}-${selectedDeadline!.year}"
                          : '01-01-2000',
                      controller: TextEditingController(
                        text: selectedDeadline != null
                            ? "${selectedDeadline!.day}-${selectedDeadline!.month}-${selectedDeadline!.year}"
                            : '',
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
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
                    handleCompleteProfile();
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
