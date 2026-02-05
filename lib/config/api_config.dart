class ApiConfig {
  // Base URL for your backend API
  // For Android Emulator: use http://10.0.2.2:8080
  // For Android Physical Device: use http://YOUR_COMPUTER_IP:8080 (e.g., http://192.168.1.100:8080)
  // For iOS Simulator: use http://localhost:8080
  // For production: use https://api.yourdomain.com
  static const String baseUrl = 'http://10.0.2.2:8080'; // Android Emulator default
  
  // API endpoints
  static const String login = '/api/auth/login';
  static const String signup = '/api/auth/signup';
  static const String forgotPassword = '/api/auth/forgot-password';
  static const String resetPassword = '/api/auth/reset-password';
  static const String verifyOtp = '/api/auth/verify-otp';
  static const String resendOtp = '/api/auth/resend-otp';
  
  // Phone-based OTP endpoints
  static const String sendVerificationCode = '/api/auth/send-verification-code';
  static const String verifyPhoneOtp = '/api/auth/verify-phone-otp';
  static const String completeSignup = '/api/auth/complete-signup';
  static const String resendPhoneOtp = '/api/auth/resend-phone-otp';
  
  // Hotel endpoints
  static const String searchHotels = '/api/hotels/search';
  static const String getHotelDetails = '/api/hotels';
  static const String getHotelRooms = '/api/hotels/rooms';
  static const String registerVendor = '/api/hotels/vendor/register';
  static const String getVendorProfile = '/api/hotels/vendor/profile';
  static const String saveAccountDetails = '/api/hotels/vendor/account-details';
  static const String getValidationRules = '/api/hotels/vendor/validation-rules';
  static const String checkAccountExists = '/api/hotels/vendor/check-account';
  
  // Booking endpoints
  static const String createBooking = '/api/bookings';
  static const String getBookings = '/api/bookings';
  static const String cancelBooking = '/api/bookings/cancel';
  
  // Payment endpoints
  static const String processPayment = '/api/payments/process';
  static const String getPaymentStatus = '/api/payments/status';
  
  // Timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Headers
  static Map<String, String> getHeaders({String? token}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
}

