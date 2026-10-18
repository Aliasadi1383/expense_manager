import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/screen/history_screen.dart';
import 'package:expense_manager/screen/home_screen.dart';
import 'package:expense_manager/screen/reports_screen.dart';
import 'package:expense_manager/screen/settings_screen.dart';
import 'package:expense_manager/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    HistoryScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onChangeItem: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        onAddTransaction: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const AddTransactionScreen()),
          );
        },
      ),
    );
  }
}
