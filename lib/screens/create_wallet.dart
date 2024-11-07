import 'package:flutter/material.dart';
import 'package:tofu/theme.dart'; // Replace with your theme package if necessary.
import 'package:tofu/widgets/custom_filled_button.dart'; // Replace with your custom button if necessary.

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  final TextEditingController walletNameController = TextEditingController();
  final TextEditingController initialDepositController =
      TextEditingController();

  @override
  void dispose() {
    walletNameController.dispose();
    initialDepositController.dispose();
    super.dispose();
  }

  Widget buildHeader() {
    return Column(
      children: [
        Text(
          'Create Your Wallet',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Set up your wallet with an initial name and amount.',
          style: subtitleTextStyle.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String hintText = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return CustomFilledButton(
      buttonText: 'Create Wallet',
      onPressed: () {
        // Handle wallet creation logic here.
        final walletName = walletNameController.text;
        final initialDeposit = initialDepositController.text;

        if (walletName.isNotEmpty && initialDeposit.isNotEmpty) {
          Navigator.pushNamed(context, '/wallet-home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all fields.')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Wallet'),
        backgroundColor: backgroundPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              const SizedBox(height: 24),
              buildInputField(
                label: 'Wallet Name',
                controller: walletNameController,
                hintText: 'e.g., My Savings Wallet',
              ),
              buildInputField(
                label: 'Initial Deposit',
                controller: initialDepositController,
                keyboardType: TextInputType.number,
                hintText: 'e.g., 1000',
              ),
              const SizedBox(height: 24),
              buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
