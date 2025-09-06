import 'package:flutter/material.dart';
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
        if (homeState.creditScoreChart != null && homeState.creditScore != null)
          CreditScoreChartCard(
            creditScore: homeState.creditScore!,
            creditScoreChart: homeState.creditScoreChart!,
          ),
        const SizedBox(height: SpacingTokens.space8),

        // Credit factors section
        if (homeState.creditFactors != null)
          CreditFactorsCard(creditFactors: homeState.creditFactors),
        const SizedBox(height: SpacingTokens.space8),

        // Account details section
        if (homeState.accountDetails != null)
          AccountDetailsCard(accountDetails: homeState.accountDetails),
        const SizedBox(height: SpacingTokens.space8),

        // Credit card accounts section
        if (homeState.creditCardAccounts != null)
          CreditCardAccountsCard(
              creditCardAccounts: homeState.creditCardAccounts),
      ],
    );
  }
}
