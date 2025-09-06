import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meet_sam_ava/features/home/model/credit_score_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_factors_model.dart';
import 'package:meet_sam_ava/features/home/model/account_details_model.dart';
import 'package:meet_sam_ava/features/home/model/credit_card_accounts_model.dart';
import 'package:meet_sam_ava/features/home/repositories/providers/repository_providers.dart';

part 'home_view_model.g.dart';

class HomeState {
  final CreditScore? creditScore;
  final CreditScoreChart? creditScoreChart;
  final CreditFactors? creditFactors;
  final AccountDetails? accountDetails;
  final CreditCardAccounts? creditCardAccounts;
  final String? errorMessage;

  const HomeState({
    this.creditScore,
    this.creditScoreChart,
    this.creditFactors,
    this.accountDetails,
    this.creditCardAccounts,
    this.errorMessage,
  });

  HomeState copyWith({
    CreditScore? creditScore,
    CreditScoreChart? creditScoreChart,
    CreditFactors? creditFactors,
    AccountDetails? accountDetails,
    CreditCardAccounts? creditCardAccounts,
    String? errorMessage,
  }) {
    return HomeState(
      creditScore: creditScore ?? this.creditScore,
      creditScoreChart: creditScoreChart ?? this.creditScoreChart,
      creditFactors: creditFactors ?? this.creditFactors,
      accountDetails: accountDetails ?? this.accountDetails,
      creditCardAccounts: creditCardAccounts ?? this.creditCardAccounts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@Riverpod(keepAlive: true)
class HomeViewModel extends _$HomeViewModel {
  final defaultState = const HomeState();

  @override
  FutureOr<HomeState> build() async {
    return loadData();
  }

  FutureOr<HomeState> loadData() async {
    try {
      final results = await Future.wait([
        ref.read(creditScoreRepositoryProvider).getCreditScore(),
        ref.read(creditScoreRepositoryProvider).getCreditScoreChart(),
        ref.read(creditFactorsRepositoryProvider).getCreditFactors(),
        ref.read(accountDetailsRepositoryProvider).getAccountDetails(),
        ref.read(creditCardAccountsRepositoryProvider).getCreditCardAccounts(),
      ]);

      CreditScore? creditScore;
      CreditScoreChart? creditScoreChart;
      CreditFactors? creditFactors;
      AccountDetails? accountDetails;
      CreditCardAccounts? creditCardAccounts;

      results[0].fold(
        (error) => throw Exception('Credit score error: $error'),
        (data) => creditScore = data as CreditScore,
      );

      results[1].fold(
        (error) => throw Exception('Credit score chart error: $error'),
        (data) => creditScoreChart = data as CreditScoreChart,
      );

      results[2].fold(
        (error) => throw Exception('Credit factors error: $error'),
        (data) => creditFactors = data as CreditFactors,
      );

      results[3].fold(
        (error) => throw Exception('Account details error: $error'),
        (data) => accountDetails = data as AccountDetails,
      );

      results[4].fold(
        (error) => throw Exception('Credit card accounts error: $error'),
        (data) => creditCardAccounts = data as CreditCardAccounts,
      );

      return defaultState.copyWith(
        creditScore: creditScore,
        creditScoreChart: creditScoreChart,
        creditFactors: creditFactors,
        accountDetails: accountDetails,
        creditCardAccounts: creditCardAccounts,
      );
    } catch (e) {
      return defaultState.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    final newState = await loadData();
    state = AsyncData(newState);
  }
}
