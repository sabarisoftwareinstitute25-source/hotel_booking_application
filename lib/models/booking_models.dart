class Booking {
  final String id;
  final String userId;
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final String status;
  final double totalPrice;
  final String? createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
    required this.totalPrice,
    this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    // Handle nested user and hotel objects
    String userId = '';
    if (json['user'] != null) {
      if (json['user'] is Map) {
        userId = json['user']['id'] ?? '';
      } else if (json['user'] is String) {
        userId = json['user'];
      }
    }
    userId = userId.isEmpty ? (json['userId'] ?? '') : userId;

    String hotelId = '';
    if (json['hotel'] != null) {
      if (json['hotel'] is Map) {
        hotelId = json['hotel']['id'] ?? '';
      } else if (json['hotel'] is String) {
        hotelId = json['hotel'];
      }
    }
    hotelId = hotelId.isEmpty ? (json['hotelId'] ?? '') : hotelId;

    return Booking(
      id: json['id'] ?? '',
      userId: userId,
      hotelId: hotelId,
      checkInDate: json['checkInDate'] ?? '',
      checkOutDate: json['checkOutDate'] ?? '',
      status: json['status'] ?? 'PENDING',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'hotelId': hotelId,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'status': status,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
    };
  }
}

class BookingRequest {
  final String userId;
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final double totalPrice;

  BookingRequest({
    required this.userId,
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    // Backend expects nested user and hotel objects with id field
    return {
      'user': {'id': userId},
      'hotel': {'id': hotelId},
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'totalPrice': totalPrice,
      'status': 'PENDING',
    };
  }
}

