import 'package:expense_manager/data/default_categories.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterTransactionsDialog extends StatefulWidget {
  final Category? selectedCategory;
  final TransactionType? selectedType;
  final Function(TransactionType?, Category?) onApply;
  final VoidCallback onReset;
  const FilterTransactionsDialog({
    super.key,
    required this.selectedCategory,
    required this.selectedType,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<FilterTransactionsDialog> createState() =>
      _FilterTransactionsDialogState();
}

class _FilterTransactionsDialogState extends State<FilterTransactionsDialog> {
  Category? currentCategory;
  TransactionType? currentType;

  @override
  void initState() {
    super.initState();
    currentType = widget.selectedType;
    currentCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: theme.surface,
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Filter Transactions',
                  style: textTheme.titleMedium!.copyWith(fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Text(
              'Category Filter',
              style: textTheme.labelMedium!.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 10),
            _buildCategoryDropdown(textTheme),
            const SizedBox(height: 10),
            Text(
              'Transaction Type',
              style: textTheme.labelMedium!.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildOptionButton(
                  isSelected: currentType == null,
                  label: 'All',
                  theme: theme,
                  textTheme: textTheme,
                  onTap: () {
                    setState(() {
                      currentType = null;
                    });
                  },
                ),
                _buildOptionButton(
                  isSelected: currentType == TransactionType.expense,
                  label: 'Expenses',
                  theme: theme,
                  textTheme: textTheme,
                  onTap: () {
                    setState(() {
                      currentType = TransactionType.expense;
                    });
                  },
                ),
                _buildOptionButton(
                  isSelected: currentType == TransactionType.income,
                  label: 'Income',
                  theme: theme,
                  textTheme: textTheme,
                  onTap: () {
                    setState(() {
                      currentType = TransactionType.income;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildOptionButton(
                  theme: theme,
                  textTheme: textTheme,
                  label: 'Reset',
                  onTap: () {
                    widget.onReset();
                    Navigator.pop(context);
                  },
                ),
                _buildOptionButton(
                  backgroundColor: theme.primary,
                  textColor: theme.onPrimary,
                  theme: theme,
                  textTheme: textTheme,
                  label: 'Apply Filters',
                  onTap: () {
                    widget.onApply(currentType, currentCategory);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 2),
      ),
      child: DropdownButton<Category?>(
        padding: EdgeInsets.symmetric(horizontal: 10),
        underline: const SizedBox.shrink(),
        isExpanded: true,
        borderRadius: BorderRadius.circular(12),
        menuWidth: double.infinity,
        value: currentCategory,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(
              'All Categories',
              style: textTheme.titleMedium!.copyWith(fontSize: 16),
            ),
          ),
          ...defaultCategories.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e.name,
                style: textTheme.titleMedium!.copyWith(fontSize: 16),
              ),
            );
          }),
        ],

        onChanged: (value) {
          setState(() {
            currentCategory = value;
          });
        },
      ),
    );
  }

  Widget _buildOptionButton({
    required ColorScheme theme,
    required TextTheme textTheme,
    required String label,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? textColor,
    bool isSelected = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.borderColor, width: 2),
          ),
          color: backgroundColor ?? (isSelected ? theme.primary : null),

          child: InkWell(
            borderRadius: BorderRadius.circular(10),

            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium!.copyWith(
                    fontSize: 14,
                    color: textColor ?? (isSelected ? theme.surface : null),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
