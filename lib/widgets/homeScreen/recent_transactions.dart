import 'package:expense_manager/logics/home_logic.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/state/page_state.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/widgets/empty_transactions_view.dart';
import 'package:expense_manager/widgets/homeScreen/interactive_text.dart';
import 'package:expense_manager/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final List<Transaction> transactions = context
        .watch<TransactionState>()
        .transactionList;
    final recentTransactions =
    HomeLogic.getRecentWeekTransactions(transactions);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('Recent Transactions', style: textTheme.bodySmall),
            const Spacer(),
            InteractiveText(
              text: 'View All (${transactions.length})',
              changePage: () {
                context.read<PageState>().changePage(1);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (recentTransactions.isNotEmpty)
          TransactionListItem(transactionList: recentTransactions)
        else
          EmptyTransactionsView(
            title: 'There are no recent transactions',
            description:
                'You have not recorded any transactions in the past few days, view your previous transactions in the history section.\n To add a transaction, click the button below.',
            onAddTransaction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransactionScreen()),
              );
            },
          ),
      ],
    );
  }
}
