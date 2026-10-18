import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatelessWidget {
  final DateTime? dateTime;
  final ValueChanged<DateTime?> onChanged;
  const DateTimeInput({
    super.key,
    required this.dateTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: theme.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FormField(
          
          initialValue: dateTime,
          validator: (value) {
            if (value == null) {
              return 'Please enter the date and time';
            }
            return null;
          },
          builder: (field) {
            return InputDecorator(
              decoration: InputDecoration(
                 errorStyle: textTheme.labelMedium!.copyWith(
            color: theme.error
          ),
                errorText: field.errorText,
                border: InputBorder.none,
                errorBorder: OutlineInputBorder(
                
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                    color: theme.error,
                  ),
              
                ),
               
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date & time', style: textTheme.labelMedium),
                  const SizedBox(height: 8),

                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      final selectedDateTime = await _selectDateTime(context);

                      if (selectedDateTime != null) {
                        field.didChange(selectedDateTime);
                        onChanged(selectedDateTime);
                        field.validate();
                      }
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            dateTime == null
                                ? 'Please select the date and time.'
                                : DateFormat(
                                    'MMM d,  yyyy • hh:mm a',
                                  ).format(field.value!),
                            style: textTheme.labelMedium!.copyWith(
                              color: AppColors.primaryText,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.date_range, color: theme.primary),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: field.value != null
                          ? () {
                              field.didChange(null);
                              onChanged(null);
                              field.validate();
                            }
                          : null,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Clear date & time'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
      initialDate: now,
    );

    if (date == null) {
      return null;
    }
    if (!context.mounted) {
      return null;
    }

    final TimeOfDay? time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (time == null) {
      return null;
    }
    final selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (!context.mounted) {
      return null;
    }

    if (selectedDateTime.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('The selected time has not arrived yet.'),
        ),
      );

      return null;
    }

    return selectedDateTime;
  }
}
