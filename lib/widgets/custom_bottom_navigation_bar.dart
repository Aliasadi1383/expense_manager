import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChangeItem;
  final VoidCallback onAddTransaction;
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onChangeItem,
    required this.onAddTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      color: AppColors.surfaceLight,

      height: 64,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigationItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isSelected: selectedIndex == 0,
            onTap: () => onChangeItem(0),
          ),
          NavigationItem(
            icon: Icons.receipt_long,
            label: 'History',
            isSelected: selectedIndex == 1,
            onTap: () => onChangeItem(1),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onAddTransaction,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: theme.surface),
              ),
            ),
          ),
          NavigationItem(
            icon: Icons.donut_small_outlined,
            label: 'Reports',
            isSelected: selectedIndex == 2,
            onTap: () => onChangeItem(2),
          ),
          NavigationItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            isSelected: selectedIndex == 3,
            onTap: () => onChangeItem(3),
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const NavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? AppColors.primaryLight : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? theme.primary : AppColors.mutedText,
              ),
            ),
            const SizedBox(height: 2),

            Text(
              label,
              style: isSelected
                  ? textTheme.labelMedium!.copyWith(color: theme.primary)
                  : textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
