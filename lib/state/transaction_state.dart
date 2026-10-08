
import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionState extends ChangeNotifier{
    final List<Transaction> transactionList = [];

    void addTransaction(Transaction transaction){
      transactionList.add(transaction);
      notifyListeners();
    }
}