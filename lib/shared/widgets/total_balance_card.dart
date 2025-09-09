import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/shared/models/utilization_ranges.dart';
import 'package:meet_sam_ava/shared/models/utilization_rating.dart';
import 'package:meet_sam_ava/shared/widgets/animated_utilization_indicator.dart';

class TotalBalanceCard extends StatelessWidget {
  final String totalBalance;
  final String totalLimit;
  final String ratingLabel;
  final double utilizationPercentage;
  final List<UtilizationRange> utilizationRanges;

  const TotalBalanceCard({
    required this.totalBalance,
    required this.totalLimit,
    required this.ratingLabel,
    required this.utilizationPercentage,
    required this.utilizationRanges,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          children: [
                            TextSpan(
                              text: 'Total balance: ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextSpan(
                              text: totalBalance,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpacingTokens.space1),
                      Text(
                        'Total limit: $totalLimit',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: SpacingTokens.space4),
                AnimatedUtilizationIndicator(
                  percentage: utilizationPercentage,
                  statusLabel: ratingLabel,
                  size: 80,
                ),
              ],
            ),
            const SizedBox(height: SpacingTokens.space2),
            if (utilizationRanges.isNotEmpty) ...[
              Row(
                children: [
                  // Excellent + Good section (0-29%)
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Show rating label if Excellent (0-9%) or Good (10-29%) is active
                        if (_isRangeActive(0, 9, utilizationPercentage) ||
                            _isRangeActive(10, 29, utilizationPercentage))
                          Text(
                            ratingLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: _getRatingColor(context, ratingLabel),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        else
                          const SizedBox(height: 20),
                        const SizedBox(height: SpacingTokens.space2),
                        Container(
                          height: 24,
                          margin: const EdgeInsets.only(right: 1),
                          decoration: BoxDecoration(
                            color: UtilizationRating.getBarColor(0),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Fair section (30-49%)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // Show rating label only if Fair (30-49%) is active
                        if (_isRangeActive(30, 49, utilizationPercentage))
                          Text(
                            ratingLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: _getRatingColor(context, ratingLabel),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        else
                          const SizedBox(height: 20),
                        const SizedBox(height: SpacingTokens.space2),
                        Container(
                          height: 24,
                          margin: const EdgeInsets.only(right: 1),
                          decoration: BoxDecoration(
                            color: UtilizationRating.getBarColor(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Needs Work + Poor section (50%+)
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Show rating label if Needs Work (50-74%) or Poor (75%+) is active
                        if (_isRangeActive(50, 74, utilizationPercentage) ||
                            _isRangeActive(75, 100, utilizationPercentage))
                          Text(
                            ratingLabel,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: _getRatingColor(context, ratingLabel),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        else
                          const SizedBox(height: 20),
                        const SizedBox(height: SpacingTokens.space2),
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: UtilizationRating.getBarColor(3),
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: utilizationRanges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final range = entry.value;
                  final isActive = range.isActive;

                  // Get the appropriate color for this range
                  Color rangeColor;
                  if (isActive) {
                    rangeColor = UtilizationRating.getBarColor(index);
                  } else {
                    rangeColor = Theme.of(context).colorScheme.onSurfaceVariant;
                  }

                  return Text(
                    range.range,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: rangeColor,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getRatingColor(BuildContext context, String rating) {
    // Try to match rating string to enum and use the simplified 3-color scheme
    for (int i = 0; i < UtilizationRating.values.length; i++) {
      if (UtilizationRating.values[i].label.toLowerCase() ==
          rating.toLowerCase()) {
        return UtilizationRating.getBarColor(i);
      }
    }
    // Default fallback
    return Theme.of(context).colorScheme.onSurface;
  }

  bool _isRangeActive(double min, double max, double percentage) {
    return percentage >= min && percentage <= max;
  }
}
