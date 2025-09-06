import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class CreditScoreCard extends StatelessWidget {
  final CreditScore creditScore;

  const CreditScoreCard({
    required this.creditScore,
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
                  Row(
                    children: [
                      Text(
                        'Credit Score',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(width: SpacingTokens.space2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpacingTokens.space2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius:
                              BorderRadius.circular(RadiusTokens.xxxl),
                        ),
                        child: Text(
                          creditScore.status,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingTokens.space1),
                  Text(
                    '${creditScore.lastUpdated} | ${creditScore.nextUpdate}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: SpacingTokens.space3),
                  Text(
                    creditScore.provider,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  creditScore.score.toString(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
