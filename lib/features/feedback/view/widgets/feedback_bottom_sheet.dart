import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:meet_sam_ava/core/theme/tokens/spacing_tokens.dart';
import 'package:meet_sam_ava/features/feedback/vm/feedback_view_model.dart';

class FeedbackBottomSheet extends ConsumerWidget {
  const FeedbackBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(feedbackViewModelProvider);
    final viewModel = ref.read(feedbackViewModelProvider.notifier);

    return Container(
      padding: EdgeInsets.only(
        left: SpacingTokens.space4,
        right: SpacingTokens.space4,
        top: SpacingTokens.space4,
        bottom: MediaQuery.of(context).viewInsets.bottom + SpacingTokens.space4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            'Give us feedback',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: SpacingTokens.space6),

          // Feedback text field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              initialValue: state.message,
              onChanged: viewModel.onMessageChanged,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: 'Tell us about your experience...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(SpacingTokens.space2),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

          const SizedBox(height: SpacingTokens.space6),

          // Send feedback button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: state.status == FormzSubmissionStatus.inProgress || !state.isValid
                  ? null
                  : () async {
                      final success = await viewModel.submit();
                      if (context.mounted) {
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Thank you for your feedback!'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.inverseSurface,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else if (state.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error!),
                              backgroundColor: Theme.of(context).colorScheme.error,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: state.status == FormzSubmissionStatus.inProgress
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Send feedback',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
            ),
          ),
          const SizedBox(height: SpacingTokens.space4),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const FeedbackBottomSheet(),
      ),
    );
  }
}
