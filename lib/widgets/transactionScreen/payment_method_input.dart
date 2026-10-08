import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentMethodInput extends StatelessWidget {
  final String? account;
  final ValueChanged<String?> onChanged;
  PaymentMethodInput({
    super.key,
    required this.account,
    required this.onChanged,
  });

  final paymentMethods = ['Cash', 'Bank Card', 'Credit Card', 'Bank Transfer'];

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
            Text('Payment Method', style: textTheme.labelMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField(
               initialValue: account,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Please enter the payment method';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: theme.error),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(width: 2, color: theme.error),
                ),
                hint: Text(
                  'Select payment method',
                  style: textTheme.labelMedium,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.borderColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColors.borderColor,
                  ),
                ),

                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.credit_card, color: theme.primary),
                ),
              ),
              items: paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(
                    method,
                    style: textTheme.labelMedium!.copyWith(fontSize: 14),
                  ),
                );
              }).toList(),

              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
