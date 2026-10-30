import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/header.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_actions.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_info.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatelessWidget {
 final String transactionId;
  const TransactionDetailsScreen({super.key,required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final transactions =
    context.watch<TransactionState>().transactionList;

    final transaction=transactions.firstWhere(
      (item) => item.id==transactionId,
    );

    return Scaffold(
      appBar: Header(transaction: transaction,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TransactionDetailsContentHeader(transaction: transaction),
            const SizedBox(height: 16),
            TransactionDetailsContentInfo(transaction: transaction),
            const SizedBox(height: 16),
            TransactionDetailsActions(transaction: transaction,)
          ],),
        ),
      ),
    );
  }
}
