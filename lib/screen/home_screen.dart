import 'package:expense_manager/widgets/homeScreen/balance_summary_card.dart';
import 'package:expense_manager/widgets/homeScreen/budget_summary_card.dart';
import 'package:expense_manager/widgets/homeScreen/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           BalanceSummaryCard(),
           const SizedBox(height: 24,),
           BudgetSummaryCard(),
           const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
