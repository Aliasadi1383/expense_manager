import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/animated_pressable.dart';
import 'package:expense_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class TransactionDetailsActions extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailsActions({super.key,required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        AnimatedPressable(
          child: PrimaryButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransactionScreen(transaction: transaction,)));
            },
            icon: Icons.edit_square,
            text: 'Edit Transaction',
          ),
        ),

        const SizedBox(height: 15),
        
        AnimatedPressable(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.transparent,
              backgroundColor: AppColors.errorLight,
              minimumSize: Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.delete, color: theme.error),
            label: Text(
              'Delete Transaction',
              style: textTheme.labelMedium!.copyWith(
                fontSize: 14,
                color: theme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
