import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/models/utilization_ranges.dart';
import 'package:meet_sam_ava/shared/widgets/animated_progress_slider.dart';
import 'package:meet_sam_ava/shared/widgets/total_balance_card.dart';

class AccountDetailsCard extends StatelessWidget {
  final AccountDetails accountDetails;
  final double utilizationPercentage;

  const AccountDetailsCard({
    required this.accountDetails,
    required this.utilizationPercentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: SpacingTokens.space1),
          child: Text(
            'Account details',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space5),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space5),
            child: Column(
              children: [
                // Animated progress slider section
                AnimatedProgressSlider(
                  currentValue: accountDetails.currentSpend,
                  maxValue: accountDetails.spendLimitValue,
                  currentValueLabel: '\$${accountDetails.currentSpend.toInt()}',
                  maxValueLabel: accountDetails.spendLimit,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const SizedBox(height: SpacingTokens.space5),
                // Balance and Credit Limit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountDetails.balance,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          'Balance',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          accountDetails.creditLimit,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          'Credit limit',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: SpacingTokens.space3,
                  ),
                  height: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Utilization',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '$utilizationPercentage%',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space5),
        // Total balance card as separate section
        TotalBalanceCard(
          totalBalance: accountDetails.totalBalance,
          totalLimit: accountDetails.totalLimit,
          ratingLabel: accountDetails.ratingLabel,
          utilizationPercentage: utilizationPercentage,
          utilizationRanges:
              UtilizationRange.getRangesForPercentage(utilizationPercentage),
        ),
      ],
    );
  }
}
