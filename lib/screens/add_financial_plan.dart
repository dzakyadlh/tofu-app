import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class AddFinancialPlanScreen extends StatefulWidget {
  const AddFinancialPlanScreen({super.key});

  @override
  State<AddFinancialPlanScreen> createState() => _AddFinancialPlanScreenState();
}

class _AddFinancialPlanScreenState extends State<AddFinancialPlanScreen> {
  final titleController = TextEditingController(text: '');
  final targetController = TextEditingController(text: '');
  final deadlineController = TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              'Add Financial Plan',
              style: secondaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            )),
      );
    }

    Widget inputFields() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Give this plan a title',
              style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'It is recommended to give title as of the reason why you started this plan.',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomInputField(
              labelText: '',
              hintText: 'New House',
              controller: titleController,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Tell us your balance target',
              style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Insert how much money you want to grow within this plan. No need to be realistic. Nothing is impossible if you put up the work needed!',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomInputField(
              labelText: '',
              hintText: 'New House',
              controller: titleController,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Decide the deadline',
              style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Tell us when do you think is ideal to reach this goal! Just tell us the date and we will do the rest for you!',
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomInputField(
              labelText: '',
              hintText: 'New House',
              controller: titleController,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            inputFields(),
            const SizedBox(
              height: 32,
            ),
            CustomFilledButton(
              buttonText: 'Submit Plan',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (_) => false,
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
