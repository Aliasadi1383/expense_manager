
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:uuid/uuid.dart';

class Transaction {
 final String id;
  TransactionType type;
  double amount;
  String title;
  Category category;
  DateTime dateTime;
  String account;
  String? notes;

   Transaction({
    String? id,
    required this.type,
    required this.amount,
    required this.title,
    required this.category,
    required this.dateTime,
    required this.account,
    this.notes
   }):id=id??const Uuid().v4();
}