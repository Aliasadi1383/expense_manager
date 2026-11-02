import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/animated_pressable.dart';
import 'package:expense_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class TransactionDetailsActions extends StatelessWidget {
   final VoidCallback onDelete;
   final VoidCallback onEdit;
  const TransactionDetailsActions({super.key,required this.onDelete,required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        AnimatedPressable(
          child: PrimaryButton(
            onPressed: onEdit,
            icon: Icons.edit_square,
            text: 'Edit Transaction',
          ),
        ),

        const SizedBox(height: 15),

        AnimatedPressable(
          child: PrimaryButton(
            backgroundColor: AppColors.errorLight,
            textColor: theme.error,
            foregroundColor: theme.error,
            onPressed: onDelete,
            icon: Icons.delete,
            text: 'Delete Transaction',
          ),
        ),
      ],
    );
  }
}
