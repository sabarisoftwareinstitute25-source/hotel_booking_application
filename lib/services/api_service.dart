import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/api_response.dart';
import '../models/auth_models.dart';
import '../models/hotel_models.dart';
import '../models/booking_models.dart';
import '../models/payment_models.dart';
import '../utils/phone_utils.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _authToken;
  User? _currentUser;

  // Set authentication token
  void setAuthToken(String? token) {
    _authToken = token;
  }

  // Get authentication token
  String? get authToken => _authToken;

  // Set current user
  void setCurrentUser(User? user) {
    _currentUser = user;
  }

  // Get current user
  User? get currentUser => _currentUser;

  // Generic GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      Uri uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      print('🌐 API GET Request: ${uri.toString()}');
      print('🌐 Headers: ${ApiConfig.getHeaders(token: _authToken)}');

      final response = await http.get(
        uri,
        headers: ApiConfig.getHeaders(token: _authToken),
      ).timeout(ApiConfig.receiveTimeout);

      print('📡 API Response Status: ${response.statusCode}');
      print('📡 API Response Body (first 500 chars): ${response.body.length > 500 ? response.body.substring(0, 500) + "..." : response.body}');

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      String errorMessage = 'Network error: ${e.toString()}';
      
      // Provide more specific error messages
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'Cannot connect to server. Please check:\n1. Backend is running on port 8080\n2. Correct API URL in api_config.dart\n3. Network connection';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Server is taking too long to respond.';
      } else if (e.toString().contains('HandshakeException')) {
        errorMessage = 'SSL/TLS error. Check if using HTTPS correctly.';
      }
      
      return ApiResponse<T>(
        success: false,
        message: errorMessage,
        data: null,
      );
    }
  }

  // Generic POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint,
    Map<String, dynamic> body, {
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: ApiConfig.getHeaders(token: _authToken),
        body: jsonEncode(body),
      ).timeout(ApiConfig.receiveTimeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      String errorMessage = 'Network error: ${e.toString()}';
      
      // Provide more specific error messages
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'Cannot connect to server. Please check:\n1. Backend is running on port 8080\n2. Correct API URL in api_config.dart\n3. Network connection';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Server is taking too long to respond.';
      } else if (e.toString().contains('HandshakeException')) {
        errorMessage = 'SSL/TLS error. Check if using HTTPS correctly.';
      }
      
      return ApiResponse<T>(
        success: false,
        message: errorMessage,
        data: null,
      );
    }
  }

  // Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint,
    Map<String, dynamic> body, {
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: ApiConfig.getHeaders(token: _authToken),
        body: jsonEncode(body),
      ).timeout(ApiConfig.receiveTimeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      String errorMessage = 'Network error: ${e.toString()}';
      
      // Provide more specific error messages
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'Cannot connect to server. Please check:\n1. Backend is running on port 8080\n2. Correct API URL in api_config.dart\n3. Network connection';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Server is taking too long to respond.';
      } else if (e.toString().contains('HandshakeException')) {
        errorMessage = 'SSL/TLS error. Check if using HTTPS correctly.';
      }
      
      return ApiResponse<T>(
        success: false,
        message: errorMessage,
        data: null,
      );
    }
  }

  // Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: ApiConfig.getHeaders(token: _authToken),
      ).timeout(ApiConfig.receiveTimeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      String errorMessage = 'Network error: ${e.toString()}';
      
      // Provide more specific error messages
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'Cannot connect to server. Please check:\n1. Backend is running on port 8080\n2. Correct API URL in api_config.dart\n3. Network connection';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Server is taking too long to respond.';
      } else if (e.toString().contains('HandshakeException')) {
        errorMessage = 'SSL/TLS error. Check if using HTTPS correctly.';
      }
      
      return ApiResponse<T>(
        success: false,
        message: errorMessage,
        data: null,
      );
    }
  }

  // Handle HTTP response
  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    try {
      // Handle empty response body
      if (response.body.isEmpty || response.body.trim().isEmpty) {
        return ApiResponse<T>(
          success: response.statusCode >= 200 && response.statusCode < 300,
          message: response.statusCode >= 200 && response.statusCode < 300 
              ? 'Success' 
              : 'Request failed',
          data: null,
          statusCode: response.statusCode,
        );
      }

      dynamic jsonData;
      try {
        jsonData = jsonDecode(response.body);
      } catch (e) {
        return ApiResponse<T>(
          success: false,
          message: 'Invalid JSON response: ${e.toString()}',
          data: null,
          statusCode: response.statusCode,
        );
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        T? data;
        
        // Handle list responses (arrays)
        if (jsonData is List) {
          // For list responses, return the list directly
          return ApiResponse<T>(
            success: true,
            message: 'Success',
            data: jsonData as T,
          );
        }
        
        // Handle object responses
        if (jsonData is Map<String, dynamic>) {
          // Check if response has 'success' field (direct response format)
          bool responseSuccess = jsonData['success'] ?? true;
          
          // Try to parse from 'data' field first (if exists)
          if (fromJson != null && jsonData['data'] != null) {
            data = fromJson(jsonData['data'] as Map<String, dynamic>);
          } 
          // Otherwise parse the entire response (for login/signup direct responses)
          else if (fromJson != null) {
            data = fromJson(jsonData);
          }
          // If no fromJson provided, use entire response as data
          // This handles direct responses like VerifyOtpResponse: {success, message, verified}
          // For VendorProfileResponse, the entire object is the data (it has success, message, and all fields)
          if (data == null && jsonData is Map<String, dynamic>) {
            data = jsonData as T?;
          }

          return ApiResponse<T>(
            success: responseSuccess,
            message: jsonData['message'] ?? 'Success',
            data: data,
          );
        }
        
        // Fallback
        return ApiResponse<T>(
          success: true,
          message: 'Success',
          data: jsonData as T?,
        );
      } else {
        // Handle error responses (400, 500, etc.)
        // For ValidationErrorResponse (400), fieldErrors is at root level
        String errorMessage = 'Request failed';
        String? detailedError;
        Map<String, dynamic>? errorData;
        
        if (jsonData is Map<String, dynamic>) {
          errorMessage = jsonData['message'] ?? errorMessage;
          // Extract fieldErrors if present (ValidationErrorResponse format)
          if (jsonData.containsKey('fieldErrors')) {
            errorData = jsonData; // Store entire response as data for fieldErrors access
          }
          
          // Also check for fieldErrors in nested structure
          if (errorData == null && jsonData.containsKey('data') && jsonData['data'] is Map) {
            Map<String, dynamic> nestedData = jsonData['data'] as Map<String, dynamic>;
            if (nestedData.containsKey('fieldErrors')) {
              errorData = nestedData;
            }
          }
        }
        
        if (jsonData is Map<String, dynamic>) {
          String rawMessage = jsonData['message'] ?? 
                        jsonData['error'] ?? 
                        'Request failed with status ${response.statusCode}';
          
          // Sanitize error message to remove technical details
          errorMessage = _sanitizeErrorMessage(rawMessage);
          
          // Extract detailed validation errors if available
          if (jsonData.containsKey('errors') || jsonData.containsKey('validationErrors')) {
            var errors = jsonData['errors'] ?? jsonData['validationErrors'];
            if (errors is List) {
              detailedError = errors.map((e) => _sanitizeErrorMessage(e.toString())).join('\n');
            } else if (errors is Map) {
              detailedError = errors.entries.map((e) => '${e.key}: ${_sanitizeErrorMessage(e.value.toString())}').join('\n');
            }
          }
          
          // For ValidationErrorResponse, ensure fieldErrors is accessible
          if (jsonData.containsKey('fieldErrors') && errorData == null) {
            errorData = jsonData;
          }
          
          // Log full error response for debugging (but don't show to user)
          print('❌ Error Response (${response.statusCode}):');
          print('   Full Response: ${jsonEncode(jsonData)}');
          if (jsonData.containsKey('fieldErrors')) {
            print('   Field Errors: ${jsonData['fieldErrors']}');
          }
          if (detailedError != null) {
            print('   Validation Errors: $detailedError');
          }
        }
        
        // For ValidationErrorResponse, include fieldErrors in data
        T? errorResponseData;
        if (errorData != null && fromJson != null) {
          try {
            errorResponseData = fromJson(errorData);
          } catch (e) {
            // If fromJson fails, use errorData directly
            errorResponseData = errorData as T?;
          }
        } else if (errorData != null) {
          // No fromJson provided, use errorData directly
          errorResponseData = errorData as T?;
        }
        
        return ApiResponse<T>(
          success: false,
          message: detailedError != null ? '$errorMessage\n\n$detailedError' : errorMessage,
          data: errorResponseData,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      // Handle JSON parsing errors
      return ApiResponse<T>(
        success: false,
        message: 'Unable to process server response. Please try again.',
        data: null,
        statusCode: response.statusCode,
      );
    }
  }

  /// Sanitizes error messages to remove technical details
  String _sanitizeErrorMessage(String message) {
    if (message.isEmpty) {
      return 'An unexpected error occurred. Please try again.';
    }

    String sanitized = message;

    // Remove exception class names and package paths
    sanitized = sanitized.replaceAll(RegExp(r'[A-Z][a-zA-Z0-9]*Exception:?\s*', caseSensitive: false), '');
    sanitized = sanitized.replaceAll(RegExp(r'[A-Z][a-zA-Z0-9]*Error:?\s*', caseSensitive: false), '');
    sanitized = sanitized.replaceAll(RegExp(r'org\.|com\.|java\.|jakarta\.|springframework\.', caseSensitive: false), '');

    // Remove stack trace patterns
    sanitized = sanitized.replaceAll(RegExp(r'at\s+[a-zA-Z0-9_.]+\.', caseSensitive: false), '');
    sanitized = sanitized.replaceAll(RegExp(r'Caused by:.*', caseSensitive: false), '');
    sanitized = sanitized.replaceAll(RegExp(r'Stack trace:.*', caseSensitive: false), '');

    // Replace technical error messages with user-friendly ones
    if (sanitized.toLowerCase().contains('formatmapper') || 
        sanitized.toLowerCase().contains('json format')) {
      return 'Unable to process the request. Please try again.';
    }
    
    if (sanitized.toLowerCase().contains('failed to save') ||
        sanitized.toLowerCase().contains('database') ||
        sanitized.toLowerCase().contains('jpa') ||
        sanitized.toLowerCase().contains('hibernate')) {
      return 'Unable to save data. Please try again.';
    }
    
    if (sanitized.toLowerCase().contains('constraint') ||
        sanitized.toLowerCase().contains('violation')) {
      return 'Invalid data provided. Please check your input.';
    }

    // Clean up multiple spaces and newlines
    sanitized = sanitized.replaceAll(RegExp(r'\s+'), ' ');
    sanitized = sanitized.replaceAll(RegExp(r'\n+'), ' ');
    sanitized = sanitized.trim();

    // If message is too technical or empty after sanitization, return generic message
    if (sanitized.isEmpty || 
        sanitized.length < 10 ||
        sanitized.contains('Exception') ||
        sanitized.contains('Error') ||
        sanitized.contains('at ') ||
        sanitized.contains('Caused by')) {
      return 'An unexpected error occurred. Please try again.';
    }

    return sanitized;
  }
  
  // Helper method to handle list responses
  Future<ApiResponse<List<T>>> getList<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      Uri uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      final response = await http.get(
        uri,
        headers: ApiConfig.getHeaders(token: _authToken),
      ).timeout(ApiConfig.receiveTimeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Handle empty response
        if (response.body.isEmpty || response.body.trim().isEmpty) {
          return ApiResponse<List<T>>(
            success: true,
            message: 'No data found',
            data: [],
          );
        }
        
        dynamic jsonData;
        try {
          jsonData = jsonDecode(response.body);
        } catch (e) {
          return ApiResponse<List<T>>(
            success: false,
            message: 'Invalid JSON response: ${e.toString()}',
            data: null,
            statusCode: response.statusCode,
          );
        }
        
        if (jsonData is List) {
          final List<T> items = [];
          for (var item in jsonData) {
            try {
              if (item is Map<String, dynamic>) {
                items.add(fromJson(item));
              } else {
                print('⚠️ Skipping invalid item (not a Map): $item');
              }
            } catch (e) {
              // Log error but continue processing other items
              print('⚠️ Error parsing item: $e. Item: $item');
              // Continue to next item instead of rethrowing
            }
          }
          return ApiResponse<List<T>>(
            success: true,
            message: 'Success',
            data: items,
          );
        }
        
        // Handle empty response or null
        if (response.body.isEmpty || jsonData == null) {
          return ApiResponse<List<T>>(
            success: true,
            message: 'No data found',
            data: [],
          );
        }
        
        return ApiResponse<List<T>>(
          success: false,
          message: 'Invalid response format: expected List, got ${jsonData.runtimeType}',
          data: null,
        );
      } else {
        String errorMessage = 'Request failed with status ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData is Map<String, dynamic>) {
            errorMessage = errorData['message'] ?? errorData['error'] ?? errorMessage;
          }
        } catch (_) {
          // Use default error message
        }
        
        return ApiResponse<List<T>>(
          success: false,
          message: errorMessage,
          data: null,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      String errorMessage = 'Network error: ${e.toString()}';
      
      if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'Cannot connect to server. Please check:\n1. Backend is running on port 8080\n2. Correct API URL in api_config.dart\n3. Network connection';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Server is taking too long to respond.';
      }
      
      return ApiResponse<List<T>>(
        success: false,
        message: errorMessage,
        data: null,
      );
    }
  }

  // Authentication methods
  
  // Login
  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    return post<LoginResponse>(
      ApiConfig.login,
      request.toJson(),
      fromJson: (json) => LoginResponse.fromJson(json),
    );
  }

  // Signup
  Future<ApiResponse<SignupResponse>> signup(SignupRequest request) async {
    return post<SignupResponse>(
      ApiConfig.signup,
      request.toJson(),
      fromJson: (json) => SignupResponse.fromJson(json),
    );
  }

  // Forgot Password
  Future<ApiResponse<void>> forgotPassword(String email) async {
    return post<void>(
      ApiConfig.forgotPassword,
      {'email': email},
    );
  }

  // Reset Password
  Future<ApiResponse<void>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return post<void>(
      ApiConfig.resetPassword,
      {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
  }

  // Verify OTP
  Future<ApiResponse<void>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return post<void>(
      ApiConfig.verifyOtp,
      {
        'email': email,
        'otp': otp,
      },
    );
  }

  // Resend OTP
  Future<ApiResponse<void>> resendOtp(String email) async {
    return post<void>(
      ApiConfig.resendOtp,
      {'email': email},
    );
  }

  // Phone-based OTP methods
  
  // Send verification code (Step 1: Phone signup)
  Future<ApiResponse<Map<String, dynamic>>> sendVerificationCode({
    required String fullName,
    required String phone,
  }) async {
    // Normalize phone number to consistent format
    final normalizedPhone = PhoneUtils.normalizePhone(phone);
    
    return post<Map<String, dynamic>>(
      ApiConfig.sendVerificationCode,
      {
        'fullName': fullName,
        'phone': normalizedPhone, // Send normalized phone
      },
    );
  }

  // Verify phone OTP (Step 2: Verify OTP)
  Future<ApiResponse<Map<String, dynamic>>> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    // Normalize phone number to consistent format
    final normalizedPhone = PhoneUtils.normalizePhone(phone);
    
    return post<Map<String, dynamic>>(
      ApiConfig.verifyPhoneOtp,
      {
        'phone': normalizedPhone, // Send normalized phone
        'otp': otp,
      },
    );
  }

  // Complete signup (Step 3: Complete with email and password)
  Future<ApiResponse<SignupResponse>> completeSignup({
    required String fullName,
    required String phone,
    required String otp,
    required String email,
    required String password,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiConfig.completeSignup,
      {
        'fullName': fullName,
        'phone': phone,
        'otp': otp,
        'email': email,
        'password': password,
      },
    );

    if (response.success && response.data != null) {
      final signupResponse = SignupResponse.fromJson(response.data!);
      return ApiResponse<SignupResponse>(
        success: true,
        message: response.message,
        data: signupResponse,
      );
    }

    return ApiResponse<SignupResponse>(
      success: false,
      message: response.message,
      data: null,
    );
  }

  // Resend phone OTP
  Future<ApiResponse<Map<String, dynamic>>> resendPhoneOtp(String phone) async {
    // Normalize phone number to consistent format
    final normalizedPhone = PhoneUtils.normalizePhone(phone);
    
    return post<Map<String, dynamic>>(
      ApiConfig.resendPhoneOtp,
      {'phone': normalizedPhone}, // Send normalized phone
    );
  }

  // Hotel methods
  
  // Search hotels (supports basic filters + dates/guests)
  Future<ApiResponse<List<Hotel>>> searchHotels({
    String? city,
    String? country,
    int? starRating,
    String? location,
    String? checkIn,   // yyyy-MM-dd
    String? checkOut,  // yyyy-MM-dd
    int? rooms,
    int? adults,
    int? children,
    String? purpose,
  }) async {
    final Map<String, String> queryParams = {};
    if (city != null && city.isNotEmpty) queryParams['city'] = city;
    if (country != null && country.isNotEmpty) queryParams['country'] = country;
    if (starRating != null) queryParams['starRating'] = starRating.toString();
    if (location != null && location.isNotEmpty) queryParams['location'] = location;
    if (checkIn != null && checkIn.isNotEmpty) queryParams['checkIn'] = checkIn;
    if (checkOut != null && checkOut.isNotEmpty) queryParams['checkOut'] = checkOut;
    if (rooms != null && rooms > 0) queryParams['rooms'] = rooms.toString();
    if (adults != null && adults > 0) queryParams['adults'] = adults.toString();
    if (children != null && children >= 0) queryParams['children'] = children.toString();
    if (purpose != null && purpose.isNotEmpty) queryParams['purpose'] = purpose;
    
    print('🔍 Searching hotels with params: $queryParams');
    final response = await getList<Hotel>(
      ApiConfig.searchHotels,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      fromJson: (json) => Hotel.fromJson(json),
    );
    print('📦 Hotels response: ${response.success ? 'Success (${response.data?.length ?? 0} hotels)' : 'Failed: ${response.message}'}');
    return response;
  }

  // Get all hotels
  Future<ApiResponse<List<Hotel>>> getAllHotels() async {
    print('🏨 Fetching all hotels from: ${ApiConfig.baseUrl}${ApiConfig.getHotelDetails}');
    final response = await getList<Hotel>(
      ApiConfig.getHotelDetails,
      fromJson: (json) => Hotel.fromJson(json),
    );
    print('📦 All hotels response: ${response.success ? 'Success (${response.data?.length ?? 0} hotels)' : 'Failed: ${response.message}'}');
    return response;
  }

  // Get hotel by ID
  Future<ApiResponse<Hotel>> getHotelById(String id) async {
    return get<Hotel>(
      '${ApiConfig.getHotelDetails}/$id',
      fromJson: (json) => Hotel.fromJson(json),
    );
  }

  // Get rooms for a hotel
  Future<ApiResponse<List<Room>>> getHotelRooms(String hotelId) async {
    return getList<Room>(
      ApiConfig.getHotelRooms,
      queryParameters: {'hotelId': hotelId},
      fromJson: (json) => Room.fromJson(json),
    );
  }

  // Register hotel vendor (comprehensive 5-step form)
  Future<ApiResponse<Map<String, dynamic>>> registerVendor(Map<String, dynamic> formData) async {
    print('🏨 Registering hotel vendor with data: ${formData.keys}');
    print('📋 Request Data:');
    formData.forEach((key, value) {
      if (value is Map || value is List) {
        print('   $key: ${value.toString().substring(0, value.toString().length > 100 ? 100 : value.toString().length)}...');
      } else {
        print('   $key: $value');
      }
    });
    
    final response = await post<Map<String, dynamic>>(
      ApiConfig.registerVendor,
      formData,
    );
    
    print('📦 Vendor registration response:');
    print('   Success: ${response.success}');
    print('   Message: ${response.message}');
    print('   Status Code: ${response.statusCode}');
    if (!response.success && response.message != null) {
      print('   ❌ Error Details: ${response.message}');
    }
    
    return response;
  }

  // Get validation rules for input fields
  Future<ApiResponse<Map<String, dynamic>>> getValidationRules() async {
    print('📋 Fetching validation rules...');
    
    final response = await get<Map<String, dynamic>>(
      ApiConfig.getValidationRules,
    );
    
    if (response.success && response.data != null) {
      print('✅ Validation rules fetched successfully');
      print('   Field Rules: ${response.data!.keys}');
    } else {
      print('❌ Failed to fetch validation rules: ${response.message}');
    }
    
    return response;
  }

  // Save Account Details to vendors table
  Future<ApiResponse<Map<String, dynamic>>> saveAccountDetails({
    required String fullName,
    required String businessName,
    required String phoneOrEmail,
    String? password,
  }) async {
    print('💾 Saving account details:');
    print('   Full Name: $fullName');
    print('   Business Name: $businessName');
    print('   Phone/Email: $phoneOrEmail');
    
    final requestBody = {
      'fullName': fullName,
      'businessName': businessName,
      'phoneOrEmail': phoneOrEmail,
      if (password != null && password.isNotEmpty) 'password': password,
    };
    
    final response = await post<Map<String, dynamic>>(
      ApiConfig.saveAccountDetails,
      requestBody,
    );
    
    print('📦 Account details response:');
    print('   Success: ${response.success}');
    print('   Message: ${response.message}');
    print('   Status Code: ${response.statusCode}');
    
    // For error responses, the backend returns fieldErrors at root level
    // We need to extract it and put it in data for consistency
    if (!response.success && response.data == null) {
      // Try to parse fieldErrors from the raw response
      // The backend ValidationErrorResponse has fieldErrors at root
      print('   ⚠️ Response data is null, checking raw response...');
    }
    
    if (response.data != null) {
      print('   Vendor ID: ${response.data!['vendorId']}');
      if (response.data!['fieldErrors'] != null) {
        print('   Field Errors: ${response.data!['fieldErrors']}');
      }
    }
    if (!response.success && response.message != null) {
      print('   ❌ Error Details: ${response.message}');
    }
    
    return response;
  }

  // Check if vendor account details exist
  Future<ApiResponse<Map<String, dynamic>>> checkAccountExists(String phoneOrEmail) async {
    return get<Map<String, dynamic>>(
      ApiConfig.checkAccountExists,
      queryParameters: {'phoneOrEmail': phoneOrEmail},
    );
  }

  // Get vendor profile with statistics
  Future<ApiResponse<Map<String, dynamic>>> getVendorProfile({
    String? email,
    String? mobileNumber,
  }) async {
    Map<String, String> queryParams = {};
    if (email != null && email.isNotEmpty) {
      queryParams['email'] = email;
    }
    if (mobileNumber != null && mobileNumber.isNotEmpty) {
      queryParams['mobileNumber'] = mobileNumber;
    }
    
    return get<Map<String, dynamic>>(
      ApiConfig.getVendorProfile,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  // Booking methods
  
  // Create booking
  Future<ApiResponse<Booking>> createBooking(BookingRequest request) async {
    print('📝 Creating booking: ${request.toJson()}');
    final response = await post<Booking>(
      ApiConfig.createBooking,
      request.toJson(),
      fromJson: (json) => Booking.fromJson(json),
    );
    print('📦 Booking response: ${response.success ? 'Success (ID: ${response.data?.id})' : 'Failed: ${response.message}'}');
    return response;
  }

  // Get all bookings
  Future<ApiResponse<List<Booking>>> getAllBookings() async {
    return getList<Booking>(
      ApiConfig.getBookings,
      fromJson: (json) => Booking.fromJson(json),
    );
  }

  // Get bookings by user ID
  Future<ApiResponse<List<Booking>>> getBookingsByUserId(String userId) async {
    return getList<Booking>(
      '${ApiConfig.getBookings}/user/$userId',
      fromJson: (json) => Booking.fromJson(json),
    );
  }

  // Get booking by ID
  Future<ApiResponse<Booking>> getBookingById(String id) async {
    return get<Booking>(
      '${ApiConfig.getBookings}/$id',
      fromJson: (json) => Booking.fromJson(json),
    );
  }

  // Cancel booking
  Future<ApiResponse<void>> cancelBooking(String bookingId) async {
    return post<void>(
      ApiConfig.cancelBooking,
      {'bookingId': bookingId},
    );
  }

  // Payment methods
  
  // Process payment
  Future<ApiResponse<PaymentResponse>> processPayment(PaymentRequest request) async {
    print('💳 Processing payment: ${request.toJson()}');
    final response = await post<Map<String, dynamic>>(
      ApiConfig.processPayment,
      request.toJson(),
      fromJson: (json) => json,
    );
    
    if (response.success && response.data != null) {
      print('✅ Payment successful: ${response.data}');
      return ApiResponse<PaymentResponse>(
        success: true,
        message: response.message,
        data: PaymentResponse.fromJson(response.data!),
      );
    }
    
    print('❌ Payment failed: ${response.message}');
    return ApiResponse<PaymentResponse>(
      success: false,
      message: response.message,
      data: null,
    );
  }

  // Get payment status
  Future<ApiResponse<PaymentStatusResponse>> getPaymentStatus(String transactionId) async {
    final response = await get<Map<String, dynamic>>(
      ApiConfig.getPaymentStatus,
      queryParameters: {'transactionId': transactionId},
      fromJson: (json) => json,
    );
    
    if (response.success && response.data != null) {
      return ApiResponse<PaymentStatusResponse>(
        success: true,
        message: response.message,
        data: PaymentStatusResponse.fromJson(response.data!),
      );
    }
    
    return ApiResponse<PaymentStatusResponse>(
      success: false,
      message: response.message,
      data: null,
    );
  }
}

