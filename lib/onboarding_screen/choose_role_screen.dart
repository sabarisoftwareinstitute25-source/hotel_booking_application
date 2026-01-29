import 'package:flutter/material.dart';
import 'package:hotel_booking_mobile_application/onboarding_screen/find_stays_screen.dart';
import '../home_screen/hotel_registration_screen.dart';

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
                            // Color(0xFF3B82F6),
                            // Color(0xFF8B5CF6),
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
                      // Update the List Property onTap in ChooseRoleScreen:
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
//   const PropertyAuthScreen({super.key});
//
//   @override
//   State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
// }
//
// class _PropertyAuthScreenState extends State<PropertyAuthScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
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
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _handleLogin() {
//     // For demo, just navigate to PropertyTypeScreen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HotelOwnerDashboard(hotelName: '', ownerName: '', mobileNumber: '', email: '', addressLine1: '', addressLine2: '', city: '', district: '', state: '', pinCode: '', gstNumber: '', fssaiLicense: '', tradeLicense: '', panNumber: '', aadharNumber: '', accountHolderName: '', bankName: '', accountNumber: '', ifscCode: '', branch: '', accountType: '', personPhotoInfo: {}, totalRooms: 35),
//       ),
//     );
//   }
//
//   void _handleRegister() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PropertyTypeScreen(),
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
//                     Tab(text: 'New User Registration'),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
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
//
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRegisterTab() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(24),
//       child: Column(
//         children: [
//           Text(
//             "New Property Registration",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1F2937),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           Text(
//             "Register your hotel, villa, or guest house to start earning with us",
//             style: TextStyle(
//               color: Color(0xFF6B7280),
//               // textAlign: TextAlign.center,
//             ),
//           ),
//
//           const SizedBox(height: 30),
//
//           // Benefits List
//           _buildBenefitItem(Icons.verified, "Verified Partner Badge"),
//           _buildBenefitItem(Icons.group, "Reach millions of travelers"),
//           _buildBenefitItem(Icons.attach_money, "Competitive commission rates"),
//           _buildBenefitItem(Icons.support_agent, "24/7 partner support"),
//
//           const SizedBox(height: 30),
//
//           // Register Button
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: _handleRegister,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFFF5F6D),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 "Create an account",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Terms
//           Text(
//             "By registering, you agree to our Terms & Conditions",
//             style: TextStyle(
//               fontSize: 12,
//               color: Color(0xFF6B7280),
//             ),
//             textAlign: TextAlign.center,
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
//     bool isPassword = false,
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
//             decoration: InputDecoration(
//               hintText: hint,
//               prefixIcon: Icon(icon, color: Color(0xFF6B7280)),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.all(16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBenefitItem(IconData icon, String text) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: Colors.red.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, size: 20, color: Colors.red),
//           ),
//           const SizedBox(width: 12),
//           Text(
//             text,
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
// }



class PropertyAuthScreen extends StatefulWidget {
  const PropertyAuthScreen({super.key});

  @override
  State<PropertyAuthScreen> createState() => _PropertyAuthScreenState();
}


