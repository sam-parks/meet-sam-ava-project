import 'package:flutter/material.dart';
import 'package:meet_sam_ava/shared/widgets/animated_circular_indicator.dart';

class AnimatedCreditScoreCircle extends StatelessWidget {
  final int score;
  final String status;
  final double size;
  final double strokeWidth;
  
  const AnimatedCreditScoreCircle({
    required this.score,
    required this.status,
    this.size = 100,
    this.strokeWidth = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCircularIndicator(
      value: score.toDouble(),
      maxValue: 850,
      displayText: score.toString(),
      subText: status,
      size: size,
      strokeWidth: strokeWidth,
      progressColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      subTextStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}