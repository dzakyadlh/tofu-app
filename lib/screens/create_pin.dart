import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  int submitNumber = 0;
  String savedPin = '';
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = tertiaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 45,
      height: 60,
      textStyle: primaryTextStyle.copyWith(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    PreferredSizeWidget topBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
            backgroundColor: backgroundPrimaryColor,
            elevation: 0,
            title: Text(
              'Create PIN',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget header() {
      return Column(
        children: [
          Text(
            submitNumber == 0 ? 'Insert your PIN' : 'Confirm your PIN',
            style: secondaryTextStyle.copyWith(
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Create a pin number to help us identify you and secure your payment',
            style: subtitleTextStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget pinInputField() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Form(
          key: formKey,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Pinput(
                length: 6,
                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                validator: (value) {
                  if (value == null || value.length != 6) {
                    return 'Pin needs to be 6 numbers long';
                  }
                  if (submitNumber == 1 && value != savedPin) {
                    return 'Pin is not the same. Please try again';
                  }
                  return null;
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      if (submitNumber == 0) {
                        savedPin = pin;
                        submitNumber = 1;
                        pinController.clear();
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/create-wallet', (_) => false);
                      }
                    });
                  }
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
                errorTextStyle: alertTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ]),
        ),
      );
    }

    Widget submitButton() {
      return CustomFilledButton(
          buttonText: 'Continue',
          onPressed: () {
            focusNode.unfocus();
            if (formKey.currentState!.validate()) {
              setState(() {
                submitNumber += 1;
              });
              if (submitNumber > 1) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/create-wallet', (_) => false);
              }
            }
          });
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header(),
            pinInputField(),
            submitButton(),
          ],
        ),
      )),
    );
  }
}
