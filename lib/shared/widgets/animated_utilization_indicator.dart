import 'package:flutter/material.dart';
import 'package:meet_sam_ava/shared/widgets/animated_circular_indicator.dart';
import 'package:meet_sam_ava/shared/models/utilization_rating.dart';

class AnimatedUtilizationIndicator extends StatelessWidget {
  final double percentage;
  final String statusLabel;
  final Duration animationDuration;
  final double size;
  final double strokeWidth;

  const AnimatedUtilizationIndicator({
    required this.percentage,
    required this.statusLabel,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.size = 85,
    this.strokeWidth = 6,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rating = UtilizationRating.fromPercentage(percentage);
    // Get the visual color based on which range the percentage falls into
    final ratingIndex = UtilizationRating.values.indexOf(rating);
    final visualColor = UtilizationRating.getBarColor(ratingIndex);
    
    return AnimatedCircularIndicator(
      value: percentage,
      maxValue: 100,
      displayText: '${percentage.round()}%',
      subText: statusLabel,
      size: size,
      strokeWidth: strokeWidth,
      progressColor: visualColor, // Dark green
      backgroundColor: visualColor.withValues(alpha: 0.3), // Light green
      animationDuration: animationDuration,
      subTextStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: visualColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}