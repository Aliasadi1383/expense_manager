import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionFilterChips extends StatelessWidget {
  final String label;
  final ValueChanged onSelected;
  final TransactionType? selectedFilterchips;
  final TransactionType? selectedFilter;
  const TransactionFilterChips({
    super.key,
    required this.label,
    required this.onSelected,
    required this.selectedFilterchips,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool isSelected = selectedFilter == selectedFilterchips;
    final Color selectedColor;

    switch (selectedFilterchips) {
      case TransactionType.expense:
        selectedColor = theme.error;
      case TransactionType.income:
        selectedColor = AppColors.success;
      default:
        selectedColor = theme.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
      child: ChoiceChip(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        onSelected: onSelected,
        label: Row(
          children: [
            if (selectedFilterchips != null)
              Icon(
                selectedFilterchips == TransactionType.expense
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: isSelected ? theme.surface : null,
              ),

            Text(label),
          ],
        ),
        selected: isSelected,
        showCheckmark: false,

        backgroundColor: theme.surface,
        selectedColor: selectedColor,
        labelStyle: textTheme.labelMedium!.copyWith(
          fontSize: 14,
          color: isSelected ? theme.surface : null,
        ),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
