import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  final TextEditingController controller;
  const TitleInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: textTheme.labelMedium!.copyWith(
                fontSize: 16,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w100,
              ),
              controller: controller,
              decoration: InputDecoration(
               
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.error, width: 2),
                ),

                fillColor: AppColors.surfaceLight,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.primary, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.error, width: 2),
                ),
                prefixIcon: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.primaryText,
                ),
                hintText: 'e.g., Grocery shopping, Starbucks, Salary',
                hintStyle: textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              maxLength: 30,
            ),
          ],
        ),
      ),
    );
  }
}
