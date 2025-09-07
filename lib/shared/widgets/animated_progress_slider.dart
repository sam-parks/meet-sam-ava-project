import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class AnimatedProgressSlider extends StatefulWidget {
  final double currentValue;
  final double maxValue;
  final String currentValueLabel;
  final String maxValueLabel;
  final Duration animationDuration;
  final Color? progressColor;
  final Color? backgroundColor;

  const AnimatedProgressSlider({
    required this.currentValue,
    required this.maxValue,
    required this.currentValueLabel,
    required this.maxValueLabel,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.progressColor,
    this.backgroundColor,
    super.key,
  });

  @override
  State<AnimatedProgressSlider> createState() => _AnimatedProgressSliderState();
}

class _AnimatedProgressSliderState extends State<AnimatedProgressSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _markerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.currentValue / widget.maxValue,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _markerAnimation = Tween<double>(
      begin: 0.0,
      end: widget.currentValue / widget.maxValue,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressColor =
        widget.progressColor ?? Theme.of(context).colorScheme.secondary;
    final backgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(
                  height: 8,
                  width: double.infinity,
                  child: FractionallySizedBox(
                    widthFactor: _progressAnimation.value,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: (_markerAnimation.value *
                          (MediaQuery.of(context).size.width -
                              SpacingTokens.space8 * 2 -
                              32)) -
                      16,
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingTokens.space2,
                      vertical: SpacingTokens.space1,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.currentValueLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Positioned(
                  left: (_markerAnimation.value *
                          (MediaQuery.of(context).size.width -
                              SpacingTokens.space8 * 2 -
                              32)) -
                      1,
                  top: -2,
                  child: Container(
                    width: 2,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpacingTokens.space4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spend limit: ${widget.maxValueLabel}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: () {
                    // Handle "Why is it different?" tap
                  },
                  child: Text(
                    'Why is it different?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
