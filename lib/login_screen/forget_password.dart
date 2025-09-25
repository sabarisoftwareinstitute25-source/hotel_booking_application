// import 'package:flutter/material.dart';
// import '../login_screen/login_screen.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   final String? registeredEmail;
//   final String? registeredPassword;
//
//   const ForgotPasswordScreen({super.key, this.registeredEmail, this.registeredPassword});
//
//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//
//   bool _emailVerified = false;
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Forgot Password")),
//       body: Padding(
//         padding: EdgeInsets.all(w * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: "Enter your registered email",
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (_emailVerified)
//               TextField(
//                 controller: _newPasswordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: "Enter new password",
//                 ),
//               ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 if (!_emailVerified) {
//                   // Step 1: Verify email
//                   if (_emailController.text.trim() == widget.registeredEmail) {
//                     setState(() {
//                       _emailVerified = true;
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Email verified! Enter new password.")),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Email not found!")),
//                     );
//                   }
//                 } else {
//                   // Step 2: Update password and go back to login
//                   if (_newPasswordController.text.trim().isNotEmpty) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => LoginScreen(
//                           registeredEmail: widget.registeredEmail,
//                           registeredPassword: _newPasswordController.text.trim(),
//                         ),
//                       ),
//                     );
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Password updated! Please login.")),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Enter new password")),
//                     );
//                   }
//                 }
//               },
//               child: Text(!_emailVerified ? "Verify Email" : "Update Password"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import '../login_screen/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? registeredEmail;
  final String? registeredPassword;

  const ForgotPasswordScreen({super.key, this.registeredEmail, this.registeredPassword});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _emailVerified = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient + background painter like LoginScreen
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
            child: Padding(
              padding: EdgeInsets.all(w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.08),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(height: h * 0.02),
                  Center(
                    child: Text(
                      "Forgot Password",
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
                  SizedBox(height: h * 0.03),
                  Container(
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
                          "Enter your registered email",
                          _emailController,
                        ),
                        SizedBox(height: h * 0.02),
                        if (_emailVerified)
                          _buildTextField(
                            "Enter new password",
                            _newPasswordController,
                            obscureText: true,
                          ),
                        SizedBox(height: h * 0.03),
                        ElevatedButton(
                          onPressed: () {
                            if (!_emailVerified) {
                              // Verify email
                              if (_emailController.text.trim() == widget.registeredEmail) {
                                setState(() => _emailVerified = true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Email verified! Enter new password.")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Email not found!")),
                                );
                              }
                            } else {
                              // Update password
                              if (_newPasswordController.text.trim().isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginScreen(
                                      registeredEmail: widget.registeredEmail,
                                      registeredPassword: _newPasswordController.text.trim(),
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Password updated! Please login.")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Enter new password")),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7043),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text(
                            !_emailVerified ? "Verify Email" : "Update Password",
                            style: TextStyle(fontSize: w * 0.045, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }
}

// Same background painter as LoginScreen
class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.1), size.width * 0.15, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), size.width * 0.1, paint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.5), size.width * 0.12, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.6), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.8), size.width * 0.1, paint);

    final rectPaint = Paint()
      ..color = Color(0xFFFF8A65).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(center: Offset(size.width * 0.7, size.height * 0.3), width: size.width * 0.2, height: size.width * 0.2),
      rectPaint,
    );

    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.75), size.width * 0.08, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
