class Hotel {
  final String id;
  final String name;
  final String address;
  final String city;
  final String country;
  final int starRating;
  final String? createdAt;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.starRating,
    this.createdAt,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      starRating: json['starRating'] ?? 0,
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'country': country,
      'starRating': starRating,
      'createdAt': createdAt,
    };
  }
}

class Room {
  final int? id;
  final String hotelId;
  final String roomNumber;
  final String roomType;
  final double pricePerNight;
  final String? description;
  final bool available;

  Room({
    this.id,
    required this.hotelId,
    required this.roomNumber,
    required this.roomType,
    required this.pricePerNight,
    this.description,
    required this.available,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    // Handle nested hotel object
    String hotelId = '';
    if (json['hotel'] != null) {
      if (json['hotel'] is Map) {
        hotelId = json['hotel']['id'] ?? '';
      } else if (json['hotel'] is String) {
        hotelId = json['hotel'];
      }
    }
    hotelId = hotelId.isEmpty ? (json['hotelId'] ?? '') : hotelId;

    return Room(
      id: json['id'],
      hotelId: hotelId,
      roomNumber: json['roomNumber'] ?? '',
      roomType: json['roomType'] ?? '',
      pricePerNight: (json['pricePerNight'] ?? 0).toDouble(),
      description: json['description'],
      available: json['available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotelId': hotelId,
      'roomNumber': roomNumber,
      'roomType': roomType,
      'pricePerNight': pricePerNight,
      'description': description,
      'available': available,
    };
  }
}

