enum UserType { customer, vendor, admin }
enum VerificationStatus { pending, verified, rejected }
enum HotelStar { one, two, three, four, five }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserType userType;
  VerificationStatus verificationStatus;
  final DateTime registrationDate;
  String? profileImage;
  String? hotelName;
  HotelStar? hotelStar;
  int totalBookings;
  bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.verificationStatus,
    required this.registrationDate,
    this.profileImage,
    this.hotelName,
    this.hotelStar,
    this.totalBookings = 0,
    this.isActive = true,
  });


  static List<UserModel> demoCustomers() {
    return [
      UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+1234567890',
        userType: UserType.customer,
        verificationStatus: VerificationStatus.verified,
        registrationDate: DateTime.now().subtract(const Duration(days: 30)),
        totalBookings: 12,
      ),
      UserModel(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        phone: '+1234567891',
        userType: UserType.customer,
        verificationStatus: VerificationStatus.pending,
        registrationDate: DateTime.now().subtract(const Duration(days: 2)),
        totalBookings: 0,
      ),
    ];
  }

  static List<UserModel> demoVendors() {
    return [
      UserModel(
        id: '3',
        name: 'Grand Hotel',
        email: 'contact@grandhotel.com',
        phone: '+1234567892',
        userType: UserType.vendor,
        verificationStatus: VerificationStatus.verified,
        registrationDate: DateTime.now().subtract(const Duration(days: 60)),
        hotelName: 'Grand Hotel',
        hotelStar: HotelStar.five,
        totalBookings: 245,
      ),
      UserModel(
        id: '4',
        name: 'City Inn',
        email: 'info@cityinn.com',
        phone: '+1234567893',
        userType: UserType.vendor,
        verificationStatus: VerificationStatus.pending,
        registrationDate: DateTime.now().subtract(const Duration(days: 5)),
        hotelName: 'City Inn',
        hotelStar: HotelStar.three,
        totalBookings: 0,
      ),
      UserModel(
        id: '5',
        name: 'Beach Resort',
        email: 'reservations@beachresort.com',
        phone: '+1234567894',
        userType: UserType.vendor,
        verificationStatus: VerificationStatus.rejected,
        registrationDate: DateTime.now().subtract(const Duration(days: 10)),
        hotelName: 'Beach Resort',
        hotelStar: HotelStar.four,
        totalBookings: 0,
      ),
    ];
  }

  static List<UserModel> demoAdmins() {
    return [
      UserModel(
        id: '6',
        name: 'Admin User',
        email: 'admin@hotelbooking.com',
        phone: '+1234567895',
        userType: UserType.admin,
        verificationStatus: VerificationStatus.verified,
        registrationDate: DateTime.now().subtract(const Duration(days: 365)),
        totalBookings: 0,
      ),
    ];
  }
}

// Extension for HotelStar
extension HotelStarExtension on HotelStar {
  String get displayName {
    switch (this) {
      case HotelStar.one:
        return '1 Star';
      case HotelStar.two:
        return '2 Star';
      case HotelStar.three:
        return '3 Star';
      case HotelStar.four:
        return '4 Star';
      case HotelStar.five:
        return '5 Star';
    }
  }

  int get value {
    switch (this) {
      case HotelStar.one:
        return 1;
      case HotelStar.two:
        return 2;
      case HotelStar.three:
        return 3;
      case HotelStar.four:
        return 4;
      case HotelStar.five:
        return 5;
    }
  }

  static HotelStar fromValue(int value) {
    switch (value) {
      case 1:
        return HotelStar.one;
      case 2:
        return HotelStar.two;
      case 3:
        return HotelStar.three;
      case 4:
        return HotelStar.four;
      case 5:
        return HotelStar.five;
      default:
        return HotelStar.three;
    }
  }
}