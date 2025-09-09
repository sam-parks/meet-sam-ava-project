import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/core/failures/failure.dart';
import 'package:meet_sam_ava/features/home/vm/home_view_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';

void main() {
  group('HomeViewModel Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('HomeState', () {
      test('should create initial state with all failures', () {
        final state = HomeState.initial();
        
        expect(state.creditScore.isLeft(), isTrue);
        expect(state.creditScoreChart.isLeft(), isTrue);
        expect(state.creditFactors.isLeft(), isTrue);
        expect(state.accountDetails.isLeft(), isTrue);
        expect(state.creditCardAccounts.isLeft(), isTrue);
        
        state.creditScore.fold(
          (failure) => expect(failure, isA<NotInitializedFailure>()),
          (_) => fail('Expected left side'),
        );
      });

      test('should calculate utilization percentage correctly', () {
        final state = HomeState.initial().copyWith(
          accountDetails: right(const AccountDetails(
            spendLimitValue: 0,
            balanceValue: 5000,
            creditLimitValue: 25000,
            totalBalanceValue: 5000,
            totalLimitValue: 25000,
            currentSpend: 0,
            ratingLabel: 'Good',
          )),
        );

        expect(state.utilizationPercentage, equals(20.0));
      });

      test('should return 0 utilization when account details are failure', () {
        final state = HomeState.initial();
        expect(state.utilizationPercentage, equals(0.0));
      });

      test('should return 0 utilization when total limit is 0', () {
        final state = HomeState.initial().copyWith(
          accountDetails: right(const AccountDetails(
            spendLimitValue: 0,
            balanceValue: 5000,
            creditLimitValue: 0,
            totalBalanceValue: 5000,
            totalLimitValue: 0,
            currentSpend: 0,
            ratingLabel: 'Good',
          )),
        );

        expect(state.utilizationPercentage, equals(0.0));
      });

      test('should clamp utilization percentage to 100', () {
        final state = HomeState.initial().copyWith(
          accountDetails: right(const AccountDetails(
            spendLimitValue: 0,
            balanceValue: 15000,
            creditLimitValue: 10000,
            totalBalanceValue: 15000,
            totalLimitValue: 10000,
            currentSpend: 0,
            ratingLabel: 'Poor',
          )),
        );

        expect(state.utilizationPercentage, equals(100.0));
      });

      test('should copy with new values correctly', () {
        final initialState = HomeState.initial();
        final creditScore = const CreditScore(
          score: 750,
          change: '+10',
          status: 'Good',
          lastUpdated: '2024-01-01',
          nextUpdate: '2024-02-01',
          provider: 'Test Provider',
        );

        final newState = initialState.copyWith(
          creditScore: right(creditScore),
        );

        expect(newState.creditScore.isRight(), isTrue);
        newState.creditScore.fold(
          (_) => fail('Expected right side'),
          (score) => expect(score.score, equals(750)),
        );
        
        // Other properties should remain unchanged
        expect(newState.creditScoreChart.isLeft(), isTrue);
      });
    });
  });
}