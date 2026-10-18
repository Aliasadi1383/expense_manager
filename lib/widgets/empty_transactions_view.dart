import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class EmptyTransactionsView extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onAddTransaction;
  final VoidCallback? onClearFilters;
  final bool showClearFiltersButton;
  const EmptyTransactionsView({super.key,
  required this.title,
  required this.description,
  required this.onAddTransaction,
  this.onClearFilters,
  this.showClearFiltersButton=false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt,
                size: 40,
                color: AppColors.hintTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(title, style: textTheme.bodySmall),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              description,
              style: textTheme.labelSmall!.copyWith(
                fontSize: 13,
                color: AppColors.hintTextColor,
              ),
            ),
            const SizedBox(height: 10),
            showClearFiltersButton?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.surfaceLight,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: onClearFilters,
                  child: Text(
                    'Clear Filters',
                    style: textTheme.labelMedium!.copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: theme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: onAddTransaction,
                  child: Text(
                    'Add New',
                    style: textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                      color: theme.onPrimary,
                    ),
                  ),
                ),
              ],
            ):PrimaryButton(onPressed: onAddTransaction, icon: Icons.add_circle_outline, text: 'Add New'),
          ],
        ),
      ),
    );
  }
}
