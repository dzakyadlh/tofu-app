import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  bool isPermitted = false;

  @override
  void dispose() {
    nameController.dispose();
    occupationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final photoPermission = await Permission.photos.request();

    if (cameraPermission.isGranted && photoPermission.isGranted) {
      _pickImage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied. Unable to pick image.')),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.uploadProfilePicture(_imageFile!);
    }
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
          GestureDetector(
            onTap: _requestPermissions, // Open the gallery when tapped
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(50)),
              alignment: Alignment.center,
              child: _imageFile == null
                  ? const Icon(
                      Icons.person_add_alt_1,
                      size: 80,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _imageFile!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
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
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      handleCompleteProfile();
                    }
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
