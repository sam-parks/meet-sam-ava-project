import 'package:flutter/material.dart';
import 'package:meet_sam_ava/core/failures/failure.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/features/home/view/widgets/account_details_card.dart';
import 'package:meet_sam_ava/features/home/view/widgets/credit_card_accounts_card.dart';
import 'package:meet_sam_ava/features/home/view/widgets/credit_factors_card.dart';
import 'package:meet_sam_ava/features/home/view/widgets/credit_score_chart_card.dart';
import 'package:meet_sam_ava/features/home/vm/home_view_model.dart';

class HomeContentWidget extends StatelessWidget {
  final HomeState homeState;

  const HomeContentWidget({
    required this.homeState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Chart section
        homeState.creditScoreChart.fold(
          (failure) => ErrorStateWidget(failure: failure),
          (creditScoreChart) => homeState.creditScore.fold(
            (failure) => ErrorStateWidget(failure: failure),
            (creditScore) => Column(
              children: [
                const SizedBox(
                  height: SpacingTokens.space4,
                ),
                CreditScoreChartCard(
                  creditScore: creditScore,
                  creditScoreChart: creditScoreChart,
                ),
                const SizedBox(height: SpacingTokens.space8),
              ],
            ),
          ),
        ),

        // Credit factors section
        homeState.creditFactors.fold(
          (failure) => ErrorStateWidget(failure: failure),
          (creditFactors) => Column(
            children: [
              CreditFactorsCard(creditFactors: creditFactors),
              const SizedBox(height: SpacingTokens.space8),
            ],
          ),
        ),

        // Account details section
        homeState.accountDetails.fold(
          (failure) => ErrorStateWidget(failure: failure),
          (accountDetails) => Column(
            children: [
              AccountDetailsCard(
                accountDetails: accountDetails,
                utilizationPercentage: homeState.utilizationPercentage,
              ),
              const SizedBox(height: SpacingTokens.space8),
            ],
          ),
        ),

        // Credit card accounts section
        homeState.creditCardAccounts.fold(
          (failure) => ErrorStateWidget(failure: failure),
          (creditCardAccounts) => CreditCardAccountsCard(
            creditCardAccounts: creditCardAccounts,
          ),
        ),
      ],
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final Failure failure;

  const ErrorStateWidget({
    required this.failure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (failure is NotInitializedFailure) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: SpacingTokens.space4),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space4),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: SpacingTokens.space2),
            Expanded(
              child: Text(
                failure.message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
