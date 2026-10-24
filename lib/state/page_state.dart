import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {
  int selectedIndex = 0;

  void changePage(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;

    notifyListeners();
  }
}
