import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onPressed;
  final TextEditingController controller;
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    required this.onPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        fillColor: theme.surface,
        filled: true,
        prefixIcon: Icon(Icons.search, color: AppColors.mutedText),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(onPressed: onPressed, icon: Icon(Icons.close))
            : null,

        hintText: 'Search merchant, category, notes...',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 1),
        ),
      ),
    );
  }
}
