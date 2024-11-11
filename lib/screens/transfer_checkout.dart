import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/custom_editing_controller.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class TransferCheckoutScreen extends StatefulWidget {
  const TransferCheckoutScreen({super.key});

  @override
  State<TransferCheckoutScreen> createState() => _TransferCheckoutScreenState();
}

class _TransferCheckoutScreenState extends State<TransferCheckoutScreen> {
  final amountController = IntegerTextEditingController();
  final noteController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  bool isError = false;

  List<String> category = [
    'payment',
    'salary',
    'investment',
    'business',
    'self-development',
    'enjoyments',
    'grocery',
    'electricity',
    'others',
  ];

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> transfer(String receiverAccountNumber) async {
    UserProvider userProvider = Provider.of(context);
    TransactionProvider transactionProvider = Provider.of(context);
    try {
      Map<String, dynamic>? receiverUser =
          await userProvider.fetchUserDataByPhoneNumber(receiverAccountNumber);
      if (receiverUser != null) {
        transactionProvider.addTransaction(
            'Transfer to ${receiverUser['name']}',
            DateTime.now(),
            amountController.integerValue!,
            selectedValue!,
            'Completed',
            {
              'type': 'Tofu Wallet',
              'accountNumber': userProvider.user['phoneNumber']
            },
            {'accountNumber': receiverAccountNumber},
            true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to transfer: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final Map<String, dynamic>? receiver = args['user'];

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
              'Transfer to ${receiver?['name']}',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget header() {
      return Consumer<UserProvider>(builder: (context, provider, child) {
        return Skeletonizer(
          enabled: provider.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From',
                style: subtitleTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              AccountCard(
                accountName: 'Tofu',
                balance: provider.isLoading
                    ? 5000
                    : provider.user['wallet']['balance'],
                isSource: true,
              ),
              const SizedBox(height: 16),
              Text(
                'Transfer to',
                style: subtitleTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              AccountCard(
                accountName: '${receiver?['name']}',
                accountNumber: '${receiver?['phoneNumber']}',
                isSource: false,
              ),
            ],
          ),
        );
      });
    }

    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              labelText: 'Insert an amount',
              hintText: '0',
              controller: amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty || amountController.integerValue! < 5) {
                  return 'Transfer amount cannot be less than \$5';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Select a category',
              style: primaryTextStyle.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 8,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Expanded(
                      child: Text('Select Category',
                          style: secondaryTextStyle.copyWith(fontSize: 14)),
                    ),
                  ],
                ),
                items: category
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              item,
                              style: secondaryTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semibold,
                              ),
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
              labelText: 'Additional Note for ${receiver?['name']}',
              hintText: 'My part for dinner last week',
              controller: noteController,
            ),
            const SizedBox(height: 32),
            CustomFilledButton(
                buttonText: 'Transfer',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    transfer(receiver?['accountNumber']);
                  }
                }),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      backgroundColor: const Color(0xFF222222),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                inputFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String accountName;
  final int? balance;
  final String? accountNumber;
  final bool isSource;

  const AccountCard({
    super.key,
    required this.accountName,
    this.balance,
    this.accountNumber,
    required this.isSource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF323232),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isSource ? 'Your Balance' : accountName,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    )),
                const SizedBox(height: 8),
                Text(
                    isSource
                        ? '\$${balance?.toStringAsFixed(2)}'
                        : accountNumber ?? '',
                    style: isSource
                        ? primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold)
                        : subtitleTextStyle.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
