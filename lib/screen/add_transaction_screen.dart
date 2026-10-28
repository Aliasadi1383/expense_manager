import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/transactionScreen/amount_input.dart';
import 'package:expense_manager/widgets/transactionScreen/category_input.dart';
import 'package:expense_manager/widgets/transactionScreen/date_time_input.dart';
import 'package:expense_manager/widgets/transactionScreen/notes_input.dart';
import 'package:expense_manager/widgets/transactionScreen/payment_method_input.dart';
import 'package:expense_manager/widgets/transactionScreen/title_input.dart';
import 'package:expense_manager/widgets/transactionScreen/transaction_type_selector.dart';
import 'package:expense_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType selectedType = TransactionType.expense;
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  Category? category;
  DateTime? dateTime;
  String? account;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    amountController.dispose();
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          style: IconButton.styleFrom(backgroundColor: AppColors.surfaceLight),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: AppColors.primaryText),
        ),
        title: Text(
          'Add Transaction',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TransactionTypeSelector(
                  selectedType: selectedType,
                  onChanged: (value) {
                    if (selectedType != value) {
                      setState(() {
                        selectedType = value;
                        amountController.clear();
                        titleController.clear();
                        notesController.clear();
                        category = null;
                        dateTime = null;
                        account = null;
                        _formKey = GlobalKey<FormState>();
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                AmountInput(
                  selectedType: selectedType,
                  controller: amountController,
                ),
                const SizedBox(height: 8),
                TitleInput(controller: titleController),
                const SizedBox(height: 16),
                CategoryInput(
                  category: category,
                  onChanged: (value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DateTimeInput(
                  dateTime: dateTime,
                  onChanged: (value) {
                    setState(() {
                      dateTime = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                PaymentMethodInput(
                  account: account,
                  onChanged: (value) {
                    setState(() {
                      account = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                NotesInput(controller: notesController),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    context.read<TransactionState>().addTransaction(
                      Transaction(
                        type: selectedType,
                        amount: double.parse(amountController.text),
                        title: titleController.text,
                        category: category!,
                        dateTime: dateTime!,
                        account: account!,
                        notes: notesController.text,
                      ),
                    );

                    Navigator.pop(context,true);
                  },

                  icon: Icons.check_circle_outline,
                  text: 'Save Transaction',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
