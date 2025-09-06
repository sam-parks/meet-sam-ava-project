import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class CreditScoreChartCard extends StatelessWidget {
  final CreditScore creditScore;
  final CreditScoreChart creditScoreChart;

  const CreditScoreChartCard({
    required this.creditScore,
    required this.creditScoreChart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingTokens.space1,
          ),
          child: Text(
            'Chart',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          height: SpacingTokens.space5,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(SpacingTokens.space5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Credit Score',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: SpacingTokens.space2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpacingTokens.space2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(RadiusTokens.xxxl),
                      ),
                      child: Text(
                        creditScore.status,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingTokens.space1),
                Text(
                  'Updated Today • Next May 12',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                const SizedBox(height: SpacingTokens.space4),
                // Placeholder for chart - you can integrate a charting library here
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(RadiusTokens.sm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: SpacingTokens.space2),
                        Text(
                          'Credit Score Chart',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SpacingTokens.space2),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        creditScoreChart.period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        creditScoreChart.calculationMethod,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
