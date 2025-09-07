import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedProgressSlider extends StatefulWidget {
  final double currentValue;
  final double maxValue;
  final String currentValueLabel;
  final String maxValueLabel;
  final Duration animationDuration;
  final Color? backgroundColor;

  const AnimatedProgressSlider({
    required this.currentValue,
    required this.maxValue,
    required this.currentValueLabel,
    required this.maxValueLabel,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.backgroundColor,
    super.key,
  });

  @override
  State<AnimatedProgressSlider> createState() => _AnimatedProgressSliderState();
}

class _AnimatedProgressSliderState extends State<AnimatedProgressSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _markerAnimation;
  bool _hasAnimated = false;

  double get _progressPercentage => widget.currentValue / widget.maxValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _setupAnimations();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimated && info.visibleFraction > 0) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  void _setupAnimations() {
    // Marker animates from 0 to final position with elastic effect
    _markerAnimation = Tween<double>(
      begin: 0.0,
      end: _progressPercentage.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void didUpdateWidget(AnimatedProgressSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue ||
        oldWidget.maxValue != widget.maxValue) {
      _controller.reset();
      _setupAnimations();
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
    final backgroundColor = widget.backgroundColor ??
        Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);

    return VisibilityDetector(
      key: Key('animated-progress-slider-${widget.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final barWidth = constraints.maxWidth;
                  final markerPosition = _markerAnimation.value * barWidth;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background bar (light color)
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),

                      // Marker with label and triangle caret
                      Positioned(
                        left: markerPosition - 25, // Center the label
                        top: -36,
                        child: Column(
                          children: [
                            Container(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            // Triangle caret pointing down
                            CustomPaint(
                              size: const Size(8, 4),
                              painter: TrianglePainter(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: markerPosition - 8,
                        child: Container(
                          width: 4,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: SpacingTokens.space3),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Spend limit: ${widget.maxValueLabel} ',
                    ),
                    TextSpan(
                      text: 'Why is it different?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle "Why is it different?" tap
                        },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Custom painter for the triangle caret
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
