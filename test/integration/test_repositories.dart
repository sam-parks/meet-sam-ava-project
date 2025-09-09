import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_score_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_factors_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/account_details_repository.dart';
import 'package:meet_sam_ava/features/home/repositories/interfaces/credit_card_accounts_repository.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';

/// Test-only credit score repository without delays
class TestCreditScoreRepository implements ICreditScoreRepository {
  @override
  Future<Either<String, CreditScore>> getCreditScore() async {
    // No delay for testing
    return right(const CreditScore(
      score: 720,
      change: '+2pts',
      status: 'Good',
      lastUpdated: 'Updated Today',
      nextUpdate: 'Next May 12',
      provider: 'Experian',
    ));
  }

  @override
  Future<Either<String, CreditScoreChart>> getCreditScoreChart() async {
    // No delay for testing
    final dataPoints = [
      CreditScoreDataPoint(date: DateTime(2023, 1, 1), score: 650),
      CreditScoreDataPoint(date: DateTime(2023, 6, 1), score: 680),
      CreditScoreDataPoint(date: DateTime(2023, 12, 1), score: 720),
    ];

    return right(CreditScoreChart(
      dataPoints: dataPoints,
      period: 'Last 12 months',
      calculationMethod: 'Test calculation',
      minY: 650,
      maxY: 720,
    ));
  }

  @override
  Future<Either<String, void>> refreshCreditScore() async {
    // No delay for testing
    return right(null);
  }
}

/// Test-only credit factors repository without delays
class TestCreditFactorsRepository implements ICreditFactorsRepository {
  @override
  Future<Either<String, CreditFactors>> getCreditFactors() async {
    // No delay for testing
    return right(const CreditFactors(
      factors: [
        CreditFactor(
          name: 'Payment History',
          percentage: '85%',
          impact: CreditFactorImpact.high,
          description: 'Good payment history',
        ),
        CreditFactor(
          name: 'Credit Utilization',
          percentage: '30%',
          impact: CreditFactorImpact.medium,
          description: 'Moderate utilization',
        ),
      ],
    ));
  }

  @override
  Future<Either<String, void>> refreshCreditFactors() async {
    return right(null);
  }
}

/// Test-only account details repository without delays
class TestAccountDetailsRepository implements IAccountDetailsRepository {
  @override
  Future<Either<String, AccountDetails>> getAccountDetails() async {
    // No delay for testing
    return right(const AccountDetails(
      spendLimitValue: 0,
      balanceValue: 5000,
      creditLimitValue: 25000,
      totalBalanceValue: 5000,
      totalLimitValue: 25000,
      currentSpend: 0,
      ratingLabel: 'Good',
    ));
  }

  @override
  Future<Either<String, void>> refreshAccountDetails() async {
    return right(null);
  }
}

/// Test-only credit card accounts repository without delays
class TestCreditCardAccountsRepository implements ICreditCardAccountsRepository {
  @override
  Future<Either<String, CreditCardAccounts>> getCreditCardAccounts() async {
    // No delay for testing
    return right(const CreditCardAccounts(
      accounts: [
        CreditCardAccount(
          provider: 'Chase',
          balanceValue: 1500,
          creditLimitValue: 10000,
          reportedDate: '2024-01-01',
        ),
        CreditCardAccount(
          provider: 'Capital One',
          balanceValue: 3500,
          creditLimitValue: 15000,
          reportedDate: '2024-01-01',
        ),
      ],
    ));
  }

  @override
  Future<Either<String, void>> refreshCreditCardAccounts() async {
    return right(null);
  }
}