import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/providers/user_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/account_card.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';
import 'package:tofu/widgets/custom_outlined_button.dart';

class FundTransferScreen extends StatefulWidget {
  const FundTransferScreen({super.key});

  @override
  State<FundTransferScreen> createState() => _FundTransferScreenState();
}

class _FundTransferScreenState extends State<FundTransferScreen> {
  final targetAccountController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? user;
  List<String> accountHistory = [];

  @override
  void dispose() {
    targetAccountController.dispose();
    super.dispose();
  }

  Future<void> searchUser(String phoneNumber) async {
    UserProvider userProvider = Provider.of(context, listen: false);
    try {
      user = await userProvider.fetchUserDataByPhoneNumber(phoneNumber);
      if (user != null) {
        Navigator.pushNamed(context, '/transfer-checkout',
            arguments: {'user': user});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User not found',
              style: alertTextStyle,
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to search for user: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    handleSearch(value) {
      searchUser(value);
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
              'Transfer',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget topMenu() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Scan a QR',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Bank Transfer',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: tertiaryColor),
                  color: backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Multipayment',
                      style: primaryTextStyle.copyWith(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget accountInput() {
      return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              CustomInputField(
                labelText: '',
                hintText: 'Type an account number',
                controller: targetAccountController,
                padding: EdgeInsets.zero,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Type an account number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomOutlinedButton(
                  buttonText: 'Transfer to this user',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      searchUser(targetAccountController.text);
                    }
                  }),
            ],
          ),
        ),
      );
    }

    Widget accountHistoryList() {
      return Expanded(
        child: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            if (provider.transactions.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      'You haven\'t done any transactions',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semibold,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Tofu wallet can be used to transfer to other accounts and do payments',
                      style: subtitleTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              );
            }

            if (provider.isLoading) {
              return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return AccountCard(
                      accountNumber: 'sample text',
                      onPressed: () {},
                    );
                  },
                ),
              );
            }

            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (item, index) {
                if (!accountHistory.contains(provider.transactions[index]
                    ['receiver']['accountNumber'])) {
                  String accountNumber =
                      provider.transactions[index]['receiver']['accountNumber'];
                  accountHistory.add(accountNumber);
                  return AccountCard(
                      accountNumber: accountNumber,
                      onPressed: () {
                        handleSearch(accountNumber);
                      });
                }
                return null;
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            topMenu(),
            accountInput(),
            accountHistoryList(),
          ],
        ),
      ),
    );
  }
}
