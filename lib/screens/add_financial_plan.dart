import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/financial_plan_provider.dart';
import 'package:tofu/theme.dart';
import 'package:tofu/utils/custom_editing_controller.dart';
import 'package:tofu/widgets/custom_filled_button.dart';
import 'package:tofu/widgets/custom_input_field.dart';

class AddFinancialPlanScreen extends StatefulWidget {
  const AddFinancialPlanScreen({super.key});

  @override
  State<AddFinancialPlanScreen> createState() => _AddFinancialPlanScreenState();
}

class _AddFinancialPlanScreenState extends State<AddFinancialPlanScreen> {
  final titleController = TextEditingController(text: '');
  final targetController = IntegerTextEditingController();
  DateTime? selectedDeadline;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  @override
  void dispose() {
    titleController.dispose();
    targetController.dispose();
    super.dispose();
  }

  Future<void> addFinancialPlan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FinancialPlanProvider financialPlanProvider =
          Provider.of<FinancialPlanProvider>(context, listen: false);

      try {
        await financialPlanProvider.addFinancialPlan(
          titleController.text,
          targetController.integerValue!,
          selectedDeadline!,
        );
        Navigator.pop(context);
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to load financial plans: ${e.toString()}')),
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
    handleSubmit() {
      addFinancialPlan();
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
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
              hintText: '1,000,000',
              controller: targetController,
              padding: EdgeInsets.zero,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                GestureDetector(
                  onTap: () => _selectDate(context), // Trigger the date picker
                  child: AbsorbPointer(
                    // Prevent keyboard from popping up
                    child: CustomInputField(
                      labelText: '',
                      hintText: selectedDeadline != null
                          ? "${selectedDeadline!.day}-${selectedDeadline!.month}-${selectedDeadline!.year}"
                          : 'Select a date',
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
                if (_formKey.currentState!.validate()) {
                  handleSubmit();
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
