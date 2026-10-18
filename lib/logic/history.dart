import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';

class History {
  static List<Transaction> transactionSearch(
    List<Transaction> transactionList,
    String text,
  ) {
    final query = text.trim().toLowerCase();

    if (query.isEmpty) {
      return transactionList;
    }

    return transactionList
        .where((element) => element.title.toLowerCase().contains(query))
        .toList();
  }

  static List<Transaction> filterTransactionType(
    List<Transaction> transactionList,
    TransactionType? transactionType,
  ) {
    switch (transactionType) {
      case TransactionType.expense:
        return transactionList
            .where((element) => element.type == TransactionType.expense)
            .toList();
      case TransactionType.income:
        return transactionList
            .where((element) => element.type == TransactionType.income)
            .toList();
      default:
        return transactionList;
    }
  }

  static List<Transaction> filterByCategory(List<Transaction>transactionList,Category? category){
   if (category==null) {
     return transactionList;
   }
   return transactionList.where((element) => element.category.name==category.name).toList();
  }
}
