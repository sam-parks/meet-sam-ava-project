import 'package:flutter/material.dart';
import 'package:meet_sam_ava/shared/widgets/animated_circular_indicator.dart';

class AnimatedCircularProgress extends StatelessWidget {
  final double percentage;
  final String percentageLabel;
  final String statusLabel;
  final Duration animationDuration;
  final double size;
  final double strokeWidth;

  const AnimatedCircularProgress({
    required this.percentage,
    required this.percentageLabel,
    required this.statusLabel,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.size = 85,
    this.strokeWidth = 6,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularIndicator(
      value: percentage,
      maxValue: 100,
      displayText: '${percentage.round()}%',
      subText: statusLabel,
      size: size,
      strokeWidth: strokeWidth,
      progressColor: Theme.of(context).colorScheme.secondary,
      backgroundColor:
          Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      animationDuration: animationDuration,
      subTextStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
