// Login Request Model
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// Login Response Model
class LoginResponse {
  final String token;
  final User user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}

// Signup Request Model
class SignupRequest {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignupRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}

// Signup Response Model
class SignupResponse {
  final String message;
  final User? user;

  SignupResponse({
    required this.message,
    this.user,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      message: json['message'] ?? 'Signup successful',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user?.toJson(),
    };
  }
}

// User Model
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
    };
  }
}

