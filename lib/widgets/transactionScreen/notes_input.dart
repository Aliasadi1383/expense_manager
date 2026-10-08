import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotesInput extends StatelessWidget {
 final TextEditingController controller;
  const NotesInput({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes (Optional)',style: textTheme.labelMedium,),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
               
                hint: Text('Add optional notes and details.',
                style: textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
                ),
                fillColor: AppColors.surfaceLight,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 2, color: theme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
