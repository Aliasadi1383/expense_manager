import 'package:expense_manager/logics/history_logic.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/screen/add_transaction_screen.dart';
import 'package:expense_manager/state/history_filter_state.dart';
import 'package:expense_manager/state/transaction_state.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:expense_manager/widgets/custom_toast.dart';
import 'package:expense_manager/widgets/empty_transactions_view.dart';
import 'package:expense_manager/widgets/historyScreen/filter_transactions_dialog.dart';
import 'package:expense_manager/widgets/historyScreen/history_header.dart';
import 'package:expense_manager/widgets/historyScreen/selected_filter_category.dart';
import 'package:expense_manager/widgets/transaction_list_item.dart';
import 'package:expense_manager/widgets/historyScreen/transaction_search_and_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
 
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final Category? selectedCategory=context.watch<HistoryFilterState>().selectedCategory;
   final TransactionType? selectedTransactionType=context.watch<HistoryFilterState>().selectedFilterchips;
    
   


    void navigateToAddTransaction() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTransactionScreen()),
      );
    }

    final transactions = context.watch<TransactionState>().transactionList;

    final typeFilteredTransactions = HistoryLogic.filterTransactionType(
      transactions,
      selectedTransactionType,
    );

    final categoryFilteredTransactions = HistoryLogic.filterByCategory(
      typeFilteredTransactions,
      selectedCategory,
    );

    final filteredTransactions = HistoryLogic.transactionSearch(
      categoryFilteredTransactions,
      _searchController.text,
    );

    return Scaffold(
      body: CustomScrollView(
        
        slivers: [

          SliverToBoxAdapter(
            child: HistoryHeader(
              onPressed: () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: 'Close filter dialog',
                  context: context,

                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FilterTransactionsDialog(
                        onApply: (type, category) { 
                          context.read<HistoryFilterState>().historyFilter(category, type);

                          CustomToast.show(
                            context,
                            'Filters applied',
                            Icon(
                              Icons.check_circle,
                              color: AppColors.successLight,
                            ),
                          );
                        },
                        onReset: () {
                           context.read<HistoryFilterState>().clearFilters();

                          CustomToast.show(
                            context,
                            'Filters cleared',
                            Icon(
                              Icons.check_circle,
                              color: AppColors.successLight,
                            ),
                          );
                        },

                        selectedType: selectedTransactionType,
                        selectedCategory: selectedCategory,
                      ),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        if (animation.status == AnimationStatus.reverse) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        }

                        final slideAnimation =
                            Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            );

                        return SlideTransition(
                          position: slideAnimation,
                          child: child,
                        );
                      },
                );
              },
              hasActiveFilters:
                  selectedTransactionType != null || selectedCategory != null,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TransactionSearchAndFilter(
                    controller: _searchController,
                    onSearchChanged: (_) {
                      setState(() {});
                    },
                    selectedType: selectedTransactionType,
                    onTypeChanged: (value) {

                       context.read<HistoryFilterState>().setSelectedType(value);
                    },
                    onClearSearch: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),

                  if (selectedCategory != null) ...[
                    SelectedFilterCategory(
                      categoryName: selectedCategory.name,
                      onRemove: () {
                      context.read<HistoryFilterState>().setSelectedCategory(null);

                      },
                    ),
                    const SizedBox(height: 20),
                  ],

                  if (filteredTransactions.isNotEmpty) ...[
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: AppColors.hintTextColor.withValues(alpha: 0.8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Showing ${filteredTransactions.length} items',
                            ),
                          ),
                          Text('Swipe or tap for details'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
          if (transactions.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: EmptyTransactionsView(
                  title: 'There are no transactions',
                  description:
                      'Start tracking your finances by adding your first transaction',
                  onAddTransaction: navigateToAddTransaction,
                ),
              ),
            )
          else if (filteredTransactions.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: EmptyTransactionsView(
                  title: 'No transaction found',
                  description:
                      'Try adjusting your search criteria, clearing active\n filters, or adding a new transaction.',
                  onAddTransaction: navigateToAddTransaction,
                  onClearFilters: () {
                    setState(() {
                      _searchController.clear();
                    });
                    context.read<HistoryFilterState>().clearFilters();
                  },
                  showClearFiltersButton: true,
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(child: TransactionListItem(transactionList: filteredTransactions))),
        ],
      ),
    );
  }
}
