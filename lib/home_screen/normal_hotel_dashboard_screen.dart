// normal_hotel_dashboard.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:typed_data';


class NormalHotelDashboard extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  final String hotelName;
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String addressLine1;
  final String city;
  final String state;
  final String pinCode;
  final int totalRooms;
  final String hotelType;
  final Map<String, bool> selectedRoomTypes;
  final Map<String, Map<String, dynamic>> roomDetails;
  final Map<String, bool> basicAmenities;
  final Map<String, bool> hotelFacilities;
  final Map<String, bool> foodServices;
  final Map<String, bool> additionalAmenities;
  final List<String> customAmenities;
  final Map<String, Map<String, dynamic>> uploadedFiles;
  final Map<String, dynamic> personPhotoInfo;
  final Uint8List? digitalSignatureImage;

  const NormalHotelDashboard({
    Key? key,
    required this.registrationData,
    required this.hotelName,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.totalRooms,
    required this.hotelType,
    required this.selectedRoomTypes,
    required this.roomDetails,
    required this.basicAmenities,
    required this.hotelFacilities,
    required this.foodServices,
    required this.additionalAmenities,
    required this.customAmenities,
    required this.uploadedFiles,
    required this.personPhotoInfo,
    this.digitalSignatureImage,
  }) : super(key: key);

  @override
  State<NormalHotelDashboard> createState() => _NormalHotelDashboardState();
}

