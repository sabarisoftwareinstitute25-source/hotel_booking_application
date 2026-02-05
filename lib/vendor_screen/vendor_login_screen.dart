import 'package:flutter/material.dart';
import '../home_screen/hotel_registration_screen.dart';
import '../login_screen/login_screen.dart';
import '../signup_screen/signup_screen.dart';

/// Vendor Login Screen - First screen for vendors to authenticate
class VendorLoginScreen extends StatefulWidget {
  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Logo/Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5F6D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.business,
                    size: 50,
                    color: Color(0xFFFF5F6D),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Title
                const Text(
                  'Property Partner',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 10),
                
                const Text(
                  'Manage your hospitality business',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 50),
                
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ).then((result) {
                      // If login successful, navigate to registration form
                      if (result == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HotelRegistrationScreen(),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5F6D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sign Up Button - Navigate to OTP verification for signup
                OutlinedButton(
                  onPressed: () {
                    // For signup, we'll use the OTP flow
                    // Navigate to a signup screen or OTP screen
                    // For now, show a message that signup is via OTP
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sign Up'),
                        content: const Text('Please use the main app signup flow with OTP verification. After signing up, you can login here to register your property.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF5F6D),
                    side: const BorderSide(color: Color(0xFFFF5F6D), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Info text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Login or create an account to register your hotel or villa property',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

