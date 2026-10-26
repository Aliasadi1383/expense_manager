import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:flutter/material.dart';

class HistoryFilterState extends ChangeNotifier {
  Category? selectedCategory;
  TransactionType? selectedFilterchips;

  void historyFilter(Category? category, TransactionType? type) {
    selectedCategory = category;
    selectedFilterchips = type;
    notifyListeners();
  }

  void setSelectedType(TransactionType? type){
   selectedFilterchips = type;
   notifyListeners();
  }

  void setSelectedCategory(Category? category){
    selectedCategory = category;
    notifyListeners();
  }

  void clearFilters(){
    selectedCategory=null;
    selectedFilterchips=null;
    notifyListeners();
  }
}
