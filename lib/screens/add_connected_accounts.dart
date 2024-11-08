import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/connected_accounts_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class AddConnectedAccountsScreen extends StatefulWidget {
  const AddConnectedAccountsScreen({super.key});

  @override
  State<AddConnectedAccountsScreen> createState() =>
      _AddConnectedAccountsScreenState();
}

class _AddConnectedAccountsScreenState
    extends State<AddConnectedAccountsScreen> {
  final List<Map<String, String>> accountTypes = [
    {
      'name': 'VISA',
      'icon': 'assets/images/visa.png',
    },
    {
      'name': 'Paypal',
      'icon': 'assets/images/paypal.png',
    },
    {
      'name': 'AmazonPay',
      'icon': 'assets/images/amazon.png',
    },
    {
      'name': 'Mandiri',
      'icon': 'assets/images/mandiri.png',
    },
    {
      'name': 'BCA',
      'icon': 'assets/images/bca.png',
    },
  ];

  final accountNumberController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    ConnectedAccountsProvider connectedAccountsProvider = Provider.of(context);

    handleConnectAccount() async {
      if (_formKey.currentState!.validate() && selectedValue != null) {
        // Only proceed if the form is valid and an account is selected
        Map<String, dynamic> accountData = {
          'name': selectedValue,
          'icon': accountTypes.firstWhere(
              (account) => account['name'] == selectedValue)['icon'],
          'accountNumber': accountNumberController.text,
          'balance': 1000000, // Example balance
        };

        await connectedAccountsProvider.addConnectedAccount(accountData);
        Navigator.pop(context);
      } else if (selectedValue == null) {
        setState(() {
          isError = true;
        });
      }
    }

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
              'Add Account Connection',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget accountInput() {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select an account',
              style: primaryTextStyle.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 4,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Expanded(
                      child: Text('Select Account Type',
                          style: secondaryTextStyle.copyWith(fontSize: 14)),
                    ),
                  ],
                ),
                items: accountTypes
                    .map((item) => DropdownMenuItem<String>(
                          value: item['name'],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  item['icon']!,
                                  width: 50,
                                  height: 30,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  item['name']!,
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semibold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    border: Border.all(
                      color: isError ? errorColor : Colors.white30,
                      width: 1,
                    ),
                    color: backgroundPrimaryColor,
                  ),
                  elevation: 4,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 24,
                    color: primaryColor,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    color: backgroundPrimaryColor,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                    thumbColor: WidgetStateProperty.all(primaryColor),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            isError
                ? Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Please select an account type',
                      style: errorTextStyle.copyWith(fontSize: 12),
                    ),
                  )
                : SizedBox(),
            CustomInputField(
              labelText: 'Insert your account number',
              hintText: 'Account Number',
              controller: accountNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an account number';
                } else if (value.length < 6) {
                  return 'Please enter a valid account number';
                }
                return null;
              },
            )
          ],
        ),
      );
    }

    Widget submitButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: CustomFilledButton(
            buttonText: 'Connect Account',
            onPressed: () {
              handleConnectAccount();
            }),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            accountInput(),
            submitButton(),
          ],
        ),
      ),
    );
  }
}
