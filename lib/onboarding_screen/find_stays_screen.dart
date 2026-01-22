// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'otp_verification_screen.dart';
//
// class FindStaysScreen extends StatefulWidget {
//   const FindStaysScreen({super.key});
//
//   @override
//   State<FindStaysScreen> createState() => _FindStaysScreenState();
// }
//
// class _FindStaysScreenState extends State<FindStaysScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//
//   final TextEditingController _phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
//       ),
//     );
//
//     _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
//       ),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
//       ),
//     );
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   void _submitPhoneNumber() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       // Simulate API call
//       Future.delayed(const Duration(seconds: 1), () {
//         setState(() {
//           _isLoading = false;
//         });
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpVerificationScreen(
//               phoneNumber: _phoneController.text,
//             ),
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             width: w,
//             height: h,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
//               ),
//             ),
//             child: CustomPaint(painter: _BackgroundPainter()),
//           ),
//
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: h * 0.09),
//
//
//                 Padding(
//                   padding: EdgeInsets.only(left: w * 0.04),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.02),
//
//
//                 AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: Offset(0, _slideAnimation.value),
//                       child: Opacity(
//                         opacity: _fadeAnimation.value,
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(left: w * 0.04),
//                             child: Text(
//                               "Find Perfect Stays",
//                               style: TextStyle(
//                                 fontSize: w * 0.08,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 shadows: [
//                                   Shadow(
//                                     blurRadius: 4.0,
//                                     color: Colors.black.withOpacity(0.3),
//                                     offset: Offset(2.0, 2.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: h * 0.01),
//
//
//                 AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return Transform.translate(
//                       offset: Offset(0, _slideAnimation.value),
//                       child: Opacity(
//                         opacity: _fadeAnimation.value,
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(left: w * 0.04),
//                             child: Text(
//                               "Enter your mobile number to continue",
//                               style: TextStyle(
//                                 fontSize: w * 0.045,
//                                 color: Colors.white.withOpacity(0.9),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: h * 0.05),
//
//
//                 AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return Transform.scale(
//                       scale: _scaleAnimation.value,
//                       child: Opacity(
//                         opacity: _fadeAnimation.value,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(horizontal: w * 0.05),
//                           padding: EdgeInsets.all(w * 0.05),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 20,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               children: [
//                                 // Phone Illustration
//                                 Container(
//                                   width: 80,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color(0xFFFF5F6D),
//                                         Color(0xFFFF8061),
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.3),
//                                         blurRadius: 15,
//                                         offset: Offset(0, 5),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Icon(
//                                     Icons.phone_iphone_rounded,
//                                     size: 50,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//
//                                 SizedBox(height: h * 0.03),
//
//                                 // Phone Input Label
//                                 Text(
//                                   "Enter your mobile number",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey[700],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: h * 0.01),
//
//                                 Text(
//                                   "We'll send you a verification code",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.grey[500],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: h * 0.04),
//
//                                 // Phone Input
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: Colors.grey[300]!,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       // Country Code
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 20,
//                                           vertical: 18,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[200],
//                                           borderRadius: const BorderRadius.only(
//                                             topLeft: Radius.circular(12),
//                                             bottomLeft: Radius.circular(12),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "+91",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w700,
//                                             color: Color(0xFF333333),
//                                           ),
//                                         ),
//                                       ),
//
//                                       // Phone Input Field
//                                       Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                           child: TextFormField(
//                                             controller: _phoneController,
//                                             keyboardType: TextInputType.phone,
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.black87,
//                                             ),
//                                             decoration: InputDecoration(
//                                               hintText: "Enter phone number",
//                                               hintStyle: TextStyle(
//                                                 color: Colors.grey[500],
//                                               ),
//                                               border: InputBorder.none,
//                                             ),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Please enter phone number';
//                                               }
//                                               if (value.length != 10) {
//                                                 return 'Enter 10-digit number';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: h * 0.03),
//
//                                 // Security Info
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.security_rounded,
//                                       color: Color(0xFFFF7043),
//                                       size: 16,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Your data is safe with us",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Color(0xFFFF7043),
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: h * 0.05),
//
//                                 // Continue Button
//                                 AnimatedBuilder(
//                                   animation: _controller,
//                                   builder: (context, child) {
//                                     return Transform.scale(
//                                       scale: _scaleAnimation.value,
//                                       child: GestureDetector(
//                                         onTap: _submitPhoneNumber,
//                                         child: Container(
//                                           width: w * 0.7,
//                                           height: h * 0.07,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                             BorderRadius.circular(15),
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Color(0xFFFF5F6D),
//                                                 Color(0xFFFF8061),
//                                               ],
//                                               begin: Alignment.topLeft,
//                                               end: Alignment.bottomRight,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color:
//                                                 Colors.black.withOpacity(0.3),
//                                                 blurRadius: 10,
//                                                 offset: Offset(0, 5),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Center(
//                                             child: _isLoading
//                                                 ? SizedBox(
//                                               width: 20,
//                                               height: 20,
//                                               child:
//                                               CircularProgressIndicator(
//                                                 valueColor:
//                                                 AlwaysStoppedAnimation<
//                                                     Color>(
//                                                     Colors.white),
//                                                 strokeWidth: 2,
//                                               ),
//                                             )
//                                                 : Text(
//                                               "Send Verification Code",
//                                               style: TextStyle(
//                                                 fontSize: w * 0.045,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//
//                                 SizedBox(height: h * 0.03),
//
//                                 // Terms Text
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                                   child: Text(
//                                     "By continuing, you agree to our Terms of Service and Privacy Policy",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey[600],
//                                       height: 1.5,
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(height: h * 0.02),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: h * 0.05),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _BackgroundPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withOpacity(0.15)
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(
//       Offset(size.width * 0.2, size.height * 0.1),
//       size.width * 0.15,
//       paint,
//     );
//     canvas.drawCircle(
//       Offset(size.width * 0.8, size.height * 0.2),
//       size.width * 0.1,
//       paint,
//     );
//     canvas.drawCircle(
//       Offset(size.width * 0.1, size.height * 0.5),
//       size.width * 0.12,
//       paint,
//     );
//     canvas.drawCircle(
//       Offset(size.width * 0.9, size.height * 0.6),
//       size.width * 0.08,
//       paint,
//     );
//     canvas.drawCircle(
//       Offset(size.width * 0.3, size.height * 0.8),
//       size.width * 0.1,
//       paint,
//     );
//
//     final rectPaint = Paint()
//       ..color = Color(0xFFFF8A65).withOpacity(0.2)
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(
//       Rect.fromCenter(
//         center: Offset(size.width * 0.7, size.height * 0.3),
//         width: size.width * 0.2,
//         height: size.width * 0.2,
//       ),
//       rectPaint,
//     );
//
//     canvas.drawCircle(
//       Offset(size.width * 0.25, size.height * 0.75),
//       size.width * 0.08,
//       rectPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }






import 'package:flutter/material.dart';
import 'dart:async';
import 'otp_verification_screen.dart';

class FindStaysScreen extends StatefulWidget {
  const FindStaysScreen({super.key});

  @override
  State<FindStaysScreen> createState() => _FindStaysScreenState();
}

class _FindStaysScreenState extends State<FindStaysScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

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
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              username: _usernameController.text,
              phoneNumber: _phoneController.text,
            ),
          ),
        );
      });
    }
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
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                SizedBox(height: h * 0.02),

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
                              "Find Perfect Stays",
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
                              "Enter your details to continue",
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // User Illustration
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
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
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 15,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.person_add_alt_1_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(height: h * 0.03),

                                // Title
                                Text(
                                  "Create Your Account",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[800],
                                  ),
                                ),

                                SizedBox(height: h * 0.01),

                                Text(
                                  "Enter your details to get started",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),

                                SizedBox(height: h * 0.04),


                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.person_outline_rounded,
                                          color: Color(0xFF333333),
                                          size: 20,
                                        ),
                                      ),


                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextFormField(
                                            controller: _usernameController,
                                            keyboardType: TextInputType.text,
                                            textCapitalization: TextCapitalization.words,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Enter your full name",
                                              hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your name';
                                              }
                                              if (value.length < 3) {
                                                return 'Name must be at least 3 characters';
                                              }
                                              // Optional: Add name validation regex
                                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                                return 'Please enter a valid name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: h * 0.02),


                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          "+91",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF333333),
                                          ),
                                        ),
                                      ),


                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextFormField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "Enter phone number",
                                              hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter phone number';
                                              }
                                              if (value.length != 10) {
                                                return 'Enter 10-digit number';
                                              }

                                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                return 'Please enter valid numbers only';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: h * 0.03),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.security_rounded,
                                      color: Color(0xFFFF7043),
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Your data is safe with us",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFFFF7043),
                                        fontWeight: FontWeight.w500,
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
                                            borderRadius:
                                            BorderRadius.circular(15),
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
                                                color:
                                                Colors.black.withOpacity(0.3),
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
                                              child:
                                              CircularProgressIndicator(
                                                valueColor:
                                                AlwaysStoppedAnimation<
                                                    Color>(
                                                    Colors.white),
                                                strokeWidth: 2,
                                              ),
                                            )
                                                : Text(
                                              "Send Verification Code",
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

                                SizedBox(height: h * 0.03),


                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "By continuing, you agree to our Terms of Service and Privacy Policy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      height: 1.5,
                                    ),
                                  ),
                                ),

                                SizedBox(height: h * 0.02),
                              ],
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
