import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/widgets/credit_score_info.dart';
import 'package:meet_sam_ava/shared/widgets/animated_credit_score_line_chart.dart';

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
            left: SpacingTokens.space3,
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
                CreditScoreInfo(
                  title: 'Credit Score',
                  badgeText: creditScore.change,
                  subtitle:
                      '${creditScore.lastUpdated} | Next ${creditScore.nextUpdate}',
                  provider: creditScore.provider,
                  titleStyle: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: SpacingTokens.space4),
                // Animated credit score line chart
                AnimatedCreditScoreLineChart(
                  chartData: creditScoreChart,
                  height: 100,
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
