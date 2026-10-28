import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/header.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_actions.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_info.dart';
import 'package:expense_manager/widgets/transactionDetailsScreen/transaction_details_content_header.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
 final Transaction transaction;
  const TransactionDetailsScreen({super.key,required this.transaction});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TransactionDetailsContentHeader(transaction: transaction),
            const SizedBox(height: 16),
            TransactionDetailsContentInfo(transaction: transaction),
            const SizedBox(height: 16),
            TransactionDetailsActions()
          ],),
        ),
      ),
    );
  }
}
