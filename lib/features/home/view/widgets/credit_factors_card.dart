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
          padding: const EdgeInsets.only(left: SpacingTokens.space3),
          child: Text(
            'Credit factors',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space2),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: factors.length,
            itemExtent: 144,
            itemBuilder: (context, index) {
              return CreditFactorItem(factor: factors[index]);
            },
          ),
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
    final impactColor = factor.impact.backgroundColor;
    final impactLabel = factor.impact.label;
    final impactTextColor = factor.impact.textColor;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SpacingTokens.space6,
          horizontal: SpacingTokens.space2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 36,
              width: double.infinity,
              child: Text(
                factor.name,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: SpacingTokens.space2),
            Text(
              factor.percentage,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space3,
                vertical: SpacingTokens.space1,
              ),
              decoration: BoxDecoration(
                color: impactColor,
                borderRadius: BorderRadius.circular(RadiusTokens.xs),
              ),
              child: Text(
                impactLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: impactTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
