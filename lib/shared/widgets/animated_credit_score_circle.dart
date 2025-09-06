import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:meet_sam_ava/core/theme/tokens/typography_tokens.dart';

class AnimatedCreditScoreCircle extends StatefulWidget {
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
  State<AnimatedCreditScoreCircle> createState() => _AnimatedCreditScoreCircleState();
}

class _AnimatedCreditScoreCircleState extends State<AnimatedCreditScoreCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Calculate progress based on score (assuming max score is 850)
    final progress = widget.score / 850;
    
    _animation = Tween<double>(
      begin: 0,
      end: progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedCreditScoreCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      final progress = widget.score / 850;
      _animation = Tween<double>(
        begin: _animation.value,
        end: progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircleProgressPainter(
              progress: _animation.value,
              strokeWidth: widget.strokeWidth,
              backgroundColor: Theme.of(context).colorScheme.surface,
              gradientColors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.score.toString(),
                    style: TypographyTokens.headlineLargeCondensed.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    widget.status,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final List<Color> gradientColors;

  _CircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Draw background circle with light green
    final backgroundPaint = Paint()
      ..color = gradientColors[1] // Use light green (secondaryContainer)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Draw progress arc with solid dark green
    final progressPaint = Paint()
      ..color = gradientColors[0] // Use dark green (secondary)
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