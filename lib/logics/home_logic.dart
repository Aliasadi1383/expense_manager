import 'package:expense_manager/models/transaction.dart';

class HomeLogic{
 static  List<Transaction> groupTransactions(List<Transaction> transactionList) {
    List<Transaction> groupedTransactions = [];

    for (var transaction in transactionList) {
      bool isGrouped = false;

      if (groupedTransactions.isEmpty) {
        groupedTransactions.add(
          Transaction(
            type: transaction.type,
            amount: transaction.amount,
            title: transaction.title,
            category: transaction.category,
            dateTime: transaction.dateTime,
            account: transaction.account,
          ),
        );
      } else {
        for (var groupedTransaction in groupedTransactions) {
          if (groupedTransaction.category.name == transaction.category.name &&
              groupedTransaction.type == transaction.type) {
            groupedTransaction.amount += transaction.amount;
            isGrouped = true;
            break;
          }
        }

        if (!isGrouped) {
          groupedTransactions.add(
            Transaction(
              type: transaction.type,
              amount: transaction.amount,
              title: transaction.title,
              category: transaction.category,
              dateTime: transaction.dateTime,
              account: transaction.account,
            ),
          );
        }
      }
    }
    return groupedTransactions;
  }

  static List<Transaction> getRecentWeekTransactions(List<Transaction> transactions){
    final DateTime now = DateTime.now();
   return transactions
        .where(
          (element) => element.dateTime.isAfter(
            DateTime(now.year, now.month, now.day - 7),
          ),
        )
        .toList();
  }
}