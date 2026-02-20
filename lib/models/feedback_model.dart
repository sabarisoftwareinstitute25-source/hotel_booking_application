// feedback_model.dart
class FeedbackModel {
  final String id;
  final String customerName;
  final String customerPhone;
  final String bookingId;
  final String hotelName;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;
  final bool isAnonymous;

  FeedbackModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.bookingId,
    required this.hotelName,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
    this.isAnonymous = false,
  });
}

// Simple storage class
class FeedbackStorage {
  static List<FeedbackModel> _feedbacks = [];

  static List<FeedbackModel> get feedbacks => _feedbacks;

  static void addFeedback(FeedbackModel feedback) {
    _feedbacks.insert(0, feedback);
  }

  static void clear() {
    _feedbacks.clear();
  }

  // Add some sample data for testing
  static void addSampleData() {
    if (_feedbacks.isEmpty) {
      _feedbacks.addAll([
        FeedbackModel(
          id: 'FB001',
          customerName: 'John Doe',
          customerPhone: '+91 9942523910',
          bookingId: 'BK001',
          hotelName: 'Grand Hotel Plaza',
          rating: 5,
          comment: 'Excellent service and amazing experience! The staff was very helpful and the room was spotless.',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        FeedbackModel(
          id: 'FB002',
          customerName: 'Robert Wilson',
          customerPhone: '+1 234 567 894',
          bookingId: 'BK005',
          hotelName: 'Business Hotel',
          rating: 4,
          comment: 'Great location and comfortable rooms. Would definitely recommend.',
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
        FeedbackModel(
          id: 'FB003',
          customerName: 'Alice Johnson',
          customerPhone: '+1 234 567 895',
          bookingId: 'BK006',
          hotelName: 'Ocean View Resort',
          rating: 5,
          comment: 'Beautiful view and wonderful amenities. The food was delicious!',
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
      ]);
    }
  }
}