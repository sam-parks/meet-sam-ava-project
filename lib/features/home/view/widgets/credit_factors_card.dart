import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class CreditFactorsCard extends StatelessWidget {
  final CreditFactors? creditFactors;

  const CreditFactorsCard({
    this.creditFactors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final factors = creditFactors?.factors ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: SpacingTokens.space1),
          child: Text(
            'Credit factors',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space4),
        Row(
          children: factors.map((factor) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: SpacingTokens.space3),
                child: CreditFactorItem(factor: factor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CreditFactorItem extends StatelessWidget {
  final CreditFactor factor;

  const CreditFactorItem({
    required this.factor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final impactColor = _getImpactColor(context, factor.impact);
    final impactLabel = _getImpactLabel(factor.impact);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              factor.name,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: SpacingTokens.space2),
            Text(
              factor.percentage,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: SpacingTokens.space2),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space2,
                vertical: SpacingTokens.space1,
              ),
              decoration: BoxDecoration(
                color: impactColor,
                borderRadius: BorderRadius.circular(RadiusTokens.sm),
              ),
              child: Text(
                impactLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getImpactColor(BuildContext context, CreditFactorImpact impact) {
    switch (impact) {
      case CreditFactorImpact.high:
        return Colors.red.shade700;
      case CreditFactorImpact.medium:
        return Colors.orange.shade600;
      case CreditFactorImpact.low:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  String _getImpactLabel(CreditFactorImpact impact) {
    switch (impact) {
      case CreditFactorImpact.high:
        return 'HIGH IMPACT';
      case CreditFactorImpact.medium:
        return 'MED IMPACT';
      case CreditFactorImpact.low:
        return 'LOW IMPACT';
    }
  }
}
