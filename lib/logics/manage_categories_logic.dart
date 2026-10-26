import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/models/transaction_type.dart';

class ManageCategoriesLogic{
  static int totalNumberTransactionsCategory(
    List<Transaction> transactionList,
    Category category,
  ) {
    return transactionList.fold(0, (previousValue, element) {
      if (element.category == category) {
        return previousValue += 1;
      }
      return previousValue;
    });
  }

  static   double totalAmountTransactionsCategory(
    List<Transaction> transactionList,
    Category category,
    TransactionType type,
  ) {
    double sum = 0;
    for (var element in transactionList) {
      if (element.category == category && element.type == type) {
        sum += element.amount;
      }
    }
    return sum;
  }
}