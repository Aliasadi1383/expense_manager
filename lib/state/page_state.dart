import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {
  int selectedIndex = 0;
  int currentTabIndex =0;

  void changePage(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
   if (index<4) {
     currentTabIndex=index;
   }
    notifyListeners();
  }
}
