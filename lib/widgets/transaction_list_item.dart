import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/screen/transaction_details_screen.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/animated_pressable.dart';
import 'package:expense_manager/widgets/category_icon_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionListItem({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: theme.surface,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: AppColors.hintTextColor,
            thickness: 0.3,
            indent: 20,
            endIndent: 20,
          );
        },
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          final transaction = transactionList;

          return AnimatedPressable(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TransactionDetailsScreen(transactionId: transaction[index].id,),
                ),
              );

            },
            child: Container(
              color: theme.surface,
              padding: const EdgeInsets.all(12),
              height: 70,
              child: Row(
                children: [
                  CategoryIconBox(category: transaction[index].category),
                  const SizedBox(width: 10),
                  _buildTransactionDetails(transaction, index, textTheme),
                  const SizedBox(width: 10),
                  _buildTransactionAmountAndAccount(
                    transaction,
                    index,
                    textTheme,
                    theme,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionDetails(
    List<Transaction> transaction,
    int index,
    TextTheme textTheme,
  ) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction[index].title,
            style: textTheme.bodySmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${DateFormat('y-M-d').format(transaction[index].dateTime)} • ${transaction[index].category.name}',
            style: textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionAmountAndAccount(
    List<Transaction> transaction,
    int index,
    TextTheme textTheme,
    ColorScheme theme,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            transaction[index].type == TransactionType.expense
                ? '-\$${transaction[index].amount.toStringAsFixed(2)}'
                : '+\$${transaction[index].amount.toStringAsFixed(2)}',
            style: textTheme.bodySmall!.copyWith(
              color: transaction[index].type == TransactionType.expense
                  ? theme.error
                  : AppColors.success,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(transaction[index].account, style: textTheme.labelSmall),
        ],
      ),
    );
  }
}
