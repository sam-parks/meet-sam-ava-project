import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/widgets/credit_score_info.dart';
import 'package:meet_sam_ava/shared/widgets/animated_credit_score_circle.dart';

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
              child: CreditScoreInfo(
                title: 'Credit Score',
                badgeText: creditScore.change,
                subtitle:
                    '${creditScore.lastUpdated} | ${creditScore.nextUpdate}',
                provider: creditScore.provider,
              ),
            ),
            AnimatedCreditScoreCircle(
              score: creditScore.score,
              status: creditScore.status,
              size: 100,
              strokeWidth: 8,
            ),
          ],
        ),
      ),
    );
  }
}
