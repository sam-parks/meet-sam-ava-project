class CreditScore {
  final int score;
  final String change;
  final String lastUpdated;
  final String nextUpdate;
  final String provider;
  final String status;

  const CreditScore({
    required this.score,
    required this.change,
    required this.status,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.provider,
  });

  factory CreditScore.empty() => const CreditScore(
        score: 0,
        change: '',
        status: '',
        lastUpdated: '',
        nextUpdate: '',
        provider: '',
      );

  CreditScore copyWith({
    int? score,
    String? change,
    String? status,
    String? lastUpdated,
    String? nextUpdate,
    String? provider,
  }) {
    return CreditScore(
      score: score ?? this.score,
      change: change ?? this.change,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      nextUpdate: nextUpdate ?? this.nextUpdate,
      provider: provider ?? this.provider,
    );
  }
}

class CreditScoreChart {
  final List<CreditScoreDataPoint> dataPoints;
  final String period;
  final String calculationMethod;
  final double minY;
  final double maxY;

  const CreditScoreChart({
    required this.dataPoints,
    required this.period,
    required this.calculationMethod,
    required this.minY,
    required this.maxY,
  });

  // Round minY down to nearest 50
  double get roundedMinY => (minY / 50).floor() * 50.0;
  
  // Round maxY up to nearest 50
  double get roundedMaxY => (maxY / 50).ceil() * 50.0;

  factory CreditScoreChart.empty() => const CreditScoreChart(
        dataPoints: [],
        period: '',
        calculationMethod: '',
        minY: 0.0,
        maxY: 0.0,
      );
}

class CreditScoreDataPoint {
  final DateTime date;
  final int score;

  const CreditScoreDataPoint({
    required this.date,
    required this.score,
  });
}
