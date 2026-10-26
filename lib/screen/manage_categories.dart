import 'package:expense_manager/data/default_categories.dart';
import 'package:expense_manager/logics/manage_categories_logic.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/state/history_filter_state.dart';
import 'package:expense_manager/state/page_state.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/category_icon_box.dart';
import 'package:expense_manager/widgets/custom_toast.dart';
import 'package:expense_manager/widgets/interactive_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategories extends StatelessWidget {
  const ManageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<Transaction> transactions = context
        .watch<TransactionState>()
        .transactionList;

    return Scaffold(
      appBar: AppBar(title: _appBar(context, textTheme, theme)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),

              itemCount: defaultCategories.length,

              itemBuilder: (context, index) {
                final Category category = defaultCategories[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: SizedBox(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            CategoryIconBox(category: category),
                            const SizedBox(width: 10),
                            _categoryNameAndNumberTransactions(
                              category,
                              textTheme,
                              transactions,
                              index,
                            ),
                            const Spacer(),
                            _categoryAmount(
                              transactions,
                              category,
                              textTheme,
                              theme,
                              context,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _categoryAmount(
    List<Transaction> transactions,
    Category category,
    TextTheme textTheme,
    ColorScheme theme,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '-\$${ManageCategoriesLogic.totalAmountTransactionsCategory(transactions, category, TransactionType.expense).toStringAsFixed(2)}',
          style: textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: theme.error,
          ),
        ),
        const SizedBox(height: 5),
        InteractiveText(
          text: 'View Expense Transactions',
          changePage: () {
            context.read<PageState>().changePage(1);
            context.read<HistoryFilterState>().historyFilter(
              category,
              TransactionType.expense,
            );

            CustomToast.show(context,'Filtered by ${category.name}',
                  Icon(Icons.check_circle, color: AppColors.successLight),);
          },
          fontSize: 11,
        ),
        const SizedBox(height: 5),
        Text(
          '+\$${ManageCategoriesLogic.totalAmountTransactionsCategory(transactions, category, TransactionType.income).toStringAsFixed(2)}',
          style: textTheme.bodySmall!.copyWith(
            fontSize: 13,
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: 5),
        InteractiveText(
          text: 'View Income Transactions',
          changePage: () {
            context.read<PageState>().changePage(1);
            context.read<HistoryFilterState>().historyFilter(
              category,
              TransactionType.income,
            );
            CustomToast.show(context,'Filtered by ${category.name}',
                  Icon(Icons.check_circle, color: AppColors.successLight),);
          },
          fontSize: 11,
        ),
      ],
    );
  }

  Column _categoryNameAndNumberTransactions(
    Category category,
    TextTheme textTheme,
    List<Transaction> transactions,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(category.name, style: textTheme.bodySmall!.copyWith(fontSize: 13)),
        Text(
          '${ManageCategoriesLogic.totalNumberTransactionsCategory(transactions, defaultCategories[index])} transactions',
          style: textTheme.labelSmall!.copyWith(
            color: AppColors.hintTextColor.withValues(alpha: 0.8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Row _appBar(BuildContext context, TextTheme textTheme, ColorScheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppColors.surfaceLight,
          ),
          onPressed: () {
            context.read<PageState>().changePage(0);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primaryText),
        ),
        Text('Manage Categories', style: textTheme.titleMedium),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.add, color: theme.primary),
        ),
      ],
    );
  }
}
