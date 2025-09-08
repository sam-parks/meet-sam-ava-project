import 'package:meet_sam_ava/features/feedback/model/feedback_data.dart';
import 'package:meet_sam_ava/features/feedback/repositories/interfaces/feedback_repository.dart';

class MockFeedbackRepository implements FeedbackRepository {
  @override
  Future<bool> submitFeedback(FeedbackData feedback) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // Simulate occasional failure (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      throw Exception('Network error: Failed to submit feedback');
    }

    // Mock successful submission
    return true;
  }
}