class _PropertyAuthScreenState extends State<PropertyAuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Register form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    _registerPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // For demo, just navigate to PropertyTypeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerDashboard(
            hotelName: '',
            ownerName: '',
            mobileNumber: '',
            email: '',
            addressLine1: '',
            addressLine2: '',
            city: '',
            district: '',
            state: '',
            pinCode: '',
            gstNumber: '',
            fssaiLicense: '',
            tradeLicense: '',
            panNumber: '',
            aadharNumber: '',
            accountHolderName: '',
            bankName: '',
            accountNumber: '',
            ifscCode: '',
            branch: '',
            accountType: '',
            personPhotoInfo: {},
            totalRooms: 35
        ),
      ),
    );
  }

  void _handleRegister() {
    // Validate form
    if (_nameController.text.isEmpty ||
        _businessNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _registerPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_registerPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to Welcome/Info Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(

        ),
      ),
    );
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
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Logo
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

              // Tab Bar
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
                    // Login Tab
                    _buildLoginTab(),

                    // Register Tab
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          // Email Field
          _buildTextField(
            label: "Email Address",
            hint: "Enter your email",
            icon: Icons.email,
            controller: _emailController,
          ),

          const SizedBox(height: 16),

          // Password Field
          _buildTextField(
            label: "Password",
            hint: "Enter your password",
            icon: Icons.lock,
            controller: _passwordController,
            isPassword: true,
          ),

          const SizedBox(height: 4),

          // Forgot Password
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

          // Login Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF5F6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
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




          // Form Container
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
                // Form Header
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

                // Form Fields
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Name Field
                      _buildModernTextField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        icon: Icons.person_outline_rounded,
                        controller: _nameController,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      // Business Name Field
                      _buildModernTextField(
                        label: "Business Name",
                        hint: "Hotel/Guest House/Business name",
                        icon: Icons.business_outlined,
                        controller: _businessNameController,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      // Combined Phone or Email Field
                      _buildModernTextField(
                        label: "Phone or Email",
                        hint: "Phone number or email address",
                        icon: Icons.contact_phone_outlined,
                        controller: _phoneController,
                        keyboardType: TextInputType.emailAddress,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      // Password Field
                      _buildModernTextField(
                        label: "Password",
                        hint: "Create a strong password",
                        icon: Icons.lock_outline_rounded,
                        controller: _registerPasswordController,
                        isPassword: true,
                        isRequired: true,
                      ),

                      SizedBox(height: 16),

                      // Confirm Password Field
                      _buildModernTextField(
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

          // Register Button
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
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Row(
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
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
            border: Border.all(color: Color(0xFFE5E7EB)),
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
                  obscureText: isPassword,
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
                        Icons.visibility_outlined,
                        size: 20,
                        color: Color(0xFF6B7280),
                      ),
                      onPressed: () {
                        // Toggle password visibility
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
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Color(0xFF6B7280)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Color(0xFF6B7280),
                ),
                onPressed: () {
                  // Toggle password visibility if needed
                },
              )
                  : null,
            ),
          ),
        ),
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

                // Logo
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

                /// 🏨 REGISTER SECTION (ONLY)
                _buildRegisterTab(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // // ---------------- REGISTER ----------------
  // Widget _buildRegisterTab() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const Text(
  //           "New Property Registration",
  //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //         ),
  //
  //         const SizedBox(height: 12),
  //
  //         Center(
  //           child: const Text(
  //             "Register your hotel, villa, or guest house to start earning with us",
  //             style: TextStyle(color: Color(0xFF6B7280)),
  //           ),
  //         ),
  //
  //         const SizedBox(height: 24),
  //
  //         _buildBenefitItem(Icons.verified, "Verified Partner Badge"),
  //         _buildBenefitItem(Icons.group, "Reach millions of travelers"),
  //         _buildBenefitItem(Icons.attach_money, "Competitive commission rates"),
  //         _buildBenefitItem(Icons.support_agent, "24/7 partner support"),
  //
  //         const SizedBox(height: 24),
  //
  //         SizedBox(
  //           width: double.infinity,
  //           height: 50,
  //           child: ElevatedButton(
  //             onPressed: () {},
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFFFF5F6D),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             child: const Text(
  //               "Start Registration",
  //               style: TextStyle(color: Colors.white, fontSize: 16),
  //             ),
  //           ),
  //         ),
  //
  //         const SizedBox(height: 12),
  //
  //         const Text(
  //           "By registering, you agree to our Terms & Conditions",
  //           style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
  //           textAlign: TextAlign.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
            // Title
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

            // Subtitle
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

            // Benefits
            _buildBenefitItem(Icons.verified_rounded, "Verified Partner Badge"),
            _buildBenefitItem(Icons.public_rounded, "Reach millions of travelers"),
            _buildBenefitItem(Icons.trending_up_rounded, "Competitive commission rates"),
            _buildBenefitItem(Icons.support_agent_rounded, "24/7 dedicated partner support"),

            const SizedBox(height: 30),

            // CTA Button
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

            // Terms
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
      isAvailable: true, // Add this field
    ),
    PropertyType(
      icon: '🏡',
      title: 'Villa',
      description: 'Private Villas & Bungalows',
      color: Color(0xFFFFC371),
      isPopular: false,
      isAvailable: false, // Not available yet
    ),
    PropertyType(
      icon: '🏢',
      title: 'Apartment',
      description: 'Serviced Apartments',
      color: Color(0xFFFFC371),
      isPopular: true,
      isAvailable: false, // Not available yet
    ),
    PropertyType(
      icon: '🌴',
      title: 'Resort',
      description: 'Beach & Hill Resorts',
      color: Color(0xFFFFC371),
      isPopular: false,
      isAvailable: false, // Not available yet
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section (same as before)
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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Indicator (same as before)
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

                      // Title Section (same as before)
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

                      // Property Grid
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
                                // Only Hotel is available
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelCategoryScreen(),
                                  ),
                                );
                              } else {
                                // Show coming soon message for other property types
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

  // Method to show coming soon dialog
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
  final bool isAvailable; // Add this field

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
                    // Popular Badge
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

                    // Icon Container
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

                    // Title
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

                    // Description
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

                    // Arrow Indicator or Coming Soon
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

        // Selection Checkmark
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
            // Header
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
                      // Progress
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

                      // Title
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

                      // Hotel Categories
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
        'color': Color(0xFFFF6347),
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
            }
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
            // Large Hotel Image Container
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
                    // Hotel Image
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

                    // Gradient Overlay
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

                    // Star Rating Badge on Image
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

            // Content Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price
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

                    // Subtitle
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Arrow Button
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





