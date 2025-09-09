import 'package:flutter_test/flutter_test.dart';
import 'package:meet_sam_ava/features/home/repositories/implementations/mock_credit_score_repository.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';

void main() {
  group('MockCreditScoreRepository Tests', () {
    late MockCreditScoreRepository repository;

    setUp(() {
      repository = MockCreditScoreRepository();
    });

    group('getCreditScore', () {
      test('should return successful credit score data', () async {
        final result = await repository.getCreditScore();

        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected right side'),
          (creditScore) {
            expect(creditScore, isA<CreditScore>());
            expect(creditScore.score, equals(720));
            expect(creditScore.change, equals('+2pts'));
            expect(creditScore.status, equals('Good'));
            expect(creditScore.lastUpdated, equals('Updated Today'));
            expect(creditScore.nextUpdate, equals('Next May 12'));
            expect(creditScore.provider, equals('Experian'));
          },
        );
      });

      test('should simulate network delay', () async {
        final stopwatch = Stopwatch()..start();
        await repository.getCreditScore();
        stopwatch.stop();

        // Should take at least 500ms due to simulated delay
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(450));
      });
    });

    group('getCreditScoreChart', () {
      test('should return successful credit score chart data', () async {
        final result = await repository.getCreditScoreChart();

        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected right side'),
          (chart) {
            expect(chart, isA<CreditScoreChart>());
            expect(chart.dataPoints.length, equals(7));
            expect(chart.period, equals('Last 12 months'));
            expect(chart.calculationMethod, contains('VantageScore 3.0'));
            expect(chart.minY, equals(650.0));
            expect(chart.maxY, equals(720.0));
            
            // Verify data points are chronological
            final scores = chart.dataPoints.map((p) => p.score).toList();
            expect(scores, equals([650, 660, 670, 685, 690, 705, 720]));
          },
        );
      });

      test('should have properly calculated min and max values', () async {
        final result = await repository.getCreditScoreChart();

        result.fold(
          (_) => fail('Expected right side'),
          (chart) {
            final scores = chart.dataPoints.map((p) => p.score).toList();
            final expectedMin = scores.reduce((a, b) => a < b ? a : b).toDouble();
            final expectedMax = scores.reduce((a, b) => a > b ? a : b).toDouble();
            
            expect(chart.minY, equals(expectedMin));
            expect(chart.maxY, equals(expectedMax));
          },
        );
      });

      test('should simulate shorter network delay than getCreditScore', () async {
        final stopwatch = Stopwatch()..start();
        await repository.getCreditScoreChart();
        stopwatch.stop();

        // Should take at least 300ms but less than getCreditScore's 500ms
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(250));
        expect(stopwatch.elapsedMilliseconds, lessThan(450));
      });
    });

    group('refreshCreditScore', () {
      test('should return successful refresh', () async {
        final result = await repository.refreshCreditScore();

        expect(result.isRight(), isTrue);
        result.fold(
          (_) => fail('Expected right side'),
          (_) {
            // Refresh completed successfully (void return)
            expect(true, isTrue);
          },
        );
      });

      test('should simulate longest network delay for refresh', () async {
        final stopwatch = Stopwatch()..start();
        await repository.refreshCreditScore();
        stopwatch.stop();

        // Should take at least 1000ms due to simulated refresh delay
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(950));
      });
    });

    group('Error Scenarios', () {
      test('should handle data consistency across calls', () async {
        final result1 = await repository.getCreditScore();
        final result2 = await repository.getCreditScore();

        // Mock returns consistent data
        expect(result1.isRight(), isTrue);
        expect(result2.isRight(), isTrue);

        final score1 = result1.getOrElse(() => throw Exception());
        final score2 = result2.getOrElse(() => throw Exception());

        expect(score1.score, equals(score2.score));
        expect(score1.status, equals(score2.status));
      });
    });
  });
}