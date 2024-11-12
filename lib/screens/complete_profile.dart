import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
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

  @override
  void dispose() {
    nameController.dispose();
    occupationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to complete profile: ${e.toString()}')),
        );
      }
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

    PreferredSizeWidget topBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            backgroundColor: backgroundPrimaryColor,
            elevation: 0,
            title: Text(
              'Complete Profile',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget header() {
      return Text(
        'Help us to know more about you!',
        style: secondaryTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            CustomInputField(
              labelText: 'What is Your Occupation? *',
              hintText: 'Software Engineer',
              controller: occupationController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            CustomInputField(
              labelText: 'What is Your Phone Number?',
              hintText: 'XXXX-XXXX-XXXX',
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    Widget buttons() {
      return Column(
        children: [
          CustomFilledButton(
              buttonText: 'Done',
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  handleCompleteProfile();
                }
              })
        ],
      );
    }

    return Scaffold(
      appBar: topBar(),
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header(),
            const SizedBox(
              height: 32,
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
