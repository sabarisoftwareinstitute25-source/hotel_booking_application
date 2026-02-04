import 'package:flutter/material.dart';
import 'dart:async';

import '../home_screen/hotel_registration_screen.dart';
import '../home_screen/hotel_search_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'forget_password.dart';
import 'otp_screen.dart';
import '../services/api_service.dart';
import '../models/auth_models.dart';

class LoginScreen extends StatefulWidget {

  final String? registeredEmail;
  final String? registeredPassword;
  final String? preFilledPhone; // Phone number from OTP verification
  final String? preFilledName; // Name from OTP verification
  
  const LoginScreen({
    super.key, 
    this.registeredEmail, 
    this.registeredPassword,
    this.preFilledPhone,
    this.preFilledName,
  });

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
  
  // Field-level error tracking
  Map<String, String?> _fieldErrors = {};




  @override
  void initState() {
    super.initState();

    // Pre-fill email and password if provided
    if (widget.registeredEmail != null) {
      _emailController.text = widget.registeredEmail!;
    }
    if (widget.registeredPassword != null) {
      _passwordController.text = widget.registeredPassword!;
    }
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




  void _submitForm() async {
    // Clear previous errors
    setState(() {
      _fieldErrors.clear();
    });
    
    // Validate fields with comprehensive checks
    bool hasErrors = false;
    String emailInput = _emailController.text.trim();
    String passwordInput = _passwordController.text.trim();
    
    // Validate email/phone field
    if (emailInput.isEmpty) {
      setState(() {
        _fieldErrors['email'] = 'Email or phone number is required';
      });
      hasErrors = true;
    } else if (emailInput.length < 3) {
      setState(() {
        _fieldErrors['email'] = 'Email or phone number must be at least 3 characters';
      });
      hasErrors = true;
    } else if (emailInput.length > 150) {
      setState(() {
        _fieldErrors['email'] = 'Email or phone number must not exceed 150 characters';
      });
      hasErrors = true;
    } else {
      // Check if it's an email
      bool isEmail = RegExp(r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$').hasMatch(emailInput);
      
      // Check if it's a phone number (remove spaces, dashes, parentheses for validation)
      String cleanedPhone = emailInput.replaceAll(RegExp(r'[\s\-\(\)]'), '');
      bool isPhone = RegExp(r'^\+?[1-9]\d{9,14}$').hasMatch(cleanedPhone) || 
                     RegExp(r'^[0-9]{10}$').hasMatch(cleanedPhone);
      
      if (!isEmail && !isPhone) {
        setState(() {
          _fieldErrors['email'] = 'Please enter a valid email address (e.g., user@example.com) or phone number (e.g., +91 9876543210)';
        });
        hasErrors = true;
      }
    }
    
    // Validate password field
    if (passwordInput.isEmpty) {
      setState(() {
        _fieldErrors['password'] = 'Password is required';
      });
      hasErrors = true;
    } else if (passwordInput.length < 6) {
      setState(() {
        _fieldErrors['password'] = 'Password must be at least 6 characters long';
      });
      hasErrors = true;
    } else if (passwordInput.length > 100) {
      setState(() {
        _fieldErrors['password'] = 'Password must not exceed 100 characters';
      });
      hasErrors = true;
    }
    
    // CRITICAL: Stop here if validation fails - do NOT proceed to API call
    if (hasErrors) {
      // Update UI to show errors
      setState(() {
        _isLoading = false;
      });
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Please fix ${_fieldErrors.length} validation error${_fieldErrors.length > 1 ? 's' : ''} before continuing',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        ),
      );
      
      // STOP - Do not proceed to API call
      return;
    }

    // Only proceed if validation passes
    setState(() {
      _isLoading = true;
    });

    try {
      // Double-check validation before API call (defense in depth)
      final emailInput = _emailController.text.trim();
      final passwordInput = _passwordController.text.trim();
      
      // Final validation check - prevent API call if invalid
      if (emailInput.isEmpty || passwordInput.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email/phone and password are required'),
            backgroundColor: Colors.red[700],
          ),
        );
        return; // STOP - Do not call API
      }
      
      // Validate format one more time before API call
      bool isValidEmail = RegExp(r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$').hasMatch(emailInput);
      String cleanedPhone = emailInput.replaceAll(RegExp(r'[\s\-\(\)]'), '');
      bool isValidPhone = RegExp(r'^\+?[1-9]\d{9,14}$').hasMatch(cleanedPhone) || 
                         RegExp(r'^[0-9]{10}$').hasMatch(cleanedPhone);
      
      if (!isValidEmail && !isValidPhone) {
        setState(() {
          _isLoading = false;
          _fieldErrors['email'] = 'Invalid email or phone format';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email or phone number'),
            backgroundColor: Colors.red[700],
          ),
        );
        return; // STOP - Do not call API
      }
      
      if (passwordInput.length < 6 || passwordInput.length > 100) {
        setState(() {
          _isLoading = false;
          _fieldErrors['password'] = 'Password must be 6-100 characters';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password must be between 6 and 100 characters'),
            backgroundColor: Colors.red[700],
          ),
        );
        return; // STOP - Do not call API
      }

      // Create login request - only if all validations pass
      final loginRequest = LoginRequest(
        email: emailInput,
        password: passwordInput,
      );

      // Call API service - only reached if validation passes
      final apiService = ApiService();
      final response = await apiService.login(loginRequest);

      setState(() {
        _isLoading = false;
      });

      // CRITICAL SECURITY CHECKS: Stop login immediately if:
      // 1. Response status is 401 (Unauthorized) - User doesn't exist OR password is wrong
      // 2. Response is not successful
      // 3. Token is null or empty
      // 4. User is null
      
      bool isUnauthorized = response.statusCode == 401;
      bool hasNoToken = response.data == null || 
                        response.data!.token == null || 
                        response.data!.token!.isEmpty;
      bool hasNoUser = response.data == null || response.data!.user == null;
      
      // STOP LOGIN if any of these conditions are true
      if (isUnauthorized || !response.success || hasNoToken || hasNoUser) {
        // DO NOT set token
        // DO NOT set user
        // DO NOT navigate
        
        // Show error message
        String errorMessage = "Invalid email or password";
        if (isUnauthorized) {
          errorMessage = "Invalid email or password. Please check your credentials.";
        } else if (response.message.isNotEmpty) {
          errorMessage = response.message;
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(errorMessage),
                ),
              ],
            ),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
        
        // STOP HERE - Do not proceed
        return;
      }

