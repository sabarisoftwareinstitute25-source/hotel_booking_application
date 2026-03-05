import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_booking_mobile_application/onboarding_screen/find_stays_screen.dart';
import '../home_screen/hotel_registration_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/normal_hotel_dashboard_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/office_users_screen.dart';



class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFF0F4FF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E293B), Color(0xFF334155)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.admin_panel_settings_rounded,
                              size: 18,
                              color: Colors.amber.shade300,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Admin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),


                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5F6D).withOpacity(0.2),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.hotel, size: 48, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 24),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.waving_hand_rounded,
                          color: Color(0xFFFF5F6D),
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: const Text(
                            "Welcome Aboard!",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),

                    const SizedBox(height: 26),

                    Column(
                      children: [
                        const Text(
                          "Trusted by travelers worldwide",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.verified,
                              color: Color(0xFF10B981),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "Secure bookings | Best prices",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xDDED6262),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Choose your role 👇",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRoleCard(
                        icon: Icons.houseboat_outlined,
                        title: "Book hotels and villas",
                        description: "Find Stays",
                        color: const Color(0xFF3B82F6),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindStaysScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildRoleCard(
                        icon: Icons.business_outlined,
                        title: "Register your hotel or villa",
                        description: "List Property",
                        color: const Color(0xFF10B981),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyAuthScreen(selectedPropertyType: '',),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OfficeLoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.business_center_rounded,
                            size: 18,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Office Login",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Icon(icon, size: 28, color: color)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class OfficeLoginScreen extends StatefulWidget {
  const OfficeLoginScreen({Key? key}) : super(key: key);

  @override
  State<OfficeLoginScreen> createState() => _OfficeLoginScreenState();
}

class _OfficeLoginScreenState extends State<OfficeLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OfficeDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4e73df), Color(0xff1cc88a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.admin_panel_settings,
                    size: 60,
                    color: Color(0xff4e73df),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Office Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Office Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e73df),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class PropertyAuthScreen extends StatefulWidget {
//   // final String selectedPropertyType;
//   final Map<String, dynamic>? registrationData;
//   const PropertyAuthScreen({super.key,   this.registrationData = const {}});
//
//   @override
//   State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
// }
//
// class _PropertyAuthScreenState extends State<PropertyAuthScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final TextEditingController _loginEmailController = TextEditingController();
//   final TextEditingController _loginPasswordController =
//       TextEditingController();
//
//   final TextEditingController _regNameController = TextEditingController();
//   final TextEditingController _regBusinessController = TextEditingController();
//   final TextEditingController _regEmailController = TextEditingController();
//   final TextEditingController _regPhoneController = TextEditingController();
//   final TextEditingController _regPasswordController = TextEditingController();
//   final TextEditingController _regConfirmPasswordController =
//       TextEditingController();
//
//   final Map<String, String?> _loginErrors = {};
//   final Map<String, String?> _regErrors = {};
//
//   bool _showLoginPassword = false;
//   bool _showRegPassword = false;
//   bool _showConfirmPassword = false;
//   bool _isLoggingIn = false;
//   bool _isRegistering = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//
//     _prefillRegistrationData();
//   }
//
//   void _prefillRegistrationData() {
//     if (widget.registrationData != null &&
//         widget.registrationData!.isNotEmpty) {
//       final data = widget.registrationData!;
//       if (data['hotelName'] != null) {
//         _regBusinessController.text = data['hotelName'].toString();
//       }
//       if (data['ownerName'] != null) {
//         _regNameController.text = data['ownerName'].toString();
//       }
//       if (data['email'] != null) {
//         _regEmailController.text = data['email'].toString();
//       }
//       if (data['mobileNumber'] != null) {
//         _regPhoneController.text = data['mobileNumber'].toString();
//       }
//     }
//   }
//
//   // Future<void> _saveUser(Map<String, dynamic> userData) async {
//   //   try {
//   //     final prefs = await SharedPreferences.getInstance();
//   //
//   //     final String usersJson = prefs.getString('registered_users') ?? '[]';
//   //     List<dynamic> users = jsonDecode(usersJson);
//   //
//   //     final normalizedEmail = userData['email'].toString().toLowerCase().trim();
//   //     userData['email'] = normalizedEmail;
//   //
//   //     bool userExists = false;
//   //     for (int i = 0; i < users.length; i++) {
//   //       final existingEmail =
//   //           users[i]['email']?.toString().toLowerCase().trim() ?? '';
//   //       if (existingEmail == normalizedEmail) {
//   //         users[i] = userData;
//   //         userExists = true;
//   //         print('Updated existing user: $normalizedEmail');
//   //         break;
//   //       }
//   //     }
//   //
//   //     if (!userExists) {
//   //       users.add(userData);
//   //       print('Added new user: $normalizedEmail');
//   //     }
//   //
//   //     await prefs.setString('registered_users', jsonEncode(users));
//   //     print('Total registered users: ${users.length}');
//   //   } catch (e) {
//   //     print('Error saving user: $e');
//   //   }
//   // }
//
//   // Future<Map<String, dynamic>?> _getUser(String email) async {
//   //   try {
//   //     final prefs = await SharedPreferences.getInstance();
//   //     final String usersJson = prefs.getString('registered_users') ?? '[]';
//   //     final List<dynamic> users = jsonDecode(usersJson);
//   //
//   //     final normalizedEmail = email.toLowerCase().trim();
//   //
//   //     for (var user in users) {
//   //       final storedEmail =
//   //           user['email']?.toString().toLowerCase().trim() ?? '';
//   //       if (storedEmail == normalizedEmail) {
//   //         return Map<String, dynamic>.from(user);
//   //       }
//   //     }
//   //     return null;
//   //   } catch (e) {
//   //     print('Error getting user: $e');
//   //     return null;
//   //   }
//   // }
//   Future<void> _saveUser(Map<String, dynamic> userData) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//
//       final String usersJson = prefs.getString('registered_users') ?? '[]';
//       List<dynamic> users = jsonDecode(usersJson);
//
//       final normalizedEmail = userData['email'].toString().toLowerCase().trim();
//       userData['email'] = normalizedEmail;
//
//       print('=== SAVING USER ===');
//       print('User data keys: ${userData.keys.toList()}');
//       if (userData.containsKey('basicInfo')) {
//         print('basicInfo exists with keys: ${(userData['basicInfo'] as Map).keys.toList()}');
//       }
//
//       bool userExists = false;
//       for (int i = 0; i < users.length; i++) {
//         final existingEmail = users[i]['email']?.toString().toLowerCase().trim() ?? '';
//         if (existingEmail == normalizedEmail) {
//           users[i] = userData;
//           userExists = true;
//           print('Updated existing user: $normalizedEmail');
//           break;
//         }
//       }
//
//       if (!userExists) {
//         users.add(userData);
//         print('Added new user: $normalizedEmail');
//       }
//
//       await prefs.setString('registered_users', jsonEncode(users));
//       print('Total registered users: ${users.length}');
//     } catch (e) {
//       print('Error saving user: $e');
//     }
//   }
//   Future<Map<String, dynamic>?> _getUser(String email) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String usersJson = prefs.getString('registered_users') ?? '[]';
//       final List<dynamic> users = jsonDecode(usersJson);
//
//       final normalizedEmail = email.toLowerCase().trim();
//
//       for (var user in users) {
//         final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
//         if (storedEmail == normalizedEmail) {
//           print('=== FOUND USER ===');
//           print('User data keys: ${user.keys.toList()}');
//           return Map<String, dynamic>.from(user);
//         }
//       }
//       return null;
//     } catch (e) {
//       print('Error getting user: $e');
//       return null;
//     }
//   }
//
//   Future<bool> _validateCredentials(String email, String password) async {
//     final user = await _getUser(email);
//     return user != null && user['password'] == password;
//   }
//
//   bool _isValidEmail(String email) {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//   }
//
//   bool _isValidPhone(String phone) {
//     return RegExp(r'^[0-9]{10}$').hasMatch(phone);
//   }
//
//   bool _isValidPassword(String password) {
//     return password.length >= 6;
//   }
//
//   void _clearAllForms() {
//     _loginEmailController.clear();
//     _loginPasswordController.clear();
//     _regNameController.clear();
//     _regBusinessController.clear();
//     _regEmailController.clear();
//     _regPhoneController.clear();
//     _regPasswordController.clear();
//     _regConfirmPasswordController.clear();
//
//     _loginErrors.clear();
//     _regErrors.clear();
//
//     setState(() {
//       _showLoginPassword = false;
//       _showRegPassword = false;
//       _showConfirmPassword = false;
//     });
//   }
//
//   Future<void> _handleRegister() async {
//     setState(() {
//       _regErrors.clear();
//     });
//
//     final fullName = _regNameController.text.trim();
//     final businessName = _regBusinessController.text.trim();
//     final email = _regEmailController.text.trim();
//     final phone = _regPhoneController.text.trim();
//     final password = _regPasswordController.text;
//     final confirmPassword = _regConfirmPasswordController.text;
//
//     bool hasErrors = false;
//
//     if (fullName.isEmpty) {
//       _regErrors['fullName'] = 'Full name is required';
//       hasErrors = true;
//     }
//
//     if (businessName.isEmpty) {
//       _regErrors['businessName'] = 'Business name is required';
//       hasErrors = true;
//     }
//
//     if (email.isEmpty) {
//       _regErrors['email'] = 'Email is required';
//       hasErrors = true;
//     } else if (!_isValidEmail(email)) {
//       _regErrors['email'] = 'Enter a valid email address';
//       hasErrors = true;
//     }
//
//     if (phone.isEmpty) {
//       _regErrors['phone'] = 'Phone number is required';
//       hasErrors = true;
//     } else if (!_isValidPhone(phone)) {
//       _regErrors['phone'] = 'Enter a valid 10-digit phone number';
//       hasErrors = true;
//     }
//
//     if (password.isEmpty) {
//       _regErrors['password'] = 'Password is required';
//       hasErrors = true;
//     } else if (!_isValidPassword(password)) {
//       _regErrors['password'] = 'Password must be at least 6 characters';
//       hasErrors = true;
//     }
//
//     if (confirmPassword.isEmpty) {
//       _regErrors['confirmPassword'] = 'Please confirm your password';
//       hasErrors = true;
//     } else if (password != confirmPassword) {
//       _regErrors['confirmPassword'] = 'Passwords do not match';
//       hasErrors = true;
//     }
//
//     if (hasErrors) {
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please correct the highlighted fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     final existingUser = await _getUser(email);
//     if (existingUser != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Email already registered. Please login.'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       _tabController.animateTo(0);
//       _loginEmailController.text = email;
//       _loginPasswordController.text = password;
//       return;
//     }
//
//     setState(() => _isRegistering = true);
//
//     try {
//       final userData = {
//         'fullName': fullName,
//         'businessName': businessName,
//         'email': email.toLowerCase().trim(),
//         'phone': phone,
//         'password': password,
//         'registeredAt': DateTime.now().toIso8601String(),
//         'lastLogin': DateTime.now().toIso8601String(),
//
//         if (widget.registrationData != null) ...widget.registrationData!,
//       };
//
//       await _saveUser(userData);
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('is_logged_in', true);
//       await prefs.setString('current_user_email', email.toLowerCase().trim());
//
//       if (!mounted) return;
//
//       setState(() => _isRegistering = false);
//
//       _clearAllForms();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Registration successful!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       final mergedData = {...userData, ...?widget.registrationData};
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//       );
//     } catch (e) {
//       setState(() => _isRegistering = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Registration failed: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   Future<void> _handleLogin() async {
//     setState(() {
//       _loginErrors.clear();
//     });
//
//     final email = _loginEmailController.text.trim();
//     final password = _loginPasswordController.text;
//
//     bool hasErrors = false;
//
//     if (email.isEmpty) {
//       _loginErrors['email'] = 'Email is required';
//       hasErrors = true;
//     } else if (!_isValidEmail(email)) {
//       _loginErrors['email'] = 'Enter a valid email address';
//       hasErrors = true;
//     }
//
//     if (password.isEmpty) {
//       _loginErrors['password'] = 'Password is required';
//       hasErrors = true;
//     }
//
//     if (hasErrors) {
//       setState(() {});
//       return;
//     }
//
//     setState(() => _isLoggingIn = true);
//
//     try {
//       final isValid = await _validateCredentials(email, password);
//
//       if (!isValid) {
//         setState(() {
//           _isLoggingIn = false;
//           _loginErrors['email'] = 'Invalid email or password';
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Invalid email or password'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }
//
//       final userData = await _getUser(email);
//
//       if (userData == null) {
//         setState(() => _isLoggingIn = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('User data not found'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }
//
//       userData['lastLogin'] = DateTime.now().toIso8601String();
//       await _saveUser(userData);
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('is_logged_in', true);
//       await prefs.setString('current_user_email', email.toLowerCase().trim());
//
//       if (!mounted) return;
//
//       setState(() => _isLoggingIn = false);
//
//       _clearAllForms();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Login successful!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//
//       await Future.delayed(const Duration(milliseconds: 500));
//
//       final mergedData = {...userData, ...?widget.registrationData};
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HotelOwnerDashboard(
//             registrationData: mergedData,
//             hotelName: '',
//             ownerName: '',
//             mobileNumber: '',
//             email: '',
//             addressLine1: '',
//             addressLine2: '',
//             city: '',
//             district: '',
//             state: '',
//             pinCode: '',
//             gstNumber: '',
//             fssaiLicense: '',
//             tradeLicense: '',
//             panNumber: '',
//             aadharNumber: '',
//             accountHolderName: '',
//             bankName: '',
//             accountNumber: '',
//             ifscCode: '',
//             branch: '',
//             accountType: '',
//             totalRooms: 0,
//             personPhotoInfo: {},
//           ),
//         ),
//       );
//     } catch (e) {
//       setState(() => _isLoggingIn = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Login error: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//
//   // Future<void> _handleRegister() async {
//   //   setState(() {
//   //     _regErrors.clear();
//   //   });
//   //
//   //   final fullName = _regNameController.text.trim();
//   //   final businessName = _regBusinessController.text.trim();
//   //   final email = _regEmailController.text.trim();
//   //   final phone = _regPhoneController.text.trim();
//   //   final password = _regPasswordController.text;
//   //   final confirmPassword = _regConfirmPasswordController.text;
//   //
//   //   bool hasErrors = false;
//   //
//   //   if (fullName.isEmpty) {
//   //     _regErrors['fullName'] = 'Full name is required';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (businessName.isEmpty) {
//   //     _regErrors['businessName'] = 'Business name is required';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (email.isEmpty) {
//   //     _regErrors['email'] = 'Email is required';
//   //     hasErrors = true;
//   //   } else if (!_isValidEmail(email)) {
//   //     _regErrors['email'] = 'Enter a valid email address';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (phone.isEmpty) {
//   //     _regErrors['phone'] = 'Phone number is required';
//   //     hasErrors = true;
//   //   } else if (!_isValidPhone(phone)) {
//   //     _regErrors['phone'] = 'Enter a valid 10-digit phone number';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (password.isEmpty) {
//   //     _regErrors['password'] = 'Password is required';
//   //     hasErrors = true;
//   //   } else if (!_isValidPassword(password)) {
//   //     _regErrors['password'] = 'Password must be at least 6 characters';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (confirmPassword.isEmpty) {
//   //     _regErrors['confirmPassword'] = 'Please confirm your password';
//   //     hasErrors = true;
//   //   } else if (password != confirmPassword) {
//   //     _regErrors['confirmPassword'] = 'Passwords do not match';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (hasErrors) {
//   //     setState(() {});
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Please correct the highlighted fields'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //     return;
//   //   }
//   //
//   //   final existingUser = await _getUser(email);
//   //   if (existingUser != null) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Email already registered. Please login.'),
//   //         backgroundColor: Colors.orange,
//   //       ),
//   //     );
//   //     _tabController.animateTo(0);
//   //     _loginEmailController.text = email;
//   //     _loginPasswordController.text = password;
//   //     return;
//   //   }
//   //
//   //   setState(() => _isRegistering = true);
//   //
//   //   try {
//   //     print('=== HANDLE REGISTER START ===');
//   //     print('widget.registrationData is null? ${widget.registrationData == null}');
//   //     print('widget.selectedPropertyType: ${widget.selectedPropertyType}');
//   //
//   //     // IMPORTANT: Start with an empty map
//   //     final Map<String, dynamic> userData = {};
//   //
//   //     // FIRST: Add ALL registration data (this contains the villa data)
//   //     if (widget.registrationData != null) {
//   //       print('✅ Registration data exists');
//   //       print('Registration data keys: ${widget.registrationData!.keys.toList()}');
//   //
//   //       // Add each key from registration data individually to ensure deep copy
//   //       widget.registrationData!.forEach((key, value) {
//   //         if (value is Map) {
//   //           // Create a deep copy of maps
//   //           userData[key] = Map<String, dynamic>.from(value);
//   //         } else if (value is List) {
//   //           // Create a deep copy of lists
//   //           userData[key] = List.from(value);
//   //         } else {
//   //           userData[key] = value;
//   //         }
//   //       });
//   //       print('✅ Added registration data to userData');
//   //     } else {
//   //       print('❌ WARNING: No registration data available!');
//   //     }
//   //
//   //     // SECOND: Add user account data
//   //     userData['fullName'] = fullName;
//   //     userData['businessName'] = businessName;
//   //     userData['email'] = email.toLowerCase().trim();
//   //     userData['phone'] = phone;
//   //     userData['password'] = password;
//   //     userData['registeredAt'] = DateTime.now().toIso8601String();
//   //     userData['lastLogin'] = DateTime.now().toIso8601String();
//   //
//   //     // THIRD: Set property type from the widget parameter
//   //     String propertyType = widget.selectedPropertyType.isNotEmpty
//   //         ? widget.selectedPropertyType
//   //         : 'unknown';
//   //
//   //     userData['propertyType'] = propertyType;
//   //
//   //     print('✅ FINAL USER DATA KEYS: ${userData.keys.toList()}');
//   //
//   //     // Verify villa data is present
//   //     if (userData.containsKey('basicInfo')) {
//   //       print('✅✅✅ basicInfo EXISTS with keys: ${(userData['basicInfo'] as Map).keys.toList()}');
//   //       print('✅✅✅ villaName: ${(userData['basicInfo'] as Map)['villaName']}');
//   //     } else {
//   //       print('❌❌❌ basicInfo NOT found in userData');
//   //       print('This is the problem! Registration data is not being properly added.');
//   //     }
//   //
//   //     if (userData.containsKey('propertyDetails')) {
//   //       print('✅ propertyDetails EXISTS with keys: ${(userData['propertyDetails'] as Map).keys.toList()}');
//   //     }
//   //
//   //     // Save the complete user data
//   //     await _saveUser(userData);
//   //
//   //     final prefs = await SharedPreferences.getInstance();
//   //     await prefs.setBool('is_logged_in', true);
//   //     await prefs.setString('current_user_email', email.toLowerCase().trim());
//   //
//   //     if (!mounted) return;
//   //
//   //     setState(() => _isRegistering = false);
//   //
//   //     _clearAllForms();
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Registration successful!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //
//   //     await Future.delayed(const Duration(milliseconds: 500));
//   //
//   //     // Navigate to appropriate dashboard based on property type
//   //     if (propertyType == 'villa') {
//   //       print('✅✅✅ Navigating to VillaOwnerDashboard');
//   //
//   //       // Handle digital signature safely
//   //       Uint8List? digitalSignatureImage;
//   //       if (userData['signature'] != null &&
//   //           userData['signature']['digitalSignature'] != null &&
//   //           userData['signature']['digitalSignature'] is Uint8List) {
//   //         digitalSignatureImage = userData['signature']['digitalSignature'];
//   //       }
//   //
//   //       // Handle declaration date safely
//   //       DateTime? declarationDate;
//   //       if (userData['signature'] != null && userData['signature']['date'] != null) {
//   //         if (userData['signature']['date'] is DateTime) {
//   //           declarationDate = userData['signature']['date'];
//   //         } else {
//   //           declarationDate = DateTime.tryParse(userData['signature']['date'].toString());
//   //         }
//   //       }
//   //
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => VillaOwnerDashboard(
//   //             registrationData: userData,
//   //             villaName: userData['basicInfo']?['villaName'] ?? userData['villaName'] ?? '',
//   //             ownerName: userData['basicInfo']?['ownerName'] ?? userData['ownerName'] ?? '',
//   //             mobileNumber: userData['basicInfo']?['mobile'] ?? userData['mobileNumber'] ?? '',
//   //             email: userData['basicInfo']?['email'] ?? userData['email'] ?? '',
//   //             address: userData['location']?['address'] ?? userData['address'] ?? '',
//   //             area: userData['location']?['area'] ?? userData['area'] ?? '',
//   //             city: userData['location']?['city'] ?? userData['city'] ?? '',
//   //             state: userData['location']?['state'] ?? userData['state'] ?? '',
//   //             pincode: userData['location']?['pincode'] ?? userData['pincode'] ?? '',
//   //             propertyType: userData['propertyDetails']?['propertyType'] ?? userData['propertyType'] ?? '',
//   //             bedrooms: int.tryParse(userData['propertyDetails']?['bedrooms']?.toString() ?? userData['bedrooms']?.toString() ?? '0') ?? 0,
//   //             bathrooms: int.tryParse(userData['propertyDetails']?['bathrooms']?.toString() ?? userData['bathrooms']?.toString() ?? '0') ?? 0,
//   //             guestCapacity: int.tryParse(userData['propertyDetails']?['guestCapacity']?.toString() ?? userData['guestCapacity']?.toString() ?? '0') ?? 0,
//   //             propertySize: userData['propertyDetails']?['propertySize']?.toString() ?? userData['propertySize']?.toString() ?? '',
//   //             yearConstruction: userData['propertyDetails']?['yearConstruction']?.toString() ?? userData['yearConstruction']?.toString() ?? '',
//   //             description: userData['propertyDetails']?['description']?.toString() ?? userData['description']?.toString() ?? '',
//   //             villaAmenities: Map<String, bool>.from(userData['amenities']?['selected'] ?? userData['villaAmenities'] ?? {}),
//   //             customAmenities: List<String>.from(userData['amenities']?['custom'] ?? userData['customAmenities'] ?? []),
//   //             basePrice: userData['pricing']?['basePrice']?.toString() ?? userData['basePrice']?.toString() ?? '',
//   //             weekendPrice: userData['pricing']?['weekendPrice']?.toString() ?? userData['weekendPrice']?.toString() ?? '',
//   //             peakPrice: userData['pricing']?['peakPrice']?.toString() ?? userData['peakPrice']?.toString() ?? '',
//   //             securityDeposit: userData['pricing']?['securityDeposit']?.toString() ?? userData['securityDeposit']?.toString() ?? '',
//   //             minimumStay: userData['pricing']?['minimumStay']?.toString() ?? userData['minimumStay']?.toString() ?? '',
//   //             checkInTime: userData['pricing']?['checkInTime']?.toString() ?? userData['checkInTime']?.toString(),
//   //             checkOutTime: userData['pricing']?['checkOutTime']?.toString() ?? userData['checkOutTime']?.toString(),
//   //             cancellationPolicy: Map<String, dynamic>.from(userData['pricing']?['cancellationPolicy'] ?? userData['cancellationPolicy'] ?? {}),
//   //             availabilityCalendar: Map<String, dynamic>.from(userData['pricing']?['availabilityCalendar'] ?? userData['availabilityCalendar'] ?? {}),
//   //             ownershipProof: Map<String, dynamic>.from(userData['legal']?['ownershipProof'] ?? userData['ownershipProof'] ?? {}),
//   //             idProof: Map<String, dynamic>.from(userData['legal']?['idProof'] ?? userData['idProof'] ?? {}),
//   //             gstNumber: userData['legal']?['gstNumber']?.toString() ?? userData['gstNumber']?.toString() ?? '',
//   //             tradeLicense: userData['legal']?['tradeLicense']?.toString() ?? userData['tradeLicense']?.toString() ?? '',
//   //             accountHolderName: userData['bank']?['accountHolder']?.toString() ?? userData['accountHolderName']?.toString() ?? '',
//   //             bankName: userData['bank']?['bankName']?.toString() ?? userData['bankName']?.toString() ?? '',
//   //             accountNumber: userData['bank']?['accountNumber']?.toString() ?? userData['accountNumber']?.toString() ?? '',
//   //             ifscCode: userData['bank']?['ifscCode']?.toString() ?? userData['ifscCode']?.toString() ?? '',
//   //             upiId: userData['bank']?['upiId']?.toString() ?? userData['upiId']?.toString() ?? '',
//   //             cancelledCheque: Map<String, dynamic>.from(userData['bank']?['cancelledCheque'] ?? userData['cancelledCheque'] ?? {}),
//   //             mediaFiles: Map<String, List<Map<String, dynamic>>>.from(userData['media'] ?? userData['mediaFiles'] ?? {}),
//   //             ownerPhoto: Map<String, dynamic>.from(userData['basicInfo']?['ownerPhoto'] ?? userData['ownerPhoto'] ?? {}),
//   //             hasDigitalSignature: userData['signature']?['hasDigital'] ?? userData['hasDigitalSignature'] ?? false,
//   //             digitalSignatureImage: digitalSignatureImage,
//   //             declarationDate: declarationDate,
//   //             declarationAccepted: userData['declarationAccepted'] ?? false,
//   //             altMobile: userData['basicInfo']?['altMobile']?.toString() ?? userData['altMobile']?.toString(),
//   //             website: userData['basicInfo']?['website']?.toString() ?? userData['website']?.toString(),
//   //             googleMapLink: userData['location']?['googleMapLink']?.toString() ?? userData['googleMapLink']?.toString(),
//   //           ),
//   //         ),
//   //       );
//   //     } else if (propertyType == 'hotel') {
//   //       print('Navigating to HotelOwnerDashboard');
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => HotelOwnerDashboard(
//   //             registrationData: userData,
//   //             hotelName: userData['hotelName'] ?? '',
//   //             ownerName: userData['ownerName'] ?? '',
//   //             mobileNumber: userData['mobileNumber'] ?? '',
//   //             email: userData['email'] ?? '',
//   //             addressLine1: userData['addressLine1'] ?? '',
//   //             addressLine2: userData['addressLine2'] ?? '',
//   //             city: userData['city'] ?? '',
//   //             district: userData['district'] ?? '',
//   //             state: userData['state'] ?? '',
//   //             pinCode: userData['pinCode'] ?? '',
//   //             gstNumber: userData['gstNumber'] ?? '',
//   //             fssaiLicense: userData['fssaiLicense'] ?? '',
//   //             tradeLicense: userData['tradeLicense'] ?? '',
//   //             panNumber: userData['panNumber'] ?? '',
//   //             aadharNumber: userData['aadharNumber'] ?? '',
//   //             accountHolderName: userData['accountHolderName'] ?? '',
//   //             bankName: userData['bankName'] ?? '',
//   //             accountNumber: userData['accountNumber'] ?? '',
//   //             ifscCode: userData['ifscCode'] ?? '',
//   //             branch: userData['branch'] ?? '',
//   //             accountType: userData['accountType'] ?? '',
//   //             totalRooms: int.tryParse(userData['totalRooms']?.toString() ?? '0') ?? 0,
//   //             personPhotoInfo: Map<String, dynamic>.from(userData['personPhotoInfo'] ?? {}),
//   //           ),
//   //         ),
//   //       );
//   //     } else {
//   //       print('❌ Unknown property type: "$propertyType", navigating to WelcomeScreen');
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text('Unknown property type: $propertyType. Please contact support.'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     setState(() => _isRegistering = false);
//   //     print('Registration error: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Registration failed: ${e.toString()}'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }
//   // String _determinePropertyTypeFromRegistrationData(Map<String, dynamic>? data) {
//   //   print('=== DETERMINING PROPERTY TYPE FROM REGISTRATION DATA ===');
//   //
//   //   if (data == null) {
//   //     print('❌ Registration data is NULL');
//   //     return 'unknown';
//   //   }
//   //
//   //   if (data.isEmpty) {
//   //     print('❌ Registration data is EMPTY');
//   //     return 'unknown';
//   //   }
//   //
//   //   print('📋 Registration data keys: ${data.keys.toList()}');
//   //
//   //   // Check if this is villa data by looking for villa-specific structures
//   //   if (data.containsKey('basicInfo')) {
//   //     print('✅ Found basicInfo section');
//   //     final basicInfo = data['basicInfo'] as Map;
//   //     print('basicInfo keys: ${basicInfo.keys.toList()}');
//   //
//   //     if (basicInfo.containsKey('villaName')) {
//   //       print('✅✅✅ Found villaName in basicInfo - this is a VILLA');
//   //       return 'villa';
//   //     }
//   //   }
//   //
//   //   if (data.containsKey('propertyDetails')) {
//   //     print('Found propertyDetails section');
//   //     final propertyDetails = data['propertyDetails'] as Map;
//   //     print('propertyDetails keys: ${propertyDetails.keys.toList()}');
//   //
//   //     if (propertyDetails.containsKey('bedrooms') ||
//   //         propertyDetails.containsKey('bathrooms') ||
//   //         propertyDetails.containsKey('guestCapacity')) {
//   //       print('✅✅✅ Found villa-specific fields in propertyDetails - this is a VILLA');
//   //       return 'villa';
//   //     }
//   //
//   //     // Also check propertyType in propertyDetails
//   //     if (propertyDetails.containsKey('propertyType')) {
//   //       final type = propertyDetails['propertyType'].toString().toLowerCase();
//   //       print('Found propertyType in propertyDetails: $type');
//   //       if (type.contains('villa')) {
//   //         print('✅✅✅ Found propertyType: $type in propertyDetails - this is a VILLA');
//   //         return 'villa';
//   //       }
//   //     }
//   //   }
//   //
//   //   // Check for direct villa keys
//   //   if (data.containsKey('villaName')) {
//   //     print('✅✅✅ Found direct villaName - this is a VILLA');
//   //     return 'villa';
//   //   }
//   //
//   //   if (data.containsKey('bedrooms') && data.containsKey('bathrooms')) {
//   //     print('✅✅✅ Found bedrooms and bathrooms - this is likely a VILLA');
//   //     return 'villa';
//   //   }
//   //
//   //   // Check for hotel
//   //   if (data.containsKey('hotelName') || data.containsKey('totalRooms') || data.containsKey('roomDetails')) {
//   //     print('Found hotel-specific fields - this is a HOTEL');
//   //     return 'hotel';
//   //   }
//   //
//   //   // Check for apartment
//   //   if (data.containsKey('apartmentName')) {
//   //     print('Found apartment-specific fields - this is an APARTMENT');
//   //     return 'apartment';
//   //   }
//   //
//   //   // Check for resort
//   //   if (data.containsKey('resortName')) {
//   //     print('Found resort-specific fields - this is a RESORT');
//   //     return 'resort';
//   //   }
//   //
//   //   print('❌ Could not determine property type from registration data');
//   //   return 'unknown';
//   // }
//   // Future<void> _handleLogin() async {
//   //   setState(() {
//   //     _loginErrors.clear();
//   //   });
//   //
//   //   final email = _loginEmailController.text.trim();
//   //   final password = _loginPasswordController.text;
//   //
//   //   bool hasErrors = false;
//   //
//   //   if (email.isEmpty) {
//   //     _loginErrors['email'] = 'Email is required';
//   //     hasErrors = true;
//   //   } else if (!_isValidEmail(email)) {
//   //     _loginErrors['email'] = 'Enter a valid email address';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (password.isEmpty) {
//   //     _loginErrors['password'] = 'Password is required';
//   //     hasErrors = true;
//   //   }
//   //
//   //   if (hasErrors) {
//   //     setState(() {});
//   //     return;
//   //   }
//   //
//   //   setState(() => _isLoggingIn = true);
//   //
//   //   try {
//   //     final isValid = await _validateCredentials(email, password);
//   //
//   //     if (!isValid) {
//   //       setState(() {
//   //         _isLoggingIn = false;
//   //         _loginErrors['email'] = 'Invalid email or password';
//   //       });
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Invalid email or password'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       return;
//   //     }
//   //
//   //     final userData = await _getUser(email);
//   //
//   //     if (userData == null) {
//   //       setState(() => _isLoggingIn = false);
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('User data not found'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       return;
//   //     }
//   //
//   //     userData['lastLogin'] = DateTime.now().toIso8601String();
//   //     await _saveUser(userData);
//   //
//   //     final prefs = await SharedPreferences.getInstance();
//   //     await prefs.setBool('is_logged_in', true);
//   //     await prefs.setString('current_user_email', email.toLowerCase().trim());
//   //
//   //     if (!mounted) return;
//   //
//   //     setState(() => _isLoggingIn = false);
//   //
//   //     _clearAllForms();
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Login successful!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //
//   //     await Future.delayed(const Duration(milliseconds: 500));
//   //
//   //     // Determine property type from user data
//   //     final propertyType = _determinePropertyType(userData);
//   //
//   //     // Navigate to the appropriate dashboard based on property type
//   //     if (propertyType == 'villa') {
//   //       // Navigate to VillaOwnerDashboard
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => VillaOwnerDashboard(
//   //             registrationData: userData,
//   //             villaName: userData['villaName'] ?? userData['basicInfo']?['villaName'] ?? '',
//   //             ownerName: userData['ownerName'] ?? userData['basicInfo']?['ownerName'] ?? '',
//   //             mobileNumber: userData['mobileNumber'] ?? userData['basicInfo']?['mobile'] ?? '',
//   //             email: userData['email'] ?? userData['basicInfo']?['email'] ?? '',
//   //             address: userData['address'] ?? userData['location']?['address'] ?? '',
//   //             area: userData['area'] ?? userData['location']?['area'] ?? '',
//   //             city: userData['city'] ?? userData['location']?['city'] ?? '',
//   //             state: userData['state'] ?? userData['location']?['state'] ?? '',
//   //             pincode: userData['pincode'] ?? userData['location']?['pincode'] ?? '',
//   //             propertyType: userData['propertyType'] ?? userData['propertyDetails']?['propertyType'] ?? '',
//   //             bedrooms: int.tryParse(userData['bedrooms']?.toString() ?? userData['propertyDetails']?['bedrooms']?.toString() ?? '0') ?? 0,
//   //             bathrooms: int.tryParse(userData['bathrooms']?.toString() ?? userData['propertyDetails']?['bathrooms']?.toString() ?? '0') ?? 0,
//   //             guestCapacity: int.tryParse(userData['guestCapacity']?.toString() ?? userData['propertyDetails']?['guestCapacity']?.toString() ?? '0') ?? 0,
//   //             propertySize: userData['propertySize']?.toString() ?? userData['propertyDetails']?['propertySize']?.toString() ?? '',
//   //             yearConstruction: userData['yearConstruction']?.toString() ?? userData['propertyDetails']?['yearConstruction']?.toString() ?? '',
//   //             description: userData['description']?.toString() ?? userData['propertyDetails']?['description']?.toString() ?? '',
//   //             villaAmenities: Map<String, bool>.from(userData['villaAmenities'] ?? userData['amenities']?['selected'] ?? {}),
//   //             customAmenities: List<String>.from(userData['customAmenities'] ?? userData['amenities']?['custom'] ?? []),
//   //             basePrice: userData['basePrice']?.toString() ?? userData['pricing']?['basePrice']?.toString() ?? '',
//   //             weekendPrice: userData['weekendPrice']?.toString() ?? userData['pricing']?['weekendPrice']?.toString() ?? '',
//   //             peakPrice: userData['peakPrice']?.toString() ?? userData['pricing']?['peakPrice']?.toString() ?? '',
//   //             securityDeposit: userData['securityDeposit']?.toString() ?? userData['pricing']?['securityDeposit']?.toString() ?? '',
//   //             minimumStay: userData['minimumStay']?.toString() ?? userData['pricing']?['minimumStay']?.toString() ?? '',
//   //             checkInTime: userData['checkInTime']?.toString() ?? userData['pricing']?['checkInTime']?.toString(),
//   //             checkOutTime: userData['checkOutTime']?.toString() ?? userData['pricing']?['checkOutTime']?.toString(),
//   //             cancellationPolicy: Map<String, dynamic>.from(userData['cancellationPolicy'] ?? userData['pricing']?['cancellationPolicy'] ?? {}),
//   //             availabilityCalendar: Map<String, dynamic>.from(userData['availabilityCalendar'] ?? userData['pricing']?['availabilityCalendar'] ?? {}),
//   //             ownershipProof: Map<String, dynamic>.from(userData['ownershipProof'] ?? userData['legal']?['ownershipProof'] ?? {}),
//   //             idProof: Map<String, dynamic>.from(userData['idProof'] ?? userData['legal']?['idProof'] ?? {}),
//   //             gstNumber: userData['gstNumber']?.toString() ?? userData['legal']?['gstNumber']?.toString() ?? '',
//   //             tradeLicense: userData['tradeLicense']?.toString() ?? userData['legal']?['tradeLicense']?.toString() ?? '',
//   //             accountHolderName: userData['accountHolderName']?.toString() ?? userData['bank']?['accountHolder']?.toString() ?? '',
//   //             bankName: userData['bankName']?.toString() ?? userData['bank']?['bankName']?.toString() ?? '',
//   //             accountNumber: userData['accountNumber']?.toString() ?? userData['bank']?['accountNumber']?.toString() ?? '',
//   //             ifscCode: userData['ifscCode']?.toString() ?? userData['bank']?['ifscCode']?.toString() ?? '',
//   //             upiId: userData['upiId']?.toString() ?? userData['bank']?['upiId']?.toString() ?? '',
//   //             cancelledCheque: Map<String, dynamic>.from(userData['cancelledCheque'] ?? userData['bank']?['cancelledCheque'] ?? {}),
//   //             mediaFiles: Map<String, List<Map<String, dynamic>>>.from(userData['mediaFiles'] ?? userData['media'] ?? {}),
//   //             ownerPhoto: Map<String, dynamic>.from(userData['ownerPhoto'] ?? userData['basicInfo']?['ownerPhoto'] ?? {}),
//   //             hasDigitalSignature: userData['hasDigitalSignature'] ?? userData['signature']?['hasDigital'] ?? false,
//   //             digitalSignatureImage: userData['digitalSignatureImage'] != null
//   //                 ? (userData['digitalSignatureImage'] is Uint8List
//   //                 ? userData['digitalSignatureImage']
//   //                 : null)
//   //                 : null,
//   //             declarationDate: userData['declarationDate'] != null
//   //                 ? (userData['declarationDate'] is DateTime
//   //                 ? userData['declarationDate']
//   //                 : DateTime.tryParse(userData['declarationDate'].toString()))
//   //                 : null,
//   //             declarationAccepted: userData['declarationAccepted'] ?? userData['signature']?['declarationAccepted'] ?? false,
//   //             altMobile: userData['altMobile']?.toString() ?? userData['basicInfo']?['altMobile']?.toString(),
//   //             website: userData['website']?.toString() ?? userData['basicInfo']?['website']?.toString(),
//   //             googleMapLink: userData['googleMapLink']?.toString() ?? userData['location']?['googleMapLink']?.toString(),
//   //           ),
//   //         ),
//   //       );
//   //     } else if (propertyType == 'hotel') {
//   //       // Navigate to HotelOwnerDashboard
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => HotelOwnerDashboard(
//   //             registrationData: userData,
//   //             hotelName: userData['hotelName'] ?? '',
//   //             ownerName: userData['ownerName'] ?? '',
//   //             mobileNumber: userData['mobileNumber'] ?? '',
//   //             email: userData['email'] ?? '',
//   //             addressLine1: userData['addressLine1'] ?? '',
//   //             addressLine2: userData['addressLine2'] ?? '',
//   //             city: userData['city'] ?? '',
//   //             district: userData['district'] ?? '',
//   //             state: userData['state'] ?? '',
//   //             pinCode: userData['pinCode'] ?? '',
//   //             gstNumber: userData['gstNumber'] ?? '',
//   //             fssaiLicense: userData['fssaiLicense'] ?? '',
//   //             tradeLicense: userData['tradeLicense'] ?? '',
//   //             panNumber: userData['panNumber'] ?? '',
//   //             aadharNumber: userData['aadharNumber'] ?? '',
//   //             accountHolderName: userData['accountHolderName'] ?? '',
//   //             bankName: userData['bankName'] ?? '',
//   //             accountNumber: userData['accountNumber'] ?? '',
//   //             ifscCode: userData['ifscCode'] ?? '',
//   //             branch: userData['branch'] ?? '',
//   //             accountType: userData['accountType'] ?? '',
//   //             totalRooms: int.tryParse(userData['totalRooms']?.toString() ?? '0') ?? 0,
//   //             personPhotoInfo: Map<String, dynamic>.from(userData['personPhotoInfo'] ?? {}),
//   //           ),
//   //         ),
//   //       );
//   //     } else if (propertyType == 'apartment') {
//   //       // Navigate to ApartmentOwnerDashboard (create this later)
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Apartment dashboard coming soon!'),
//   //           backgroundColor: Colors.orange,
//   //         ),
//   //       );
//   //       // For now, navigate to WelcomeScreen
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//   //       );
//   //     } else if (propertyType == 'resort') {
//   //       // Navigate to ResortOwnerDashboard (create this later)
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Resort dashboard coming soon!'),
//   //           backgroundColor: Colors.orange,
//   //         ),
//   //       );
//   //       // For now, navigate to WelcomeScreen
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//   //       );
//   //     } else {
//   //       // Unknown property type - show error and navigate to WelcomeScreen
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Unknown property type. Please contact support.'),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     setState(() => _isLoggingIn = false);
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Login error: ${e.toString()}'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }
//   // String _determinePropertyType(Map<String, dynamic> userData) {
//   //   print('=== DETERMINING PROPERTY TYPE DURING LOGIN ===');
//   //   print('User data keys: ${userData.keys.toList()}');
//   //
//   //   // Check if propertyType is directly stored
//   //   if (userData.containsKey('propertyType')) {
//   //     final type = userData['propertyType'].toString().toLowerCase();
//   //     print('Found direct propertyType: $type');
//   //     if (type == 'villa') return 'villa';
//   //     if (type == 'hotel') return 'hotel';
//   //     if (type == 'apartment') return 'apartment';
//   //     if (type == 'resort') return 'resort';
//   //   }
//   //
//   //   // Check for villa-specific fields
//   //   if (userData.containsKey('basicInfo')) {
//   //     print('Found basicInfo section - this is a VILLA');
//   //     return 'villa';
//   //   }
//   //
//   //   if (userData.containsKey('villaName') ||
//   //       userData.containsKey('bedrooms') ||
//   //       userData.containsKey('bathrooms')) {
//   //     print('Found villa-specific fields - this is a VILLA');
//   //     return 'villa';
//   //   }
//   //
//   //   // Check for hotel-specific fields
//   //   if (userData.containsKey('hotelName') ||
//   //       userData.containsKey('totalRooms') ||
//   //       userData.containsKey('roomDetails')) {
//   //     print('Found hotel-specific fields - this is a HOTEL');
//   //     return 'hotel';
//   //   }
//   //
//   //   // Check for apartment
//   //   if (userData.containsKey('apartmentName')) {
//   //     print('Found apartment-specific fields - this is an APARTMENT');
//   //     return 'apartment';
//   //   }
//   //
//   //   // Check for resort
//   //   if (userData.containsKey('resortName')) {
//   //     print('Found resort-specific fields - this is a RESORT');
//   //     return 'resort';
//   //   }
//   //
//   //   print('Could not determine property type, defaulting to unknown');
//   //   return 'unknown';
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFF8FAFF), Color(0xFFF0F4FF)],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Center(
//                   child: Icon(Icons.business, size: 40, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               const Text(
//                 "Property Partner",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w800,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//               const Text(
//                 "Manage your hospitality business",
//                 style: TextStyle(color: Color(0xFF6B7280)),
//               ),
//               const SizedBox(height: 20),
//
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   labelColor: Colors.white,
//                   unselectedLabelColor: const Color(0xFF6B7280),
//                   indicator: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tabs: const [
//                     Tab(text: 'Login to your account'),
//                     Tab(text: 'New User Registration'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [_buildLoginTab(), _buildRegisterTab()],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginTab() {
//     final emailError = _loginErrors['email'];
//     final passwordError = _loginErrors['password'];
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Email Address",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF374151),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: emailError != null
//                         ? Colors.red
//                         : const Color(0xFFE5E7EB),
//                   ),
//                 ),
//                 child: TextField(
//                   controller: _loginEmailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     hintText: "Enter registered email",
//                     prefixIcon: Icon(Icons.email, color: Color(0xFF6B7280)),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(16),
//                   ),
//                 ),
//               ),
//               if (emailError != null) ...[
//                 const SizedBox(height: 4),
//                 Text(
//                   emailError,
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               ],
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Password",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF374151),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: passwordError != null
//                         ? Colors.red
//                         : const Color(0xFFE5E7EB),
//                   ),
//                 ),
//                 child: TextField(
//                   controller: _loginPasswordController,
//                   obscureText: !_showLoginPassword,
//                   decoration: InputDecoration(
//                     hintText: "Enter your password",
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: Color(0xFF6B7280),
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.all(16),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _showLoginPassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: const Color(0xFF6B7280),
//                       ),
//                       onPressed: () => setState(
//                         () => _showLoginPassword = !_showLoginPassword,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (passwordError != null) ...[
//                 const SizedBox(height: 4),
//                 Text(
//                   passwordError,
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               ],
//             ],
//           ),
//
//           const SizedBox(height: 24),
//
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: _isLoggingIn ? null : _handleLogin,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF5F6D),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: _isLoggingIn
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation(Colors.white),
//                       ),
//                     )
//                   : const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRegisterTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFF9FAFB),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(16),
//                       topRight: Radius.circular(16),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                             colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.how_to_reg_rounded,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Account Details",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF1F2937),
//                               ),
//                             ),
//                             Text(
//                               "Fill in your information",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Color(0xFF6B7280),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       _buildTextField(
//                         label: "Full Name",
//                         hint: "Enter your full name",
//                         icon: Icons.person_outline_rounded,
//                         controller: _regNameController,
//                         error: _regErrors['fullName'],
//                       ),
//                       const SizedBox(height: 16),
//
//                       _buildTextField(
//                         label: "Business Name",
//                         hint: "Hotel/Guest House/Business name",
//                         icon: Icons.business_outlined,
//                         controller: _regBusinessController,
//                         error: _regErrors['businessName'],
//                       ),
//                       const SizedBox(height: 16),
//
//                       _buildTextField(
//                         label: "Email address",
//                         hint: "Valid email address",
//                         icon: Icons.email_outlined,
//                         controller: _regEmailController,
//                         keyboardType: TextInputType.emailAddress,
//                         error: _regErrors['email'],
//                       ),
//                       const SizedBox(height: 16),
//
//                       _buildTextField(
//                         label: "Phone number",
//                         hint: "10-digit phone number",
//                         icon: Icons.phone,
//                         controller: _regPhoneController,
//                         keyboardType: TextInputType.phone,
//                         error: _regErrors['phone'],
//                       ),
//                       const SizedBox(height: 16),
//
//                       _buildPasswordField(
//                         label: "Password",
//                         hint: "Minimum 6 characters",
//                         controller: _regPasswordController,
//                         obscure: !_showRegPassword,
//                         onToggle: () => setState(
//                           () => _showRegPassword = !_showRegPassword,
//                         ),
//                         error: _regErrors['password'],
//                       ),
//                       const SizedBox(height: 16),
//
//                       _buildPasswordField(
//                         label: "Confirm Password",
//                         hint: "Re-enter your password",
//                         controller: _regConfirmPasswordController,
//                         obscure: !_showConfirmPassword,
//                         onToggle: () => setState(
//                           () => _showConfirmPassword = !_showConfirmPassword,
//                         ),
//                         error: _regErrors['confirmPassword'],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           Container(
//             height: 56,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFFFF5F6D), Color(0xFFFF8A7A)],
//               ),
//               borderRadius: BorderRadius.circular(14),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFFFF5F6D).withOpacity(0.3),
//                   blurRadius: 15,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: ElevatedButton(
//               onPressed: _isRegistering ? null : _handleRegister,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 padding: EdgeInsets.zero,
//               ),
//               child: _isRegistering
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation(Colors.white),
//                       ),
//                     )
//                   : const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.rocket_launch_rounded,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required String hint,
//     required IconData icon,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//     String? error,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF374151),
//                 fontSize: 14,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 4),
//               child: Text(
//                 "*",
//                 style: TextStyle(
//                   color: Color(0xFFFF5F6D),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: error != null ? Colors.red : const Color(0xFFE5E7EB),
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFF9FAFB),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                   ),
//                   border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
//                 ),
//                 child: Center(
//                   child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
//                 ),
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: controller,
//                   keyboardType: keyboardType,
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     hintStyle: const TextStyle(
//                       color: Color(0xFF9CA3AF),
//                       fontSize: 14,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 15,
//                     ),
//                   ),
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF1F2937),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (error != null) ...[
//           const SizedBox(height: 4),
//           Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildPasswordField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     required bool obscure,
//     required VoidCallback onToggle,
//     String? error,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF374151),
//                 fontSize: 14,
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 4),
//               child: Text(
//                 "*",
//                 style: TextStyle(
//                   color: Color(0xFFFF5F6D),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: error != null ? Colors.red : const Color(0xFFE5E7EB),
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFF9FAFB),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                   ),
//                   border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.lock_outline_rounded,
//                     size: 20,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: controller,
//                   obscureText: obscure,
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     hintStyle: const TextStyle(
//                       color: Color(0xFF9CA3AF),
//                       fontSize: 14,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 15,
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         obscure
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                         size: 20,
//                         color: const Color(0xFF6B7280),
//                       ),
//                       onPressed: onToggle,
//                     ),
//                   ),
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF1F2937),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (error != null) ...[
//           const SizedBox(height: 4),
//           Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
//         ],
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _loginEmailController.dispose();
//     _loginPasswordController.dispose();
//     _regNameController.dispose();
//     _regBusinessController.dispose();
//     _regEmailController.dispose();
//     _regPhoneController.dispose();
//     _regPasswordController.dispose();
//     _regConfirmPasswordController.dispose();
//     super.dispose();
//   }
// }




class VillaAuthScreen extends StatefulWidget {
  final Map<String, dynamic>? registrationData;

  const VillaAuthScreen({super.key, this.registrationData});

  @override
  State<VillaAuthScreen> createState() => _VillaAuthScreenState();
}

class _VillaAuthScreenState extends State<VillaAuthScreen> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  final Map<String, String?> _loginErrors = {};

  bool _showLoginPassword = false;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _saveUser(Map<String, dynamic> userData) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String usersJson = prefs.getString('registered_users') ?? '[]';
  //     List<dynamic> users = jsonDecode(usersJson);
  //
  //     final normalizedEmail = userData['email'].toString().toLowerCase().trim();
  //     userData['email'] = normalizedEmail;
  //
  //     bool userExists = false;
  //     for (int i = 0; i < users.length; i++) {
  //       final existingEmail = users[i]['email']?.toString().toLowerCase().trim() ?? '';
  //       if (existingEmail == normalizedEmail) {
  //         users[i] = userData;
  //         userExists = true;
  //         break;
  //       }
  //     }
  //
  //     if (!userExists) {
  //       users.add(userData);
  //     }
  //
  //     await prefs.setString('registered_users', jsonEncode(users));
  //   } catch (e) {
  //     print('Error saving user: $e');
  //   }
  // }
  //
  // Future<Map<String, dynamic>?> _getUser(String email) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String usersJson = prefs.getString('registered_users') ?? '[]';
  //     final List<dynamic> users = jsonDecode(usersJson);
  //
  //     final normalizedEmail = email.toLowerCase().trim();
  //
  //     for (var user in users) {
  //       final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
  //       if (storedEmail == normalizedEmail) {
  //         return Map<String, dynamic>.from(user);
  //       }
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error getting user: $e');
  //     return null;
  //   }
  // }


  Future<void> _saveUser(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      List<dynamic> users = jsonDecode(usersJson);

      final normalizedEmail = userData['email'].toString().toLowerCase().trim();
      userData['email'] = normalizedEmail;


      bool userExists = false;
      for (int i = 0; i < users.length; i++) {
        final existingEmail = users[i]['email']?.toString().toLowerCase().trim() ?? '';
        if (existingEmail == normalizedEmail) {
          users[i] = userData;
          userExists = true;
          break;
        }
      }

      if (!userExists) {
        users.add(userData);
      }

      await prefs.setString('registered_users', jsonEncode(users));
    } catch (e) {
      print('Error saving user: $e');
    }
  }


  Future<Map<String, dynamic>?> _getUser(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      final normalizedEmail = email.toLowerCase().trim();

      for (var user in users) {
        final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
        if (storedEmail == normalizedEmail) {
          // Make sure to properly cast all nested maps
          return Map<String, dynamic>.from(user);
        }
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<bool> _validateCredentials(String email, String password) async {
    final user = await _getUser(email);
    return user != null && user['password'] == password;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Future<void> _handleLogin() async {
  //   setState(() {
  //     _loginErrors.clear();
  //   });
  //
  //   final email = _loginEmailController.text.trim();
  //   final password = _loginPasswordController.text;
  //
  //   bool hasErrors = false;
  //
  //   if (email.isEmpty) {
  //     _loginErrors['email'] = 'Email is required';
  //     hasErrors = true;
  //   } else if (!_isValidEmail(email)) {
  //     _loginErrors['email'] = 'Enter a valid email address';
  //     hasErrors = true;
  //   }
  //
  //   if (password.isEmpty) {
  //     _loginErrors['password'] = 'Password is required';
  //     hasErrors = true;
  //   }
  //
  //   if (hasErrors) {
  //     setState(() {});
  //     return;
  //   }
  //
  //   setState(() => _isLoggingIn = true);
  //
  //   try {
  //     final isValid = await _validateCredentials(email, password);
  //
  //     if (!isValid) {
  //       setState(() {
  //         _isLoggingIn = false;
  //         _loginErrors['email'] = 'Invalid email or password';
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Invalid email or password'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     final userData = await _getUser(email);
  //
  //     if (userData == null) {
  //       setState(() => _isLoggingIn = false);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('User data not found'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     // NO RESTRICTIONS - Just update last login and proceed
  //     userData['lastLogin'] = DateTime.now().toIso8601String();
  //     await _saveUser(userData);
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('is_logged_in', true);
  //     await prefs.setString('current_user_email', email.toLowerCase().trim());
  //
  //     if (!mounted) return;
  //
  //     setState(() => _isLoggingIn = false);
  //     _clearForms();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Login successful!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     await Future.delayed(const Duration(milliseconds: 500));
  //
  //     // Navigate to VillaOwnerDashboard - NO RESTRICTIONS
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => VillaOwnerDashboard(
  //           registrationData: userData,
  //           villaName: userData['villaName'] ?? userData['basicInfo']?['villaName'] ?? '',
  //           ownerName: userData['ownerName'] ?? userData['basicInfo']?['ownerName'] ?? userData['fullName'] ?? '',
  //           mobileNumber: userData['mobileNumber'] ?? userData['basicInfo']?['mobile'] ?? userData['phone'] ?? '',
  //           email: userData['email'] ?? '',
  //           address: userData['address'] ?? userData['location']?['address'] ?? '',
  //           area: userData['area'] ?? userData['location']?['area'] ?? '',
  //           city: userData['city'] ?? userData['location']?['city'] ?? '',
  //           state: userData['state'] ?? userData['location']?['state'] ?? '',
  //           pincode: userData['pincode'] ?? userData['location']?['pincode'] ?? '',
  //           propertyType: 'villa',
  //           bedrooms: int.tryParse(userData['bedrooms']?.toString() ?? userData['propertyDetails']?['bedrooms']?.toString() ?? '0') ?? 0,
  //           bathrooms: int.tryParse(userData['bathrooms']?.toString() ?? userData['propertyDetails']?['bathrooms']?.toString() ?? '0') ?? 0,
  //           guestCapacity: int.tryParse(userData['guestCapacity']?.toString() ?? userData['propertyDetails']?['guestCapacity']?.toString() ?? '0') ?? 0,
  //           propertySize: userData['propertySize']?.toString() ?? userData['propertyDetails']?['propertySize']?.toString() ?? '',
  //           yearConstruction: userData['yearConstruction']?.toString() ?? userData['propertyDetails']?['yearConstruction']?.toString() ?? '',
  //           description: userData['description']?.toString() ?? userData['propertyDetails']?['description']?.toString() ?? '',
  //           villaAmenities: Map<String, bool>.from(userData['villaAmenities'] ?? userData['amenities']?['selected'] ?? {}),
  //           customAmenities: List<String>.from(userData['customAmenities'] ?? userData['amenities']?['custom'] ?? []),
  //           basePrice: userData['basePrice']?.toString() ?? userData['pricing']?['basePrice']?.toString() ?? '',
  //           weekendPrice: userData['weekendPrice']?.toString() ?? userData['pricing']?['weekendPrice']?.toString() ?? '',
  //           peakPrice: userData['peakPrice']?.toString() ?? userData['pricing']?['peakPrice']?.toString() ?? '',
  //           securityDeposit: userData['securityDeposit']?.toString() ?? userData['pricing']?['securityDeposit']?.toString() ?? '',
  //           minimumStay: userData['minimumStay']?.toString() ?? userData['pricing']?['minimumStay']?.toString() ?? '',
  //           checkInTime: userData['checkInTime']?.toString() ?? userData['pricing']?['checkInTime']?.toString(),
  //           checkOutTime: userData['checkOutTime']?.toString() ?? userData['pricing']?['checkOutTime']?.toString(),
  //           cancellationPolicy: Map<String, dynamic>.from(userData['cancellationPolicy'] ?? userData['pricing']?['cancellationPolicy'] ?? {}),
  //           availabilityCalendar: Map<String, dynamic>.from(userData['availabilityCalendar'] ?? userData['pricing']?['availabilityCalendar'] ?? {}),
  //           ownershipProof: Map<String, dynamic>.from(userData['ownershipProof'] ?? userData['legal']?['ownershipProof'] ?? {}),
  //           idProof: Map<String, dynamic>.from(userData['idProof'] ?? userData['legal']?['idProof'] ?? {}),
  //           gstNumber: userData['gstNumber']?.toString() ?? userData['legal']?['gstNumber']?.toString() ?? '',
  //           tradeLicense: userData['tradeLicense']?.toString() ?? userData['legal']?['tradeLicense']?.toString() ?? '',
  //           accountHolderName: userData['accountHolderName']?.toString() ?? userData['bank']?['accountHolder']?.toString() ?? '',
  //           bankName: userData['bankName']?.toString() ?? userData['bank']?['bankName']?.toString() ?? '',
  //           accountNumber: userData['accountNumber']?.toString() ?? userData['bank']?['accountNumber']?.toString() ?? '',
  //           ifscCode: userData['ifscCode']?.toString() ?? userData['bank']?['ifscCode']?.toString() ?? '',
  //           upiId: userData['upiId']?.toString() ?? userData['bank']?['upiId']?.toString() ?? '',
  //           cancelledCheque: Map<String, dynamic>.from(userData['cancelledCheque'] ?? userData['bank']?['cancelledCheque'] ?? {}),
  //           mediaFiles: Map<String, List<Map<String, dynamic>>>.from(userData['mediaFiles'] ?? userData['media'] ?? {}),
  //           ownerPhoto: Map<String, dynamic>.from(userData['ownerPhoto'] ?? userData['basicInfo']?['ownerPhoto'] ?? {}),
  //           hasDigitalSignature: userData['hasDigitalSignature'] ?? userData['signature']?['hasDigital'] ?? false,
  //           digitalSignatureImage: userData['digitalSignatureImage'] != null
  //               ? (userData['digitalSignatureImage'] is Uint8List
  //               ? userData['digitalSignatureImage']
  //               : null)
  //               : (userData['signature']?['digitalSignature'] is Uint8List
  //               ? userData['signature']['digitalSignature']
  //               : null),
  //           declarationDate: userData['declarationDate'] != null
  //               ? (userData['declarationDate'] is DateTime
  //               ? userData['declarationDate']
  //               : DateTime.tryParse(userData['declarationDate'].toString()))
  //               : (userData['signature']?['date'] != null
  //               ? (userData['signature']['date'] is DateTime
  //               ? userData['signature']['date']
  //               : DateTime.tryParse(userData['signature']['date'].toString()))
  //               : null),
  //           declarationAccepted: userData['declarationAccepted'] ?? false,
  //           altMobile: userData['altMobile']?.toString() ?? userData['basicInfo']?['altMobile']?.toString(),
  //           website: userData['website']?.toString() ?? userData['basicInfo']?['website']?.toString(),
  //           googleMapLink: userData['googleMapLink']?.toString() ?? userData['location']?['googleMapLink']?.toString(),
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     setState(() => _isLoggingIn = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login error: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }



  Future<void> _handleLogin() async {
    setState(() {
      _loginErrors.clear();
    });

    final email = _loginEmailController.text.trim();
    final password = _loginPasswordController.text;

    bool hasErrors = false;

    if (email.isEmpty) {
      _loginErrors['email'] = 'Email is required';
      hasErrors = true;
    } else if (!_isValidEmail(email)) {
      _loginErrors['email'] = 'Enter a valid email address';
      hasErrors = true;
    }

    if (password.isEmpty) {
      _loginErrors['password'] = 'Password is required';
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() {});
      return;
    }

    setState(() => _isLoggingIn = true);

    try {
      final isValid = await _validateCredentials(email, password);

      if (!isValid) {
        setState(() {
          _isLoggingIn = false;
          _loginErrors['email'] = 'Invalid email or password';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final userData = await _getUser(email);

      if (userData == null) {
        setState(() => _isLoggingIn = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User data not found'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }


      print('=== USER DATA AFTER LOGIN ===');
      print('All keys: ${userData.keys.toList()}');
      if (userData.containsKey('basicInfo')) {
        print('basicInfo keys: ${(userData['basicInfo'] as Map).keys.toList()}');
      }
      if (userData.containsKey('propertyDetails')) {
        print('propertyDetails keys: ${(userData['propertyDetails'] as Map).keys.toList()}');
      }
      if (userData.containsKey('amenities')) {
        print('amenities keys: ${(userData['amenities'] as Map).keys.toList()}');
      }
      if (userData.containsKey('pricing')) {
        print('pricing keys: ${(userData['pricing'] as Map).keys.toList()}');
      }
      if (userData.containsKey('location')) {
        print('location keys: ${(userData['location'] as Map).keys.toList()}');
      }
      if (userData.containsKey('legal')) {
        print('legal keys: ${(userData['legal'] as Map).keys.toList()}');
      }
      if (userData.containsKey('bank')) {
        print('bank keys: ${(userData['bank'] as Map).keys.toList()}');
      }
      if (userData.containsKey('media')) {
        print('media keys: ${(userData['media'] as Map).keys.toList()}');
      }
      if (userData.containsKey('signature')) {
        print('signature keys: ${(userData['signature'] as Map).keys.toList()}');
      }

      userData['lastLogin'] = DateTime.now().toIso8601String();
      await _saveUser(userData);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_email', email.toLowerCase().trim());

      if (!mounted) return;

      setState(() => _isLoggingIn = false);
      _clearForms();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VillaOwnerDashboard(
            registrationData: userData,
            // Basic Info
            villaName: userData['basicInfo']?['villaName'] ?? userData['villaName'] ?? '',
            ownerName: userData['basicInfo']?['ownerName'] ?? userData['ownerName'] ?? userData['fullName'] ?? '',
            mobileNumber: userData['basicInfo']?['mobile'] ?? userData['mobileNumber'] ?? userData['phone'] ?? '',
            email: userData['basicInfo']?['email'] ?? userData['email'] ?? '',

            // Location
            address: userData['location']?['address'] ?? userData['address'] ?? '',
            area: userData['location']?['area'] ?? userData['area'] ?? '',
            city: userData['location']?['city'] ?? userData['city'] ?? '',
            state: userData['location']?['state'] ?? userData['state'] ?? '',
            pincode: userData['location']?['pincode'] ?? userData['pincode'] ?? '',

            // Property Details
            propertyType: userData['propertyDetails']?['propertyType'] ?? 'villa',
            bedrooms: int.tryParse(userData['propertyDetails']?['bedrooms']?.toString() ?? '0') ?? 0,
            bathrooms: int.tryParse(userData['propertyDetails']?['bathrooms']?.toString() ?? '0') ?? 0,
            guestCapacity: int.tryParse(userData['propertyDetails']?['guestCapacity']?.toString() ?? '0') ?? 0,
            propertySize: userData['propertyDetails']?['propertySize']?.toString() ?? '',
            yearConstruction: userData['propertyDetails']?['yearConstruction']?.toString() ?? '',
            description: userData['propertyDetails']?['description']?.toString() ?? '',

            // Amenities
            villaAmenities: Map<String, bool>.from(
                userData['amenities']?['selected'] ?? userData['villaAmenities'] ?? {}),
            customAmenities: List<String>.from(
                userData['amenities']?['custom'] ?? userData['customAmenities'] ?? []),

            // Pricing
            basePrice: userData['pricing']?['basePrice']?.toString() ?? userData['basePrice']?.toString() ?? '',
            weekendPrice: userData['pricing']?['weekendPrice']?.toString() ?? userData['weekendPrice']?.toString() ?? '',
            peakPrice: userData['pricing']?['peakPrice']?.toString() ?? userData['peakPrice']?.toString() ?? '',
            securityDeposit: userData['pricing']?['securityDeposit']?.toString() ?? userData['securityDeposit']?.toString() ?? '',
            minimumStay: userData['pricing']?['minimumStay']?.toString() ?? userData['minimumStay']?.toString() ?? '',
            checkInTime: userData['pricing']?['checkInTime']?.toString() ?? userData['checkInTime']?.toString(),
            checkOutTime: userData['pricing']?['checkOutTime']?.toString() ?? userData['checkOutTime']?.toString(),
            cancellationPolicy: Map<String, dynamic>.from(
                userData['pricing']?['cancellationPolicy'] ?? userData['cancellationPolicy'] ?? {}),
            availabilityCalendar: Map<String, dynamic>.from(
                userData['pricing']?['availabilityCalendar'] ?? userData['availabilityCalendar'] ?? {}),

            // Legal
            ownershipProof: Map<String, dynamic>.from(
                userData['legal']?['ownershipProof'] ?? userData['ownershipProof'] ?? {}),
            idProof: Map<String, dynamic>.from(
                userData['legal']?['idProof'] ?? userData['idProof'] ?? {}),
            gstNumber: userData['legal']?['gstNumber']?.toString() ?? userData['gstNumber']?.toString() ?? '',
            tradeLicense: userData['legal']?['tradeLicense']?.toString() ?? userData['tradeLicense']?.toString() ?? '',

            // Bank
            accountHolderName: userData['bank']?['accountHolder']?.toString() ?? userData['accountHolderName']?.toString() ?? '',
            bankName: userData['bank']?['bankName']?.toString() ?? userData['bankName']?.toString() ?? '',
            accountNumber: userData['bank']?['accountNumber']?.toString() ?? userData['accountNumber']?.toString() ?? '',
            ifscCode: userData['bank']?['ifscCode']?.toString() ?? userData['ifscCode']?.toString() ?? '',
            upiId: userData['bank']?['upiId']?.toString() ?? userData['upiId']?.toString() ?? '',
            cancelledCheque: Map<String, dynamic>.from(
                userData['bank']?['cancelledCheque'] ?? userData['cancelledCheque'] ?? {}),

            // Media
            mediaFiles: Map<String, List<Map<String, dynamic>>>.from(
                userData['media'] ?? userData['mediaFiles'] ?? {}),
            ownerPhoto: Map<String, dynamic>.from(
                userData['basicInfo']?['ownerPhoto'] ?? userData['ownerPhoto'] ?? {}),

            // Signature
            hasDigitalSignature: userData['signature']?['hasDigital'] ?? userData['hasDigitalSignature'] ?? false,
            digitalSignatureImage: userData['signature']?['digitalSignature'] != null
                ? (userData['signature']['digitalSignature'] is Uint8List
                ? userData['signature']['digitalSignature']
                : null)
                : null,
            declarationDate: userData['signature']?['date'] != null
                ? (userData['signature']['date'] is DateTime
                ? userData['signature']['date']
                : DateTime.tryParse(userData['signature']['date'].toString()))
                : null,
            declarationAccepted: userData['declarationAccepted'] ?? false,

            // Additional
            altMobile: userData['basicInfo']?['altMobile']?.toString() ?? userData['altMobile']?.toString(),
            website: userData['basicInfo']?['website']?.toString() ?? userData['website']?.toString(),
            googleMapLink: userData['location']?['googleMapLink']?.toString() ?? userData['googleMapLink']?.toString(),
          ),
        ),
      );
    } catch (e) {
      setState(() => _isLoggingIn = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _clearForms() {
    _loginEmailController.clear();
    _loginPasswordController.clear();
    _loginErrors.clear();
    setState(() {
      _showLoginPassword = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Villa Owner Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Color(0xFF1F2937),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFF0F4FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5F6D).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.home_work, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Login to your villa dashboard",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 40),

                // Login Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email Field
                      const Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _loginErrors['email'] != null
                                ? Colors.red
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: TextField(
                          controller: _loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0xFF6B7280)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      if (_loginErrors['email'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _loginErrors['email']!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // Password Field
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _loginErrors['password'] != null
                                ? Colors.red
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: TextField(
                          controller: _loginPasswordController,
                          obscureText: !_showLoginPassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            prefixIcon: const Icon(Icons.lock_outline_rounded,
                                color: Color(0xFF6B7280)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showLoginPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF6B7280),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showLoginPassword = !_showLoginPassword;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      if (_loginErrors['password'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _loginErrors['password']!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color(0xFFFF5F6D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Login Button
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFF8A7A)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF5F6D).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _isLoggingIn ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: _isLoggingIn
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                              : const Text(
                            "Login to Villa Dashboard",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }
}



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(

        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF6B7280),
                    ),
                    onPressed: () => Navigator.pop(context),
                    // onPressed: () => {
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    // builder: (context) => PropertyAuthScreen(selectedPropertyType: selectedPropertyType),
                    // ),
                    // ),
                    // },
                  ),
                ),

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(Icons.business, size: 40, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Property Partner",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const Text(
                  "Manage your hospitality business",
                  style: TextStyle(color: Color(0xFF6B7280)),
                ),

                const SizedBox(height: 40),

                _buildRegisterTab(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "New Property Registration",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              "Register your hotel, villa, or guest house and start earning with us",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 28),

            _buildBenefitItem(Icons.verified_rounded, "Verified Partner Badge"),
            _buildBenefitItem(
              Icons.public_rounded,
              "Reach millions of travelers",
            ),
            _buildBenefitItem(
              Icons.trending_up_rounded,
              "Competitive commission rates",
            ),
            _buildBenefitItem(
              Icons.support_agent_rounded,
              "24/7 dedicated partner support",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyTypeScreen(
                        ownerName: '',
                        businessName: '',
                        email: '',
                        phone: '',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFFF5F6D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Start Registration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "By registering, you agree to our Terms & Conditions",
              style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.red),
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class PropertyTypeScreen extends StatefulWidget {
  const PropertyTypeScreen({
    super.key,
    required String ownerName,
    required String businessName,
    required String email,
    required String phone,
  });

  @override
  State<PropertyTypeScreen> createState() => _PropertyTypeScreenState();
}

// class _PropertyTypeScreenState extends State<PropertyTypeScreen> {
//   int _selectedIndex = -1;
//
//   final List<PropertyType> _propertyTypes = [
//     PropertyType(
//       icon: '🏨',
//       title: 'Hotel',
//       description: 'Hotels, Lodges & Guest Houses',
//       color: Color(0xFFFFC371),
//       isPopular: true,
//       isAvailable: true,
//     ),
//     PropertyType(
//       icon: '🏡',
//       title: 'Villa',
//       description: 'Private Villas & Bungalows',
//       color: Color(0xFFFFC371),
//       isPopular: false,
//       isAvailable: true,
//     ),
//     PropertyType(
//       icon: '🏢',
//       title: 'Apartment',
//       description: 'Serviced Apartments',
//       color: Color(0xFFFFC371),
//       isPopular: true,
//       isAvailable: true,
//     ),
//     PropertyType(
//       icon: '🌴',
//       title: 'Resort',
//       description: 'Beach & Hill Resorts',
//       color: Color(0xFFFFC371),
//       isPopular: false,
//       isAvailable: true,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0x14000000),
//                     blurRadius: 10,
//                     offset: Offset(0, 1),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Color(0xFFF5F5F7),
//                       ),
//                       child: Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         size: 18,
//                         color: Color(0xFF3C3C43),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'PROPERTY TYPE',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF8E8E93),
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         SizedBox(height: 2),
//                         Text(
//                           'Choose Category',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0xFF1C1C1E),
//                             fontWeight: FontWeight.w700,
//                             height: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 4,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2),
//                               gradient: LinearGradient(
//                                 colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                           Expanded(
//                             child: Container(
//                               height: 4,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(2),
//                                 color: Color(0xFFF2F2F7),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 32),
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'What type of property\ndo you want to list?',
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w800,
//                               color: Color(0xFF1C1C1E),
//                               height: 1.2,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'Select the category that best describes your property',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color(0xFF8E8E93),
//                               height: 1.4,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 32),
//
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 12,
//                           mainAxisSpacing: 12,
//                           childAspectRatio: 0.9,
//                         ),
//                         itemCount: _propertyTypes.length,
//                         itemBuilder: (context, index) {
//                           final property = _propertyTypes[index];
//                           return GestureDetector(
//                             // onTap: () {
//                             //   if (property.isAvailable) {
//                             //
//                             //     if (property.title == 'Hotel') {
//                             //
//                             //       Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               HotelCategoryScreen(),
//                             //         ),
//                             //       );
//                             //     } else if (property.title == 'Villa') {
//                             //
//                             //       Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               VillaRegistrationVendorForm(),
//                             //         ),
//                             //       );
//                             //     } else if (property.title == 'Apartment') {
//                             //
//                             //       Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) =>
//                             //               ApartmentRegistrationVendorForm(),
//                             //         ),
//                             //       );
//                             //     }
//                             //   } else if (property.title == 'Resort') {
//                             //
//                             //     Navigator.push(
//                             //       context,
//                             //       MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             ResortRegistrationVendorForm(),
//                             //       ),
//                             //     );
//                             //   } else {
//                             //     _showComingSoonDialog(context, property.title);
//                             //   }
//                             // },
//
//                             onTap: () {
//                               if (property.isAvailable) {
//                                 if (property.title == 'Hotel') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HotelCategoryScreen(),
//                                     ),
//                                   );
//                                 } else if (property.title == 'Villa') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => VillaRegistrationVendorForm(),
//                                     ),
//                                   );
//                                 } else if (property.title == 'Apartment') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ApartmentRegistrationVendorForm(),
//                                     ),
//                                   );
//                                 } else if (property.title == 'Resort') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ResortRegistrationVendorForm(),
//                                     ),
//                                   );
//                                 }
//                               } else {
//                                 _showComingSoonDialog(context, property.title);
//                               }
//                             },
//                             child: _PropertyCard(
//                               property: property,
//                               isSelected: _selectedIndex == index,
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showComingSoonDialog(BuildContext context, String propertyType) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(Icons.hourglass_empty, color: Color(0xFFFFC371)),
//             SizedBox(width: 12),
//             Text('Coming Soon'),
//           ],
//         ),
//         content: Text(
//           '$propertyType registration will be available soon. Currently, only Hotel registration is supported.',
//           style: TextStyle(fontSize: 15, color: Color(0xFF8E8E93)),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'OK',
//               style: TextStyle(
//                 color: Color(0xFFFF5F6D),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _PropertyTypeScreenState extends State<PropertyTypeScreen> {
  int _selectedIndex = -1;

  final List<PropertyType> _propertyTypes = [
    PropertyType(
      icon: '🏨',
      title: 'Hotel',
      description: 'Hotels, Lodges & Guest Houses',
      color: Color(0xFFFFC371),
      isPopular: true,
      isAvailable: true,
    ),
    PropertyType(
      icon: '🏡',
      title: 'Villa',
      description: 'Private Villas & Bungalows',
      color: Color(0xFFFFC371),
      isPopular: false,
      isAvailable: true,
    ),
    PropertyType(
      icon: '🏢',
      title: 'Apartment',
      description: 'Serviced Apartments',
      color: Color(0xFFFFC371),
      isPopular: true,
      isAvailable: true,
    ),
    PropertyType(
      icon: '🌴',
      title: 'Resort',
      description: 'Beach & Hill Resorts',
      color: Color(0xFFFFC371),
      isPopular: false,
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x14000000),
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF5F5F7),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Color(0xFF3C3C43),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROPERTY TYPE',
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Choose Category',
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xFF1C1C1E),
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: const Color(0xFFF2F2F7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What type of property\ndo you want to list?',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1C1C1E),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Select the category that best describes your property',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8E8E93),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: _propertyTypes.length,
                        itemBuilder: (context, index) {
                          final property = _propertyTypes[index];
                          return GestureDetector(
                            onTap: () {
                              if (property.isAvailable) {
                                _navigateToRegistration(context, property.title);
                              } else {
                                _showComingSoonDialog(context, property.title);
                              }
                            },
                            child: _PropertyCard(
                              property: property,
                              isSelected: _selectedIndex == index,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRegistration(BuildContext context, String propertyType) {
    print('=== NAVIGATING TO REGISTRATION ===');
    print('Property Type selected: $propertyType');

    switch (propertyType) {
      case 'Hotel':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HotelCategoryScreen()),
        );
        break;
      case 'Villa':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VillaRegistrationVendorForm()),
        );
        break;
      case 'Apartment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ApartmentRegistrationVendorForm()),
        );
        break;
      case 'Resort':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResortRegistrationVendorForm()),
        );
        break;
    }
  }

  void _showComingSoonDialog(BuildContext context, String propertyType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.hourglass_empty, color: const Color(0xFFFFC371)),
            const SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: Text('$propertyType registration will be available soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: const Color(0xFFFF5F6D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyType {
  final String icon;
  final String title;
  final String description;
  final Color color;
  final bool isPopular;
  final bool isAvailable;

  PropertyType({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isPopular,
    required this.isAvailable,
  });
}

class _PropertyCard extends StatelessWidget {
  final PropertyType property;
  final bool isSelected;

  const _PropertyCard({required this.property, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = property.isAvailable;

    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected && isAvailable
                  ? property.color
                  : Color(0xFFF2F2F7),
              width: isSelected && isAvailable ? 2 : 1,
            ),
            boxShadow: isSelected && isAvailable
                ? [
                    BoxShadow(
                      color: property.color.withOpacity(0.15),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: Opacity(
            opacity: isAvailable ? 1.0 : 0.6,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (property.isPopular && isAvailable)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                            ),
                          ),
                          child: Text(
                            'POPULAR',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: property.isPopular && isAvailable ? 4 : 0),

                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            property.color.withOpacity(
                              isSelected && isAvailable ? 0.2 : 0.1,
                            ),
                            property.color.withOpacity(
                              isSelected && isAvailable ? 0.1 : 0.05,
                            ),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          property.icon,
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    Text(
                      property.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1E),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),

                    Expanded(
                      child: Text(
                        property.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8E8E93),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected && isAvailable
                              ? property.color.withOpacity(0.2)
                              : Color(0xFFF5F5F7),
                          border: isSelected && isAvailable
                              ? Border.all(
                                  color: property.color.withOpacity(0.4),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Center(
                          child: isAvailable
                              ? Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: isSelected
                                      ? property.color
                                      : Color(0xFFC7C7CC),
                                )
                              : Icon(
                                  Icons.lock_outline,
                                  size: 14,
                                  color: Color(0xFFC7C7CC),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        if (isSelected && isAvailable)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: property.color,
                boxShadow: [
                  BoxShadow(
                    color: property.color.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(Icons.check_rounded, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

class HotelCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFF5F5F7),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Color(0xFF3C3C43),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hotel Category',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1C1C1E),
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select Star Rating',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Color(0xFFF2F2F7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose your hotel\ncategory',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1C1C1E),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Select the star rating of your hotel',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8E8E93),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),

                      ..._buildHotelCategories(context),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHotelCategories(BuildContext context) {
    final categories = [
      {
        'title': 'Normal Hotel',
        'subtitle': 'Basic Accommodation',
        'description': 'Essential amenities only',
        'stars': '',
        'price': '₹800 - ₹2,000',
        'color': Color(0xFF4A6FA5),
        'image':
            'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '2 Star Hotel',
        'subtitle': 'Budget Hotels',
        'description': 'Limited facilities',
        'stars': '⭐⭐',
        'price': '₹1,500 - ₹3,500',
        'color': Color(0xFF6B8E23),
        'image':
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '3 Star Hotel',
        'subtitle': 'Mid-Range',
        'description': 'Standard facilities',
        'stars': '⭐⭐⭐',
        'price': '₹2,500 - ₹5,000',
        'color': Color(0xFFDAA520),
        'image':
            'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '4 Star Hotel',
        'subtitle': 'Upscale Hotels',
        'description': 'Premium amenities',
        'stars': '⭐⭐⭐⭐',
        'price': '₹4,000 - ₹8,000',
        'color': Color(0xFF9370DB),
        'image':
            'https://images.unsplash.com/photo-1564501049418-3c27787d01e8?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '5 Star Hotel',
        'subtitle': 'Luxury',
        'description': 'World-class facilities',
        'stars': '⭐⭐⭐⭐⭐',
        'price': '₹6,000 - ₹15,000',
        'color': Color(0xFFFB717D),
        'image':
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '6 Star Hotel',
        'subtitle': 'Ultra-Luxury',
        'description': 'Exceptional services',
        'stars': '⭐⭐⭐⭐⭐⭐⭐',
        'price': '₹15,000+',
        'color': Color(0xFFC71585),
        'image':
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '7 Star Hotel',
        'subtitle': 'Iconic Luxury',
        'description': 'The pinnacle of hospitality',
        'stars': '⭐⭐⭐⭐⭐⭐⭐',
        'price': '₹25,000+',
        'color': Color(0xFF52AEF8),
        'image':
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': 'Global Luxury Star Hotel',
        'subtitle': 'International Standards',
        'description': 'World-renowned hospitality brands',
        'stars': '⭐⭐⭐⭐⭐⭐⭐',
        'price': '₹35,000+',
        'color': Color(0xFF10B981),
        'image':
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
    ];

    return List.generate(
      categories.length,
      (index) => Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: _HotelCategoryCard(
          title: categories[index]['title'] as String,
          subtitle: categories[index]['subtitle'] as String,
          description: categories[index]['description'] as String,
          stars: categories[index]['stars'] as String,
          price: categories[index]['price'] as String,
          color: categories[index]['color'] as Color,
          imageUrl: categories[index]['image'] as String,
          onTap: () {
            if (categories[index]['title'] == 'Normal Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '2 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TwoStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '3 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThreeStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '4 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FourStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '5 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FiveStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '6 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SixStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] == '7 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SevenStarHotelRegistrationScreen(),
                ),
              );
            } else if (categories[index]['title'] ==
                'Global Luxury Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GlobalEliteLuxuryHotelRegistrationScreen(),
                ),
              );
            }
            ;
          },
        ),
      ),
    );
  }
}

class _HotelCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String stars;
  final String price;
  final Color color;
  final String imageUrl;
  final VoidCallback onTap;

  const _HotelCategoryCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.stars,
    required this.price,
    required this.color,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFF2F2F7), width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: color.withOpacity(0.1),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: color,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: color.withOpacity(0.1),
                          child: Center(
                            child: Icon(Icons.hotel, size: 40, color: color),
                          ),
                        );
                      },
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    if (stars.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            stars,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFFFB347),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1C1C1E),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: color.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            price,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),

                    Text(
                      description,
                      style: TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
                    ),
                    SizedBox(height: 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: color.withOpacity(0.1),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Login Successful")));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4e73df), Color(0xff1cc88a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.admin_panel_settings,
                    size: 60,
                    color: Color(0xff4e73df),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Admin Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Admin Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e73df),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class PropertyAuthScreen extends StatefulWidget {
  final String selectedPropertyType;
  final Map<String, dynamic>? registrationData;

  const PropertyAuthScreen({
    Key? key,
    required this.selectedPropertyType,
    this.registrationData,
  }) : super(key: key);

  @override
  State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
}

class _PropertyAuthScreenState extends State<PropertyAuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _propertyType;

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regBusinessController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _regConfirmPasswordController = TextEditingController();

  final Map<String, String?> _loginErrors = {};
  final Map<String, String?> _regErrors = {};

  bool _showLoginPassword = false;
  bool _showRegPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoggingIn = false;
  bool _isRegistering = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Store property type directly from widget - SIMPLE AND RELIABLE
    _propertyType = widget.selectedPropertyType.toLowerCase().trim();

    print('=== PropertyAuthScreen INIT ===');
    print('Property Type from widget: "$_propertyType"');
    print('Registration data exists: ${widget.registrationData != null}');

    _prefillRegistrationData();
  }

  void _prefillRegistrationData() {
    if (widget.registrationData != null && widget.registrationData!.isNotEmpty) {
      final data = widget.registrationData!;

      // Handle different property types
      if (_propertyType == 'villa') {
        if (data['basicInfo'] != null) {
          final basicInfo = data['basicInfo'] as Map;
          _regNameController.text = basicInfo['ownerName']?.toString() ?? '';
          _regBusinessController.text = basicInfo['villaName']?.toString() ?? '';
          _regEmailController.text = basicInfo['email']?.toString() ?? '';
          _regPhoneController.text = basicInfo['mobile']?.toString() ?? '';
        }
      } else if (_propertyType == 'hotel') {
        _regNameController.text = data['ownerName']?.toString() ?? '';
        _regBusinessController.text = data['hotelName']?.toString() ?? '';
        _regEmailController.text = data['email']?.toString() ?? '';
        _regPhoneController.text = data['mobileNumber']?.toString() ?? '';
      } else {
        _regNameController.text = data['ownerName']?.toString() ?? '';
        _regBusinessController.text = data['businessName']?.toString() ?? data['propertyName']?.toString() ?? '';
        _regEmailController.text = data['email']?.toString() ?? '';
        _regPhoneController.text = data['phone']?.toString() ?? data['mobileNumber']?.toString() ?? '';
      }
    }
  }

  // Future<void> _saveUser(Map<String, dynamic> userData) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String usersJson = prefs.getString('registered_users') ?? '[]';
  //     List<dynamic> users = jsonDecode(usersJson);
  //
  //     final normalizedEmail = userData['email'].toString().toLowerCase().trim();
  //     userData['email'] = normalizedEmail;
  //
  //     // Ensure propertyType is set using the stored _propertyType
  //     if (!userData.containsKey('propertyType') ||
  //         userData['propertyType'] == null ||
  //         userData['propertyType'].toString().isEmpty) {
  //       userData['propertyType'] = _propertyType;
  //     }
  //
  //     print('=== SAVING USER ===');
  //     print('Property Type being saved: "${userData['propertyType']}"');
  //     print('Stored _propertyType: "$_propertyType"');
  //
  //     bool userExists = false;
  //     for (int i = 0; i < users.length; i++) {
  //       final existingEmail = users[i]['email']?.toString().toLowerCase().trim() ?? '';
  //       if (existingEmail == normalizedEmail) {
  //         users[i] = userData;
  //         userExists = true;
  //         print('Updated existing user: $normalizedEmail');
  //         break;
  //       }
  //     }
  //
  //     if (!userExists) {
  //       users.add(userData);
  //       print('Added new user: $normalizedEmail');
  //     }
  //
  //     await prefs.setString('registered_users', jsonEncode(users));
  //     print('User saved with propertyType: ${userData['propertyType']}');
  //   } catch (e) {
  //     print('Error saving user: $e');
  //   }
  // }
  Future<void> _saveUser(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      List<dynamic> users = jsonDecode(usersJson);

      final normalizedEmail = userData['email'].toString().toLowerCase().trim();
      userData['email'] = normalizedEmail;

      // Ensure propertyType is set using the stored _propertyType
      if (!userData.containsKey('propertyType') ||
          userData['propertyType'] == null ||
          userData['propertyType'].toString().isEmpty) {
        userData['propertyType'] = _propertyType;
      }

      print('=== SAVING USER ===');
      print('Property Type being saved: "${userData['propertyType']}"');
      print('Data keys being saved: ${userData.keys.toList()}');

      // CRITICAL: Make sure all hotel data is preserved
      if (_propertyType == 'hotel') {
        print('Hotel data being saved:');
        print('- selectedRoomTypes exists: ${userData.containsKey('selectedRoomTypes')}');
        print('- roomDetails exists: ${userData.containsKey('roomDetails')}');
        print('- basicAmenities exists: ${userData.containsKey('basicAmenities')}');
      }

      bool userExists = false;
      for (int i = 0; i < users.length; i++) {
        final existingEmail = users[i]['email']?.toString().toLowerCase().trim() ?? '';
        if (existingEmail == normalizedEmail) {
          users[i] = userData;
          userExists = true;
          print('Updated existing user: $normalizedEmail');
          break;
        }
      }

      if (!userExists) {
        users.add(userData);
        print('Added new user: $normalizedEmail');
      }

      await prefs.setString('registered_users', jsonEncode(users));
      print('User saved successfully with all data');
    } catch (e) {
      print('Error saving user: $e');
    }
  }
  Future<Map<String, dynamic>?> _getUser(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      final normalizedEmail = email.toLowerCase().trim();

      for (var user in users) {
        final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
        if (storedEmail == normalizedEmail) {
          print('=== FOUND USER ===');
          print('User propertyType: "${user['propertyType']}"');
          print('User keys: ${user.keys.toList()}');

          // CRITICAL: Check if hotel data exists
          if (user['propertyType'] == 'hotel') {
            print('Hotel data in user:');
            print('- selectedRoomTypes exists: ${user.containsKey('selectedRoomTypes')}');
            print('- roomDetails exists: ${user.containsKey('roomDetails')}');
            print('- basicAmenities exists: ${user.containsKey('basicAmenities')}');
          }

          return Map<String, dynamic>.from(user);
        }
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  // Future<Map<String, dynamic>?> _getUser(String email) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String usersJson = prefs.getString('registered_users') ?? '[]';
  //     final List<dynamic> users = jsonDecode(usersJson);
  //
  //     final normalizedEmail = email.toLowerCase().trim();
  //
  //     for (var user in users) {
  //       final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
  //       if (storedEmail == normalizedEmail) {
  //         print('=== FOUND USER ===');
  //         print('User propertyType: "${user['propertyType']}"');
  //         print('User keys: ${user.keys.toList()}');
  //         return Map<String, dynamic>.from(user);
  //       }
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error getting user: $e');
  //     return null;
  //   }
  // }

  Future<bool> _validateCredentials(String email, String password) async {
    final user = await _getUser(email);
    return user != null && user['password'] == password;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  void _clearAllForms() {
    _loginEmailController.clear();
    _loginPasswordController.clear();
    _regNameController.clear();
    _regBusinessController.clear();
    _regEmailController.clear();
    _regPhoneController.clear();
    _regPasswordController.clear();
    _regConfirmPasswordController.clear();

    _loginErrors.clear();
    _regErrors.clear();

    setState(() {
      _showLoginPassword = false;
      _showRegPassword = false;
      _showConfirmPassword = false;
    });
  }

  Future<void> _handleRegister() async {
    setState(() {
      _regErrors.clear();
    });

    final fullName = _regNameController.text.trim();
    final businessName = _regBusinessController.text.trim();
    final email = _regEmailController.text.trim();
    final phone = _regPhoneController.text.trim();
    final password = _regPasswordController.text;
    final confirmPassword = _regConfirmPasswordController.text;

    bool hasErrors = false;

    if (fullName.isEmpty) {
      _regErrors['fullName'] = 'Full name is required';
      hasErrors = true;
    }

    if (businessName.isEmpty) {
      _regErrors['businessName'] = 'Business name is required';
      hasErrors = true;
    }

    if (email.isEmpty) {
      _regErrors['email'] = 'Email is required';
      hasErrors = true;
    } else if (!_isValidEmail(email)) {
      _regErrors['email'] = 'Enter a valid email address';
      hasErrors = true;
    }

    if (phone.isEmpty) {
      _regErrors['phone'] = 'Phone number is required';
      hasErrors = true;
    } else if (!_isValidPhone(phone)) {
      _regErrors['phone'] = 'Enter a valid 10-digit phone number';
      hasErrors = true;
    }

    if (password.isEmpty) {
      _regErrors['password'] = 'Password is required';
      hasErrors = true;
    } else if (!_isValidPassword(password)) {
      _regErrors['password'] = 'Password must be at least 6 characters';
      hasErrors = true;
    }

    if (confirmPassword.isEmpty) {
      _regErrors['confirmPassword'] = 'Please confirm your password';
      hasErrors = true;
    } else if (password != confirmPassword) {
      _regErrors['confirmPassword'] = 'Passwords do not match';
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final existingUser = await _getUser(email);
    if (existingUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email already registered. Please login.'),
          backgroundColor: Colors.orange,
        ),
      );
      _tabController.animateTo(0);
      _loginEmailController.text = email;
      _loginPasswordController.text = password;
      return;
    }

    setState(() => _isRegistering = true);

    try {
      final Map<String, dynamic> userData = {};

      // CRITICAL: Set property type using the stored _propertyType
      userData['propertyType'] = _propertyType;

      print('=== REGISTRATION ===');
      print('Setting propertyType to: "${userData['propertyType']}"');

      // Add registration data if available
      if (widget.registrationData != null && widget.registrationData!.isNotEmpty) {
        userData.addAll(widget.registrationData!);
        print('Added registration data with keys: ${widget.registrationData!.keys.toList()}');
      }

      // Add user account data
      userData['fullName'] = fullName;
      userData['businessName'] = businessName;
      userData['email'] = email.toLowerCase().trim();
      userData['phone'] = phone;
      userData['password'] = password;
      userData['registeredAt'] = DateTime.now().toIso8601String();
      userData['lastLogin'] = DateTime.now().toIso8601String();

      await _saveUser(userData);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_email', email.toLowerCase().trim());

      if (!mounted) return;

      setState(() => _isRegistering = false);
      _clearAllForms();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Please login.'),
          backgroundColor: Colors.green,
        ),
      );

      _tabController.animateTo(0);
      _loginEmailController.text = email;
      _loginPasswordController.text = password;

    } catch (e) {
      setState(() => _isRegistering = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleLogin() async {
    setState(() {
      _loginErrors.clear();
    });

    final email = _loginEmailController.text.trim();
    final password = _loginPasswordController.text;

    bool hasErrors = false;

    if (email.isEmpty) {
      _loginErrors['email'] = 'Email is required';
      hasErrors = true;
    } else if (!_isValidEmail(email)) {
      _loginErrors['email'] = 'Enter a valid email address';
      hasErrors = true;
    }

    if (password.isEmpty) {
      _loginErrors['password'] = 'Password is required';
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() {});
      return;
    }

    setState(() => _isLoggingIn = true);

    try {
      final isValid = await _validateCredentials(email, password);

      if (!isValid) {
        setState(() {
          _isLoggingIn = false;
          _loginErrors['email'] = 'Invalid email or password';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final userData = await _getUser(email);

      if (userData == null) {
        setState(() => _isLoggingIn = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User data not found'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // SIMPLE: Get property type from userData or fallback to widget
      String propertyType = '';

      if (userData.containsKey('propertyType') && userData['propertyType'] != null) {
        propertyType = userData['propertyType'].toString().toLowerCase().trim();
      }

      // If not found in userData, use the widget's property type
      if (propertyType.isEmpty) {
        propertyType = _propertyType;
      }

      print('=== LOGIN ===');
      print('Property Type from userData: "${userData['propertyType']}"');
      print('Stored _propertyType: "$_propertyType"');
      print('Final propertyType: "$propertyType"');

      if (propertyType.isEmpty) {
        // Last resort - check data structure
        if (userData.containsKey('basicInfo')) {
          propertyType = 'villa';
        } else if (userData.containsKey('hotelName')) {
          propertyType = 'hotel';
        } else if (userData.containsKey('apartmentName')) {
          propertyType = 'apartment';
        } else if (userData.containsKey('resortName')) {
          propertyType = 'resort';
        }
      }

      // Update userData with the detected property type
      userData['propertyType'] = propertyType;
      userData['lastLogin'] = DateTime.now().toIso8601String();
      await _saveUser(userData);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_email', email.toLowerCase().trim());

      if (!mounted) return;

      setState(() => _isLoggingIn = false);
      _clearAllForms();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      _navigateToDashboard(userData, propertyType);

    } catch (e) {
      setState(() => _isLoggingIn = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Future<void> _handleRegister() async {
  //   setState(() {
  //     _regErrors.clear();
  //   });
  //
  //   final fullName = _regNameController.text.trim();
  //   final businessName = _regBusinessController.text.trim();
  //   final email = _regEmailController.text.trim();
  //   final phone = _regPhoneController.text.trim();
  //   final password = _regPasswordController.text;
  //   final confirmPassword = _regConfirmPasswordController.text;
  //
  //   bool hasErrors = false;
  //
  //   if (fullName.isEmpty) {
  //     _regErrors['fullName'] = 'Full name is required';
  //     hasErrors = true;
  //   }
  //
  //   if (businessName.isEmpty) {
  //     _regErrors['businessName'] = 'Business name is required';
  //     hasErrors = true;
  //   }
  //
  //   if (email.isEmpty) {
  //     _regErrors['email'] = 'Email is required';
  //     hasErrors = true;
  //   } else if (!_isValidEmail(email)) {
  //     _regErrors['email'] = 'Enter a valid email address';
  //     hasErrors = true;
  //   }
  //
  //   if (phone.isEmpty) {
  //     _regErrors['phone'] = 'Phone number is required';
  //     hasErrors = true;
  //   } else if (!_isValidPhone(phone)) {
  //     _regErrors['phone'] = 'Enter a valid 10-digit phone number';
  //     hasErrors = true;
  //   }
  //
  //   if (password.isEmpty) {
  //     _regErrors['password'] = 'Password is required';
  //     hasErrors = true;
  //   } else if (!_isValidPassword(password)) {
  //     _regErrors['password'] = 'Password must be at least 6 characters';
  //     hasErrors = true;
  //   }
  //
  //   if (confirmPassword.isEmpty) {
  //     _regErrors['confirmPassword'] = 'Please confirm your password';
  //     hasErrors = true;
  //   } else if (password != confirmPassword) {
  //     _regErrors['confirmPassword'] = 'Passwords do not match';
  //     hasErrors = true;
  //   }
  //
  //   if (hasErrors) {
  //     setState(() {});
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please correct the highlighted fields'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   final existingUser = await _getUser(email);
  //   if (existingUser != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Email already registered. Please login.'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     _tabController.animateTo(0);
  //     _loginEmailController.text = email;
  //     _loginPasswordController.text = password;
  //     return;
  //   }
  //
  //   setState(() => _isRegistering = true);
  //
  //   try {
  //     // Create a clean user data structure
  //     final Map<String, dynamic> userData = {};
  //
  //     // CRITICAL: Set property type
  //     userData['propertyType'] = _propertyType;
  //
  //     // Add user account data
  //     userData['fullName'] = fullName;
  //     userData['businessName'] = businessName;
  //     userData['email'] = email.toLowerCase().trim();
  //     userData['phone'] = phone;
  //     userData['password'] = password;
  //     userData['registeredAt'] = DateTime.now().toIso8601String();
  //     userData['lastLogin'] = DateTime.now().toIso8601String();
  //
  //     // IMPORTANT: Store ALL registration data in a single field
  //     if (widget.registrationData != null && widget.registrationData!.isNotEmpty) {
  //       print('=== STORING REGISTRATION DATA ===');
  //       print('Registration data keys: ${widget.registrationData!.keys.toList()}');
  //
  //       // Store the complete registration data in a nested field
  //       userData['registrationData'] = widget.registrationData;
  //
  //       // Also store key fields at top level for backward compatibility
  //       userData.addAll(widget.registrationData!);
  //     }
  //
  //     print('=== SAVING USER ===');
  //     print('Property Type: "${userData['propertyType']}"');
  //     print('User data keys: ${userData.keys.toList()}');
  //
  //     await _saveUser(userData);
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('is_logged_in', true);
  //     await prefs.setString('current_user_email', email.toLowerCase().trim());
  //
  //     if (!mounted) return;
  //
  //     setState(() => _isRegistering = false);
  //     _clearAllForms();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Registration successful!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     // Navigate directly to dashboard instead of showing login tab
  //     _navigateToDashboard(userData, _propertyType);
  //
  //   } catch (e) {
  //     setState(() => _isRegistering = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Registration failed: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }
  // Future<void> _handleLogin() async {
  //   setState(() {
  //     _loginErrors.clear();
  //   });
  //
  //   final email = _loginEmailController.text.trim();
  //   final password = _loginPasswordController.text;
  //
  //   bool hasErrors = false;
  //
  //   if (email.isEmpty) {
  //     _loginErrors['email'] = 'Email is required';
  //     hasErrors = true;
  //   } else if (!_isValidEmail(email)) {
  //     _loginErrors['email'] = 'Enter a valid email address';
  //     hasErrors = true;
  //   }
  //
  //   if (password.isEmpty) {
  //     _loginErrors['password'] = 'Password is required';
  //     hasErrors = true;
  //   }
  //
  //   if (hasErrors) {
  //     setState(() {});
  //     return;
  //   }
  //
  //   setState(() => _isLoggingIn = true);
  //
  //   try {
  //     final userData = await _getUser(email);
  //
  //     if (userData == null) {
  //       setState(() {
  //         _isLoggingIn = false;
  //         _loginErrors['email'] = 'User not found';
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Invalid email or password'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     // Verify password
  //     if (userData['password'] != password) {
  //       setState(() {
  //         _isLoggingIn = false;
  //         _loginErrors['password'] = 'Incorrect password';
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Invalid email or password'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     // Get property type
  //     String propertyType = userData['propertyType']?.toString().toLowerCase().trim() ?? _propertyType;
  //
  //     print('=== LOGIN SUCCESSFUL ===');
  //     print('Email: $email');
  //     print('Property Type: $propertyType');
  //     print('User data keys: ${userData.keys.toList()}');
  //
  //     // Check if registration data exists
  //     if (userData.containsKey('registrationData')) {
  //       print('Registration data found with keys: ${(userData['registrationData'] as Map).keys.toList()}');
  //     }
  //
  //     // Update last login
  //     userData['lastLogin'] = DateTime.now().toIso8601String();
  //     await _saveUser(userData);
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('is_logged_in', true);
  //     await prefs.setString('current_user_email', email.toLowerCase().trim());
  //
  //     if (!mounted) return;
  //
  //     setState(() => _isLoggingIn = false);
  //     _clearAllForms();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Login successful!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     _navigateToDashboard(userData, propertyType);
  //
  //   } catch (e) {
  //     setState(() => _isLoggingIn = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login error: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  void _navigateToDashboard(Map<String, dynamic> userData, String propertyType) {
    print('=== NAVIGATING TO DASHBOARD ===');
    print('Property Type: "$propertyType"');

    if (propertyType == 'villa') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VillaOwnerDashboard(
            registrationData: userData,
            villaName: _getVillaName(userData),
            ownerName: _getOwnerName(userData),
            mobileNumber: _getMobileNumber(userData),
            email: _getEmail(userData),
            address: _getNestedValue(userData, ['location', 'address'], ''),
            area: _getNestedValue(userData, ['location', 'area'], ''),
            city: _getNestedValue(userData, ['location', 'city'], ''),
            state: _getNestedValue(userData, ['location', 'state'], ''),
            pincode: _getNestedValue(userData, ['location', 'pincode'], ''),
            propertyType: _getNestedValue(userData, ['propertyDetails', 'propertyType'], 'Villa'),
            bedrooms: _getNestedInt(userData, ['propertyDetails', 'bedrooms'], 0),
            bathrooms: _getNestedInt(userData, ['propertyDetails', 'bathrooms'], 0),
            guestCapacity: _getNestedInt(userData, ['propertyDetails', 'guestCapacity'], 0),
            propertySize: _getNestedValue(userData, ['propertyDetails', 'propertySize'], ''),
            yearConstruction: _getNestedValue(userData, ['propertyDetails', 'yearConstruction'], ''),
            description: _getNestedValue(userData, ['propertyDetails', 'description'], ''),
            villaAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weekendPrice: _getNestedValue(userData, ['pricing', 'weekendPrice'], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            securityDeposit: _getNestedValue(userData, ['pricing', 'securityDeposit'], ''),
            minimumStay: _getNestedValue(userData, ['pricing', 'minimumStay'], ''),
            checkInTime: _getNestedValue(userData, ['pricing', 'checkInTime'], ''),
            checkOutTime: _getNestedValue(userData, ['pricing', 'checkOutTime'], ''),
            cancellationPolicy: _getMapValue(userData, ['pricing', 'cancellationPolicy']),
            availabilityCalendar: _getMapValue(userData, ['pricing', 'availabilityCalendar']),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            gstNumber: _getNestedValue(userData, ['legal', 'gstNumber'], ''),
            tradeLicense: _getNestedValue(userData, ['legal', 'tradeLicense'], ''),
            accountHolderName: _getNestedValue(userData, ['bank', 'accountHolder'], ''),
            bankName: _getNestedValue(userData, ['bank', 'bankName'], ''),
            accountNumber: _getNestedValue(userData, ['bank', 'accountNumber'], ''),
            ifscCode: _getNestedValue(userData, ['bank', 'ifscCode'], ''),
            upiId: _getNestedValue(userData, ['bank', 'upiId'], ''),
            cancelledCheque: _getMapValue(userData, ['bank', 'cancelledCheque']),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            hasDigitalSignature: _getNestedBool(userData, ['signature', 'hasDigital'], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, ['signature', 'declarationAccepted'], false),
            altMobile: _getNestedValue(userData, ['basicInfo', 'altMobile'], ''),
            website: _getNestedValue(userData, ['basicInfo', 'website'], ''),
            googleMapLink: _getNestedValue(userData, ['location', 'googleMapLink'], ''),
          ),
        ),
      );
    } else if (propertyType == 'hotel') {
      print('=== Creating Normal Hotel Dashboard ===');

      // Get registration data
      Map<String, dynamic> regData = {};
      if (userData.containsKey('registrationData') && userData['registrationData'] != null) {
        regData = Map<String, dynamic>.from(userData['registrationData']);
        print('Found registration data with keys: ${regData.keys.toList()}');
      } else {
        print('No registration data found, using userData directly');
        regData = Map<String, dynamic>.from(userData);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NormalHotelDashboard(
            registrationData: regData,
            hotelName: regData['hotelName']?.toString() ?? userData['businessName']?.toString() ?? '',
            ownerName: regData['ownerName']?.toString() ?? userData['fullName']?.toString() ?? '',
            mobileNumber: regData['mobileNumber']?.toString() ?? userData['phone']?.toString() ?? '',
            email: regData['email']?.toString() ?? userData['email']?.toString() ?? '',
            addressLine1: regData['addressLine1']?.toString() ?? '',
            city: regData['city']?.toString() ?? '',
            state: regData['state']?.toString() ?? '',
            pinCode: regData['pinCode']?.toString() ?? '',
            totalRooms: regData['totalRooms'] ?? 0,
            hotelType: regData['hotelType']?.toString() ?? 'Normal',
            selectedRoomTypes: Map<String, bool>.from(regData['selectedRoomTypes'] ?? {}),
            roomDetails: Map<String, Map<String, dynamic>>.from(regData['roomDetails'] ?? {}),
            basicAmenities: Map<String, bool>.from(regData['basicAmenities'] ?? {}),
            hotelFacilities: Map<String, bool>.from(regData['hotelFacilities'] ?? {}),
            foodServices: Map<String, bool>.from(regData['foodServices'] ?? {}),
            additionalAmenities: Map<String, bool>.from(regData['additionalAmenities'] ?? {}),
            customAmenities: List<String>.from(regData['customAmenities'] ?? []),
            uploadedFiles: Map<String, Map<String, dynamic>>.from(regData['uploadedFiles'] ?? {}),
            personPhotoInfo: Map<String, dynamic>.from(regData['personPhotoInfo'] ?? {}),
            digitalSignatureImage: regData['digitalSignatureImage'] as Uint8List?,
          ),
        ),
      );
    }
    // } else if (propertyType == 'hotel') {
    //   print('=== Creating Hotel Profile Page ===');
    //   print('Full userData keys: ${userData.keys.toList()}');
    //
    //   // Extract all hotel data from userData
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HotelOwnerProfilePage(
    //         // Basic Information
    //         hotelName: userData['hotelName']?.toString() ?? userData['businessName']?.toString() ?? '',
    //         hotelType: userData['hotelType']?.toString() ?? '',
    //         yearOfEstablishment: userData['yearOfEstablishment']?.toString() ?? '',
    //         totalRooms: int.tryParse(userData['totalRooms']?.toString() ?? '0') ?? 0,
    //
    //         // Contact Information
    //         ownerName: userData['ownerName']?.toString() ?? userData['fullName']?.toString() ?? '',
    //         mobileNumber: userData['mobileNumber']?.toString() ?? userData['phone']?.toString() ?? '',
    //         alternateContact: userData['alternateContact']?.toString() ?? '',
    //         landlineNumbers: List<String>.from(userData['landlineNumbers'] ?? []),
    //         email: userData['email']?.toString() ?? '',
    //         website: userData['website']?.toString() ?? '',
    //
    //         // Address Information
    //         addressLine1: userData['addressLine1']?.toString() ?? '',
    //         addressLine2: userData['addressLine2']?.toString() ?? '',
    //         city: userData['city']?.toString() ?? '',
    //         district: userData['district']?.toString() ?? '',
    //         state: userData['state']?.toString() ?? '',
    //         pinCode: userData['pinCode']?.toString() ?? '',
    //         landmark: userData['landmark']?.toString() ?? '',
    //
    //         // Room Configuration
    //         selectedRoomTypes: _getMapBool(userData, 'selectedRoomTypes'),
    //         roomDetails: _getRoomDetailsMap(userData, 'roomDetails'),
    //         minTariff: userData['minTariff']?.toString() ?? '',
    //         maxTariff: userData['maxTariff']?.toString() ?? '',
    //         extraBedAvailable: userData['extraBedAvailable'] ?? false,
    //
    //         // Amenities
    //         basicAmenities: _getMapBool(userData, 'basicAmenities'),
    //         hotelFacilities: _getMapBool(userData, 'hotelFacilities'),
    //         foodServices: _getMapBool(userData, 'foodServices'),
    //         additionalAmenities: _getMapBool(userData, 'additionalAmenities'),
    //         customAmenities: List<String>.from(userData['customAmenities'] ?? []),
    //
    //         // Legal Details
    //         gstNumber: userData['gstNumber']?.toString() ?? '',
    //         fssaiLicense: userData['fssaiLicense']?.toString() ?? '',
    //         tradeLicense: userData['tradeLicense']?.toString() ?? '',
    //         aadharNumber: userData['aadharNumber']?.toString() ?? '',
    //         panNumber: userData['panNumber']?.toString(),
    //
    //         // Bank Details
    //         accountHolderName: userData['accountHolderName']?.toString() ?? '',
    //         bankName: userData['bankName']?.toString() ?? '',
    //         accountNumber: userData['accountNumber']?.toString() ?? '',
    //         ifscCode: userData['ifscCode']?.toString() ?? '',
    //         branch: userData['branch']?.toString() ?? '',
    //         accountType: userData['accountType']?.toString() ?? '',
    //
    //         // Uploaded Files
    //         uploadedFiles: _getUploadedFilesMap(userData, 'uploadedFiles'),
    //         personPhotoInfo: _getMapDynamic(userData, 'personPhotoInfo'),
    //
    //         // Signature & Declaration
    //         signatureName: userData['signatureName']?.toString() ?? '',
    //         declarationName: userData['declarationName']?.toString() ?? '',
    //         declarationDate: _getDateTime(userData['declarationDate']),
    //         declarationAccepted: userData['declarationAccepted'] ?? false,
    //
    //         // Hotel Category
    //         hotelCategory: userData['hotelCategory']?.toString() ?? 'Normal',
    //
    //         // Digital Signature
    //         hasDigitalSignature: userData['hasDigitalSignature'] ?? false,
    //         digitalSignatureImage: userData['digitalSignatureImage'] as Uint8List?,
    //
    //         // 2-Star+ fields
    //         designation: userData['designation']?.toString(),
    //         checkInTime: userData['checkInTime']?.toString(),
    //         checkOutTime: userData['checkOutTime']?.toString(),
    //         roomAmenities: _getMapBool(userData, 'roomAmenities'),
    //         guestServices: _getMapBool(userData, 'guestServices'),
    //         coupleFriendly: userData['coupleFriendly'] as bool?,
    //         petsAllowed: userData['petsAllowed'] as bool?,
    //         selectedIdProof: userData['selectedIdProof']?.toString(),
    //         idProofFiles: _getIdProofFilesMap(userData, 'idProofFiles'),
    //
    //         // 3-Star+ fields
    //         registrationNumber: userData['registrationNumber']?.toString(),
    //         signatoryName: userData['signatoryName']?.toString(),
    //         seasonalPricing: userData['seasonalPricing'] as bool?,
    //         earlyCheckinAllowed: userData['earlyCheckinAllowed'] as bool?,
    //         earlyCheckinChargeable: userData['earlyCheckinChargeable'] as bool?,
    //         fireSafetyCertificate: userData['fireSafetyCertificate'] as bool?,
    //         businessServices: _getMapBool(userData, 'businessServices'),
    //
    //         // 4-Star+ fields
    //         starCertificate: userData['starCertificate'] as bool?,
    //         wellnessRecreation: _getMapBool(userData, 'wellnessRecreation'),
    //
    //         // 5-Star+ fields
    //         brandName: userData['brandName']?.toString(),
    //         starCertNumber: userData['starCertNumber']?.toString(),
    //         pollutionCertificate: userData['pollutionCertificate'] as bool?,
    //         liftCertificate: userData['liftCertificate'] as bool?,
    //         diningServices: _getMapBool(userData, 'diningServices'),
    //         wellnessRecreation5Star: _getMapBool(userData, 'wellnessRecreation5Star'),
    //
    //         // 6-Star fields
    //         globalRecognition: userData['globalRecognition']?.toString(),
    //         gmName: userData['gmName']?.toString(),
    //         country: userData['country']?.toString(),
    //         personalButler: userData['personalButler'] as bool?,
    //         aiPricing: userData['aiPricing'] as bool?,
    //         vipProtocols: userData['vipProtocols'] as bool?,
    //         petLuxuryServices: userData['petLuxuryServices'] as bool?,
    //         fireSafetyNoc: userData['fireSafetyNoc'] as bool?,
    //         environmentalCert: userData['environmentalCert'] as bool?,
    //         internationalCert: userData['internationalCert'] as bool?,
    //         hotelInfrastructure: _getMapBool(userData, 'hotelInfrastructure'),
    //         diningExperiences: _getMapBool(userData, 'diningExperiences'),
    //         wellnessLeisure: _getMapBool(userData, 'wellnessLeisure'),
    //         guestPrivileges: _getMapBool(userData, 'guestPrivileges'),
    //         additionalAddresses: userData['additionalAddresses'] as List?,
    //       ),
    //     ),
    //   );
    // }
    else if (propertyType == 'apartment') {
      print('=== Creating Apartment Dashboard ===');
      print('Full userData keys: ${userData.keys.toList()}');

      if (userData.containsKey('basicInfo')) {
        print('basicInfo exists with keys: ${(userData['basicInfo'] as Map).keys.toList()}');
        final basicInfo = userData['basicInfo'] as Map;
        print('basicInfo["apartmentName"] = "${basicInfo['apartmentName']}"');
        print('basicInfo["ownerName"] = "${basicInfo['ownerName']}"');
      }

      String apartmentName = _getApartmentName(userData);
      String ownerName = _getOwnerName(userData);

      print('Extracted apartmentName: "$apartmentName"');
      print('Extracted ownerName: "$ownerName"');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ApartmentOwnerDashboard(
            registrationData: userData,
            apartmentName: _getApartmentName(userData),
            ownerName: _getOwnerName(userData),
            mobileNumber: _getMobileNumber(userData),
            email: _getEmail(userData),
            altMobile: _getAltMobile(userData),
            companyName: _getCompanyName(userData),
            website: _getWebsite(userData),
            address: _getNestedValue(userData, ['location', 'address'], ''),
            area: _getNestedValue(userData, ['location', 'area'], ''),
            city: _getNestedValue(userData, ['location', 'city'], ''),
            state: _getNestedValue(userData, ['location', 'state'], ''),
            pincode: _getNestedValue(userData, ['location', 'pincode'], ''),
            googleMapLink: _getNestedValue(userData, ['location', 'googleMapLink'], ''),
            propertyType: _getNestedValue(userData, ['propertyDetails', 'propertyType'], 'Apartment'),
            totalUnits: _getNestedValue(userData, ['propertyDetails', 'totalUnits'], '0'),
            totalBedrooms: _getNestedValue(userData, ['propertyDetails', 'totalBedrooms'], '0'),
            totalBathrooms: _getNestedValue(userData, ['propertyDetails', 'totalBathrooms'], '0'),
            guestCapacity: _getNestedValue(userData, ['propertyDetails', 'guestCapacity'], '0'),
            floorNumber: _getNestedValue(userData, ['propertyDetails', 'floorNumber'], ''),
            totalFloors: _getNestedValue(userData, ['propertyDetails', 'totalFloors'], ''),
            elevatorAvailable: _getNestedValue(userData, ['propertyDetails', 'elevatorAvailable'], ''),
            propertySize: _getNestedValue(userData, ['propertyDetails', 'propertySize'], ''),
            yearConstruction: _getNestedValue(userData, ['propertyDetails', 'yearConstruction'], ''),
            description: _getNestedValue(userData, ['propertyDetails', 'description'], ''),
            apartmentAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weeklyPrice: _getNestedValue(userData, ['pricing', 'weeklyPrice'], ''),
            monthlyPrice: _getNestedValue(userData, ['pricing', 'monthlyPrice'], ''),
            weekendPrice: _getNestedValue(userData, ['pricing', 'weekendPrice'], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            securityDeposit: _getNestedValue(userData, ['pricing', 'securityDeposit'], ''),
            minimumStay: _getNestedValue(userData, ['pricing', 'minimumStay'], ''),
            advancePayment: _getNestedValue(userData, ['pricing', 'advancePayment'], ''),
            checkInTime: _getNestedValue(userData, ['pricing', 'checkInTime'], ''),
            checkOutTime: _getNestedValue(userData, ['pricing', 'checkOutTime'], ''),
            cancellationPolicy: _getMapValue(userData, ['pricing', 'cancellationPolicy']),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            cancelledCheque: _getMapValue(userData, ['bank', 'cancelledCheque']),
            calendarSync: _getMapValue(userData, ['availability', 'calendarSync']),
            availableFromDate: _getDateTimeValue(userData, ['availability', 'availableFromDate']),
            blackoutDates: _getNestedValue(userData, ['availability', 'blackoutDates'], ''),
            instantBooking: _getNestedValue(userData, ['availability', 'instantBooking'], ''),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            smokingPolicy: _getNestedValue(userData, ['houseRules', 'smokingPolicy'], ''),
            petPolicy: _getNestedValue(userData, ['houseRules', 'petPolicy'], ''),
            eventPolicy: _getNestedValue(userData, ['houseRules', 'eventPolicy'], ''),
            visitorPolicy: _getNestedValue(userData, ['houseRules', 'visitorPolicy'], ''),
            quietHours: _getNestedValue(userData, ['houseRules', 'quietHours'], ''),
            additionalRules: _getNestedValue(userData, ['houseRules', 'additionalRules'], ''),
            hasDigitalSignature: _getNestedBool(userData, ['signature', 'hasDigital'], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, ['declarationAccepted'], false),
            vendorStatus: _getNestedValue(userData, ['adminFields', 'vendorStatus'], 'Pending'),
            featuredListing: _getNestedBool(userData, ['adminFields', 'featuredListing'], false),
            verifiedBadge: _getNestedBool(userData, ['adminFields', 'verifiedBadge'], false),
            ratingScore: _getNestedDouble(userData, ['adminFields', 'ratingScore'], 0.0),
            remarks: _getNestedValue(userData, ['adminFields', 'remarks'], ''),
          ),
        ),
      );
    } else if (propertyType == 'resort') {
      print('=== Creating Resort Dashboard ===');
      print('Full userData keys: ${userData.keys.toList()}');

      if (userData.containsKey('basicInfo')) {
        print('basicInfo exists with keys: ${(userData['basicInfo'] as Map).keys.toList()}');
        final basicInfo = userData['basicInfo'] as Map;
        print('basicInfo["resortName"] = "${basicInfo['resortName']}"');
        print('basicInfo["ownerName"] = "${basicInfo['ownerName']}"');
      }

      String resortName = _getResortName(userData);
      String ownerName = _getOwnerName(userData);

      print('Extracted resortName: "$resortName"');
      print('Extracted ownerName: "$ownerName"');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResortOwnerDashboard(
            registrationData: userData,
            resortName: _getResortName(userData),
            ownerName: _getOwnerName(userData),
            contactPerson: _getContactPerson(userData),
            mobileNumber: _getMobileNumber(userData),
            email: _getEmail(userData),
            altMobile: _getAltMobile(userData),
            website: _getWebsite(userData),
            companyName: _getCompanyName(userData),
            address: _getNestedValue(userData, ['location', 'address'], ''),
            area: _getNestedValue(userData, ['location', 'area'], ''),
            city: _getNestedValue(userData, ['location', 'city'], ''),
            state: _getNestedValue(userData, ['location', 'state'], ''),
            pincode: _getNestedValue(userData, ['location', 'pincode'], ''),
            googleMapLink: _getNestedValue(userData, ['location', 'googleMapLink'], ''),
            nearestAirport: _getNestedValue(userData, ['location', 'nearestAirport'], ''),
            nearestRailway: _getNestedValue(userData, ['location', 'nearestRailway'], ''),
            resortCategory: _getNestedValue(userData, ['propertyDetails', 'resortCategory'], ''),
            totalRooms: _getNestedValue(userData, ['propertyDetails', 'totalRooms'], '0'),
            totalCapacity: _getNestedValue(userData, ['propertyDetails', 'totalCapacity'], '0'),
            roomTypes: _getRoomTypes(userData),
            propertyArea: _getNestedValue(userData, ['propertyDetails', 'propertyArea'], ''),
            yearEstablished: _getNestedValue(userData, ['propertyDetails', 'yearEstablished'], ''),
            description: _getNestedValue(userData, ['propertyDetails', 'description'], ''),
            resortAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weekendPrice: _getNestedValue(userData, ['pricing', 'weekendPrice'], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            extraBedCharges: _getNestedValue(userData, ['pricing', 'extraBedCharges'], ''),
            childPolicy: _getNestedValue(userData, ['pricing', 'childPolicy'], ''),
            minimumStay: _getNestedValue(userData, ['pricing', 'minimumStay'], ''),
            advancePayment: _getNestedValue(userData, ['pricing', 'advancePayment'], ''),
            checkInTime: _getNestedValue(userData, ['pricing', 'checkInTime'], ''),
            checkOutTime: _getNestedValue(userData, ['pricing', 'checkOutTime'], ''),
            instantBooking: _getNestedValue(userData, ['availability', 'instantBooking'], ''),
            manualApproval: _getNestedValue(userData, ['availability', 'manualApproval'], ''),
            availableFromDate: _getDateTimeValue(userData, ['availability', 'availableFromDate']),
            blackoutDates: _getNestedValue(userData, ['availability', 'blackoutDates'], ''),
            seasonalPricing: _getNestedValue(userData, ['availability', 'seasonalPricing'], ''),
            cancellationPolicy: _getMapValue(userData, ['pricing', 'cancellationPolicy']),
            businessReg: _getMapValue(userData, ['legal', 'businessReg']),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            fireSafety: _getMapValue(userData, ['legal', 'fireSafety']),
            cancelledCheque: _getMapValue(userData, ['bank', 'cancelledCheque']),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            checkInRequirements: _getNestedValue(userData, ['houseRules', 'checkInRequirements'], ''),
            idProofRequired: _getNestedValue(userData, ['houseRules', 'idProofRequired'], ''),
            petPolicy: _getNestedValue(userData, ['houseRules', 'petPolicy'], ''),
            smokingPolicy: _getNestedValue(userData, ['houseRules', 'smokingPolicy'], ''),
            eventPolicy: _getNestedValue(userData, ['houseRules', 'eventPolicy'], ''),
            damagePolicy: _getNestedValue(userData, ['houseRules', 'damagePolicy'], ''),
            refundPolicy: _getNestedValue(userData, ['houseRules', 'refundPolicy'], ''),
            gstNumber: _getNestedValue(userData, ['legal', 'gstNumber'], ''),
            tradeLicense: _getNestedValue(userData, ['legal', 'tradeLicense'], ''),
            fssaiLicense: _getNestedValue(userData, ['legal', 'fssaiLicense'], ''),
            tourismApproval: _getNestedValue(userData, ['legal', 'tourismApproval'], ''),
            accountHolderName: _getNestedValue(userData, ['bank', 'accountHolder'], ''),
            bankName: _getNestedValue(userData, ['bank', 'bankName'], ''),
            accountNumber: _getNestedValue(userData, ['bank', 'accountNumber'], ''),
            ifscCode: _getNestedValue(userData, ['bank', 'ifscCode'], ''),
            upiId: _getNestedValue(userData, ['bank', 'upiId'], ''),
            gstBilling: _getNestedValue(userData, ['bank', 'gstBilling'], ''),
            hasDigitalSignature: _getNestedBool(userData, ['signature', 'hasDigital'], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, ['declarationAccepted'], false),
            vendorStatus: _getNestedValue(userData, ['adminFields', 'vendorStatus'], 'Pending'),
            featuredResort: _getNestedBool(userData, ['adminFields', 'featuredResort'], false),
            verifiedBadge: _getNestedBool(userData, ['adminFields', 'verifiedBadge'], false),
            ratingScore: _getNestedDouble(userData, ['adminFields', 'ratingScore'], 0.0),
            priorityListingLevel: _getNestedValue(userData, ['adminFields', 'priorityListingLevel'], 'Standard'),
            remarks: _getNestedValue(userData, ['adminFields', 'remarks'], ''),
          ),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unknown property type: $propertyType'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  // Helper method to safely get Map<String, bool>
  Map<String, bool> _getMapBool(Map<String, dynamic> data, String key) {
    if (data.containsKey(key) && data[key] != null) {
      final value = data[key];
      if (value is Map) {
        return Map<String, bool>.from(
            value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false))
        );
      }
    }
    return {};
  }

// Helper method to safely get Map<String, Map<String, dynamic>>
  Map<String, Map<String, dynamic>> _getRoomDetailsMap(Map<String, dynamic> data, String key) {
    if (data.containsKey(key) && data[key] != null) {
      final value = data[key];
      if (value is Map) {
        Map<String, Map<String, dynamic>> result = {};
        value.forEach((k, v) {
          if (v is Map) {
            Map<String, dynamic> innerMap = {};
            v.forEach((ik, iv) {
              innerMap[ik.toString()] = iv;
            });
            result[k.toString()] = innerMap;
          }
        });
        return result;
      }
    }
    return {};
  }

// Helper method to safely get Map<String, dynamic>
  Map<String, dynamic> _getMapDynamic(Map<String, dynamic> data, String key) {
    if (data.containsKey(key) && data[key] != null && data[key] is Map) {
      return Map<String, dynamic>.from(data[key] as Map);
    }
    return {};
  }

// Helper method to safely get uploaded files map
  Map<String, Map<String, dynamic>> _getUploadedFilesMap(Map<String, dynamic> data, String key) {
    if (data.containsKey(key) && data[key] != null) {
      final value = data[key];
      if (value is Map) {
        Map<String, Map<String, dynamic>> result = {};
        value.forEach((k, v) {
          if (v is Map) {
            Map<String, dynamic> innerMap = {};
            v.forEach((ik, iv) {
              innerMap[ik.toString()] = iv;
            });
            result[k.toString()] = innerMap;
          }
        });
        return result;
      }
    }
    return {};
  }

// Helper method to safely get id proof files map
  Map<String, Map<String, dynamic>>? _getIdProofFilesMap(Map<String, dynamic> data, String key) {
    if (data.containsKey(key) && data[key] != null) {
      final value = data[key];
      if (value is Map) {
        Map<String, Map<String, dynamic>> result = {};
        value.forEach((k, v) {
          if (v is Map) {
            Map<String, dynamic> innerMap = {};
            v.forEach((ik, iv) {
              innerMap[ik.toString()] = iv;
            });
            result[k.toString()] = innerMap;
          }
        });
        return result;
      }
    }
    return null;
  }

// Helper method to safely get DateTime
  DateTime? _getDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
  String _getApartmentName(Map<String, dynamic> data) {
    print('=== _getApartmentName called ===');
    print('Data keys: ${data.keys.toList()}');

    // Try to get from basicInfo first (nested structure)
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      print('Found basicInfo');
      final basicInfo = data['basicInfo'] as Map;
      print('basicInfo keys: ${basicInfo.keys.toList()}');

      if (basicInfo.containsKey('apartmentName')) {
        String value = basicInfo['apartmentName']?.toString() ?? '';
        print('Found apartmentName in basicInfo: "$value"');
        return value;
      } else {
        print('apartmentName not found in basicInfo');
      }
    } else {
      print('basicInfo not found in data');
    }

    // Try direct keys
    if (data.containsKey('apartmentName')) {
      String value = data['apartmentName']?.toString() ?? '';
      print('Found apartmentName as direct key: "$value"');
      return value;
    }

    // Try from propertyDetails
    if (data.containsKey('propertyDetails') && data['propertyDetails'] != null) {
      print('Found propertyDetails');
      final propertyDetails = data['propertyDetails'] as Map;
      print('propertyDetails keys: ${propertyDetails.keys.toList()}');

      if (propertyDetails.containsKey('apartmentName')) {
        String value = propertyDetails['apartmentName']?.toString() ?? '';
        print('Found apartmentName in propertyDetails: "$value"');
        return value;
      }
    }

    print('apartmentName not found anywhere, returning empty string');
    return '';
  }

  String _getOwnerName(Map<String, dynamic> data) {
    // Try from basicInfo first
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      final basicInfo = data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName')) {
        return basicInfo['ownerName']?.toString() ?? '';
      }
    }

    // Try direct keys
    if (data.containsKey('ownerName')) {
      return data['ownerName']?.toString() ?? '';
    }

    if (data.containsKey('fullName')) {
      return data['fullName']?.toString() ?? '';
    }

    return '';
  }

  String _getResortName(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      final basicInfo = data['basicInfo'] as Map;
      if (basicInfo.containsKey('resortName')) {
        return basicInfo['resortName']?.toString() ?? '';
      }
    }
    return data['resortName']?.toString() ?? '';
  }

  String _getContactPerson(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      final basicInfo = data['basicInfo'] as Map;
      if (basicInfo.containsKey('contactPerson')) {
        return basicInfo['contactPerson']?.toString() ?? '';
      }
    }
    return data['contactPerson']?.toString() ?? '';
  }

  Map<String, bool> _getRoomTypes(Map<String, dynamic> data) {
    if (data.containsKey('propertyDetails') && data['propertyDetails'] != null) {
      final propertyDetails = data['propertyDetails'] as Map;
      if (propertyDetails.containsKey('roomTypes')) {
        return Map<String, bool>.from(propertyDetails['roomTypes']);
      }
    }
    return {};
  }

  String _getAltMobile(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['altMobile']?.toString() ?? '';
    }
    return data['altMobile']?.toString() ?? '';
  }

  String _getCompanyName(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['companyName']?.toString() ?? '';
    }
    return data['companyName']?.toString() ?? '';
  }

  String _getWebsite(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['website']?.toString() ?? '';
    }
    return data['website']?.toString() ?? '';
  }

  DateTime? _getDateTimeValue(Map<String, dynamic> data, List<String> keys) {
    dynamic value = data;
    for (String key in keys) {
      if (value is Map && value.containsKey(key)) {
        value = value[key];
      } else {
        return null;
      }
    }
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  double _getNestedDouble(Map<String, dynamic> data, List<String> keys, double defaultValue) {
    dynamic value = data;
    for (String key in keys) {
      if (value is Map && value.containsKey(key)) {
        value = value[key];
      } else {
        return defaultValue;
      }
    }
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
  // Helper methods for data extraction
  String _getVillaName(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['villaName']?.toString() ?? '';
    }
    return data['villaName']?.toString() ?? '';
  }


  String _getMobileNumber(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['mobile']?.toString() ?? '';
    }
    return data['mobileNumber']?.toString() ?? data['phone']?.toString() ?? '';
  }

  String _getEmail(Map<String, dynamic> data) {
    if (data.containsKey('basicInfo') && data['basicInfo'] != null) {
      return data['basicInfo']['email']?.toString() ?? '';
    }
    return data['email']?.toString() ?? '';
  }

  String _getNestedValue(Map<String, dynamic> map, List<String> keys, String defaultValue) {
    dynamic value = map;
    for (String key in keys) {
      if (value is Map && value.containsKey(key)) {
        value = value[key];
      } else {
        return defaultValue;
      }
    }
    return value?.toString() ?? defaultValue;
  }

  int _getNestedInt(Map<String, dynamic> map, List<String> keys, int defaultValue) {
    final value = _getNestedValue(map, keys, '');
    return int.tryParse(value) ?? defaultValue;
  }

  bool _getNestedBool(Map<String, dynamic> map, List<String> keys, bool defaultValue) {
    dynamic value = map;
    for (String key in keys) {
      if (value is Map && value.containsKey(key)) {
        value = value[key];
      } else {
        return defaultValue;
      }
    }
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return defaultValue;
  }

  Map<String, dynamic> _getMapValue(Map<String, dynamic> map, List<String> keys) {
    dynamic value = map;
    for (String key in keys) {
      if (value is Map && value.containsKey(key)) {
        value = value[key];
      } else {
        return {};
      }
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return {};
  }

  Map<String, bool> _getAmenities(Map<String, dynamic> userData) {
    final amenities = _getMapValue(userData, ['amenities', 'selected']);
    return amenities.map((key, value) =>
        MapEntry(key.toString(), value is bool ? value : false)
    );
  }

  List<String> _getCustomAmenities(Map<String, dynamic> userData) {
    final custom = _getMapValue(userData, ['amenities', 'custom']);
    return custom.values.map((e) => e.toString()).toList();
  }

  Map<String, List<Map<String, dynamic>>> _getMediaFiles(Map<String, dynamic> userData) {
    final media = _getMapValue(userData, ['media']);
    final result = <String, List<Map<String, dynamic>>>{};

    media.forEach((key, value) {
      if (value is List) {
        List<Map<String, dynamic>> convertedList = [];
        for (var item in value) {
          if (item is Map) {
            Map<String, dynamic> stringMap = {};
            item.forEach((k, v) {
              stringMap[k.toString()] = v;
            });
            convertedList.add(stringMap);
          }
        }
        result[key.toString()] = convertedList;
      }
    });

    return result;
  }

  Uint8List? _getSignatureImage(Map<String, dynamic> userData) {
    final signature = _getMapValue(userData, ['signature']);
    if (signature.containsKey('digitalSignature') && signature['digitalSignature'] is Uint8List) {
      return signature['digitalSignature'];
    }
    return null;
  }

  DateTime? _getDeclarationDate(Map<String, dynamic> userData) {
    final signature = _getMapValue(userData, ['signature']);
    if (signature.containsKey('date')) {
      final date = signature['date'];
      if (date is DateTime) return date;
      if (date is String) return DateTime.tryParse(date);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFF0F4FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getPropertyTypeColor(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getPropertyTypeIcon(),
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _propertyType.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(Icons.business, size: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                _getTitleText(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),
              Text(
                _getSubtitleText(),
                style: const TextStyle(color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF6B7280),
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: const [
                    Tab(text: 'Login'),
                    Tab(text: 'Register'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildLoginTab(), _buildRegisterTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPropertyTypeColor() {
    switch (_propertyType) {
      case 'villa':
        return Colors.green;
      case 'hotel':
        return Colors.blue;
      case 'apartment':
        return Colors.orange;
      case 'resort':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getPropertyTypeIcon() {
    switch (_propertyType) {
      case 'villa':
        return Icons.villa;
      case 'hotel':
        return Icons.hotel;
      case 'apartment':
        return Icons.apartment;
      case 'resort':
        return Icons.beach_access;
      default:
        return Icons.business;
    }
  }

  String _getTitleText() {
    switch (_propertyType) {
      case 'villa':
        return "Villa Partner";
      case 'hotel':
        return "Hotel Partner";
      case 'apartment':
        return "Apartment Partner";
      case 'resort':
        return "Resort Partner";
      default:
        return "Property Partner";
    }
  }

  String _getSubtitleText() {
    switch (_propertyType) {
      case 'villa':
        return "Manage your villa business";
      case 'hotel':
        return "Manage your hotel business";
      case 'apartment':
        return "Manage your apartment business";
      case 'resort':
        return "Manage your resort business";
      default:
        return "Manage your hospitality business";
    }
  }

  Widget _buildLoginTab() {
    final emailError = _loginErrors['email'];
    final passwordError = _loginErrors['password'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email Address",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: emailError != null
                        ? Colors.red
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: TextField(
                  controller: _loginEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter registered email",
                    prefixIcon: Icon(Icons.email, color: Color(0xFF6B7280)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              if (emailError != null) ...[
                const SizedBox(height: 4),
                Text(
                  emailError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: passwordError != null
                        ? Colors.red
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: TextField(
                  controller: _loginPasswordController,
                  obscureText: !_showLoginPassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF6B7280),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showLoginPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF6B7280),
                      ),
                      onPressed: () => setState(
                            () => _showLoginPassword = !_showLoginPassword,
                      ),
                    ),
                  ),
                ),
              ),
              if (passwordError != null) ...[
                const SizedBox(height: 4),
                Text(
                  passwordError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoggingIn ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5F6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoggingIn
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
                  : const Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.how_to_reg_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            Text(
                              "Fill in your information",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTextField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        icon: Icons.person_outline_rounded,
                        controller: _regNameController,
                        error: _regErrors['fullName'],
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        label: _getBusinessLabel(),
                        hint: _getBusinessHint(),
                        icon: Icons.business_outlined,
                        controller: _regBusinessController,
                        error: _regErrors['businessName'],
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        label: "Email address",
                        hint: "Valid email address",
                        icon: Icons.email_outlined,
                        controller: _regEmailController,
                        keyboardType: TextInputType.emailAddress,
                        error: _regErrors['email'],
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        label: "Phone number",
                        hint: "10-digit phone number",
                        icon: Icons.phone,
                        controller: _regPhoneController,
                        keyboardType: TextInputType.phone,
                        error: _regErrors['phone'],
                      ),
                      const SizedBox(height: 16),

                      _buildPasswordField(
                        label: "Password",
                        hint: "Minimum 6 characters",
                        controller: _regPasswordController,
                        obscure: !_showRegPassword,
                        onToggle: () => setState(
                              () => _showRegPassword = !_showRegPassword,
                        ),
                        error: _regErrors['password'],
                      ),
                      const SizedBox(height: 16),

                      _buildPasswordField(
                        label: "Confirm Password",
                        hint: "Re-enter your password",
                        controller: _regConfirmPasswordController,
                        obscure: !_showConfirmPassword,
                        onToggle: () => setState(
                              () => _showConfirmPassword = !_showConfirmPassword,
                        ),
                        error: _regErrors['confirmPassword'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5F6D), Color(0xFFFF8A7A)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5F6D).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _isRegistering ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.zero,
              ),
              child: _isRegistering
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
                  : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rocket_launch_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBusinessLabel() {
    switch (_propertyType) {
      case 'villa':
        return "Villa Name";
      case 'hotel':
        return "Hotel Name";
      case 'apartment':
        return "Apartment Name";
      case 'resort':
        return "Resort Name";
      default:
        return "Business Name";
    }
  }

  String _getBusinessHint() {
    switch (_propertyType) {
      case 'villa':
        return "Enter your villa name";
      case 'hotel':
        return "Enter your hotel name";
      case 'apartment':
        return "Enter your apartment name";
      case 'resort':
        return "Enter your resort name";
      default:
        return "Enter your business name";
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                fontSize: 14,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "*",
                style: TextStyle(
                  color: Color(0xFFFF5F6D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: error != null ? Colors.red : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
                ),
                child: Center(
                  child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                fontSize: 14,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "*",
                style: TextStyle(
                  color: Color(0xFFFF5F6D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: error != null ? Colors.red : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: const Color(0xFF6B7280),
                      ),
                      onPressed: onToggle,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _regNameController.dispose();
    _regBusinessController.dispose();
    _regEmailController.dispose();
    _regPhoneController.dispose();
    _regPasswordController.dispose();
    _regConfirmPasswordController.dispose();
    super.dispose();
  }
}






