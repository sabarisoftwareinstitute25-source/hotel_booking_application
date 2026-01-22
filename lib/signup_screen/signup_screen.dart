// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import '../login_screen/login_screen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _isLoading = false;
//   bool _agreeToTerms = false;
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
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       if (_passwordController.text != _confirmPasswordController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Passwords do not match"),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//         return;
//       }
//
//       if (!_agreeToTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Please agree to Terms & Conditions"),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//         return;
//       }
//
//       setState(() {
//         _isLoading = true;
//       });
//
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _isLoading = false;
//         });
//
//         // Show success snackbar
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.white),
//                 SizedBox(width: 8),
//                 Text("Registration Successful!"),
//               ],
//             ),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             duration: Duration(seconds: 2),
//           ),
//         );
//
//         // Navigate to login screen
//         Future.delayed(const Duration(seconds: 2), () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LoginScreen(
//                 registeredEmail: _emailController.text,
//                 registeredPassword: _passwordController.text,
//               ),
//             ),
//           );
//         });
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
//                 Padding(
//                   padding: EdgeInsets.only(left: w * 0.04),
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.02),
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
//                             padding: EdgeInsets.only(left: w * 0.03),
//                             child: Text(
//                               "Create Account",
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
//                               "Join us today",
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
//                                 // Name field
//                                 _buildTextField(
//                                   Icons.person_outline,
//                                   "Full Name",
//                                   controller: _nameController,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your name';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//
//                                 // SizedBox(height: h * 0.02),
//                                 // _buildTextField(
//                                 //   Icons.person_outline,
//                                 //   "Address",
//                                 //   controller: _nameController,
//                                 //   validator: (value) {
//                                 //     if (value == null || value.isEmpty) {
//                                 //       return 'Please enter your address';
//                                 //     }
//                                 //     return null;
//                                 //   },
//                                 // ),
//
//                                 SizedBox(height: h * 0.02),
//
//                                 // Email field
//                                 _buildTextField(
//                                   Icons.email_outlined,
//                                   "Email Address",
//                                   controller: _emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your email';
//                                     }
//                                     if (!value.contains('@')) {
//                                       return 'Enter a valid email';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//
//                                 SizedBox(height: h * 0.02),
//
//                                 // Password field
//                                 _buildPasswordField(
//                                   Icons.lock_outline,
//                                   "Password",
//                                   controller: _passwordController,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter your password';
//                                     }
//                                     if (value.length < 6) {
//                                       return 'Password must be at least 6 characters';
//                                     }
//                                     return null;
//                                   },
//                                   isPassword: true,
//                                   isConfirm: false,
//                                 ),
//
//                                 SizedBox(height: h * 0.02),
//
//                                 // Confirm Password field
//                                 _buildPasswordField(
//                                   Icons.lock_outline,
//                                   "Confirm Password",
//                                   controller: _confirmPasswordController,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please confirm your password';
//                                     }
//                                     return null;
//                                   },
//                                   isPassword: true,
//                                   isConfirm: true,
//                                 ),
//
//                                 SizedBox(height: h * 0.03),
//
//                                 // Terms & Conditions
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           _agreeToTerms = !_agreeToTerms;
//                                         });
//                                       },
//                                       child: Container(
//                                         width: 20,
//                                         height: 20,
//                                         decoration: BoxDecoration(
//                                           color: _agreeToTerms
//                                               ? Color(0xFFFF7043)
//                                               : Colors.white,
//                                           borderRadius: BorderRadius.circular(4),
//                                           border: Border.all(
//                                             color: _agreeToTerms
//                                                 ? Color(0xFFFF7043)
//                                                 : Colors.grey,
//                                             width: 1.5,
//                                           ),
//                                         ),
//                                         child: _agreeToTerms
//                                             ? Icon(
//                                           Icons.check,
//                                           size: 16,
//                                           color: Colors.white,
//                                         )
//                                             : null,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                     Expanded(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             _agreeToTerms = !_agreeToTerms;
//                                           });
//                                         },
//                                         child: Text(
//                                           "I agree to Terms & Conditions",
//                                           style: TextStyle(
//                                             color: Colors.grey[700],
//                                             fontSize: w * 0.035,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: h * 0.05),
//
//                                 // Sign Up Button
//                                 AnimatedBuilder(
//                                   animation: _controller,
//                                   builder: (context, child) {
//                                     return Transform.scale(
//                                       scale: _scaleAnimation.value,
//                                       child: GestureDetector(
//                                         onTap: _submitForm,
//                                         child: Container(
//                                           width: w * 0.7,
//                                           height: h * 0.07,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(15),
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
//                                                 color: Colors.black.withOpacity(0.3),
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
//                                               child: CircularProgressIndicator(
//                                                 valueColor:
//                                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                                                 strokeWidth: 2,
//                                               ),
//                                             )
//                                                 : Text(
//                                               "Sign Up",
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
//                                 // Login link
//                                 AnimatedBuilder(
//                                   animation: _controller,
//                                   builder: (context, child) {
//                                     return Transform.translate(
//                                       offset: Offset(0, _slideAnimation.value),
//                                       child: Opacity(
//                                         opacity: _fadeAnimation.value,
//                                         child: Center(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               Navigator.pushReplacement(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) => const LoginScreen(),
//                                                 ),
//                                               );
//                                             },
//                                             child: RichText(
//                                               text: TextSpan(
//                                                 text: "Already have an account? ",
//                                                 style: TextStyle(
//                                                   color: Colors.grey[700],
//                                                   fontSize: w * 0.04,
//                                                 ),
//                                                 children: [
//                                                   TextSpan(
//                                                     text: "Sign In",
//                                                     style: TextStyle(
//                                                       color: Color(0xFFFF7043),
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
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
//
//   Widget _buildTextField(
//       IconData icon,
//       String hint, {
//         TextEditingController? controller,
//         TextInputType keyboardType = TextInputType.text,
//         String? Function(String?)? validator,
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!, width: 1),
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: TextStyle(color: Colors.black87),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.grey[600]),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//           errorStyle: TextStyle(fontSize: 12),
//         ),
//         validator: validator,
//       ),
//     );
//   }
//
//   Widget _buildPasswordField(
//       IconData icon,
//       String hint, {
//         required TextEditingController controller,
//         required String? Function(String?)? validator,
//         required bool isPassword,
//         required bool isConfirm,
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!, width: 1),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: isConfirm ? !_isConfirmPasswordVisible : !_isPasswordVisible,
//         style: TextStyle(color: Colors.black87),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.grey[600]),
//           suffixIcon: IconButton(
//             icon: Icon(
//               isConfirm
//                   ? (_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)
//                   : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
//               color: Colors.grey[600],
//             ),
//             onPressed: () {
//               setState(() {
//                 if (isConfirm) {
//                   _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                 } else {
//                   _isPasswordVisible = !_isPasswordVisible;
//                 }
//               });
//             },
//           ),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//           errorStyle: TextStyle(fontSize: 12),
//         ),
//         validator: validator,
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



















