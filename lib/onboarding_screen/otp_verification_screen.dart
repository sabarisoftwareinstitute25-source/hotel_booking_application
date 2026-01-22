//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import '../signup_screen/signup_screen.dart';
//
// class OtpVerificationScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const OtpVerificationScreen({super.key, required this.phoneNumber});
//
//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }
//
// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final List<TextEditingController> _otpControllers =
//   List.generate(6, (index) => TextEditingController());
//   final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
//   int _secondsRemaining = 30;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_secondsRemaining > 0) {
//         setState(() {
//           _secondsRemaining--;
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   void resendCode() {
//     setState(() {
//       _secondsRemaining = 30;
//     });
//     startTimer();
//     // Resend OTP logic here
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Gradient Section
//             Container(
//               height: 220,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF667EEA),
//                     Color(0xFF764BA2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   // Back Button
//                   Positioned(
//                     top: 20,
//                     left: 20,
//                     child: Container(
//                       width: 44,
//                       height: 44,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                       child: IconButton(
//                         onPressed: () => Navigator.pop(context),
//                         icon: Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Center Content
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Lock Icon with Animation
//                         Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.2),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.3),
//                               width: 2,
//                             ),
//                           ),
//                           child: Icon(
//                             Icons.lock_open_rounded,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Text(
//                           "Verify OTP",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Main Content
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 20),
//
//                       // Message
//                       Text(
//                         "Enter the verification code",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF1F2937),
//                         ),
//                       ),
//
//                       SizedBox(height: 8),
//
//                       Text.rich(
//                         TextSpan(
//                           text: "Sent to ",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color(0xFF6B7280),
//                           ),
//                           children: [
//                             TextSpan(
//                               text: "+91 ${widget.phoneNumber}",
//                               style: TextStyle(
//                                 color: Color(0xFF667EEA),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       SizedBox(height: 40),
//
//                       // OTP Boxes - Fixed width and spacing
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: List.generate(6, (index) {
//                             return Container(
//                               width: 44, // Reduced from 50
//                               height: 56, // Reduced from 60
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: _focusNodes[index].hasFocus
//                                       ? Color(0xFF667EEA)
//                                       : Color(0xFFE5E7EB),
//                                   width: _focusNodes[index].hasFocus ? 2 : 1,
//                                 ),
//                                 boxShadow: _focusNodes[index].hasFocus
//                                     ? [
//                                   BoxShadow(
//                                     color: Color(0xFF667EEA).withOpacity(0.2),
//                                     blurRadius: 10,
//                                     spreadRadius: 1,
//                                   ),
//                                 ]
//                                     : [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 5,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: TextField(
//                                 controller: _otpControllers[index],
//                                 focusNode: _focusNodes[index],
//                                 textAlign: TextAlign.center,
//                                 keyboardType: TextInputType.number,
//                                 maxLength: 1,
//                                 style: TextStyle(
//                                   fontSize: 22, // Reduced from 24
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xFF1F2937),
//                                 ),
//                                 decoration: const InputDecoration(
//                                   counterText: "",
//                                   border: InputBorder.none,
//                                 ),
//                                 onChanged: (value) {
//                                   if (value.isNotEmpty && index < 5) {
//                                     _focusNodes[index + 1].requestFocus();
//                                   }
//                                   if (value.isEmpty && index > 0) {
//                                     _focusNodes[index - 1].requestFocus();
//                                   }
//
//                                   // Check if all fields are filled
//                                   bool allFilled = _otpControllers.every((controller) => controller.text.isNotEmpty);
//                                   if (allFilled) {
//                                     FocusScope.of(context).unfocus();
//                                   }
//                                 },
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//
//                       SizedBox(height: 30),
//
//                       // Timer and Resend
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.timer_outlined,
//                             color: Color(0xFF667EEA),
//                             size: 18,
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "Code expires in: ",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color(0xFF6B7280),
//                             ),
//                           ),
//                           Text(
//                             "00:${_secondsRemaining.toString().padLeft(2, '0')}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFFEF4444),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       SizedBox(height: 16),
//
//                       // Resend Button
//                       TextButton(
//                         onPressed: _secondsRemaining == 0 ? resendCode : null,
//                         child: Text(
//                           "Resend Code",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: _secondsRemaining == 0
//                                 ? Color(0xFF667EEA)
//                                 : Color(0xFF9CA3AF),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: 36),
//
//                       // Verify Button - Fixed width to be responsive
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.6, // 60% of screen width
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Verify OTP logic here
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const SignUpScreen(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF667EEA),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: Text(
//                             "Verify",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       SizedBox(height: 20),
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
// }













import 'dart:async';

import 'package:flutter/material.dart';
import '../signup_screen/signup_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber, required String username});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  int _secondsRemaining = 30;
  late Timer _timer;
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
    startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    setState(() {
      _secondsRemaining = 30;
    });
    startTimer();

  }

  void _verifyOtp() {
    bool allFilled = _otpControllers.every((controller) => controller.text.isNotEmpty);

    if (!allFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all OTP digits"),
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
              Text("OTP Verified Successfully!"),
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
            builder: (context) => const SignUpScreen(),
          ),
        );
      });
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
                              "Verify OTP",
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
                              "Enter the 6-digit code sent to your phone",
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
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.lock_open_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: h * 0.03),


                              Text.rich(
                                TextSpan(
                                  text: "Sent to ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "+91 ${widget.phoneNumber}",
                                      style: TextStyle(
                                        color: Color(0xFFFF7043),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: h * 0.04),


                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(6, (index) {
                                    return Container(
                                      width: w * 0.12,
                                      height: w * 0.12,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _focusNodes[index].hasFocus
                                              ? Color(0xFFFF7043)
                                              : Colors.grey[300]!,
                                          width: _focusNodes[index].hasFocus ? 2 : 1,
                                        ),
                                        boxShadow: _focusNodes[index].hasFocus
                                            ? [
                                          BoxShadow(
                                            color: Color(0xFFFF7043).withOpacity(0.2),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                            : [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _otpControllers[index],
                                        focusNode: _focusNodes[index],
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        maxLength: 1,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF333333),
                                        ),
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty && index < 5) {
                                            _focusNodes[index + 1].requestFocus();
                                          }
                                          if (value.isEmpty && index > 0) {
                                            _focusNodes[index - 1].requestFocus();
                                          }

                                          bool allFilled = _otpControllers.every(
                                                  (controller) => controller.text.isNotEmpty);
                                          if (allFilled) {
                                            FocusScope.of(context).unfocus();
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),

                              SizedBox(height: h * 0.04),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Color(0xFFFF7043),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Code expires in: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text(
                                    "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFF5F6D),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: h * 0.02),


                              TextButton(
                                onPressed: _secondsRemaining == 0 ? resendCode : null,
                                child: Text(
                                  "Resend Code",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _secondsRemaining == 0
                                        ? Color(0xFFFF7043)
                                        : Colors.grey[400],
                                  ),
                                ),
                              ),

                              SizedBox(height: h * 0.04),


                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _scaleAnimation.value,
                                    child: GestureDetector(
                                      onTap: _verifyOtp,
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
                                            "Verify",
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

                              SizedBox(height: h * 0.02),
                            ],
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