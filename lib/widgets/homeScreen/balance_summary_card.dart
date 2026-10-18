import 'package:flutter/material.dart';

class BalanceSummaryCard extends StatefulWidget {
  const BalanceSummaryCard({super.key});

  @override
  State<BalanceSummaryCard> createState() => _BalanceSummaryCardState();
}

class _BalanceSummaryCardState extends State<BalanceSummaryCard> {
  bool isAmounts = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
            color: theme.primary.withValues(alpha: 0.4)
          )
        ],
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6A14B4),
            theme.primary,
            const Color(0xFF3730A3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceHeader(theme, textTheme),
            const SizedBox(height: 16),
            Text(
              isAmounts ? '\$2,450.00' : '•••••••',
              style: textTheme.titleLarge!.copyWith(color: theme.onPrimary),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFinancialStat(theme, textTheme, isIncome: true),
                const SizedBox(width: 10),
                _buildFinancialStat(theme, textTheme, isIncome: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialStat(
    ColorScheme theme,
    TextTheme textTheme, {
    required bool isIncome,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.onPrimary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isIncome ? 'Total Income' : 'Total Expenses',
                  style: textTheme.labelMedium!.copyWith(
                    color: theme.surfaceContainerHighest.withValues(alpha: 0.6),
                  ),
                ),
                Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    color: isIncome
                        ? theme.tertiary.withValues(green: 0.65, alpha: 0.5)
                        : theme.error.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isIncome
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: isIncome
                        ? theme.tertiary.withValues(green: 0.9)
                        : theme.error.withValues(green: 0.7, red: 0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isAmounts ? (isIncome ? '+\$3,200.00' : '-\$750.00') : '••••••',
              style: textTheme.titleMedium!.copyWith(color: theme.onPrimary),
            ),
            const SizedBox(height: 5),
            Text(
             isAmounts?(isIncome ? '+14.2% this mo' : '-4.5% vs avg'):'••••••',

              style: textTheme.labelMedium!.copyWith(
                color: isIncome
                    ? theme.tertiary.withValues(green: 1)
                    : theme.error.withValues(green: 0.7, red: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceHeader(ColorScheme theme, TextTheme textTheme) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: theme.onPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'TOTAL BALANCE',
            style: textTheme.labelMedium!.copyWith(
              color: theme.surfaceContainerHighest.withValues(alpha: 0.6),
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'USD',
          style: textTheme.labelMedium!.copyWith(
            color: theme.surfaceContainerHighest.withValues(alpha: 0.6),
            fontSize: 13,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            setState(() {
              isAmounts = !isAmounts;
            });
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: theme.onPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isAmounts
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: theme.onPrimary.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
