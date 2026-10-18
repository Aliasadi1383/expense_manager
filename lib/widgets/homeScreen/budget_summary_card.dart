import 'package:expense_manager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetSummaryCard extends StatelessWidget {
  const BudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(theme, textTheme),
            const SizedBox(height: 12),
            _buildProgressBar(theme),
            const SizedBox(height: 12),
            _buildBudgetDetails(textTheme),

          
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetDetails(TextTheme textTheme) {
    return Row(
      children: [
        Text(
          '\$7500.00',
          style: textTheme.labelMedium!.copyWith(
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'spent',
          style: textTheme.labelMedium!.copyWith(
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: AppColors.mutedText,
          ),
        ),
        const Spacer(),
        Text(
          'Limit: \$2,000.00',
          style: textTheme.labelMedium!.copyWith(
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: AppColors.mutedText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(ColorScheme theme) {
    return Container(
      width: double.infinity,
      height: 10,
      decoration: BoxDecoration(
        color: theme.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 200,
          height: 6,
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme theme, TextTheme textTheme) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: theme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.account_balance_wallet_outlined,
            color: theme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'October Budget',
              style: textTheme.titleMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '37.5% of cap used',
              style: textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.successLight.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            '\$1,250 left',
            style: textTheme.labelMedium!.copyWith(color: AppColors.success),
          ),
        ),
      ],
    );
  }
}
