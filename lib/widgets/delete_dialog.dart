import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/animated_pressable.dart';
import 'package:expense_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';

Future<bool?> showDeleteDialog(BuildContext context) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Delete Dialog',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      final theme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      return Dialog(
        insetPadding: EdgeInsets.all(10),

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    shape: BoxShape.circle,
                  ),

                  child: Icon(Icons.delete, color: theme.error),
                ),
                const SizedBox(height: 16),
                Text('Delete Transaction?', style: textTheme.bodySmall),
                const SizedBox(height: 8),

                Text(
                  textAlign: TextAlign.center,
                  'Deleting this transaction will update your monthly balance and transaction history. This action cannot be undone.',
                  style: textTheme.labelMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.hintTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AnimatedPressable(
                        child: PrimaryButton(
                          backgroundColor: AppColors.borderColor,
                          textColor: AppColors.mutedText,
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          text: 'Cancel',
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: AnimatedPressable(
                        child: PrimaryButton(
                          backgroundColor: theme.error,
                          textColor: theme.onError,
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          text: 'Yes,Delete',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },

    transitionBuilder: (_, animation, _, child) {
      if (animation.status == AnimationStatus.reverse) {
        return FadeTransition(opacity: animation, child: child);
      }

      final slideAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

      return SlideTransition(position: slideAnimation, child: child);
    },

  );
}
