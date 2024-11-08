import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
    UserProvider userProvider = Provider.of(context);

    handleVerifyPin() async {
      try {
        bool isPinCorrect = await userProvider.verifyPin(pinController.text);
        if (isPinCorrect) {
          // PIN is correct, navigate to success page
          Navigator.pushNamedAndRemoveUntil(
              context, '/transaction-success', (_) => false);
        } else {
          // Show an error if the PIN is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect PIN. Please try again.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        // Handle any errors (e.g., connection issues)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error verifying PIN: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }

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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: subtitleTextColor,
                )),
            title: Text(
              'Verification',
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
            'Insert your PIN',
            style: secondaryTextStyle.copyWith(
              fontSize: 20,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Help us identify you to secure your payment',
            style: secondaryTextStyle.copyWith(fontSize: 14),
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
                  return value?.length == 6
                      ? null
                      : 'Pin needs to be 6 numbers long';
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
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
              handleVerifyPin();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/transaction-success', (_) => false);
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
