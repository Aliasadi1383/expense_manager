import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/category_icon_box.dart';
import 'package:flutter/material.dart';

class TransactionDetailsContentHeader extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailsContentHeader({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bool isExpense = transaction.type == TransactionType.expense;

    final Color transactionTypeColor = isExpense
        ? theme.error
        : AppColors.success;

    return Column(
      children: [
        Center(
          child: CategoryIconBox(
            category: transaction.category,
            width: 70,
            height: 70,
            iconSize: 34,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          transaction.title,
          style: textTheme.titleMedium!.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          decoration: BoxDecoration(
            color: isExpense
                ?  AppColors.errorLight
                : AppColors.successLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isExpense
                      ? transactionTypeColor.withValues(alpha: 0.75)
                      : transactionTypeColor.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),

              Text(
                transaction.type.name[0].toUpperCase() +
                    transaction.type.name.substring(1),
                style: textTheme.labelMedium!.copyWith(
                  fontSize: 15,
                  color: transactionTypeColor,
                ),
              ),

              const SizedBox(width: 5),

              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: transactionTypeColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),

              Text(
                'Settled',
                style: textTheme.labelMedium!.copyWith(
                  fontSize: 15,
                  color: transactionTypeColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${isExpense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
          style: textTheme.titleLarge!.copyWith(
            color: transactionTypeColor,
            fontSize: 44,
          ),
        ),
      ],
    );
  }
}
