import 'package:meet_sam_ava/features/feedback/model/feedback_data.dart';

abstract class FeedbackRepository {
  Future<bool> submitFeedback(FeedbackData feedback);
}
