import 'package:meet_sam_ava/features/feedback/repositories/interfaces/feedback_repository.dart';
import 'package:meet_sam_ava/features/feedback/repositories/implementations/mock_feedback_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
FeedbackRepository feedbackRepository(Ref ref) {
  return MockFeedbackRepository();
}
