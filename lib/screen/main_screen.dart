import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/screen/history_screen.dart';
import 'package:expense_manager/screen/home_screen.dart';
import 'package:expense_manager/screen/manage_categories.dart';
import 'package:expense_manager/screen/reports_screen.dart';
import 'package:expense_manager/screen/settings_screen.dart';
import 'package:expense_manager/state/page_state.dart';
import 'package:expense_manager/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = const [
    HomeScreen(),
    HistoryScreen(),
    ReportsScreen(),
    SettingsScreen(),
    ManageCategories()
  ];

  @override
  Widget build(BuildContext context) {
    final PageState tab = context.watch<PageState>();

    return Scaffold(
      body: pages[tab.selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: tab.currentTabIndex,
        onChangeItem: (value) {
          context.read<PageState>().changePage(value);
        },
        onAddTransaction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
      ),
    );
  }
}
