import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:meet_sam_ava/core/theme/tokens/typography_tokens.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCircularIndicator extends StatefulWidget {
  final double value;
  final double maxValue;
  final String displayText;
  final String? subText;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final Duration animationDuration;
  final TextStyle? textStyle;
  final TextStyle? subTextStyle;
  
  const AnimatedCircularIndicator({
    required this.value,
    required this.maxValue,
    required this.displayText,
    this.subText,
    this.size = 85,
    this.strokeWidth = 6,
    this.progressColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.textStyle,
    this.subTextStyle,
    super.key,
  });

  @override
  State<AnimatedCircularIndicator> createState() => _AnimatedCircularIndicatorState();
}

class _AnimatedCircularIndicatorState extends State<AnimatedCircularIndicator>
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
    final progress = widget.value / widget.maxValue;
    
    _animation = Tween<double>(
      begin: 0,
      end: progress,
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedCircularIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value || oldWidget.maxValue != widget.maxValue) {
      _controller.reset();
      _setupAnimation();
      if (_hasAnimated) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated-circular-indicator-${widget.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
            painter: _CircleProgressPainter(
              progress: _animation.value,
              strokeWidth: widget.strokeWidth,
              backgroundColor: widget.backgroundColor ?? 
                  Theme.of(context).colorScheme.secondaryContainer,
              progressColor: widget.progressColor ?? 
                  Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.displayText,
                    style: widget.textStyle ?? 
                        TypographyTokens.headlineLargeCondensed.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: widget.size > 80 ? 34 : 28,
                        ),
                  ),
                  if (widget.subText != null)
                    Text(
                      widget.subText!,
                      style: widget.subTextStyle ??
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: widget.progressColor ?? 
                                Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          );
        },
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  _CircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    // Start from top (-pi/2) and sweep based on progress
    final sweepAngle = 2 * math.pi * progress;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}