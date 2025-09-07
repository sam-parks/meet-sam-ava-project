import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/color_tokens.dart';

enum UtilizationRating {
  excellent(
    label: 'Excellent',
    minPercentage: 0,
    maxPercentage: 9,
    rangeLabel: '0-9%',
  ),
  good(
    label: 'Good',
    minPercentage: 10,
    maxPercentage: 29,
    rangeLabel: '10-29%',
  ),
  fair(
    label: 'Fair',
    minPercentage: 30,
    maxPercentage: 49,
    rangeLabel: '30-49%',
  ),
  needsWork(
    label: 'Needs Work',
    minPercentage: 50,
    maxPercentage: 74,
    rangeLabel: '50-74%',
  ),
  poor(
    label: 'Poor',
    minPercentage: 75,
    maxPercentage: 100,
    rangeLabel: '<75%',
  );

  final String label;
  final int minPercentage;
  final int maxPercentage;
  final String rangeLabel;

  const UtilizationRating({
    required this.label,
    required this.minPercentage,
    required this.maxPercentage,
    required this.rangeLabel,
  });

  static UtilizationRating fromPercentage(double percentage) {
    if (percentage <= 9) return UtilizationRating.excellent;
    if (percentage <= 29) return UtilizationRating.good;
    if (percentage <= 49) return UtilizationRating.fair;
    if (percentage <= 74) return UtilizationRating.needsWork;
    return UtilizationRating.poor;
  }

  // Get the visual color for the bar graph (3 colors for 5 ranges)
  static Color getBarColor(int index) {
    switch (index) {
      case 0: // 0-9%
      case 1: // 10-29%
        return ColorTokens.secondary;
      case 2: // 30-49%
        return const Color(0xFFFF7E17).withAlpha(70); // Peach
      case 3: // 50-74%
      case 4: // <75%
        return const Color(0xFFDD1338).withAlpha(70); // Pink
      default:
        return ColorTokens.secondary;
    }
  }
}