// import 'package:flutter/material.dart';
// import '../login_screen/login_screen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             expandedHeight: 180,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF667EEA),
//                       Color(0xFF764BA2),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(60),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 32, bottom: 32),
//                   child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // IconButton(
//                         //   onPressed: () => Navigator.pop(context),
//                         //   icon: Icon(
//                         //     Icons.arrow_back_ios_new_rounded,
//                         //     color: Colors.white,
//                         //     size: 24,
//                         //   ),
//                         // ),
//                         SizedBox(height: 20),
//                         Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.white,
//                             height: 1.2,
//                           ),
//                         ),
//                         SizedBox(height: 2),
//                         Text(
//                           "Join us today",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Form section
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(32.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Name field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: Color(0xFFE0E0E0),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: _nameController,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF333333),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "User Name",
//                           hintStyle: TextStyle(color: Color(0xFF999999)),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(18),
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(left: 15, right: 10),
//                             child: Icon(
//                               Icons.person_2_outlined,
//                               color: Color(0xFF667EEA),
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     // SizedBox(height: 20),
//
//                     // Phone Number field (NEW FIELD)
//                     // Container(
//                     //   decoration: BoxDecoration(
//                     //     borderRadius: BorderRadius.circular(15),
//                     //     border: Border.all(
//                     //       color: Color(0xFFE0E0E0),
//                     //       width: 1.5,
//                     //     ),
//                     //   ),
//                     //   child: TextFormField(
//                     //     controller: _phoneController,
//                     //     keyboardType: TextInputType.phone,
//                     //     style: TextStyle(
//                     //       fontSize: 16,
//                     //       color: Color(0xFF333333),
//                     //       fontWeight: FontWeight.w500,
//                     //     ),
//                     //     decoration: InputDecoration(
//                     //       hintText: "Phone Number",
//                     //       hintStyle: TextStyle(color: Color(0xFF999999)),
//                     //       border: InputBorder.none,
//                     //       contentPadding: EdgeInsets.all(18),
//                     //       prefixIcon: Padding(
//                     //         padding: const EdgeInsets.only(left: 15, right: 10),
//                     //         child: Icon(
//                     //           Icons.phone_iphone_rounded,
//                     //           color: Color(0xFF667EEA),
//                     //           size: 24,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //     validator: (value) {
//                     //       if (value == null || value.isEmpty) {
//                     //         return 'Please enter your phone number';
//                     //       }
//                     //       if (value.length != 10) {
//                     //         return 'Enter a valid 10-digit phone number';
//                     //       }
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//
//                     SizedBox(height: 20),
//
//                     // Email field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: Color(0xFFE0E0E0),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF333333),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Email",
//                           hintStyle: TextStyle(color: Color(0xFF999999)),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(18),
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(left: 15, right: 10),
//                             child: Icon(
//                               Icons.email_outlined,
//                               color: Color(0xFF667EEA),
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!value.contains('@')) {
//                             return 'Enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Password field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: Color(0xFFE0E0E0),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         obscureText: _obscurePassword,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF333333),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           hintStyle: TextStyle(color: Color(0xFF999999)),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(18),
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(left: 15, right: 10),
//                             child: Icon(
//                               Icons.lock_outline,
//                               color: Color(0xFF667EEA),
//                               size: 24,
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Color(0xFF999999),
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//
//                     // Confirm password field
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: Color(0xFFE0E0E0),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: TextFormField(
//                         controller: _confirmPasswordController,
//                         obscureText: _obscureConfirmPassword,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF333333),
//                           fontWeight: FontWeight.w500,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Confirm password",
//                           hintStyle: TextStyle(color: Color(0xFF999999)),
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(18),
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(left: 15, right: 10),
//                             child: Icon(
//                               Icons.lock_reset_outlined,
//                               color: Color(0xFF667EEA),
//                               size: 24,
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _obscureConfirmPassword = !_obscureConfirmPassword;
//                               });
//                             },
//                             icon: Icon(
//                               _obscureConfirmPassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Color(0xFF999999),
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     SizedBox(height: 30),
//
//                     // Terms checkbox
//                     Row(
//                       children: [
//                         Container(
//                           width: 22,
//                           height: 22,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFF667EEA),
//                           ),
//                           child: Icon(
//                             Icons.check,
//                             color: Colors.white,
//                             size: 14,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             "I agree to Terms & Conditions",
//                             style: TextStyle(
//                               color: Color(0xFF666666),
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(height: 40),
//
//                     // Sign up button
//                     Container(
//                       width: double.infinity,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF667EEA),
//                             Color(0xFF764BA2),
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0xFF667EEA).withOpacity(0.3),
//                             blurRadius: 15,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             if (_passwordController.text != _confirmPasswordController.text) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text("Passwords do not match"),
//                                   backgroundColor: Colors.red,
//                                   behavior: SnackBarBehavior.floating,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               );
//                               return;
//                             }
//
//                             // Show success snackbar
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Row(
//                                   children: [
//                                     Icon(Icons.check_circle, color: Colors.white, size: 20),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Registration successful!",
//                                       style: TextStyle(fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 backgroundColor: Colors.green,
//                                 behavior: SnackBarBehavior.floating,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//
//                             // Wait for snackbar to show, then navigate
//                             await Future.delayed(Duration(milliseconds: 1500));
//
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const LoginScreen(),
//                               ),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           foregroundColor: Colors.white,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           padding: EdgeInsets.zero,
//                         ),
//                         child: Text(
//                           "SIGN UP",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(height: 30),
//
//
//
//
//
//
//
//                     // Login link
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginScreen(),
//                           ),
//                         );
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           text: "Already have an account? ",
//                           style: TextStyle(
//                             color: Color(0xFF666666),
//                             fontSize: 15,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: "Sign in",
//                               style: TextStyle(
//                                 color: Color(0xFF667EEA),
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'dart:async';

import '../login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;

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
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please agree to Terms & Conditions"),
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


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Registration Successful!"),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );


        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                registeredEmail: _emailController.text,
                registeredPassword: _passwordController.text,
              ),
            ),
          );
        });
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
                SizedBox(height: h * 0.03),

                Padding(
                  padding: EdgeInsets.only(left: w * 0.04),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                            padding: EdgeInsets.only(left: w * 0.03),
                            child: Text(
                              "Create Account",
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
                              "Complete your profile",
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

                                _buildSectionHeader("Personal Information"),

                                SizedBox(height: h * 0.015),


                                _buildTextField(
                                  Icons.person_outline,
                                  "Full Name *",
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    if (value.length < 3) {
                                      return 'Name must be at least 3 characters';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: h * 0.02),


                                _buildTextField(
                                  Icons.email_outlined,
                                  "Email *",
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: h * 0.025),


                                _buildSectionHeader("Address Information"),

                                SizedBox(height: h * 0.015),


                                _buildTextField(
                                  Icons.location_on_outlined,
                                  "Address (Optional)",
                                  controller: _addressController,
                                  keyboardType: TextInputType.streetAddress,
                                ),

                                SizedBox(height: h * 0.02),


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "City *",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    _buildTextField(
                                      Icons.location_city_outlined,
                                      "Enter city",
                                      controller: _cityController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter city';
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: h * 0.02),


                                    Text(
                                      "State *",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    _buildTextField(
                                      Icons.flag_outlined,
                                      "Enter state",
                                      controller: _stateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter state';
                                        }
                                        return null;
                                      },
                                    ),


                                    SizedBox(height: h * 0.02),
                                    Text(
                                      "Country *",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),

                                    _buildTextField(
                                      Icons.public_outlined,
                                      "Enter country",
                                      controller: _countryController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter country';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),



                                SizedBox(height: h * 0.025),


                                _buildSectionHeader("Account Security"),

                                SizedBox(height: h * 0.015),


                                _buildPasswordField(
                                  Icons.lock_outline,
                                  "Password *",
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  isConfirm: false,
                                ),

                                SizedBox(height: h * 0.02),


                                _buildPasswordField(
                                  Icons.lock_outline,
                                  "Confirm Password *",
                                  controller: _confirmPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  isConfirm: true,
                                ),

                                SizedBox(height: h * 0.03),


                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _agreeToTerms = !_agreeToTerms;
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: _agreeToTerms
                                              ? Color(0xFFFF7043)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: _agreeToTerms
                                                ? Color(0xFFFF7043)
                                                : Colors.grey,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: _agreeToTerms
                                            ? Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _agreeToTerms = !_agreeToTerms;
                                          });
                                        },
                                        child: Text.rich(
                                          TextSpan(
                                            text: "I agree to the ",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: w * 0.035,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "Terms & Conditions",
                                                style: TextStyle(
                                                  color: Color(0xFFFF7043),
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
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
                                            borderRadius: BorderRadius.circular(15),
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
                                                AlwaysStoppedAnimation<Color>(Colors.white),
                                                strokeWidth: 2,
                                              ),
                                            )
                                                : Text(
                                              "Create Account",
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
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const LoginScreen(),
                                                ),
                                              );
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                text: "Already have an account? ",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: w * 0.04,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: "Sign In",
                                                    style: TextStyle(
                                                      color: Color(0xFFFF7043),
                                                      fontWeight: FontWeight.bold,
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

  Widget _buildSectionHeader(String title) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
    );
  }

  Widget _buildTextField(
      IconData icon,
      String hint, {
        TextEditingController? controller,
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
        int maxLines = 1,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black87),
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: maxLines > 1 ? 15 : 18, horizontal: 15),
          errorStyle: TextStyle(fontSize: 12),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField(
      IconData icon,
      String hint, {
        required TextEditingController controller,
        required String? Function(String?)? validator,
        required bool isPassword,
        required bool isConfirm,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isConfirm ? !_isConfirmPasswordVisible : !_isPasswordVisible,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon: IconButton(
            icon: Icon(
              isConfirm
                  ? (_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)
                  : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                if (isConfirm) {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                } else {
                  _isPasswordVisible = !_isPasswordVisible;
                }
              });
            },
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          errorStyle: TextStyle(fontSize: 12),
        ),
        validator: validator,
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














