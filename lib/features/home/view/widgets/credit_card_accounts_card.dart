import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

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
        Text(
          'Open credit card accounts',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: SpacingTokens.space4),
        ...accounts.map((account) => Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space3),
          child: CreditCardAccountItem(account: account),
        )),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.provider,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space1),
                  Text(
                    account.balance,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    account.reportedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  account.utilizationPercentage,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: SpacingTokens.space1),
                Text(
                  account.creditLimit,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}