import 'package:expense_manager/logic/history.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/screen/add_transaction_screen.dart';
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
  Category? _selectedCategory;
  TransactionType? _selectedFilterchips;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void navigateToAddTransaction() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTransactionScreen()),
      );
    }

    final transactions = context.watch<TransactionState>().transactionList;

    final typeFilteredTransactions = History.filterTransactionType(
      transactions,
      _selectedFilterchips,
    );

    final categoryFilteredTransactions = History.filterByCategory(
      typeFilteredTransactions,
      _selectedCategory,
    );

    final filteredTransactions = History.transactionSearch(
      categoryFilteredTransactions,
      _searchController.text,
    );

    return Scaffold(
      // appBar: HistoryHeader(
      //   onPressed: () {
      //     showGeneralDialog(
      //       barrierDismissible: true,
      //       barrierLabel: 'Close filter dialog',
      //       context: context,

      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           FilterTransactionsDialog(
      //             onApply: (type, category) {
      //               setState(() {
      //                 _selectedFilterchips = type;
      //                 _selectedCategory = category;
      //               });
      //               CustomToast.show(
      //                 context,
      //                 'Filters applied',
      //                 Icon(Icons.check_circle, color: AppColors.successLight),
      //               );
      //             },
      //             onReset: () {
      //               setState(() {
      //                 _selectedCategory = null;
      //                 _selectedFilterchips = null;
      //               });
      //               CustomToast.show(
      //                 context,
      //                 'Filters cleared',
      //                 Icon(Icons.check_circle, color: AppColors.successLight),
      //               );
      //             },

      //             selectedType: _selectedFilterchips,
      //             selectedCategory: _selectedCategory,
      //           ),
      //       transitionBuilder: (context, animation, secondaryAnimation, child) {
      //         if (animation.status == AnimationStatus.reverse) {
      //           return FadeTransition(opacity: animation, child: child);
      //         }

      //         final slideAnimation =
      //             Tween<Offset>(
      //               begin: const Offset(0, 1),
      //               end: Offset.zero,
      //             ).animate(
      //               CurvedAnimation(parent: animation, curve: Curves.easeOut),
      //             );

      //         return SlideTransition(position: slideAnimation, child: child);
      //       },
      //     );
      //   },
      //   hasActiveFilters:
      //       _selectedFilterchips != null || _selectedCategory != null,
      // ),
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
                          setState(() {
                            _selectedFilterchips = type;
                            _selectedCategory = category;
                          });
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
                          setState(() {
                            _selectedCategory = null;
                            _selectedFilterchips = null;
                          });
                          CustomToast.show(
                            context,
                            'Filters cleared',
                            Icon(
                              Icons.check_circle,
                              color: AppColors.successLight,
                            ),
                          );
                        },

                        selectedType: _selectedFilterchips,
                        selectedCategory: _selectedCategory,
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
                  _selectedFilterchips != null || _selectedCategory != null,
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
                    selectedType: _selectedFilterchips,
                    onTypeChanged: (value) {
                      setState(() {
                        _selectedFilterchips = value;
                      });
                    },
                    onClearSearch: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),

                  if (_selectedCategory != null) ...[
                    SelectedFilterCategory(
                      categoryName: _selectedCategory!.name,
                      onRemove: () {
                        setState(() {
                          _selectedCategory = null;
                        });
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
                      _selectedFilterchips = null;
                      _selectedCategory = null;
                    });
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
