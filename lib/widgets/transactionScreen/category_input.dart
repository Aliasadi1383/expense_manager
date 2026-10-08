import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? category;

  const CategoryInput({
    super.key,
    required this.onChanged,
    required this.category,
  });

  final List<String> categories = const [
    'Food',
    'Shopping',
    'Transportation',
    'Housing & Bills',
    'Health',
    'Education',
    'Entertainment',
    'Other',
  ];

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
            Text('Category', style: textTheme.labelMedium),
            const SizedBox(height: 8),
            FormField<String>(
              initialValue: category,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorText: field.errorText,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: theme.error),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      _showCategoryDialog(
                        context,
                        theme,
                        textTheme,
                        categories,
                        field,
                      );
                    },
                    child: Ink(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            category ?? 'Selected Category',
                            style: textTheme.labelMedium!.copyWith(
                              color: AppColors.primaryText,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Change',
                            style: textTheme.labelMedium!.copyWith(
                              color: theme.primary,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: theme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(
    BuildContext context,
    ColorScheme theme,
    TextTheme textTheme,
    List<String> categories,
    FormFieldState<String> field,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: theme.surface,
          title: Row(
            children: [
              Text(
                'Select Category',
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
          content: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            runSpacing: 10,
            children: categories.map((categoryName) {
              return _buildCategoryItem(context, categoryName, textTheme,field);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String categoryName,
    TextTheme textTheme,
    FormFieldState<String> field,
  ) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 75) / 2,
      height: MediaQuery.sizeOf(context).height / 18,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          field.didChange(categoryName);
          onChanged(categoryName);
          Navigator.pop(context);
        },
        child: Ink(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.borderColor),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: textTheme.labelMedium!.copyWith(
                color: AppColors.primaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
