import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectedFilterCategory extends StatelessWidget {
  final String categoryName;
  final VoidCallback onRemove;
  const SelectedFilterCategory({super.key,required this.categoryName,required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            categoryName,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14,
              color: theme.primary,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, color: theme.primary),
          ),
        ],
      ),
    );
  }
}
