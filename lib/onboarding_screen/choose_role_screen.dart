import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_booking_mobile_application/onboarding_screen/find_stays_screen.dart';
import '../home_screen/hotel_registration_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFF0F4FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Color(0xFF3B82F6),
                        // Color(0xFF8B5CF6),
                        Color(0xFFFF5F6D),
                        Color(0xFFFFC371),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF5F6D).withOpacity(0.2),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.hotel,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.waving_hand_rounded,
                          color: Color(0xFFFF5F6D),
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              // Color(0xFF3B82F6),
                              // Color(0xFF8B5CF6),
                              Color(0xFFFF5F6D),
                              Color(0xFFFFC371),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: Text(
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
                        gradient: LinearGradient(
                          colors: [

                            Color(0xFFFF5F6D),
                            Color(0xFFFFC371),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),

                    const SizedBox(height: 26),


                    Column(
                      children: [
                        Text(
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
                            Icon(Icons.verified, color: Color(0xFF10B981), size: 16),
                            SizedBox(width: 6),
                            Text(
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

                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xDDED6262),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Choose your role 👇",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

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
                        title: "Book hotels and experiences",
                        description: "Find Stays",
                        color: Color(0xFF3B82F6),
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
                        color: Color(0xFF10B981),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyAuthScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),



                const SizedBox(height: 20),
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
              child: Center(
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
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




// class PropertyAuthScreen extends StatefulWidget {
//   final Map<String, dynamic>? registrationData;
//   const PropertyAuthScreen({super.key,   this.registrationData = const {},});
//
//   @override
//   State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
// }
//
//
// class _PropertyAuthScreenState extends State<PropertyAuthScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   // Register form controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _businessNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _registerPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   // Register form validation + UI state
//   final Map<String, String?> _fieldErrors = {
//     'fullName': null,
//     'businessName': null,
//     'email': null,
//     'phoneOrEmail': null,
//     'password': null,
//     'confirmPassword': null,
//   };
//   bool _showRegisterPassword = false;
//   bool _showConfirmPassword = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _nameController.dispose();
//     _businessNameController.dispose();
//     _phoneController.dispose();
//     _registerPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   // void _handleLogin() {
//   //   // For demo, just navigate to PropertyTypeScreen
//   //   Navigator.pushReplacement(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => HotelOwnerDashboard(
//   //           hotelName: '',
//   //           ownerName: '',
//   //           mobileNumber: '',
//   //           email: '',
//   //           addressLine1: '',
//   //           addressLine2: '',
//   //           city: '',
//   //           district: '',
//   //           state: '',
//   //           pinCode: '',
//   //           gstNumber: '',
//   //           fssaiLicense: '',
//   //           tradeLicense: '',
//   //           panNumber: '',
//   //           aadharNumber: '',
//   //           accountHolderName: '',
//   //           bankName: '',
//   //           accountNumber: '',
//   //           ifscCode: '',
//   //           branch: '',
//   //           accountType: '',
//   //           personPhotoInfo: {},
//   //           totalRooms: 35
//   //       ),
//   //     ),
//   //   );
//   // }
//   void _handleLogin() {
//     // Helper function to safely extract data
//     String getData(String key, String defaultValue) {
//       if (widget.registrationData == null) return defaultValue;
//       return widget.registrationData![key]?.toString() ?? defaultValue;
//     }
//
//     Map<String, dynamic> getPersonPhotoInfo() {
//       if (widget.registrationData == null ||
//           widget.registrationData!['personPhotoInfo'] == null ||
//           widget.registrationData!['personPhotoInfo'] is! Map<String, dynamic>) {
//         return {'name': '', 'size': 0, 'path': '', 'uploaded': false};
//       }
//       return widget.registrationData!['personPhotoInfo'] as Map<String, dynamic>;
//     }
//
//     int getTotalRooms() {
//       if (widget.registrationData == null) return 58;
//       return int.tryParse(widget.registrationData!['totalRooms']?.toString() ?? '58') ?? 58;
//     }
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HotelOwnerDashboard(
//           hotelName: getData('hotelName', 'Raj Bhavan Hotel'),
//           ownerName: getData('ownerName', 'John Alexandar'),
//           mobileNumber: getData('mobileNumber', '99933366677'),
//           email: getData('email', 'hotel@gmail.com'),
//           addressLine1: getData('addressLine1', '123 Main Street'),
//           addressLine2: getData('addressLine2', ''),
//           city: getData('city', 'Mumbai'),
//           district: getData('district', 'Mumbai District'),
//           state: getData('state', 'Maharashtra'),
//           pinCode: getData('pinCode', '400001'),
//           gstNumber: getData('gstNumber', '27ABCDE1234F1Z5'),
//           fssaiLicense: getData('fssaiLicense', '12345678901234'),
//           tradeLicense: getData('tradeLicense', 'TL78901234'),
//           panNumber: getData('panNumber', ''),
//           aadharNumber: getData('aadharNumber', '1234 5678 9012'),
//           accountHolderName: getData('accountHolderName', 'John Alexandar'),
//           bankName: getData('bankName', 'State Bank of India'),
//           accountNumber: getData('accountNumber', '123456789012'),
//           ifscCode: getData('ifscCode', 'SBIN0001234'),
//           branch: getData('branch', 'Mumbai Main'),
//           accountType: getData('accountType', 'Savings'),
//           personPhotoInfo: getPersonPhotoInfo(),
//           totalRooms: getTotalRooms(),
//           registrationData: widget.registrationData ?? {},
//         ),
//       ),
//     );
//   }
//
//
//   // Future<void> _handleRegister() async {
//   //   // Local validation for better UX and field highlighting
//   //   setState(() {
//   //     _fieldErrors.updateAll((key, value) => null);
//   //   });
//   //
//   //   final fullName = _nameController.text.trim();
//   //   final businessName = _businessNameController.text.trim();
//   //   final email = _emailController.text.trim();
//   //   final phone = _phoneController.text.trim();
//   //   final password = _registerPasswordController.text;
//   //   final confirmPassword = _confirmPasswordController.text;
//   //
//   //   // 1) Minimal validation for existing-vendor fast path: only email + phone.
//   //   if (email.isEmpty) {
//   //     _fieldErrors['email'] = 'Email is required';
//   //   } else if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
//   //     _fieldErrors['email'] = 'Enter a valid email address';
//   //   }
//   //
//   //   if (phone.isEmpty) {
//   //     _fieldErrors['phoneOrEmail'] = 'Phone number is required';
//   //   } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
//   //     _fieldErrors['phoneOrEmail'] = 'Enter a valid 10‑digit phone number';
//   //   }
//   //
//   //   setState(() {});
//   //
//   //   // If email+phone are valid, FIRST check if this vendor already exists.
//   //   final hasBasicErrors = _fieldErrors['email'] != null || _fieldErrors['phoneOrEmail'] != null;
//   //   if (!hasBasicErrors) {
//   //     final existingVendor = await _getExistingVendor(phone);
//   //     if (existingVendor != null) {
//   //       if (!mounted) return;
//   //
//   //       // Verify that the email entered matches the vendor's email in DB
//   //       final backendEmail = (existingVendor['email'] ?? '') as String;
//   //       if (backendEmail.isNotEmpty &&
//   //           backendEmail.toLowerCase() != email.toLowerCase()) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           const SnackBar(
//   //             content: Text(
//   //               'This phone is already registered with a different email. Please use the same email or contact support.',
//   //             ),
//   //             backgroundColor: Colors.red,
//   //           ),
//   //         );
//   //         return;
//   //       }
//   //
//   //       // Continue hotel registration on next page using existing vendor data
//   //       final ownerName = (existingVendor['fullName'] ?? '') as String;
//   //       final business = (existingVendor['businessName'] ?? '') as String;
//   //       final mobileNumber = (existingVendor['phone'] ?? phone) as String;
//   //       final vendorEmail = backendEmail.isNotEmpty ? backendEmail : email;
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Account found. Continuing hotel registration...'),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );
//   //
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => HotelOwnerDashboard(
//   //             hotelName: business,
//   //             ownerName: ownerName,
//   //             mobileNumber: mobileNumber,
//   //             email: vendorEmail,
//   //             addressLine1: '',
//   //             addressLine2: '',
//   //             city: '',
//   //             district: '',
//   //             state: '',
//   //             pinCode: '',
//   //             gstNumber: '',
//   //             fssaiLicense: '',
//   //             tradeLicense: '',
//   //             panNumber: '',
//   //             aadharNumber: '',
//   //             accountHolderName: '',
//   //             bankName: '',
//   //             accountNumber: '',
//   //             ifscCode: '',
//   //             branch: '',
//   //             accountType: '',
//   //             totalRooms: 0,
//   //             personPhotoInfo: const {},
//   //             registrationData: {
//   //               'hotelName': business,
//   //               'ownerName': ownerName,
//   //               'mobileNumber': mobileNumber,
//   //               'email': vendorEmail,
//   //             },
//   //           ),
//   //         ),
//   //       );
//   //       return; // Do NOT create a new vendor
//   //     }
//   //   }
//   //
//   //   // 2) Full validation for NEW vendor registration (no existing vendor found).
//   //   _fieldErrors.updateAll((key, value) => null);
//   //
//   //   if (fullName.isEmpty) {
//   //     _fieldErrors['fullName'] = 'Full name is required';
//   //   } else if (fullName.length < 2) {
//   //     _fieldErrors['fullName'] = 'Full name must be at least 2 characters';
//   //   }
//   //
//   //   if (businessName.isEmpty) {
//   //     _fieldErrors['businessName'] = 'Business name is required';
//   //   } else if (businessName.length < 2) {
//   //     _fieldErrors['businessName'] = 'Business name must be at least 2 characters';
//   //   }
//   //
//   //   // Re-apply email/phone checks for consistency
//   //   if (email.isEmpty) {
//   //     _fieldErrors['email'] = 'Email is required';
//   //   } else if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
//   //     _fieldErrors['email'] = 'Enter a valid email address';
//   //   }
//   //
//   //   if (phone.isEmpty) {
//   //     _fieldErrors['phoneOrEmail'] = 'Phone number is required';
//   //   } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
//   //     _fieldErrors['phoneOrEmail'] = 'Enter a valid 10‑digit phone number';
//   //   }
//   //
//   //   if (password.isEmpty) {
//   //     _fieldErrors['password'] = 'Password is required';
//   //   } else if (password.length < 8) {
//   //     _fieldErrors['password'] = 'Password must be at least 8 characters';
//   //   }
//   //
//   //   if (confirmPassword.isEmpty) {
//   //     _fieldErrors['confirmPassword'] = 'Please confirm your password';
//   //   } else if (password != confirmPassword) {
//   //     _fieldErrors['confirmPassword'] = 'Passwords do not match';
//   //   }
//   //
//   //   if (fullName.isEmpty) {
//   //     _fieldErrors['fullName'] = 'Full name is required';
//   //   }
//   //
//   //   setState(() {});
//   //
//   //   final hasErrors = _fieldErrors.values.any((e) => e != null && e.isNotEmpty);
//   //   if (hasErrors) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Please correct the highlighted fields'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //     return;
//   //   }
//   //
//   //   // Build request payload expected by AccountDetailsRequest on backend
//   //   // Before creating a new account, check if this phone already has a vendor account
//   //   final existingVendor = await _getExistingVendor(phone);
//   //   if (existingVendor != null) {
//   //     if (!mounted) return;
//   //
//   //     // Verify that the email entered matches the vendor's email in DB
//   //     final backendEmail = (existingVendor['email'] ?? '') as String;
//   //     if (backendEmail.isNotEmpty &&
//   //         backendEmail.toLowerCase() != email.toLowerCase()) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text(
//   //             'This phone is already registered with a different email. Please use the same email or contact support.',
//   //           ),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //       return;
//   //     }
//   //
//   //     // Continue hotel registration on next page using existing vendor data
//   //     final ownerName = (existingVendor['fullName'] ?? '') as String;
//   //     final businessName = (existingVendor['businessName'] ?? '') as String;
//   //     final mobileNumber = (existingVendor['phone'] ?? phone) as String;
//   //     final vendorEmail = backendEmail.isNotEmpty ? backendEmail : email;
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Account found. Continuing hotel registration...'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //
//   //     // Navigate to dashboard/registration flow with pre-filled basic data
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => HotelOwnerDashboard(
//   //           hotelName: businessName,
//   //           ownerName: ownerName,
//   //           mobileNumber: mobileNumber,
//   //           email: vendorEmail,
//   //           addressLine1: '',
//   //           addressLine2: '',
//   //           city: '',
//   //           district: '',
//   //           state: '',
//   //           pinCode: '',
//   //           gstNumber: '',
//   //           fssaiLicense: '',
//   //           tradeLicense: '',
//   //           panNumber: '',
//   //           aadharNumber: '',
//   //           accountHolderName: '',
//   //           bankName: '',
//   //           accountNumber: '',
//   //           ifscCode: '',
//   //           branch: '',
//   //           accountType: '',
//   //           totalRooms: 0,
//   //           personPhotoInfo: const {},
//   //           registrationData: {
//   //             'hotelName': businessName,
//   //             'ownerName': ownerName,
//   //             'mobileNumber': mobileNumber,
//   //             'email': vendorEmail,
//   //           },
//   //         ),
//   //       ),
//   //     );
//   //     return;
//   //   }
//   //
//   //   final payload = {
//   //     'fullName': fullName,
//   //     'businessName': businessName,
//   //     'phoneOrEmail': phone,
//   //     'password': password,
//   //   };
//   //
//   //   // Use 10.0.2.2 to reach localhost:8080 from Android emulator
//   //   final uri = Uri.parse('http://10.0.2.2:8080/api/hotels/vendor/account-details');
//   //
//   //   try {
//   //     final response = await http.post(
//   //       uri,
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: jsonEncode(payload),
//   //     );
//   //
//   //     if (response.statusCode == 201 || response.statusCode == 200) {
//   //       // Success – parse vendorId if needed
//   //       final data = jsonDecode(response.body) as Map<String, dynamic>;
//   //       final vendorId = data['vendorId'] as String?;
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text(
//   //             vendorId != null
//   //                 ? 'Account created successfully. Vendor ID: $vendorId'
//   //                 : 'Account created successfully.',
//   //           ),
//   //           backgroundColor: Colors.green,
//   //         ),
//   //       );
//   //
//   //       // Navigate to welcome / info screen after short delay
//   //       await Future.delayed(const Duration(seconds: 1));
//   //       if (!mounted) return;
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => const WelcomeScreen(),
//   //         ),
//   //       );
//   //     } else {
//   //       // Try to extract backend validation errors for specific fields
//   //       String message = 'Failed to create account (${response.statusCode})';
//   //       try {
//   //         final data = jsonDecode(response.body);
//   //         if (data is Map) {
//   //           // Prefer fieldErrors if present
//   //           if (data['fieldErrors'] is Map) {
//   //             final errors = (data['fieldErrors'] as Map).cast<String, dynamic>();
//   //
//   //             // Map backend field errors into UI field error map
//   //             setState(() {
//   //               if (errors.containsKey('fullName')) {
//   //                 _fieldErrors['fullName'] = errors['fullName']?.toString();
//   //               }
//   //               if (errors.containsKey('businessName')) {
//   //                 _fieldErrors['businessName'] = errors['businessName']?.toString();
//   //               }
//   //               if (errors.containsKey('phoneOrEmail')) {
//   //                 _fieldErrors['phoneOrEmail'] = errors['phoneOrEmail']?.toString();
//   //               }
//   //               if (errors.containsKey('password')) {
//   //                 _fieldErrors['password'] = errors['password']?.toString();
//   //               }
//   //             });
//   //
//   //             // Build a human readable summary for the SnackBar
//   //             final buffer = StringBuffer('Please fix these fields:\n');
//   //             errors.forEach((field, err) {
//   //               if (err != null && err.toString().trim().isNotEmpty) {
//   //                 buffer.writeln('$field: ${err.toString()}');
//   //               }
//   //             });
//   //             message = buffer.toString().trimRight();
//   //           } else if (data['message'] is String) {
//   //             // Fallback to generic backend message
//   //             message = data['message'] as String;
//   //           }
//   //         }
//   //       } catch (_) {}
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text(message),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Network error: $e'),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }
//
//
//   // /// Fetch existing vendor from backend by phone/email if it exists.
//   // /// Returns vendor map or null.
//   // Future<Map<String, dynamic>?> _getExistingVendor(String phoneOrEmail) async {
//   //   final uri = Uri.parse(
//   //     'http://10.0.2.2:8080/api/hotels/vendor/check-account',
//   //   ).replace(queryParameters: {'phoneOrEmail': phoneOrEmail});
//   //
//   //   try {
//   //     final response = await http.get(uri);
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       if (data is Map && data['exists'] == true && data['vendor'] is Map) {
//   //         return Map<String, dynamic>.from(data['vendor'] as Map);
//   //       }
//   //     }
//   //   } catch (_) {
//   //     // On network/parse errors, fall back to allowing registration flow;
//   //     // the POST /account-details will still enforce uniqueness/validation.
//   //   }
//   //   return null;
//   // }
//
//   void _handleRegister() async {
//     // Basic validation only
//     if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill required fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     // Direct navigation for testing
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WelcomeScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFF8FAFF),
//               Color(0xFFF0F4FF),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Back Button
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//
//               // Logo
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.business,
//                     size: 40,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Text(
//                 "Property Partner",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w800,
//                   color: Color(0xFF1F2937),
//                 ),
//               ),
//
//               Text(
//                 "Manage your hospitality business",
//                 style: TextStyle(
//                   color: Color(0xFF6B7280),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Tab Bar
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 24),
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
//                   unselectedLabelColor: Color(0xFF6B7280),
//                   indicator: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tabs: [
//                     Tab(text: 'Login to your account'),
//                     Tab(text: 'New User Registeration'),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     // Login Tab
//                     _buildLoginTab(),
//
//                     // Register Tab
//                     _buildRegisterTab(),
//                   ],
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
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(24),
//       child: Column(
//         children: [
//           // Email Field
//           _buildTextField(
//             label: "Email Address",
//             hint: "Enter your email",
//             icon: Icons.email,
//             controller: _emailController,
//           ),
//
//           const SizedBox(height: 16),
//
//           // Password Field
//           _buildTextField(
//             label: "Password",
//             hint: "Enter your password",
//             icon: Icons.lock,
//             controller: _passwordController,
//             isPassword: true,
//           ),
//
//           const SizedBox(height: 4),
//
//           // Forgot Password
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {},
//               child: Text(
//                 "Forgot Password?",
//                 style: TextStyle(color: Color(0xFFFF5F6D)),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 14),
//
//           // Login Button
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: _handleLogin,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFFF5F6D),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 "Login",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRegisterTab() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//
//
//
//
//           // Form Container
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 // Form Header
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
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
//                           gradient: LinearGradient(
//                             colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.how_to_reg_rounded,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Expanded(
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
//                 // Form Fields
//                 Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // Name Field
//                       _buildModernTextField(
//                         fieldKey: 'fullName',
//                         label: "Full Name",
//                         hint: "Enter your full name",
//                         icon: Icons.person_outline_rounded,
//                         controller: _nameController,
//                         isRequired: true,
//                       ),
//
//                       SizedBox(height: 16),
//
//                       // Business Name Field
//                       _buildModernTextField(
//                         fieldKey: 'businessName',
//                         label: "Business Name",
//                         hint: "Hotel/Guest House/Business name",
//                         icon: Icons.business_outlined,
//                         controller: _businessNameController,
//                         isRequired: true,
//                       ),
//
//                       SizedBox(height: 16),
//
//                       // Combined Phone or Email Field
//                       _buildModernTextField(
//                         fieldKey: 'email',
//                         label: "Email address",
//                         hint: "Email address",
//                         icon: Icons.contact_phone_outlined,
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         isRequired: true,
//                       ),
//
//                       SizedBox(height: 16),
//
//                       // Combined Phone or Email Field
//                       _buildModernTextField(
//                         fieldKey: 'phoneOrEmail',
//                         label: "Phone number",
//                         hint: "Phone number",
//                         icon: Icons.phone,
//                         controller: _phoneController,
//                         keyboardType: TextInputType.phone,
//                         isRequired: true,
//                       ),
//
//
//                       SizedBox(height: 16),
//
//                       // Password Field
//                       _buildModernTextField(
//                         fieldKey: 'password',
//                         label: "Password",
//                         hint: "Create a strong password",
//                         icon: Icons.lock_outline_rounded,
//                         controller: _registerPasswordController,
//                         isPassword: true,
//                         isRequired: true,
//                       ),
//
//                       SizedBox(height: 16),
//
//                       // Confirm Password Field
//                       _buildModernTextField(
//                         fieldKey: 'confirmPassword',
//                         label: "Confirm Password",
//                         hint: "Re-enter your password",
//                         icon: Icons.lock_clock_outlined,
//                         controller: _confirmPasswordController,
//                         isPassword: true,
//                         isRequired: true,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 24),
//
//           // Register Button
//           Container(
//             height: 56,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFFF5F6D), Color(0xFFFF8A7A)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(14),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xFFFF5F6D).withOpacity(0.3),
//                   blurRadius: 15,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: ElevatedButton(
//               onPressed: _handleRegister,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 padding: EdgeInsets.zero,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.rocket_launch_rounded,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//
//
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildModernTextField({
//     required String fieldKey,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required TextEditingController controller,
//     bool isPassword = false,
//     bool isRequired = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     final errorText = _fieldErrors[fieldKey];
//
//     // Determine password visibility state
//     bool obscure = false;
//     if (isPassword) {
//       if (fieldKey == 'password') {
//         obscure = !_showRegisterPassword;
//       } else if (fieldKey == 'confirmPassword') {
//         obscure = !_showConfirmPassword;
//       }
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF374151),
//                 fontSize: 14,
//               ),
//             ),
//             if (isRequired)
//               Padding(
//                 padding: EdgeInsets.only(left: 4),
//                 child: Text(
//                   "*",
//                   style: TextStyle(
//                     color: Color(0xFFFF5F6D),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: errorText != null ? Colors.red : const Color(0xFFE5E7EB),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.02),
//                 blurRadius: 5,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF9FAFB),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                   ),
//                   border: Border(
//                     right: BorderSide(color: Color(0xFFE5E7EB)),
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     icon,
//                     size: 20,
//                     color: Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: controller,
//                   obscureText: isPassword ? obscure : false,
//                   keyboardType: keyboardType,
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     hintStyle: TextStyle(
//                       color: Color(0xFF9CA3AF),
//                       fontSize: 14,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//                     suffixIcon: isPassword
//                         ? IconButton(
//                             icon: Icon(
//                               (fieldKey == 'password' && _showRegisterPassword) ||
//                                       (fieldKey == 'confirmPassword' && _showConfirmPassword)
//                                   ? Icons.visibility_off_outlined
//                                   : Icons.visibility_outlined,
//                               size: 20,
//                               color: const Color(0xFF6B7280),
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 if (fieldKey == 'password') {
//                                   _showRegisterPassword = !_showRegisterPassword;
//                                 } else if (fieldKey == 'confirmPassword') {
//                                   _showConfirmPassword = !_showConfirmPassword;
//                                 }
//                               });
//                             },
//                           )
//                         : null,
//                   ),
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF1F2937),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (errorText != null) ...[
//           const SizedBox(height: 4),
//           Text(
//             errorText,
//             style: const TextStyle(
//               color: Colors.red,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required String label,
//     required String hint,
//     required IconData icon,
//     required TextEditingController controller,
//     bool isPassword = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF374151),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: TextField(
//             controller: controller,
//             obscureText: isPassword,
//             keyboardType: keyboardType,
//             decoration: InputDecoration(
//               hintText: hint,
//               prefixIcon: Icon(icon, color: Color(0xFF6B7280)),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.all(16),
//               suffixIcon: isPassword
//                   ? IconButton(
//                 icon: Icon(
//                   Icons.visibility,
//                   color: Color(0xFF6B7280),
//                 ),
//                 onPressed: () {
//                   // Toggle password visibility if needed
//                 },
//               )
//                   : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//








class PropertyAuthScreen extends StatefulWidget {
  final Map<String, dynamic>? registrationData;
  const PropertyAuthScreen({super.key, this.registrationData = const {}});

  @override
  State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
}

class _PropertyAuthScreenState extends State<PropertyAuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  final Map<String, String?> _fieldErrors = {
    'fullName': null,
    'businessName': null,
    'email': null,
    'phone': null,
    'password': null,
    'confirmPassword': null,
  };

  final Map<String, String?> _loginErrors = {
    'loginEmail': null,
    'loginPassword': null,
  };

  bool _showRegisterPassword = false;
  bool _showConfirmPassword = false;
  bool _showLoginPassword = false;
  bool _isLoggingIn = false;
  bool _isRegistering = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }


  Future<void> _saveRegisteredUser(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();


      final existingUsersJson = prefs.getString('registered_users') ?? '[]';
      List<dynamic> existingUsers = jsonDecode(existingUsersJson);


      final String userEmail = userData['email'];
      bool userExists = false;

      for (int i = 0; i < existingUsers.length; i++) {
        if (existingUsers[i]['email'] == userEmail) {
          existingUsers[i] = userData;
          userExists = true;
          break;
        }
      }

      if (!userExists) {
        existingUsers.add(userData);
      }


      await prefs.setString('registered_users', jsonEncode(existingUsers));

      print('User saved: $userEmail');
      print('Total registered users: ${existingUsers.length}');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }


  Future<bool> _validateCredentials(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString('registered_users') ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      for (var user in users) {
        if (user is Map<String, dynamic>) {
          final storedEmail = user['email']?.toString().toLowerCase().trim();
          final storedPassword = user['password']?.toString();
          final inputEmail = email.toLowerCase().trim();

          if (storedEmail == inputEmail && storedPassword == password) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('Error validating credentials: $e');
      return false;
    }
  }


  Future<Map<String, dynamic>?> _getUserData(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString('registered_users') ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      for (var user in users) {
        if (user is Map<String, dynamic>) {
          final storedEmail = user['email']?.toString().toLowerCase().trim();
          if (storedEmail == email.toLowerCase().trim()) {
            return Map<String, dynamic>.from(user);
          }
        }
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
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

  // Future<void> _handleLogin() async {
  //   // Clear previous errors
  //   setState(() {
  //     _loginErrors.updateAll((key, value) => null);
  //   });
  //
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text;
  //
  //   // Validation
  //   bool hasErrors = false;
  //
  //   if (email.isEmpty) {
  //     setState(() {
  //       _loginErrors['loginEmail'] = 'Email is required';
  //     });
  //     hasErrors = true;
  //   } else if (!_isValidEmail(email)) {
  //     setState(() {
  //       _loginErrors['loginEmail'] = 'Enter a valid email address';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   if (password.isEmpty) {
  //     setState(() {
  //       _loginErrors['loginPassword'] = 'Password is required';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   if (hasErrors) {
  //     return;
  //   }
  //
  //   setState(() {
  //     _isLoggingIn = true;
  //   });
  //
  //   try {
  //     // First check local storage
  //     final isValid = await _validateCredentials(email, password);
  //
  //     if (!isValid) {
  //       if (!mounted) return;
  //
  //       setState(() {
  //         _isLoggingIn = false;
  //         _loginErrors['loginEmail'] = 'Invalid email or password';
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Invalid email or password. Please register first.'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     // Get user data
  //     final userData = await _getUserData(email);
  //
  //     if (userData == null) {
  //       if (!mounted) return;
  //
  //       setState(() {
  //         _isLoggingIn = false;
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('User data not found. Please register again.'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       return;
  //     }
  //
  //     // Save current session
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('is_logged_in', true);
  //     await prefs.setString('current_user_email', email);
  //
  //     if (!mounted) return;
  //
  //     setState(() {
  //       _isLoggingIn = false;
  //     });
  //
  //     // Clear all form fields before navigation
  //     _clearAllForms();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Login successful!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     // Navigate to dashboard
  //     await Future.delayed(Duration(milliseconds: 500));
  //     _navigateToDashboard(userData);
  //
  //   } catch (e) {
  //     if (!mounted) return;
  //     setState(() {
  //       _isLoggingIn = false;
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login error: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  // Future<void> _handleRegister() async {
  //   // Clear previous errors
  //   setState(() {
  //     _fieldErrors.updateAll((key, value) => null);
  //   });
  //
  //   final fullName = _nameController.text.trim();
  //   final businessName = _businessNameController.text.trim();
  //   final email = _emailController.text.trim();
  //   final phone = _phoneController.text.trim();
  //   final password = _registerPasswordController.text;
  //   final confirmPassword = _confirmPasswordController.text;
  //
  //   // Validation
  //   bool hasErrors = false;
  //
  //   // Full name validation
  //   if (fullName.isEmpty) {
  //     setState(() {
  //       _fieldErrors['fullName'] = 'Full name is required';
  //     });
  //     hasErrors = true;
  //   } else if (fullName.length < 2) {
  //     setState(() {
  //       _fieldErrors['fullName'] = 'Full name must be at least 2 characters';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   // Business name validation
  //   if (businessName.isEmpty) {
  //     setState(() {
  //       _fieldErrors['businessName'] = 'Business name is required';
  //     });
  //     hasErrors = true;
  //   } else if (businessName.length < 2) {
  //     setState(() {
  //       _fieldErrors['businessName'] = 'Business name must be at least 2 characters';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   // Email validation
  //   if (email.isEmpty) {
  //     setState(() {
  //       _fieldErrors['email'] = 'Email is required';
  //     });
  //     hasErrors = true;
  //   } else if (!_isValidEmail(email)) {
  //     setState(() {
  //       _fieldErrors['email'] = 'Enter a valid email address';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   // Phone validation
  //   if (phone.isEmpty) {
  //     setState(() {
  //       _fieldErrors['phone'] = 'Phone number is required';
  //     });
  //     hasErrors = true;
  //   } else if (!_isValidPhone(phone)) {
  //     setState(() {
  //       _fieldErrors['phone'] = 'Enter a valid 10-digit phone number';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   // Password validation
  //   if (password.isEmpty) {
  //     setState(() {
  //       _fieldErrors['password'] = 'Password is required';
  //     });
  //     hasErrors = true;
  //   } else if (!_isValidPassword(password)) {
  //     setState(() {
  //       _fieldErrors['password'] = 'Password must be at least 6 characters';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   // Confirm password validation
  //   if (confirmPassword.isEmpty) {
  //     setState(() {
  //       _fieldErrors['confirmPassword'] = 'Please confirm your password';
  //     });
  //     hasErrors = true;
  //   } else if (password != confirmPassword) {
  //     setState(() {
  //       _fieldErrors['confirmPassword'] = 'Passwords do not match';
  //     });
  //     hasErrors = true;
  //   }
  //
  //   if (hasErrors) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please correct the highlighted fields'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   // Check if email already registered
  //   final existingUser = await _getUserData(email);
  //   if (existingUser != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Email $email is already registered. Please login.'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     _tabController.animateTo(0); // Switch to login tab
  //     _passwordController.text = password; // Auto-fill password for convenience
  //     return;
  //   }
  //
  //   setState(() {
  //     _isRegistering = true;
  //   });
  //
  //   try {
  //     // Create user data object
  //     final userData = {
  //       'fullName': fullName,
  //       'businessName': businessName,
  //       'email': email,
  //       'phone': phone,
  //       'password': password, // Store password for validation
  //       'registeredAt': DateTime.now().toIso8601String(),
  //       'addressLine1': '',
  //       'city': '',
  //       'state': '',
  //       'pinCode': '',
  //       'gstNumber': '',
  //       'fssaiLicense': '',
  //       'totalRooms': 0,
  //     };
  //
  //     // Save to SharedPreferences
  //     await _saveRegisteredUser(userData);
  //
  //     // Also save to current session
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('is_logged_in', true);
  //     await prefs.setString('current_user_email', email);
  //
  //     if (!mounted) return;
  //
  //     setState(() {
  //       _isRegistering = false;
  //     });
  //
  //     // Clear all form fields BEFORE showing success message
  //     _clearAllForms();
  //
  //     // Show success message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Registration successful! Logging you in...'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     // Auto-login after registration
  //     await Future.delayed(Duration(milliseconds: 500));
  //     _navigateToDashboard(userData);
  //
  //   } catch (e) {
  //     if (!mounted) return;
  //     setState(() {
  //       _isRegistering = false;
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Registration failed: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  // Clear all form fields


  Future<void> _handleRegister() async {

    setState(() {
      _fieldErrors.updateAll((key, value) => null);
    });

    final fullName = _nameController.text.trim();
    final businessName = _businessNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _registerPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;


    bool hasErrors = false;


    if (fullName.isEmpty) {
      setState(() {
        _fieldErrors['fullName'] = 'Full name is required';
      });
      hasErrors = true;
    } else if (fullName.length < 2) {
      setState(() {
        _fieldErrors['fullName'] = 'Full name must be at least 2 characters';
      });
      hasErrors = true;
    }

    if (businessName.isEmpty) {
      setState(() {
        _fieldErrors['businessName'] = 'Business name is required';
      });
      hasErrors = true;
    } else if (businessName.length < 2) {
      setState(() {
        _fieldErrors['businessName'] = 'Business name must be at least 2 characters';
      });
      hasErrors = true;
    }


    if (email.isEmpty) {
      setState(() {
        _fieldErrors['email'] = 'Email is required';
      });
      hasErrors = true;
    } else if (!_isValidEmail(email)) {
      setState(() {
        _fieldErrors['email'] = 'Enter a valid email address';
      });
      hasErrors = true;
    }


    if (phone.isEmpty) {
      setState(() {
        _fieldErrors['phone'] = 'Phone number is required';
      });
      hasErrors = true;
    } else if (!_isValidPhone(phone)) {
      setState(() {
        _fieldErrors['phone'] = 'Enter a valid 10-digit phone number';
      });
      hasErrors = true;
    }


    if (password.isEmpty) {
      setState(() {
        _fieldErrors['password'] = 'Password is required';
      });
      hasErrors = true;
    } else if (!_isValidPassword(password)) {
      setState(() {
        _fieldErrors['password'] = 'Password must be at least 6 characters';
      });
      hasErrors = true;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        _fieldErrors['confirmPassword'] = 'Please confirm your password';
      });
      hasErrors = true;
    } else if (password != confirmPassword) {
      setState(() {
        _fieldErrors['confirmPassword'] = 'Passwords do not match';
      });
      hasErrors = true;
    }

    if (hasErrors) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    final existingUser = await _getUserData(email);
    if (existingUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email $email is already registered. Please login.'),
          backgroundColor: Colors.orange,
        ),
      );
      _tabController.animateTo(0);
      _passwordController.text = password;
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    try {

      final userData = {
        'fullName': fullName,
        'businessName': businessName,
        'email': email,
        'phone': phone,
        'password': password,
        'registeredAt': DateTime.now().toIso8601String(),
        'addressLine1': '',
        'city': '',
        'state': '',
        'pinCode': '',
        'gstNumber': '',
        'fssaiLicense': '',
        'totalRooms': 0,
      };


      await _saveRegisteredUser(userData);



      if (!mounted) return;

      setState(() {
        _isRegistering = false;
      });


      _clearAllForms();


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );


      await Future.delayed(Duration(milliseconds: 500));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isRegistering = false;
      });

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
      _loginErrors.updateAll((key, value) => null);
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;


    bool hasErrors = false;

    if (email.isEmpty) {
      setState(() {
        _loginErrors['loginEmail'] = 'Email is required';
      });
      hasErrors = true;
    } else if (!_isValidEmail(email)) {
      setState(() {
        _loginErrors['loginEmail'] = 'Enter a valid email address';
      });
      hasErrors = true;
    }

    if (password.isEmpty) {
      setState(() {
        _loginErrors['loginPassword'] = 'Password is required';
      });
      hasErrors = true;
    }

    if (hasErrors) {
      return;
    }

    setState(() {
      _isLoggingIn = true;
    });

    try {

      final isValid = await _validateCredentials(email, password);

      if (!isValid) {
        if (!mounted) return;

        setState(() {
          _isLoggingIn = false;
          _loginErrors['loginEmail'] = 'Invalid email or password';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password. Please register first.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }


      final userData = await _getUserData(email);

      if (userData == null) {
        if (!mounted) return;

        setState(() {
          _isLoggingIn = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User data not found. Please register again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }


      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_email', email);

      if (!mounted) return;

      setState(() {
        _isLoggingIn = false;
      });


      _clearAllForms();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );


      await Future.delayed(Duration(milliseconds: 500));
      _navigateToDashboard(userData);

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoggingIn = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }




  void _clearAllForms() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _businessNameController.clear();
    _phoneController.clear();
    _registerPasswordController.clear();
    _confirmPasswordController.clear();


    setState(() {
      _fieldErrors.updateAll((key, value) => null);
      _loginErrors.updateAll((key, value) => null);
      _showRegisterPassword = false;
      _showConfirmPassword = false;
      _showLoginPassword = false;
    });
  }
  //
  // void _navigateToDashboard(Map<String, dynamic> userData) {
  //
  //   String getData(String key, String defaultValue) {
  //     return userData[key]?.toString() ?? defaultValue;
  //   }
  //
  //   int getTotalRooms() {
  //     return int.tryParse(userData['totalRooms']?.toString() ?? '0') ?? 0;
  //   }
  //
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HotelOwnerDashboard(
  //         hotelName: getData('businessName', ''),
  //         ownerName: getData('fullName', ''),
  //         mobileNumber: getData('phone', ''),
  //         email: getData('email', ''),
  //         addressLine1: getData('addressLine1', ''),
  //         addressLine2: getData('addressLine2', ''),
  //         city: getData('city', ''),
  //         district: getData('district', ''),
  //         state: getData('state', ''),
  //         pinCode: getData('pinCode', ''),
  //         gstNumber: getData('gstNumber', ''),
  //         fssaiLicense: getData('fssaiLicense', ''),
  //         tradeLicense: getData('tradeLicense', ''),
  //         panNumber: getData('panNumber', ''),
  //         aadharNumber: getData('aadharNumber', ''),
  //         accountHolderName: getData('accountHolderName', ''),
  //         bankName: getData('bankName', ''),
  //         accountNumber: getData('accountNumber', ''),
  //         ifscCode: getData('ifscCode', ''),
  //         branch: getData('branch', ''),
  //         accountType: getData('accountType', ''),
  //         personPhotoInfo: {'name': '', 'size': 0, 'path': '', 'uploaded': false},
  //         totalRooms: getTotalRooms(),
  //         registrationData: userData,
  //       ),
  //     ),
  //   );
  // }

  void _navigateToDashboard(Map<String, dynamic> userData) {
    // Debug: Check what data we're receiving
    print('=== DEBUG: _navigateToDashboard START ===');
    print('User data keys: ${userData.keys.toList()}');
    print('widget.registrationData is null: ${widget.registrationData == null}');

    if (widget.registrationData != null) {
      print('Registration data keys: ${widget.registrationData!.keys.toList()}');
      print('Registration data hotelPhoto: ${widget.registrationData!['hotelPhoto']}');
    }

    // Create a merged data map - start with userData
    Map<String, dynamic> mergedData = Map<String, dynamic>.from(userData);

    // Add hotel registration data if it exists
    final hotelRegData = widget.registrationData;
    if (hotelRegData != null && hotelRegData.isNotEmpty) {
      print('Merging hotel registration data...');
      mergedData.addAll(hotelRegData);
    }

    // Debug merged data
    print('Merged data keys: ${mergedData.keys.toList()}');
    print('Merged hotelPhoto: ${mergedData['hotelPhoto']}');
    print('=== DEBUG: _navigateToDashboard END ===');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerDashboard(
          // Pass the merged data
          registrationData: mergedData,

          // Pass individual fields
          hotelName: mergedData['hotelName']?.toString() ?? userData['businessName']?.toString() ?? '',
          ownerName: mergedData['ownerName']?.toString() ?? userData['fullName']?.toString() ?? '',
          mobileNumber: mergedData['mobileNumber']?.toString() ?? userData['phone']?.toString() ?? '',
          email: userData['email']?.toString() ?? '',
          addressLine1: mergedData['addressLine1']?.toString() ?? '',
          addressLine2: mergedData['addressLine2']?.toString() ?? '',
          city: mergedData['city']?.toString() ?? '',
          district: mergedData['district']?.toString() ?? '',
          state: mergedData['state']?.toString() ?? '',
          pinCode: mergedData['pinCode']?.toString() ?? '',
          gstNumber: mergedData['gstNumber']?.toString() ?? '',
          fssaiLicense: mergedData['fssaiLicense']?.toString() ?? '',
          tradeLicense: mergedData['tradeLicense']?.toString() ?? '',
          aadharNumber: mergedData['aadharNumber']?.toString() ?? '',
          accountHolderName: mergedData['accountHolderName']?.toString() ?? '',
          bankName: mergedData['bankName']?.toString() ?? '',
          accountNumber: mergedData['accountNumber']?.toString() ?? '',
          ifscCode: mergedData['ifscCode']?.toString() ?? '',
          branch: mergedData['branch']?.toString() ?? '',
          accountType: mergedData['accountType']?.toString() ?? '',

          // Pass photo data
          personPhotoInfo: mergedData['personPhotoInfo'] is Map
              ? Map<String, dynamic>.from(mergedData['personPhotoInfo'] as Map)
              : {},
          totalRooms: int.tryParse(mergedData['totalRooms']?.toString() ?? '0') ?? 0,
          panNumber: mergedData['panNumber']?.toString() ?? '',
        ),
      ),
    );
  }


  Future<void> _clearAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('registered_users');
      await prefs.remove('is_logged_in');
      await prefs.remove('current_user_email');

      _clearAllForms();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All data cleared.'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      print('Error clearing users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFF0F4FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),


              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    Icons.business,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Property Partner",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),

              Text(
                "Manage your hospitality business",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 20),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
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
                  unselectedLabelColor: Color(0xFF6B7280),
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: [
                    Tab(text: 'Login to your account'),
                    Tab(text: 'New User Registeration'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginTab(),
                    _buildRegisterTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    final emailError = _loginErrors['loginEmail'];
    final passwordError = _loginErrors['loginPassword'];

    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                  border: emailError != null
                      ? Border.all(color: Colors.red)
                      : null,
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 16),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                  border: passwordError != null
                      ? Border.all(color: Colors.red)
                      : null,
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_showLoginPassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF6B7280)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showLoginPassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF6B7280),
                      ),
                      onPressed: () {
                        setState(() {
                          _showLoginPassword = !_showLoginPassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              if (passwordError != null) ...[
                const SizedBox(height: 4),
                Text(
                  passwordError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 4),


          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Color(0xFFFF5F6D)),
              ),
            ),
          ),

          const SizedBox(height: 14),


          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoggingIn ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF5F6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoggingIn
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
                  : Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

        ],
      ),
    );
  }

  Widget _buildRegisterTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
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
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
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
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.how_to_reg_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildModernTextField(
                        fieldKey: 'fullName',
                        label: "Full Name",
                        hint: "Enter your full name",
                        icon: Icons.person_outline_rounded,
                        controller: _nameController,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      _buildModernTextField(
                        fieldKey: 'businessName',
                        label: "Business Name",
                        hint: "Hotel/Guest House/Business name",
                        icon: Icons.business_outlined,
                        controller: _businessNameController,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      _buildModernTextField(
                        fieldKey: 'email',
                        label: "Email address",
                        hint: "Valid email address",
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      _buildModernTextField(
                        fieldKey: 'phone',
                        label: "Phone number",
                        hint: "10-digit phone number",
                        icon: Icons.phone,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      _buildModernTextField(
                        fieldKey: 'password',
                        label: "Password",
                        hint: "Minimum 6 characters",
                        icon: Icons.lock_outline_rounded,
                        controller: _registerPasswordController,
                        isPassword: true,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      _buildModernTextField(
                        fieldKey: 'confirmPassword',
                        label: "Confirm Password",
                        hint: "Re-enter your password",
                        icon: Icons.lock_clock_outlined,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        isRequired: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),


          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF5F6D), Color(0xFFFF8A7A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF5F6D).withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _isRegistering ? null : _handleRegister,
              // onPressed:(){
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => WelcomeScreen(),
              //     ),
              //   );
              // },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.zero,
              ),
              child: _isRegistering
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
                  : Row(
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

          SizedBox(height: 20),

        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required String fieldKey,
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final errorText = _fieldErrors[fieldKey];

    bool obscure = false;
    if (isPassword) {
      if (fieldKey == 'password') {
        obscure = !_showRegisterPassword;
      } else if (fieldKey == 'confirmPassword') {
        obscure = !_showConfirmPassword;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                fontSize: 14,
              ),
            ),
            if (isRequired)
              Padding(
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
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null ? Colors.red : const Color(0xFFE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  border: Border(
                    right: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword ? obscure : false,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    suffixIcon: isPassword
                        ? IconButton(
                      icon: Icon(
                        (fieldKey == 'password' && _showRegisterPassword) ||
                            (fieldKey == 'confirmPassword' && _showConfirmPassword)
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: const Color(0xFF6B7280),
                      ),
                      onPressed: () {
                        setState(() {
                          if (fieldKey == 'password') {
                            _showRegisterPassword = !_showRegisterPassword;
                          } else if (fieldKey == 'confirmPassword') {
                            _showConfirmPassword = !_showConfirmPassword;
                          }
                        });
                      },
                    )
                        : null,
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
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
  final TextEditingController _confirmPasswordController = TextEditingController();

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
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color(0xFFF8FAFF),
          //     Color(0xFFF0F4FF),
          //   ],
          // ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
                    onPressed: () => Navigator.pop(context),
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
            _buildBenefitItem(Icons.public_rounded, "Reach millions of travelers"),
            _buildBenefitItem(Icons.trending_up_rounded, "Competitive commission rates"),
            _buildBenefitItem(Icons.support_agent_rounded, "24/7 dedicated partner support"),

            const SizedBox(height: 30),


            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyTypeScreen(ownerName: '', businessName: '', email: '', phone: '')
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
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
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
  const PropertyTypeScreen({super.key, required String ownerName, required String businessName, required String email, required String phone});

  @override
  State<PropertyTypeScreen> createState() => _PropertyTypeScreenState();
}

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
      isAvailable: false,
    ),
    PropertyType(
      icon: '🏢',
      title: 'Apartment',
      description: 'Serviced Apartments',
      color: Color(0xFFFFC371),
      isPopular: true,
      isAvailable: false,
    ),
    PropertyType(
      icon: '🌴',
      title: 'Resort',
      description: 'Beach & Hill Resorts',
      color: Color(0xFFFFC371),
      isPopular: false,
      isAvailable: false,
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROPERTY TYPE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Choose Category',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1C1C1E),
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 100,
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
                            'What type of property\ndo you want to list?',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1C1C1E),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Select the category that best describes your property',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8E8E93),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),


                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelCategoryScreen(),
                                  ),
                                );
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
                      SizedBox(height: 40),

                      // // Selected Info Section - Updated message
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Color(0xFFF5F5F7),
                      //     border: Border.all(
                      //       color: Color(0xFFE5E5EA),
                      //       width: 1,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.info_outline_rounded,
                      //         size: 20,
                      //         color: Color(0xFF8E8E93),
                      //       ),
                      //       SizedBox(width: 12),
                      //       Expanded(
                      //         child: Text(
                      //           'Currently, only Hotel registration is available. Other property types coming soon!',
                      //           style: TextStyle(
                      //             fontSize: 14,
                      //             color: Color(0xFF8E8E93),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 20),
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


  void _showComingSoonDialog(BuildContext context, String propertyType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.hourglass_empty, color: Color(0xFFFFC371)),
            SizedBox(width: 12),
            Text('Coming Soon'),
          ],
        ),
        content: Text(
          '$propertyType registration will be available soon. Currently, only Hotel registration is supported.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF8E8E93),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: Color(0xFFFF5F6D),
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

  const _PropertyCard({
    required this.property,
    required this.isSelected,
  });

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
                              colors: [
                                Color(0xFFFF5F6D),
                                Color(0xFFFFC371),
                              ],
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
                            property.color.withOpacity(isSelected && isAvailable ? 0.2 : 0.1),
                            property.color.withOpacity(isSelected && isAvailable ? 0.1 : 0.05),
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
                            color: isSelected ? property.color : Color(0xFFC7C7CC),
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
                child: Icon(
                  Icons.check_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        // // Coming Soon Overlay
        // if (!isAvailable)
        //   Positioned.fill(
        //     child: Container(
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(16),
        //         color: Colors.black.withOpacity(0.02),
        //       ),
        //       child: Center(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //           decoration: BoxDecoration(
        //             color: Colors.white.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(12),
        //             border: Border.all(color: Color(0xFFFFC371).withOpacity(0.3)),
        //           ),
        //           // child: Text(
        //           //   'Coming Soon',
        //           //   style: TextStyle(
        //           //     fontSize: 11,
        //           //     fontWeight: FontWeight.w600,
        //           //     color: Color(0xFFFFC371),
        //           //   ),
        //           // ),
        //         ),
        //       ),
        //     ),
        //   ),
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
        'image': 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '2 Star Hotel',
        'subtitle': 'Budget Hotels',
        'description': 'Limited facilities',
        'stars': '⭐⭐',
        'price': '₹1,500 - ₹3,500',
        'color': Color(0xFF6B8E23),
        'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '3 Star Hotel',
        'subtitle': 'Mid-Range',
        'description': 'Standard facilities',
        'stars': '⭐⭐⭐',
        'price': '₹2,500 - ₹5,000',
        'color': Color(0xFFDAA520),
        'image': 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '4 Star Hotel',
        'subtitle': 'Upscale Hotels',
        'description': 'Premium amenities',
        'stars': '⭐⭐⭐⭐',
        'price': '₹4,000 - ₹8,000',
        'color': Color(0xFF9370DB),
        'image': 'https://images.unsplash.com/photo-1564501049418-3c27787d01e8?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '5 Star Hotel',
        'subtitle': 'Luxury',
        'description': 'World-class facilities',
        'stars': '⭐⭐⭐⭐⭐',
        'price': '₹6,000 - ₹15,000',
        'color': Color(0xFFFB717D),
        'image': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
      },
      {
        'title': '7 Star Hotel',
        'subtitle': 'Ultra-Luxury',
        'description': 'Exceptional services',
        'stars': '⭐⭐⭐⭐⭐⭐⭐',
        'price': '₹15,000+',
        'color': Color(0xFFC71585),
        'image': 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&h=400&q=80',
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
            } else if (categories[index]['title'] == '7 Star Hotel') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SixStarHotelRegistrationScreen(),
                ),
              );
            };
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
          border: Border.all(
            color: Color(0xFFF2F2F7),
            width: 1,
          ),
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
                            child: Icon(
                              Icons.hotel,
                              size: 40,
                              color: color,
                            ),
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
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8E8E93),
                      ),
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





