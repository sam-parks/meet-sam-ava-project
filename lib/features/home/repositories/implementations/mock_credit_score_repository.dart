import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_score_repository.dart';

class MockCreditScoreRepository implements ICreditScoreRepository {
  @override
  Future<Either<String, CreditScore>> getCreditScore() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return right(const CreditScore(
      score: 720,
      status: '+2pts',
      lastUpdated: 'Updated Today',
      nextUpdate: 'Next May 12',
      provider: 'Experian',
    ));
  }

  @override
  Future<Either<String, CreditScoreChart>> getCreditScoreChart() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final dataPoints = [
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 365)), score: 650),
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 300)), score: 660),
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 240)), score: 670),
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 180)), score: 685),
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 120)), score: 690),
      CreditScoreDataPoint(
          date: DateTime.now().subtract(const Duration(days: 60)), score: 705),
      CreditScoreDataPoint(date: DateTime.now(), score: 720),
    ];

    return right(CreditScoreChart(
      dataPoints: dataPoints,
      period: 'Last 12 months',
      calculationMethod: 'Score calculated using VantageScore 3.0',
    ));
  }

  @override
  Future<Either<String, void>> refreshCreditScore() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return right(null);
  }
}
