import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCreditProgressBar extends StatefulWidget {
  final double percentage;
  final double height;
  final Color? progressColor;
  final Color? backgroundColor;
  final Duration animationDuration;

  const AnimatedCreditProgressBar({
    required this.percentage,
    this.height = 8.0,
    this.progressColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 1200),
    super.key,
  });

  @override
  State<AnimatedCreditProgressBar> createState() => _AnimatedCreditProgressBarState();
}

class _AnimatedCreditProgressBarState extends State<AnimatedCreditProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _setupAnimation();
  }

  void _setupAnimation() {
    final targetPercentage = (widget.percentage / 100).clamp(0.0, 1.0);
    
    _animation = Tween<double>(
      begin: 0.0,
      end: targetPercentage,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimated && info.visibleFraction > 0) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedCreditProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percentage != widget.percentage) {
      _controller.reset();
      _setupAnimation();
      if (_hasAnimated) {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressColor = widget.progressColor ?? Theme.of(context).colorScheme.secondary;
    final backgroundColor = widget.backgroundColor ?? 
        Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);

    return VisibilityDetector(
      key: Key('animated-credit-progress-bar-${widget.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(widget.height / 2),
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return FractionallySizedBox(
              widthFactor: _animation.value,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(widget.height / 2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}