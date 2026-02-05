# Backend Connection Guide

This guide explains how to connect your Flutter hotel booking app with your backend API.

## Setup Instructions

### 1. Install Dependencies

First, install the required HTTP package:

```bash
flutter pub get
``


### 2. Configure Backend URL

Open `lib/config/api_config.dart` and update the `baseUrl` with your backend API URL:

```dart
static const String baseUrl = 'https://api.yourdomain.com';
```

**For local development:**
- **Android Emulator**: Use `http://server.port=8080` (where 3000 is your backend port)
- **iOS Simulator**: Use `http://server.port=8080`
- **Physical Device**: Use your computer's IP address, e.g., `http://192.168.1.100:3000`

### 3. Backend API Requirements

Your backend API should follow these conventions:

#### Response Format

All API responses should follow this structure:

```json
{
  "success": true,
  "message": "Success message",
  "data": {
    // Response data here
  }
}
```

#### Error Response Format

```json
{
  "success": false,
  "message": "Error message",
  "data": null
}
```

### 4. Authentication Endpoints

#### Login (`POST /api/auth/login`)

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "jwt_token_here",
    "user": {
      "id": "user_id",
      "name": "User Name",
      "email": "user@example.com",
      "phone": "1234567890",
      "profileImage": "url_to_image"
    }
  }
}
```

#### Signup (`POST /api/auth/signup`)

**Request Body:**
```json
{
  "name": "User Name",
  "email": "user@example.com",
  "phone": "1234567890",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Signup successful",
  "data": {
    "user": {
      "id": "user_id",
      "name": "User Name",
      "email": "user@example.com",
      "phone": "1234567890"
    }
  }
}
```

#### Forgot Password (`POST /api/auth/forgot-password`)

**Request Body:**
```json
{
  "email": "user@example.com"
}
```

#### Reset Password (`POST /api/auth/reset-password`)

**Request Body:**
```json
{
  "email": "user@example.com",
  "otp": "123456",
  "newPassword": "newpassword123"
}
```

#### Verify OTP (`POST /api/auth/verify-otp`)

**Request Body:**
```json
{
  "email": "user@example.com",
  "otp": "123456"
}
```

## Usage Examples

### Using the API Service

The `ApiService` class is a singleton that handles all API calls. Here's how to use it:

```dart
import '../services/api_service.dart';
import '../models/auth_models.dart';

// Get API service instance
final apiService = ApiService();

// Login example
final loginRequest = LoginRequest(
  email: 'user@example.com',
  password: 'password123',
);

final response = await apiService.login(loginRequest);

if (response.success && response.data != null) {
  // Save token
  apiService.setAuthToken(response.data!.token);
  
  // Access user data
  final user = response.data!.user;
  print('Logged in as: ${user.name}');
} else {
  print('Error: ${response.message}');
}
```

### Making Custom API Calls

You can also make custom API calls using the generic methods:

```dart
// GET request
final response = await apiService.get<Map<String, dynamic>>(
  '/api/hotels/search',
  queryParameters: {'location': 'New York', 'checkIn': '2024-01-01'},
  fromJson: (json) => json,
);

// POST request
final response = await apiService.post<Map<String, dynamic>>(
  '/api/bookings',
  {
    'hotelId': '123',
    'checkIn': '2024-01-01',
    'checkOut': '2024-01-05',
  },
  fromJson: (json) => json,
);
```

### Using Authentication Token

Once a user logs in, the token is automatically stored in `ApiService`. All subsequent API calls will include the token in the Authorization header:

```dart
// Token is automatically included in headers
final response = await apiService.get('/api/bookings');
```

## Project Structure

```
lib/
├── config/
│   └── api_config.dart          # API configuration (base URL, endpoints)
├── services/
│   └── api_service.dart         # API service for HTTP requests
├── models/
│   ├── api_response.dart        # Generic API response model
│   └── auth_models.dart         # Authentication models (Login, Signup, User)
└── ...
```

## Testing Your Connection

1. **Check Network Permissions**: Ensure your `AndroidManifest.xml` has internet permission (already included).

2. **Test with a Simple Endpoint**: Try calling a simple endpoint first to verify connectivity.

3. **Check Logs**: Use `print()` statements or Flutter DevTools to debug API calls.

4. **Handle Errors**: Always wrap API calls in try-catch blocks and handle network errors gracefully.

## Common Issues

### CORS Issues (Web)
If you're running on web, you may need to configure CORS on your backend.

### SSL Certificate Issues
For HTTPS connections, ensure your backend has a valid SSL certificate. For development, you might need to allow self-signed certificates.

### Network Timeout
If requests timeout, adjust the timeout values in `api_config.dart`:
```dart
static const Duration connectTimeout = Duration(seconds: 60);
static const Duration receiveTimeout = Duration(seconds: 60);
```

## Next Steps

1. Update other screens (signup, forgot password) to use the API service
2. Add more models for hotels, bookings, payments, etc.
3. Implement token storage persistence (using `shared_preferences` package)
4. Add refresh token functionality
5. Implement proper error handling and retry logic