class _NormalHotelDashboardState extends State<NormalHotelDashboard> {
  final Color _primaryColor = const Color(0xFFFF5F6D);
  final Color _primaryLight = const Color(0xFFEEF2FF);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _textPrimary = const Color(0xFF111827);
  final Color _textSecondary = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _borderColor = const Color(0xFFE5E7EB);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryColor, _primaryColor.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.hotel, color: Colors.white, size: 22),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                    ),
                  ),
                  Text(
                    widget.ownerName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: _textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: _textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NormalHotelProfileScreen(
                    registrationData: widget.registrationData,
                    hotelName: widget.hotelName,
                    ownerName: widget.ownerName,
                    mobileNumber: widget.mobileNumber,
                    email: widget.email,
                    addressLine1: widget.addressLine1,
                    city: widget.city,
                    state: widget.state,
                    pinCode: widget.pinCode,
                    totalRooms: widget.totalRooms,
                    hotelType: widget.hotelType,
                    selectedRoomTypes: widget.selectedRoomTypes,
                    roomDetails: widget.roomDetails,
                    basicAmenities: widget.basicAmenities,
                    hotelFacilities: widget.hotelFacilities,
                    foodServices: widget.foodServices,
                    additionalAmenities: widget.additionalAmenities,
                    customAmenities: widget.customAmenities,
                    uploadedFiles: widget.uploadedFiles,
                    personPhotoInfo: widget.personPhotoInfo,
                    digitalSignatureImage: widget.digitalSignatureImage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildDashboardContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 20),
          _buildStatsCards(),
          const SizedBox(height: 20),
          _buildQuickActions(),
          const SizedBox(height: 20),
          _buildRecentBookings(),
          const SizedBox(height: 20),
          _buildHotelInfoCard(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hotelName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.addressLine1,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      widget.hotelType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.meeting_room, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.totalRooms} Rooms',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Bookings',
            value: '24',
            icon: Icons.book_online,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Revenue',
            value: '₹45,200',
            icon: Icons.currency_rupee,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Rating',
            value: '4.5 ★',
            icon: Icons.star,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: _textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.calendar_today,
                label: 'Bookings',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildActionButton(
                icon: Icons.edit_note,
                label: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NormalHotelProfileScreen(
                        registrationData: widget.registrationData,
                        hotelName: widget.hotelName,
                        ownerName: widget.ownerName,
                        mobileNumber: widget.mobileNumber,
                        email: widget.email,
                        addressLine1: widget.addressLine1,
                        city: widget.city,
                        state: widget.state,
                        pinCode: widget.pinCode,
                        totalRooms: widget.totalRooms,
                        hotelType: widget.hotelType,
                        selectedRoomTypes: widget.selectedRoomTypes,
                        roomDetails: widget.roomDetails,
                        basicAmenities: widget.basicAmenities,
                        hotelFacilities: widget.hotelFacilities,
                        foodServices: widget.foodServices,
                        additionalAmenities: widget.additionalAmenities,
                        customAmenities: widget.customAmenities,
                        uploadedFiles: widget.uploadedFiles,
                        personPhotoInfo: widget.personPhotoInfo,
                        digitalSignatureImage: widget.digitalSignatureImage,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildActionButton(
                icon: Icons.analytics,
                label: 'Analytics',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: _primaryColor, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBookings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Bookings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(color: _primaryColor, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Guest ${index + 1}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Deluxe Room • 2 Nights',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Confirmed',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _successColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHotelInfoCard() {
    int selectedRoomCount = widget.selectedRoomTypes.entries
        .where((e) => e.value)
        .length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: _primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Hotel Information',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            'Hotel Name',
            widget.hotelName,
          ),
          _buildInfoItem(
            'Room Types',
            '$selectedRoomCount types available',
          ),
          _buildInfoItem(
            'Total Rooms',
            '${widget.totalRooms} rooms',
          ),
          _buildInfoItem(
            'Contact',
            '${widget.mobileNumber} • ${widget.email}',
          ),
          _buildInfoItem(
            'Location',
            '${widget.city}, ${widget.state} - ${widget.pinCode}',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: _textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _primaryColor,
        unselectedItemColor: _textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service_outlined),
            activeIcon: Icon(Icons.room_service),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}









class NormalHotelProfileScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  final String hotelName;
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String addressLine1;
  final String city;
  final String state;
  final String pinCode;
  final int totalRooms;
  final String hotelType;
  final Map<String, bool> selectedRoomTypes;
  final Map<String, Map<String, dynamic>> roomDetails;
  final Map<String, bool> basicAmenities;
  final Map<String, bool> hotelFacilities;
  final Map<String, bool> foodServices;
  final Map<String, bool> additionalAmenities;
  final List<String> customAmenities;
  final Map<String, Map<String, dynamic>> uploadedFiles;
  final Map<String, dynamic> personPhotoInfo;
  final Uint8List? digitalSignatureImage;

  const NormalHotelProfileScreen({
    Key? key,
    required this.registrationData,
    required this.hotelName,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.totalRooms,
    required this.hotelType,
    required this.selectedRoomTypes,
    required this.roomDetails,
    required this.basicAmenities,
    required this.hotelFacilities,
    required this.foodServices,
    required this.additionalAmenities,
    required this.customAmenities,
    required this.uploadedFiles,
    required this.personPhotoInfo,
    this.digitalSignatureImage,
  }) : super(key: key);

  @override
  State<NormalHotelProfileScreen> createState() => _NormalHotelProfileScreenState();
}

class _NormalHotelProfileScreenState extends State<NormalHotelProfileScreen> {
  final Color _primaryColor = const Color(0xFFFF5F6D);
  final Color _primaryLight = const Color(0xFFEEF2FF);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _textPrimary = const Color(0xFF111827);
  final Color _textSecondary = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _borderColor = const Color(0xFFE5E7EB);

  bool _isEditing = false;

  // Controllers for editable fields
  late TextEditingController _hotelNameController;
  late TextEditingController _ownerNameController;
  late TextEditingController _mobileController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _hotelNameController = TextEditingController(text: widget.hotelName);
    _ownerNameController = TextEditingController(text: widget.ownerName);
    _mobileController = TextEditingController(text: widget.mobileNumber);
    _emailController = TextEditingController(text: widget.email);
    _addressController = TextEditingController(text: widget.addressLine1);
    _cityController = TextEditingController(text: widget.city);
    _stateController = TextEditingController(text: widget.state);
    _pinController = TextEditingController(text: widget.pinCode);
  }

  @override
  void dispose() {
    _hotelNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Hotel Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _saveChanges();
                }
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? 'Save' : 'Edit',
              style: TextStyle(
                color: _isEditing ? _successColor : _primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 16),
            _buildHotelInformation(),
            const SizedBox(height: 16),
            _buildContactInformation(),
            const SizedBox(height: 16),
            _buildAddressInformation(),
            const SizedBox(height: 16),
            _buildRoomConfiguration(),
            const SizedBox(height: 16),
            _buildAmenitiesSection(),
            const SizedBox(height: 16),
            _buildLegalDocuments(),
            const SizedBox(height: 16),
            _buildBankDetails(),
            const SizedBox(height: 16),
            _buildUploadedDocuments(),
            const SizedBox(height: 16),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _primaryColor.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget.personPhotoInfo['uploaded'] == true &&
                widget.personPhotoInfo['path'] != null &&
                widget.personPhotoInfo['path'].isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(widget.personPhotoInfo['path']),
                fit: BoxFit.cover,
              ),
            )
                : Center(
              child: Text(
                widget.hotelName.isNotEmpty
                    ? widget.hotelName[0].toUpperCase()
                    : 'H',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isEditing
                    ? TextFormField(
                  controller: _hotelNameController,
                  decoration: InputDecoration(
                    hintText: 'Hotel Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                )
                    : Text(
                  widget.hotelName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.hotelType,
                        style: TextStyle(
                          fontSize: 11,
                          color: _primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.totalRooms} Rooms',
                        style: TextStyle(
                          fontSize: 11,
                          color: _primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelInformation() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _buildInfoRow('Hotel Name', widget.hotelName),
        _buildInfoRow('Hotel Type', widget.hotelType),
        _buildInfoRow('Total Rooms', '${widget.totalRooms}'),
      ],
    );
  }

  Widget _buildContactInformation() {
    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: [
        _buildInfoRow('Owner/Manager', widget.ownerName),
        _buildInfoRow('Mobile Number', widget.mobileNumber),
        _buildInfoRow('Email', widget.email),
        if (widget.registrationData['alternateContact'] != null &&
            widget.registrationData['alternateContact'].toString().isNotEmpty)
          _buildInfoRow(
              'Alternate Contact', widget.registrationData['alternateContact']),
        if (widget.registrationData['website'] != null &&
            widget.registrationData['website'].toString().isNotEmpty)
          _buildInfoRow('Website', widget.registrationData['website']),
        if (widget.registrationData['landlineNumbers'] != null &&
            (widget.registrationData['landlineNumbers'] as List).isNotEmpty)
          _buildInfoRow(
              'Landline Numbers',
              (widget.registrationData['landlineNumbers'] as List)
                  .join(', ')),
      ],
    );
  }

  Widget _buildAddressInformation() {
    return _buildSectionCard(
      title: 'Address Information',
      icon: Icons.location_on,
      children: [
        _buildInfoRow('Address Line 1', widget.addressLine1),
        if (widget.registrationData['addressLine2'] != null &&
            widget.registrationData['addressLine2'].toString().isNotEmpty)
          _buildInfoRow(
              'Address Line 2', widget.registrationData['addressLine2']),
        _buildInfoRow('City', widget.city),
        _buildInfoRow('State', widget.state),
        _buildInfoRow('PIN Code', widget.pinCode),
        if (widget.registrationData['district'] != null &&
            widget.registrationData['district'].toString().isNotEmpty)
          _buildInfoRow('District', widget.registrationData['district']),
        if (widget.registrationData['landmark'] != null &&
            widget.registrationData['landmark'].toString().isNotEmpty)
          _buildInfoRow('Landmark', widget.registrationData['landmark']),
      ],
    );
  }

  Widget _buildRoomConfiguration() {
    int selectedCount = widget.selectedRoomTypes.entries
        .where((e) => e.value)
        .length;

    if (selectedCount == 0) return const SizedBox.shrink();

    List<Widget> children = [
      _buildInfoRow('Room Types Available', '$selectedCount types'),
      const SizedBox(height: 8),
    ];

    widget.selectedRoomTypes.entries
        .where((e) => e.value)
        .forEach((entry) {
      String roomType = entry.key;
      var details = widget.roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _primaryLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _primaryColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.hotel, size: 16, color: _primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (details['rooms'] != null &&
                  details['rooms'].toString().isNotEmpty)
                _buildDetailRow('Rooms', details['rooms'].toString()),
              if (details['occupancy'] != null &&
                  details['occupancy'].toString().isNotEmpty)
                _buildDetailRow('Max Occupancy', '${details['occupancy']} persons'),
              if (details['price'] != null &&
                  details['price'].toString().isNotEmpty)
                _buildDetailRow('Price/Night', '₹${details['price']}'),
              if (details['ac'] != null)
                _buildDetailRow('AC/Non-AC', details['ac'] ? 'AC' : 'Non-AC'),
              if (details['extraBed'] != null)
                _buildDetailRow('Extra Bed', details['extraBed'] ? 'Yes' : 'No'),
              if (details['extraBed'] == true &&
                  details['extraBedPrice'] != null &&
                  details['extraBedPrice'].toString().isNotEmpty)
                _buildDetailRow('Extra Bed Price', '₹${details['extraBedPrice']}'),
            ],
          ),
        ),
      );
    });

    if (widget.registrationData['minTariff'] != null &&
        widget.registrationData['maxTariff'] != null) {
      children.add(
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tariff Range',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _textSecondary,
                ),
              ),
              Text(
                '₹${widget.registrationData['minTariff']} - ₹${widget.registrationData['maxTariff']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _successColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (widget.registrationData['extraBedAvailable'] != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: _buildInfoRow(
            'Extra Bed Available Overall',
            widget.registrationData['extraBedAvailable'] ? 'Yes' : 'No',
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Room Configuration',
      icon: Icons.meeting_room,
      children: children,
    );
  }

  Widget _buildAmenitiesSection() {
    List<Widget> children = [];

    // Basic Amenities
    if (widget.basicAmenities.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Basic Amenities', widget.basicAmenities));
    }

    // Hotel Facilities
    if (widget.hotelFacilities.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Hotel Facilities', widget.hotelFacilities));
    }

    // Food Services
    if (widget.foodServices.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Food Services', widget.foodServices));
    }

    // Additional Amenities
    if (widget.additionalAmenities.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Additional Amenities', widget.additionalAmenities));
    }

    // Custom Amenities
    if (widget.customAmenities.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Amenities',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.customAmenities.map((amenity) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    amenity,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Amenities',
      icon: Icons.workspaces_filled,
      children: children,
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    List<String> selected = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selected.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _primaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 12, color: _primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 11,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalDocuments() {
    List<Widget> children = [];

    if (widget.registrationData['gstNumber'] != null &&
        widget.registrationData['gstNumber'].toString().isNotEmpty) {
      children.add(_buildInfoRow('GST Number', widget.registrationData['gstNumber']));
    }

    if (widget.registrationData['fssaiLicense'] != null &&
        widget.registrationData['fssaiLicense'].toString().isNotEmpty) {
      children.add(_buildInfoRow('FSSAI License', widget.registrationData['fssaiLicense']));
    }

    if (widget.registrationData['tradeLicense'] != null &&
        widget.registrationData['tradeLicense'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Trade License', widget.registrationData['tradeLicense']));
    }

    if (widget.registrationData['aadharNumber'] != null &&
        widget.registrationData['aadharNumber'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Aadhar Number', widget.registrationData['aadharNumber']));
    }

    if (widget.registrationData['panNumber'] != null &&
        widget.registrationData['panNumber'].toString().isNotEmpty) {
      children.add(_buildInfoRow('PAN Number', widget.registrationData['panNumber']));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal Details',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    List<Widget> children = [];

    if (widget.registrationData['accountHolderName'] != null &&
        widget.registrationData['accountHolderName'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Account Holder', widget.registrationData['accountHolderName']));
    }

    if (widget.registrationData['bankName'] != null &&
        widget.registrationData['bankName'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Bank Name', widget.registrationData['bankName']));
    }

    if (widget.registrationData['accountNumber'] != null &&
        widget.registrationData['accountNumber'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Account Number', _maskAccountNumber(
          widget.registrationData['accountNumber'].toString())));
    }

    if (widget.registrationData['ifscCode'] != null &&
        widget.registrationData['ifscCode'].toString().isNotEmpty) {
      children.add(_buildInfoRow('IFSC Code', widget.registrationData['ifscCode']));
    }

    if (widget.registrationData['branch'] != null &&
        widget.registrationData['branch'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Branch', widget.registrationData['branch']));
    }

    if (widget.registrationData['accountType'] != null &&
        widget.registrationData['accountType'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Account Type', widget.registrationData['accountType']));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildUploadedDocuments() {
    List<Widget> children = [];

    widget.uploadedFiles.forEach((key, value) {
      if (value['uploaded'] == true && value['name'] != null) {
        children.add(
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _successColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  _getDocumentIcon(key),
                  size: 18,
                  color: _successColor,
                ),
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
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value['name'],
                        style: TextStyle(
                          fontSize: 11,
                          color: _textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 16, color: _successColor),
              ],
            ),
          ),
        );
      }
    });

    if (widget.digitalSignatureImage != null) {
      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.draw, size: 16, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 16, color: _successColor),
            ],
          ),
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDeclarationSection() {
    List<Widget> children = [];

    if (widget.registrationData['declarationName'] != null &&
        widget.registrationData['declarationName'].toString().isNotEmpty) {
      children.add(_buildInfoRow('Declared By', widget.registrationData['declarationName']));
    }

    if (widget.registrationData['declarationDate'] != null) {
      String dateStr = widget.registrationData['declarationDate'].toString();
      try {
        DateTime date = DateTime.parse(dateStr);
        dateStr = '${date.day}/${date.month}/${date.year}';
      } catch (e) {}
      children.add(_buildInfoRow('Declaration Date', dateStr));
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _successColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _successColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: _successColor, size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Declaration Accepted',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return _buildSectionCard(
      title: 'Declaration',
      icon: Icons.verified_user,
      children: children,
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: _textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: _textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDocumentIcon(String docName) {
    if (docName.contains('Signature')) return Icons.draw;
    if (docName.contains('GST')) return Icons.receipt;
    if (docName.contains('FSSAI')) return Icons.restaurant;
    if (docName.contains('License')) return Icons.badge;
    if (docName.contains('Cheque')) return Icons.account_balance;
    if (docName.contains('Photos')) return Icons.photo_library;
    if (docName.contains('Proof')) return Icons.perm_identity;
    return Icons.description;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  void _saveChanges() {
    // Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Changes saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}