import 'package:expense_manager/logics/home_logic.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/state/history_filter_state.dart';
import 'package:expense_manager/state/page_state.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/animated_pressable.dart';
import 'package:expense_manager/widgets/category_icon_box.dart';
import 'package:expense_manager/widgets/custom_toast.dart';
import 'package:expense_manager/widgets/interactive_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<Transaction> transactions = context
        .watch<TransactionState>()
        .transactionList;

    return Column(
      children: [
        Row(
          children: [
            Text('Top Categories', style: textTheme.bodySmall),
            const Spacer(),
            InteractiveText(
              text: 'Manage All',
              changePage: () {
                context.read<PageState>().changePage(4);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: HomeLogic.groupTransactions(transactions).length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.3,
          ),
          itemBuilder: (context, index) {
            final groupedTransactions = HomeLogic.groupTransactions(
              transactions,
            )[index];
            return AnimatedPressable(
              onTap: () {
                context.read<PageState>().changePage(1);
                context.read<HistoryFilterState>().historyFilter(
                  groupedTransactions.category,
                  groupedTransactions.type,
                );

                CustomToast.show(
                  context,
                  'Filtered by ${groupedTransactions.category.name}',
                  Icon(Icons.check_circle, color: AppColors.successLight),
                );

                
              },
              child: Card(
                color: theme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CategoryIconBox(category: groupedTransactions.category),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              groupedTransactions.category.name,
                              style: textTheme.bodySmall!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                    GoogleFonts.hankenGrotesk().fontFamily,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${groupedTransactions.type == TransactionType.expense ? '-' : '+'}\$${groupedTransactions.amount.toStringAsFixed(2)}',
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall!.copyWith(
                                fontSize: 16,
                                color:
                                    groupedTransactions.type ==
                                        TransactionType.expense
                                    ? theme.error
                                    : AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
