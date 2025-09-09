import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/widgets/animated_credit_progress_bar.dart';

class CreditCardAccountsCard extends StatelessWidget {
  final CreditCardAccounts? creditCardAccounts;

  const CreditCardAccountsCard({
    this.creditCardAccounts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accounts = creditCardAccounts?.accounts ?? [];

    if (accounts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: SpacingTokens.space3),
          child: Text(
            'Open credit card accounts',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space3),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space5),
            child: Column(
              children: [
                for (int i = 0; i < accounts.length; i++) ...[
                  CreditCardAccountItem(account: accounts[i]),
                  if (i < accounts.length - 1) ...[
                    const SizedBox(height: SpacingTokens.space5),
                    Container(
                      height: 1,
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.2),
                    ),
                    const SizedBox(height: SpacingTokens.space5),
                  ],
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CreditCardAccountItem extends StatelessWidget {
  final CreditCardAccount account;

  const CreditCardAccountItem({
    required this.account,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with provider name and percentage
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              account.provider,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              account.utilizationPercentageString,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space3),

        // Animated progress bar
        AnimatedCreditProgressBar(
          percentage: account.utilizationPercentage,
          height: 8.0,
        ),
        const SizedBox(height: SpacingTokens.space3),

        // Balance and limit row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${account.balance} Balance',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${account.creditLimit} Limit',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space1),

        // Reported date
        Text(
          account.reportedDate,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
