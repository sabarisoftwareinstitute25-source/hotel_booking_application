import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_booking_mobile_application/onboarding_screen/find_stays_screen.dart';
import '../home_screen/hotel_registration_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import '../home_screen/normal_hotel_dashboard_screen.dart';
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
                              builder: (context) =>
                                  PropertyAuthScreen(selectedPropertyType: ''),
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
        decoration: const BoxDecoration(),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                _navigateToRegistration(
                                  context,
                                  property.title,
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
          MaterialPageRoute(
            builder: (context) => VillaRegistrationVendorForm(),
          ),
        );
        break;
      case 'Apartment':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApartmentRegistrationVendorForm(),
          ),
        );
        break;
      case 'Resort':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResortRegistrationVendorForm(),
          ),
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
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regBusinessController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _regConfirmPasswordController =
      TextEditingController();

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
    //
    // Store property type directly from widget - SIMPLE AND RELIABLE
    _propertyType = widget.selectedPropertyType.toLowerCase().trim();

    print('=== PropertyAuthScreen INIT ===');
    print('Property Type from widget: "$_propertyType"');
    print('Registration data exists: ${widget.registrationData != null}');

    _prefillRegistrationData();
  }

  void _prefillRegistrationData() {
    if (widget.registrationData != null &&
        widget.registrationData!.isNotEmpty) {
      final data = widget.registrationData!;

      // Handle different property types
      if (_propertyType == 'villa') {
        if (data['basicInfo'] != null) {
          final basicInfo = data['basicInfo'] as Map;
          _regNameController.text = basicInfo['ownerName']?.toString() ?? '';
          _regBusinessController.text =
              basicInfo['villaName']?.toString() ?? '';
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
        _regBusinessController.text =
            data['businessName']?.toString() ??
            data['propertyName']?.toString() ??
            '';
        _regEmailController.text = data['email']?.toString() ?? '';
        _regPhoneController.text =
            data['phone']?.toString() ?? data['mobileNumber']?.toString() ?? '';
      }
    }
  }

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
        print(
          '- selectedRoomTypes exists: ${userData.containsKey('selectedRoomTypes')}',
        );
        print('- roomDetails exists: ${userData.containsKey('roomDetails')}');
        print(
          '- basicAmenities exists: ${userData.containsKey('basicAmenities')}',
        );
      }

      bool userExists = false;
      for (int i = 0; i < users.length; i++) {
        final existingEmail =
            users[i]['email']?.toString().toLowerCase().trim() ?? '';
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
        final storedEmail =
            user['email']?.toString().toLowerCase().trim() ?? '';
        if (storedEmail == normalizedEmail) {
          print('=== FOUND USER ===');
          print('User propertyType: "${user['propertyType']}"');
          print('User keys: ${user.keys.toList()}');

          // CRITICAL: Check if hotel data exists
          if (user['propertyType'] == 'hotel') {
            print('Hotel data in user:');
            print(
              '- selectedRoomTypes exists: ${user.containsKey('selectedRoomTypes')}',
            );
            print('- roomDetails exists: ${user.containsKey('roomDetails')}');
            print(
              '- basicAmenities exists: ${user.containsKey('basicAmenities')}',
            );
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
  //     final Map<String, dynamic> userData = {};
  //
  //     // CRITICAL: Set property type using the stored _propertyType
  //     userData['propertyType'] = _propertyType;
  //
  //     print('=== REGISTRATION ===');
  //     print('Setting propertyType to: "${userData['propertyType']}"');
  //
  //     // Add registration data if available
  //     if (widget.registrationData != null && widget.registrationData!.isNotEmpty) {
  //       userData.addAll(widget.registrationData!);
  //       print('Added registration data with keys: ${widget.registrationData!.keys.toList()}');
  //     }
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
  //     // Navigate directly to OwnerDashboardScreen (not to login tab)
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OwnerDashboardScreen(
  //           userData: userData,
  //           userEmail: email.toLowerCase().trim(),
  //         ),
  //       ),
  //     );
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

      // CRITICAL FIX: Only set propertyType if there's ACTUAL registration data
      // For first-time account creation with NO hotel data, propertyType should NOT be set
      if (widget.registrationData != null &&
          widget.registrationData!.isNotEmpty &&
          widget.registrationData!.containsKey('hotelName')) {
        userData['propertyType'] = 'hotel';
        print(
          'Setting propertyType to hotel because hotel registration data exists',
        );
        userData.addAll(widget.registrationData!);
      } else {
        // This is just account creation, no property registered yet
        print('Creating account only - no property registered yet');
        // DO NOT set propertyType here
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
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate directly to OwnerDashboardScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OwnerDashboardScreen(
            userData: userData,
            userEmail: email.toLowerCase().trim(),
          ),
        ),
      );
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

      if (userData.containsKey('propertyType') &&
          userData['propertyType'] != null) {
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

  void _navigateToDashboard(
    Map<String, dynamic> userData,
    String propertyType,
  ) {
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
            propertyType: _getNestedValue(userData, [
              'propertyDetails',
              'propertyType',
            ], 'Villa'),
            bedrooms: _getNestedInt(userData, [
              'propertyDetails',
              'bedrooms',
            ], 0),
            bathrooms: _getNestedInt(userData, [
              'propertyDetails',
              'bathrooms',
            ], 0),
            guestCapacity: _getNestedInt(userData, [
              'propertyDetails',
              'guestCapacity',
            ], 0),
            propertySize: _getNestedValue(userData, [
              'propertyDetails',
              'propertySize',
            ], ''),
            yearConstruction: _getNestedValue(userData, [
              'propertyDetails',
              'yearConstruction',
            ], ''),
            description: _getNestedValue(userData, [
              'propertyDetails',
              'description',
            ], ''),
            villaAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weekendPrice: _getNestedValue(userData, [
              'pricing',
              'weekendPrice',
            ], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            securityDeposit: _getNestedValue(userData, [
              'pricing',
              'securityDeposit',
            ], ''),
            minimumStay: _getNestedValue(userData, [
              'pricing',
              'minimumStay',
            ], ''),
            checkInTime: _getNestedValue(userData, [
              'pricing',
              'checkInTime',
            ], ''),
            checkOutTime: _getNestedValue(userData, [
              'pricing',
              'checkOutTime',
            ], ''),
            cancellationPolicy: _getMapValue(userData, [
              'pricing',
              'cancellationPolicy',
            ]),
            availabilityCalendar: _getMapValue(userData, [
              'pricing',
              'availabilityCalendar',
            ]),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            gstNumber: _getNestedValue(userData, ['legal', 'gstNumber'], ''),
            tradeLicense: _getNestedValue(userData, [
              'legal',
              'tradeLicense',
            ], ''),
            accountHolderName: _getNestedValue(userData, [
              'bank',
              'accountHolder',
            ], ''),
            bankName: _getNestedValue(userData, ['bank', 'bankName'], ''),
            accountNumber: _getNestedValue(userData, [
              'bank',
              'accountNumber',
            ], ''),
            ifscCode: _getNestedValue(userData, ['bank', 'ifscCode'], ''),
            upiId: _getNestedValue(userData, ['bank', 'upiId'], ''),
            cancelledCheque: _getMapValue(userData, [
              'bank',
              'cancelledCheque',
            ]),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            hasDigitalSignature: _getNestedBool(userData, [
              'signature',
              'hasDigital',
            ], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, [
              'signature',
              'declarationAccepted',
            ], false),
            altMobile: _getNestedValue(userData, [
              'basicInfo',
              'altMobile',
            ], ''),
            website: _getNestedValue(userData, ['basicInfo', 'website'], ''),
            googleMapLink: _getNestedValue(userData, [
              'location',
              'googleMapLink',
            ], ''),
          ),
        ),
      );
    } else if (propertyType == 'hotel') {
      print('=== Creating Normal Hotel Dashboard ===');

      // Get registration data
      Map<String, dynamic> regData = {};
      if (userData.containsKey('registrationData') &&
          userData['registrationData'] != null) {
        regData = Map<String, dynamic>.from(userData['registrationData']);
        print('Found registration data with keys: ${regData.keys.toList()}');
      } else {
        print('No registration data found, using userData directly');
        regData = Map<String, dynamic>.from(userData);
      }

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => VillaOwnerDashboard(
      //       registrationData: regData,
      //       hotelName:
      //           regData['hotelName']?.toString() ??
      //           userData['businessName']?.toString() ??
      //           '',
      //       ownerName:
      //           regData['ownerName']?.toString() ??
      //           userData['fullName']?.toString() ??
      //           '',
      //       mobileNumber:
      //           regData['mobileNumber']?.toString() ??
      //           userData['phone']?.toString() ??
      //           '',
      //       email:
      //           regData['email']?.toString() ??
      //           userData['email']?.toString() ??
      //           '',
      //       addressLine1: regData['addressLine1']?.toString() ?? '',
      //       city: regData['city']?.toString() ?? '',
      //       state: regData['state']?.toString() ?? '',
      //       pinCode: regData['pinCode']?.toString() ?? '',
      //       totalRooms: regData['totalRooms'] ?? 0,
      //       hotelType: regData['hotelType']?.toString() ?? 'Normal',
      //       selectedRoomTypes: Map<String, bool>.from(
      //         regData['selectedRoomTypes'] ?? {},
      //       ),
      //       roomDetails: Map<String, Map<String, dynamic>>.from(
      //         regData['roomDetails'] ?? {},
      //       ),
      //       basicAmenities: Map<String, bool>.from(
      //         regData['basicAmenities'] ?? {},
      //       ),
      //       hotelFacilities: Map<String, bool>.from(
      //         regData['hotelFacilities'] ?? {},
      //       ),
      //       foodServices: Map<String, bool>.from(regData['foodServices'] ?? {}),
      //       additionalAmenities: Map<String, bool>.from(
      //         regData['additionalAmenities'] ?? {},
      //       ),
      //       customAmenities: List<String>.from(
      //         regData['customAmenities'] ?? [],
      //       ),
      //       uploadedFiles: Map<String, Map<String, dynamic>>.from(
      //         regData['uploadedFiles'] ?? {},
      //       ),
      //       personPhotoInfo: Map<String, dynamic>.from(
      //         regData['personPhotoInfo'] ?? {},
      //       ),
      //       digitalSignatureImage:
      //           regData['digitalSignatureImage'] as Uint8List?,
      //     ),
      //   ),
      // );
    }

    else if (propertyType == 'apartment') {
      print('=== Creating Apartment Dashboard ===');
      print('Full userData keys: ${userData.keys.toList()}');

      if (userData.containsKey('basicInfo')) {
        print(
          'basicInfo exists with keys: ${(userData['basicInfo'] as Map).keys.toList()}',
        );
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
            googleMapLink: _getNestedValue(userData, [
              'location',
              'googleMapLink',
            ], ''),
            propertyType: _getNestedValue(userData, [
              'propertyDetails',
              'propertyType',
            ], 'Apartment'),
            totalUnits: _getNestedValue(userData, [
              'propertyDetails',
              'totalUnits',
            ], '0'),
            totalBedrooms: _getNestedValue(userData, [
              'propertyDetails',
              'totalBedrooms',
            ], '0'),
            totalBathrooms: _getNestedValue(userData, [
              'propertyDetails',
              'totalBathrooms',
            ], '0'),
            guestCapacity: _getNestedValue(userData, [
              'propertyDetails',
              'guestCapacity',
            ], '0'),
            floorNumber: _getNestedValue(userData, [
              'propertyDetails',
              'floorNumber',
            ], ''),
            totalFloors: _getNestedValue(userData, [
              'propertyDetails',
              'totalFloors',
            ], ''),
            elevatorAvailable: _getNestedValue(userData, [
              'propertyDetails',
              'elevatorAvailable',
            ], ''),
            propertySize: _getNestedValue(userData, [
              'propertyDetails',
              'propertySize',
            ], ''),
            yearConstruction: _getNestedValue(userData, [
              'propertyDetails',
              'yearConstruction',
            ], ''),
            description: _getNestedValue(userData, [
              'propertyDetails',
              'description',
            ], ''),
            apartmentAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weeklyPrice: _getNestedValue(userData, [
              'pricing',
              'weeklyPrice',
            ], ''),
            monthlyPrice: _getNestedValue(userData, [
              'pricing',
              'monthlyPrice',
            ], ''),
            weekendPrice: _getNestedValue(userData, [
              'pricing',
              'weekendPrice',
            ], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            securityDeposit: _getNestedValue(userData, [
              'pricing',
              'securityDeposit',
            ], ''),
            minimumStay: _getNestedValue(userData, [
              'pricing',
              'minimumStay',
            ], ''),
            advancePayment: _getNestedValue(userData, [
              'pricing',
              'advancePayment',
            ], ''),
            checkInTime: _getNestedValue(userData, [
              'pricing',
              'checkInTime',
            ], ''),
            checkOutTime: _getNestedValue(userData, [
              'pricing',
              'checkOutTime',
            ], ''),
            cancellationPolicy: _getMapValue(userData, [
              'pricing',
              'cancellationPolicy',
            ]),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            cancelledCheque: _getMapValue(userData, [
              'bank',
              'cancelledCheque',
            ]),
            calendarSync: _getMapValue(userData, [
              'availability',
              'calendarSync',
            ]),
            availableFromDate: _getDateTimeValue(userData, [
              'availability',
              'availableFromDate',
            ]),
            blackoutDates: _getNestedValue(userData, [
              'availability',
              'blackoutDates',
            ], ''),
            instantBooking: _getNestedValue(userData, [
              'availability',
              'instantBooking',
            ], ''),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            smokingPolicy: _getNestedValue(userData, [
              'houseRules',
              'smokingPolicy',
            ], ''),
            petPolicy: _getNestedValue(userData, [
              'houseRules',
              'petPolicy',
            ], ''),
            eventPolicy: _getNestedValue(userData, [
              'houseRules',
              'eventPolicy',
            ], ''),
            visitorPolicy: _getNestedValue(userData, [
              'houseRules',
              'visitorPolicy',
            ], ''),
            quietHours: _getNestedValue(userData, [
              'houseRules',
              'quietHours',
            ], ''),
            additionalRules: _getNestedValue(userData, [
              'houseRules',
              'additionalRules',
            ], ''),
            hasDigitalSignature: _getNestedBool(userData, [
              'signature',
              'hasDigital',
            ], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, [
              'declarationAccepted',
            ], false),
            vendorStatus: _getNestedValue(userData, [
              'adminFields',
              'vendorStatus',
            ], 'Pending'),
            featuredListing: _getNestedBool(userData, [
              'adminFields',
              'featuredListing',
            ], false),
            verifiedBadge: _getNestedBool(userData, [
              'adminFields',
              'verifiedBadge',
            ], false),
            ratingScore: _getNestedDouble(userData, [
              'adminFields',
              'ratingScore',
            ], 0.0),
            remarks: _getNestedValue(userData, ['adminFields', 'remarks'], ''),
          ),
        ),
      );
    } else if (propertyType == 'resort') {
      print('=== Creating Resort Dashboard ===');
      print('Full userData keys: ${userData.keys.toList()}');

      if (userData.containsKey('basicInfo')) {
        print(
          'basicInfo exists with keys: ${(userData['basicInfo'] as Map).keys.toList()}',
        );
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
            googleMapLink: _getNestedValue(userData, [
              'location',
              'googleMapLink',
            ], ''),
            nearestAirport: _getNestedValue(userData, [
              'location',
              'nearestAirport',
            ], ''),
            nearestRailway: _getNestedValue(userData, [
              'location',
              'nearestRailway',
            ], ''),
            resortCategory: _getNestedValue(userData, [
              'propertyDetails',
              'resortCategory',
            ], ''),
            totalRooms: _getNestedValue(userData, [
              'propertyDetails',
              'totalRooms',
            ], '0'),
            totalCapacity: _getNestedValue(userData, [
              'propertyDetails',
              'totalCapacity',
            ], '0'),
            roomTypes: _getRoomTypes(userData),
            propertyArea: _getNestedValue(userData, [
              'propertyDetails',
              'propertyArea',
            ], ''),
            yearEstablished: _getNestedValue(userData, [
              'propertyDetails',
              'yearEstablished',
            ], ''),
            description: _getNestedValue(userData, [
              'propertyDetails',
              'description',
            ], ''),
            resortAmenities: _getAmenities(userData),
            customAmenities: _getCustomAmenities(userData),
            basePrice: _getNestedValue(userData, ['pricing', 'basePrice'], ''),
            weekendPrice: _getNestedValue(userData, [
              'pricing',
              'weekendPrice',
            ], ''),
            peakPrice: _getNestedValue(userData, ['pricing', 'peakPrice'], ''),
            extraBedCharges: _getNestedValue(userData, [
              'pricing',
              'extraBedCharges',
            ], ''),
            childPolicy: _getNestedValue(userData, [
              'pricing',
              'childPolicy',
            ], ''),
            minimumStay: _getNestedValue(userData, [
              'pricing',
              'minimumStay',
            ], ''),
            advancePayment: _getNestedValue(userData, [
              'pricing',
              'advancePayment',
            ], ''),
            checkInTime: _getNestedValue(userData, [
              'pricing',
              'checkInTime',
            ], ''),
            checkOutTime: _getNestedValue(userData, [
              'pricing',
              'checkOutTime',
            ], ''),
            instantBooking: _getNestedValue(userData, [
              'availability',
              'instantBooking',
            ], ''),
            manualApproval: _getNestedValue(userData, [
              'availability',
              'manualApproval',
            ], ''),
            availableFromDate: _getDateTimeValue(userData, [
              'availability',
              'availableFromDate',
            ]),
            blackoutDates: _getNestedValue(userData, [
              'availability',
              'blackoutDates',
            ], ''),
            seasonalPricing: _getNestedValue(userData, [
              'availability',
              'seasonalPricing',
            ], ''),
            cancellationPolicy: _getMapValue(userData, [
              'pricing',
              'cancellationPolicy',
            ]),
            businessReg: _getMapValue(userData, ['legal', 'businessReg']),
            ownershipProof: _getMapValue(userData, ['legal', 'ownershipProof']),
            idProof: _getMapValue(userData, ['legal', 'idProof']),
            fireSafety: _getMapValue(userData, ['legal', 'fireSafety']),
            cancelledCheque: _getMapValue(userData, [
              'bank',
              'cancelledCheque',
            ]),
            mediaFiles: _getMediaFiles(userData),
            ownerPhoto: _getMapValue(userData, ['basicInfo', 'ownerPhoto']),
            checkInRequirements: _getNestedValue(userData, [
              'houseRules',
              'checkInRequirements',
            ], ''),
            idProofRequired: _getNestedValue(userData, [
              'houseRules',
              'idProofRequired',
            ], ''),
            petPolicy: _getNestedValue(userData, [
              'houseRules',
              'petPolicy',
            ], ''),
            smokingPolicy: _getNestedValue(userData, [
              'houseRules',
              'smokingPolicy',
            ], ''),
            eventPolicy: _getNestedValue(userData, [
              'houseRules',
              'eventPolicy',
            ], ''),
            damagePolicy: _getNestedValue(userData, [
              'houseRules',
              'damagePolicy',
            ], ''),
            refundPolicy: _getNestedValue(userData, [
              'houseRules',
              'refundPolicy',
            ], ''),
            gstNumber: _getNestedValue(userData, ['legal', 'gstNumber'], ''),
            tradeLicense: _getNestedValue(userData, [
              'legal',
              'tradeLicense',
            ], ''),
            fssaiLicense: _getNestedValue(userData, [
              'legal',
              'fssaiLicense',
            ], ''),
            tourismApproval: _getNestedValue(userData, [
              'legal',
              'tourismApproval',
            ], ''),
            accountHolderName: _getNestedValue(userData, [
              'bank',
              'accountHolder',
            ], ''),
            bankName: _getNestedValue(userData, ['bank', 'bankName'], ''),
            accountNumber: _getNestedValue(userData, [
              'bank',
              'accountNumber',
            ], ''),
            ifscCode: _getNestedValue(userData, ['bank', 'ifscCode'], ''),
            upiId: _getNestedValue(userData, ['bank', 'upiId'], ''),
            gstBilling: _getNestedValue(userData, ['bank', 'gstBilling'], ''),
            hasDigitalSignature: _getNestedBool(userData, [
              'signature',
              'hasDigital',
            ], false),
            digitalSignatureImage: _getSignatureImage(userData),
            declarationDate: _getDeclarationDate(userData),
            declarationAccepted: _getNestedBool(userData, [
              'declarationAccepted',
            ], false),
            vendorStatus: _getNestedValue(userData, [
              'adminFields',
              'vendorStatus',
            ], 'Pending'),
            featuredResort: _getNestedBool(userData, [
              'adminFields',
              'featuredResort',
            ], false),
            verifiedBadge: _getNestedBool(userData, [
              'adminFields',
              'verifiedBadge',
            ], false),
            ratingScore: _getNestedDouble(userData, [
              'adminFields',
              'ratingScore',
            ], 0.0),
            priorityListingLevel: _getNestedValue(userData, [
              'adminFields',
              'priorityListingLevel',
            ], 'Standard'),
            remarks: _getNestedValue(userData, ['adminFields', 'remarks'], ''),
          ),
        ),
      );
    } else {
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
          value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
        );
      }
    }
    return {};
  }

  // Helper method to safely get Map<String, Map<String, dynamic>>
  Map<String, Map<String, dynamic>> _getRoomDetailsMap(
    Map<String, dynamic> data,
    String key,
  ) {
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
  Map<String, Map<String, dynamic>> _getUploadedFilesMap(
    Map<String, dynamic> data,
    String key,
  ) {
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
  Map<String, Map<String, dynamic>>? _getIdProofFilesMap(
    Map<String, dynamic> data,
    String key,
  ) {
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
    if (data.containsKey('propertyDetails') &&
        data['propertyDetails'] != null) {
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
    if (data.containsKey('propertyDetails') &&
        data['propertyDetails'] != null) {
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

  double _getNestedDouble(
    Map<String, dynamic> data,
    List<String> keys,
    double defaultValue,
  ) {
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

  String _getNestedValue(
    Map<String, dynamic> map,
    List<String> keys,
    String defaultValue,
  ) {
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

  int _getNestedInt(
    Map<String, dynamic> map,
    List<String> keys,
    int defaultValue,
  ) {
    final value = _getNestedValue(map, keys, '');
    return int.tryParse(value) ?? defaultValue;
  }

  bool _getNestedBool(
    Map<String, dynamic> map,
    List<String> keys,
    bool defaultValue,
  ) {
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

  Map<String, dynamic> _getMapValue(
    Map<String, dynamic> map,
    List<String> keys,
  ) {
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
    return amenities.map(
      (key, value) => MapEntry(key.toString(), value is bool ? value : false),
    );
  }

  List<String> _getCustomAmenities(Map<String, dynamic> userData) {
    final custom = _getMapValue(userData, ['amenities', 'custom']);
    return custom.values.map((e) => e.toString()).toList();
  }

  Map<String, List<Map<String, dynamic>>> _getMediaFiles(
    Map<String, dynamic> userData,
  ) {
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
    if (signature.containsKey('digitalSignature') &&
        signature['digitalSignature'] is Uint8List) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF6B7280),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
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

class OwnerDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userEmail;

  const OwnerDashboardScreen({
    Key? key,
    required this.userData,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  Map<String, dynamic> _userData = {};
  bool _isLoading = true;
  // Map<String, bool> _registeredProperties = {};
  Map<String, bool> _registeredProperties = {};
  // bool _showProperties = false;
  @override
  void initState() {
    super.initState();
    _userData = widget.userData;
    _checkRegisteredProperties();
    _loadUserData();
  }

  // Future<void> _loadUserData() async {
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String usersJson = prefs.getString('registered_users') ?? '[]';
  //     final List<dynamic> usersList = jsonDecode(usersJson);
  //
  //     final normalizedEmail = widget.userEmail.toLowerCase().trim();
  //
  //     for (var user in usersList) {
  //       if (user is Map) {
  //         final storedEmail = user['email']?.toString().toLowerCase().trim() ?? '';
  //         if (storedEmail == normalizedEmail) {
  //           // Convert safely without casting
  //           Map<String, dynamic> safeUserData = {};
  //           user.forEach((key, value) {
  //             safeUserData[key.toString()] = value;
  //           });
  //
  //           setState(() {
  //             _userData = safeUserData;
  //             _checkRegisteredProperties();
  //           });
  //           break;
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Error loading user data: $e');
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

  // void _checkRegisteredProperties() {
  //   // Check which properties this user has already registered
  //   bool isHotelRegistered = false;
  //   bool isVillaRegistered = false;
  //   bool isApartmentRegistered = false;
  //   bool isResortRegistered = false;
  //
  //   // Check for HOTEL registration
  //   if (_userData.containsKey('propertyType') &&
  //       _userData['propertyType'] != null &&
  //       _userData['propertyType'].toString().toLowerCase() == 'hotel') {
  //     isHotelRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('hotelName') &&
  //       _userData['hotelName'] != null &&
  //       _userData['hotelName'].toString().isNotEmpty) {
  //     isHotelRegistered = true;
  //   }
  //
  //   // Check for hotels list
  //   if (_userData.containsKey('hotels') &&
  //       _userData['hotels'] is List &&
  //       (_userData['hotels'] as List).isNotEmpty) {
  //     isHotelRegistered = true;
  //   }
  //
  //   // Check for hotel-specific fields
  //   if (_userData.containsKey('totalRooms') ||
  //       _userData.containsKey('roomDetails') ||
  //       _userData.containsKey('selectedRoomTypes')) {
  //     isHotelRegistered = true;
  //   }
  //
  //   // Check for VILLA registration
  //   if (_userData.containsKey('propertyType') &&
  //       _userData['propertyType'] != null &&
  //       _userData['propertyType'].toString().toLowerCase() == 'villa') {
  //     isVillaRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('villaName') &&
  //       _userData['villaName'] != null &&
  //       _userData['villaName'].toString().isNotEmpty) {
  //     isVillaRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
  //     final basicInfo = _userData['basicInfo'] as Map;
  //     if (basicInfo.containsKey('villaName') &&
  //         basicInfo['villaName'].toString().isNotEmpty) {
  //       isVillaRegistered = true;
  //     }
  //   }
  //
  //   // Check for APARTMENT registration
  //   if (_userData.containsKey('propertyType') &&
  //       _userData['propertyType'] != null &&
  //       _userData['propertyType'].toString().toLowerCase() == 'apartment') {
  //     isApartmentRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('apartmentName') &&
  //       _userData['apartmentName'] != null &&
  //       _userData['apartmentName'].toString().isNotEmpty) {
  //     isApartmentRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
  //     final basicInfo = _userData['basicInfo'] as Map;
  //     if (basicInfo.containsKey('apartmentName') &&
  //         basicInfo['apartmentName'].toString().isNotEmpty) {
  //       isApartmentRegistered = true;
  //     }
  //   }
  //
  //   // Check for RESORT registration
  //   if (_userData.containsKey('propertyType') &&
  //       _userData['propertyType'] != null &&
  //       _userData['propertyType'].toString().toLowerCase() == 'resort') {
  //     isResortRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('resortName') &&
  //       _userData['resortName'] != null &&
  //       _userData['resortName'].toString().isNotEmpty) {
  //     isResortRegistered = true;
  //   }
  //
  //   if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
  //     final basicInfo = _userData['basicInfo'] as Map;
  //     if (basicInfo.containsKey('resortName') &&
  //         basicInfo['resortName'].toString().isNotEmpty) {
  //       isResortRegistered = true;
  //     }
  //   }
  //
  //   setState(() {
  //     _registeredProperties = {
  //       'hotel': isHotelRegistered,
  //       'villa': isVillaRegistered,
  //       'apartment': isApartmentRegistered,
  //       'resort': isResortRegistered,
  //     };
  //   });
  //
  //   print('Registered properties: $_registeredProperties');
  // }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      final List<dynamic> usersList = jsonDecode(usersJson);

      final normalizedEmail = widget.userEmail.toLowerCase().trim();

      for (var user in usersList) {
        if (user is Map) {
          final storedEmail =
              user['email']?.toString().toLowerCase().trim() ?? '';
          if (storedEmail == normalizedEmail) {
            // Convert safely without casting
            Map<String, dynamic> safeUserData = {};
            user.forEach((key, value) {
              safeUserData[key.toString()] = value;
            });

            // CRITICAL: Ensure propertyType is preserved
            if (!safeUserData.containsKey('propertyType') ||
                safeUserData['propertyType'] == null) {
              // If propertyType is missing, try to determine it
              if (safeUserData.containsKey('hotelName') ||
                  safeUserData.containsKey('hotels') ||
                  safeUserData.containsKey('roomDetails')) {
                safeUserData['propertyType'] = 'hotel';
                print('Added missing propertyType: hotel');
              }
            }

            setState(() {
              _userData = safeUserData;
              _checkRegisteredProperties();
            });
            break;
          }
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }
  // void _checkRegisteredProperties() {
  //   print('=== CHECKING REGISTERED PROPERTIES ===');
  //   print('User data keys: ${_userData.keys.toList()}');
  //
  //   // Initialize all as false
  //   bool isHotelRegistered = false;
  //   bool isVillaRegistered = false;
  //   bool isApartmentRegistered = false;
  //   bool isResortRegistered = false;
  //
  //   // CRITICAL: First check propertyType - this should be the PRIMARY indicator
  //   if (_userData.containsKey('propertyType') && _userData['propertyType'] != null) {
  //     String propertyType = _userData['propertyType'].toString().toLowerCase();
  //     print('Found propertyType: "$propertyType"');
  //
  //     if (propertyType == 'hotel') {
  //       isHotelRegistered = true;
  //       print('Setting isHotelRegistered = true based on propertyType');
  //     } else if (propertyType == 'villa') {
  //       isVillaRegistered = true;
  //     } else if (propertyType == 'apartment') {
  //       isApartmentRegistered = true;
  //     } else if (propertyType == 'resort') {
  //       isResortRegistered = true;
  //     }
  //   }
  //
  //   // Check for hotel-specific fields - only set hotel to true, don't affect others
  //   if (_userData.containsKey('hotelName') &&
  //       _userData['hotelName'] != null &&
  //       _userData['hotelName'].toString().isNotEmpty) {
  //     isHotelRegistered = true;
  //     print('Setting isHotelRegistered = true based on hotelName');
  //   }
  //
  //   // Check for hotels list
  //   if (_userData.containsKey('hotels') &&
  //       _userData['hotels'] is List &&
  //       (_userData['hotels'] as List).isNotEmpty) {
  //     isHotelRegistered = true;
  //     print('Setting isHotelRegistered = true based on hotels list');
  //   }
  //
  //   // Check for hotel-specific fields
  //   if (_userData.containsKey('totalRooms') ||
  //       _userData.containsKey('roomDetails') ||
  //       _userData.containsKey('selectedRoomTypes')) {
  //     isHotelRegistered = true;
  //     print('Setting isHotelRegistered = true based on hotel-specific fields');
  //   }
  //
  //   // IMPORTANT: Do NOT check for other property types if this is a hotel registration
  //   // Only check for other properties if propertyType indicates they might exist
  //
  //   setState(() {
  //     _registeredProperties = {
  //       'hotel': isHotelRegistered,
  //       'villa': isVillaRegistered,
  //       'apartment': isApartmentRegistered,
  //       'resort': isResortRegistered,
  //     };
  //   });
  //
  //   print('Final registered properties: $_registeredProperties');
  // }

  void _checkRegisteredProperties() {
    print('=== CHECKING REGISTERED PROPERTIES ===');
    print('User data keys: ${_userData.keys.toList()}');

    // Initialize all as false
    bool isHotelRegistered = false;
    bool isVillaRegistered = false;
    bool isApartmentRegistered = false;
    bool isResortRegistered = false;

    // CRITICAL FIX: Only check for ACTUAL data, not just propertyType

    // Check for hotel-specific fields - these indicate an ACTUAL hotel registration
    if (_userData.containsKey('hotelName') &&
        _userData['hotelName'] != null &&
        _userData['hotelName'].toString().isNotEmpty) {
      isHotelRegistered = true;
      print('Setting isHotelRegistered = true based on hotelName');
    }

    // Check for hotels list
    if (_userData.containsKey('hotels') &&
        _userData['hotels'] is List &&
        (_userData['hotels'] as List).isNotEmpty) {
      isHotelRegistered = true;
      print('Setting isHotelRegistered = true based on hotels list');
    }

    // Check for hotel-specific fields
    if (_userData.containsKey('totalRooms') ||
        _userData.containsKey('roomDetails') ||
        _userData.containsKey('selectedRoomTypes') ||
        _userData.containsKey('basicAmenities')) {
      isHotelRegistered = true;
      print('Setting isHotelRegistered = true based on hotel-specific fields');
    }

    // Check registrationData if it exists
    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      final regData = _userData['registrationData'] as Map;
      if (regData.containsKey('hotelName') &&
          regData['hotelName']?.toString().isNotEmpty == true) {
        isHotelRegistered = true;
        print('Found hotel in registrationData');
      }
    }

    // DO NOT use propertyType alone to determine registration
    // Only use propertyType if we're confident it's correct
    if (_userData.containsKey('propertyType') &&
        _userData['propertyType'] != null) {
      String propertyType = _userData['propertyType'].toString().toLowerCase();
      print(
        'Found propertyType: "$propertyType" - but not using it alone for registration status',
      );
    }

    setState(() {
      _registeredProperties = {
        'hotel': isHotelRegistered,
        'villa': isVillaRegistered,
        'apartment': isApartmentRegistered,
        'resort': isResortRegistered,
      };
    });

    print('Final registered properties: $_registeredProperties');
  }

  void _navigateToWelcomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  void _navigateToPropertyDetails(String propertyType) {
    if (!_registeredProperties[propertyType]!) {
      // If not registered, show message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have not registered for $propertyType yet'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Navigate to the appropriate property details screen
    switch (propertyType) {
      case 'hotel':
        _navigateToHotelDetails();
        break;
      case 'villa':
        _navigateToVillaDetails();
        break;
      case 'apartment':
        _navigateToApartmentDetails();
        break;
      case 'resort':
        _navigateToResortDetails();
        break;
    }
  }

  void _navigateToHotelDetails() {
    print('=== Navigating to Hotel Details ===');

    // Extract all hotel registration data
    Map<String, dynamic> hotelData = {};

    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      hotelData = Map<String, dynamic>.from(_userData['registrationData']);
    } else {
      hotelData = Map<String, dynamic>.from(_userData);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HotelRegistrationDetailsScreen(registrationData: hotelData),
      ),
    );
  }

  void _navigateToVillaDetails() {
    print('=== Navigating to Villa Details ===');

    Map<String, dynamic> villaData = {};

    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      villaData = Map<String, dynamic>.from(_userData['registrationData']);
    } else {
      villaData = Map<String, dynamic>.from(_userData);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VillaRegistrationDetailsScreen(registrationData: villaData),
      ),
    );
  }

  void _navigateToApartmentDetails() {
    print('=== Navigating to Apartment Details ===');

    Map<String, dynamic> apartmentData = {};

    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      apartmentData = Map<String, dynamic>.from(_userData['registrationData']);
    } else {
      apartmentData = Map<String, dynamic>.from(_userData);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ApartmentRegistrationDetailsScreen(registrationData: apartmentData),
      ),
    );
  }

  void _navigateToResortDetails() {
    print('=== Navigating to Resort Details ===');

    Map<String, dynamic> resortData = {};

    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      resortData = Map<String, dynamic>.from(_userData['registrationData']);
    } else {
      resortData = Map<String, dynamic>.from(_userData);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResortRegistrationDetailsScreen(registrationData: resortData),
      ),
    );
  }

  String _getUserFullName() {
    if (_userData.containsKey('fullName')) {
      return _userData['fullName'].toString();
    }
    if (_userData.containsKey('ownerName')) {
      return _userData['ownerName'].toString();
    }
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName')) {
        return basicInfo['ownerName'].toString();
      }
    }
    return 'User';
  }

  String _getUserEmail() {
    return _userData['email']?.toString() ?? widget.userEmail;
  }

  String _getUserPhone() {
    if (_userData.containsKey('phone')) {
      return _userData['phone'].toString();
    }
    if (_userData.containsKey('mobileNumber')) {
      return _userData['mobileNumber'].toString();
    }
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('mobile')) {
        return basicInfo['mobile'].toString();
      }
    }
    return 'Not provided';
  }

  String _getRegisteredPropertyType() {
    if (_userData.containsKey('propertyType')) {
      return _userData['propertyType'].toString();
    }
    if (_userData.containsKey('hotelName')) return 'hotel';
    if (_userData.containsKey('villaName')) return 'villa';
    if (_userData.containsKey('apartmentName')) return 'apartment';
    if (_userData.containsKey('resortName')) return 'resort';
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('hotelName')) return 'hotel';
      if (basicInfo.containsKey('villaName')) return 'villa';
      if (basicInfo.containsKey('apartmentName')) return 'apartment';
      if (basicInfo.containsKey('resortName')) return 'resort';
    }
    return 'none';
  }

  // Widget _buildActionButton({
  //   required VoidCallback onTap,
  //   required IconData icon,
  //   required String title,
  //   required String subtitle,
  //   required List<Color> gradientColors,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         border: Border.all(
  //           color: gradientColors.first.withOpacity(0.2),
  //           width: 1.5,
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: gradientColors.first.withOpacity(0.1),
  //             blurRadius: 15,
  //             offset: const Offset(0, 5),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           // Icon with gradient background
  //           Container(
  //             padding: const EdgeInsets.all(2),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: gradientColors,
  //               ),
  //               borderRadius: BorderRadius.circular(14),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: gradientColors.first.withOpacity(0.3),
  //                   blurRadius: 8,
  //                   offset: const Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Icon(
  //               icon,
  //               color: Colors.white,
  //               size: 22,
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           // Text Column
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                     color: Color(0xFF1F2937),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 2),
  //                 Text(
  //                   subtitle,
  //                   style: TextStyle(
  //                     fontSize: 11,
  //                     color: Colors.grey.shade600,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           // Circular indicator
  //           Container(
  //             padding: const EdgeInsets.all(4),
  //             decoration: BoxDecoration(
  //               color: gradientColors.first.withOpacity(0.1),
  //               shape: BoxShape.circle,
  //             ),
  //             child: Icon(
  //               Icons.arrow_forward_rounded,
  //               color: gradientColors.first,
  //               size: 16,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon with white background
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            // Text Column - Fixed height to ensure consistency
            SizedBox(
              height: 38, // Fixed height for both buttons
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle.isNotEmpty) // Only show if subtitle exists
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1F2937)),
          // onPressed: () => Navigator.pop(context),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyAuthScreen(
                  selectedPropertyType:
                      'hotel', // or whatever property type you want to pass
                  registrationData:
                      null, // or pass any existing registration data if needed
                ),
              ),
            );
          },
        ),
        title: const Text(
          'My Dashboard',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // My Profile Section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile Header with Button
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF5F6D),
                                      Color(0xFFFFC371),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getUserFullName(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getUserEmail(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // My Profile Button
                              // ElevatedButton(
                              //   onPressed: () {
                              //     _showProfileDialog();
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: const Color(0xFFFF5F6D),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: const Text('My Profile'),
                              // ),
                            ],
                          ),
                        ),

                        // Personal Details Summary (First-time registered data)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Personal Details',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDetailItem(
                                        icon: Icons.phone,
                                        label: 'Phone',
                                        value: _getUserPhone(),
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildDetailItem(
                                        icon: Icons.email,
                                        label: 'Email',
                                        value: _getUserEmail(),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_getRegisteredPropertyType() != 'none')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: _buildDetailItem(
                                      icon: Icons.business,
                                      label: 'Registered As',
                                      value: _getRegisteredPropertyType()
                                          .toUpperCase(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // In the build method, update the My Profile button:
                  Row(
                    children: [
                      // New Register Button
                      Expanded(
                        child: _buildActionButton(
                          onTap: _navigateToWelcomeScreen,
                          icon: Icons.app_registration,
                          title: 'New Register',
                          subtitle: 'Add another property',
                          gradientColors: [
                            Colors.blue,
                            Colors.lightBlue.shade300,
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // My Profile Button
                      Expanded(
                        child: _buildActionButton(
                          onTap: () {
                            print(
                              'Navigating to PropertiesScreen with userData: ${_userData.keys}',
                            );
                            print('propertyType: ${_userData['propertyType']}');

                            // Create a fresh copy with explicit propertyType
                            Map<String, dynamic> dataToPass =
                                Map<String, dynamic>.from(_userData);

                            // Ensure propertyType has a value
                            if (dataToPass['propertyType'] == null ||
                                dataToPass['propertyType'].toString().isEmpty) {
                              dataToPass['propertyType'] = 'hotel';
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertiesScreen(
                                  userData: dataToPass,
                                  userEmail: widget.userEmail,
                                ),
                              ),
                            );
                          },
                          icon: Icons.person_rounded,
                          title: 'My Profile',
                          subtitle: 'View properties', // Static subtitle
                          gradientColors: [
                            const Color(0xFFFF5F6D),
                            const Color(0xFFFFC371),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color(0xFFF8FAFF),
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       title: const Text(
  //         'Dashboard',
  //         style: TextStyle(
  //           color: Color(0xFF1F2937),
  //           fontSize: 20,
  //           fontWeight: FontWeight.w700,
  //         ),
  //       ),
  //     ),
  //     body: _isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           // Welcome Message
  //           Container(
  //             padding: const EdgeInsets.all(24),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.05),
  //                   blurRadius: 10,
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 const Icon(
  //                   Icons.dashboard_rounded,
  //                   size: 60,
  //                   color: Color(0xFFFF5F6D),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   'Welcome, ${_getUserFullName()}!',
  //                   style: const TextStyle(
  //                     fontSize: 22,
  //                     fontWeight: FontWeight.w700,
  //                     color: Color(0xFF1F2937),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 const Text(
  //                   'What would you like to do?',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     color: Color(0xFF6B7280),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           const SizedBox(height: 32),
  //
  //           // Action Buttons
  //           Row(
  //             children: [
  //               // New Register Button
  //               Expanded(
  //                 child: _buildActionButton(
  //                   onTap: _navigateToWelcomeScreen,
  //                   icon: Icons.app_registration,
  //                   title: 'New Register',
  //                   subtitle: 'Add another property',
  //                   gradientColors: [Colors.blue, Colors.lightBlue.shade300],
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               // My Profile Button
  //               Expanded(
  //                 child: _buildActionButton(
  //                   onTap: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => PropertiesScreen(
  //                           userData: _userData,
  //                           userEmail: widget.userEmail,
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                   icon: Icons.person_rounded,
  //                   title: 'My Profile',
  //                   subtitle: 'View properties',
  //                   gradientColors: [const Color(0xFFFF5F6D), const Color(0xFFFFC371)],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyBox({
    required String propertyType,
    required IconData icon,
    required Color color,
    required bool isRegistered,
  }) {
    return GestureDetector(
      onTap: isRegistered
          ? () => _navigateToPropertyDetails(propertyType.toLowerCase())
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRegistered ? color : Colors.grey.shade300,
            width: isRegistered ? 2 : 1,
          ),
          boxShadow: isRegistered
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: isRegistered ? color : Colors.grey.shade400,
                ),
                const SizedBox(height: 8),
                Text(
                  propertyType,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isRegistered ? color : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isRegistered
                        ? color.withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isRegistered ? 'Registered' : 'Not Registered',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isRegistered ? color : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            if (!isRegistered)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_outline,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileDetailRow('Full Name', _getUserFullName()),
              const Divider(),
              _buildProfileDetailRow('Email', _getUserEmail()),
              const Divider(),
              _buildProfileDetailRow('Phone', _getUserPhone()),
              const Divider(),
              _buildProfileDetailRow(
                'Registered Property',
                _getRegisteredPropertyType() != 'none'
                    ? _getRegisteredPropertyType().toUpperCase()
                    : 'None',
              ),
              const Divider(),
              _buildProfileDetailRow(
                'Registration Date',
                _userData.containsKey('registeredAt')
                    ? _formatDate(_userData['registeredAt'])
                    : 'Not available',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5F6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Not available';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

class VillaRegistrationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;

  const VillaRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Villa Registration Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: Basic Information
            _buildSection(
              title: 'Step 1: Basic Information',
              icon: Icons.info,
              color: Colors.green,
              children: [
                _buildDetailRow(
                  'Villa Name',
                  _getNestedValue('basicInfo', 'villaName') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Owner Name',
                  _getNestedValue('basicInfo', 'ownerName') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Mobile Number',
                  _getNestedValue('basicInfo', 'mobile') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Alternate Mobile',
                  _getNestedValue('basicInfo', 'altMobile') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Email',
                  _getNestedValue('basicInfo', 'email') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Website',
                  _getNestedValue('basicInfo', 'website') ?? 'N/A',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Step 2: Location Details
            _buildSection(
              title: 'Step 2: Location Details',
              icon: Icons.location_on,
              color: Colors.green.shade700,
              children: [
                _buildDetailRow(
                  'Address',
                  _getNestedValue('location', 'address') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Area',
                  _getNestedValue('location', 'area') ?? 'N/A',
                ),
                _buildDetailRow(
                  'City',
                  _getNestedValue('location', 'city') ?? 'N/A',
                ),
                _buildDetailRow(
                  'State',
                  _getNestedValue('location', 'state') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Pincode',
                  _getNestedValue('location', 'pincode') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Google Map Link',
                  _getNestedValue('location', 'googleMapLink') ?? 'N/A',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Step 3: Property Details
            _buildSection(
              title: 'Step 3: Property Details',
              icon: Icons.home,
              color: Colors.green.shade600,
              children: [
                _buildDetailRow(
                  'Property Type',
                  _getNestedValue('propertyDetails', 'propertyType') ?? 'Villa',
                ),
                _buildDetailRow(
                  'Bedrooms',
                  _getNestedValue('propertyDetails', 'bedrooms') ?? '0',
                ),
                _buildDetailRow(
                  'Bathrooms',
                  _getNestedValue('propertyDetails', 'bathrooms') ?? '0',
                ),
                _buildDetailRow(
                  'Guest Capacity',
                  _getNestedValue('propertyDetails', 'guestCapacity') ?? '0',
                ),
                _buildDetailRow(
                  'Property Size',
                  _getNestedValue('propertyDetails', 'propertySize') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Year Construction',
                  _getNestedValue('propertyDetails', 'yearConstruction') ??
                      'N/A',
                ),
                _buildDetailRow(
                  'Description',
                  _getNestedValue('propertyDetails', 'description') ?? 'N/A',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Step 4: Amenities
            _buildSection(
              title: 'Step 4: Amenities',
              icon: Icons.star,
              color: Colors.green.shade500,
              children: _buildAmenities(),
            ),

            const SizedBox(height: 16),

            // Step 5: Pricing
            _buildSection(
              title: 'Step 5: Pricing',
              icon: Icons.attach_money,
              color: Colors.green.shade400,
              children: [
                _buildDetailRow(
                  'Base Price',
                  _getNestedValue('pricing', 'basePrice') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Weekend Price',
                  _getNestedValue('pricing', 'weekendPrice') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Peak Price',
                  _getNestedValue('pricing', 'peakPrice') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Security Deposit',
                  _getNestedValue('pricing', 'securityDeposit') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Minimum Stay',
                  _getNestedValue('pricing', 'minimumStay') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Check-in Time',
                  _getNestedValue('pricing', 'checkInTime') ?? 'N/A',
                ),
                _buildDetailRow(
                  'Check-out Time',
                  _getNestedValue('pricing', 'checkOutTime') ?? 'N/A',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _getNestedValue(String section, String key) {
    if (registrationData.containsKey(section) &&
        registrationData[section] != null &&
        registrationData[section] is Map) {
      final map = registrationData[section] as Map;
      if (map.containsKey(key)) {
        return map[key]?.toString();
      }
    }
    return null;
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children.isNotEmpty
                  ? children
                  : [
                      const Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAmenities() {
    List<Widget> widgets = [];

    if (registrationData.containsKey('amenities') &&
        registrationData['amenities'] != null) {
      final amenities = registrationData['amenities'] as Map;

      if (amenities.containsKey('selected') && amenities['selected'] != null) {
        final selected = amenities['selected'] as Map;
        List<String> selectedAmenities = [];
        selected.forEach((key, value) {
          if (value == true) {
            selectedAmenities.add(key.toString());
          }
        });

        if (selectedAmenities.isNotEmpty) {
          widgets.add(
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Selected Amenities:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          );
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: selectedAmenities
                    .map(
                      (item) => Chip(
                        label: Text(item),
                        backgroundColor: Colors.green.shade50,
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      }

      if (amenities.containsKey('custom') && amenities['custom'] != null) {
        final custom = amenities['custom'] as Map;
        if (custom.isNotEmpty) {
          widgets.add(
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Custom Amenities:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          );
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: custom.values
                    .map(
                      (item) => Chip(
                        label: Text(item.toString()),
                        backgroundColor: Colors.purple.shade50,
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      }
    }

    return widgets;
  }
}

class ApartmentRegistrationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;

  const ApartmentRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartment Registration Details'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Apartment Details - Implement similar to Villa screen'),
      ),
    );
  }
}

class ResortRegistrationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;

  const ResortRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resort Registration Details'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Resort Details - Implement similar to Villa screen'),
      ),
    );
  }
}

class HotelRegistrationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const HotelRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
  }) : super(key: key);

  @override
  State<HotelRegistrationDetailsScreen> createState() =>
      _HotelRegistrationDetailsScreenState();
}

class _HotelRegistrationDetailsScreenState
    extends State<HotelRegistrationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // Your beautiful color
  final Color primaryColor = const Color(0xFFFF5F6D);
  final Color primaryLight = const Color(0xFFFF5F6D).withOpacity(0.1);
  final Color primarySoft = const Color(0xFFFF5F6D).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFFFF5F6D).withOpacity(0.03);

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '';

    if (value is int) {
      return value.toString();
    }

    if (value is double) {
      return value.toInt().toString();
    }

    if (value is String) {
      // Try to parse as double first, then convert to int
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
      return value;
    }

    return value.toString();
  }

  // Helper method to format price/double values
  String _formatPrice(dynamic value) {
    if (value == null) return '';

    if (value is double) {
      // Show .00 only if it has decimal places
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }

    if (value is int) {
      return value.toString();
    }

    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }

    return value.toString();
  }

  // Helper method to safely get and format any numeric value
  String _getFormattedValue(dynamic value, {bool isPrice = false}) {
    if (value == null) return '';

    if (isPrice) {
      return _formatPrice(value);
    } else {
      return _formatInteger(value);
    }
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '$namePrefix-${timestamp}';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? 'Normal Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // Tab Bar Views
          SliverAppBar(
            expandedHeight: 180, // Increased height significantly
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.85)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,

                  child: Column(
                    children: [
                      const SizedBox(height: 25),

                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          // backdropFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        ),
                        child: Row(
                          children: [
                            // Icon
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.hotel,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getHotelType(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card - Now outside the SliverAppBar and visible
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
        decoration: BoxDecoration(
          color: primarySoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: primaryColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: primaryColor),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: mediumText,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Information',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Type', _data['hotelType']),
              // _buildInfoRow('Year of Establishment', _data['yearOfEstablishment']),
              // _buildInfoRow('Total Rooms', _data['totalRooms']),
              // UPDATED: Year of Establishment as integer
              _buildInfoRow(
                'Year of Establishment',
                _data['yearOfEstablishment'],
              ),
              // UPDATED: Total Rooms as integer
              _buildInfoRow('Total Rooms', _data['totalRooms']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildInfoRow('Owner/Manager', _data['ownerName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              _buildInfoRow('Alternate Contact', _data['alternateContact']),
              _buildInfoRow('Email', _data['email']),
              _buildInfoRow('Website', _data['website']),
              ..._buildLandlineNumbers(_data['landlineNumbers']),
            ],
          ),
          if (_data['personPhotoInfo'] != null &&
              _data['personPhotoInfo']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(_data['personPhotoInfo']),
            ),
        ],
      ),
    );
  }

  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('District', _data['district']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('PIN Code', _data['pinCode']),
              _buildInfoRow('Landmark', _data['landmark']),
            ],
          ),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_data['minTariff'] != null || _data['maxTariff'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Pricing Information',
                icon: Icons.attach_money,
                children: [
                  // _buildPriceRow('Min Tariff', _data['minTariff']),
                  // _buildPriceRow('Max Tariff', _data['maxTariff']),
                  // UPDATED: Min Tariff as price
                  if (_hasValue(_data['minTariff']))
                    _buildPriceRow('Min Tariff', _data['minTariff']),

                  // UPDATED: Max Tariff as price
                  if (_hasValue(_data['maxTariff']))
                    _buildPriceRow('Max Tariff', _data['maxTariff']),
                  if (_data['extraBedAvailable'] != null)
                    _buildStatusRow(
                      'Extra Bed Available',
                      _data['extraBedAvailable'] == true,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // // Step 4: Amenities
  // Widget _buildStep4() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         if (_data['basicAmenities'] != null)
  //           _buildAmenityCard('Basic Amenities', _data['basicAmenities']),
  //         if (_data['hotelFacilities'] != null)
  //           Padding(
  //             padding: const EdgeInsets.only(top: 16),
  //             child: _buildAmenityCard(
  //               'Hotel Facilities',
  //               _data['hotelFacilities'],
  //             ),
  //           ),
  //         if (_data['foodServices'] != null)
  //           Padding(
  //             padding: const EdgeInsets.only(top: 16),
  //             child: _buildAmenityCard('Food Services', _data['foodServices']),
  //           ),
  //         if (_data['additionalAmenities'] != null)
  //           Padding(
  //             padding: const EdgeInsets.only(top: 16),
  //             child: _buildAmenityCard(
  //               'Additional Amenities',
  //               _data['additionalAmenities'],
  //             ),
  //           ),
  //         if (_data['customAmenities'] != null &&
  //             (_data['customAmenities'] as List).isNotEmpty)
  //           Padding(
  //             padding: const EdgeInsets.only(top: 16),
  //             child: _buildCustomAmenitiesCard(_data['customAmenities']),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['basicAmenities'] != null)
            _buildAmenityCard('Basic Amenities', _data['basicAmenities']),
          if (_data['hotelFacilities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Facilities',
                _data['hotelFacilities'],
              ),
            ),
          if (_data['foodServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Food Services', _data['foodServices']),
            ),
          if (_data['additionalAmenities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Additional Amenities',
                _data['additionalAmenities'],
              ),
            ),

          // ADDED: Custom Amenities Section
          if (_data['customAmenities'] != null &&
              (_data['customAmenities'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildCustomAmenitiesCard(_data['customAmenities']),
            ),
        ],
      ),
    );
  }
  Widget _buildCustomAmenitiesCard(dynamic customAmenities) {
    if (customAmenities is! List || customAmenities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primarySoft, primaryMedium],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.stars, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                'Custom Amenities',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: customAmenities
                .map(
                  (item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: primaryColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  item.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
  // Step 5: Legal & Bank Details
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal Details',
            icon: Icons.gavel,
            children: [
              _buildInfoRow('GST Number', _data['gstNumber']),
              _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              _buildInfoRow('Trade License', _data['tradeLicense']),
              _buildInfoRow('Aadhar Number', _data['aadharNumber']),
              _buildInfoRow('PAN Number', _data['panNumber']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              _buildInfoRow('Account Holder', _data['accountHolderName']),
              _buildInfoRow('Bank Name', _data['bankName']),
              _buildInfoRow(
                'Account Number',
                _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
              ),
              _buildInfoRow('IFSC Code', _data['ifscCode']),
              _buildInfoRow('Branch', _data['branch']),
              _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              _buildInfoRow('Name', _data['declarationName']),
              _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          if (_data['hasDigitalSignature'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // // Elegant Info Row
  // Widget _buildInfoRow(String label, dynamic value) {
  //   if (value == null || value.toString().isEmpty) {
  //     return const SizedBox.shrink();
  //   }
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     decoration: BoxDecoration(
  //       color: primaryMedium,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: primaryColor.withOpacity(0.05)),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 3,
  //           child: Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 13,
  //               color: lightText,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: Text(
  //             value.toString(),
  //             style: TextStyle(
  //               fontSize: 13,
  //               fontWeight: FontWeight.w600,
  //               color: darkText,
  //             ),
  //             textAlign: TextAlign.right,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Price Row with Special Styling

  Widget _buildInfoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    // Check if this is a numeric field that needs special formatting
    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Occupancy') ||
        label == 'Total Rooms' ||
        label == 'Number of Rooms' ||
        label == 'Max Occupancy') {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') ||
        label.contains('Tariff') ||
        label.contains('Min') ||
        label.contains('Max')) {
      displayValue = '₹${_formatPrice(value)}';
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPriceRow(String label, dynamic value) {
  //   if (value == null || value.toString().isEmpty) {
  //     return const SizedBox.shrink();
  //   }
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     decoration: BoxDecoration(
  //       color: primarySoft,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: primaryColor.withOpacity(0.15)),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 3,
  //           child: Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 13,
  //               color: mediumText,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: Text(
  //             '₹${value.toString()}',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w700,
  //               color: primaryColor,
  //             ),
  //             textAlign: TextAlign.right,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPriceRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue = _formatPrice(value);
    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹$displayValue',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (accountType == null || accountType.toString().isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLandlineNumbers(dynamic landlineNumbers) {
    List<Widget> widgets = [];
    if (landlineNumbers is List && landlineNumbers.isNotEmpty) {
      for (var i = 0; i < landlineNumbers.length; i++) {
        if (landlineNumbers[i].toString().isNotEmpty) {
          widgets.add(_buildInfoRow('Landline ${i + 1}', landlineNumbers[i]));
        }
      }
    }
    return widgets;
  }

  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];
    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        type.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // List<Widget> _buildRoomDetails() {
  //   List<Widget> widgets = [];
  //   final roomDetails = _data['roomDetails'];
  //   final selectedRoomTypes = _data['selectedRoomTypes'];
  //
  //   if (roomDetails is Map && selectedRoomTypes is Map) {
  //     selectedRoomTypes.forEach((type, isSelected) {
  //       if (isSelected == true && roomDetails.containsKey(type)) {
  //         final details = roomDetails[type];
  //         if (details is Map) {
  //           bool hasData = details['rooms'].toString().isNotEmpty ||
  //               details['occupancy'].toString().isNotEmpty ||
  //               details['price'].toString().isNotEmpty;
  //
  //           if (hasData) {
  //             widgets.add(
  //               Container(
  //                 margin: const EdgeInsets.only(bottom: 12),
  //                 padding: const EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: cardColor,
  //                   borderRadius: BorderRadius.circular(16),
  //                   border: Border.all(color: borderColor),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Container(
  //                           padding: const EdgeInsets.all(8),
  //                           decoration: BoxDecoration(
  //                             color: primarySoft,
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           child: Icon(Icons.hotel, size: 16, color: primaryColor),
  //                         ),
  //                         const SizedBox(width: 12),
  //                         Text(
  //                           type.toString(),
  //                           style: TextStyle(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w700,
  //                             color: darkText,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(height: 12),
  //                     if (details['rooms'].toString().isNotEmpty)
  //                       _buildDetailRow('Number of Rooms', details['rooms'].toString()),
  //                     if (details['occupancy'].toString().isNotEmpty)
  //                       _buildDetailRow('Max Occupancy', '${details['occupancy']} Persons'),
  //                     if (details['ac'] != null)
  //                       _buildDetailRow('AC', details['ac'] == true ? 'Yes' : 'No'),
  //                     if (details['price'].toString().isNotEmpty)
  //                       _buildDetailRow('Price per Night', '₹${details['price']}'),
  //                     if (details['extraBed'] != null)
  //                       _buildDetailRow('Extra Bed', details['extraBed'] == true ? 'Yes' : 'No'),
  //                     if (details['extraBed'] == true && details['extraBedPrice'].toString().isNotEmpty)
  //                       _buildDetailRow('Extra Bed Price', '₹${details['extraBedPrice']}'),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }
  //         }
  //       }
  //     });
  //   }
  //   return widgets;
  // }
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                _hasValue(details['occupancy']) ||
                _hasValue(details['price']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.hotel,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // UPDATED: Number of Rooms
                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Rooms', details['rooms']),

                      // UPDATED: Max Occupancy
                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', details['occupancy']),

                      // AC/Non-AC
                      if (details['ac'] != null)
                        _buildDetailRow(
                          'AC',
                          details['ac'] == true ? 'Yes' : 'No',
                        ),

                      // UPDATED: Price per Night
                      if (_hasValue(details['price']))
                        _buildDetailRow('Price per Night', details['price']),

                      // Extra Bed
                      if (details['extraBed'] != null)
                        _buildDetailRow(
                          'Extra Bed',
                          details['extraBed'] == true ? 'Yes' : 'No',
                        ),

                      // UPDATED: Extra Bed Price
                      if (details['extraBed'] == true &&
                          _hasValue(details['extraBedPrice']))
                        _buildDetailRow(
                          'Extra Bed Price',
                          details['extraBedPrice'],
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        }
      });
    }
    return widgets;
  }

  // Add this helper method to check if a value exists and is not empty
  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num && value == 0) return true; // Zero is still a valid value
    return true;
  }
  // Widget _buildDetailRow(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 12,
  //             color: lightText,
  //           ),
  //         ),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w600,
  //             color: darkText,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildDetailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    // Check the label to determine formatting
    if (label.contains('Rooms') || label.contains('Occupancy')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label == 'AC' || label == 'Extra Bed') {
      displayValue = value == true ? 'Yes' : 'No';
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor.withOpacity(0.15)),
                    ),
                    child: Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Widget _buildCustomAmenitiesCard(dynamic customAmenities) {
  //   if (customAmenities is! List || customAmenities.isEmpty) {
  //     return const SizedBox.shrink();
  //   }
  //
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(colors: [primarySoft, primaryMedium]),
  //       borderRadius: BorderRadius.circular(24),
  //       border: Border.all(color: primaryColor.withOpacity(0.2)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 color: cardColor,
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Icon(Icons.stars, size: 16, color: primaryColor),
  //             ),
  //             const SizedBox(width: 12),
  //             Text(
  //               'Custom Amenities',
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w700,
  //                 color: primaryColor,
  //                 letterSpacing: -0.3,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Wrap(
  //           spacing: 8,
  //           runSpacing: 8,
  //           children: customAmenities
  //               .map(
  //                 (item) => Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 16,
  //                     vertical: 6,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: cardColor,
  //                     borderRadius: BorderRadius.circular(25),
  //                     border: Border.all(color: primaryColor.withOpacity(0.3)),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: primaryColor.withOpacity(0.1),
  //                         blurRadius: 4,
  //                         offset: const Offset(0, 2),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Text(
  //                     item.toString(),
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w600,
  //                       color: primaryColor,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  Widget _buildPhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  photoInfo['name'] ?? 'Uploaded successfully',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

class TwoStarHotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const TwoStarHotelDetailsScreen({super.key, required this.registrationData});

  @override
  State<TwoStarHotelDetailsScreen> createState() =>
      _TwoStarHotelDetailsScreenState();
}

class _TwoStarHotelDetailsScreenState extends State<TwoStarHotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // 2-Star specific color scheme (Olive Green)
  final Color primaryColor = const Color(0xFF6B8E23);
  final Color primaryLight = const Color(0xFF6B8E23).withOpacity(0.1);
  final Color primarySoft = const Color(0xFF6B8E23).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFF6B8E23).withOpacity(0.03);

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper methods for formatting
  String _formatInteger(dynamic value) {
    if (value == null) return '';
    if (value is int) return value.toString();
    if (value is double) return value.toInt().toString();
    if (value is String) {
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.toInt().toString();
      return value;
    }
    return value.toString();
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }
    return value.toString();
  }

  String _formatTime(String time) {
    if (time.isEmpty) return 'Not set';
    try {
      if (time.contains(':')) {
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          String period = hour >= 12 ? 'PM' : 'AM';
          int hour12 = hour % 12;
          if (hour12 == 0) hour12 = 12;
          return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }
      }
    } catch (e) {}
    return time;
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num && value == 0) return true;
    return true;
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '2STAR-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? '2-Star Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with 2-Star specific styling
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.85)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon with 2 stars
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        2,
                                        (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getHotelType(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main Content
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Policies'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                        _buildStep6(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Information',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Category', '2-Star Hotel'),
              _buildInfoRow('Hotel Type', _data['hotelType']),
              _buildInfoRow(
                'Year of Establishment',
                _data['yearOfEstablishment'],
              ),
              _buildInfoRow('Total Rooms', _data['totalRooms']),
              if (_hasValue(_data['designation']))
                _buildInfoRow('Designation', _data['designation']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildInfoRow('Owner/Manager', _data['ownerName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              if (_hasValue(_data['alternateContact']))
                _buildInfoRow('Alternate Contact', _data['alternateContact']),
              if (_hasValue(_data['email']))
                _buildInfoRow('Email', _data['email']),
              if (_hasValue(_data['website']))
                _buildInfoRow('Website', _data['website']),
            ],
          ),
          if (_data['profilePhoto'] != null &&
              _data['profilePhoto']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(_data['profilePhoto']),
            ),
        ],
      ),
    );
  }

  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              if (_hasValue(_data['addressLine2']))
                _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('District', _data['district']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('PIN Code', _data['pinCode']),
              if (_hasValue(_data['country']))
                _buildInfoRow('Country', _data['country']),
            ],
          ),

          // Additional Addresses
          if (_data['additionalAddresses'] != null &&
              (_data['additionalAddresses'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAdditionalAddressesCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalAddressesCard() {
    final addresses = _data['additionalAddresses'] as List;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Additional Addresses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key + 1;
            dynamic addr = entry.value;
            String addressText = '';

            if (addr is Map) {
              addressText = addr['address']?.toString() ?? '';
            } else if (addr is String) {
              addressText = addr;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryMedium,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TextStyle(fontSize: 13, color: darkText),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_hasValue(_data['minTariff']) || _hasValue(_data['maxTariff']))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Pricing Information',
                icon: Icons.attach_money,
                children: [
                  if (_hasValue(_data['minTariff']))
                    _buildPriceRow('Min Tariff', _data['minTariff']),
                  if (_hasValue(_data['maxTariff']))
                    _buildPriceRow('Max Tariff', _data['maxTariff']),
                  if (_data['extraBedAvailable'] != null)
                    _buildStatusRow(
                      'Extra Bed Available',
                      _data['extraBedAvailable'] == true,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['roomAmenities'] != null)
            _buildAmenityCard('Room Amenities', _data['roomAmenities']),
          if (_data['hotelFacilities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Facilities',
                _data['hotelFacilities'],
              ),
            ),
          if (_data['foodServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Food Services', _data['foodServices']),
            ),
          if (_data['guestServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Guest Services',
                _data['guestServices'],
              ),
            ),
          // Custom Amenities (NEW)
          if (_data['customAmenities'] != null &&
              (_data['customAmenities'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildCustomAmenitiesCard(_data['customAmenities']),
            ),
        ],
      ),
    );
  }

  // Step 5: Policies
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildInfoRow('Check-in Time', _formatTime(_data['checkInTime'])),
              _buildInfoRow(
                'Check-out Time',
                _formatTime(_data['checkOutTime']),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Hotel Policies',
            icon: Icons.policy,
            children: [
              _buildStatusRow(
                'Couple Friendly',
                _data['coupleFriendly'] == true,
              ),
              _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
              if (_hasValue(_data['idProofRequired']))
                _buildInfoRow('ID Proof Required', _data['idProofRequired']),
            ],
          ),
        ],
      ),
    );
  }

  // Step 6: Legal & Bank Details
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal Details',
            icon: Icons.gavel,
            children: [
              if (_hasValue(_data['gstNumber']))
                _buildInfoRow('GST Number', _data['gstNumber']),
              if (_hasValue(_data['tradeLicense']))
                _buildInfoRow('Trade License', _data['tradeLicense']),
              if (_hasValue(_data['fssaiLicense']))
                _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              if (_hasValue(_data['panNumber']))
                _buildInfoRow('PAN Number', _data['panNumber']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(_data['accountHolderName']))
                _buildInfoRow('Account Holder', _data['accountHolderName']),
              if (_hasValue(_data['bankName']))
                _buildInfoRow('Bank Name', _data['bankName']),
              if (_hasValue(_data['accountNumber']))
                _buildInfoRow(
                  'Account Number',
                  _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
                ),
              if (_hasValue(_data['ifscCode']))
                _buildInfoRow('IFSC Code', _data['ifscCode']),
              if (_hasValue(_data['branch']))
                _buildInfoRow('Branch', _data['branch']),
              if (_hasValue(_data['accountType']))
                _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              if (_hasValue(_data['declarationName']))
                _buildInfoRow('Name', _data['declarationName']),
              if (_hasValue(_data['declarationDate']))
                _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          // Digital Signature Tile
          if (_data['hasDigitalSignature'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
          // Uploaded Signature File (NEW)
          if (_data['signatureFile'] != null &&
              _data['signatureFile']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildSignatureFileTile(_data['signatureFile']),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // Info Row with proper formatting
  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;

    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Total')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Time')) {
      displayValue = _formatTime(value.toString());
    } else {
      displayValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row with Special Styling
  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹${_formatPrice(value)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (!_hasValue(accountType)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Room Types
  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            2,
                            (index) => const Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // Room Details
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                _hasValue(details['occupancy']) ||
                _hasValue(details['price']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.hotel,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Rooms', details['rooms']),

                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', details['occupancy']),

                      if (details['ac'] != null)
                        _buildDetailRow(
                          'AC',
                          details['ac'] == true ? 'Yes' : 'No',
                        ),

                      if (_hasValue(details['price']))
                        _buildDetailRow(
                          'Price per Night',
                          details['price'],
                          isPrice: true,
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        }
      });
    }
    return widgets;
  }

  // Detail Row
  Widget _buildDetailRow(String label, dynamic value, {bool isPrice = false}) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;
    if (isPrice) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Rooms') || label.contains('Occupancy')) {
      displayValue = _formatInteger(value);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // Amenity Card
  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor.withOpacity(0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 12, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          item.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Custom Amenities Card (NEW)
  Widget _buildCustomAmenitiesCard(dynamic customAmenities) {
    if (customAmenities is! List || customAmenities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primarySoft, primaryMedium]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.stars, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                'Custom Amenities',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: customAmenities
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: primaryColor.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Uploaded Documents
  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        // Skip digital signature as it's handled separately
        if (key == 'Digital Signature') return;

        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  // Photo Tile
  Widget _buildPhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  photoInfo['name'] ?? 'Uploaded successfully',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Digital Signature Tile
  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Signature File Tile (NEW)
  Widget _buildSignatureFileTile(Map<String, dynamic> signatureInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.note_alt_outlined, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uploaded Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  signatureInfo['name'] ?? 'Signature uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

class ThreeStarHotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const ThreeStarHotelDetailsScreen({
    super.key,
    required this.registrationData,
  });

  @override
  State<ThreeStarHotelDetailsScreen> createState() =>
      _ThreeStarHotelDetailsScreenState();
}

class _ThreeStarHotelDetailsScreenState
    extends State<ThreeStarHotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // 3-Star specific color scheme (Gold)
  final Color primaryColor = const Color(0xFFDAA520);
  final Color primaryLight = const Color(0xFFDAA520).withOpacity(0.1);
  final Color primarySoft = const Color(0xFFDAA520).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFFDAA520).withOpacity(0.03);

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);
  final Color starColor = const Color(0xFFFFD700);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper methods for formatting
  String _formatInteger(dynamic value) {
    if (value == null) return '';
    if (value is int) return value.toString();
    if (value is double) return value.toInt().toString();
    if (value is String) {
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.toInt().toString();
      return value;
    }
    return value.toString();
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }
    return value.toString();
  }

  String _formatTime(String time) {
    if (time.isEmpty) return 'Not set';
    try {
      if (time.contains(':')) {
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          String period = hour >= 12 ? 'PM' : 'AM';
          int hour12 = hour % 12;
          if (hour12 == 0) hour12 = 12;
          return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }
      }
    } catch (e) {}
    return time;
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num) return true; // Keep 0 values
    if (value is bool) return true; // Keep false values
    if (value is List) return value.isNotEmpty;
    if (value is Map) {
      // Check if it's a file upload with actual content
      if (value.containsKey('uploaded')) {
        return value['uploaded'] == true;
      }
      return value.isNotEmpty;
    }
    return true;
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '3STAR-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    if (_data.containsKey('signatoryName') &&
        _data['signatoryName'].toString().isNotEmpty) {
      return _data['signatoryName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? '3-Star Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with 3-Star specific styling
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.85)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon with 3 stars
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        3,
                                        (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getHotelType(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main Content
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Policies'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                        _buildStep6(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Information',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Category', '3-Star Hotel'),
              _buildInfoRow('Hotel Type', _data['hotelType']),
              _buildInfoRow(
                'Year of Establishment',
                _data['yearOfEstablishment'],
              ),
              _buildInfoRow('Total Rooms', _data['totalRooms']),
              if (_hasValue(_data['registrationNumber']))
                _buildInfoRow(
                  'Registration Number',
                  _data['registrationNumber'],
                ),
              if (_hasValue(_data['designation']))
                _buildInfoRow('Designation', _data['designation']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildInfoRow('Owner/Manager', _data['ownerName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              if (_hasValue(_data['alternateContact']))
                _buildInfoRow('Alternate Contact', _data['alternateContact']),
              if (_hasValue(_data['email']))
                _buildInfoRow('Email', _data['email']),
              if (_hasValue(_data['website']))
                _buildInfoRow('Website', _data['website']),
            ],
          ),
          if (_data.containsKey('profilePhoto') &&
              _data['profilePhoto'] != null &&
              _data['profilePhoto']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildProfilePhotoTile(_data['profilePhoto']),
            ),
        ],
      ),
    );
  }

  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              if (_hasValue(_data['addressLine2']))
                _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('District', _data['district']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('PIN Code', _data['pinCode']),
              if (_hasValue(_data['country']))
                _buildInfoRow('Country', _data['country']),
            ],
          ),

          // Additional Addresses
          if (_data.containsKey('additionalAddresses') &&
              _data['additionalAddresses'] != null &&
              (_data['additionalAddresses'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAdditionalAddressesCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalAddressesCard() {
    final addresses = _data['additionalAddresses'] as List;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Additional Addresses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key + 1;
            dynamic addr = entry.value;
            String addressText = '';

            if (addr is Map) {
              addressText = addr['address']?.toString() ?? '';
            } else if (addr is String) {
              addressText = addr;
            }

            if (addressText.isEmpty) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryMedium,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TextStyle(fontSize: 13, color: darkText),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_hasValue(_data['extraBedAvailable']) ||
              _hasValue(_data['seasonalPricing']))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Additional Features',
                icon: Icons.settings,
                children: [
                  if (_hasValue(_data['extraBedAvailable']))
                    _buildStatusRow(
                      'Extra Bed Available',
                      _data['extraBedAvailable'] == true,
                    ),
                  if (_hasValue(_data['seasonalPricing']))
                    _buildStatusRow(
                      'Seasonal Pricing',
                      _data['seasonalPricing'] == true,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['roomAmenities'] != null)
            _buildAmenityCard('Room Amenities', _data['roomAmenities']),
          if (_data['hotelFacilities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Facilities',
                _data['hotelFacilities'],
              ),
            ),
          if (_data['foodServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Food Services', _data['foodServices']),
            ),
          if (_data['businessServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Business Services',
                _data['businessServices'],
              ),
            ),
        ],
      ),
    );
  }

  // Step 5: Policies
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildInfoRow(
                'Check-in Time',
                _formatTime(_data['checkInTime'] ?? ''),
              ),
              _buildInfoRow(
                'Check-out Time',
                _formatTime(_data['checkOutTime'] ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Hotel Policies',
            icon: Icons.policy,
            // children: [
            //   if (_hasValue(_data['earlyCheckinAllowed']))
            //     _buildInfoRow(
            //       'Early/Late Check-out',
            //       _data['earlyCheckinAllowed'] == true
            //           ? (_data['earlyCheckinChargeable'] == true
            //                 ? 'Chargeable'
            //                 : 'Complimentary')
            //           : 'Not Available',
            //     ),
            //   _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
            // ],
            children: [
              if (_hasValue(_data['earlyCheckinAllowed']))
                _buildInfoRow(
                  'Early/Late Check-out',
                  _data['earlyCheckinAllowed'] == true
                      ? (_data['earlyCheckinChargeable'] == true
                      ? 'Chargeable'
                      : 'Free')  // Changed from 'Complimentary' to 'Free'
                      : 'Not Available',
                ),
              _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
            ],
          ),
        ],
      ),
    );
  }

  // Step 6: Legal & Bank Details
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal Details',
            icon: Icons.gavel,
            children: [
              if (_hasValue(_data['gstNumber']))
                _buildInfoRow('GST Number', _data['gstNumber']),
              if (_hasValue(_data['panNumber']))
                _buildInfoRow('PAN Number', _data['panNumber']),
              if (_hasValue(_data['tradeLicense']))
                _buildInfoRow('Trade License', _data['tradeLicense']),
              if (_hasValue(_data['fssaiLicense']))
                _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              if (_hasValue(_data['fireSafetyCertificate']))
                _buildStatusRow(
                  'Fire Safety Certificate',
                  _data['fireSafetyCertificate'] == true,
                ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(_data['accountHolderName']))
                _buildInfoRow('Account Holder', _data['accountHolderName']),
              if (_hasValue(_data['bankName']))
                _buildInfoRow('Bank Name', _data['bankName']),
              if (_hasValue(_data['accountNumber']))
                _buildInfoRow(
                  'Account Number',
                  _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
                ),
              if (_hasValue(_data['ifscCode']))
                _buildInfoRow('IFSC Code', _data['ifscCode']),
              if (_hasValue(_data['branch']))
                _buildInfoRow('Branch', _data['branch']),
              if (_hasValue(_data['accountType']))
                _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              if (_hasValue(_data['signatoryName']))
                _buildInfoRow('Signatory Name', _data['signatoryName']),
              if (_hasValue(_data['declarationDate']))
                _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          // Digital Signature Tile
          if (_data['hasDigitalSignature'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
          // Uploaded Signature File
          if (_data['signatureFile'] != null &&
              _data['signatureFile']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildSignatureFileTile(_data['signatureFile']),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // Info Row with proper formatting
  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;

    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Total')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Time')) {
      displayValue = _formatTime(value.toString());
    } else {
      displayValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row with Special Styling
  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹${_formatPrice(value)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (!_hasValue(accountType)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Room Types
  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            3,
                            (index) => const Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // Room Details
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                _hasValue(details['occupancy']) ||
                _hasValue(details['price']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.hotel,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Rooms', details['rooms']),

                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', details['occupancy']),

                      if (details['ac'] != null)
                        _buildDetailRow(
                          'AC',
                          details['ac'] == true ? 'Yes' : 'No',
                        ),

                      if (_hasValue(details['bedType']))
                        _buildDetailRow('Bed Type', details['bedType']),

                      if (_hasValue(details['price']))
                        _buildDetailRow(
                          'Price per Night',
                          details['price'],
                          isPrice: true,
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        }
      });
    }
    return widgets;
  }

  // Detail Row
  Widget _buildDetailRow(String label, dynamic value, {bool isPrice = false}) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;
    if (isPrice) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Rooms') || label.contains('Occupancy')) {
      displayValue = _formatInteger(value);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // Amenity Card
  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor.withOpacity(0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, size: 12, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          item.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Uploaded Documents
  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        // Skip digital signature as it's handled separately
        if (key == 'Digital Signature') return;

        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value['name'] ?? 'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  // Profile Photo Tile
  Widget _buildProfilePhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  photoInfo['name'] ?? 'Uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (photoInfo.containsKey('size'))
                  Text(
                    '${(photoInfo['size'] / 1024).toStringAsFixed(1)} KB',
                    style: TextStyle(
                      fontSize: 11,
                      color: lightText.withOpacity(0.7),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, color: primaryColor, size: 20),
          ),
        ],
      ),
    );
  }

  // Digital Signature Tile
  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Signature File Tile
  Widget _buildSignatureFileTile(Map<String, dynamic> signatureInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.note_alt_outlined, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uploaded Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  signatureInfo['name'] ?? 'Signature uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

class FourStarHotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const FourStarHotelDetailsScreen({
    super.key,
    required this.registrationData,
  });

  @override
  State<FourStarHotelDetailsScreen> createState() => _FourStarHotelDetailsScreenState();
}

class _FourStarHotelDetailsScreenState extends State<FourStarHotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // 4-Star specific color scheme (Indigo/Purple)
  final Color primaryColor = const Color(0xFF4F46E5);
  final Color primaryLight = const Color(0xFF4F46E5).withOpacity(0.1);
  final Color primarySoft = const Color(0xFF4F46E5).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFF4F46E5).withOpacity(0.03);

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);
  final Color starColor = const Color(0xFFFFD700);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper methods for formatting
  String _formatInteger(dynamic value) {
    if (value == null) return '';
    if (value is int) return value.toString();
    if (value is double) return value.toInt().toString();
    if (value is String) {
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.toInt().toString();
      return value;
    }
    return value.toString();
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }
    return value.toString();
  }

  // String _formatTime(String time) {
  //   if (time.isEmpty) return 'Not set';
  //   try {
  //     if (time.contains(':')) {
  //       List<String> parts = time.split(':');
  //       if (parts.length >= 2) {
  //         int hour = int.parse(parts[0]);
  //         int minute = int.parse(parts[1].substring(0, 2));
  //         String period = hour >= 12 ? 'PM' : 'AM';
  //         int hour12 = hour % 12;
  //         if (hour12 == 0) hour12 = 12;
  //         return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  //       }
  //     }
  //   } catch (e) {}
  //   return time;
  // }
  String _formatTime(String time) {
    if (time.isEmpty) return 'Not set';

    try {
      // Check if time is in HH:MM format (24-hour)
      if (time.contains(':') && !time.contains('AM') && !time.contains('PM')) {
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));

          // CORRECT CONVERSION from 24-hour to 12-hour format
          String period = hour >= 12 ? 'PM' : 'AM';

          int hour12;
          if (hour == 0) {
            hour12 = 12; // 12 AM (midnight)
          } else if (hour > 12) {
            hour12 = hour - 12; // 1 PM to 11 PM (13-23)
          } else {
            hour12 = hour; // 1 AM to 11 AM (1-11)
          }
          // Note: hour 12 is handled by the else case (stays as 12 for noon)

          return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }
      }

      // If already in 12-hour format with AM/PM, return as is
      return time;

    } catch (e) {
      // Return original if parsing fails
      return time;
    }
  }
  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num && value == 0) return true;
    return true;
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '4STAR-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    if (_data.containsKey('signatoryName') &&
        _data['signatoryName'].toString().isNotEmpty) {
      return _data['signatoryName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? '4-Star Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with 4-Star specific styling
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.85)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon with 4 stars
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        4,
                                            (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getHotelType(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main Content
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Policies'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                        _buildStep6(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Information',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Category', '4-Star Hotel'),
              _buildInfoRow('Hotel Type', _data['hotelType']),
              _buildInfoRow(
                'Year of Establishment',
                _data['yearOfEstablishment'],
              ),
              _buildInfoRow('Total Rooms', _data['totalRooms']),
              if (_hasValue(_data['registrationNumber']))
                _buildInfoRow('Registration Number', _data['registrationNumber']),
              if (_hasValue(_data['designation']))
                _buildInfoRow('Designation', _data['designation']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildInfoRow('Owner/Manager', _data['ownerName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              if (_hasValue(_data['alternateContact']))
                _buildInfoRow('Alternate Contact', _data['alternateContact']),

              ..._buildLandlineNumbers(_data['landlineNumbers']),

              if (_hasValue(_data['email']))
                _buildInfoRow('Email', _data['email']),
              if (_hasValue(_data['website']))
                _buildInfoRow('Website', _data['website']),
            ],
          ),
          if (_data['profilePhoto'] != null &&
              _data['profilePhoto']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(_data['profilePhoto']),
            ),
        ],
      ),
    );
  }
  List<Widget> _buildLandlineNumbers(dynamic landlineNumbers) {
    List<Widget> widgets = [];
    if (landlineNumbers is List && landlineNumbers.isNotEmpty) {
      for (var i = 0; i < landlineNumbers.length; i++) {
        if (landlineNumbers[i].toString().isNotEmpty) {
          widgets.add(_buildInfoRow('Landline ${i + 1}', landlineNumbers[i]));
        }
      }
    }
    return widgets;
  }
  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              if (_hasValue(_data['addressLine2']))
                _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('District', _data['district']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('PIN Code', _data['pinCode']),
              if (_hasValue(_data['country']))
                _buildInfoRow('Country', _data['country']),
            ],
          ),

          // Additional Addresses
          if (_data['additionalAddresses'] != null &&
              (_data['additionalAddresses'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAdditionalAddressesCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalAddressesCard() {
    final addresses = _data['additionalAddresses'] as List;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Additional Addresses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key + 1;
            dynamic addr = entry.value;
            String addressText = '';

            if (addr is Map) {
              addressText = addr['address']?.toString() ?? '';
            } else if (addr is String) {
              addressText = addr;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryMedium,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TextStyle(fontSize: 13, color: darkText),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_hasValue(_data['extraBedAvailable']) || _hasValue(_data['seasonalPricing']))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Additional Features',
                icon: Icons.settings,
                children: [
                  if (_hasValue(_data['extraBedAvailable']))
                    _buildStatusRow('Extra Bed Available', _data['extraBedAvailable'] == true),
                  if (_hasValue(_data['seasonalPricing']))
                    _buildStatusRow('Seasonal Pricing', _data['seasonalPricing'] == true),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['roomAmenities'] != null)
            _buildAmenityCard('Room Amenities', _data['roomAmenities']),
          if (_data['hotelFacilities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Facilities',
                _data['hotelFacilities'],
              ),
            ),
          if (_data['foodServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Food Services', _data['foodServices']),
            ),
          if (_data['businessServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Business Services',
                _data['businessServices'],
              ),
            ),
          if (_data['wellnessRecreation'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Wellness & Recreation',
                _data['wellnessRecreation'],
              ),
            ),
        ],
      ),
    );
  }

  // Step 5: Policies
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildInfoRow('Check-in Time', _formatTime(_data['checkInTime'] ?? '')),
              _buildInfoRow(
                'Check-out Time',
                _formatTime(_data['checkOutTime'] ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Hotel Policies',
            icon: Icons.policy,
            // children: [
            //   if (_hasValue(_data['earlyCheckinAllowed']))
            //     _buildInfoRow(
            //       'Early/Late Check-out',
            //       _data['earlyCheckinAllowed'] == true
            //           ? (_data['earlyCheckinChargeable'] == true ? 'Chargeable' : 'Complimentary')
            //           : 'Not Available',
            //     ),
            //   _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
            // ],

            children: [
              if (_hasValue(_data['earlyCheckinAllowed']))
                _buildInfoRow(
                  'Early/Late Check-out',
                  _data['earlyCheckinAllowed'] == true
                      ? (_data['earlyCheckinChargeable'] == true
                      ? 'Chargeable'
                      : 'Free')  // Changed from 'Complimentary' to 'Free'
                      : 'Not Available',
                ),
              _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
            ],
          ),
        ],
      ),
    );
  }

  // Step 6: Legal & Bank Details
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal Details',
            icon: Icons.gavel,
            children: [
              if (_hasValue(_data['gstNumber']))
                _buildInfoRow('GST Number', _data['gstNumber']),
              if (_hasValue(_data['panNumber']))
                _buildInfoRow('PAN Number', _data['panNumber']),
              if (_hasValue(_data['tradeLicense']))
                _buildInfoRow('Trade License', _data['tradeLicense']),
              if (_hasValue(_data['fssaiLicense']))
                _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              if (_hasValue(_data['fireSafetyCertificate']))
                _buildStatusRow('Fire Safety Certificate', _data['fireSafetyCertificate'] == true),
              if (_hasValue(_data['starCertificate']))
                _buildStatusRow('Star Certificate', _data['starCertificate'] == true),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(_data['accountHolderName']))
                _buildInfoRow('Account Holder', _data['accountHolderName']),
              if (_hasValue(_data['bankName']))
                _buildInfoRow('Bank Name', _data['bankName']),
              if (_hasValue(_data['accountNumber']))
                _buildInfoRow(
                  'Account Number',
                  _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
                ),
              if (_hasValue(_data['ifscCode']))
                _buildInfoRow('IFSC Code', _data['ifscCode']),
              if (_hasValue(_data['branch']))
                _buildInfoRow('Branch', _data['branch']),
              if (_hasValue(_data['accountType']))
                _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              if (_hasValue(_data['signatoryName']))
                _buildInfoRow('Signatory Name', _data['signatoryName']),
              if (_hasValue(_data['declarationDate']))
                _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          // Digital Signature Tile
          if (_data['hasDigitalSignature'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
          // Uploaded Signature File
          if (_data['signatureFile'] != null &&
              _data['signatureFile']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildSignatureFileTile(_data['signatureFile']),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // Info Row with proper formatting
  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;

    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Total')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Time')) {
      displayValue = _formatTime(value.toString());
    } else {
      displayValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row with Special Styling
  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹${_formatPrice(value)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (!_hasValue(accountType)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Room Types
  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        4,
                            (index) => const Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        type.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // Room Details
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                    _hasValue(details['occupancy']) ||
                    _hasValue(details['price']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.hotel,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Rooms', details['rooms']),

                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', details['occupancy']),

                      if (details['ac'] != null)
                        _buildDetailRow(
                          'AC',
                          details['ac'] == true ? 'Yes' : 'No',
                        ),

                      if (_hasValue(details['bedType']))
                        _buildDetailRow('Bed Type', details['bedType']),

                      if (_hasValue(details['price']))
                        _buildDetailRow(
                          'Price per Night',
                          details['price'],
                          isPrice: true,
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        }
      });
    }
    return widgets;
  }

  // Detail Row
  Widget _buildDetailRow(String label, dynamic value, {bool isPrice = false}) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;
    if (isPrice) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Rooms') || label.contains('Occupancy')) {
      displayValue = _formatInteger(value);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // Amenity Card
  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor.withOpacity(0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Uploaded Documents
  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        // Skip digital signature as it's handled separately
        if (key == 'Digital Signature') return;

        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value['name'] ?? 'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  // Photo Tile
  Widget _buildPhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  photoInfo['name'] ?? 'Uploaded successfully',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Digital Signature Tile
  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Signature File Tile
  Widget _buildSignatureFileTile(Map<String, dynamic> signatureInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.note_alt_outlined, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uploaded Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  signatureInfo['name'] ?? 'Signature uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}


class FiveStarHotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const FiveStarHotelDetailsScreen({
    super.key,
    required this.registrationData,
  });

  @override
  State<FiveStarHotelDetailsScreen> createState() =>
      _FiveStarHotelDetailsScreenState();
}

class _FiveStarHotelDetailsScreenState extends State<FiveStarHotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // 5-Star specific color scheme (Pink/Rose Gold)
  final Color primaryColor = const Color(0xFFFB717D);
  final Color primaryLight = const Color(0xFFFB717D).withOpacity(0.1);
  final Color primarySoft = const Color(0xFFFB717D).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFFFB717D).withOpacity(0.03);

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);
  final Color starColor = const Color(0xFFFFD700);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper methods for formatting
  String _formatInteger(dynamic value) {
    if (value == null) return '';
    if (value is int) return value.toString();
    if (value is double) return value.toInt().toString();
    if (value is String) {
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.toInt().toString();
      return value;
    }
    return value.toString();
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }
    return value.toString();
  }

  // String _formatTime(String time) {
  //   if (time.isEmpty) return 'Not set';
  //   try {
  //     if (time.contains(':')) {
  //       List<String> parts = time.split(':');
  //       if (parts.length >= 2) {
  //         int hour = int.parse(parts[0]);
  //         int minute = int.parse(parts[1].substring(0, 2));
  //         String period = hour >= 12 ? 'PM' : 'AM';
  //         int hour12 = hour % 12;
  //         if (hour12 == 0) hour12 = 12;
  //         return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  //       }
  //     }
  //   } catch (e) {}
  //   return time;
  // }

  String _formatTime(String time) {
    if (time.isEmpty) return 'Not set';

    try {
      // Check if time is in HH:MM format (24-hour)
      if (time.contains(':') && !time.contains('AM') && !time.contains('PM')) {
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));

          // CORRECT CONVERSION from 24-hour to 12-hour format
          String period = hour >= 12 ? 'PM' : 'AM';

          int hour12;
          if (hour == 0) {
            hour12 = 12; // 12 AM (midnight)
          } else if (hour > 12) {
            hour12 = hour - 12; // 1 PM to 11 PM (13-23)
          } else {
            hour12 = hour; // 1 AM to 11 AM (1-11)
          }
          // Note: hour 12 is handled by the else case (stays as 12 for noon)

          return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }
      }

      // If already in 12-hour format with AM/PM, return as is
      return time;

    } catch (e) {
      // Return original if parsing fails
      return time;
    }
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num && value == 0) return true;
    return true;
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '5STAR-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    if (_data.containsKey('signatoryName') &&
        _data['signatoryName'].toString().isNotEmpty) {
      return _data['signatoryName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? '5-Star Luxury Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with 5-Star specific styling
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.85)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon with 5 stars
                            Container(
                              width: 80,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) =>
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        5,
                                            (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getHotelType(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main Content
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Policies'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                        _buildStep6(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Information',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Category', '5-Star Luxury Hotel'),
              if (_hasValue(_data['hotelType']))
                _buildInfoRow('Hotel Type', _data['hotelType']),
              if (_hasValue(_data['brandName']))
                _buildInfoRow('Brand Name', _data['brandName']),
              if (_hasValue(_data['yearOfEstablishment']))
                _buildInfoRow(
                  'Year of Establishment',
                  _formatInteger(_data['yearOfEstablishment']),
                ),
              if (_hasValue(_data['totalRooms']))
                _buildInfoRow(
                  'Total Rooms',
                  _formatInteger(_data['totalRooms']),
                ),
              if (_hasValue(_data['starCertNumber']))
                _buildInfoRow('Star Certificate No.', _data['starCertNumber']),
              if (_hasValue(_data['designation']))
                _buildInfoRow('Designation', _data['designation']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Contact Information',
            icon: Icons.contact_phone,
            children: [
              _buildInfoRow('Owner/Manager', _data['ownerName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              if (_hasValue(_data['alternateContact']))
                _buildInfoRow('Alternate Contact', _data['alternateContact']),
              if (_hasValue(_data['email']))
                _buildInfoRow('Email', _data['email']),
              if (_hasValue(_data['website']))
                _buildInfoRow('Website', _data['website']),
            ],
          ),
          if (_data['profilePhoto'] != null &&
              _data['profilePhoto']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(_data['profilePhoto']),
            ),
        ],
      ),
    );
  }

  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              if (_hasValue(_data['addressLine2']))
                _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('District', _data['district']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('PIN Code', _data['pinCode']),
              if (_hasValue(_data['country']))
                _buildInfoRow('Country', _data['country']),
            ],
          ),

          // Additional Addresses
          if (_data['additionalAddresses'] != null &&
              (_data['additionalAddresses'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAdditionalAddressesCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalAddressesCard() {
    final addresses = _data['additionalAddresses'] as List;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Additional Addresses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key + 1;
            dynamic addr = entry.value;
            String addressText = '';

            if (addr is Map) {
              addressText = addr['address']?.toString() ?? '';
            } else if (addr is String) {
              addressText = addr;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryMedium,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TextStyle(fontSize: 13, color: darkText),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_hasValue(_data['extraBedAvailable']) || _hasValue(_data['seasonalPricing']))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Additional Features',
                icon: Icons.settings,
                children: [
                  if (_hasValue(_data['extraBedAvailable']))
                    _buildStatusRow('Extra Bed Available', _data['extraBedAvailable'] == true),
                  if (_hasValue(_data['seasonalPricing']))
                    _buildStatusRow('Seasonal/Dynamic Pricing', _data['seasonalPricing'] == true),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['roomAmenities'] != null)
            _buildAmenityCard('In-Room Luxury Amenities', _data['roomAmenities']),
          if (_data['hotelFacilities'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Infrastructure & Services',
                _data['hotelFacilities'],
              ),
            ),
          if (_data['diningServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Dining, Events & Entertainment', _data['diningServices']),
            ),
          if (_data['wellnessRecreation'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Wellness, Leisure & Recreation',
                _data['wellnessRecreation'],
              ),
            ),
          if (_data['guestServices'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Premium Guest Services',
                _data['guestServices'],
              ),
            ),
        ],
      ),
    );
  }

  // Step 5: Policies
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildInfoRow('Check-in Time', _formatTime(_data['checkInTime'] ?? '')),
              _buildInfoRow(
                'Check-out Time',
                _formatTime(_data['checkOutTime'] ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Hotel Policies',
            icon: Icons.policy,
            children: [
              if (_hasValue(_data['earlyCheckinAllowed']))
                _buildInfoRow(
                  'Early/Late Check-out',
                  _data['earlyCheckinAllowed'] == true
                      ? (_data['earlyCheckinChargeable'] == true
                      ? 'Chargeable'
                      : 'Free')  // Changed from 'Complimentary' to 'Free'
                      : 'Not Available',
                ),
              if (_hasValue(_data['coupleFriendly']))
                _buildStatusRow('Couple Friendly', _data['coupleFriendly'] == true),
              _buildStatusRow('Pets Allowed', _data['petsAllowed'] == true),
              if (_data['smokingRooms'] == true || _data['nonSmokingRooms'] == true)
                _buildInfoRow(
                  'Smoking Policy',
                  _data['smokingRooms'] == true && _data['nonSmokingRooms'] == true
                      ? 'Both Available'
                      : _data['smokingRooms'] == true
                      ? 'Smoking Rooms'
                      : 'Non-Smoking Rooms',
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 6: Legal & Bank Details
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal Details',
            icon: Icons.gavel,
            children: [
              if (_hasValue(_data['gstNumber']))
                _buildInfoRow('GST Number', _data['gstNumber']),
              if (_hasValue(_data['panNumber']))
                _buildInfoRow('PAN Number', _data['panNumber']),
              if (_hasValue(_data['tradeLicense']))
                _buildInfoRow('Trade License', _data['tradeLicense']),
              if (_hasValue(_data['fssaiLicense']))
                _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              // Compliance Certificates
              _buildComplianceCertificates(),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(_data['accountHolderName']))
                _buildInfoRow('Account Holder', _data['accountHolderName']),
              if (_hasValue(_data['bankName']))
                _buildInfoRow('Bank Name', _data['bankName']),
              if (_hasValue(_data['accountNumber']))
                _buildInfoRow(
                  'Account Number',
                  _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
                ),
              if (_hasValue(_data['ifscCode']))
                _buildInfoRow('IFSC Code', _data['ifscCode']),
              if (_hasValue(_data['branch']))
                _buildInfoRow('Branch', _data['branch']),
              if (_hasValue(_data['accountType']))
                _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              if (_hasValue(_data['signatoryName']))
                _buildInfoRow('Signatory Name', _data['signatoryName']),
              if (_hasValue(_data['signatoryDesignation']))
                _buildInfoRow('Designation', _data['signatoryDesignation']),
              if (_hasValue(_data['declarationDate']))
                _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          // Digital Signature Tile
          if (_data['hasDigitalSignature'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
          // Uploaded Signature File
          if (_data['signatureFile'] != null &&
              _data['signatureFile']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildSignatureFileTile(_data['signatureFile']),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // Info Row with proper formatting
  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;

    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Total')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Time')) {
      displayValue = _formatTime(value.toString());
    } else {
      displayValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row with Special Styling
  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹${_formatPrice(value)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (!_hasValue(accountType)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Compliance Certificates
  Widget _buildComplianceCertificates() {
    final List<String> certificates = [];

    if (_data['fireSafetyCertificate'] == true) certificates.add('Fire Safety NOC');
    if (_data['pollutionCertificate'] == true) certificates.add('Pollution Control');
    if (_data['starCertificate'] == true) certificates.add('Star Classification');
    if (_data['liftCertificate'] == true) certificates.add('Lift Fitness');

    if (certificates.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance Certificates',
            style: TextStyle(
              fontSize: 13,
              color: lightText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: certificates.map((cert) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 12, color: primaryColor),
                  const SizedBox(width: 4),
                  Text(
                    cert,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // Room Types
  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        5,
                            (index) => const Icon(
                          Icons.star,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        type.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // Room Details
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                    _hasValue(details['occupancy']) ||
                    _hasValue(details['ac']) ||
                    _hasValue(details['bedType']) ||
                    _hasValue(details['minPrice']) ||
                    _hasValue(details['maxPrice']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.hotel,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            type.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Units', _formatInteger(details['rooms'])),

                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

                      if (details['ac'] != null)
                        _buildDetailRow(
                          'Climate Control',
                          details['ac'] == true ? 'Yes' : 'No',
                        ),

                      if (_hasValue(details['bedType']))
                        _buildDetailRow('Bed Type', details['bedType']),

                      if (_hasValue(details['minPrice']) || _hasValue(details['maxPrice']))
                        _buildDetailRow(
                          'Price Range',
                          '₹${_formatPrice(details['minPrice'])} - ₹${_formatPrice(details['maxPrice'])}',
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        }
      });
    }
    return widgets;
  }

  // Detail Row
  Widget _buildDetailRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // Amenity Card
  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor.withOpacity(0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Uploaded Documents
  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        // Skip digital signature as it's handled separately
        if (key == 'Digital Signature') return;

        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value['name'] ?? 'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  // Photo Tile
  Widget _buildPhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  photoInfo['name'] ?? 'Uploaded successfully',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Digital Signature Tile
  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Signature File Tile
  Widget _buildSignatureFileTile(Map<String, dynamic> signatureInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.note_alt_outlined, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uploaded Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  signatureInfo['name'] ?? 'Signature uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}



class SixStarHotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const SixStarHotelDetailsScreen({
    super.key,
    required this.registrationData,
  });

  @override
  State<SixStarHotelDetailsScreen> createState() =>
      _SixStarHotelDetailsScreenState();
}

class _SixStarHotelDetailsScreenState extends State<SixStarHotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  // 6-Star specific color scheme (Royal Gold/Purple)
  final Color primaryColor = const Color(0xFFD4AF37); // Royal Gold
  final Color primaryLight = const Color(0xFFD4AF37).withOpacity(0.1);
  final Color primarySoft = const Color(0xFFD4AF37).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFFD4AF37).withOpacity(0.03);
  final Color royalPurple = const Color(0xFF7851A9); // Royal Purple accent

  // Sophisticated neutral palette
  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);
  final Color starColor = const Color(0xFFFFD700);

  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper methods for formatting
  String _formatInteger(dynamic value) {
    if (value == null) return '';
    if (value is int) return value.toString();
    if (value is double) return value.toInt().toString();
    if (value is String) {
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) return parsedDouble.toInt().toString();
      return value;
    }
    return value.toString();
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed.toStringAsFixed(
          parsed.truncateToDouble() == parsed ? 0 : 2,
        );
      }
      return value;
    }
    return value.toString();
  }

  String _formatTime(String time) {
    if (time.isEmpty) return 'Not set';
    try {
      if (time.contains(':')) {
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          String period = hour >= 12 ? 'PM' : 'AM';
          int hour12 = hour % 12;
          if (hour12 == 0) hour12 = 12;
          return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
        }
      }
    } catch (e) {}
    return time;
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num && value == 0) return true;
    return true;
  }

  String _getRegistrationId() {
    final hotelName = _data['hotelName']?.toString() ?? 'HOTEL';
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    final namePrefix = hotelName.length >= 3
        ? hotelName.substring(0, 3).toUpperCase()
        : hotelName.toUpperCase();
    return '6STAR-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    if (_data.containsKey('fullName') &&
        _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') &&
        _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    if (_data.containsKey('signatoryName') &&
        _data['signatoryName'].toString().isNotEmpty) {
      return _data['signatoryName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('phone')) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobileNumber')) {
      return _data['mobileNumber'].toString();
    }
    return 'Not provided';
  }

  String _getHotelName() {
    return _data['hotelName']?.toString() ?? 'Hotel';
  }

  String _getHotelType() {
    return _data['hotelType']?.toString() ?? '6-Star Ultra-Luxury Hotel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with 6-Star specific styling
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, royalPurple],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      // Main Content Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon with 6 stars
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(6, (index) =>
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getHotelName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        6,
                                            (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _getHotelType(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        size: 14,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main Content
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  // Personal Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: primaryColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Profile Avatar with Gradient Border
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                royalPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkText,
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.phone_outlined,
                                      value: _getUserPhone(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _buildInfoChip(
                                      icon: Icons.email_outlined,
                                      value: _getUserEmail(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Address'),
                        Tab(text: 'Room Config'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Policies'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),

                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                        _buildStep4(),
                        _buildStep5(),
                        _buildStep6(),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: primaryColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Hotel Profile',
            icon: Icons.business_center,
            children: [
              _buildInfoRow('Hotel Name', _data['hotelName']),
              _buildInfoRow('Hotel Category', '6-Star Ultra-Luxury Hotel'),
              if (_hasValue(_data['brandName']))
                _buildInfoRow('Brand Name', _data['brandName']),
              if (_hasValue(_data['hotelType']))
                _buildInfoRow('Hotel Type', _data['hotelType']),
              if (_hasValue(_data['yearOfEstablishment']))
                _buildInfoRow(
                  'Year of Establishment',
                  _formatInteger(_data['yearOfEstablishment']),
                ),
              if (_hasValue(_data['totalRooms']))
                _buildInfoRow(
                  'Total Rooms',
                  _formatInteger(_data['totalRooms']),
                ),
              if (_hasValue(_data['globalRecognition']))
                _buildRecognitionInfo(),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Executive Management',
            icon: Icons.people,
            children: [
              _buildInfoRow('Owner / Signatory', _data['ownerName']),
              _buildInfoRow('Designation', _data['designation']),
              _buildInfoRow('General Manager', _data['gmName']),
              _buildInfoRow('Mobile Number', _data['mobileNumber']),
              if (_hasValue(_data['alternateContact']))
                _buildInfoRow('Alternate Contact', _data['alternateContact']),
              if (_hasValue(_data['email']))
                _buildInfoRow('Email', _data['email']),
              if (_hasValue(_data['website']))
                _buildInfoRow('Website', _data['website']),
            ],
          ),
          if (_data['profilePhoto'] != null &&
              _data['profilePhoto']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(_data['profilePhoto']),
            ),
        ],
      ),
    );
  }

  Widget _buildRecognitionInfo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.workspace_premium, color: primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Global Recognition',
                  style: TextStyle(
                    fontSize: 12,
                    color: lightText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _data['globalRecognition'].toString(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 2: Address Details
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Address Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Address Line 1', _data['addressLine1']),
              if (_hasValue(_data['addressLine2']))
                _buildInfoRow('Address Line 2', _data['addressLine2']),
              _buildInfoRow('City', _data['city']),
              _buildInfoRow('State', _data['state']),
              _buildInfoRow('Country', _data['country']),
              _buildInfoRow('PIN Code', _data['pinCode']),
            ],
          ),

          // Additional Addresses
          if (_data['additionalAddresses'] != null &&
              (_data['additionalAddresses'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAdditionalAddressesCard(),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalAddressesCard() {
    final addresses = _data['additionalAddresses'] as List;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Additional Addresses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.asMap().entries.map((entry) {
            int index = entry.key + 1;
            dynamic addr = entry.value;
            String addressText = '';

            if (addr is Map) {
              addressText = addr['address']?.toString() ?? '';
            } else if (addr is String) {
              addressText = addr;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryMedium,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      addressText,
                      style: TextStyle(fontSize: 13, color: darkText),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Room Types Available',
            icon: Icons.meeting_room,
            children: _buildRoomTypes(),
          ),
          ..._buildRoomDetails(),
          if (_hasValue(_data['personalButler']) || _hasValue(_data['aiPricing']))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildGlassCard(
                title: 'Additional Features',
                icon: Icons.settings,
                children: [
                  if (_hasValue(_data['personalButler']))
                    _buildStatusRow('Personal Butler Service', _data['personalButler'] == true),
                  if (_hasValue(_data['aiPricing']))
                    _buildStatusRow('AI-Based Pricing', _data['aiPricing'] == true),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Step 4: Amenities
  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_data['roomAmenities'] != null)
            _buildAmenityCard('In-Room Ultra-Luxury Amenities', _data['roomAmenities']),
          if (_data['hotelInfrastructure'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Hotel Infrastructure & Elite Services',
                _data['hotelInfrastructure'],
              ),
            ),
          if (_data['diningExperiences'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard('Dining, Events & Experiences', _data['diningExperiences']),
            ),
          if (_data['wellnessLeisure'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Wellness, Leisure & Lifestyle',
                _data['wellnessLeisure'],
              ),
            ),
          if (_data['guestPrivileges'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildAmenityCard(
                'Exclusive Guest Privileges',
                _data['guestPrivileges'],
              ),
            ),
        ],
      ),
    );
  }

  // Step 5: Policies
  Widget _buildStep5() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildInfoRow('Check-In Time', _formatTime(_data['checkInTime'] ?? '')),
              _buildInfoRow(
                'Check-Out Time',
                _formatTime(_data['checkOutTime'] ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Guest Policies',
            icon: Icons.policy,
            children: [
              if (_hasValue(_data['vipProtocols']))
                _buildStatusRow('VIP / Diplomatic Protocols', _data['vipProtocols'] == true),
              if (_hasValue(_data['petLuxuryServices']))
                _buildStatusRow('Pet Luxury Services', _data['petLuxuryServices'] == true),
              if (_data['smokingPrivateAreas'] == true || _data['nonSmoking'] == true)
                _buildInfoRow(
                  'Smoking Policy',
                  _data['smokingPrivateAreas'] == true && _data['nonSmoking'] == true
                      ? 'Both Available'
                      : _data['smokingPrivateAreas'] == true
                      ? 'Private Areas Only'
                      : 'Non-Smoking',
                ),
              _buildInfoRow('Early / Late Check-Out', 'By Approval'),
            ],
          ),
        ],
      ),
    );
  }

  // Step 6: Legal & Bank Details
  Widget _buildStep6() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal & Global Compliance',
            icon: Icons.gavel,
            children: [
              if (_hasValue(_data['gstNumber']))
                _buildInfoRow('GST Number', _data['gstNumber']),
              if (_hasValue(_data['panNumber']))
                _buildInfoRow('PAN Number', _data['panNumber']),
              if (_hasValue(_data['tradeLicense']))
                _buildInfoRow('Trade License', _data['tradeLicense']),
              if (_hasValue(_data['fssaiLicense']))
                _buildInfoRow('FSSAI License', _data['fssaiLicense']),
              // Compliance Certificates
              _buildComplianceCertificates(),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank & Financial Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(_data['accountHolderName']))
                _buildInfoRow('Account Holder', _data['accountHolderName']),
              if (_hasValue(_data['bankName']))
                _buildInfoRow('Bank Name', _data['bankName']),
              if (_hasValue(_data['accountNumber']))
                _buildInfoRow(
                  'Account Number',
                  _maskAccountNumber(_data['accountNumber']?.toString() ?? ''),
                ),
              if (_hasValue(_data['ifscCode']))
                _buildInfoRow('IFSC / SWIFT Code', _data['ifscCode']),
              if (_hasValue(_data['branch']))
                _buildInfoRow('Branch / Country', _data['branch']),
              if (_hasValue(_data['accountType']))
                _buildAccountTypeRow(_data['accountType']),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Uploaded Documents',
            icon: Icons.folder,
            children: _buildUploadedDocuments(),
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Declaration',
            icon: Icons.verified_user,
            children: [
              if (_hasValue(_data['signatoryName']))
                _buildInfoRow('Signatory Name', _data['signatoryName']),
              if (_hasValue(_data['signatoryDesignation']))
                _buildInfoRow('Designation', _data['signatoryDesignation']),
              if (_hasValue(_data['declarationDate']))
                _buildInfoRow('Date', _data['declarationDate']),
              _buildStatusRow('Accepted', _data['declarationAccepted'] == true),
            ],
          ),
          // Digital Signature Tile
          if (_data['hasDigitalSignature'] == true ||
              (_data['digitalSignature'] != null && _data['digitalSignature'] > 0))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildDigitalSignatureTile(),
            ),
          // Uploaded Signature File
          if (_data['signatureFile'] != null &&
              _data['signatureFile']['uploaded'] == true)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildSignatureFileTile(_data['signatureFile']),
            ),
        ],
      ),
    );
  }

  // Beautiful Glass Card Design
  Widget _buildGlassCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final filteredChildren = children.where((child) {
      if (child is SizedBox) return true;
      return child is Widget;
    }).toList();

    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: primaryColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  // Info Row with proper formatting
  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue;

    if (label.contains('Year') ||
        label.contains('Rooms') ||
        label.contains('Units') ||
        label.contains('Occupancy')) {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Tariff')) {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Time')) {
      displayValue = _formatTime(value.toString());
    } else {
      displayValue = value.toString();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Price Row with Special Styling
  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: mediumText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '₹${_formatPrice(value)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Status Row
  Widget _buildStatusRow(String label, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: value ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? primaryColor.withOpacity(0.2) : borderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: value ? primaryColor : lightText,
                ),
                const SizedBox(width: 6),
                Text(
                  value ? 'Yes' : 'No',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Account Type Row
  Widget _buildAccountTypeRow(dynamic accountType) {
    if (!_hasValue(accountType)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                accountType.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Compliance Certificates
  Widget _buildComplianceCertificates() {
    final List<String> certificates = [];

    if (_data['fireSafetyNoc'] == true) certificates.add('Fire Safety & Disaster NOC');
    if (_data['environmentalCert'] == true) certificates.add('Environmental Certification');
    if (_data['internationalCert'] == true) certificates.add('International Certification');

    if (certificates.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compliance Certificates',
            style: TextStyle(
              fontSize: 13,
              color: lightText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: certificates.map((cert) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 12, color: primaryColor),
                  const SizedBox(width: 4),
                  Text(
                    cert,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // Room Types
  List<Widget> _buildRoomTypes() {
    List<Widget> widgets = [];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (selectedRoomTypes is Map) {
      final selected = selectedRoomTypes.entries
          .where((e) => e.value == true)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selected
                  .map(
                    (type) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, royalPurple],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        6,
                            (index) => const Icon(
                          Icons.star,
                          size: 8,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        type.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // Room Details
  List<Widget> _buildRoomDetails() {
    List<Widget> widgets = [];
    final roomDetails = _data['roomDetails'];
    final selectedRoomTypes = _data['selectedRoomTypes'];

    if (roomDetails is Map && selectedRoomTypes is Map) {
      selectedRoomTypes.forEach((type, isSelected) {
        if (isSelected == true && roomDetails.containsKey(type)) {
          final details = roomDetails[type];
          if (details is Map) {
            bool hasData =
                _hasValue(details['rooms']) ||
                    _hasValue(details['occupancy']) ||
                    _hasValue(details['minPrice']) ||
                    _hasValue(details['maxPrice']);

            if (hasData) {
              widgets.add(
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                    gradient: LinearGradient(
                      colors: [Colors.white, primaryLight.withOpacity(0.3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.villa,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              type.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: royalPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: royalPurple.withOpacity(0.3)),
                            ),
                            child: Text(
                              details['bedType']?.toString() ?? 'King',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: royalPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (_hasValue(details['rooms']))
                        _buildDetailRow('Number of Units', _formatInteger(details['rooms'])),

                      if (_hasValue(details['occupancy']))
                        _buildDetailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

                      if (_hasValue(details['minPrice']) || _hasValue(details['maxPrice']))
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: primaryColor.withOpacity(0.2)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Range',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: lightText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '₹${_formatPrice(details['minPrice'])} - ₹${_formatPrice(details['maxPrice'])}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
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
        }
      });
    }
    return widgets;
  }

  // Detail Row
  Widget _buildDetailRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: lightText)),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // Amenity Card
  Widget _buildAmenityCard(String title, dynamic amenities) {
    if (amenities is! Map) return const SizedBox.shrink();

    final selected = amenities.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.star, size: 16, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected
                .map(
                  (item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor.withOpacity(0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12, color: primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  // Uploaded Documents
  List<Widget> _buildUploadedDocuments() {
    List<Widget> widgets = [];
    final uploadedFiles = _data['uploadedFiles'];

    if (uploadedFiles is Map) {
      uploadedFiles.forEach((key, value) {
        // Skip digital signature as it's handled separately
        if (key == 'Digital Signature') return;

        if (value is Map && value['uploaded'] == true) {
          widgets.add(
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value['name'] ?? 'Uploaded successfully',
                          style: TextStyle(fontSize: 11, color: lightText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }

    return widgets;
  }

  // Photo Tile
  Widget _buildPhotoTile(Map<String, dynamic> photoInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, royalPurple],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  photoInfo['name'] ?? 'Uploaded successfully',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Digital Signature Tile
  Widget _buildDigitalSignatureTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: royalPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: royalPurple.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.draw, size: 20, color: royalPurple),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Digital Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text('Saved successfully', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  // Signature File Tile
  Widget _buildSignatureFileTile(Map<String, dynamic> signatureInfo) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.note_alt_outlined, size: 20, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uploaded Signature',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  signatureInfo['name'] ?? 'Signature uploaded',
                  style: TextStyle(fontSize: 12, color: lightText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check_circle, size: 18, color: primaryColor),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }
}

class HotelListScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userEmail;

  const HotelListScreen({
    Key? key,
    required this.userData,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _registeredHotels = [];
  bool _isLoading = true;

  final Color primaryColor = const Color(0xFFFF5F6D);
  final Color accentColor = const Color(0xFF8B5CF6);
  final Color successColor = const Color(0xFF10B981);
  final Color warningColor = const Color(0xFFF59E0B);
  final Color darkText = const Color(0xFF1F2937);
  final Color lightText = const Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _extractHotels();
  }


  void _extractHotels() {
    setState(() => _isLoading = true);

    try {
      print('=== EXTRACTING HOTELS ===');
      print('User data keys: ${widget.userData.keys.toList()}');

      _registeredHotels.clear();

      // Check for hotels list (multiple hotels)
      if (widget.userData.containsKey('hotels') &&
          widget.userData['hotels'] is List) {
        List<dynamic> hotelsList = widget.userData['hotels'] as List;
        print('Found hotels list with ${hotelsList.length} hotels');

        for (var hotel in hotelsList) {
          if (hotel is Map) {
            Map<String, dynamic> hotelMap = Map<String, dynamic>.from(hotel);

            String hotelName =
                hotelMap['hotelName']?.toString() ??
                hotelMap['businessName']?.toString() ??
                'Unknown Hotel';

            String hotelCategory =
                hotelMap['hotelCategory']?.toString() ??
                hotelMap['hotelType']?.toString() ??
                'Normal Hotel';

            print('Adding hotel: $hotelName ($hotelCategory)');

            _registeredHotels.add({
              'id':
                  hotelMap['id'] ??
                  'HOTEL_${DateTime.now().millisecondsSinceEpoch}',
              'name': hotelName,
              'category': hotelCategory,
              'type': hotelMap['hotelType']?.toString() ?? 'Hotel',
              'data': hotelMap,
              'registrationDate':
                  hotelMap['registeredAt']?.toString() ??
                  DateTime.now().toIso8601String(),
            });
          }
        }
      }

      // If no hotels list, check for single hotel data
      if (_registeredHotels.isEmpty) {
        if (widget.userData.containsKey('hotelName') &&
            widget.userData['hotelName'] != null &&
            widget.userData['hotelName'].toString().isNotEmpty) {
          print(
            'Found single hotel with name: ${widget.userData['hotelName']}',
          );

          String hotelCategory =
              widget.userData['hotelCategory']?.toString() ??
              widget.userData['hotelType']?.toString() ??
              'Normal Hotel';

          _registeredHotels.add({
            'id':
                widget.userData['id'] ??
                'HOTEL_${DateTime.now().millisecondsSinceEpoch}',
            'name': widget.userData['hotelName'].toString(),
            'category': hotelCategory,
            'type': widget.userData['hotelType']?.toString() ?? 'Hotel',
            'data': Map<String, dynamic>.from(widget.userData),
            'registrationDate':
                widget.userData['registeredAt']?.toString() ??
                DateTime.now().toIso8601String(),
          });
        }
      }

      print('Total hotels extracted: ${_registeredHotels.length}');
    } catch (e) {
      print('Error extracting hotels: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _generateHotelId(Map<String, dynamic> hotelData) {
    final name = hotelData['hotelName']?.toString() ?? 'HTL';
    final prefix = name.length >= 3
        ? name.substring(0, 3).toUpperCase()
        : name.toUpperCase();
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(8);
    return '$prefix-$timestamp';
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '2-Star':
        return const Color(0xFF6B8E23);
      case '3-Star':
        return const Color(0xFFDAA520);
      case '4-Star':
        return const Color(0xFF4F46E5);
      case '5-Star':
        return const Color(0xFFFB717D);
      case '6-Star Ultra-Luxury':
        return const Color(0xFFD4AF37);
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('HotelListScreen building with ${_registeredHotels.length} hotels');
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF1F2937),
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Hotels List',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          // New Register Button inside Hotel List
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('New Register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _registeredHotels.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(13),
              itemCount: _registeredHotels.length,
              itemBuilder: (context, index) {
                final hotel = _registeredHotels[index];
                return _buildHotelCard(hotel);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.hotel,
              size: 50,
              color: primaryColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Hotels Registered',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Register your first hotel to get started',
            style: TextStyle(fontSize: 14, color: lightText),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Register Hotel'),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    final category = hotel['category'] as String;
    final categoryColor = _getCategoryColor(category);

    return GestureDetector(

      onTap: () {
        if (category == '2-Star') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TwoStarHotelDetailsScreen(registrationData: hotel['data']),
            ),
          );
        } else if (category == '3-Star') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ThreeStarHotelDetailsScreen(registrationData: hotel['data']),
            ),
          );
        } else if (category == '4-Star') {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FourStarHotelDetailsScreen(
                registrationData: hotel['data'],
              ),
            ),
          );
        }  else if (category == '5-Star') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FiveStarHotelDetailsScreen(registrationData: hotel['data']),
            ),
          );
        } else if (category == '6-Star') {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         FiveStarHotelDetailsScreen(registrationData: hotel['data']),
          //   ),
          // );
        } else {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelRegistrationDetailsScreen(
                registrationData: hotel['data'],
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [categoryColor, categoryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(Icons.hotel, color: Colors.white, size: 30),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hotel['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: categoryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (category.contains('Star'))
                              ...List.generate(
                                _getStarCount(category),
                                (index) => Icon(
                                  Icons.star,
                                  size: 10,
                                  color: categoryColor,
                                ),
                              ),
                            if (!category.contains('Star'))
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: categoryColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hotel['type'],
                    style: TextStyle(fontSize: 13, color: lightText),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'ID: ${hotel['id']}',
                          style: TextStyle(
                            fontSize: 10,
                            color: lightText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.calendar_today, size: 12, color: lightText),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(hotel['registrationDate']),
                        style: TextStyle(fontSize: 10, color: lightText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: categoryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getStarCount(String category) {
    if (category.contains('2')) return 2;
    if (category.contains('3')) return 3;
    if (category.contains('4')) return 4;
    if (category.contains('5')) return 5;
    if (category.contains('6')) return 6;
    return 0;
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

class PropertiesScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userEmail;

  const PropertiesScreen({
    Key? key,
    required this.userData,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> _userData = {};
  Map<String, bool> _registeredProperties = {};
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final Color primaryRed = const Color(0xFFFF5F6D);
  final Color primaryOrange = const Color(0xFFFFC371);
  final Color lightText = const Color(0xFF6B7280);
  final Color bgColor = const Color(0xFFF8FAFF);

  @override
  void initState() {
    super.initState();
    print(
      'PropertiesScreen initState - received userData keys: ${widget.userData.keys.toList()}',
    );
    print(
      'PropertiesScreen initState - propertyType: ${widget.userData['propertyType']}',
    );


    _userData = Map<String, dynamic>.from(widget.userData);


    if (_userData.containsKey('hotelName') &&
        _userData['hotelName'] != null &&
        _userData['hotelName'].toString().isNotEmpty) {
      _userData['propertyType'] = 'hotel';
      print('Forced propertyType to hotel based on hotelName');
    }

    _checkRegisteredProperties();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkRegisteredProperties() {
    print('=== CHECKING REGISTERED PROPERTIES IN PropertiesScreen ===');
    print('User data keys: ${_userData.keys.toList()}');
    print('propertyType value: ${_userData['propertyType']}');

    bool isHotelRegistered = false;
    bool isVillaRegistered = false;
    bool isApartmentRegistered = false;
    bool isResortRegistered = false;

    // CRITICAL FIX: Only mark hotel as registered if there's ACTUAL hotel data
    // Check for hotel registration data - not just propertyType

    // Check if there's actual hotel data in the user object
    if (_userData.containsKey('hotelName') &&
        _userData['hotelName'] != null &&
        _userData['hotelName'].toString().isNotEmpty) {
      isHotelRegistered = true;
      print('Found hotelName: ${_userData['hotelName']}');
    }

    if (_userData.containsKey('hotels') &&
        _userData['hotels'] is List &&
        (_userData['hotels'] as List).isNotEmpty) {
      isHotelRegistered = true;
      print(
        'Found hotels list with ${(_userData['hotels'] as List).length} hotels',
      );
    }

    // Check for hotel-specific fields
    if (_userData.containsKey('totalRooms') ||
        _userData.containsKey('roomDetails') ||
        _userData.containsKey('selectedRoomTypes') ||
        _userData.containsKey('basicAmenities')) {
      isHotelRegistered = true;
      print('Found hotel-specific fields');
    }

    // Check registrationData if it exists
    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      final regData = _userData['registrationData'] as Map;
      if (regData.containsKey('hotelName') &&
          regData['hotelName']?.toString().isNotEmpty == true) {
        isHotelRegistered = true;
        print('Found hotel in registrationData');
      }
    }

    // DO NOT use propertyType alone to determine registration
    // Only use propertyType if there's also corresponding data
    if (_userData.containsKey('propertyType') &&
        _userData['propertyType'] != null) {
      String propertyType = _userData['propertyType'].toString().toLowerCase();

      // Only trust propertyType if there's actual data to back it up
      if (propertyType == 'hotel' && isHotelRegistered) {
        print('propertyType matches hotel data');
      } else if (propertyType == 'hotel' && !isHotelRegistered) {
        // This is the bug - propertyType says hotel but no data
        print(
          'WARNING: propertyType is hotel but no hotel data found - ignoring',
        );
        // Do NOT set isHotelRegistered based on propertyType alone
      }
    }

    setState(() {
      _registeredProperties = {
        'hotel': isHotelRegistered,
        'villa': isVillaRegistered,
        'apartment': isApartmentRegistered,
        'resort': isResortRegistered,
      };
    });

    print(
      'PropertiesScreen registered properties result: $_registeredProperties',
    );
  }

  void _navigateToPropertyDetails(String propertyType) {
    if (!_registeredProperties[propertyType]!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have not registered for $propertyType yet'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // For hotel, navigate to the list screen
    if (propertyType == 'hotel') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HotelListScreen(userData: _userData, userEmail: widget.userEmail),
        ),
      );
      return;
    }

    // For other property types, extract the data
    Map<String, dynamic> propertyData = {};

    if (_userData.containsKey('registrationData') &&
        _userData['registrationData'] != null) {
      propertyData = Map<String, dynamic>.from(_userData['registrationData']);
    } else {
      propertyData = Map<String, dynamic>.from(_userData);
    }

    Widget screen;
    switch (propertyType) {
      case 'villa':
        screen = VillaRegistrationDetailsScreen(registrationData: propertyData);
        break;
      case 'apartment':
        screen = ApartmentRegistrationDetailsScreen(
          registrationData: propertyData,
        );
        break;
      case 'resort':
        screen = ResortRegistrationDetailsScreen(
          registrationData: propertyData,
        );
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  int _getRegisteredCount() {
    return _registeredProperties.values.where((value) => value).length;
  }

  String _getUserFullName() {
    print('Getting full name from: ${_userData.keys}');

    if (_userData.containsKey('fullName') &&
        _userData['fullName'] != null &&
        _userData['fullName'].toString().isNotEmpty) {
      return _userData['fullName'].toString();
    }
    if (_userData.containsKey('ownerName') &&
        _userData['ownerName'] != null &&
        _userData['ownerName'].toString().isNotEmpty) {
      return _userData['ownerName'].toString();
    }
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName') &&
          basicInfo['ownerName'].toString().isNotEmpty) {
        return basicInfo['ownerName'].toString();
      }
    }
    return 'User';
  }

  String _getUserEmail() {
    print('Getting email from: ${_userData.keys}');

    if (_userData.containsKey('email') &&
        _userData['email'] != null &&
        _userData['email'].toString().isNotEmpty) {
      return _userData['email'].toString();
    }
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('email') &&
          basicInfo['email'].toString().isNotEmpty) {
        return basicInfo['email'].toString();
      }
    }
    return widget.userEmail;
  }

  String _getUserPhone() {
    print('Getting phone from: ${_userData.keys}');

    if (_userData.containsKey('phone') &&
        _userData['phone'] != null &&
        _userData['phone'].toString().isNotEmpty) {
      return _userData['phone'].toString();
    }
    if (_userData.containsKey('mobileNumber') &&
        _userData['mobileNumber'] != null &&
        _userData['mobileNumber'].toString().isNotEmpty) {
      return _userData['mobileNumber'].toString();
    }
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('mobile') &&
          basicInfo['mobile'].toString().isNotEmpty) {
        return basicInfo['mobile'].toString();
      }
    }
    return 'Not provided';
  }

  String _getRegisteredPropertyType() {
    if (_userData.containsKey('propertyType') &&
        _userData['propertyType'] != null) {
      return _userData['propertyType'].toString();
    }
    if (_userData.containsKey('hotelName')) return 'hotel';
    if (_userData.containsKey('villaName')) return 'villa';
    if (_userData.containsKey('apartmentName')) return 'apartment';
    if (_userData.containsKey('resortName')) return 'resort';
    if (_userData.containsKey('basicInfo') && _userData['basicInfo'] != null) {
      final basicInfo = _userData['basicInfo'] as Map;
      if (basicInfo.containsKey('hotelName')) return 'hotel';
      if (basicInfo.containsKey('villaName')) return 'villa';
      if (basicInfo.containsKey('apartmentName')) return 'apartment';
      if (basicInfo.containsKey('resortName')) return 'resort';
    }
    return 'none';
  }

  String _getBusinessName() {
    if (_userData.containsKey('businessName') &&
        _userData['businessName'] != null &&
        _userData['businessName'].toString().isNotEmpty) {
      return _userData['businessName'].toString();
    }
    if (_userData.containsKey('hotelName') &&
        _userData['hotelName'] != null &&
        _userData['hotelName'].toString().isNotEmpty) {
      return _userData['hotelName'].toString();
    }
    if (_userData.containsKey('villaName') &&
        _userData['villaName'] != null &&
        _userData['villaName'].toString().isNotEmpty) {
      return _userData['villaName'].toString();
    }
    if (_userData.containsKey('apartmentName') &&
        _userData['apartmentName'] != null &&
        _userData['apartmentName'].toString().isNotEmpty) {
      return _userData['apartmentName'].toString();
    }
    if (_userData.containsKey('resortName') &&
        _userData['resortName'] != null &&
        _userData['resortName'].toString().isNotEmpty) {
      return _userData['resortName'].toString();
    }
    return 'Not specified';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_getRegisteredCount()}/4',
                  style: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Details Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile Header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getUserFullName(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getUserEmail(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Personal Details Summary
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personal Details',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem(
                                    icon: Icons.phone,
                                    label: 'Phone',
                                    value: _getUserPhone(),
                                  ),
                                ),
                                Expanded(
                                  child: _buildDetailItem(
                                    icon: Icons.email,
                                    label: 'Email',
                                    value: _getUserEmail(),
                                  ),
                                ),
                              ],
                            ),
                            if (_getRegisteredPropertyType() != 'none')
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: _buildDetailItem(
                                  icon: Icons.business,
                                  label: 'Registered As',
                                  value: _getRegisteredPropertyType()
                                      .toUpperCase(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section Header
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Available Properties',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Select a property to view details',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // 4 Property Boxes Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildPropertyBox(
                    propertyType: 'Hotel',
                    icon: Icons.hotel,
                    color: Colors.blue,
                    isRegistered: _registeredProperties['hotel'] ?? false,
                  ),
                  _buildPropertyBox(
                    propertyType: 'Villa',
                    icon: Icons.villa,
                    color: Colors.green,
                    isRegistered: _registeredProperties['villa'] ?? false,
                  ),
                  _buildPropertyBox(
                    propertyType: 'Apartment',
                    icon: Icons.apartment,
                    color: Colors.orange,
                    isRegistered: _registeredProperties['apartment'] ?? false,
                  ),
                  _buildPropertyBox(
                    propertyType: 'Resort',
                    icon: Icons.beach_access,
                    color: Colors.purple,
                    isRegistered: _registeredProperties['resort'] ?? false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyBox({
    required String propertyType,
    required IconData icon,
    required Color color,
    required bool isRegistered,
  }) {
    return GestureDetector(
      onTap: isRegistered
          ? () => _navigateToPropertyDetails(propertyType.toLowerCase())
          : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              isRegistered ? color.withOpacity(0.05) : Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isRegistered ? color.withOpacity(0.3) : Colors.grey.shade300,
            width: isRegistered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isRegistered
                  ? color.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned(
              bottom: -10,
              right: -10,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  icon,
                  size: 80,
                  color: isRegistered ? color : Colors.grey,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isRegistered
                          ? color.withOpacity(0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: isRegistered ? color : Colors.grey.shade500,
                      size: 28,
                    ),
                  ),

                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        propertyType,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: isRegistered ? color : Colors.grey.shade500,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isRegistered
                              ? color.withOpacity(0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isRegistered
                                  ? Icons.check_circle
                                  : Icons.lock_outline,
                              size: 12,
                              color: isRegistered
                                  ? color
                                  : Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isRegistered ? 'Registered' : 'Not Registered',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isRegistered
                                    ? color
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

