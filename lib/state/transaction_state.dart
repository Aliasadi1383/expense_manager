import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionState extends ChangeNotifier {
  final List<Transaction> transactionList = [];

  void addTransaction(Transaction transaction) {
    transactionList.add(transaction);
    notifyListeners();
  }

  void editTransaction(Transaction updatedTransaction) {
    final index = transactionList.indexWhere(
      (transaction) => transaction.id == updatedTransaction.id,
    );

    if (index == -1) return;

    transactionList[index] = updatedTransaction;
    notifyListeners();
  }

  void deleteTransaction(String transactionId){
    transactionList.removeWhere((transaction) =>transaction.id==transactionId);
    notifyListeners();
  }
}
