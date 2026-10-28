import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionDetailsContentInfo extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailsContentInfo({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _transactionInfoRow(
                  'Category',
                  textTheme,
                  Row(
                    children: [
                      Icon(transaction.category.icon, color: theme.primary),
                      const SizedBox(width: 5),
                      Text(
                        transaction.category.name,
                        style: textTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _transactionInfoRow(
                  'Date & Time',
                  textTheme,
                  Text(
                    DateFormat(
                      'MMM d, yyyy • hh:mm a',
                    ).format(transaction.dateTime),
                    style: textTheme.bodySmall!.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
    
                _transactionInfoRow(
                  'Payment Method',
                  textTheme,
                  Text(
                    transaction.account,
                    style: textTheme.bodySmall!.copyWith(fontSize: 16),
                  ),
                ),
    
                const SizedBox(height: 8),
    
                Row(
                  children: [
                    Text(
                      'Transaction ID',
                      style: textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        color: AppColors.hintTextColor,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: transaction.id),
                          );
                          CustomToast.show(
                            context,
                            'Transaction ID copied to clipboard',
                            Icon(
                              Icons.check_circle_sharp,
                              color: AppColors.successLight,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                transaction.id,
                                style: textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  color: theme.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.copy_rounded, color: theme.primary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description & Notes',
                    style: textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      color: AppColors.hintTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    transaction.notes!.trim().isEmpty
                        ? 'No description added'
                        : transaction.notes!,
                    style: textTheme.bodySmall!.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _transactionInfoRow(String label, TextTheme textTheme, Widget value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                fontSize: 16,
                color: AppColors.hintTextColor,
              ),
            ),
            value,
          ],
        ),
        const SizedBox(height: 8),
        Divider(thickness: 2, color: AppColors.primaryLight),
      ],
    );
  }
}
