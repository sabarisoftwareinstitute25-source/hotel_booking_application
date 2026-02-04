import 'package:flutter/material.dart';
import 'dart:async';

import '../home_screen/hotel_registration_screen.dart';
import '../home_screen/hotel_search_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'forget_password.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {

  final String? registeredEmail;
  final String? registeredPassword;
  final Map<String, dynamic>? registrationData;
  const LoginScreen({super.key, this.registeredEmail, this.registeredPassword, this.registrationData,});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;




  @override
  void initState() {
    super.initState();

    // Pre-fill email if available
    if (widget.registeredEmail != null) {
      _emailController.text = widget.registeredEmail!;
    }

    // For demo, set default password
    if (widget.registeredPassword != null) {
      _passwordController.text = widget.registeredPassword!;
    } else {
      // Default password for demo
      _passwordController.text = 'hotel@123';
    }

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }




  // void _submitForm() {
  //   if (_emailController.text.trim().isEmpty ||
  //       _passwordController.text.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Please fill all fields"),
  //         backgroundColor: Colors.red,
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //
  //     if (_emailController.text.trim() == widget.registeredEmail &&
  //         _passwordController.text.trim() == widget.registeredPassword) {
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Row(
  //             children: [
  //               Icon(Icons.check_circle, color: Colors.white),
  //               SizedBox(width: 8),
  //               Text("Login Successful!"),
  //             ],
  //           ),
  //           backgroundColor: Colors.green,
  //           behavior: SnackBarBehavior.floating,
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //
  //
  //       Future.delayed(const Duration(seconds: 2), () {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HotelSearchScreen()),
  //         );
  //       });
  //     } else {
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Row(
  //             children: [
  //               Icon(Icons.error, color: Colors.white),
  //               SizedBox(width: 8),
  //               Text("Invalid email or password"),
  //             ],
  //           ),
  //           backgroundColor: Colors.red,
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     }
  //   });
  // }



  void _submitForm() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // For demo purposes: Accept ANY login if registrationData exists
      // OR check against registered credentials
      if (widget.registrationData != null ||
          (_emailController.text.trim() == widget.registeredEmail &&
              _passwordController.text.trim() == widget.registeredPassword)) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Login Successful!"),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          // Use registrationData if available, otherwise use individual fields
          Map<String, dynamic> regData = widget.registrationData ?? {};

          // Extract hotel owner data from registration data
          String hotelName = regData['hotelName'] ?? 'Raj Bhavan Hotel';
          String ownerName = regData['ownerName'] ?? 'John Alexandar';
          String mobileNumber = regData['mobileNumber'] ?? '99933366677';
          String email = regData['email'] ?? 'hotel@gmail.com';
          String addressLine1 = regData['addressLine1'] ?? '123 Main Street';
          String addressLine2 = regData['addressLine2'] ?? '';
          String city = regData['city'] ?? 'Mumbai';
          String district = regData['district'] ?? 'Mumbai District';
          String state = regData['state'] ?? 'Maharashtra';
          String pinCode = regData['pinCode'] ?? '400001';
          String gstNumber = regData['gstNumber'] ?? '27ABCDE1234F1Z5';
          String fssaiLicense = regData['fssaiLicense'] ?? '12345678901234';
          String tradeLicense = regData['tradeLicense'] ?? 'TL78901234';
          String aadharNumber = regData['aadharNumber'] ?? '1234 5678 9012';
          String accountHolderName = regData['accountHolderName'] ?? 'John Alexandar';
          String bankName = regData['bankName'] ?? 'State Bank of India';
          String accountNumber = regData['accountNumber'] ?? '123456789012';
          String ifscCode = regData['ifscCode'] ?? 'SBIN0001234';
          String branch = regData['branch'] ?? 'Mumbai Main';
          String accountType = regData['accountType'] ?? 'Savings';
          int totalRooms = int.tryParse(regData['totalRooms']?.toString() ?? '58') ?? 58;

          // Person photo info
          Map<String, dynamic> personPhotoInfo = regData['personPhotoInfo'] ??
              {'name': '', 'size': 0, 'path': '', 'uploaded': false};

          // Other registration data
          String hotelType = regData['hotelType'] ?? 'Standard Hotel';
          String yearOfEstablishment = regData['yearOfEstablishment'] ?? '2015';
          String website = regData['website'] ?? 'https://rajbhavanhotel.com';
          String landmark = regData['landmark'] ?? 'Near City Center';
          Map<String, bool> selectedRoomTypes = regData['selectedRoomTypes'] ?? {};
          Map<String, Map<String, dynamic>> roomDetails = regData['roomDetails'] ?? {};
          String minTariff = regData['minTariff'] ?? '2500';
          String maxTariff = regData['maxTariff'] ?? '6000';
          bool extraBedAvailable = regData['extraBedAvailable'] ?? true;
          Map<String, bool> basicAmenities = regData['basicAmenities'] ?? {};
          Map<String, bool> hotelFacilities = regData['hotelFacilities'] ?? {};
          Map<String, bool> foodServices = regData['foodServices'] ?? {};
          Map<String, bool> additionalAmenities = regData['additionalAmenities'] ?? {};
          List<String> customAmenities = List<String>.from(regData['customAmenities'] ?? []);
          String alternateContact = regData['alternateContact'] ?? '';
          List<String> landlineNumbers = List<String>.from(regData['landlineNumbers'] ?? []);
          Map<String, Map<String, dynamic>> uploadedFiles = Map<String, Map<String, dynamic>>.from(regData['uploadedFiles'] ?? {});
          String signatureName = regData['signatureName'] ?? 'John Alexandar';
          String declarationName = regData['declarationName'] ?? 'John Alexandar';
          DateTime? declarationDate = regData['declarationDate'];
          bool declarationAccepted = regData['declarationAccepted'] ?? true;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HotelOwnerDashboard(
                hotelName: hotelName,
                ownerName: ownerName,
                mobileNumber: mobileNumber,
                email: email,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                district: district,
                state: state,
                pinCode: pinCode,
                gstNumber: gstNumber,
                fssaiLicense: fssaiLicense,
                tradeLicense: tradeLicense,
                aadharNumber: aadharNumber,
                accountHolderName: accountHolderName,
                bankName: bankName,
                accountNumber: accountNumber,
                ifscCode: ifscCode,
                branch: branch,
                accountType: accountType,
                totalRooms: totalRooms,
                personPhotoInfo: personPhotoInfo,
                registrationData: {
                  'hotelName': hotelName,
                  'ownerName': ownerName,
                  'mobileNumber': mobileNumber,
                  'email': email,
                  'addressLine1': addressLine1,
                  'addressLine2': addressLine2,
                  'city': city,
                  'district': district,
                  'state': state,
                  'pinCode': pinCode,
                  'gstNumber': gstNumber,
                  'fssaiLicense': fssaiLicense,
                  'tradeLicense': tradeLicense,
                  'aadharNumber': aadharNumber,
                  'accountHolderName': accountHolderName,
                  'bankName': bankName,
                  'accountNumber': accountNumber,
                  'ifscCode': ifscCode,
                  'branch': branch,
                  'accountType': accountType,
                  'totalRooms': totalRooms,
                  'personPhotoInfo': personPhotoInfo,
                  'hotelType': hotelType,
                  'yearOfEstablishment': yearOfEstablishment,
                  'website': website,
                  'landmark': landmark,
                  'selectedRoomTypes': selectedRoomTypes,
                  'roomDetails': roomDetails,
                  'minTariff': minTariff,
                  'maxTariff': maxTariff,
                  'extraBedAvailable': extraBedAvailable,
                  'basicAmenities': basicAmenities,
                  'hotelFacilities': hotelFacilities,
                  'foodServices': foodServices,
                  'additionalAmenities': additionalAmenities,
                  'customAmenities': customAmenities,
                  'alternateContact': alternateContact,
                  'landlineNumbers': landlineNumbers,
                  'uploadedFiles': uploadedFiles,
                  'signatureName': signatureName,
                  'declarationName': declarationName,
                  'declarationDate': declarationDate,
                  'declarationAccepted': declarationAccepted,
                }, panNumber: '',
              ),
            ),
                (route) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Text("Invalid email or password"),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
              ),
            ),
            child: CustomPaint(painter: _BackgroundPainter()),
          ),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.09),

                Padding(
                  padding: EdgeInsets.only(left: w * 0.04),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()),
                      );
                    },
                  ),
                ),

                SizedBox(height: h * 0.02),
                SizedBox(height: h * 0.09),


                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04),
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: w * 0.08,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: h * 0.01),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04),
                            child: Text(
                              "Login to continue your journey with us",
                              style: TextStyle(
                                fontSize: w * 0.045,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: h * 0.05),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: w * 0.05),
                          padding: EdgeInsets.all(w * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildTextField(
                                Icons.email_outlined,
                                "Email Address",
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              SizedBox(height: h * 0.02),

                              _buildPasswordField(
                                Icons.lock_outline,
                                "Password",
                                controller: _passwordController,
                              ),

                              SizedBox(height: h * 0.03),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _rememberMe = !_rememberMe;
                                          });
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: _rememberMe
                                                ? Color(0xFFFF7043)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            border: Border.all(
                                              color: _rememberMe
                                                  ? Color(0xFFFF7043)
                                                  : Colors.grey,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: _rememberMe
                                              ? Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: w * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ForgotPasswordScreen(
                                            registeredEmail: widget.registeredEmail,
                                            registeredPassword: widget.registeredPassword,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color(0xFFFF7043),
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(height: h * 0.05),

                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _scaleAnimation.value,
                                    child: GestureDetector(
                                      onTap: _submitForm,
                                      child: Container(
                                        width: w * 0.7,
                                        height: h * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFFF5F6D),
                                              Color(0xFFFF8061),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: _isLoading
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.white),
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : Text(
                                                  "Login",
                                                  style: TextStyle(
                                                    fontSize: w * 0.045,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: h * 0.03),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate back to SignUp Screen
                              Navigator.pop(context);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: w * 0.04,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Color(0xFFFF7043),
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 2.0,
                                          color: Colors.black.withOpacity(0.3),
                                          offset: Offset(1.0, 1.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: h * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    IconData icon,
    String hint, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    IconData icon,
    String hint, {
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color iconColor, Color bgColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.1),
      size.width * 0.15,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      size.width * 0.1,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.5),
      size.width * 0.12,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.6),
      size.width * 0.08,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.8),
      size.width * 0.1,
      paint,
    );

    final rectPaint = Paint()
      ..color = Color(0xFFFF8A65).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.7, size.height * 0.3),
        width: size.width * 0.2,
        height: size.width * 0.2,
      ),
      rectPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.75),
      size.width * 0.08,
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
