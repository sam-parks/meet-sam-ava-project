import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';

class AnimatedCreditScoreLineChart extends StatefulWidget {
  final CreditScoreChart chartData;
  final double height;
  final Duration animationDuration;

  const AnimatedCreditScoreLineChart({
    required this.chartData,
    this.height = 200,
    this.animationDuration = const Duration(milliseconds: 1500),
    super.key,
  });

  @override
  State<AnimatedCreditScoreLineChart> createState() =>
      _AnimatedCreditScoreLineChartState();
}

class _AnimatedCreditScoreLineChartState
    extends State<AnimatedCreditScoreLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
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
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space4),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Calculate how many data points to show based on animation progress
          final dataPointsToShow =
              (_animation.value * widget.chartData.dataPoints.length).ceil();
          final animatedDataPoints =
              widget.chartData.dataPoints.take(dataPointsToShow).toList();

          // Ensure bounds align with 50-point intervals
          final adjustedMinY = widget.chartData.roundedMinY;
          final adjustedMaxY = widget.chartData.roundedMaxY;

          return LineChart(
            LineChartData(
              minY: adjustedMinY,
              maxY: adjustedMaxY,
              gridData: const FlGridData(
                show: false, // Disable automatic grid
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: () {
                  final lines = <HorizontalLine>[];
                  for (double i = adjustedMinY; i <= adjustedMaxY; i += 50) {
                    lines.add(HorizontalLine(
                      y: i,
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.3),
                      strokeWidth: 1,
                    ));
                  }
                  return lines;
                }(),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      );
                    },
                  ),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: animatedDataPoints.asMap().entries.map((entry) {
                    return FlSpot(
                        entry.key.toDouble(), entry.value.score.toDouble());
                  }).toList(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: Theme.of(context).colorScheme.secondary,
                  barWidth: 3,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 3,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: Theme.of(context).colorScheme.secondary,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
