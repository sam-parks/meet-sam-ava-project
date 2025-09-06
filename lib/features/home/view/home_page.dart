import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_sam_ava/app_router.dart';
import 'package:meet_sam_ava/features/home/vm/home_view_model.dart';
import 'package:meet_sam_ava/features/home/view/widgets/credit_score_card.dart';
import 'package:meet_sam_ava/features/home/view/widgets/loading_state_widget.dart';
import 'package:meet_sam_ava/features/home/view/widgets/error_state_widget.dart';
import 'package:meet_sam_ava/features/home/view/widgets/home_content_widget.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            context.router.push(const EmploymentInfoRoute());
          },
        ),
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        centerTitle: true,
      ),
      body: switch (homeState) {
        AsyncData(:final value) => RefreshIndicator(
            onRefresh: () => viewModel.refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Credit score header that scrolls behind app bar but doesn't stretch on refresh
                if (value.creditScore != null)
                  SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: _CreditScoreHeaderDelegate(
                      creditScore: value.creditScore!,
                      colorScheme: Theme.of(context).colorScheme,
                    ),
                  ),

                // Main content
                value.errorMessage != null
                    ? SliverToBoxAdapter(
                        child: ErrorStateWidget(
                          errorMessage: value.errorMessage,
                          viewModel: viewModel,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: SpacingTokens.space4,
                            right: SpacingTokens.space4,
                            bottom: SpacingTokens.space4,
                            top: SpacingTokens.space4,
                          ),
                          child: HomeContentWidget(homeState: value),
                        ),
                      ),
              ],
            ),
          ),
        AsyncError(:final error) => ErrorStateWidget(
            errorMessage: error.toString(),
            viewModel: viewModel,
          ),
        AsyncLoading() => const LoadingStateWidget(),
      },
    );
  }
}

class _CreditScoreHeaderDelegate extends SliverPersistentHeaderDelegate {
  final dynamic creditScore;
  final ColorScheme colorScheme;

  _CreditScoreHeaderDelegate({
    required this.creditScore,
    required this.colorScheme,
  });

  @override
  double get minExtent => 160;

  @override
  double get maxExtent => 160;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(RadiusTokens.xxl),
          bottomRight: Radius.circular(RadiusTokens.xxl),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space4),
        child: CreditScoreCard(creditScore: creditScore),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CreditScoreHeaderDelegate oldDelegate) {
    return creditScore != oldDelegate.creditScore;
  }
}
