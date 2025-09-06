import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class AccountDetailsCard extends StatelessWidget {
  final AccountDetails? accountDetails;

  const AccountDetailsCard({
    this.accountDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (accountDetails == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account details',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: SpacingTokens.space4),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space4),
            child: Column(
              children: [
                // Spend limit section
                Container(
                  padding: const EdgeInsets.all(SpacingTokens.space3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(RadiusTokens.md),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(SpacingTokens.space2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '\$/S',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: SpacingTokens.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Spend limit: ${accountDetails!.spendLimit} Why is it different?',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SpacingTokens.space4),
                // Balance and Credit Limit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      accountDetails!.balance,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      accountDetails!.creditLimit,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      'Credit limit',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Utilization',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      accountDetails!.utilizationPercentage,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space4),
                // Total balance section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total balance: ${accountDetails!.totalBalance}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Total limit: ${accountDetails!.totalLimit}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'E',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space2),
                Text(
                  accountDetails!.ratingLabel,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: SpacingTokens.space4),
                // Utilization range
                if (accountDetails!.utilizationRanges.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: accountDetails!.utilizationRanges.map((range) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpacingTokens.space2,
                              vertical: SpacingTokens.space1,
                            ),
                            decoration: BoxDecoration(
                              color: range.isActive 
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(RadiusTokens.sm),
                            ),
                            child: Text(
                              range.range,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: range.isActive 
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: range.isActive ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}