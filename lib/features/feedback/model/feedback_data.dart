class FeedbackData {
  final String message;
  final DateTime timestamp;

  const FeedbackData({
    required this.message,
    required this.timestamp,
  });

  factory FeedbackData.empty() => FeedbackData(
        message: '',
        timestamp: DateTime.now(),
      );

  FeedbackData copyWith({
    String? message,
    DateTime? timestamp,
  }) {
    return FeedbackData(
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}