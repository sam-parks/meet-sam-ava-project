import 'package:formz/formz.dart';
import 'package:meet_sam_ava/features/feedback/model/feedback_data.dart';
import 'package:meet_sam_ava/features/feedback/repositories/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_view_model.g.dart';

class FeedbackState {
  final String message;
  final FormzSubmissionStatus status;
  final String? error;
  final bool isVisible;

  const FeedbackState({
    this.message = '',
    this.status = FormzSubmissionStatus.initial,
    this.error,
    this.isVisible = false,
  });

  bool get isValid => message.trim().isNotEmpty;

  FeedbackData get feedbackData => FeedbackData(
        message: message.trim(),
        timestamp: DateTime.now(),
      );

  FeedbackState copyWith({
    String? message,
    FormzSubmissionStatus? status,
    String? error,
    bool? isVisible,
  }) {
    return FeedbackState(
      message: message ?? this.message,
      status: status ?? this.status,
      error: error,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

@riverpod
class FeedbackViewModel extends _$FeedbackViewModel {
  @override
  FeedbackState build() => const FeedbackState();

  void onMessageChanged(String value) {
    state = state.copyWith(message: value);
  }

  void show() {
    state = state.copyWith(
      isVisible: true,
      message:
          'It\'s been very helpful so far!', // Default message from screenshot
    );
  }

  void hide() {
    state = state.copyWith(
      isVisible: false,
      message: '',
      status: FormzSubmissionStatus.initial,
      error: null,
    );
  }

  Future<bool> submit() async {
    if (!state.isValid) return false;

    state = state.copyWith(
      status: FormzSubmissionStatus.inProgress,
      error: null,
    );

    try {
      final repository = ref.watch(feedbackRepositoryProvider);
      await repository.submitFeedback(state.feedbackData);

      state = state.copyWith(
        status: FormzSubmissionStatus.success,
      );

      // Auto-hide after successful submission with a brief delay to show success state
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (state.status == FormzSubmissionStatus.success && state.isVisible) {
          hide();
        }
      });

      return true;
    } catch (e) {
      state = state.copyWith(
        status: FormzSubmissionStatus.failure,
        error: e.toString().contains('Network error')
            ? 'Network error: Please check your connection'
            : 'Failed to send feedback. Please try again.',
      );
      return false;
    }
  }
}