      // Only reach here if ALL security checks pass:
      // - Response is successful (200-299)
      // - Status is NOT 401
      // - Token exists and is not empty
      // - User exists
      
      // FINAL VERIFICATION: Double-check before setting credentials
      if (response.statusCode == 401 || 
          response.data == null || 
          response.data!.token == null || 
          response.data!.token!.isEmpty ||
          response.data!.user == null) {
        // This should never happen due to checks above, but safety net
        print('⚠️ SECURITY WARNING: Attempted to set credentials with invalid response');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
            backgroundColor: Colors.red[700],
          ),
        );
        return; // STOP - Do not set credentials
      }
      
      // All checks passed - Safe to set credentials
      apiService.setAuthToken(response.data!.token!);
      apiService.setCurrentUser(response.data!.user!);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("Login Successful!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to home screen - only if all checks passed
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HotelSearchScreen()),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // CRITICAL: On any error, DO NOT set token or user
      // DO NOT navigate
      // Only show error message
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text("Login failed. Please check your credentials and try again."),
              ),
            ],
          ),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      
      // STOP HERE - No token, no user, no navigation
      return;
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
                                "Email Address or Phone Number",
                                controller: _emailController,
                                keyboardType: TextInputType.text,
                                fieldKey: 'email',
                              ),

                              SizedBox(height: h * 0.02),

                              _buildPasswordField(
                                Icons.lock_outline,
                                "Password",
                                controller: _passwordController,
                                fieldKey: 'password',
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
    String? fieldKey,
  }) {
    String? errorText = fieldKey != null ? _fieldErrors[fieldKey] : null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null ? Colors.red[700]! : Colors.grey[300]!,
              width: errorText != null ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.black87),
            onChanged: (value) {
              // Clear error when user starts typing
              if (fieldKey != null && _fieldErrors.containsKey(fieldKey)) {
                setState(() {
                  _fieldErrors.remove(fieldKey);
                });
              }
            },
            onSubmitted: (value) {
              // Validate on submit (when user presses enter)
              if (fieldKey == 'email' && value.trim().isNotEmpty) {
                final emailInput = value.trim();
                bool isValidEmail = RegExp(r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$').hasMatch(emailInput);
                String cleanedPhone = emailInput.replaceAll(RegExp(r'[\s\-\(\)]'), '');
                bool isValidPhone = RegExp(r'^\+?[1-9]\d{9,14}$').hasMatch(cleanedPhone) || 
                                   RegExp(r'^[0-9]{10}$').hasMatch(cleanedPhone);
                
                if (!isValidEmail && !isValidPhone) {
                  setState(() {
                    _fieldErrors['email'] = 'Please enter a valid email or phone number';
                  });
                }
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                errorText != null ? Icons.error_outline : icon,
                color: errorText != null ? Colors.red[700] : Colors.grey[600],
              ),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 12),
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red[700], size: 14),
                SizedBox(width: 4),
                Text(
                  errorText,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField(
    IconData icon,
    String hint, {
    required TextEditingController controller,
    String? fieldKey,
  }) {
    String? errorText = fieldKey != null ? _fieldErrors[fieldKey] : null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: errorText != null ? Colors.red[700]! : Colors.grey[300]!,
              width: errorText != null ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: !_isPasswordVisible,
            style: TextStyle(color: Colors.black87),
            onChanged: (value) {
              // Clear error when user starts typing
              if (fieldKey != null && _fieldErrors.containsKey(fieldKey)) {
                setState(() {
                  _fieldErrors.remove(fieldKey);
                });
              }
            },
            onSubmitted: (value) {
              // Validate password on submit (when user presses enter)
              if (fieldKey == 'password' && value.trim().isNotEmpty) {
                if (value.length < 6) {
                  setState(() {
                    _fieldErrors['password'] = 'Password must be at least 6 characters';
                  });
                } else if (value.length > 100) {
                  setState(() {
                    _fieldErrors['password'] = 'Password must not exceed 100 characters';
                  });
                }
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                errorText != null ? Icons.error_outline : icon,
                color: errorText != null ? Colors.red[700] : Colors.grey[600],
              ),
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
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6, left: 12),
            child: Row(
              children: [
                Icon(Icons.error, color: Colors.red[700], size: 14),
                SizedBox(width: 4),
                Text(
                  errorText,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
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
