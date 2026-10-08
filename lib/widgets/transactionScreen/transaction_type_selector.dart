import 'package:expense_manager/models/transaction_type.dart';
import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';


class TransactionTypeSelector extends StatelessWidget {
 
 final ValueChanged<TransactionType>onChanged;
 final TransactionType selectedType;

  const TransactionTypeSelector({super.key,required this.onChanged,required this.selectedType});


  

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          _buildTypeItem(title:'Expense',type: TransactionType.expense,icon: Icons.arrow_upward,context: context,theme: theme),
          _buildTypeItem(title:'Income',type: TransactionType.income,icon: Icons.arrow_downward,context: context,theme: theme),
          ]),
      ),
    );
  }

  Widget _buildTypeItem({
    required IconData icon,
    required TransactionType type,
    required String title,
   required BuildContext context,
   required ColorScheme theme
  }) {
    final isSelected = selectedType == type;
    return Expanded(
      child: InkWell(
        onTap: () {
          onChanged(type);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? (type==TransactionType.expense?theme.error:AppColors.success):null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(icon,color:isSelected?theme.onSecondary:AppColors.mutedText,),
              SizedBox(width: 3),
              Text(title,style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 14,
                color: isSelected?theme.onSecondary:AppColors.mutedText
              ),)
            ],),
          ),
        ),
      ),
    );
  }
}
