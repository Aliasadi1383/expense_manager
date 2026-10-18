import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final bool hasActiveFilters;
  const HistoryHeader({
    super.key,
    required this.onPressed,
    required this.hasActiveFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transactions',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text('History & Ledger', style: textTheme.labelSmall),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: theme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 2, color: AppColors.borderColor),
                  ),
                ),
                onPressed: onPressed,

                icon: Icon(Icons.tune),
              ),
              if (hasActiveFilters)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
