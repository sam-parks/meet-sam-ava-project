class CreditScore {
  final int score;
  final String status;
  final String lastUpdated;
  final String nextUpdate;
  final String provider;

  const CreditScore({
    required this.score,
    required this.status,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.provider,
  });

  factory CreditScore.empty() => const CreditScore(
        score: 0,
        status: '',
        lastUpdated: '',
        nextUpdate: '',
        provider: '',
      );

  CreditScore copyWith({
    int? score,
    String? status,
    String? lastUpdated,
    String? nextUpdate,
    String? provider,
  }) {
    return CreditScore(
      score: score ?? this.score,
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

  const CreditScoreChart({
    required this.dataPoints,
    required this.period,
    required this.calculationMethod,
  });

  factory CreditScoreChart.empty() => const CreditScoreChart(
        dataPoints: [],
        period: '',
        calculationMethod: '',
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