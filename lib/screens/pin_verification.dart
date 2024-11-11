import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';

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

  bool isError = false;

  Future<void> transaction(Map<String, dynamic> args) async {
    UserProvider userProvider = Provider.of(context, listen: false);
    ConnectedAccountsProvider connectedAccountsProvider =
        Provider.of(context, listen: false);
    TransactionProvider transactionProvider =
        Provider.of(context, listen: false);
    try {
      bool isPinCorrect = await userProvider.verifyPin(pinController.text);
      if (isPinCorrect) {
        final String? transactionType = args['transactionType'];
        if (transactionType == 'Top Up') {
          final int? transactionAmount = args['transactionAmount'];
          Map<String, dynamic>? connectedAccount = args['connectedAccount'];
          try {
            await userProvider.updateWalletBalance(
                'currentUser', transactionAmount!);
            await connectedAccountsProvider.updateConnectedAccountBalance(
              connectedAccount?['accountNumber'],
              -transactionAmount,
            );
            await transactionProvider.addTransaction(
              transactionType!,
              DateTime.now(),
              transactionAmount,
              transactionType,
              'Completed',
              {
                'type': connectedAccount!['name'],
                'accountNumber': connectedAccount['accountNumber'],
              },
              {
                'type': 'Tofu Wallet',
                'accountNumber': userProvider.user['phoneNumber'],
              },
              false,
            );
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/transaction-success',
                (_) => false,
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to top up: ${e.toString()}')),
              );
            }
          }
        } else if (transactionType == 'transfer') {
          final Map<String, dynamic>? sender = args['sender'];
          final Map<String, dynamic>? receiver = args['receiver'];

          if (sender != null && receiver != null) {
            DateTime now = DateTime.now();
            try {
              await transactionProvider.addTransaction(
                  sender['title'],
                  now,
                  sender['amount'],
                  sender['category'],
                  sender['status'],
                  sender['method'],
                  sender['receiver'],
                  sender['isOutcome']);
              await userProvider.updateWalletBalance(
                  'currentUser', -sender['amount']);
              await transactionProvider.addTransactionToOtherUser(
                  receiver['id'],
                  receiver['title'],
                  now,
                  receiver['amount'],
                  receiver['category'],
                  receiver['status'],
                  receiver['method'],
                  receiver['sender']);
              await userProvider.updateWalletBalance(
                  receiver['id'], receiver['amount']);
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/transaction-success',
                  (_) => false,
                );
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Failed to transfer: ${e.toString()}')),
                );
              }
            }
          }
        }
      } else {
        setState(() {
          pinController.clear();
          isError = true;
        });
      }
    } catch (e) {
      // Handle any errors (e.g., connection issues)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error verifying PIN: ${e.toString()}'),
          backgroundColor: errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    handleVerifyPin() {
      transaction(args);
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
        border: Border.all(color: isError ? errorColor : borderColor),
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
            style: subtitleTextStyle.copyWith(fontSize: 14),
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
                onCompleted: (pin) {
                  if (formKey.currentState!.validate()) {
                    handleVerifyPin();
                  }
                },
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
                  border: Border.all(color: errorColor),
                ),
                errorTextStyle: errorTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ]),
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                header(),
                pinInputField(),
                isError
                    ? Text(
                        'Incorrect PIN number. Please try again',
                        style: errorTextStyle.copyWith(fontSize: 12),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
