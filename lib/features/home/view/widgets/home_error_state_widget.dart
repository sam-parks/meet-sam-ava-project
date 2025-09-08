import 'package:flutter/material.dart';
import 'package:meet_sam_ava/features/home/vm/home_view_model.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';

class HomeErrorStateWidget extends StatelessWidget {
  final String? errorMessage;
  final HomeViewModel viewModel;

  const HomeErrorStateWidget({
    required this.errorMessage,
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: SpacingTokens.space4),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: SpacingTokens.space2),
            Text(
              errorMessage ?? 'An unknown error occurred',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpacingTokens.space4),
            ElevatedButton(
              onPressed: () => viewModel.refresh(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
