import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:meet_sam_ava/core/failures/failure.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';
import 'package:meet_sam_ava/features/home/repositories/providers/repository_providers.dart';

part 'home_view_model.g.dart';

class HomeState {
  final Either<Failure, CreditScore> creditScore;
  final Either<Failure, CreditScoreChart> creditScoreChart;
  final Either<Failure, CreditFactors> creditFactors;
  final Either<Failure, AccountDetails> accountDetails;
  final Either<Failure, CreditCardAccounts> creditCardAccounts;

  const HomeState({
    required this.creditScore,
    required this.creditScoreChart,
    required this.creditFactors,
    required this.accountDetails,
    required this.creditCardAccounts,
  });

  // Clean initial state
  factory HomeState.initial() => HomeState(
        creditScore: left(const NotInitializedFailure(
            message: 'Not initialized credit score...')),
        creditScoreChart: left(const NotInitializedFailure(
            message: 'Not initialized credit history...')),
        creditFactors: left(const NotInitializedFailure(
            message: 'Not initialized credit factors...')),
        accountDetails: left(const NotInitializedFailure(
            message: 'Not initialized account details...')),
        creditCardAccounts: left(const NotInitializedFailure(
            message: 'Not initialized credit cards...')),
      );

  double get utilizationPercentage {
    return accountDetails.fold(
      (failure) => 0.0,
      (details) {
        if (details.totalLimitValue <= 0) return 0.0;
        final percentage =
            (details.totalBalanceValue / details.totalLimitValue) * 100;
        return percentage.clamp(0.0, 100.0).roundToDouble();
      },
    );
  }

  HomeState copyWith({
    Either<Failure, CreditScore>? creditScore,
    Either<Failure, CreditScoreChart>? creditScoreChart,
    Either<Failure, CreditFactors>? creditFactors,
    Either<Failure, AccountDetails>? accountDetails,
    Either<Failure, CreditCardAccounts>? creditCardAccounts,
  }) {
    return HomeState(
      creditScore: creditScore ?? this.creditScore,
      creditScoreChart: creditScoreChart ?? this.creditScoreChart,
      creditFactors: creditFactors ?? this.creditFactors,
      accountDetails: accountDetails ?? this.accountDetails,
      creditCardAccounts: creditCardAccounts ?? this.creditCardAccounts,
    );
  }
}

@Riverpod(keepAlive: true)
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<HomeState> build() async {
    return loadData();
  }

  FutureOr<HomeState> loadData() async {
    final results = await Future.wait([
      ref.read(creditScoreRepositoryProvider).getCreditScore(),
      ref.read(creditScoreRepositoryProvider).getCreditScoreChart(),
      ref.read(creditFactorsRepositoryProvider).getCreditFactors(),
      ref.read(accountDetailsRepositoryProvider).getAccountDetails(),
      ref.read(creditCardAccountsRepositoryProvider).getCreditCardAccounts(),
    ]);

    return HomeState(
      creditScore: results[0].fold(
        (error) => left(
            NetworkFailure(message: 'Failed to load credit score: $error')),
        (data) => right(data as CreditScore),
      ),
      creditScoreChart: results[1].fold(
        (error) => left(
            NetworkFailure(message: 'Failed to load credit history: $error')),
        (data) => right(data as CreditScoreChart),
      ),
      creditFactors: results[2].fold(
        (error) => left(
            NetworkFailure(message: 'Failed to load credit factors: $error')),
        (data) => right(data as CreditFactors),
      ),
      accountDetails: results[3].fold(
        (error) => left(
            NetworkFailure(message: 'Failed to load account details: $error')),
        (data) => right(data as AccountDetails),
      ),
      creditCardAccounts: results[4].fold(
        (error) => left(
            NetworkFailure(message: 'Failed to load credit cards: $error')),
        (data) => right(data as CreditCardAccounts),
      ),
    );
  }

  Future<void> refresh() async {
    final newState = await loadData();
    state = AsyncData(newState);
  }
}
