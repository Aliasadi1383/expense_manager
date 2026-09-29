import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/screen/history_screen.dart';
import 'package:expense_manager/screen/home_screen.dart';
import 'package:expense_manager/screen/reports_screen.dart';
import 'package:expense_manager/screen/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   int selectedIndex=0;

  final List<Widget> pages =const[
    HomeScreen(),
    HistoryScreen(),
    AddTransactionScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

   final theme=Theme.of(context).colorScheme;
   final textTheme=Theme.of(context).textTheme;

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if(states.contains(WidgetState.selected)){
              return IconThemeData(
                color: theme.primary
              );
            }
            return IconThemeData(
                color: theme.secondary.withValues(alpha: 0.8)
              );
            
          },)
        ),
        child: NavigationBar(
           height: 64,
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex=value;
            });
          },
          selectedIndex: selectedIndex,
          
          indicatorColor: theme.primary.withValues(alpha: 0.25),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return  textTheme.labelMedium!.copyWith(color: theme.primary);
            }
            return textTheme.labelMedium!.copyWith(color: theme.secondary.withValues(alpha: 0.8));
          },),
          
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined,), label: 'home',),
            NavigationDestination(icon: Icon(Icons.receipt_long), label: 'History',),
            GestureDetector(

              onTap: () {
                setState(() {
                  selectedIndex=2;
                });
              },
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add,color: theme.onPrimary,),
              ),
            ),
            NavigationDestination(icon: Icon(Icons.donut_small_outlined), label: 'Report'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings',),
          ],
        ),
      ),
    );
  }
}
