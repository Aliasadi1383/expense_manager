import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/widgets/historyScreen/custom_search_bar.dart';
import 'package:expense_manager/widgets/historyScreen/transaction_filter_chips.dart';
import 'package:flutter/material.dart';

class TransactionSearchAndFilter extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final TransactionType? selectedType;
  final ValueChanged<TransactionType?> onTypeChanged;
  final VoidCallback onClearSearch;
  const TransactionSearchAndFilter({
    super.key,
    required this.controller,
    required this.onSearchChanged,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          controller: controller,
          onChanged: onSearchChanged,
          onPressed: onClearSearch,
        ),
        Row(
          children: [
            TransactionFilterChips(
              label: 'All',
              selectedFilter: selectedType,
              selectedFilterchips: null,
              onSelected: (_) {
                onTypeChanged(null);
              },
            ),
            TransactionFilterChips(
              label: 'Expenses',
              selectedFilter: selectedType,
              selectedFilterchips: TransactionType.expense,
              onSelected: (value) {
                onTypeChanged(TransactionType.expense);
              },
            ),
            TransactionFilterChips(
              selectedFilter: selectedType,
              selectedFilterchips: TransactionType.income,
              label: 'Income',
              onSelected: (value) {
                onTypeChanged(TransactionType.income);
              },
            ),
          ],
        ),
      ],
    );
  }
}
