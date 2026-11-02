import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/widgets/delete_dialog.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/header.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_actions.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_info.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String transactionId;

  const TransactionDetailsScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final transactions = context.watch<TransactionState>().transactionList;

   final Transaction? transaction = transactions
        .where((item) => item.id == transactionId)
        .firstOrNull;

    if (transaction == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: Header(
        onBack: () {
          Navigator.pop(context);
        },
        onEdit: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTransactionScreen(transaction: transaction),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TransactionDetailsContentHeader(transaction: transaction),
              const SizedBox(height: 16),
              TransactionDetailsContentInfo(transaction: transaction),
              const SizedBox(height: 16),
              TransactionDetailsActions(
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddTransactionScreen(transaction: transaction),
                    ),
                  );
                },
                onDelete: () async {
                  final confirmed = await showDeleteDialog(context);

                  if (!context.mounted) return;

                  if (confirmed == true) {
                    Navigator.pop(context);
                    context.read<TransactionState>().deleteTransaction(
                      transaction.id,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
