import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import '../login_screen/forget_password.dart';
import '../login_screen/login_screen.dart';
import '../onboarding_screen/choose_role_screen.dart';
import '../services/api_service.dart';

class HotelRegistrationScreen extends StatefulWidget {
  final String? propertyType; // Hotel, Villa, Apartment, Resort
  
  const HotelRegistrationScreen({super.key, this.propertyType});

  @override
  State<HotelRegistrationScreen> createState() =>
      _HotelRegistrationScreenState();
}

class _HotelRegistrationScreenState extends State<HotelRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final Color _primaryColor = Color(0xFFFF5F6D);
  final Color _primaryLight = Color(0xFFEEF2FF);
  final Color _bgColor = Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _textPrimary = Color(0xFF111827);
  final Color _textSecondary = Color(0xFF6B7280);
  final Color _successColor = Color(0xFFFB717D);

  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _altMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _minTariffController = TextEditingController();
  final TextEditingController _maxTariffController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _fssaiController = TextEditingController();
  final TextEditingController _tradeLicenseController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _signatureNameController =
      TextEditingController();
  final TextEditingController _declarationNameController =
      TextEditingController();
  final TextEditingController _extraAmenitiesController =
      TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();

  List<TextEditingController> _landlineControllers = [TextEditingController()];

  // Validation state for Basic Details (Step 1)
  Map<String, String> _fieldErrors = {};
  Map<String, String> _fieldRules = {
    'hotelName': 'Hotel name must be 2-150 characters',
    'hotelType': 'Please select a hotel type',
    'year': 'Year must be between 1800 and current year (YYYY format)',
    'rooms': 'Total rooms must be a positive number (1-10000)',
    'ownerName': 'Owner name must be 2-100 characters (letters, spaces, dots, apostrophes, hyphens)',
    'mobile': 'Mobile number must be 10 digits (Indian format) or international format with country code',
    'email': 'Email must be a valid email address (e.g., user@example.com)',
    'website': 'Website must be a valid URL (e.g., https://example.com)',
  };

  Map<String, dynamic> _personPhotoInfo = {
    'name': '',
    'size': 0,
    'path': '',
    'uploaded': false,
  };

  final Map<String, Map<String, dynamic>> _roomDetails = {
    'Single Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
    'Double Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
    'Deluxe Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
    'Suite Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
    'Family Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
    'Executive Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
      'extraBed': false,
      'extraBedPrice': '',
    },
  };

  String? _selectedHotelType;
  bool _extraBedAvailable = false;
  DateTime? _selectedDate;
  bool _declarationAccepted = false;
  String? _selectedAccountType; // For radio button selection

  Map<String, bool> _selectedRoomTypes = {
    'Single Room': false,
    'Double Room': false,
    'Deluxe Room': false,
    'Suite Room': false,
    'Family Room': false,
    'Executive Room': false,
  };

  Map<String, bool> _basicAmenities = {
    'Free Wi-Fi': false,
    'Television': false,
    'Air Conditioning': false,
    'Attached Bathroom': false,
    'Hot Water': false,
    'Room Service': false,
  };

  Map<String, bool> _hotelFacilities = {
    '24-Hour Front Desk': false,
    'Power Backup': false,
    'Lift / Elevator': false,
    'Parking Facility': false,
    'CCTV Security': false,
  };

  Map<String, bool> _foodServices = {
    'Restaurant': false,
    'Complimentary Breakfast': false,
    'In-Room Dining': false,
    'Tea / Coffee Maker': false,
  };

  Map<String, bool> _additionalAmenities = {
    'Laundry Service': false,
    'Travel Desk': false,
    'Conference / Meeting Room': false,
    'Wheelchair Access': false,
  };

  List<String> _customAmenities = [];

  Map<String, bool> _documents = {
    'GST Certificate': false,
    'FSSAI Certificate': false,
    'Trade License': false,
    'Cancelled Cheque': false,
    'Hotel Photos': false,
    'Owner ID Proof': false,
    'Signature': false,
  };

  final Map<String, Map<String, dynamic>> _uploadedFiles = {
    'GST Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'FSSAI Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Trade License': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Cancelled Cheque': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Hotel Photos': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Owner ID Proof': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Signature': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
  };

  final List<Map<String, dynamic>> _steps = [
    {'title': 'Basic Details', 'subtitle': 'Hotel information and contact'},
    {'title': 'Hotel Details', 'subtitle': 'Address and location'},
    {'title': 'Room Availability', 'subtitle': 'Room configuration and rates'},
    {'title': 'Amenities & Legal', 'subtitle': 'Facilities and compliance'},
    {'title': 'Bank & Documents', 'subtitle': 'Payment and documents'},
  ];

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
          'Hotel Vendor Registration Form',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_steps.length, (index) {
                        bool isActive = index == _currentStep;
                        bool isCompleted = index < _currentStep;

                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _navigateToStep(index);
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isActive
                                            ? _primaryColor
                                            : isCompleted
                                            ? _successColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: isActive || isCompleted
                                              ? Colors.transparent
                                              : _borderColor,
                                          width: 2,
                                        ),
                                        boxShadow: isActive || isCompleted
                                            ? [
                                                BoxShadow(
                                                  color: (isActive ? _primaryColor : _successColor)
                                                      .withOpacity(0.3),
                                                  blurRadius: 8,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Center(
                                        child: isCompleted
                                            ? Icon(
                                                Icons.check,
                                                size: 18,
                                                color: Colors.white,
                                              )
                                            : Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  color: isActive || isCompleted
                                                      ? Colors.white
                                                      : _textSecondary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: 70,
                                      child: Text(
                                        _steps[index]['title'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: isActive
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          color: isActive || isCompleted
                                              ? _textPrimary
                                              : _textSecondary,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / _steps.length,
                    backgroundColor: _borderColor,
                    color: _primaryColor,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of ${_steps.length}',
                        style: TextStyle(fontSize: 12, color: _textSecondary),
                      ),
                      Text(
                        '${((_currentStep + 1) / _steps.length * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${_currentStep + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _steps[_currentStep]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _steps[_currentStep]['subtitle'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    _buildStepContent(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == _steps.length - 1 ? 'Submit' : 'Next',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return Container();
    }
  }

  Widget _buildStep1() {
    return Column(
      children: [
        _buildCard(
          title: 'Hotel Information',
          children: [
            _buildInputField(
              label: 'Hotel Name',
              controller: _hotelNameController,
              hint: 'Enter hotel name',
              isRequired: true,
              fieldKey: 'hotelName',
              errorText: _fieldErrors['hotelName'],
              validationRule: _fieldRules['hotelName'],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Hotel Type *',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _fieldErrors.containsKey('hotelType') 
                            ? Color(0xFFFF5F6D) 
                            : _textPrimary,
                      ),
                    ),
                    if (_fieldErrors.containsKey('hotelType'))
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.error_outline,
                          size: 16,
                          color: Color(0xFFFF5F6D),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Lodge',
                    'Budget Hotel',
                    'Standard Hotel',
                    'Guest House',
                    'Heritage Hotel',
                    'Boutique Hotel',
                  ].map((type) => _buildChip(type)).toList(),
                ),
                if (_fieldErrors.containsKey('hotelType'))
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      _fieldErrors['hotelType']!,
                      style: TextStyle(
                        color: Color(0xFFFF5F6D),
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (!_fieldErrors.containsKey('hotelType'))
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      _fieldRules['hotelType'] ?? '',
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Year of Establishment',
                    controller: _yearController,
                    hint: 'YYYY',
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    fieldKey: 'year',
                    errorText: _fieldErrors['year'],
                    validationRule: _fieldRules['year'],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Total Number of Rooms',
                    controller: _roomsController,
                    hint: '0',
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    fieldKey: 'rooms',
                    errorText: _fieldErrors['rooms'],
                    validationRule: _fieldRules['rooms'],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Contact Information',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Photo',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                _buildPhotoUploadItem(),
              ],
            ),
            SizedBox(height: 16),

            _buildInputField(
              label: 'Owner / Manager Name',
              controller: _ownerNameController,
              hint: 'Enter name',
              isRequired: true,
              fieldKey: 'ownerName',
              errorText: _fieldErrors['ownerName'],
              validationRule: _fieldRules['ownerName'],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Mobile Number',
              controller: _mobileController,
              hint: 'Enter mobile number',
              keyboardType: TextInputType.phone,
              isRequired: true,
              fieldKey: 'mobile',
              errorText: _fieldErrors['mobile'],
              validationRule: _fieldRules['mobile'],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Alternate Contact',
              controller: _altMobileController,
              hint: 'Optional',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Landline Number(s)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _textPrimary,
                      ),
                    ),
                    if (_landlineControllers.length < 3)
                      TextButton(
                        onPressed: _addLandlineField,
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 16, color: _primaryColor),
                            SizedBox(width: 4),
                            Text(
                              'Add Landline',
                              style: TextStyle(
                                fontSize: 12,
                                color: _primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: _landlineControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < _landlineControllers.length - 1
                            ? 12
                            : 0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter landline number ${index + 1}',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _primaryColor),
                                ),
                              ),
                            ),
                          ),
                          if (_landlineControllers.length > 1)
                            IconButton(
                              onPressed: () => _removeLandlineField(index),
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.only(left: 8),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildInputField(
              label: 'Email ID',
              controller: _emailController,
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
              isRequired: true,
              fieldKey: 'email',
              errorText: _fieldErrors['email'],
              validationRule: _fieldRules['email'],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Website (if any)',
              controller: _websiteController,
              hint: 'https://example.com',
              fieldKey: 'website',
              errorText: _fieldErrors['website'],
              validationRule: _fieldRules['website'],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        _buildCard(
          title: 'Hotel Address',
          children: [
            _buildInputField(
              label: 'Address Line 1',
              controller: _address1Controller,
              hint: 'Street address',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Address Line 2',
              controller: _address2Controller,
              hint: 'Apartment, suite, etc.',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'City',
                    controller: _cityController,
                    hint: 'Enter city',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'District',
                    controller: _districtController,
                    hint: 'Enter district',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'State',
                    controller: _stateController,
                    hint: 'Enter state',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'PIN Code',
                    controller: _pinController,
                    hint: '6-digit PIN',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Landmark (Optional)',
              controller: _landmarkController,
              hint: 'Nearby place',
            ),
          ],
        ),
      ],
    );
  }



  Widget _buildStep3() {
    return Column(
      children: [
        _buildCard(
          title: 'Select Room Types Available',
          children: [
            Text(
              'Select the room types available in your hotel:',
              style: TextStyle(fontSize: 13, color: _textSecondary),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedRoomTypes.entries.map((entry) {
                bool isSelected = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRoomTypes[entry.key] = !isSelected;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryLight : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? _primaryColor : _borderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: 16,
                          color: isSelected ? _primaryColor : _textSecondary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 13,
                            color: isSelected ? _primaryColor : _textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Divider(color: _borderColor),
            SizedBox(height: 16),
            Text(
              'Configure selected room types:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12),
          ],
        ),

        ..._selectedRoomTypes.entries.where((entry) => entry.value).map((
          entry,
        ) {
          String roomType = entry.key;
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            child: _buildCard(
              title: '$roomType Details',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Number of Rooms',
                        controller: TextEditingController(
                          text: _roomDetails[roomType]!['rooms'],
                        ),
                        onChanged: (value) =>
                            _roomDetails[roomType]!['rooms'] = value,
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Max Occupancy',
                        controller: TextEditingController(
                          text: _roomDetails[roomType]!['occupancy'],
                        ),
                        onChanged: (value) =>
                            _roomDetails[roomType]!['occupancy'] = value,
                        hint: 'Persons',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Price per Night (₹)',
                        controller: TextEditingController(
                          text: _roomDetails[roomType]!['price'],
                        ),
                        onChanged: (value) =>
                            _roomDetails[roomType]!['price'] = value,
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AC / Non-AC',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildToggleChip(
                                  'AC',
                                  _roomDetails[roomType]!['ac'],
                                  () {
                                    setState(() {
                                      _roomDetails[roomType]!['ac'] = true;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _buildToggleChip(
                                  'Non-AC',
                                  !_roomDetails[roomType]!['ac'],
                                  () {
                                    setState(() {
                                      _roomDetails[roomType]!['ac'] = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Extra Bed Available',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              _buildToggleChip(
                                'Yes',
                                _roomDetails[roomType]!['extraBed'],
                                () {
                                  setState(() {
                                    _roomDetails[roomType]!['extraBed'] = true;
                                  });
                                },
                              ),
                              SizedBox(width: 8),
                              _buildToggleChip(
                                'No',
                                !_roomDetails[roomType]!['extraBed'],
                                () {
                                  setState(() {
                                    _roomDetails[roomType]!['extraBed'] = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    if (_roomDetails[roomType]!['extraBed'])
                      Expanded(
                        child: _buildSmallInput(
                          label: 'Extra Bed Price (₹)',
                          controller: TextEditingController(
                            text: _roomDetails[roomType]!['extraBedPrice'],
                          ),
                          onChanged: (value) =>
                              _roomDetails[roomType]!['extraBedPrice'] = value,
                          hint: '0',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        }).toList(),

        SizedBox(height: 16),
        _buildCard(
          title: 'Select Price (per day):',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _minTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rs',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'to',
                        style: TextStyle(color: _textSecondary),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _maxTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rs',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Extra Bed Available Overall:',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _extraBedAvailable, () {
                            setState(() => _extraBedAvailable = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_extraBedAvailable, () {
                            setState(() => _extraBedAvailable = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildStep4() {
    return Column(
      children: [
        _buildCard(
          title: 'Amenities Available',
          children: [
            _buildAmenitiesSection('Basic Amenities', _basicAmenities),
            SizedBox(height: 16),
            _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
            SizedBox(height: 16),
            _buildAmenitiesSection('Food & Services', _foodServices),
            SizedBox(height: 16),
            _buildAmenitiesSection(
              'Additional Amenities',
              _additionalAmenities,
            ),


            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Extra Amenities',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  'Add any additional amenities not listed above',
                  style: TextStyle(fontSize: 12, color: _textSecondary),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _extraAmenitiesController,
                        decoration: InputDecoration(
                          hintText: 'Enter amenities...',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _primaryColor),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            _addCustomAmenity();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _addCustomAmenity,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (_customAmenities.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _customAmenities.map((amenity) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _primaryLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _primaryColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                amenity,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _primaryColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => _removeCustomAmenity(amenity),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Legal Details',
          children: [
            _buildInputField(
              label: 'GST Number',
              controller: _gstController,
              hint: 'Enter GST number',
              isRequired: true,
              fieldKey: 'gst',
              errorText: _fieldErrors['gst'],
              onChanged: (value) {
                if (_fieldErrors.containsKey('gst')) {
                  setState(() {
                    _fieldErrors.remove('gst');
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'FSSAI License No.',
                    controller: _fssaiController,
                    hint: 'Enter FSSAI license number',
                    isRequired: false,
                    fieldKey: 'fssai',
                    errorText: _fieldErrors['fssai'],
                    onChanged: (value) {
                      if (_fieldErrors.containsKey('fssai')) {
                        setState(() {
                          _fieldErrors.remove('fssai');
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Trade License No',
                    controller: _tradeLicenseController,
                    hint: 'Enter license number',
                    isRequired: false,
                    fieldKey: 'tradeLicense',
                    errorText: _fieldErrors['tradeLicense'],
                    onChanged: (value) {
                      if (_fieldErrors.containsKey('tradeLicense')) {
                        setState(() {
                          _fieldErrors.remove('tradeLicense');
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildInputField(
              label: 'Aadhar Number (Owner)',
              controller: _aadharController,
              hint: 'XXXX XXXX XXXX',
              keyboardType: TextInputType.number,
              isRequired: false,
              fieldKey: 'aadhar',
              errorText: _fieldErrors['aadhar'],
              validationRule: '12 digits, numeric only (format: XXXX XXXX XXXX)',
              onChanged: (value) {
                _validateAadhar(value);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      children: [
        _buildCard(
          title: 'Bank Details',
          children: [
            _buildInputField(
              label: 'Account Holder Name',
              controller: _accountNameController,
              hint: 'Enter name',
              isRequired: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Bank Name',
              controller: _bankNameController,
              hint: 'Enter bank name',
              isRequired: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Account Number',
                    controller: _accountNumberController,
                    hint: 'Enter account number',
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'IFSC Code',
                    controller: _ifscController,
                    hint: 'Enter IFSC code',
                    isRequired: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Branch',
              controller: _branchController,
              hint: 'Enter branch name',
              isRequired: true,
              fieldKey: 'branch',
              errorText: _fieldErrors['branch'],
              onChanged: (value) {
                if (_fieldErrors.containsKey('branch')) {
                  setState(() {
                    _fieldErrors.remove('branch');
                  });
                }
              },
            ),
            SizedBox(height: 16),
            _buildAccountTypeRadioButtons(),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Documents Required',
          children: [
            Text(
              'Please upload clear scanned copies of the following documents',
              style: TextStyle(fontSize: 12, color: _textSecondary),
            ),
            SizedBox(height: 16),

            _buildDocumentUploadItem(
              documentName: 'FSSAI Certificate',
              fileInfo: _uploadedFiles['FSSAI Certificate']!,
              onUploadPressed: () => _pickDocument('FSSAI Certificate'),
              onViewPressed: () => _viewDocument('FSSAI Certificate'),
              onRemovePressed: () => _removeDocument('FSSAI Certificate'),
              isOptional: true,
              optionalText: 'Required only if you have a restaurant',
            ),

            SizedBox(height: 12),

            ..._uploadedFiles.entries
                .where(
                  (entry) =>
                      entry.key != 'FSSAI Certificate' &&
                      entry.key != 'Signature',
                )
                .map(
                  (entry) => _buildDocumentUploadItem(
                    documentName: entry.key,
                    fileInfo: entry.value,
                    onUploadPressed: () => _pickDocument(entry.key),
                    onViewPressed: () => _viewDocument(entry.key),
                    onRemovePressed: () => _removeDocument(entry.key),
                  ),
                ),

            SizedBox(height: 12),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Declaration',
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _declarationAccepted
                    ? _successColor.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _declarationAccepted ? _successColor : _borderColor,
                  width: _declarationAccepted ? 1.5 : 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _declarationAccepted,
                    onChanged: (value) {
                      setState(() {
                        _declarationAccepted = value ?? false;
                      });
                    },
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0C4A6E),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildDocumentUploadItem(
              documentName: 'Signature',
              fileInfo: _uploadedFiles['Signature']!,
              onUploadPressed: () => _pickDocument('Signature'),
              onViewPressed: () => _viewDocument('Signature'),
              onRemovePressed: () => _removeDocument('Signature'),
              isOptional: false,
              signatureHint: 'Upload scanned copy of your signature',
            ),

            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  label: 'Name',
                  controller: _declarationNameController,
                  hint: 'Enter your name',
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: _borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : 'Select date',
                              style: TextStyle(
                                fontSize: 14,
                                color: _selectedDate != null
                                    ? _textPrimary
                                    : _textSecondary,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: _textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool isRequired = false,
    String? fieldKey,
    String? helperText,
    String? errorText,
    String? validationRule,
    ValueChanged<String>? onChanged,
  }) {
    final hasError = errorText != null && errorText.isNotEmpty;
    final fieldId = fieldKey ?? label.toLowerCase().replaceAll(' ', '_').replaceAll('*', '').trim();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: hasError ? Color(0xFFFF5F6D) : _textPrimary,
              ),
            ),
            if (isRequired)
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  '*',
                  style: TextStyle(
                    color: Color(0xFFFF5F6D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (hasError)
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.error_outline,
                  size: 16,
                  color: Color(0xFFFF5F6D),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: fieldId == 'aadhar' ? [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(12),
            _AadharInputFormatter(),
          ] : null,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged(value);
            }
            // Clear error when user starts typing
            if (hasError && fieldId.isNotEmpty) {
              setState(() {
                _fieldErrors.remove(fieldId);
              });
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            helperText: hasError ? null : (helperText ?? validationRule),
            errorText: hasError ? errorText : null,
            errorMaxLines: 2,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? Color(0xFFFF5F6D) : _borderColor,
                width: hasError ? 2 : 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? Color(0xFFFF5F6D) : _borderColor,
                width: hasError ? 2 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? Color(0xFFFF5F6D) : _primaryColor,
                width: hasError ? 2 : 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFFF5F6D),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFFF5F6D),
                width: 2,
              ),
            ),
            filled: hasError,
            fillColor: hasError ? Color(0xFFFFF5F5) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: _borderColor),
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadItem() {
    final isUploaded = _personPhotoInfo['uploaded'] as bool? ?? false;
    final fileName = _personPhotoInfo['name'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 18,
                    color: isUploaded ? _successColor : _primaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Profile Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: isUploaded ? _successColor : _textPrimary,
                    ),
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 8),

          if (!isUploaded)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _pickPersonPhoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Upload Photo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(Icons.photo, size: 20, color: _primaryColor),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Photo uploaded successfully',
                          style: TextStyle(fontSize: 10, color: _textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _viewPersonPhoto,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: _primaryColor,
                        ),
                        padding: EdgeInsets.all(4),
                        tooltip: 'View',
                      ),
                      IconButton(
                        onPressed: _removePersonPhoto,
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        padding: EdgeInsets.all(4),
                        tooltip: 'Remove',
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

  Widget _buildChip(String label) {
    bool isSelected = _selectedHotelType == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHotelType = isSelected ? null : label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _primaryColor : _borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _primaryColor : _borderColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
    return Column(
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
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenities.entries.map((entry) {
            bool isSelected = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  amenities[entry.key] = !isSelected;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? _primaryColor : _borderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      size: 14,
                      color: isSelected ? _primaryColor : _textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? _primaryColor : _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadItem({
    required String documentName,
    required Map<String, dynamic> fileInfo,
    required VoidCallback onUploadPressed,
    required VoidCallback onViewPressed,
    required VoidCallback onRemovePressed,
    bool isOptional = false,
    String? optionalText,
    String? signatureHint,
  }) {
    final fileName = fileInfo['name'] as String? ?? '';
    final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    IconData getDocumentIcon() {
      if (documentName.contains('Signature')) return Icons.draw;
      if (documentName.contains('GST')) return Icons.receipt;
      if (documentName.contains('FSSAI')) return Icons.restaurant;
      if (documentName.contains('License')) return Icons.badge;
      if (documentName.contains('Cheque')) return Icons.account_balance;
      if (documentName.contains('Photos')) return Icons.photo_library;
      if (documentName.contains('Proof')) return Icons.perm_identity;
      return Icons.description;
    }

    Color getIconColor() {
      if (isUploaded) return _successColor;
      if (documentName.contains('Signature')) return Colors.red;
      if (documentName.contains('FSSAI')) return Colors.red;
      return _primaryColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(getDocumentIcon(), size: 18, color: getIconColor()),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        documentName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: isUploaded ? _successColor : _textPrimary,
                        ),
                      ),
                      if (isOptional && optionalText != null)
                        Text(
                          optionalText,
                          style: TextStyle(
                            fontSize: 10,
                            color: _textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      if (signatureHint != null)
                        Text(
                          signatureHint,
                          style: TextStyle(fontSize: 10, color: _textSecondary),
                        ),
                    ],
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 8),

          if (!isUploaded)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onUploadPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      documentName.contains('Signature')
                          ? 'Upload Signature'
                          : 'Upload ${documentName}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  if (documentName.contains('Signature'))
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Icon(Icons.draw, size: 20, color: Colors.purple),
                      ),
                    )
                  else
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(child: _getFileIcon(fileName)),
                    ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB • ${_getFileExtension(fileName).toUpperCase()}',
                          style: TextStyle(fontSize: 10, color: _textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onViewPressed,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: _primaryColor,
                        ),
                        padding: EdgeInsets.all(4),
                        tooltip: 'View',
                      ),
                      IconButton(
                        onPressed: onRemovePressed,
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        padding: EdgeInsets.all(4),
                        tooltip: 'Remove',
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

  Widget _getFileIcon(String fileName) {
    final ext = _getFileExtension(fileName).toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icon(Icons.image, size: 20, color: _primaryColor);
    } else if (['pdf'].contains(ext)) {
      return Icon(Icons.picture_as_pdf, size: 20, color: Colors.red);
    } else if (['doc', 'docx'].contains(ext)) {
      return Icon(Icons.description, size: 20, color: Colors.blue);
    } else {
      return Icon(Icons.insert_drive_file, size: 20, color: _primaryColor);
    }
  }

  String _getFileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }

  IconData _getDocumentIcon(String documentName) {
    if (documentName.contains('GST')) return Icons.receipt;
    if (documentName.contains('FSSAI')) return Icons.restaurant;
    if (documentName.contains('License')) return Icons.badge;
    if (documentName.contains('Cheque')) return Icons.account_balance;
    if (documentName.contains('Photos')) return Icons.photo_library;
    if (documentName.contains('Proof')) return Icons.perm_identity;
    if (documentName.contains('Signature')) return Icons.draw;
    return Icons.description;
  }

  // Build Account Type Radio Buttons
  Widget _buildAccountTypeRadioButtons() {
    final hasError = _fieldErrors.containsKey('accountType');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: hasError ? Color(0xFFFF5F6D) : _textPrimary,
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 4),
          Text(
            _fieldErrors['accountType'] ?? '',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFFF5F6D),
            ),
          ),
        ],
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildRadioButtonOption(
                value: 'Savings',
                label: 'Savings',
                groupValue: _selectedAccountType,
              onChanged: (value) {
                setState(() {
                  _selectedAccountType = value;
                  _accountTypeController.text = value ?? '';
                  if (_fieldErrors.containsKey('accountType')) {
                    _fieldErrors.remove('accountType');
                  }
                });
              },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildRadioButtonOption(
                value: 'Current',
                label: 'Current',
                groupValue: _selectedAccountType,
              onChanged: (value) {
                setState(() {
                  _selectedAccountType = value;
                  _accountTypeController.text = value ?? '';
                  if (_fieldErrors.containsKey('accountType')) {
                    _fieldErrors.remove('accountType');
                  }
                });
              },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButtonOption({
    required String value,
    required String label,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    final isSelected = groupValue == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? _primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? _primaryColor : _borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: _primaryColor,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? _primaryColor : _textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addLandlineField() {
    if (_landlineControllers.length < 3) {
      setState(() {
        _landlineControllers.add(TextEditingController());
      });
    }
  }

  void _removeLandlineField(int index) {
    if (_landlineControllers.length > 1) {
      setState(() {
        _landlineControllers[index].dispose();
        _landlineControllers.removeAt(index);
      });
    }
  }

  void _addCustomAmenity() {
    final amenity = _extraAmenitiesController.text.trim();
    if (amenity.isNotEmpty && !_customAmenities.contains(amenity)) {
      setState(() {
        _customAmenities.add(amenity);
        _extraAmenitiesController.clear();
      });
    }
  }

  void _removeCustomAmenity(String amenity) {
    setState(() {
      _customAmenities.remove(amenity);
    });
  }

  Future<void> _pickPersonPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog(
            'File too large',
            'Please select a photo smaller than 5MB',
          );
          return;
        }

        // Read file bytes and convert to base64
        String? base64String;
        if (file.path != null) {
          try {
            final fileBytes = await File(file.path!).readAsBytes();
            base64String = base64Encode(fileBytes);
          } catch (e) {
            print('Error reading file: $e');
            // Try using bytes if available (for web)
            if (file.bytes != null) {
              base64String = base64Encode(file.bytes!);
            }
          }
        } else if (file.bytes != null) {
          // For web platform, use bytes directly
          base64String = base64Encode(file.bytes!);
        }

        if (base64String == null) {
          _showErrorDialog(
            'Upload Error',
            'Failed to read file. Please try again.',
          );
          return;
        }

        // Determine MIME type
        String mimeType = 'image/jpeg';
        final extension = file.extension?.toLowerCase() ?? '';
        if (extension == 'png') {
          mimeType = 'image/png';
        } else if (extension == 'jpg' || extension == 'jpeg') {
          mimeType = 'image/jpeg';
        }

        setState(() {
          _personPhotoInfo = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
            'base64': base64String,
            'mimeType': mimeType,
            'type': 'image',
          };
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo uploaded successfully'),
            backgroundColor: _successColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(
        'Upload Error',
        'Failed to upload photo: ${e.toString()}',
      );
    }
  }

  void _viewPersonPhoto() {
    final fileName = _personPhotoInfo['name'] as String? ?? '';
    final base64Data = _personPhotoInfo['base64'] as String?;
    final filePath = _personPhotoInfo['path'] as String?;
    
    if (fileName.isNotEmpty) {
      Widget imageWidget;
      
      // Try to display from base64 first, then from file path
      if (base64Data != null && base64Data.isNotEmpty) {
        try {
          final imageBytes = base64Decode(base64Data);
          imageWidget = Image.memory(
            imageBytes,
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          );
        } catch (e) {
          print('Error decoding base64: $e');
          imageWidget = Icon(Icons.person, size: 60, color: _primaryColor);
        }
      } else if (filePath != null && filePath.isNotEmpty) {
        try {
          imageWidget = Image.file(
            File(filePath),
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          );
        } catch (e) {
          print('Error loading file: $e');
          imageWidget = Icon(Icons.person, size: 60, color: _primaryColor);
        }
      } else {
        imageWidget = Icon(Icons.person, size: 60, color: _primaryColor);
      }
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Profile Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageWidget,
                ),
              ),
              SizedBox(height: 16),
              Text(
                fileName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _removePersonPhoto() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Photo'),
        content: Text('Are you sure you want to remove this photo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _personPhotoInfo = {
                  'name': '',
                  'size': 0,
                  'path': '',
                  'uploaded': false,
                  'base64': null,
                  'mimeType': null,
                  'type': null,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Photo removed'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDocument(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog(
            'File too large',
            'Please select a file smaller than 5MB',
          );
          return;
        }

        // Read file bytes and convert to base64
        String? base64String;
        if (file.path != null) {
          try {
            final fileBytes = await File(file.path!).readAsBytes();
            base64String = base64Encode(fileBytes);
          } catch (e) {
            print('Error reading file: $e');
            // Try using bytes if available (for web)
            if (file.bytes != null) {
              base64String = base64Encode(file.bytes!);
            }
          }
        } else if (file.bytes != null) {
          // For web platform, use bytes directly
          base64String = base64Encode(file.bytes!);
        }

        if (base64String == null) {
          _showErrorDialog(
            'Upload Error',
            'Failed to read file. Please try again.',
          );
          return;
        }

        // Determine MIME type
        String mimeType = 'application/pdf';
        String fileType = 'document';
        final extension = file.extension?.toLowerCase() ?? '';
        if (extension == 'pdf') {
          mimeType = 'application/pdf';
          fileType = 'pdf';
        } else if (extension == 'jpg' || extension == 'jpeg') {
          mimeType = 'image/jpeg';
          fileType = 'image';
        } else if (extension == 'png') {
          mimeType = 'image/png';
          fileType = 'image';
        } else if (extension == 'doc' || extension == 'docx') {
          mimeType = 'application/msword';
          if (extension == 'docx') {
            mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
          }
          fileType = 'document';
        }

        setState(() {
          _uploadedFiles[documentType] = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
            'base64': base64String,
            'mimeType': mimeType,
            'type': fileType,
          };
          _documents[documentType] = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${file.name} uploaded successfully'),
            backgroundColor: _successColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(
        'Upload Error',
        'Failed to upload file: ${e.toString()}',
      );
    }
  }

  void _viewDocument(String documentType) {
    final fileInfo = _uploadedFiles[documentType]!;
    final fileName = fileInfo['name'] as String? ?? '';
    final fileSize = (fileInfo['size'] as int?) ?? 0;
    final base64Data = fileInfo['base64'] as String?;
    final filePath = fileInfo['path'] as String?;
    final fileType = fileInfo['type'] as String? ?? 'document';

    if (fileName.isNotEmpty) {
      Widget? previewWidget;
      
      // Show preview for images (JPG, PNG)
      if (fileType == 'image' && base64Data != null && base64Data.isNotEmpty) {
        try {
          final imageBytes = base64Decode(base64Data);
          previewWidget = Image.memory(
            imageBytes,
            fit: BoxFit.contain,
            width: 200,
            height: 200,
          );
        } catch (e) {
          print('Error decoding base64 image: $e');
        }
      } else if (fileType == 'image' && filePath != null && filePath.isNotEmpty) {
        try {
          previewWidget = Image.file(
            File(filePath),
            fit: BoxFit.contain,
            width: 200,
            height: 200,
          );
        } catch (e) {
          print('Error loading image file: $e');
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(
                documentType.contains('Signature')
                    ? Icons.draw
                    : _getDocumentIcon(documentType),
                color: documentType.contains('Signature')
                    ? Colors.purple
                    : _primaryColor,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(documentType, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (previewWidget != null)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: previewWidget,
                  ),
                )
              else if (documentType.contains('Signature'))
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Text(
                      'Signature Preview',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                )
              else if (fileType == 'pdf')
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
                        SizedBox(height: 8),
                        Text(
                          'PDF Document',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(child: _getFileIcon(fileName)),
                ),

              SizedBox(height: 16),
              Text(
                'File Details:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text('Name: $fileName'),
              Text('Size: ${(fileSize / 1024).toStringAsFixed(1)} KB'),
              Text('Type: ${_getFileExtension(fileName).toUpperCase()}'),
              if (documentType == 'FSSAI Certificate')
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Note: Required for hotels with restaurant facilities',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              if (documentType == 'Signature')
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Note: Please upload clear scanned signature',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.purple[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _removeDocument(String documentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Document'),
        content: Text('Are you sure you want to remove this document?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uploadedFiles[documentType] = {
                  'name': '',
                  'size': 0,
                  'path': '',
                  'uploaded': false,
                  'base64': null,
                  'mimeType': null,
                  'type': null,
                };
                _documents[documentType] = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document removed'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Validation functions
  String? _validateHotelName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Hotel name is required';
    }
    if (value.trim().length < 2 || value.trim().length > 150) {
      return 'Hotel name must be 2-150 characters';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Year of establishment is required';
    }
    final year = int.tryParse(value.trim());
    if (year == null) {
      return 'Year must be a valid number';
    }
    final currentYear = DateTime.now().year;
    if (year < 1800 || year > currentYear) {
      return 'Year must be between 1800 and $currentYear';
    }
    if (value.trim().length != 4) {
      return 'Year must be in YYYY format (4 digits)';
    }
    return null;
  }

  String? _validateRooms(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Total number of rooms is required';
    }
    final rooms = int.tryParse(value.trim());
    if (rooms == null) {
      return 'Total rooms must be a valid number';
    }
    if (rooms < 1 || rooms > 10000) {
      return 'Total rooms must be between 1 and 10000';
    }
    return null;
  }

  String? _validateOwnerName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Owner/Manager name is required';
    }
    if (value.trim().length < 2 || value.trim().length > 100) {
      return 'Name must be 2-100 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(value.trim())) {
      return 'Name can only contain letters, spaces, dots, apostrophes, and hyphens';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    final phone = value.trim().replaceAll(RegExp(r'[\s-]'), '');
    // Support Indian 10-digit format or E.164 international format
    if (RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone) || 
        (phone.length == 10 && RegExp(r'^[6-9]\d{9}$').hasMatch(phone))) {
      return null;
    }
    return 'Mobile number must be 10 digits (Indian) or international format with country code';
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email ID is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateWebsite(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      final urlRegex = RegExp(r'^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$');
      if (!urlRegex.hasMatch(value.trim())) {
        return 'Please enter a valid URL (e.g., https://example.com)';
      }
    }
    return null;
  }

  String? _validateGst(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'GST Number is required';
    }
    // No format validation - just check if it's not empty
    return null;
  }

  String? _validateFssai(String? value) {
    // FSSAI is optional - no validation needed
    return null;
  }

  String? _validateTradeLicense(String? value) {
    // Trade License is optional - no validation needed
    return null;
  }

  String? _validateBranch(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Branch is required';
    }
    if (value.trim().length < 2) {
      return 'Branch name must be at least 2 characters';
    }
    return null;
  }

  String? _validateAccountType() {
    if (_selectedAccountType == null || _selectedAccountType!.isEmpty) {
      return 'Account Type is required';
    }
    return null;
  }

  String? _validateAadharRequired(String? value) {
    // Aadhar is optional - only validate format if provided
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    final cleaned = value.replaceAll(' ', '');
    if (cleaned.length != 12) {
      return 'Aadhar number must be exactly 12 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
      return 'Aadhar number must contain only digits';
    }
    return null;
  }

  bool _validateStep1() {
    _fieldErrors.clear();
    bool isValid = true;

    // Validate hotel name
    final hotelNameError = _validateHotelName(_hotelNameController.text);
    if (hotelNameError != null) {
      _fieldErrors['hotelName'] = hotelNameError;
      isValid = false;
    }

    // Validate hotel type
    if (_selectedHotelType == null || _selectedHotelType!.isEmpty) {
      _fieldErrors['hotelType'] = 'Please select a hotel type';
      isValid = false;
    }

    // Validate year
    final yearError = _validateYear(_yearController.text);
    if (yearError != null) {
      _fieldErrors['year'] = yearError;
      isValid = false;
    }

    // Validate rooms
    final roomsError = _validateRooms(_roomsController.text);
    if (roomsError != null) {
      _fieldErrors['rooms'] = roomsError;
      isValid = false;
    }

    // Validate owner name
    final ownerNameError = _validateOwnerName(_ownerNameController.text);
    if (ownerNameError != null) {
      _fieldErrors['ownerName'] = ownerNameError;
      isValid = false;
    }

    // Validate mobile
    final mobileError = _validateMobile(_mobileController.text);
    if (mobileError != null) {
      _fieldErrors['mobile'] = mobileError;
      isValid = false;
    }

    // Validate email
    final emailError = _validateEmail(_emailController.text);
    if (emailError != null) {
      _fieldErrors['email'] = emailError;
      isValid = false;
    }

    // Validate website (optional)
    final websiteError = _validateWebsite(_websiteController.text);
    if (websiteError != null) {
      _fieldErrors['website'] = websiteError;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  void _navigateToStep(int targetStep) {
    // If navigating to a future step, validate current step first
    if (targetStep > _currentStep) {
      if (_currentStep == 0) {
        if (!_validateStep1()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please complete the current step before proceeding'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
      }
    }

    // Allow navigation to any step (past, current, or future if validated)
    setState(() {
      _currentStep = targetStep;
    });
  }

  void _nextStep() {
    // Validate Step 1 before proceeding
    if (_currentStep == 0) {
      if (!_validateStep1()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fix the errors in the form'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

<<<<<<< HEAD
  void _submitForm() async {
    // Validate all required fields
    _fieldErrors.clear();
    bool isValid = true;

    // Validate GST Number
    final gstError = _validateGst(_gstController.text);
    if (gstError != null) {
      _fieldErrors['gst'] = gstError;
      isValid = false;
    }

    // FSSAI and Trade License are optional - no validation needed

    // Validate Aadhar Number
    final aadharError = _validateAadharRequired(_aadharController.text);
    if (aadharError != null) {
      _fieldErrors['aadhar'] = aadharError;
      isValid = false;
    }

    // Validate Branch
    final branchError = _validateBranch(_branchController.text);
    if (branchError != null) {
      _fieldErrors['branch'] = branchError;
      isValid = false;
    }

    // Validate Account Type
    final accountTypeError = _validateAccountType();
    if (accountTypeError != null) {
      _fieldErrors['accountType'] = accountTypeError;
      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }


    if (!_declarationAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the declaration to proceed'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Build formData map
=======
  // void _submitForm() {
  //   if (!_formKey.currentState!.validate()) {
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please fill all required fields correctly'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //
  //   if (!_declarationAccepted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please accept the declaration to proceed'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   Map<String, dynamic> formData = {
  //     'hotelName': _hotelNameController.text,
  //     'hotelType': _selectedHotelType,
  //     'yearOfEstablishment': _yearController.text,
  //     'totalRooms': _roomsController.text,
  //     'ownerName': _ownerNameController.text,
  //     'mobileNumber': _mobileController.text,
  //     'alternateContact': _altMobileController.text,
  //     'landlineNumbers': _landlineControllers
  //         .map((c) => c.text)
  //         .where((text) => text.isNotEmpty)
  //         .toList(),
  //     'email': _emailController.text,
  //     'website': _websiteController.text,
  //     'addressLine1': _address1Controller.text,
  //     'addressLine2': _address2Controller.text,
  //     'city': _cityController.text,
  //     'district': _districtController.text,
  //     'state': _stateController.text,
  //     'pinCode': _pinController.text,
  //     'landmark': _landmarkController.text,
  //     'selectedRoomTypes': _selectedRoomTypes,
  //     'roomDetails': _roomDetails,
  //     'minTariff': _minTariffController.text,
  //     'maxTariff': _maxTariffController.text,
  //     'extraBedAvailable': _extraBedAvailable,
  //     'basicAmenities': _basicAmenities,
  //     'hotelFacilities': _hotelFacilities,
  //     'foodServices': _foodServices,
  //     'additionalAmenities': _additionalAmenities,
  //     'customAmenities': _customAmenities,
  //     'gstNumber': _gstController.text,
  //     'fssaiLicense': _fssaiController.text,
  //     'tradeLicense': _tradeLicenseController.text,
  //     'panNumber': _panController.text,
  //     'aadharNumber': _aadharController.text,
  //     'accountHolderName': _accountNameController.text,
  //     'bankName': _bankNameController.text,
  //     'accountNumber': _accountNumberController.text,
  //     'ifscCode': _ifscController.text,
  //     'branch': _branchController.text,
  //     'accountType': _accountTypeController.text,
  //     'uploadedFiles': _uploadedFiles,
  //     'signatureName': _signatureNameController.text,
  //     'declarationName': _declarationNameController.text,
  //     'declarationDate': _selectedDate,
  //     'personPhotoInfo': _personPhotoInfo,
  //     'declarationAccepted': _declarationAccepted,
  //   };
  //
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => RegistrationSummaryScreen(
  //         formData: formData,
  //         hotelName: _hotelNameController.text,
  //         hotelType: _selectedHotelType,
  //         yearOfEstablishment: _yearController.text,
  //         totalRooms: _roomsController.text,
  //         ownerName: _ownerNameController.text,
  //         mobileNumber: _mobileController.text,
  //         alternateContact: _altMobileController.text,
  //         landlineNumbers: _landlineControllers
  //             .map((c) => c.text)
  //             .where((text) => text.isNotEmpty)
  //             .toList(),
  //         email: _emailController.text,
  //         website: _websiteController.text,
  //         addressLine1: _address1Controller.text,
  //         addressLine2: _address2Controller.text,
  //         city: _cityController.text,
  //         district: _districtController.text,
  //         state: _stateController.text,
  //         pinCode: _pinController.text,
  //         landmark: _landmarkController.text,
  //         selectedRoomTypes: _selectedRoomTypes,
  //         roomDetails: _roomDetails,
  //         minTariff: _minTariffController.text,
  //         maxTariff: _maxTariffController.text,
  //         extraBedAvailable: _extraBedAvailable,
  //         basicAmenities: _basicAmenities,
  //         hotelFacilities: _hotelFacilities,
  //         foodServices: _foodServices,
  //         additionalAmenities: _additionalAmenities,
  //         customAmenities: _customAmenities,
  //         gstNumber: _gstController.text,
  //         fssaiLicense: _fssaiController.text,
  //         tradeLicense: _tradeLicenseController.text,
  //         panNumber: _panController.text,
  //         aadharNumber: _aadharController.text,
  //         accountHolderName: _accountNameController.text,
  //         bankName: _bankNameController.text,
  //         accountNumber: _accountNumberController.text,
  //         ifscCode: _ifscController.text,
  //         branch: _branchController.text,
  //         accountType: _accountTypeController.text,
  //         uploadedFiles: _uploadedFiles,
  //         signatureName: _signatureNameController.text,
  //         declarationName: _declarationNameController.text,
  //         declarationDate: _selectedDate,
  //         personPhotoInfo: _personPhotoInfo,
  //         declarationAccepted: _declarationAccepted, isTwoStar: true,
  //       ),
  //     ),
  //   );
  // }

  void _submitForm() {
    // Collect all data
>>>>>>> 05bbda8 (update changes)
    Map<String, dynamic> formData = {
      'propertyType': widget.propertyType ?? 'Hotel', // Default to Hotel if not provided
      'hotelName': _hotelNameController.text.trim(),
      'hotelType': _selectedHotelType,
      'yearOfEstablishment': _yearController.text.trim(),
      'totalRooms': _roomsController.text.trim(),
      'ownerName': _ownerNameController.text.trim(),
      'mobileNumber': _mobileController.text.trim(),
      'alternateContact': _altMobileController.text.trim(),
      'landlineNumbers': _landlineControllers
          .map((c) => c.text.trim())
          .where((text) => text.isNotEmpty)
          .toList(),
      'email': _emailController.text.trim(),
      'website': _websiteController.text.trim(),
      'addressLine1': _address1Controller.text.trim(),
      'addressLine2': _address2Controller.text.trim(),
      'city': _cityController.text.trim(),
      'district': _districtController.text.trim(),
      'state': _stateController.text.trim(),
      'pinCode': _pinController.text.trim(),
      'landmark': _landmarkController.text.trim(),
      'selectedRoomTypes': _selectedRoomTypes,
      'roomDetails': _roomDetails,
      'minTariff': _minTariffController.text.trim(),
      'maxTariff': _maxTariffController.text.trim(),
      'extraBedAvailable': _extraBedAvailable ?? false,
      'basicAmenities': _basicAmenities,
      'hotelFacilities': _hotelFacilities,
      'foodServices': _foodServices,
      'additionalAmenities': _additionalAmenities,
      'customAmenities': _customAmenities,
<<<<<<< HEAD
      'gstNumber': _gstController.text.trim().replaceAll(' ', '').toUpperCase(),
      'fssaiLicense': _fssaiController.text.trim(),
      'tradeLicense': _tradeLicenseController.text.trim(),
      'panNumber': _panController.text.trim(),
      'aadharNumber': _aadharController.text.trim().replaceAll(' ', ''),
      'accountHolderName': _accountNameController.text.trim(),
      'bankName': _bankNameController.text.trim(),
      'accountNumber': _accountNumberController.text.trim(),
      'ifscCode': _ifscController.text.trim(),
      'branch': _branchController.text.trim(),
      'accountType': _selectedAccountType ?? _accountTypeController.text.trim(),
=======
      'gstNumber': _gstController.text,
      'fssaiLicense': _fssaiController.text,
      'tradeLicense': _tradeLicenseController.text,
      'aadharNumber': _aadharController.text,
      'accountHolderName': _accountNameController.text,
      'bankName': _bankNameController.text,
      'accountNumber': _accountNumberController.text,
      'ifscCode': _ifscController.text,
      'branch': _branchController.text,
      'accountType': _accountTypeController.text,
>>>>>>> 05bbda8 (update changes)
      'uploadedFiles': _uploadedFiles,
      'signatureName': _signatureNameController.text.trim(),
      'declarationName': _declarationNameController.text.trim(),
      'declarationDate': _selectedDate != null ? _selectedDate!.toIso8601String() : null,
      'personPhotoInfo': _personPhotoInfo,
      'declarationAccepted': _declarationAccepted ?? false,
    };

<<<<<<< HEAD
    try {
      // Submit form data to backend
      final apiService = ApiService();
      final response = await apiService.registerVendor(formData);

      // Hide loading indicator
      Navigator.pop(context);

      if (response.success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Registration successful!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Registration failed. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return; // Don't navigate if registration failed
      }
    } catch (e) {
      // Hide loading indicator
      Navigator.pop(context);
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting registration: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return; // Don't navigate if there was an error
    }
    // On success, go directly to the vendor profile page
    final totalRoomsInt =
        int.tryParse(_roomsController.text.trim().isNotEmpty ? _roomsController.text.trim() : '0') ??
            0;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerProfilePage(
          hotelName: _hotelNameController.text.trim(),
          ownerName: _ownerNameController.text.trim(),
          mobileNumber: _mobileController.text.trim(),
          email: _emailController.text.trim(),
          addressLine1: _address1Controller.text.trim(),
          addressLine2: _address2Controller.text.trim(),
          city: _cityController.text.trim(),
          district: _districtController.text.trim(),
          state: _stateController.text.trim(),
          pinCode: _pinController.text.trim(),
          gstNumber: _gstController.text.trim().replaceAll(' ', '').toUpperCase(),
          fssaiLicense: _fssaiController.text.trim(),
          tradeLicense: _tradeLicenseController.text.trim(),
          panNumber: _panController.text.trim(),
          aadharNumber: _aadharController.text.trim().replaceAll(' ', ''),
          accountHolderName: _accountNameController.text.trim(),
          bankName: _bankNameController.text.trim(),
          accountNumber: _accountNumberController.text.trim(),
          ifscCode: _ifscController.text.trim(),
          branch: _branchController.text.trim(),
          accountType: (_selectedAccountType ?? _accountTypeController.text).trim(),
          totalRooms: totalRoomsInt,
          personPhotoInfo: _personPhotoInfo,
          hotelType: _selectedHotelType ?? '',
          yearOfEstablishment: _yearController.text.trim(),
          website: _websiteController.text.trim(),
          landmark: _landmarkController.text.trim(),
          selectedRoomTypes: _selectedRoomTypes,
          roomDetails: _roomDetails,
          minTariff: _minTariffController.text.trim(),
          maxTariff: _maxTariffController.text.trim(),
          extraBedAvailable: _extraBedAvailable ?? false,
          basicAmenities: _basicAmenities,
          hotelFacilities: _hotelFacilities,
          foodServices: _foodServices,
          additionalAmenities: _additionalAmenities,
          customAmenities: _customAmenities,
          alternateContact: _altMobileController.text.trim(),
          landlineNumbers: _landlineControllers
              .map((c) => c.text.trim())
              .where((text) => text.isNotEmpty)
              .toList(),
          uploadedFiles: _uploadedFiles,
          signatureName: _signatureNameController.text.trim(),
          declarationName: _declarationNameController.text.trim(),
          declarationDate: _selectedDate,
          declarationAccepted: _declarationAccepted ?? false,
=======
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationSummaryScreen(
          registrationData: formData,
          hotelCategory: 'Normal',
          declarationAccepted: _declarationAccepted,
>>>>>>> 05bbda8 (update changes)
        ),
      ),
    );
  }


  @override
  void dispose() {

    _hotelNameController.dispose();
    _yearController.dispose();
    _roomsController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    _minTariffController.dispose();
    _maxTariffController.dispose();
    _gstController.dispose();
    _fssaiController.dispose();
    _tradeLicenseController.dispose();
    _panController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    _signatureNameController.dispose();
    _declarationNameController.dispose();
    _extraAmenitiesController.dispose();
    _landmarkController.dispose();
    _aadharController.dispose();
    _accountTypeController.dispose();

    // Dispose landline controllers
    for (var controller in _landlineControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  // ==================== AADHAR VALIDATION ====================
  
  void _validateAadhar(String value) {
    // Remove spaces for validation
    final cleaned = value.replaceAll(' ', '');
    
    // Clear previous error
    setState(() {
      _fieldErrors.remove('aadhar');
    });
    
    // Validate length (only if value is provided - field is optional)
    if (cleaned.isEmpty) {
      return; // Optional field - no error for empty
    }
    
    if (cleaned.length != 12) {
      setState(() {
        _fieldErrors['aadhar'] = 'Aadhar number must be exactly 12 digits';
      });
      return;
    }
    
    // Validate purely numeric
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
      setState(() {
        _fieldErrors['aadhar'] = 'Aadhar number must contain only digits';
      });
      return;
    }
    
    // Only validate 12 digits and numeric - no other validation needed
  }
  
  // Verhoeff algorithm for Aadhar checksum validation
  bool _validateAadharVerhoeff(String aadharNumber) {
    if (aadharNumber.length != 12) return false;
    
    // Verhoeff multiplication table
    final d = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
      [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
      [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
      [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
      [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
      [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
      [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
      [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
    ];
    
    // Verhoeff permutation table
    final p = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
      [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
      [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
      [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
      [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
      [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
      [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
    ];
    
    int check = 0;
    final digits = aadharNumber.split('').map((e) => int.parse(e)).toList();
    
    // Process all 12 digits
    for (int i = 0; i < 12; i++) {
      check = d[check][p[((i + 1) % 8)][digits[11 - i]]];
    }
    
    // Valid if check is 0
    return check == 0;
  }
}

<<<<<<< HEAD
// Aadhar Input Formatter - Formats as XXXX XXXX XXXX
class _AadharInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digit characters
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    // Limit to 12 digits
    final limitedText = text.length > 12 ? text.substring(0, 12) : text;
    
    // Format with spaces: XXXX XXXX XXXX
    String formatted = '';
    for (int i = 0; i < limitedText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += limitedText[i];
    }
    
    // Calculate new cursor position - fix cursor jumping issue
    int cursorPosition = formatted.length;
    
    // If user is typing (adding characters)
    if (newValue.text.length > oldValue.text.length) {
      // Count digits before cursor in old value
      final oldDigitsBeforeCursor = oldValue.text.substring(0, oldValue.selection.baseOffset).replaceAll(RegExp(r'[^\d]'), '').length;
      // Find position in formatted string where this many digits appear
      int digitCount = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (RegExp(r'\d').hasMatch(formatted[i])) {
          digitCount++;
          if (digitCount > oldDigitsBeforeCursor) {
            cursorPosition = i;
            break;
          }
        }
      }
      if (digitCount <= oldDigitsBeforeCursor) {
        cursorPosition = formatted.length;
      }
    } else if (oldValue.text.length > newValue.text.length) {
      // User is deleting, maintain relative position
      final oldDigitsBeforeCursor = oldValue.text.substring(0, oldValue.selection.baseOffset).replaceAll(RegExp(r'[^\d]'), '').length;
      int digitCount = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (RegExp(r'\d').hasMatch(formatted[i])) {
          digitCount++;
          if (digitCount >= oldDigitsBeforeCursor) {
            cursorPosition = i;
            break;
          }
        }
      }
      if (digitCount < oldDigitsBeforeCursor) {
        cursorPosition = formatted.length;
      }
    }
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

=======
>>>>>>> 05bbda8 (update changes)
// class RegistrationSummaryScreen extends StatelessWidget {
//   final Map<String, dynamic>? formData;
//   final bool declarationAccepted;
//   final String hotelName;
//   final String? hotelType;
//   final String yearOfEstablishment;
//   final String totalRooms;
//   final String ownerName;
//   final String mobileNumber;
//   final String alternateContact;
//   final List<String> landlineNumbers;
//   final String email;
//   final String website;
//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final String district;
//   final String state;
//   final String pinCode;
//   final String landmark;
//   final Map<String, bool> selectedRoomTypes;
//   final Map<String, Map<String, dynamic>> roomDetails;
//   final String minTariff;
//   final String maxTariff;
//   final bool extraBedAvailable;
//   final Map<String, bool> basicAmenities;
//   final Map<String, bool> hotelFacilities;
//   final Map<String, bool> foodServices;
//   final Map<String, bool> additionalAmenities;
//   final List<String> customAmenities;
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
//   final String panNumber;
//   final String aadharNumber;
//   final String accountHolderName;
//   final String bankName;
//   final String accountNumber;
//   final String ifscCode;
//   final String branch;
//   final String accountType;
//   final Map<String, Map<String, dynamic>> uploadedFiles;
//   final String signatureName;
//   final String declarationName;
//   final DateTime? declarationDate;
//   final Map<String, dynamic> personPhotoInfo;
//
//   const RegistrationSummaryScreen({
//     super.key,
//     this.formData,
//     required this.hotelName,
//     this.hotelType,
//     required this.yearOfEstablishment,
//     required this.totalRooms,
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.alternateContact,
//     required this.landlineNumbers,
//     required this.email,
//     required this.website,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.pinCode,
//     required this.landmark,
//     required this.selectedRoomTypes,
//     required this.roomDetails,
//     required this.minTariff,
//     required this.maxTariff,
//     required this.extraBedAvailable,
//     required this.basicAmenities,
//     required this.hotelFacilities,
//     required this.foodServices,
//     required this.additionalAmenities,
//     required this.customAmenities,
//     required this.gstNumber,
//     required this.fssaiLicense,
//     required this.tradeLicense,
//     required this.panNumber,
//     required this.aadharNumber,
//     required this.accountHolderName,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifscCode,
//     required this.branch,
//     required this.accountType,
//     required this.uploadedFiles,
//     required this.signatureName,
//     required this.declarationName,
//     this.declarationDate,
//     required this.personPhotoInfo,
<<<<<<< HEAD
//     required this.declarationAccepted,
=======
//     required this.declarationAccepted, required bool isTwoStar,
>>>>>>> 05bbda8 (update changes)
//   });
//
//   static const Color primary = Color(0xFFFF5F6D);
//   static const Color bg = Color(0xFFF9FAFB);
//   static const Color textDark = Color(0xFF111827);
//   static const Color textLight = Color(0xFF6B7280);
//   static const Color border = Color(0xFFE5E7EB);
//   static const Color green = Color(0xFF10B981);
//   static const Color greenLight = Color(0xFFD1FAE5);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: const Text(
//           'Registration Summary',
//           style: TextStyle(fontWeight: FontWeight.w600, color: textDark),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: textDark),
//       ),
<<<<<<< HEAD
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: // In RegistrationSummaryScreen's bottomNavigationBar button:
//           ElevatedButton(
=======
//       // Replace the bottomNavigationBar in RegistrationSummaryScreen with this:
//
//       // bottomNavigationBar: SafeArea(
//       //   child: Padding(
//       //     padding: const EdgeInsets.all(16),
//       //     child: ElevatedButton(
//       //       style: ElevatedButton.styleFrom(
//       //         backgroundColor: primary,
//       //         padding: const EdgeInsets.symmetric(vertical: 16),
//       //         shape: RoundedRectangleBorder(
//       //           borderRadius: BorderRadius.circular(12),
//       //         ),
//       //       ),
//       //       onPressed: () {
//       //         // Collect all registration data
//       //         Map<String, dynamic> registrationData = {
//       //           'hotelName': hotelName,
//       //           'hotelType': hotelType,
//       //           'yearOfEstablishment': yearOfEstablishment,
//       //           'totalRooms': totalRooms,
//       //           'ownerName': ownerName,
//       //           'mobileNumber': mobileNumber,
//       //           'alternateContact': alternateContact,
//       //           'landlineNumbers': landlineNumbers,
//       //           'email': email,
//       //           'website': website,
//       //           'addressLine1': addressLine1,
//       //           'addressLine2': addressLine2,
//       //           'city': city,
//       //           'district': district,
//       //           'state': state,
//       //           'pinCode': pinCode,
//       //           'landmark': landmark,
//       //           'selectedRoomTypes': selectedRoomTypes,
//       //           'roomDetails': roomDetails,
//       //           'minTariff': minTariff,
//       //           'maxTariff': maxTariff,
//       //           'extraBedAvailable': extraBedAvailable,
//       //           'basicAmenities': basicAmenities,
//       //           'hotelFacilities': hotelFacilities,
//       //           'foodServices': foodServices,
//       //           'additionalAmenities': additionalAmenities,
//       //           'customAmenities': customAmenities,
//       //           'gstNumber': gstNumber,
//       //           'fssaiLicense': fssaiLicense,
//       //           'tradeLicense': tradeLicense,
//       //           'aadharNumber': aadharNumber,
//       //           'accountHolderName': accountHolderName,
//       //           'bankName': bankName,
//       //           'accountNumber': accountNumber,
//       //           'ifscCode': ifscCode,
//       //           'branch': branch,
//       //           'accountType': accountType,
//       //           'uploadedFiles': uploadedFiles,
//       //           'signatureName': signatureName,
//       //           'declarationName': declarationName,
//       //           'declarationDate': declarationDate,
//       //           'personPhotoInfo': personPhotoInfo,
//       //           'declarationAccepted': declarationAccepted,
//       //         };
//       //
//       //         // Navigate to LoginPage with ALL registration data
//       //         Navigator.pushAndRemoveUntil(
//       //           context,
//       //           MaterialPageRoute(
//       //             builder: (context) => LoginPage(
//       //               registrationData: registrationData,
//       //               registeredEmail: email,
//       //               registeredPassword: '', // Default password
//       //             ),
//       //           ),
//       //               (route) => false,
//       //         );
//       //       },
//       //       child: const Text(
//       //         'Finish',
//       //         style: TextStyle(
//       //           color: Colors.white,
//       //           fontSize: 16,
//       //           fontWeight: FontWeight.w600,
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: ElevatedButton(
>>>>>>> 05bbda8 (update changes)
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primary,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             onPressed: () {
<<<<<<< HEAD
//               // Create a map with all registration data
//               Map<String, dynamic> registrationData = {
//                 'hotelName': hotelName,
//                 'ownerName': ownerName,
//                 'mobileNumber': mobileNumber,
//                 'email': email,
=======
//               // Collect all registration data
//               Map<String, dynamic> registrationData = {
//                 'hotelName': hotelName,
//                 'hotelType': hotelType,
//                 'yearOfEstablishment': yearOfEstablishment,
//                 'totalRooms': totalRooms,
//                 'ownerName': ownerName,
//                 'mobileNumber': mobileNumber,
//                 'alternateContact': alternateContact,
//                 'landlineNumbers': landlineNumbers,
//                 'email': email,
//                 'website': website,
>>>>>>> 05bbda8 (update changes)
//                 'addressLine1': addressLine1,
//                 'addressLine2': addressLine2,
//                 'city': city,
//                 'district': district,
//                 'state': state,
//                 'pinCode': pinCode,
//                 'landmark': landmark,
<<<<<<< HEAD
//                 'hotelType': hotelType,
//                 'yearOfEstablishment': yearOfEstablishment,
//                 'totalRooms': totalRooms,
//                 'alternateContact': alternateContact,
//                 'landlineNumbers': landlineNumbers,
//                 'website': website,
=======
>>>>>>> 05bbda8 (update changes)
//                 'selectedRoomTypes': selectedRoomTypes,
//                 'roomDetails': roomDetails,
//                 'minTariff': minTariff,
//                 'maxTariff': maxTariff,
//                 'extraBedAvailable': extraBedAvailable,
//                 'basicAmenities': basicAmenities,
//                 'hotelFacilities': hotelFacilities,
//                 'foodServices': foodServices,
//                 'additionalAmenities': additionalAmenities,
//                 'customAmenities': customAmenities,
//                 'gstNumber': gstNumber,
//                 'fssaiLicense': fssaiLicense,
//                 'tradeLicense': tradeLicense,
//                 'aadharNumber': aadharNumber,
//                 'accountHolderName': accountHolderName,
//                 'bankName': bankName,
//                 'accountNumber': accountNumber,
//                 'ifscCode': ifscCode,
//                 'branch': branch,
//                 'accountType': accountType,
//                 'uploadedFiles': uploadedFiles,
//                 'signatureName': signatureName,
//                 'declarationName': declarationName,
//                 'declarationDate': declarationDate,
<<<<<<< HEAD
//                 'declarationAccepted': declarationAccepted,
//                 'personPhotoInfo': personPhotoInfo,
//               };
//
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => LoginPage(
//                     registeredEmail: email,
//                     registeredPassword: "12345",
//                     registrationData: registrationData, // Pass all data
//                   ),
//                 ),
//                 (route) => false,
=======
//                 'personPhotoInfo': personPhotoInfo,
//                 'declarationAccepted': declarationAccepted,
//               };
//
//
//
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PropertyAuthScreen(
//                     registrationData: registrationData,
//                   ),
//                 ),
//                     (route) => false,
>>>>>>> 05bbda8 (update changes)
//               );
//             },
//             child: const Text(
//               'Finish',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _successCard(),
//
//             _section('Hotel Information', [
//               _info('Hotel Name', hotelName),
//               _info('Hotel Type', hotelType ?? 'Not selected'),
//               _info('Year of Establishment', yearOfEstablishment),
//               _info('Total Rooms', totalRooms),
//             ]),
//
//             _section('Contact Information', [
//               _info('Owner Name', ownerName),
//               if (personPhotoInfo['uploaded'] == true)
//                 _fileInfo('Profile Photo', personPhotoInfo['name'] ?? 'Photo'),
//               _info('Mobile', mobileNumber),
//               if (alternateContact.isNotEmpty)
//                 _info('Alternate Contact', alternateContact),
//               ...landlineNumbers
//                   .where((e) => e.isNotEmpty)
//                   .map((e) => _info('Landline', e)),
//               if (email.isNotEmpty) _info('Email', email),
//               if (website.isNotEmpty) _info('Website', website),
//             ]),
//
//             _section('Hotel Address', [
//               _info('Address Line 1', addressLine1),
//               if (addressLine2.isNotEmpty)
//                 _info('Address Line 2', addressLine2),
//               _info('City', city),
//               _info('District', district),
//               _info('State', state),
//               _info('PIN Code', pinCode),
//               if (landmark.isNotEmpty) _info('Landmark', landmark),
//             ]),
//
//             if (selectedRoomTypes.entries.any((entry) => entry.value))
//               _section('Room Configuration', [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: Text(
//                     'Selected Room Types:',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                       color: textDark,
//                     ),
//                   ),
//                 ),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: selectedRoomTypes.entries
//                       .where((entry) => entry.value)
//                       .map(
//                         (entry) => Container(
<<<<<<< HEAD
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primary.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: primary.withOpacity(0.3)),
//                           ),
//                           child: Text(
//                             entry.key,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: primary,
//                             ),
//                           ),
//                         ),
//                       )
=======
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: primary.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: primary.withOpacity(0.3)),
//                       ),
//                       child: Text(
//                         entry.key,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: primary,
//                         ),
//                       ),
//                     ),
//                   )
>>>>>>> 05bbda8 (update changes)
//                       .toList(),
//                 ),
//                 const SizedBox(height: 16),
//
//                 ...selectedRoomTypes.entries.where((entry) => entry.value).map((
<<<<<<< HEAD
//                   entry,
//                 ) {
=======
//                     entry,
//                     ) {
>>>>>>> 05bbda8 (update changes)
//                   String roomType = entry.key;
//                   var details = roomDetails[roomType]!;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Text(
//                           roomType,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                             color: textDark,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         margin: const EdgeInsets.only(bottom: 12),
//                         decoration: BoxDecoration(
//                           color: bg,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: border),
//                         ),
//                         child: Column(
//                           children: [
//                             if (details['rooms'] != null &&
//                                 details['rooms'].toString().isNotEmpty)
//                               _row(
//                                 'Number of Rooms',
//                                 details['rooms'].toString(),
//                               ),
//                             if (details['occupancy'] != null &&
//                                 details['occupancy'].toString().isNotEmpty)
//                               _row(
//                                 'Max Occupancy',
//                                 '${details['occupancy']} Persons',
//                               ),
//                             if (details['price'] != null &&
//                                 details['price'].toString().isNotEmpty)
//                               _row('Price per Night', '₹${details['price']}'),
//                             _row(
//                               'AC/Non-AC',
//                               details['ac'] == true ? 'AC' : 'Non-AC',
//                             ),
//                             _row(
//                               'Extra Bed Available',
//                               details['extraBed'] == true ? 'Yes' : 'No',
//                             ),
//                             if (details['extraBed'] == true &&
//                                 details['extraBedPrice'] != null &&
//                                 details['extraBedPrice'].toString().isNotEmpty)
//                               _row(
//                                 'Extra Bed Price',
//                                 '₹${details['extraBedPrice']}',
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//
//                 if (minTariff.isNotEmpty || maxTariff.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: greenLight,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: green.withOpacity(0.3)),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Room Tariff Range',
//                               style: TextStyle(fontSize: 13, color: textLight),
//                             ),
//                             Text(
//                               '₹$minTariff - ₹$maxTariff',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: green,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: green),
//                           ),
//                           child: Text(
//                             extraBedAvailable
//                                 ? 'Extra Bed: Yes'
//                                 : 'Extra Bed: No',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: green,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ]),
//
//             _section('Amenities & Facilities', [
//               if (basicAmenities.entries.any((entry) => entry.value))
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _amenityCategory('Basic Amenities', basicAmenities),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//
//               if (hotelFacilities.entries.any((entry) => entry.value))
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _amenityCategory('Hotel Facilities', hotelFacilities),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//
//               if (foodServices.entries.any((entry) => entry.value))
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _amenityCategory('Food & Services', foodServices),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//
//               if (additionalAmenities.entries.any((entry) => entry.value))
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _amenityCategory(
//                       'Additional Amenities',
//                       additionalAmenities,
//                     ),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//
//               if (customAmenities.isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: Text(
//                         'Custom Amenities',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                           color: textDark,
//                         ),
//                       ),
//                     ),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: customAmenities
//                           .map(
//                             (amenity) => Container(
<<<<<<< HEAD
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 6,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: primary.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: primary.withOpacity(0.3),
//                                 ),
//                               ),
//                               child: Text(
//                                 amenity,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: primary,
//                                 ),
//                               ),
//                             ),
//                           )
=======
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: primary.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: primary.withOpacity(0.3),
//                             ),
//                           ),
//                           child: Text(
//                             amenity,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                               color: primary,
//                             ),
//                           ),
//                         ),
//                       )
>>>>>>> 05bbda8 (update changes)
//                           .toList(),
//                     ),
//                   ],
//                 ),
//             ]),
//
//             _section('Legal Details', [
//               if (gstNumber.isNotEmpty) _info('GST Number', gstNumber),
//               if (fssaiLicense.isNotEmpty) _info('FSSAI License', fssaiLicense),
//               if (tradeLicense.isNotEmpty) _info('Trade License', tradeLicense),
//
//               if (aadharNumber.isNotEmpty) _info('Aadhar Number', aadharNumber),
//             ]),
//
//             _section('Bank Details', [
//               _info('Account Holder', accountHolderName),
//               _info('Bank Name', bankName),
//               _info('Account Number', accountNumber),
//               _info('IFSC Code', ifscCode),
//               if (branch.isNotEmpty) _info('Branch', branch),
//               if (accountType.isNotEmpty) _info('Account Type', accountType),
//             ]),
//
//             if (uploadedFiles.entries.any(
<<<<<<< HEAD
//               (entry) => entry.value['uploaded'] == true,
=======
//                   (entry) => entry.value['uploaded'] == true,
>>>>>>> 05bbda8 (update changes)
//             ))
//               _section('Uploaded Documents', [
//                 ...uploadedFiles.entries
//                     .where((entry) => entry.value['uploaded'] == true)
//                     .map((entry) => _documentFile(entry.key, entry.value)),
//               ]),
//
<<<<<<< HEAD
//             // _section('Declaration', [
//             //   _info('Authorized Signatory', signatureName),
//             //   _info('Name', declarationName),
//             //   if (declarationDate != null)
//             //     _info(
//             //       'Date',
//             //       '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
//             //     ),
//             // ]),
//
//             // In RegistrationSummaryScreen build method, keep the original declaration section:
=======
>>>>>>> 05bbda8 (update changes)
//             _section('Declaration', [
//               _info('Authorized Signatory', signatureName),
//               _info('Name', declarationName),
//               if (declarationDate != null)
//                 _info(
//                   'Date',
//                   '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
//                 ),
//               // Add declaration status
//               Container(
//                 padding: EdgeInsets.all(12),
//                 margin: EdgeInsets.only(top: 8),
//                 decoration: BoxDecoration(
//                   color: declarationAccepted
//                       ? Color(0xFFD1FAE5)
//                       : Color(0xFFFEE2E2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       declarationAccepted ? Icons.check_circle : Icons.error,
//                       color: declarationAccepted
//                           ? Color(0xFF059669)
//                           : Color(0xFFDC2626),
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       declarationAccepted
//                           ? 'Declaration accepted'
//                           : 'Declaration not accepted',
//                       style: TextStyle(
//                         color: declarationAccepted
//                             ? Color(0xFF059669)
//                             : Color(0xFFDC2626),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _successCard() {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [primary, Color(0xFFFF8A7A)]),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: const [
//           Icon(Icons.verified, color: Colors.white, size: 36),
//           SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Registration Submitted Successfully',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Your application has been submitted for review',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _section(String title, List<Widget> children) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: textDark,
//             ),
//           ),
//           const Divider(height: 24),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   Widget _info(String label, String value) {
//     return Padding(
<<<<<<< HEAD
//       padding: const EdgeInsets.only(bottom: 14),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 13, color: textLight),
//             ),
//           ),
//           Expanded(
//             flex: 6,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: textDark,
//               ),
//             ),
//           ),
//         ],
//       ),
=======
//         padding: const EdgeInsets.only(bottom: 14),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Text(
//                 label,
//                 style: const TextStyle(fontSize: 13, color: textLight),
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: textDark,
//                 ),
//               ),
//             ),
//           ],
//         ),
>>>>>>> 05bbda8 (update changes)
//     );
//   }
//
//   Widget _row(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: textDark,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _amenityCategory(String title, Map<String, bool> amenities) {
//     final selectedAmenities = amenities.entries
//         .where((entry) => entry.value)
//         .map((entry) => entry.key)
//         .toList();
//
//     if (selectedAmenities.isEmpty) return const SizedBox();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//               color: textDark,
//             ),
//           ),
//         ),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: selectedAmenities
//               .map(
//                 (amenity) => Container(
<<<<<<< HEAD
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: bg,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: border),
//                   ),
//                   child: Text(
//                     amenity,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: textLight,
//                     ),
//                   ),
//                 ),
//               )
=======
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 6,
//               ),
//               decoration: BoxDecoration(
//                 color: bg,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: border),
//               ),
//               child: Text(
//                 amenity,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: textLight,
//                 ),
//               ),
//             ),
//           )
>>>>>>> 05bbda8 (update changes)
//               .toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _fileInfo(String label, String fileName) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
//           const SizedBox(height: 4),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: bg,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: border),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 36,
//                   height: 36,
//                   decoration: BoxDecoration(
//                     color: primary.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Icon(Icons.photo, size: 18, color: primary),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     fileName,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: textDark,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _documentFile(String label, Map<String, dynamic> fileInfo) {
//     IconData getFileIcon() {
//       final fileName = fileInfo['name']?.toString().toLowerCase() ?? '';
//       if (fileName.endsWith('.pdf')) return Icons.picture_as_pdf;
//       if (fileName.endsWith('.jpg') ||
//           fileName.endsWith('.jpeg') ||
//           fileName.endsWith('.png'))
//         return Icons.image;
//       if (fileName.endsWith('.doc') || fileName.endsWith('.docx'))
//         return Icons.description;
//       if (label.contains('Signature')) return Icons.draw;
//       if (label.contains('FSSAI')) return Icons.restaurant;
//       return Icons.insert_drive_file;
//     }
//
//     Color getFileColor() {
//       if (label.contains('Signature')) return Colors.purple;
//       if (label.contains('FSSAI')) return Colors.green;
//       final fileName = fileInfo['name']?.toString().toLowerCase() ?? '';
//       if (fileName.endsWith('.pdf')) return Colors.red;
//       if (fileName.endsWith('.jpg') ||
//           fileName.endsWith('.jpeg') ||
//           fileName.endsWith('.png'))
//         return Colors.green;
//       if (fileName.endsWith('.doc') || fileName.endsWith('.docx'))
//         return Colors.blue;
//       return textLight;
//     }
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
//           const SizedBox(height: 4),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: bg,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: border),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: getFileColor().withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Icon(getFileIcon(), size: 20, color: getFileColor()),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         fileInfo['name'] ?? 'Document',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textDark,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 2),
//                       Row(
//                         children: [
//                           Text(
//                             '${(fileInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: textLight,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             width: 4,
//                             height: 4,
//                             decoration: const BoxDecoration(
//                               color: textLight,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             (fileInfo['name']
<<<<<<< HEAD
//                                     ?.toString()
//                                     .split('.')
//                                     .last
//                                     .toUpperCase() ??
=======
//                                 ?.toString()
//                                 .split('.')
//                                 .last
//                                 .toUpperCase() ??
>>>>>>> 05bbda8 (update changes)
//                                 'FILE'),
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: textLight,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.check_circle, size: 18, color: green),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
<<<<<<< HEAD
=======

>>>>>>> 05bbda8 (update changes)
class RegistrationSummaryScreen extends StatelessWidget {
  // Common fields for all hotel types
  final Map<String, dynamic> registrationData;
  final String hotelCategory;
  final bool declarationAccepted;

  // Fields from normal hotel form
  final String? hotelName;
  final String? hotelType;
  final String? yearOfEstablishment;
  final String? totalRooms;
  final String? ownerName;
  final String? mobileNumber;
  final String? alternateContact;
  final List<String>? landlineNumbers;
  final String? email;
  final String? website;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? district;
  final String? state;
  final String? pinCode;
  final String? landmark;
  final Map<String, bool>? selectedRoomTypes;
  final Map<String, Map<String, dynamic>>? roomDetails;
  final String? minTariff;
  final String? maxTariff;
  final bool? extraBedAvailable;
  final Map<String, bool>? basicAmenities;
  final Map<String, bool>? hotelFacilities;
  final Map<String, bool>? foodServices;
  final Map<String, bool>? additionalAmenities;
  final List<String>? customAmenities;
  final String? gstNumber;
  final String? fssaiLicense;
  final String? tradeLicense;
  final String? aadharNumber;
  final String? accountHolderName;
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  final String? branch;
  final String? accountType;
  final Map<String, Map<String, dynamic>>? uploadedFiles;
  final String? signatureName;
  final String? declarationName;
  final DateTime? declarationDate;
  final Map<String, dynamic>? personPhotoInfo;

  // Fields from 2-star hotel form
  final Map<String, bool>? roomAmenities;
  final Map<String, bool>? guestServices;
  final bool? coupleFriendly;
  final bool? petsAllowed;
  final String? selectedIdProof;
  final String? checkInTime;
  final String? checkOutTime;

  const RegistrationSummaryScreen({
    super.key,
    required this.registrationData,
    this.hotelCategory = 'Normal',
    this.declarationAccepted = false,

    // Normal hotel fields
    this.hotelName,
    this.hotelType,
    this.yearOfEstablishment,
    this.totalRooms,
    this.ownerName,
    this.mobileNumber,
    this.alternateContact,
    this.landlineNumbers,
    this.email,
    this.website,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.district,
    this.state,
    this.pinCode,
    this.landmark,
    this.selectedRoomTypes,
    this.roomDetails,
    this.minTariff,
    this.maxTariff,
    this.extraBedAvailable,
    this.basicAmenities,
    this.hotelFacilities,
    this.foodServices,
    this.additionalAmenities,
    this.customAmenities,
    this.gstNumber,
    this.fssaiLicense,
    this.tradeLicense,
    this.aadharNumber,
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.branch,
    this.accountType,
    this.uploadedFiles,
    this.signatureName,
    this.declarationName,
    this.declarationDate,
    this.personPhotoInfo,

    // 2-star hotel fields
    this.roomAmenities,
    this.guestServices,
    this.coupleFriendly,
    this.petsAllowed,
    this.selectedIdProof,
    this.checkInTime,
    this.checkOutTime,
  });

  // Helper method to get value from registrationData or direct field
  dynamic _getValue(String key, [dynamic defaultValue]) {
    // First check direct fields
    switch (key) {
      case 'hotelName': return hotelName ?? registrationData['hotelName'] ?? defaultValue;
      case 'hotelType': return hotelType ?? registrationData['hotelType'] ?? defaultValue;
      case 'hotelCategory': return hotelCategory;
      case 'yearOfEstablishment': return yearOfEstablishment ?? registrationData['yearOfEstablishment'] ?? defaultValue;
      case 'totalRooms': return totalRooms ?? registrationData['totalRooms'] ?? defaultValue;
      case 'ownerName': return ownerName ?? registrationData['ownerName'] ?? defaultValue;
      case 'mobileNumber': return mobileNumber ?? registrationData['mobileNumber'] ?? defaultValue;
      case 'alternateContact': return alternateContact ?? registrationData['alternateContact'] ?? defaultValue;
      case 'email': return email ?? registrationData['email'] ?? defaultValue;
      case 'website': return website ?? registrationData['website'] ?? defaultValue;
      case 'addressLine1': return addressLine1 ?? registrationData['addressLine1'] ?? defaultValue;
      case 'addressLine2': return addressLine2 ?? registrationData['addressLine2'] ?? defaultValue;
      case 'city': return city ?? registrationData['city'] ?? defaultValue;
      case 'district': return district ?? registrationData['district'] ?? defaultValue;
      case 'state': return state ?? registrationData['state'] ?? defaultValue;
      case 'pinCode': return pinCode ?? registrationData['pinCode'] ?? defaultValue;
      case 'landmark': return landmark ?? registrationData['landmark'] ?? defaultValue;
      case 'gstNumber': return gstNumber ?? registrationData['gstNumber'] ?? defaultValue;
      case 'fssaiLicense': return fssaiLicense ?? registrationData['fssaiLicense'] ?? defaultValue;
      case 'tradeLicense': return tradeLicense ?? registrationData['tradeLicense'] ?? defaultValue;
      case 'aadharNumber': return aadharNumber ?? registrationData['aadharNumber'] ?? defaultValue;
      case 'accountHolderName': return accountHolderName ?? registrationData['accountHolderName'] ?? defaultValue;
      case 'bankName': return bankName ?? registrationData['bankName'] ?? defaultValue;
      case 'accountNumber': return accountNumber ?? registrationData['accountNumber'] ?? defaultValue;
      case 'ifscCode': return ifscCode ?? registrationData['ifscCode'] ?? defaultValue;
      case 'branch': return branch ?? registrationData['branch'] ?? defaultValue;
      case 'accountType': return accountType ?? registrationData['accountType'] ?? defaultValue;
      case 'signatureName': return signatureName ?? registrationData['signatureName'] ?? defaultValue;
      case 'declarationName': return declarationName ?? registrationData['declarationName'] ?? defaultValue;
      case 'declarationAccepted': return declarationAccepted;

    // 2-star specific
      case 'coupleFriendly': return coupleFriendly ?? registrationData['coupleFriendly'] ?? defaultValue;
      case 'petsAllowed': return petsAllowed ?? registrationData['petsAllowed'] ?? defaultValue;
      case 'selectedIdProof': return selectedIdProof ?? registrationData['idProofRequired'] ?? defaultValue;
      case 'checkInTime': return checkInTime ?? registrationData['checkInTime'] ?? defaultValue;
      case 'checkOutTime': return checkOutTime ?? registrationData['checkOutTime'] ?? defaultValue;

    // Map fields
      case 'selectedRoomTypes': return selectedRoomTypes ?? registrationData['selectedRoomTypes'] ?? defaultValue;
      case 'roomDetails': return roomDetails ?? registrationData['roomDetails'] ?? defaultValue;
      case 'basicAmenities': return basicAmenities ?? registrationData['basicAmenities'] ?? defaultValue;
      case 'hotelFacilities': return hotelFacilities ?? registrationData['hotelFacilities'] ?? defaultValue;
      case 'foodServices': return foodServices ?? registrationData['foodServices'] ?? defaultValue;
      case 'additionalAmenities': return additionalAmenities ?? registrationData['additionalAmenities'] ?? defaultValue;
      case 'roomAmenities': return roomAmenities ?? registrationData['roomAmenities'] ?? defaultValue;
      case 'guestServices': return guestServices ?? registrationData['guestServices'] ?? defaultValue;
      case 'customAmenities': return customAmenities ?? registrationData['customAmenities'] ?? defaultValue;
      case 'uploadedFiles': return uploadedFiles ?? registrationData['uploadedFiles'] ?? defaultValue;
      case 'personPhotoInfo': return personPhotoInfo ?? registrationData['personPhotoInfo'] ?? defaultValue;
      case 'minTariff': return minTariff ?? registrationData['minTariff'] ?? defaultValue;
      case 'maxTariff': return maxTariff ?? registrationData['maxTariff'] ?? defaultValue;
      case 'extraBedAvailable': return extraBedAvailable ?? registrationData['extraBedAvailable'] ?? defaultValue;

      default: return registrationData[key] ?? defaultValue;
    }
  }

  // Check if it's a star hotel
  bool get isStarHotel {
    return hotelCategory.contains('Star') ||
        _getValue('roomAmenities') != null ||
        _getValue('hotelFacilities') != null ||
        _getValue('coupleFriendly') != null;
  }

  // Design constants
  static const Color primary = Color(0xFFFF5F6D);
  static const Color bg = Color(0xFFF9FAFB);
  static const Color textDark = Color(0xFF111827);
  static const Color textLight = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color green = Color(0xFF10B981);
  static const Color greenLight = Color(0xFFD1FAE5);
  static const Color starColor = Color(0xFFFFD700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          '$hotelCategory Hotel Registration Summary',
          style: TextStyle(fontWeight: FontWeight.w600, color: textDark),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: textDark),
      ),
      bottomNavigationBar: _buildFinishButton(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _successCard(),

            // Common sections for all hotels
            _buildHotelBasicInfoSection(),
            _buildContactInfoSection(),
            _buildAddressSection(),

            // Room configuration (common for all)
            _buildRoomConfigurationSection(),

            // Amenities sections (different for star vs normal)
            _buildAmenitiesSection(),

            // Policies (star hotel specific)
            if (isStarHotel) _buildPoliciesSection(),

            // Legal details (common)
            _buildLegalDetailsSection(),

            // Bank details (common)
            _buildBankDetailsSection(),

            // Documents (common)
            _buildDocumentsSection(),

            // Declaration (common)
            _buildDeclarationSection(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==================== SUCCESS CARD ====================
  Widget _successCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isStarHotel
              ? [Color(0xFF6B8E23), Color(0xFF9ACD32)] // Olive green for star hotels
              : [primary, Color(0xFFFF8A7A)], // Normal hotel color
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: Colors.white, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration Submitted Successfully',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_getValue('hotelName', 'Hotel')} ($hotelCategory)',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isStarHotel)
            Row(
              children: List.generate(hotelCategory.contains('2') ? 2 : 3, (index) =>
                  Icon(Icons.star, size: 18, color: starColor)
              ),
            ),
        ],
      ),
    );
  }

  // ==================== HOTEL BASIC INFO ====================
  Widget _buildHotelBasicInfoSection() {
    return _section('Hotel Information', [
      _info('Hotel Name', _getValue('hotelName', 'Not provided')),
      _info('Hotel Category', hotelCategory),
      if (_getValue('hotelType') != null)
        _info('Hotel Type', _getValue('hotelType')),
      if (_getValue('yearOfEstablishment') != null && _getValue('yearOfEstablishment').toString().isNotEmpty)
        _info('Year of Establishment', _getValue('yearOfEstablishment')),
      if (_getValue('totalRooms') != null && _getValue('totalRooms').toString().isNotEmpty)
        _info('Total Number of Rooms', _getValue('totalRooms')),

      // Star hotel specific check-in/out times
      if (isStarHotel && (_getValue('checkInTime') != null || _getValue('checkOutTime') != null))
        Row(
          children: [
            Expanded(
              child: _info('Check-in Time', _getValue('checkInTime', 'Not set')),
            ),
            Expanded(
              child: _info('Check-out Time', _getValue('checkOutTime', 'Not set')),
            ),
          ],
        ),
    ]);
  }

  // ==================== CONTACT INFO ====================
  Widget _buildContactInfoSection() {
    return _section('Contact Information', [
      _info('Owner Name', _getValue('ownerName', 'Not provided')),

      // Profile photo if exists
      if (_getValue('personPhotoInfo') != null && (_getValue('personPhotoInfo')['uploaded'] ?? false))
        _fileInfo('Profile Photo', _getValue('personPhotoInfo')['name'] ?? 'Photo'),

      _info('Mobile Number', _getValue('mobileNumber', 'Not provided')),

      if (_getValue('alternateContact') != null && _getValue('alternateContact').toString().isNotEmpty)
        _info('Alternate Contact', _getValue('alternateContact')),

      if (_getValue('landlineNumbers') != null && (_getValue('landlineNumbers') as List).isNotEmpty)
        ...(_getValue('landlineNumbers') as List).map((number) =>
            _info('Landline', number)
        ).toList(),

      if (_getValue('email') != null && _getValue('email').toString().isNotEmpty)
        _info('Email', _getValue('email')),

      if (_getValue('website') != null && _getValue('website').toString().isNotEmpty)
        _info('Website', _getValue('website')),
    ]);
  }

  // ==================== ADDRESS SECTION ====================
  Widget _buildAddressSection() {
    return _section('Hotel Address', [
      _info('Address Line 1', _getValue('addressLine1', 'Not provided')),

      if (_getValue('addressLine2') != null && _getValue('addressLine2').toString().isNotEmpty)
        _info('Address Line 2', _getValue('addressLine2')),

      _info('City', _getValue('city', 'Not provided')),
      _info('District', _getValue('district', 'Not provided')),
      _info('State', _getValue('state', 'Not provided')),
      _info('PIN Code', _getValue('pinCode', 'Not provided')),

      if (_getValue('landmark') != null && _getValue('landmark').toString().isNotEmpty)
        _info('Landmark', _getValue('landmark')),
    ]);
  }

  // ==================== ROOM CONFIGURATION ====================
  Widget _buildRoomConfigurationSection() {
    final selectedRoomTypes = _getValue('selectedRoomTypes', {});
    final roomDetails = _getValue('roomDetails', {});

    // Check if any room types are selected
    final hasSelectedRooms = selectedRoomTypes is Map &&
        selectedRoomTypes.entries.any((entry) => entry.value == true);

    if (!hasSelectedRooms) return const SizedBox();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    return _section('Room Configuration', [
      // Selected room types
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          'Selected Room Types:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: textDark,
          ),
        ),
      ),

      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: selectedTypes.map((type) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primary.withOpacity(0.3)),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primary,
            ),
          ),
        )).toList(),
      ),

      const SizedBox(height: 16),

      // Room details for each selected type
      ...selectedTypes.map((roomType) {
        final details = roomDetails[roomType] ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                roomType,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: textDark,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border),
              ),
              child: Column(
                children: [
                  if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                    _row('Number of Rooms', details['rooms'].toString()),

                  if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                    _row('Max Occupancy', '${details['occupancy']} Persons'),

                  if (details['price'] != null && details['price'].toString().isNotEmpty)
                    _row('Price per Night', '₹${details['price']}'),

                  if (details['ac'] != null)
                    _row('AC/Non-AC', details['ac'] == true ? 'AC' : 'Non-AC'),

                  if (details['extraBed'] != null)
                    _row('Extra Bed Available', details['extraBed'] == true ? 'Yes' : 'No'),

                  if (details['extraBed'] == true && details['extraBedPrice'] != null &&
                      details['extraBedPrice'].toString().isNotEmpty)
                    _row('Extra Bed Price', '₹${details['extraBedPrice']}'),
                ],
              ),
            ),
          ],
        );
      }).toList(),

      // Price range
      if ((_getValue('minTariff') != null && _getValue('minTariff').toString().isNotEmpty) ||
          (_getValue('maxTariff') != null && _getValue('maxTariff').toString().isNotEmpty))
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: greenLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: green.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Room Tariff Range', style: TextStyle(fontSize: 13, color: textLight)),
                  Text(
                    '₹${_getValue('minTariff', '0')} - ₹${_getValue('maxTariff', '0')}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: green,
                    ),
                  ),
                ],
              ),

              if (_getValue('extraBedAvailable') != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: green),
                  ),
                  child: Text(
                    _getValue('extraBedAvailable') == true
                        ? 'Extra Bed: Yes'
                        : 'Extra Bed: No',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: green,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ]);
  }

  // ==================== AMENITIES SECTION ====================
  // Widget _buildAmenitiesSection() {
  //   final List<Widget> amenitySections = [];
  //
  //   if (isStarHotel) {
  //     // Star hotel amenities structure
  //     final roomAmenities = _getValue('roomAmenities', {});
  //     final hotelFacilities = _getValue('hotelFacilities', {});
  //     final foodServices = _getValue('foodServices', {});
  //     final guestServices = _getValue('guestServices', {});
  //
  //     if (roomAmenities is Map && roomAmenities.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Room Amenities', roomAmenities));
  //
  //     if (hotelFacilities is Map && hotelFacilities.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Hotel Facilities', hotelFacilities));
  //
  //     if (foodServices is Map && foodServices.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Food & Beverage', foodServices));
  //
  //     if (guestServices is Map && guestServices.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Guest Services', guestServices));
  //   } else {
  //     // Normal hotel amenities structure
  //     final basicAmenities = _getValue('basicAmenities', {});
  //     final hotelFacilities = _getValue('hotelFacilities', {});
  //     final foodServices = _getValue('foodServices', {});
  //     final additionalAmenities = _getValue('additionalAmenities', {});
  //
  //     if (basicAmenities is Map && basicAmenities.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Basic Amenities', basicAmenities));
  //
  //     if (hotelFacilities is Map && hotelFacilities.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Hotel Facilities', hotelFacilities));
  //
  //     if (foodServices is Map && foodServices.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Food & Services', foodServices));
  //
  //     if (additionalAmenities is Map && additionalAmenities.entries.any((entry) => entry.value == true))
  //       amenitySections.add(_amenityCategory('Additional Amenities', additionalAmenities));
  //   }
  //
  //   // Custom amenities (common for both)
  //   final customAmenities = _getValue('customAmenities', []);
  //   if (customAmenities is List && customAmenities.isNotEmpty) {
  //     amenitySections.add(
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(bottom: 8),
  //             child: Text(
  //               'Custom Amenities',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 14,
  //                 color: textDark,
  //               ),
  //             ),
  //           ),
  //           Wrap(
  //             spacing: 8,
  //             runSpacing: 8,
  //             children: customAmenities.map((amenity) => Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: primary.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(20),
  //                 border: Border.all(color: primary.withOpacity(0.3)),
  //               ),
  //               child: Text(
  //                 amenity,
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w500,
  //                   color: primary,
  //                 ),
  //               ),
  //             )).toList(),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   if (amenitySections.isEmpty) return const SizedBox();
  //
  //   return _section('Amenities & Facilities', amenitySections);
  // }

  // Update the _getValue method to cast to Map<String, bool> when needed
  Map<String, bool>? _getAmenities(String key) {
    final value = _getValue(key);
    if (value is Map) {
      // Convert Map<dynamic, dynamic> to Map<String, bool>
      return Map<String, bool>.from(value.map((k, v) =>
          MapEntry(k.toString(), v is bool ? v : false)));
    }
    return null;
  }
  Widget _buildAmenitiesSection() {
    final List<Widget> amenitySections = [];

    if (isStarHotel) {
      // Star hotel amenities structure - use type-safe getter
      final roomAmenities = _getAmenities('roomAmenities');
      final hotelFacilities = _getAmenities('hotelFacilities');
      final foodServices = _getAmenities('foodServices');
      final guestServices = _getAmenities('guestServices');

      if (roomAmenities != null && roomAmenities.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Room Amenities', roomAmenities));

      if (hotelFacilities != null && hotelFacilities.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Hotel Facilities', hotelFacilities));

      if (foodServices != null && foodServices.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Food & Beverage', foodServices));

      if (guestServices != null && guestServices.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Guest Services', guestServices));
    } else {
      // Normal hotel amenities structure
      final basicAmenities = _getAmenities('basicAmenities');
      final hotelFacilities = _getAmenities('hotelFacilities');
      final foodServices = _getAmenities('foodServices');
      final additionalAmenities = _getAmenities('additionalAmenities');

      if (basicAmenities != null && basicAmenities.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Basic Amenities', basicAmenities));

      if (hotelFacilities != null && hotelFacilities.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Hotel Facilities', hotelFacilities));

      if (foodServices != null && foodServices.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Food & Services', foodServices));

      if (additionalAmenities != null && additionalAmenities.entries.any((entry) => entry.value == true))
        amenitySections.add(_amenityCategory('Additional Amenities', additionalAmenities));
    }

    // Custom amenities (common for both)
    final customAmenities = _getValue('customAmenities', []);
    if (customAmenities is List && customAmenities.isNotEmpty) {
      amenitySections.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Custom Amenities',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: textDark,
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: customAmenities.map((amenity) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primary.withOpacity(0.3)),
                ),
                child: Text(
                  amenity.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primary,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      );
    }

    if (amenitySections.isEmpty) return const SizedBox();

    return _section('Amenities & Facilities', amenitySections);
  }
  // ==================== POLICIES SECTION (Star Hotels Only) ====================
  Widget _buildPoliciesSection() {
    final coupleFriendly = _getValue('coupleFriendly');
    final petsAllowed = _getValue('petsAllowed');
    final selectedIdProof = _getValue('selectedIdProof');

    if (coupleFriendly == null && petsAllowed == null && selectedIdProof == null)
      return const SizedBox();

    return _section('Policies', [
      if (coupleFriendly != null)
        _info('Couple Friendly', coupleFriendly ? 'Yes' : 'No'),

      if (petsAllowed != null)
        _info('Pets Allowed', petsAllowed ? 'Yes' : 'No'),

      if (selectedIdProof != null && selectedIdProof.toString().isNotEmpty)
        _info('ID Proof Required', selectedIdProof),
    ]);
  }

  // ==================== LEGAL DETAILS ====================
  Widget _buildLegalDetailsSection() {
    final List<Widget> legalItems = [];

    if (_getValue('gstNumber') != null && _getValue('gstNumber').toString().isNotEmpty)
      legalItems.add(_info('GST Number', _getValue('gstNumber')));

    if (_getValue('fssaiLicense') != null && _getValue('fssaiLicense').toString().isNotEmpty)
      legalItems.add(_info('FSSAI License', _getValue('fssaiLicense')));

    if (_getValue('tradeLicense') != null && _getValue('tradeLicense').toString().isNotEmpty)
      legalItems.add(_info('Trade License', _getValue('tradeLicense')));

    if (_getValue('aadharNumber') != null && _getValue('aadharNumber').toString().isNotEmpty)
      legalItems.add(_info('Aadhar Number', _getValue('aadharNumber')));

    if (legalItems.isEmpty) return const SizedBox();

    return _section('Legal Details', legalItems);
  }

  // ==================== BANK DETAILS ====================
  Widget _buildBankDetailsSection() {
    return _section('Bank Details', [
      _info('Account Holder', _getValue('accountHolderName', 'Not provided')),
      _info('Bank Name', _getValue('bankName', 'Not provided')),
      _info('Account Number', _getValue('accountNumber', 'Not provided')),
      _info('IFSC Code', _getValue('ifscCode', 'Not provided')),

      if (_getValue('branch') != null && _getValue('branch').toString().isNotEmpty)
        _info('Branch', _getValue('branch')),

      if (_getValue('accountType') != null && _getValue('accountType').toString().isNotEmpty)
        _info('Account Type', _getValue('accountType')),
    ]);
  }

  // ==================== DOCUMENTS SECTION ====================
  Widget _buildDocumentsSection() {
    final uploadedFiles = _getValue('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty)
      return const SizedBox();

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox();

    return _section('Uploaded Documents', [
      ...uploadedDocs.map((entry) => _documentFile(entry.key, entry.value)).toList(),
    ]);
  }

  // ==================== DECLARATION SECTION ====================
  Widget _buildDeclarationSection() {
    return _section('Declaration', [
      if (_getValue('signatureName') != null && _getValue('signatureName').toString().isNotEmpty)
        _info('Authorized Signatory', _getValue('signatureName')),

      if (_getValue('declarationName') != null && _getValue('declarationName').toString().isNotEmpty)
        _info('Name', _getValue('declarationName')),

      if (_getValue('declarationDate') != null)
        _info('Date', '${_getValue('declarationDate').day}/${_getValue('declarationDate').month}/${_getValue('declarationDate').year}'),

      // Declaration status
      Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: _getValue('declarationAccepted')
              ? Color(0xFFD1FAE5)
              : Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              _getValue('declarationAccepted') ? Icons.check_circle : Icons.error,
              color: _getValue('declarationAccepted')
                  ? Color(0xFF059669)
                  : Color(0xFFDC2626),
            ),
            SizedBox(width: 8),
            Text(
              _getValue('declarationAccepted')
                  ? 'Declaration accepted'
                  : 'Declaration not accepted',
              style: TextStyle(
                color: _getValue('declarationAccepted')
                    ? Color(0xFF059669)
                    : Color(0xFFDC2626),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  // ==================== FINISH BUTTON ====================
  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isStarHotel ? Color(0xFF6B8E23) : primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            // Navigate to LoginPage or wherever you want
            final allData = Map<String, dynamic>.from(registrationData);

            // Add direct fields if they exist
            if (hotelCategory != 'Normal') allData['hotelCategory'] = hotelCategory;
            if (declarationAccepted) allData['declarationAccepted'] = declarationAccepted;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyAuthScreen(
                  registrationData: allData,
                ),
              ),
                  (route) => false,
            );
          },
          child: Text(
            'Finish Registration',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== HELPER WIDGETS ====================

  Widget _section(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isStarHotel && title == 'Hotel Information')
                Icon(Icons.star, size: 16, color: starColor),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textDark,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _info(String label, dynamic value) {
    if (value == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: textLight),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _amenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: textDark,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities.map((amenity) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: border),
            ),
            child: Text(
              amenity,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textLight,
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _fileInfo(String label, String fileName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.photo, size: 18, color: primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentFile(String label, Map<String, dynamic> fileInfo) {
    IconData getFileIcon() {
      final fileName = fileInfo['name']?.toString().toLowerCase() ?? '';
      if (fileName.endsWith('.pdf')) return Icons.picture_as_pdf;
      if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg') || fileName.endsWith('.png'))
        return Icons.image;
      if (fileName.endsWith('.doc') || fileName.endsWith('.docx'))
        return Icons.description;
      if (label.contains('Signature')) return Icons.draw;
      if (label.contains('FSSAI')) return Icons.restaurant;
      return Icons.insert_drive_file;
    }

    Color getFileColor() {
      if (label.contains('Signature')) return Colors.purple;
      if (label.contains('FSSAI')) return Colors.green;
      final fileName = fileInfo['name']?.toString().toLowerCase() ?? '';
      if (fileName.endsWith('.pdf')) return Colors.red;
      if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg') || fileName.endsWith('.png'))
        return Colors.green;
      if (fileName.endsWith('.doc') || fileName.endsWith('.docx'))
        return Colors.blue;
      return textLight;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: textLight)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: border),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: getFileColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(getFileIcon(), size: 20, color: getFileColor()),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileInfo['name'] ?? 'Document',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '${(fileInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                            style: const TextStyle(
                              fontSize: 11,
                              color: textLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: textLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            (fileInfo['name']?.toString().split('.').last.toUpperCase() ?? 'FILE'),
                            style: const TextStyle(
                              fontSize: 11,
                              color: textLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 18, color: green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelOwnerDashboard extends StatefulWidget {
  final String hotelName;
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String district;
  final String state;
  final String pinCode;
  final String gstNumber;
  final String fssaiLicense;
  final String tradeLicense;
  final String panNumber;
  final String aadharNumber;
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branch;
  final String accountType;
  final int totalRooms;
  final Map<String, dynamic> personPhotoInfo;
  // Add registrationData field
  final Map<String, dynamic> registrationData;
  const HotelOwnerDashboard({
    Key? key,
    required this.hotelName,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.gstNumber,
    required this.fssaiLicense,
    required this.tradeLicense,
    required this.panNumber,
    required this.aadharNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branch,
    required this.accountType,
    required this.totalRooms,
    required this.personPhotoInfo,
    this.registrationData = const {},
  }) : super(key: key);

  @override
  State<HotelOwnerDashboard> createState() => _HotelOwnerDashboardState();
}

// class _HotelOwnerDashboardState extends State<HotelOwnerDashboard> {
//   int _selectedIndex = 0;
//   final Color _primaryColor = Color(0xFFFF5F6D);
//   final Color _bgColor = Color(0xFFF9FAFB);
//   final Color _textDark = Color(0xFF111827);
//   final Color _textLight = Color(0xFF6B7280);
//   final Color _borderColor = Color(0xFFE5E7EB);
//
//   List<Map<String, dynamic>> _todayBookings = [
//     {
//       'room': '101',
//       'guest': 'John Doe',
//       'checkIn': '14:00',
//       'checkOut': '12:00',
//       'status': 'Checked In',
//     },
//     {
//       'room': '203',
//       'guest': 'Jane Smith',
//       'checkIn': '15:30',
//       'checkOut': '11:00',
//       'status': 'Pending',
//     },
//     {
//       'room': '305',
//       'guest': 'Robert Brown',
//       'checkIn': '12:00',
//       'checkOut': '10:00',
//       'status': 'Checked Out',
//     },
//   ];
//
//   List<Map<String, dynamic>> _recentReviews = [
//     {
//       'guest': 'Alice Johnson',
//       'rating': 4.5,
//       'comment': 'Great service!',
//       'date': '2024-01-20',
//     },
//     {
//       'guest': 'Mark Wilson',
//       'rating': 3.8,
//       'comment': 'Clean rooms',
//       'date': '2024-01-19',
//     },
//     {
//       'guest': 'Sarah Lee',
//       'rating': 5.0,
//       'comment': 'Excellent experience',
//       'date': '2024-01-18',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: _bgColor,
//       appBar: _buildAppBar(w),
//       drawer: _buildDrawer(w),
//       body: _buildBody(w, h),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//       floatingActionButton: _selectedIndex == 1
//           ? FloatingActionButton(
//               backgroundColor: _primaryColor,
//               onPressed: () {},
//               child: Icon(Icons.add, color: Colors.white),
//             )
//           : null,
//     );
//   }
//
//   AppBar _buildAppBar(double w) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 1,
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: Icon(Icons.menu, color: _textDark),
//           onPressed: () => Scaffold.of(context).openDrawer(),
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Welcome back ${widget.ownerName}!',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             DateFormat('EEEE, MMMM d').format(DateTime.now()),
//             style: TextStyle(fontSize: 12, color: _textLight),
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.person_outline, color: _textDark),
//           onPressed: () => _showProfile(),
//         ),
//       ],
//     );
//   }
//
//   Drawer _buildDrawer(double w) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [_primaryColor, Color(0xFFFF8A7A)],
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.hotel, size: 32, color: _primaryColor),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   widget.hotelName,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   'Owner: ${widget.ownerName}',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
//           _buildDrawerItem(Icons.bed, 'Room Management', 1),
//           _buildDrawerItem(Icons.calendar_today, 'Bookings', 2),
//           _buildDrawerItem(Icons.attach_money, 'Revenue', 3),
//           _buildDrawerItem(Icons.star, 'Reviews & Ratings', 4),
//           _buildDrawerItem(Icons.people, 'Staff Management', 5),
//           Divider(),
//           _buildDrawerItem(Icons.settings, 'Hotel Settings', 6),
//           _buildDrawerItem(Icons.help_outline, 'Help & Support', 7),
//           _buildDrawerItem(Icons.logout, 'Logout', 8),
//         ],
//       ),
//     );
//   }
//
//   ListTile _buildDrawerItem(IconData icon, String title, int index) {
//     return ListTile(
//       leading: Icon(icon, color: _textDark),
//       title: Text(title, style: TextStyle(color: _textDark)),
//       selected: _selectedIndex == index,
//       selectedTileColor: _primaryColor.withOpacity(0.1),
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//         Navigator.pop(context);
//       },
//     );
//   }
//
//   Widget _buildBody(double w, double h) {
//     switch (_selectedIndex) {
//       case 0:
//         return _buildDashboard(w, h);
//       case 1:
//         return _buildRoomManagement();
//       case 2:
//         return _buildBookings();
//       case 3:
//         return _buildRevenue();
//       case 4:
//         return _buildReviews();
//       default:
//         return _buildDashboard(w, h);
//     }
//   }
//
//   // Widget _buildDashboard(double w, double h) {
//   //   return SingleChildScrollView(
//   //     padding: EdgeInsets.all(26),
//   //     child: Column(
//   //       children: [
//   //         Container(
//   //           padding: EdgeInsets.all(20),
//   //           margin: EdgeInsets.only(bottom: 20),
//   //           decoration: BoxDecoration(
//   //             gradient: LinearGradient(
//   //               colors: [_primaryColor, Color(0xFFFF8A7A)],
//   //               begin: Alignment.topLeft,
//   //               end: Alignment.bottomRight,
//   //             ),
//   //             borderRadius: BorderRadius.circular(16),
//   //             boxShadow: [
//   //               BoxShadow(
//   //                 color: _primaryColor.withOpacity(0.3),
//   //                 blurRadius: 10,
//   //                 offset: Offset(0, 5),
//   //               ),
//   //             ],
//   //           ),
//   //           child: Row(
//   //             children: [
//   //               Expanded(
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     // Text(
//   //                     //   'Welcome back, ${widget.ownerName}!',
//   //                     //   style: TextStyle(
//   //                     //     color: Colors.white,
//   //                     //     fontSize: 20,
//   //                     //     fontWeight: FontWeight.w600,
//   //                     //   ),
//   //                     // ),
//   //                     SizedBox(height: 8),
//   //                     Text(
//   //                       'Manage your hotel efficiently with real-time updates',
//   //                       style: TextStyle(
//   //                         color: Colors.white.withOpacity(0.9),
//   //                         fontSize: 14,
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //               SizedBox(width: 20),
//   //               Container(
//   //                 width: 60,
//   //                 height: 60,
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.white.withOpacity(0.2),
//   //                   shape: BoxShape.circle,
//   //                 ),
//   //                 child: Center(
//   //                   child: Icon(Icons.hotel, size: 30, color: Colors.white),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //
//   //         SizedBox(height: 20),
//   //         GridView.count(
//   //           shrinkWrap: true,
//   //           physics: NeverScrollableScrollPhysics(),
//   //           crossAxisCount: 2,
//   //           crossAxisSpacing: 12,
//   //           mainAxisSpacing: 12,
//   //           children: [
//   //             _statCard(
//   //               icon: Icons.bed,
//   //               title: 'Total Rooms',
//   //               value: widget.totalRooms.toString(),
//   //               color: Colors.blue,
//   //             ),
//   //             _statCard(
//   //               icon: Icons.people,
//   //               title: 'Occupied Today',
//   //               value: '8',
//   //               color: Colors.green,
//   //             ),
//   //             _statCard(
//   //               icon: Icons.attach_money,
//   //               title: 'Today\'s Revenue',
//   //               value: '₹25,400',
//   //               color: Colors.orange,
//   //             ),
//   //             _statCard(
//   //               icon: Icons.star,
//   //               title: 'Avg Rating',
//   //               value: '4.2',
//   //               color: Colors.purple,
//   //             ),
//   //           ],
//   //         ),
//   //
//   //         SizedBox(height: 24),
//   //
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: [
//   //             Text(
//   //               "Today's Bookings",
//   //               style: TextStyle(
//   //                 fontSize: 18,
//   //                 fontWeight: FontWeight.w700,
//   //                 color: _textDark,
//   //               ),
//   //             ),
//   //             TextButton(
//   //               onPressed: () {},
//   //               child: Text('View All', style: TextStyle(color: _primaryColor)),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 12),
//   //         _buildBookingsList(),
//   //
//   //         SizedBox(height: 24),
//   //
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: [
//   //             Text(
//   //               "Recent Reviews",
//   //               style: TextStyle(
//   //                 fontSize: 18,
//   //                 fontWeight: FontWeight.w700,
//   //                 color: _textDark,
//   //               ),
//   //             ),
//   //             TextButton(
//   //               onPressed: () {},
//   //               child: Text('See All', style: TextStyle(color: _primaryColor)),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 12),
//   //         _buildReviewsList(),
//   //
//   //         SizedBox(height: 40),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildDashboard(double w, double h) {
//     // Calculate statistics from room details
//     int totalConfiguredRooms = 0;
//     int acRooms = 0;
//     int nonAcRooms = 0;
//     int availableRooms = 0;
//     int bookedRooms = 0;
//
//     // Calculate room type breakdown
//     Map<String, int> roomTypeCounts = {};
//
//     widget.registrationData?['roomDetails']?.forEach((roomType, details) {
//       final rooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
//       final isAC = details['ac'] ?? true;
//
//       totalConfiguredRooms += rooms;
//       if (isAC) {
//         acRooms += rooms;
//       } else {
//         nonAcRooms += rooms;
//       }
//
//       // For demo, assuming 30% of rooms are booked
//       bookedRooms += (rooms * 0.3).round();
//       availableRooms += rooms - (rooms * 0.3).round();
//
//       // Track room types
//       roomTypeCounts[roomType] = rooms;
//     });
//
//     // Monthly booking data (dummy data for demo)
//     List<Map<String, dynamic>> monthlyBookings = [
//       {'month': 'Jan', 'bookings': 45, 'revenue': 125000},
//       {'month': 'Feb', 'bookings': 52, 'revenue': 142000},
//       {'month': 'Mar', 'bookings': 48, 'revenue': 138000},
//       {'month': 'Apr', 'bookings': 60, 'revenue': 165000},
//       {'month': 'May', 'bookings': 55, 'revenue': 152000},
//       {'month': 'Jun', 'bookings': 65, 'revenue': 178000},
//     ];
//
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Welcome Card
//           Container(
//             padding: EdgeInsets.all(20),
//             margin: EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [_primaryColor, Color(0xFFFF8A7A)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: _primaryColor.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.hotelName,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '${widget.registrationData?['hotelType'] ?? 'Hotel'} • ${widget.registrationData?['yearOfEstablishment'] ?? 'Established'}',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 14,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '${widget.addressLine1}, ${widget.city}',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Icon(Icons.hotel, size: 30, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Room Statistics Grid
//           Text(
//             'Room Statistics',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: _textDark,
//             ),
//           ),
//           SizedBox(height: 12),
//           GridView.count(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             children: [
//               _statCard(
//                 icon: Icons.meeting_room,
//                 title: 'Total Rooms',
//                 value: widget.totalRooms.toString(),
//                 color: Colors.blue,
//                 subtitle: 'Configured: $totalConfiguredRooms',
//               ),
//               _statCard(
//                 icon: Icons.bed,
//                 title: 'Available Rooms',
//                 value: availableRooms.toString(),
//                 color: Colors.green,
//                 subtitle: 'Ready for booking',
//               ),
//               _statCard(
//                 icon: Icons.people,
//                 title: 'Occupied Rooms',
//                 value: bookedRooms.toString(),
//                 color: Colors.orange,
//                 subtitle: 'Currently booked',
//               ),
//               _statCard(
//                 icon: Icons.bedroom_parent,
//                 title: 'Vacant Rooms',
//                 value: (widget.totalRooms - totalConfiguredRooms).toString(),
//                 color: Colors.purple,
//                 subtitle: 'Not configured',
//               ),
//             ],
//           ),
//
//           SizedBox(height: 20),
//
//           // AC/Non-AC Breakdown
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: _borderColor),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'AC/Non-AC Distribution',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: _textDark,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildRoomTypeCard(
//                         icon: Icons.ac_unit,
//                         title: 'AC Rooms',
//                         count: acRooms,
//                         percentage: totalConfiguredRooms > 0
//                             ? ((acRooms / totalConfiguredRooms) * 100).round()
//                             : 0,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: _buildRoomTypeCard(
//                         icon: Icons.air,
//                         title: 'Non-AC Rooms',
//                         count: nonAcRooms,
//                         percentage: totalConfiguredRooms > 0
//                             ? ((nonAcRooms / totalConfiguredRooms) * 100).round()
//                             : 0,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // Room Type Breakdown
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: _borderColor),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Room Type Distribution',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: _textDark,
//                       ),
//                     ),
//                     Text(
//                       'Total: $totalConfiguredRooms rooms',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: _textLight,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 ...roomTypeCounts.entries.map((entry) {
//                   String roomType = entry.key;
//                   int count = entry.value;
//                   double percentage = totalConfiguredRooms > 0
//                       ? (count / totalConfiguredRooms) * 100
//                       : 0;
//
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 12),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 36,
//                                   height: 36,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.king_bed,
//                                       size: 18,
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       roomType,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: _textDark,
//                                       ),
//                                     ),
//                                     Text(
//                                       '$count rooms • ${percentage.toStringAsFixed(1)}%',
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: _textLight,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.bed, size: 12, color: Colors.blue),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     '${(count * 0.7).round()} available',
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         LinearProgressIndicator(
//                           value: count / widget.totalRooms,
//                           backgroundColor: Colors.grey[200],
//                           color: Colors.blue,
//                           minHeight: 4,
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // Monthly Booking Insights
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: _borderColor),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Monthly Booking Insights',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: _textDark,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         'Last 6 months',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: _textLight,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//
//                 // Month selector
//                 SizedBox(
//                   height: 40,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: monthlyBookings.map((monthData) {
//                       return Container(
//                         margin: EdgeInsets.only(right: 8),
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: monthData['month'] == 'Jun'
//                               ? _primaryColor
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: monthData['month'] == 'Jun'
//                                 ? _primaryColor
//                                 : _borderColor,
//                           ),
//                         ),
//                         child: Text(
//                           monthData['month'],
//                           style: TextStyle(
//                             color: monthData['month'] == 'Jun'
//                                 ? Colors.white
//                                 : _textDark,
//                             fontWeight: monthData['month'] == 'Jun'
//                                 ? FontWeight.w600
//                                 : FontWeight.normal,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Bar chart
//                 Container(
//                   height: 200,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: monthlyBookings.map((monthData) {
//                       double heightPercentage = (monthData['bookings'] / 100) * 0.8;
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             width: 25,
//                             height: 180 * heightPercentage,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   _primaryColor.withOpacity(0.8),
//                                   _primaryColor,
//                                 ],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 monthData['bookings'].toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             monthData['month'],
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: _textLight,
//                             ),
//                           ),
//                           Text(
//                             '₹${(monthData['revenue'] / 1000).toStringAsFixed(0)}K',
//                             style: TextStyle(
//                               fontSize: 10,
//                               color: _textDark,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 SizedBox(height: 16),
//                 Divider(),
//                 SizedBox(height: 8),
//
//                 // Statistics
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           'Total Bookings',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: _textLight,
//                           ),
//                         ),
//                         Text(
//                           monthlyBookings.fold<int>(0, (sum, item) => sum + (item['bookings'] as int)).toString(),
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: _textDark,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           'Avg Monthly',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: _textLight,
//                           ),
//                         ),
//                         Text(
//                           '${(monthlyBookings.fold<int>(0, (sum, item) => sum + (item['bookings'] as int)) / monthlyBookings.length).toStringAsFixed(0)} bookings',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: _textDark,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           'Total Revenue',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: _textLight,
//                           ),
//                         ),
//                         Text(
//                           '₹${(monthlyBookings.fold<int>(0, (sum, item) => sum + (item['revenue'] as int)) / 100000).toStringAsFixed(1)}L',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: _textDark,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // Booking Status Overview
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: _borderColor),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Booking Status Distribution',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: _textDark,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     _buildBookingStatusCard(
//                       title: 'Confirmed',
//                       count: 42,
//                       color: Colors.green,
//                       percentage: 60,
//                     ),
//                     SizedBox(width: 12),
//                     _buildBookingStatusCard(
//                       title: 'Pending',
//                       count: 18,
//                       color: Colors.orange,
//                       percentage: 25,
//                     ),
//                     SizedBox(width: 12),
//                     _buildBookingStatusCard(
//                       title: 'Cancelled',
//                       count: 10,
//                       color: Colors.red,
//                       percentage: 15,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
//
// // Helper method for room type card
//   Widget _buildRoomTypeCard({
//     required IconData icon,
//     required String title,
//     required int count,
//     required int percentage,
//     required Color color,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Icon(icon, size: 18, color: color),
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: _textDark,
//                       ),
//                     ),
//                     Text(
//                       '$count rooms',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: _textLight,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           LinearProgressIndicator(
//             value: percentage / 100,
//             backgroundColor: color.withOpacity(0.2),
//             color: color,
//             minHeight: 6,
//           ),
//           SizedBox(height: 4),
//           Text(
//             '$percentage% of total',
//             style: TextStyle(
//               fontSize: 10,
//               color: _textLight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// // Helper method for booking status card
//   Widget _buildBookingStatusCard({
//     required String title,
//     required int count,
//     required Color color,
//     required int percentage,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: color.withOpacity(0.2)),
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   '$percentage%',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: color,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: _textDark,
//               ),
//             ),
//             Text(
//               '$count bookings',
//               style: TextStyle(
//                 fontSize: 11,
//                 color: _textLight,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// // Update existing statCard method to include subtitle
//   Widget _statCard({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//     String subtitle = '',
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _borderColor),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(child: Icon(icon, size: 20, color: color)),
//           ),
//           SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: _textDark,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(title, style: TextStyle(fontSize: 13, color: _textLight)),
//           if (subtitle.isNotEmpty) ...[
//             SizedBox(height: 2),
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 11, color: _textLight.withOpacity(0.7)),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget _buildBookingsList() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _borderColor),
//       ),
//       child: Column(
//         children: _todayBookings.map((booking) {
//           Color statusColor = Colors.grey;
//           if (booking['status'] == 'Checked In') statusColor = Colors.green;
//           if (booking['status'] == 'Pending') statusColor = Colors.orange;
//           if (booking['status'] == 'Checked Out') statusColor = Colors.blue;
//
//           return Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom:
//                     _todayBookings.indexOf(booking) < _todayBookings.length - 1
//                     ? BorderSide(color: _borderColor)
//                     : BorderSide.none,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: _primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       booking['room'],
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         color: _primaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         booking['guest'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: _textDark,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Check-in: ${booking['checkIn']} | Check-out: ${booking['checkOut']}',
//                         style: TextStyle(fontSize: 12, color: _textLight),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: statusColor),
//                   ),
//                   child: Text(
//                     booking['status'],
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: statusColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildReviewsList() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _borderColor),
//       ),
//       child: Column(
//         children: _recentReviews.map((review) {
//           return Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom:
//                     _recentReviews.indexOf(review) < _recentReviews.length - 1
//                     ? BorderSide(color: _borderColor)
//                     : BorderSide.none,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.amber.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(child: Icon(Icons.person, color: Colors.amber)),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             review['guest'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: _textDark,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.star, size: 16, color: Colors.amber),
//                               SizedBox(width: 4),
//                               Text(
//                                 review['rating'].toString(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: _textDark,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         review['comment'],
//                         style: TextStyle(color: _textLight),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         review['date'],
//                         style: TextStyle(fontSize: 11, color: _textLight),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildRoomManagement() {
//     return Center(child: Text('Room Management - Coming Soon'));
//   }
//
//   Widget _buildBookings() {
//     return Center(child: Text('Bookings - Coming Soon'));
//   }
//
//   Widget _buildRevenue() {
//     return Center(child: Text('Revenue - Coming Soon'));
//   }
//
//   Widget _buildReviews() {
//     return Center(child: Text('Reviews - Coming Soon'));
//   }
//
//   BottomNavigationBar _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       currentIndex: _selectedIndex,
//       selectedItemColor: _primaryColor,
//       unselectedItemColor: _textLight,
//       showUnselectedLabels: true,
//       onTap: (index) {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.bed), label: 'Rooms'),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.calendar_today),
//           label: 'Bookings',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.attach_money),
//           label: 'Revenue',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Reviews'),
//       ],
//     );
//   }
//
//   // void _showProfile() {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => HotelOwnerProfilePage(
//   //         hotelName: widget.hotelName,
//   //         ownerName: widget.ownerName,
//   //         mobileNumber: widget.mobileNumber,
//   //         email: widget.email,
//   //         addressLine1: widget.addressLine1,
//   //         addressLine2: widget.addressLine2,
//   //         city: widget.city,
//   //         district: widget.district,
//   //         state: widget.state,
//   //         pinCode: widget.pinCode,
//   //         gstNumber: widget.gstNumber,
//   //         fssaiLicense: widget.fssaiLicense,
//   //         tradeLicense: widget.tradeLicense,
//   //         panNumber: widget.panNumber,
//   //         aadharNumber: widget.aadharNumber,
//   //         accountHolderName: widget.accountHolderName,
//   //         bankName: widget.bankName,
//   //         accountNumber: widget.accountNumber,
//   //         ifscCode: widget.ifscCode,
//   //         branch: widget.branch,
//   //         accountType: widget.accountType,
//   //         totalRooms: widget.totalRooms, // Convert int to String
//   //         personPhotoInfo: {
//   //           'url': widget.personPhotoInfo,
//   //           'fileName': 'profile_photo.jpg',
//   //           'uploadDate': DateTime.now().toIso8601String(),
//   //           'fileSize': 0,
//   //           'description': 'Profile photo',
//   //         }, selectedRoomTypes: {}, roomDetails: {}, basicAmenities: {}, hotelFacilities: {}, foodServices: {}, additionalAmenities: {}, customAmenities: [],
//   //        // Changed to bool
//   //       ),
//   //     ),
//   //   );
//   // }
//   void _showProfile() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HotelOwnerProfilePage(
//           hotelName: widget.hotelName,
//           ownerName: widget.ownerName,
//           mobileNumber: widget.mobileNumber,
//           email: widget.email,
//           addressLine1: widget.addressLine1,
//           addressLine2: widget.addressLine2,
//           city: widget.city,
//           district: widget.district,
//           state: widget.state,
//           pinCode: widget.pinCode,
//           gstNumber: widget.gstNumber,
//           fssaiLicense: widget.fssaiLicense,
//           tradeLicense: widget.tradeLicense,
//           panNumber: widget.panNumber,
//           aadharNumber: widget.aadharNumber,
//           accountHolderName: widget.accountHolderName,
//           bankName: widget.bankName,
//           accountNumber: widget.accountNumber,
//           ifscCode: widget.ifscCode,
//           branch: widget.branch,
//           accountType: widget.accountType,
//           totalRooms: widget.totalRooms,
//           personPhotoInfo: widget.personPhotoInfo,
//           // Add all the additional fields from registration
//           hotelType: widget.registrationData?['hotelType'] ?? '',
//           yearOfEstablishment: widget.registrationData?['yearOfEstablishment'] ?? '',
//           website: widget.registrationData?['website'] ?? '',
//           landmark: widget.registrationData?['landmark'] ?? '',
//           selectedRoomTypes: widget.registrationData?['selectedRoomTypes'] ?? {},
//           roomDetails: widget.registrationData?['roomDetails'] ?? {},
//           minTariff: widget.registrationData?['minTariff'] ?? '',
//           maxTariff: widget.registrationData?['maxTariff'] ?? '',
//           extraBedAvailable: widget.registrationData?['extraBedAvailable'] ?? false,
//           basicAmenities: widget.registrationData?['basicAmenities'] ?? {},
//           hotelFacilities: widget.registrationData?['hotelFacilities'] ?? {},
//           foodServices: widget.registrationData?['foodServices'] ?? {},
//           additionalAmenities: widget.registrationData?['additionalAmenities'] ?? {},
//           customAmenities: widget.registrationData?['customAmenities'] ?? [],
//           alternateContact: widget.registrationData?['alternateContact'] ?? '',
//           landlineNumbers: widget.registrationData?['landlineNumbers'] ?? [],
//           uploadedFiles: widget.registrationData?['uploadedFiles'] ?? {},
//           signatureName: widget.registrationData?['signatureName'] ?? '',
//           declarationName: widget.registrationData?['declarationName'] ?? '',
//           declarationDate: widget.registrationData?['declarationDate'],
//           declarationAccepted: widget.registrationData?['declarationAccepted'] ?? false,
//         ),
//       ),
//     );
//   }
// }







class _HotelOwnerDashboardState extends State<HotelOwnerDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = Color(0xFFFF5F6D);
  final Color _primaryLight = Color(0xFFFF8A7A);
  final Color _secondaryColor = Color(0xFF4A6FA5);
  final Color _accentColor = Color(0xFF6BCF7F);
  final Color _bgColor = Color(0xFFF9FAFB);
  final Color _cardBg = Colors.white;
  final Color _textDark = Color(0xFF111827);
  final Color _textLight = Color(0xFF6B7280);
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _successColor = Color(0xFF10B981);
  final Color _warningColor = Color(0xFFF59E0B);
  final Color _dangerColor = Color(0xFFEF4444);

  // State variables
  String _selectedMonth = 'January';
  List<String> _months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    bool isTablet = w > 600;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(w),
      body: _buildBody(w, h, isTablet),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
        backgroundColor: _primaryColor,
        onPressed: () => _addNewRoom(),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
          : null,
    );
  }

  // Step 1: Redesigned AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _cardBg,
      elevation: 2,
      shadowColor: Colors.black12,
      leading: Builder(
        builder: (context) => Container(
          margin: EdgeInsets.only(left: 16),
          child: IconButton(
            icon: Icon(Icons.menu_rounded, color: _primaryColor, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title: Row(
        children: [

          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // widget.hotelName,
                'Welcome Back!',
                style: TextStyle(
                  color: _textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Owner Dashboard',
                style: TextStyle(
                  color: _textLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.notifications_none_rounded, color: _textDark, size: 24),
        //   // onPressed: () => _showNotifications(),
        // ),
        SizedBox(width: 8),
        // Profile Icon in right corner
        Container(
          margin: EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => _showProfile(),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: _primaryColor.withOpacity(0.1),
              child: Icon(Icons.person_rounded, color: _primaryColor, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(double w, double h, bool isTablet) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {});
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 2: Summary Section
            _buildSummarySection(),

            SizedBox(height: 24),

            // Step 3: Hotel Description
            _buildHotelDescription(),

            SizedBox(height: 24),

            // Step 4: Detailed Room Breakdown
            _buildDetailedRoomBreakdown(),

            SizedBox(height: 24),

            // Step 5: Booking Insights with Graph
            _buildBookingInsightsGraph(),

            SizedBox(height: 24),

            // Step 6: Monthly Booking Statistics
            _buildMonthlyBookingStats(),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Step 2: Summary Section
  Widget _buildSummarySection() {
    final roomDetails = widget.registrationData?['roomDetails'] ?? {};
    int totalConfiguredRooms = 0;
    int totalAvailableRooms = 0;
    int totalOccupiedRooms = 0;

    // Calculate room statistics
    roomDetails.forEach((type, details) {
      int rooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
      totalConfiguredRooms += rooms;

      // For demo: Assume 35% available, 55% occupied
      totalAvailableRooms += (rooms * 0.35).round();
      totalOccupiedRooms += (rooms * 0.55).round();
    });

    int totalRooms = widget.totalRooms;
    int notConfiguredRooms = totalRooms - totalConfiguredRooms;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hotel Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Live Status',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildSummaryCard(
              title: 'Total Rooms',
              value: totalRooms.toString(),
              icon: Icons.meeting_room_rounded,
              color: _secondaryColor,
              subtitle: 'All rooms in hotel',
            ),
            _buildSummaryCard(
              title: 'Available Rooms',
              value: totalAvailableRooms.toString(),
              icon: Icons.event_available_rounded,
              color: _successColor,
              subtitle: 'Ready for booking',
            ),
            _buildSummaryCard(
              title: 'Occupied Rooms',
              value: totalOccupiedRooms.toString(),
              icon: Icons.bed_rounded,
              color: _primaryColor,
              subtitle: 'Currently booked',
            ),
            _buildSummaryCard(
              title: 'Not Configured',
              value: notConfiguredRooms.toString(),
              icon: Icons.warning_amber_rounded,
              color: _warningColor,
              subtitle: 'Need setup',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(icon, size: 24, color: color),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: _textLight,
            ),
          ),
        ],
      ),
    );
  }

  // Step 3: Hotel Description
  Widget _buildHotelDescription() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


            ],
          ),


          SizedBox(height: 16),

          // Description
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${widget.hotelName} is a premium ${widget.registrationData?['hotelType']?.toLowerCase() ?? 'hotel'} located in the heart of ${widget.city}. '
                'Offering exceptional hospitality services with state-of-the-art amenities.',
            style: TextStyle(
              fontSize: 14,
              color: _textLight,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildHotelInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(icon, size: 18, color: _primaryColor),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: _textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: _textDark,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 4: Detailed Room Breakdown
  Widget _buildDetailedRoomBreakdown() {
    final roomDetails = widget.registrationData?['roomDetails'] ?? {};
    List<Map<String, dynamic>> roomTypeData = [];

    // Process room details
    roomDetails.forEach((type, details) {
      int totalRooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
      double price = double.tryParse(details['price']?.toString() ?? '0') ?? 0;
      bool isAC = details['ac'] ?? false;

      // Calculate room distribution
      int acRooms = isAC ? totalRooms : 0;
      int nonAcRooms = !isAC ? totalRooms : 0;

      // Simulate availability (35% available, 55% booked, 10% maintenance)
      int availableRooms = (totalRooms * 0.35).round();
      int bookedRooms = (totalRooms * 0.55).round();
      int maintenanceRooms = (totalRooms * 0.10).round();

      roomTypeData.add({
        'type': type,
        'total': totalRooms,
        'acRooms': acRooms,
        'nonAcRooms': nonAcRooms,
        'available': availableRooms,
        'booked': bookedRooms,
        'maintenance': maintenanceRooms,
        'price': price,
        'isAC': isAC,
      });
    });

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room Details Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //   decoration: BoxDecoration(
              //     color: _primaryColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.bed_rounded, size: 14, color: _primaryColor),
              //       SizedBox(width: 6),
              //       Text(
              //         '${roomTypeData.length} Room Types',
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w700,
              //           color: _primaryColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 16),

          // AC vs Non-AC Summary
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildACSummaryCard(
                  title: 'AC Rooms',
                  count: roomTypeData.fold<int>(0, (sum, room) => sum + (room['acRooms'] as int)),
                  icon: Icons.ac_unit_rounded,
                  color: Colors.blue,
                ),
                _buildACSummaryCard(
                  title: 'Non-AC Rooms',
                  count: roomTypeData.fold<int>(0, (sum, room) => sum + (room['nonAcRooms'] as int)),
                  icon: Icons.air_rounded,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Detailed Room Type List
          Text(
            'Room Type Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: 12),

          ...roomTypeData.map((room) {
            return _buildRoomTypeDetailCard(room);
          }).toList(),

          if (roomTypeData.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.meeting_room_rounded, size: 60, color: _textLight.withOpacity(0.3)),
                  SizedBox(height: 16),
                  Text(
                    'No room types configured',
                    style: TextStyle(
                      fontSize: 16,
                      color: _textLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Configure room types in settings',
                    style: TextStyle(
                      fontSize: 12,
                      color: _textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildACSummaryCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(icon, size: 28, color: color),
          ),
        ),
        SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _textLight,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomTypeDetailCard(Map<String, dynamic> room) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: room['isAC']
                            ? [Colors.blue.shade100, Colors.blue.shade50]
                            : [Colors.green.shade100, Colors.green.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        room['isAC'] ? Icons.ac_unit_rounded : Icons.air_rounded,
                        size: 22,
                        color: room['isAC'] ? Colors.blue : Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room['type'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
                          SizedBox(width: 2),
                          Text(
                            '${room['price']} per night',
                            style: TextStyle(
                              fontSize: 12,
                              color: _textLight,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: _textLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            room['isAC'] ? 'AC Room' : 'Non-AC Room',
                            style: TextStyle(
                              fontSize: 12,
                              color: room['isAC'] ? Colors.blue : Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${room['total']} Rooms',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _primaryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Room Status Breakdown
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildRoomStatusItem(
                title: 'Available',
                count: room['available'],
                color: _successColor,
              ),
              _buildRoomStatusItem(
                title: 'Booked',
                count: room['booked'],
                color: _primaryColor,
              ),
              _buildRoomStatusItem(
                title: 'Maintenance',
                count: room['maintenance'],
                color: _warningColor,
              ),
            ],
          ),

          SizedBox(height: 12),

          // Progress Bar
          LinearProgressIndicator(
            value: (room['booked'] + room['maintenance']) / room['total'],
            backgroundColor: _borderColor,
            color: _primaryColor,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Occupancy: ${(((room['booked'] + room['maintenance']) / room['total']) * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 11,
                  color: _textLight,
                ),
              ),
              Text(
                'Available: ${room['available']} rooms',
                style: TextStyle(
                  fontSize: 11,
                  color: _successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoomStatusItem({
    required String title,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: _textLight,
            ),
          ),
        ],
      ),
    );
  }

  // Step 5: Booking Insights Graph
  Widget _buildBookingInsightsGraph() {
    // Sample monthly data
    Map<String, Map<String, int>> monthlyData = {
      'January': {'Confirmed': 45, 'Pending': 12, 'Cancelled': 8, 'Completed': 38},
      'February': {'Confirmed': 52, 'Pending': 15, 'Cancelled': 10, 'Completed': 45},
      'March': {'Confirmed': 48, 'Pending': 10, 'Cancelled': 7, 'Completed': 42},
      'April': {'Confirmed': 60, 'Pending': 18, 'Cancelled': 12, 'Completed': 55},
      'May': {'Confirmed': 55, 'Pending': 14, 'Cancelled': 9, 'Completed': 50},
      'June': {'Confirmed': 65, 'Pending': 20, 'Cancelled': 15, 'Completed': 60},
    };

    Map<String, int> selectedMonthData = monthlyData[_selectedMonth] ?? {'Confirmed': 0, 'Pending': 0, 'Cancelled': 0, 'Completed': 0};
    int maxValue = selectedMonthData.values.reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Insights (Graph)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //   decoration: BoxDecoration(
              //     color: _primaryColor.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.insights_rounded, size: 14, color: _primaryColor),
              //       SizedBox(width: 6),
              //       Text(
              //         'Monthly Analysis',
              //         style: TextStyle(
              //           fontSize: 12,
              //           fontWeight: FontWeight.w700,
              //           color: _primaryColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 16),

          // Month Selector
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _months.map((month) {
                bool isSelected = _selectedMonth == month;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMonth = month;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? _primaryColor : _borderColor,
                      ),
                    ),
                    child: Text(
                      month.substring(0, 3),
                      style: TextStyle(
                        color: isSelected ? Colors.white : _textDark,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // Bar Chart
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _bookingStatuses.map((status) {
                int value = selectedMonthData[status] ?? 0;
                double heightPercentage = maxValue > 0 ? (value / maxValue) * 0.8 : 0;
                Color statusColor = _getStatusColor(status);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: 150 * heightPercentage,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            statusColor.withOpacity(0.8),
                            statusColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 30,
                      child: Text(
                        status.substring(0, 3),
                        style: TextStyle(
                          fontSize: 10,
                          color: _textLight,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 20),

          // Legend
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: _bookingStatuses.map((status) {
              Color statusColor = _getStatusColor(status);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: _textLight,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return _successColor;
      case 'Pending':
        return _warningColor;
      case 'Cancelled':
        return _dangerColor;
      case 'Completed':
        return _secondaryColor;
      default:
        return _primaryColor;
    }
  }

  // Step 6: Monthly Booking Statistics

  // Widget _buildBookingInsightsGraph() {
  //   DateTime? _selectedDate;
  //
  //   // Function to get booking data based on selected month
  //   Map<String, int> _getBookingDataForMonth(DateTime date) {
  //     // This would normally come from your database/API
  //     // For demo, generating random data
  //     final month = DateFormat('MMMM yyyy').format(date);
  //
  //     // Generate different data for different months for demo
  //     int monthIndex = date.month;
  //     int baseValue = 30 + (monthIndex * 5);
  //
  //     return {
  //       'Confirmed': baseValue + Random().nextInt(20),
  //       'Pending': (baseValue * 0.3).round() + Random().nextInt(10),
  //       'Cancelled': (baseValue * 0.15).round() + Random().nextInt(5),
  //       'Completed': baseValue + Random().nextInt(15),
  //     };
  //   }
  //
  //   // Get selected month data
  //   Map<String, int> selectedMonthData = _selectedDate != null
  //       ? _getBookingDataForMonth(_selectedDate!)
  //       : _getBookingDataForMonth(DateTime.now());
  //
  //   // Get max value for scaling
  //   int maxValue = selectedMonthData.values.reduce((a, b) => a > b ? a : b);
  //   maxValue = maxValue == 0 ? 1 : maxValue;
  //
  //   return Container(
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: _cardBg,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Booking Insights',
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w700,
  //                 color: _textDark,
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: _primaryColor.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.insights_rounded, size: 14, color: _primaryColor),
  //                   SizedBox(width: 6),
  //                   Text(
  //                     'Monthly Analysis',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w700,
  //                       color: _primaryColor,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //
  //         // Date Picker
  //         Container(
  //           padding: EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: _bgColor,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: _borderColor),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Selected Month',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: _textLight,
  //                     ),
  //                   ),
  //                   SizedBox(height: 4),
  //                   Text(
  //                     _selectedDate != null
  //                         ? DateFormat('MMMM yyyy').format(_selectedDate!)
  //                         : DateFormat('MMMM yyyy').format(DateTime.now()),
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w700,
  //                       color: _textDark,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               ElevatedButton.icon(
  //                 onPressed: () async {
  //                   final DateTime? picked = await showDatePicker(
  //                     context: context,
  //                     initialDate: _selectedDate ?? DateTime.now(),
  //                     firstDate: DateTime(2020),
  //                     lastDate: DateTime(2030),
  //                     initialDatePickerMode: DatePickerMode.year,
  //                     helpText: 'SELECT MONTH',
  //                     cancelText: 'CANCEL',
  //                     confirmText: 'SELECT',
  //                     fieldLabelText: 'Month',
  //                     fieldHintText: 'Month/Year',
  //                     builder: (context, child) {
  //                       return Theme(
  //                         data: ThemeData.light().copyWith(
  //                           primaryColor: _primaryColor,
  //                           colorScheme: ColorScheme.light(
  //                             primary: _primaryColor,
  //                             secondary: _primaryLight,
  //                           ),
  //                           buttonTheme: ButtonThemeData(
  //                             textTheme: ButtonTextTheme.primary,
  //                           ),
  //                         ),
  //                         child: child!,
  //                       );
  //                     },
  //                   );
  //
  //                   if (picked != null) {
  //                     setState(() {
  //                       _selectedDate = DateTime(picked.year, picked.month);
  //                     });
  //                   }
  //                 },
  //                 icon: Icon(Icons.calendar_month_rounded, size: 16),
  //                 label: Text('Pick Month'),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: _primaryColor,
  //                   foregroundColor: Colors.white,
  //                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //         SizedBox(height: 20),
  //
  //         // Booking Statistics Summary
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             _buildBookingStatCard(
  //               title: 'Total Bookings',
  //               value: selectedMonthData.values.fold(0, (sum, value) => sum + value).toString(),
  //               color: _primaryColor,
  //               icon: Icons.bookmark_added_rounded,
  //             ),
  //             _buildBookingStatCard(
  //               title: 'Success Rate',
  //               value: '${((selectedMonthData['Completed']! / (selectedMonthData['Confirmed']! + selectedMonthData['Pending']!)) * 100).toStringAsFixed(1)}%',
  //               color: _successColor,
  //               icon: Icons.trending_up_rounded,
  //             ),
  //             _buildBookingStatCard(
  //               title: 'Cancellation',
  //               value: '${((selectedMonthData['Cancelled']! / (selectedMonthData['Confirmed']! + selectedMonthData['Pending']!)) * 100).toStringAsFixed(1)}%',
  //               color: _dangerColor,
  //               icon: Icons.cancel_rounded,
  //             ),
  //           ],
  //         ),
  //
  //         SizedBox(height: 20),
  //
  //         // Step 5: Graphical Bar Chart
  //         Text(
  //           'Booking Status Distribution',
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600,
  //             color: _textDark,
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         Container(
  //           height: 180,
  //           padding: EdgeInsets.symmetric(vertical: 16),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               _buildStatusBar(
  //                 status: 'Confirmed',
  //                 value: selectedMonthData['Confirmed']!,
  //                 maxValue: maxValue,
  //                 color: _secondaryColor,
  //               ),
  //               _buildStatusBar(
  //                 status: 'Pending',
  //                 value: selectedMonthData['Pending']!,
  //                 maxValue: maxValue,
  //                 color: _warningColor,
  //               ),
  //               _buildStatusBar(
  //                 status: 'Cancelled',
  //                 value: selectedMonthData['Cancelled']!,
  //                 maxValue: maxValue,
  //                 color: _dangerColor,
  //               ),
  //               _buildStatusBar(
  //                 status: 'Completed',
  //                 value: selectedMonthData['Completed']!,
  //                 maxValue: maxValue,
  //                 color: _successColor,
  //               ),
  //             ],
  //           ),
  //         ),
  //
  //         SizedBox(height: 20),
  //
  //         // Step 6: Detailed Booking Data Table
  //         Text(
  //           'Booking Details',
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600,
  //             color: _textDark,
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         _buildBookingDataTable(selectedMonthData),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildMonthlyBookingStats() {
    // Sample monthly statistics
    Map<String, Map<String, dynamic>> monthlyStats = {
      'January': {
        'totalBookings': 103,
        'confirmed': 45,
        'pending': 12,
        'cancelled': 8,
        'completed': 38,
        'revenue': 325000,
        'occupancy': 78.5,
      },
      'February': {
        'totalBookings': 122,
        'confirmed': 52,
        'pending': 15,
        'cancelled': 10,
        'completed': 45,
        'revenue': 385000,
        'occupancy': 82.3,
      },
      'March': {
        'totalBookings': 107,
        'confirmed': 48,
        'pending': 10,
        'cancelled': 7,
        'completed': 42,
        'revenue': 355000,
        'occupancy': 79.8,
      },
    };

    Map<String, dynamic> selectedStats = monthlyStats[_selectedMonth] ?? {
      'totalBookings': 0,
      'confirmed': 0,
      'pending': 0,
      'cancelled': 0,
      'completed': 0,
      'revenue': 0,
      'occupancy': 0,
    };

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly  ($_selectedMonth)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.analytics_rounded, size: 14, color: _primaryColor),
                    SizedBox(width: 6),
                    Text(
                      'Detailed View',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Key Statistics
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              _buildStatCard(
                title: 'Total Bookings',
                value: selectedStats['totalBookings'].toString(),
                change: '+12%',
                isPositive: true,
                icon: Icons.calendar_month_rounded,
              ),
              _buildStatCard(
                title: 'Revenue',
                value: '₹${(selectedStats['revenue'] / 1000).toStringAsFixed(0)}K',
                change: '+8%',
                isPositive: true,
                icon: Icons.currency_rupee_rounded,
              ),
              _buildStatCard(
                title: 'Occupancy Rate',
                value: '${selectedStats['occupancy']}%',
                change: '+5%',
                isPositive: true,
                icon: Icons.bar_chart_rounded,
              ),
              // _buildStatCard(
              //   title: 'Cancellation Rate',
              //   value: '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%',
              //   change: '-2%',
              //   isPositive: false,
              //   icon: Icons.cancel_rounded,
              // ),
              _buildStatCard(
                title: 'Cancellation',
                value: '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%',
                subValue: '(${selectedStats['cancelled']} of ${selectedStats['totalBookings']})',
                change: '-2%',
                isPositive: false,
                icon: Icons.cancel_rounded,
              ),
            ],
          ),

          SizedBox(height: 20),

          // Status Breakdown
          Text(
            'Booking Status Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: 12),

          ..._bookingStatuses.map((status) {
            int count = selectedStats[status.toLowerCase()] ?? 0;
            double percentage = selectedStats['totalBookings'] > 0
                ? (count / selectedStats['totalBookings']) * 100
                : 0;
            Color statusColor = _getStatusColor(status);

            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _textDark,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$count (${percentage.toStringAsFixed(1)}%)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: count / selectedStats['totalBookings'],
                    backgroundColor: _borderColor,
                    color: statusColor,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Widget _buildStatCard({
  //   required String title,
  //   required String value,
  //   required String change,
  //   required bool isPositive,
  //   required IconData icon,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: _bgColor,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: _borderColor),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               width: 36,
  //               height: 36,
  //               decoration: BoxDecoration(
  //                 color: _primaryColor.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Center(
  //                 child: Icon(icon, size: 20, color: _primaryColor),
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: isPositive ? _successColor.withOpacity(0.1) : _dangerColor.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
  //                     size: 12,
  //                     color: isPositive ? _successColor : _dangerColor,
  //                   ),
  //                   SizedBox(width: 4),
  //                   Text(
  //                     change,
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w700,
  //                       color: isPositive ? _successColor : _dangerColor,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w800,
  //             color: _textDark,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           title,
  //           style: TextStyle(
  //             fontSize: 12,
  //             color: _textLight,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? subValue,
    required String change,
    required bool isPositive,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(icon, size: 20, color: _primaryColor),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive ? _successColor.withOpacity(0.1) : _dangerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 12,
                      color: isPositive ? _successColor : _dangerColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isPositive ? _successColor : _dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Main value (percentage)
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _textDark,
            ),
          ),
          // Secondary value (numbers)
          if (subValue != null && subValue.isNotEmpty) ...[
            SizedBox(height: 2),
            Text(
              subValue,
              style: TextStyle(
                fontSize: 11,
                color: _textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: _textLight,
            ),
          ),
        ],
      ),
    );
  }

  // Drawer and Navigation Methods
  Drawer _buildDrawer(double w) {
    return Drawer(
      width: w * 0.8,
      child: Container(
        color: _cardBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryColor, _primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(Icons.hotel_rounded, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.hotelName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${widget.registrationData?['hotelType'] ?? 'Hotel'} • Owner',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildDrawerItem(Icons.dashboard_rounded, 'Dashboard', 0),
            _buildDrawerItem(Icons.meeting_room_rounded, 'Room Manager', 1),
            _buildDrawerItem(Icons.calendar_month_rounded, 'Booking Calendar', 2),
            _buildDrawerItem(Icons.analytics_rounded, 'Revenue Analytics', 3),
            _buildDrawerItem(Icons.reviews_rounded, 'Guest Reviews', 4),
            _buildDrawerItem(Icons.people_alt_rounded, 'Staff Management', 5),
            _buildDrawerItem(Icons.inventory_rounded, 'Inventory', 6),
            Divider(indent: 20, endIndent: 20),
            _buildDrawerItem(Icons.settings_rounded, 'Hotel Settings', 7),
            _buildDrawerItem(Icons.help_center_rounded, 'Help Center', 8),
            _buildDrawerItem(Icons.logout_rounded, 'Logout', 9),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Hotel Status: Active',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.85,
                    backgroundColor: _borderColor,
                    color: _successColor,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '85% rooms configured',
                    style: TextStyle(
                      fontSize: 11,
                      color: _textLight,
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

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? _primaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: _selectedIndex == index ? _primaryColor : _textDark,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? _primaryColor : _textDark,
          fontWeight: _selectedIndex == index ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      trailing: _selectedIndex == index
          ? Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: _primaryColor,
          shape: BoxShape.circle,
        ),
      )
          : null,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: _primaryColor,
      unselectedItemColor: _textLight,
      showUnselectedLabels: true,
      elevation: 8,
      backgroundColor: _cardBg,
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(fontSize: 11),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.dashboard_rounded),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.meeting_room_rounded),
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.meeting_room_rounded),
          ),
          label: 'Rooms',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_rounded),
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.calendar_month_rounded),
          ),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_rounded),
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.analytics_rounded),
          ),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          activeIcon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded),
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  // Action Methods
  void _addNewRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Room'),
        content: Text('Feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _configureRooms() {
    // Navigate to room configuration
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Configure Rooms'),
        content: Text('Redirect to room configuration page'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  void _handleInsightAction(Map<String, dynamic> insight) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(insight['title']),
        content: Text(insight['message']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
=======
>>>>>>> 05bbda8 (update changes)




  //
  // void _showProfile() async {
  //   // Prepare registration data
  //   Map<String, dynamic> regData = widget.registrationData;
  //
  //   final updatedData = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HotelOwnerProfilePage(
  //         hotelName: widget.hotelName,
  //         ownerName: widget.ownerName,
  //         mobileNumber: widget.mobileNumber,
  //         email: widget.email,
  //         addressLine1: widget.addressLine1,
  //         addressLine2: widget.addressLine2,
  //         city: widget.city,
  //         district: widget.district,
  //         state: widget.state,
  //         pinCode: widget.pinCode,
  //         gstNumber: widget.gstNumber,
  //         fssaiLicense: widget.fssaiLicense,
  //         tradeLicense: widget.tradeLicense,
  //         aadharNumber: widget.aadharNumber,
  //         accountHolderName: widget.accountHolderName,
  //         bankName: widget.bankName,
  //         accountNumber: widget.accountNumber,
  //         ifscCode: widget.ifscCode,
  //         branch: widget.branch,
  //         accountType: widget.accountType,
  //         totalRooms: widget.totalRooms,
  //         personPhotoInfo: widget.personPhotoInfo,
  //         hotelType: regData['hotelType'] ?? '',
  //         yearOfEstablishment: regData['yearOfEstablishment'] ?? '',
  //         website: regData['website'] ?? '',
  //         landmark: regData['landmark'] ?? '',
  //         selectedRoomTypes: regData['selectedRoomTypes'] ?? {},
  //         roomDetails: regData['roomDetails'] ?? {},
  //         minTariff: regData['minTariff'] ?? '',
  //         maxTariff: regData['maxTariff'] ?? '',
  //         extraBedAvailable: regData['extraBedAvailable'] ?? false,
  //         basicAmenities: regData['basicAmenities'] ?? {},
  //         hotelFacilities: regData['hotelFacilities'] ?? {},
  //         foodServices: regData['foodServices'] ?? {},
  //         additionalAmenities: regData['additionalAmenities'] ?? {},
  //         customAmenities: regData['customAmenities'] ?? [],
  //         alternateContact: regData['alternateContact'] ?? '',
  //         landlineNumbers: regData['landlineNumbers'] ?? [],
  //         uploadedFiles: regData['uploadedFiles'] ?? {},
  //         signatureName: regData['signatureName'] ?? '',
  //         declarationName: regData['declarationName'] ?? '',
  //         declarationDate: regData['declarationDate'],
  //         declarationAccepted: regData['declarationAccepted'] ?? false,
  //       ),
  //     ),
  //   );
  //
  //   if (updatedData != null && updatedData is Map<String, dynamic>) {
  //     // Update the dashboard with new data
  //     setState(() {
  //       // Update widget data (you need to make widgets mutable or use state management)
  //       // Since widget properties are final, you need to rebuild the entire dashboard
  //       // Or better, use a state management solution
  //
  //       // For now, show a snackbar and refresh the page
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Profile updated successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //
  //       // You could navigate to a new dashboard with updated data
  //       _refreshDashboard(updatedData);
  //     });
  //   }
  // }

<<<<<<< HEAD
  void _generateQrCode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Generate QR Code'),
        content: Text('QR Code generation feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
=======
// Update _showProfile method in HotelOwnerDashboard:
  void _showProfile() async {
    // Navigate to profile and wait for updates
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerProfilePage(
          hotelName: widget.hotelName,
          ownerName: widget.ownerName,
          mobileNumber: widget.mobileNumber,
          email: widget.email,
          addressLine1: widget.addressLine1,
          addressLine2: widget.addressLine2,
          city: widget.city,
          district: widget.district,
          state: widget.state,
          pinCode: widget.pinCode,
          gstNumber: widget.gstNumber,
          fssaiLicense: widget.fssaiLicense,
          tradeLicense: widget.tradeLicense,
          aadharNumber: widget.aadharNumber,
          accountHolderName: widget.accountHolderName,
          bankName: widget.bankName,
          accountNumber: widget.accountNumber,
          ifscCode: widget.ifscCode,
          branch: widget.branch,
          accountType: widget.accountType,
          totalRooms: widget.totalRooms,
          personPhotoInfo: widget.personPhotoInfo,
          hotelType: widget.registrationData['hotelType'] ?? '',
          yearOfEstablishment: widget.registrationData['yearOfEstablishment'] ?? '',
          website: widget.registrationData['website'] ?? '',
          landmark: widget.registrationData['landmark'] ?? '',
          selectedRoomTypes: Map<String, bool>.from(widget.registrationData['selectedRoomTypes'] ?? {}),
          roomDetails: Map<String, Map<String, dynamic>>.from(widget.registrationData['roomDetails'] ?? {}),
          minTariff: widget.registrationData['minTariff'] ?? '',
          maxTariff: widget.registrationData['maxTariff'] ?? '',
          extraBedAvailable: widget.registrationData['extraBedAvailable'] ?? false,
          basicAmenities: Map<String, bool>.from(widget.registrationData['basicAmenities'] ?? {}),
          hotelFacilities: Map<String, bool>.from(widget.registrationData['hotelFacilities'] ?? {}),
          foodServices: Map<String, bool>.from(widget.registrationData['foodServices'] ?? {}),
          additionalAmenities: Map<String, bool>.from(widget.registrationData['additionalAmenities'] ?? {}),
          customAmenities: List<String>.from(widget.registrationData['customAmenities'] ?? []),
          alternateContact: widget.registrationData['alternateContact'] ?? '',
          landlineNumbers: List<String>.from(widget.registrationData['landlineNumbers'] ?? []),
          uploadedFiles: Map<String, Map<String, dynamic>>.from(widget.registrationData['uploadedFiles'] ?? {}),
          signatureName: widget.registrationData['signatureName'] ?? '',
          declarationName: widget.registrationData['declarationName'] ?? '',
          declarationDate: widget.registrationData['declarationDate'],
          declarationAccepted: widget.registrationData['declarationAccepted'] ?? false,
        ),
      ),
    );

    if (updatedData != null && updatedData is Map<String, dynamic>) {
      // Update dashboard with new data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // You can refresh the dashboard here
      _refreshDashboard(updatedData);
    }
  }

// Add refresh method
  void _refreshDashboard(Map<String, dynamic> updatedData) {
    // Create new dashboard with updated data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerDashboard(
          hotelName: updatedData['hotelName'] ?? widget.hotelName,
          ownerName: updatedData['ownerName'] ?? widget.ownerName,
          mobileNumber: updatedData['mobileNumber'] ?? widget.mobileNumber,
          email: updatedData['email'] ?? widget.email,
          addressLine1: updatedData['addressLine1'] ?? widget.addressLine1,
          addressLine2: updatedData['addressLine2'] ?? widget.addressLine2,
          city: updatedData['city'] ?? widget.city,
          district: updatedData['district'] ?? widget.district,
          state: updatedData['state'] ?? widget.state,
          pinCode: updatedData['pinCode'] ?? widget.pinCode,
          gstNumber: updatedData['gstNumber'] ?? widget.gstNumber,
          fssaiLicense: updatedData['fssaiLicense'] ?? widget.fssaiLicense,
          tradeLicense: updatedData['tradeLicense'] ?? widget.tradeLicense,
          aadharNumber: updatedData['aadharNumber'] ?? widget.aadharNumber,
          accountHolderName: updatedData['accountHolderName'] ?? widget.accountHolderName,
          bankName: updatedData['bankName'] ?? widget.bankName,
          accountNumber: updatedData['accountNumber'] ?? widget.accountNumber,
          ifscCode: updatedData['ifscCode'] ?? widget.ifscCode,
          branch: updatedData['branch'] ?? widget.branch,
          accountType: updatedData['accountType'] ?? widget.accountType,
          totalRooms: int.tryParse(updatedData['totalRooms']?.toString() ?? '${widget.totalRooms}') ?? widget.totalRooms,
          personPhotoInfo: Map<String, dynamic>.from(updatedData['personPhotoInfo'] ?? widget.personPhotoInfo),
          registrationData: updatedData, panNumber: '',
        ),
>>>>>>> 05bbda8 (update changes)
      ),
    );
  }

  void _printReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Print Report'),
        content: Text('Printing report for current dashboard data...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Data'),
        content: Text('Exporting dashboard data to CSV format...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}













=======



  Widget _buildPaymentOverview() {

    List<Map<String, dynamic>> paymentData = [
      {
        'roomType': 'Standard',
        'bookedCount': 13,
        'pricePerNight': 2500,
        'totalNights': 15,
        'totalAmount': 37500,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-15',
      },
      {
        'roomType': 'Deluxe',
        'bookedCount': 10,
        'pricePerNight': 3500,
        'totalNights': 10,
        'totalAmount': 10500,
        'paymentStatus': 'Pending',
        'paymentDate': '2024-01-16',
      },
      {
        'roomType': 'Suite',
        'bookedCount': 7,
        'pricePerNight': 5000,
        'totalNights': 7,
        'totalAmount': 70000,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-14',
      },
      {
        'roomType': 'Family',
        'bookedCount': 5,
        'pricePerNight': 4200,
        'totalNights': 5,
        'totalAmount': 21000,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-13',
      },
      {
        'roomType': 'Executive',
        'bookedCount': 4,
        'pricePerNight': 6000,
        'totalNights': 3,
        'totalAmount': 18000,
        'paymentStatus': 'Pending',
        'paymentDate': '2024-01-17',
      },
    ];


    double totalProfit = paymentData.fold(0.0, (double sum, item) => sum + (item['totalAmount'] as int).toDouble());
    int totalBookedRooms = paymentData.fold(0, (int sum, item) => sum + (item['bookedCount'] as int));
    int totalNights = paymentData.fold(0, (int sum, item) => sum + (item['totalNights'] as int));
    int paidCount = paymentData.where((item) => item['paymentStatus'] == 'Paid').length;
    int pendingCount = paymentData.where((item) => item['paymentStatus'] == 'Pending').length;


    double paidAmount = paymentData
        .where((item) => item['paymentStatus'] == 'Paid')
        .fold(0.0, (double sum, item) => sum + (item['totalAmount'] as int).toDouble());

    double pendingAmount = paymentData
        .where((item) => item['paymentStatus'] == 'Pending')
        .fold(0.0, (double sum, item) => sum + (item['totalAmount'] as int).toDouble());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment_rounded, size: 14, color: _primaryColor),
                    SizedBox(width: 6),
                    Text(
                      'Revenue Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),



          SizedBox(height: 20),

          // Payment Details Table

          SizedBox(height: 12),

          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Room Type',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Booked',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              ],
            ),
          ),

          // Table Rows
          ...paymentData.map((payment) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: _cardBg,
                border: Border(
                  bottom: BorderSide(color: _borderColor),
                  left: BorderSide(color: _borderColor),
                  right: BorderSide(color: _borderColor),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      payment['roomType'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textDark,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${payment['bookedCount'] as int}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _primaryColor,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
                            Text(
                              '${payment['pricePerNight'] as int}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _textDark,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_rounded, size: 14, color: _successColor),
                            Text(
                              '${payment['totalAmount'] as int}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _successColor,
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
          }).toList(),

          // Total Row
          // Container(
          //   padding: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: _primaryColor.withOpacity(0.05),
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(12),
          //       bottomRight: Radius.circular(12),
          //     ),
          //     border: Border.all(color: _primaryColor.withOpacity(0.2)),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'TOTAL PROFIT:',
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w700,
          //           color: _textDark,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Icon(Icons.currency_rupee_rounded, size: 20, color: _successColor),
          //           Text(
          //             '${totalProfit.toStringAsFixed(0)}',
          //             style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.w800,
          //               color: _successColor,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          // Total Row - Modified with filter option
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: "Overall" text
                Text(
                  'Overall',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),

                // Middle: Date/Month filter with total profit
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, size: 14, color: _textLight),
                      SizedBox(width: 6),
                      Text(
                        'Jan 2024',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.expand_more_rounded, size: 16, color: _textLight),
                      SizedBox(width: 8),
                      Container(
                        height: 16,
                        width: 1,
                        color: _borderColor,
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Text(
                            'Total Profit - ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _textLight,
                            ),
                          ),
                          Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                          Text(
                            '${totalProfit.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _successColor,
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

          SizedBox(height: 16),


        ],
      ),
    );
  }








}

class _BookingTrendGraphPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;
  final double minValue;
  final Color primaryColor;
  final Color secondaryColor;
  final bool showRoomTypes;
  final List<String> roomTypes;
  final Map<String, Color> roomTypeColors;

  _BookingTrendGraphPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.primaryColor,
    required this.secondaryColor,
    required this.showRoomTypes,
    required this.roomTypes,
    required this.roomTypeColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    double range = maxValue - minValue;
    if (range == 0) range = 1;

    // Draw multiple wave lines if showing all room types
    if (showRoomTypes && roomTypes.length > 1) {
      for (int typeIndex = 0; typeIndex < roomTypes.length; typeIndex++) {
        String roomType = roomTypes[typeIndex];
        Color lineColor = roomTypeColors[roomType] ?? primaryColor;

        // Generate offset data for each room type
        List<double> offsetData = [];
        for (int i = 0; i < data.length; i++) {
          // Create offset pattern for each room type
          double baseValue = data[i] * (0.3 + (typeIndex * 0.15));
          double variation = sin(i * 0.3 + typeIndex) * 2;
          offsetData.add(baseValue + variation);
        }

        _drawWaveLine(canvas, size, offsetData, lineColor.withOpacity(0.7));
      }
    } else {
      // Draw single wave line
      _drawWaveLine(canvas, size, data, primaryColor);
    }

    // Draw data points
    final pointPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i += 3) { // Draw points every 3 data points
      double x = size.width * (i / (data.length - 1));
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      // Draw point
      canvas.drawCircle(Offset(x, y), 3, pointPaint);

      // Draw glow effect
      final glowPaint = Paint()
        ..color = primaryColor.withOpacity(0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(x, y), 5, glowPaint);
    }
  }

  void _drawWaveLine(Canvas canvas, Size size, List<double> lineData, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(0.3),
          color.withOpacity(0.1),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    double range = maxValue - minValue;
    if (range == 0) range = 1;

    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < lineData.length; i++) {
      double x = size.width * (i / (lineData.length - 1));
      double y = size.height - ((lineData[i] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        // Create smooth curve
        double prevX = size.width * ((i - 1) / (lineData.length - 1));
        double prevY = size.height - ((lineData[i - 1] - minValue) / range) * size.height;

        double controlX1 = prevX + (x - prevX) * 0.5;
        double controlX2 = prevX + (x - prevX) * 0.5;

        path.cubicTo(
          controlX1, prevY,
          controlX2, y,
          x, y,
        );
        fillPath.cubicTo(
          controlX1, prevY,
          controlX2, y,
          x, y,
        );
      }
    }

    // Complete fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    // Draw fill
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HotelOwnerProfilePage extends StatefulWidget {
  final String hotelName;
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String district;
  final String state;
  final String pinCode;
  final String gstNumber;
  final String fssaiLicense;
  final String tradeLicense;

  final String aadharNumber;
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branch;
  final String accountType;
  final int totalRooms;
  final Map<String, dynamic> personPhotoInfo;

  // New fields for additional tabs
  final String hotelType;
  final String yearOfEstablishment;
  final String website;
  final String landmark;
  final Map<String, bool> selectedRoomTypes;
  final Map<String, Map<String, dynamic>> roomDetails;
  final String minTariff;
  final String maxTariff;
  final bool extraBedAvailable;
  final Map<String, bool> basicAmenities;
  final Map<String, bool> hotelFacilities;
  final Map<String, bool> foodServices;
  final Map<String, bool> additionalAmenities;
  final List<String> customAmenities;
  // Additional fields for Personal Details tab
  final String alternateContact;
  final List<String> landlineNumbers;
  // Document and declaration fields for Bank & Documents tab
  final Map<String, Map<String, dynamic>> uploadedFiles;
  final String signatureName;
  final String declarationName;
  final DateTime? declarationDate;
  final bool declarationAccepted;

  const HotelOwnerProfilePage({
    super.key,
    required this.hotelName,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.gstNumber,
    required this.fssaiLicense,
    required this.tradeLicense,
    // required this.panNumber,
    required this.aadharNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branch,
    required this.accountType,
    required this.totalRooms,
    required this.personPhotoInfo,

    // Initialize new fields
    this.hotelType = '',
    this.yearOfEstablishment = '',
    this.website = '',
    this.landmark = '',
    required this.selectedRoomTypes,
    required this.roomDetails,
    this.minTariff = '',
    this.maxTariff = '',
    this.extraBedAvailable = false,
    required this.basicAmenities,
    required this.hotelFacilities,
    required this.foodServices,
    required this.additionalAmenities,
    required this.customAmenities,
    this.alternateContact = '',
    this.landlineNumbers = const [],
    this.uploadedFiles = const {},
    this.signatureName = '',
    this.declarationName = '',
    this.declarationDate,
    this.declarationAccepted = false,
  });

  @override
  State<HotelOwnerProfilePage> createState() => _HotelOwnerProfilePageState();
}

class _HotelOwnerProfilePageState extends State<HotelOwnerProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  final List<String> _tabTitles = [
    'Person details',
    'Hotel details',
    'Room Availability',
    'Amenity details',
    'Bank & Documents',
  ];
  
  // Profile data from API
  int _totalRooms = 0;
  int _activeRooms = 0;
  int _availableRooms = 0;
  int _occupiedRooms = 0;
  double _occupancyRate = 0.0;
  double _rating = 0.0;
  bool _isLoadingProfile = true;
  
  // Additional profile fields from API
  String _ownerName = '';
  String _hotelName = '';
  String _mobileNumber = '';
  String _email = '';
  String _hotelType = '';
  String _yearOfEstablishment = '';
  String _website = '';
  String _landmark = '';
  String _totalRoomsStr = '';
  String _alternateContact = '';
  List<String> _landlineNumbers = [];
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _city = '';
  String _district = '';
  String _state = '';
  String _pinCode = '';
  String _gstNumber = '';
  String _fssaiLicense = '';
  String _tradeLicense = '';
  String _panNumber = '';
  String _aadharNumber = '';
  Map<String, bool> _selectedRoomTypes = {};
  Map<String, Map<String, dynamic>> _roomDetails = {};
  String _minTariff = '';
  String _maxTariff = '';
  bool _extraBedAvailable = false;
  Map<String, bool> _basicAmenities = {};
  Map<String, bool> _hotelFacilities = {};
  Map<String, bool> _foodServices = {};
  Map<String, bool> _additionalAmenities = {};
  List<String> _customAmenities = [];
  String _accountHolderName = '';
  String _bankName = '';
  String _accountNumber = '';
  String _ifscCode = '';
  String _branch = '';
  String _accountType = '';
  String _signatureName = '';
  String _declarationName = '';
  DateTime? _declarationDate;
  bool _declarationAccepted = false;
  Map<String, dynamic> _personPhotoInfoFromApi = {};
  Map<String, Map<String, dynamic>> _uploadedFilesFromApi = {};

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
    
    // Initialize with widget values as defaults - ensure all fields are set
    _ownerName = widget.ownerName.isNotEmpty ? widget.ownerName : '';
    _hotelName = widget.hotelName.isNotEmpty ? widget.hotelName : '';
    _mobileNumber = widget.mobileNumber.isNotEmpty ? widget.mobileNumber : '';
    _email = widget.email.isNotEmpty ? widget.email : '';
    _hotelType = widget.hotelType.isNotEmpty ? widget.hotelType : '';
    _yearOfEstablishment = widget.yearOfEstablishment.isNotEmpty ? widget.yearOfEstablishment : '';
    _website = widget.website.isNotEmpty ? widget.website : '';
    _landmark = widget.landmark.isNotEmpty ? widget.landmark : '';
    _totalRooms = widget.totalRooms;
    _personPhotoInfoFromApi = widget.personPhotoInfo.isNotEmpty ? widget.personPhotoInfo : {};
    
    // Initialize additional fields from widget
    _aadharNumber = widget.aadharNumber.isNotEmpty ? widget.aadharNumber : '';
    _alternateContact = widget.alternateContact.isNotEmpty ? widget.alternateContact : '';
    _addressLine1 = widget.addressLine1.isNotEmpty ? widget.addressLine1 : '';
    _addressLine2 = widget.addressLine2.isNotEmpty ? widget.addressLine2 : '';
    _city = widget.city.isNotEmpty ? widget.city : '';
    _district = widget.district.isNotEmpty ? widget.district : '';
    _state = widget.state.isNotEmpty ? widget.state : '';
    _pinCode = widget.pinCode.isNotEmpty ? widget.pinCode : '';
    _gstNumber = widget.gstNumber.isNotEmpty ? widget.gstNumber : '';
    _fssaiLicense = widget.fssaiLicense.isNotEmpty ? widget.fssaiLicense : '';
    _tradeLicense = widget.tradeLicense.isNotEmpty ? widget.tradeLicense : '';
    _panNumber = widget.panNumber.isNotEmpty ? widget.panNumber : '';
    _selectedRoomTypes = widget.selectedRoomTypes.isNotEmpty ? widget.selectedRoomTypes : {};
    _roomDetails = widget.roomDetails.isNotEmpty ? widget.roomDetails : {};
    _minTariff = widget.minTariff.isNotEmpty ? widget.minTariff : '';
    _maxTariff = widget.maxTariff.isNotEmpty ? widget.maxTariff : '';
    _extraBedAvailable = widget.extraBedAvailable;
    _basicAmenities = widget.basicAmenities.isNotEmpty ? widget.basicAmenities : {};
    _hotelFacilities = widget.hotelFacilities.isNotEmpty ? widget.hotelFacilities : {};
    _foodServices = widget.foodServices.isNotEmpty ? widget.foodServices : {};
    _additionalAmenities = widget.additionalAmenities.isNotEmpty ? widget.additionalAmenities : {};
    _customAmenities = widget.customAmenities.isNotEmpty ? widget.customAmenities : [];
    _accountHolderName = widget.accountHolderName.isNotEmpty ? widget.accountHolderName : '';
    _bankName = widget.bankName.isNotEmpty ? widget.bankName : '';
    _accountNumber = widget.accountNumber.isNotEmpty ? widget.accountNumber : '';
    _ifscCode = widget.ifscCode.isNotEmpty ? widget.ifscCode : '';
    _branch = widget.branch.isNotEmpty ? widget.branch : '';
    _accountType = widget.accountType.isNotEmpty ? widget.accountType : '';
    _signatureName = widget.signatureName.isNotEmpty ? widget.signatureName : '';
    _declarationName = widget.declarationName.isNotEmpty ? widget.declarationName : '';
    _declarationDate = widget.declarationDate;
    _declarationAccepted = widget.declarationAccepted;
    _uploadedFilesFromApi = widget.uploadedFiles.isNotEmpty ? widget.uploadedFiles : {};
    _landlineNumbers = widget.landlineNumbers.isNotEmpty ? widget.landlineNumbers : [];
    
    // Fetch profile data from API (will update if available, otherwise keep widget values)
    _fetchProfileStatistics();
  }
  
  Future<void> _fetchProfileStatistics() async {
    setState(() {
      _isLoadingProfile = true;
    });

    final apiService = ApiService();

    try {
      // Determine identifiers to use
      final String? emailToUse = widget.email.isNotEmpty
          ? widget.email
          : (_email.isNotEmpty ? _email : apiService.currentUser?.email);
      final String? mobileToUse = widget.mobileNumber.isNotEmpty
          ? widget.mobileNumber
          : (_mobileNumber.isNotEmpty ? _mobileNumber : apiService.currentUser?.phone);

      if (emailToUse == null && mobileToUse == null) {
        // Nothing to fetch with; preserve widget values and stop loading
        setState(() {
          _totalRooms = widget.totalRooms;
          _availableRooms = widget.totalRooms;
          _occupiedRooms = 0;
          _isLoadingProfile = false;
        });
        return;
      }

      final response = await apiService.getVendorProfile(
        email: emailToUse,
        mobileNumber: mobileToUse,
      );

      if (!response.success || response.data == null) {
        // API call failed - preserve all widget values (already set in initState)
        setState(() {
          _totalRooms = widget.totalRooms;
          _availableRooms = widget.totalRooms;
          _occupiedRooms = 0;
          _isLoadingProfile = false;
        });
        return;
      }

      final data = response.data as Map<String, dynamic>;

      // Basic identity fields
      final ownerNameApi = (data['ownerName'] ?? data['owner_name'])?.toString().trim();
      if (ownerNameApi != null && ownerNameApi.isNotEmpty) {
        _ownerName = ownerNameApi;
      }

      final hotelNameApi =
          (data['hotelName'] ?? data['hotel_name'] ?? data['businessName'])?.toString().trim();
      if (hotelNameApi != null && hotelNameApi.isNotEmpty) {
        _hotelName = hotelNameApi;
      }

      final mobileApi = (data['mobileNumber'] ??
              data['mobile_number'] ??
              data['phone'])
          ?.toString()
          .trim();
      if (mobileApi != null && mobileApi.isNotEmpty) {
        _mobileNumber = mobileApi;
      }

      final emailApi = data['email']?.toString().trim();
      if (emailApi != null && emailApi.isNotEmpty) {
        _email = emailApi;
      }

      // Simple string fields
      _hotelType = (data['hotelType'] ?? data['hotel_type'] ?? _hotelType).toString();
      _yearOfEstablishment =
          (data['yearOfEstablishment'] ?? data['year_of_establishment'] ?? _yearOfEstablishment)
              .toString();
      _website = (data['website'] ?? _website).toString();
      _landmark = (data['landmark'] ?? _landmark).toString();

      if (data['totalRooms'] != null) {
        _totalRoomsStr = data['totalRooms'].toString();
      }
      _alternateContact = (data['alternateContact'] ?? _alternateContact).toString();
      if (data['landlineNumbers'] is List) {
        _landlineNumbers = List<String>.from(data['landlineNumbers']);
      }
      _addressLine1 = (data['addressLine1'] ?? _addressLine1).toString();
      _addressLine2 = (data['addressLine2'] ?? _addressLine2).toString();
      _city = (data['city'] ?? _city).toString();
      _district = (data['district'] ?? _district).toString();
      _state = (data['state'] ?? _state).toString();
      _pinCode = (data['pinCode'] ?? _pinCode).toString();
      _gstNumber = (data['gstNumber'] ?? _gstNumber).toString();
      _fssaiLicense = (data['fssaiLicense'] ?? _fssaiLicense).toString();
      _tradeLicense = (data['tradeLicense'] ?? _tradeLicense).toString();
      _panNumber = (data['panNumber'] ?? _panNumber).toString();
      _aadharNumber = (data['aadharNumber'] ?? _aadharNumber).toString();

      if (data['selectedRoomTypes'] is Map) {
        _selectedRoomTypes = Map<String, bool>.from(data['selectedRoomTypes'] as Map);
      }
      if (data['roomDetails'] is Map) {
        _roomDetails = (data['roomDetails'] as Map).map(
          (key, value) =>
              MapEntry(key.toString(), Map<String, dynamic>.from(value as Map<dynamic, dynamic>)),
        );
      }

      _minTariff = (data['minTariff'] ?? _minTariff).toString();
      _maxTariff = (data['maxTariff'] ?? _maxTariff).toString();
      if (data['extraBedAvailable'] != null) {
        final val = data['extraBedAvailable'];
        _extraBedAvailable = val == true || val == 'true';
      }

      if (data['basicAmenities'] is Map) {
        _basicAmenities = Map<String, bool>.from(data['basicAmenities'] as Map);
      }
      if (data['hotelFacilities'] is Map) {
        _hotelFacilities = Map<String, bool>.from(data['hotelFacilities'] as Map);
      }
      if (data['foodServices'] is Map) {
        _foodServices = Map<String, bool>.from(data['foodServices'] as Map);
      }
      if (data['additionalAmenities'] is Map) {
        _additionalAmenities = Map<String, bool>.from(data['additionalAmenities'] as Map);
      }
      if (data['customAmenities'] is List) {
        _customAmenities = List<String>.from(data['customAmenities'] as List);
      }

      _accountHolderName = (data['accountHolderName'] ?? _accountHolderName).toString();
      _bankName = (data['bankName'] ?? _bankName).toString();
      _accountNumber = (data['accountNumber'] ?? _accountNumber).toString();
      _ifscCode = (data['ifscCode'] ?? _ifscCode).toString();
      _branch = (data['branch'] ?? _branch).toString();
      _accountType = (data['accountType'] ?? _accountType).toString();
      _signatureName = (data['signatureName'] ?? _signatureName).toString();
      _declarationName = (data['declarationName'] ?? _declarationName).toString();

      if (data['declarationDate'] != null) {
        final dateStr = data['declarationDate'].toString();
        if (dateStr.isNotEmpty) {
          _declarationDate = DateTime.tryParse(dateStr);
        }
      }
      if (data['declarationAccepted'] != null) {
        final val = data['declarationAccepted'];
        _declarationAccepted = val == true || val == 'true';
      }

      if (data['personPhotoInfo'] is Map) {
        _personPhotoInfoFromApi = Map<String, dynamic>.from(data['personPhotoInfo'] as Map);
      }
      if (data['uploadedFiles'] is Map) {
        _uploadedFilesFromApi = (data['uploadedFiles'] as Map).map(
          (key, value) =>
              MapEntry(key.toString(), Map<String, dynamic>.from(value as Map<dynamic, dynamic>)),
        );
      }

      if (data['statistics'] is Map) {
        final stats = data['statistics'] as Map<String, dynamic>;
        final totalRoomsStr = stats['totalRooms']?.toString();
        _totalRooms = int.tryParse(totalRoomsStr ?? '') ?? widget.totalRooms;
        final activeStr = stats['activeNow']?.toString();
        _activeRooms = int.tryParse(activeStr ?? '') ?? 0;
        final occupancyStr = stats['occupancy']?.toString();
        _occupancyRate = double.tryParse(occupancyStr ?? '') ?? 0.0;
        final ratingStr = stats['rating']?.toString();
        _rating = double.tryParse(ratingStr ?? '') ?? 0.0;

        _availableRooms = _totalRooms - _activeRooms;
        if (_availableRooms < 0) _availableRooms = 0;
        _occupiedRooms = _activeRooms;

        if (_occupancyRate > 100.0) {
          _occupancyRate = 100.0;
        }
      } else {
        _totalRooms = widget.totalRooms;
        _availableRooms = widget.totalRooms;
        _occupiedRooms = 0;
      }
    } catch (e) {
      // On any error, preserve all widget values (already set in initState)
      print('❌ Error fetching profile statistics: $e');
      setState(() {
        _totalRooms = widget.totalRooms;
        _availableRooms = widget.totalRooms;
        _occupiedRooms = 0;
        _isLoadingProfile = false;
      });
    }
  }
  void _refreshStats() {
    setState(() {
      _availableRooms = getAvailableRooms();
      _occupiedRooms = getOccupiedRooms();
    });
  }


  int getAvailableRooms() {
    int totalConfiguredRooms = 0;
    widget.roomDetails.forEach((key, value) {
      final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
      totalConfiguredRooms += rooms;
    });
    return widget.totalRooms - totalConfiguredRooms;
  }

  int getOccupiedRooms() {
    int totalConfiguredRooms = 0;
    widget.roomDetails.forEach((key, value) {
      final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
      totalConfiguredRooms += rooms;
    });
    return totalConfiguredRooms;
  }

  void _goToNextTab() {
    // if (_currentTabIndex < _tabTitles.length - 1) {
    //   _tabController.animateTo(_currentTabIndex + 1);
    // }
    if (_currentTabIndex < _tabTitles.length - 1) {
      _tabController.animateTo(_currentTabIndex + 1);
    } else {

      _tabController.animateTo(0);
    }
  }

  void _goToPreviousTab() {
    if (_currentTabIndex > 0) {
      _tabController.animateTo(_currentTabIndex - 1);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Build profile photo image from base64, file path, or URL
  Widget _buildProfilePhotoImage() {
    // Use API data first, then widget data
    final photoInfo = _personPhotoInfoFromApi.isNotEmpty 
        ? _personPhotoInfoFromApi 
        : widget.personPhotoInfo;
    
    final base64Data = photoInfo['base64'] as String?;
    final filePath = photoInfo['path'] as String?;
    final url = photoInfo['url'] as String?;
    final isUploaded = photoInfo['uploaded'] as bool? ?? false;
    
    // Try base64 first
    if (base64Data != null && base64Data.isNotEmpty) {
      try {
        final imageBytes = base64Decode(base64Data);
        return Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultProfileImage();
          },
        );
      } catch (e) {
        print('Error decoding base64: $e');
      }
    }
    
    // Try file path
    if (filePath != null && filePath.isNotEmpty) {
      try {
        return Image.file(
          File(filePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultProfileImage();
          },
        );
      } catch (e) {
        print('Error loading file: $e');
      }
    }
    
    // Try URL
    if (isUploaded && url != null && url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildDefaultProfileImage();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultProfileImage();
        },
      );
    }
    
    // Default image
    return _buildDefaultProfileImage();
  }

  // Add this helper method
  Widget _buildDefaultProfileImage() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Center(
        child: Icon(Icons.person, color: Colors.white, size: 36),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [

              SliverAppBar(
                expandedHeight: 340,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.white,
                    child: Column(
                      children: [

                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 10,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              // **TOP BAR WITH BACK AND EDIT BUTTONS**
                              Row(
                                children: [
                                  // IconButton(
                                  //   icon: Icon(Icons.arrow_back, color: Colors.white),
                                  //   onPressed: () => Navigator.pop(context),
                                  // ),
                                  Spacer(),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //     horizontal: 12,
                                  //     vertical: 6,
                                  //   ),
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white.withOpacity(0.2),
                                  //     borderRadius: BorderRadius.circular(20),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Icon(
                                  //         Icons.edit,
                                  //         size: 14,
                                  //         color: Colors.white,
                                  //       ),
                                  //       SizedBox(width: 6),
                                  //       Text(
                                  //         'Edit Profile',
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => _navigateToEditProfile(context),
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, size: 14, color: Colors.white),
                                          SizedBox(width: 6),
                                          Text('Edit Profile', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),

                              // **PROFILE AND HOTEL INFO**
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // **PROFILE PHOTO**
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: _buildProfilePhotoImage(),
                                    ),
                                  ),

                                  SizedBox(width: 16),

                                  // **OWNER AND HOTEL DETAILS**
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // **OWNER NAME**
                                        Text(
<<<<<<< HEAD
                                          _ownerName.isNotEmpty ? _ownerName : widget.ownerName,
=======
                                          widget.ownerName,
                                          // 'John Alexandar',
>>>>>>> 05bbda8 (update changes)
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        SizedBox(height: 6),

                                        // **HOTEL NAME**
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.hotel,
                                              size: 18,
                                              color: Colors.white.withOpacity(
                                                0.9,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
<<<<<<< HEAD
                                                _hotelName.isNotEmpty ? _hotelName : widget.hotelName,
=======
                                                widget.hotelName,
                                                // 'Raj Bhavan Hotel',
>>>>>>> 05bbda8 (update changes)
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 12),

                                        // **CONTACT INFO**
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
<<<<<<< HEAD
                                              _mobileNumber.isNotEmpty ? _mobileNumber : widget.mobileNumber,
=======
                                              widget.mobileNumber,
                                              // '99933366677',
>>>>>>> 05bbda8 (update changes)
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.email,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
<<<<<<< HEAD
                                                _email.isNotEmpty ? _email : widget.email,
=======
                                                widget.email,
                                                // 'hotel@gmail.com',
>>>>>>> 05bbda8 (update changes)
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              // **STATS BOX**
                              // Container(
                              //   padding: EdgeInsets.all(16),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white.withOpacity(0.15),
                              //     borderRadius: BorderRadius.circular(20),
                              //     border: Border.all(color: Colors.white.withOpacity(0.3)),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     children: [
                              //       // **TOTAL ROOMS**
                              //       _buildOverviewStat(
                              //         value: widget.totalRooms.toString(),
                              //         label: 'Total Rooms',
                              //         icon: Icons.meeting_room,
                              //       ),
                              //
                              //       // **ACTIVE ROOMS**
                              //       _buildOverviewStat(
                              //         value: _activeRooms.toString(),
                              //         label: 'Active Now',
                              //         icon: Icons.check_circle,
                              //         color: Colors.white,
                              //       ),
                              //
                              //       // **OCCUPANCY**
                              //       _buildOverviewStat(
                              //         value: '${_occupancyRate.toStringAsFixed(1)}%',
                              //         label: 'Occupancy',
                              //         icon: Icons.trending_up,
                              //         color: Colors.white,
                              //       ),
                              //
                              //       // **RATING**
                              //       _buildOverviewStat(
                              //         value: _rating.toStringAsFixed(1),
                              //         label: 'Rating',
                              //         icon: Icons.star,
                              //         color: Colors.white,
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // **STATS BOX**
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    // **TOTAL ROOMS**
                                    _buildOverviewStat(
                                      value: _isLoadingProfile ? '...' : _totalRooms.toString(),
                                      label: 'Total Rooms',
                                      icon: Icons.meeting_room,
                                    ),

                                    // **AVAILABLE ROOMS**
                                    _buildOverviewStat(
                                      value: _isLoadingProfile ? '...' : _availableRooms.toString(),
                                      label: 'Available Rooms',
                                      icon: Icons.hotel,
                                      color: Colors.white,
                                    ),

                                    // **OCCUPIED ROOMS**
                                    _buildOverviewStat(
                                      value: _isLoadingProfile ? '...' : _occupiedRooms.toString(),
                                      label: 'Occupied Rooms',
                                      icon: Icons.people,
                                      color: Colors.white,
                                    ),

                                    // **RATING**
                                    _buildOverviewStat(
                                      value: _isLoadingProfile ? '...' : _rating.toStringAsFixed(1),
                                      label: 'Rating',
                                      icon: Icons.star,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // bottom: PreferredSize(
                //   preferredSize: Size.fromHeight(60),
                //   child: Container(
                //     color: Colors.white,
                //     child: TabBar(
                //       controller: _tabController,
                //       indicatorColor: Color(0xFF4F46E5),
                //       indicatorWeight: 3,
                //       labelColor: Color(0xFF4F46E5),
                //       unselectedLabelColor: Colors.grey[600],
                //       labelStyle: TextStyle(
                //         fontWeight: FontWeight.w600,
                //         fontSize: 14,
                //       ),
                //       // isScrollable: true, // Added to accommodate 5 tabs
                //       tabs: _tabTitles.map((title) {
                //         return Tab(
                //           child: Container(
                //             padding: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                //             child: Text(title),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Color(0xFF4F46E5),
                      indicatorWeight: 3,
                      labelColor: Color(0xFF4F46E5),
                      unselectedLabelColor: Colors.grey[600],
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12, // Reduced from 14 to 12
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12, // Reduced from 14 to 12
                      ),
                      tabs: _tabTitles.map((title) {
                        return Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 7,
                            ),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              // Personal details Tab - updated with new fields
              _PersonalDetailsTab(
                ownerName: _ownerName.isNotEmpty ? _ownerName : widget.ownerName,
                mobileNumber: _mobileNumber.isNotEmpty ? _mobileNumber : widget.mobileNumber,
                email: _email.isNotEmpty ? _email : widget.email,
                aadharNumber: _aadharNumber.isNotEmpty ? _aadharNumber : widget.aadharNumber,
                personPhotoInfo: _personPhotoInfoFromApi.isNotEmpty ? _personPhotoInfoFromApi : widget.personPhotoInfo,
                alternateContact: _alternateContact.isNotEmpty ? _alternateContact : widget.alternateContact,
                website: _website.isNotEmpty ? _website : widget.website,
              ),

              // Hotel details Tab
              _HotelDetailsTab(
                hotelName: _hotelName.isNotEmpty ? _hotelName : widget.hotelName,
                addressLine1: _addressLine1.isNotEmpty ? _addressLine1 : widget.addressLine1,
                addressLine2: _addressLine2.isNotEmpty ? _addressLine2 : widget.addressLine2,
                city: _city.isNotEmpty ? _city : widget.city,
                district: _district.isNotEmpty ? _district : widget.district,
                state: _state.isNotEmpty ? _state : widget.state,
                pinCode: _pinCode.isNotEmpty ? _pinCode : widget.pinCode,
                totalRooms: _totalRooms > 0 ? _totalRooms : widget.totalRooms,
                hotelType: _hotelType.isNotEmpty ? _hotelType : widget.hotelType,
                yearOfEstablishment: _yearOfEstablishment.isNotEmpty ? _yearOfEstablishment : widget.yearOfEstablishment,
                website: _website.isNotEmpty ? _website : widget.website,
                landmark: _landmark.isNotEmpty ? _landmark : widget.landmark,
                hotelEmail: _email.isNotEmpty ? _email : widget.email,
                hotelPhone: _mobileNumber.isNotEmpty ? _mobileNumber : widget.mobileNumber,
              ),

              // Room Availability Tab
              _RoomAvailabilityTab(
                selectedRoomTypes: _selectedRoomTypes.isNotEmpty ? _selectedRoomTypes : widget.selectedRoomTypes,
                roomDetails: _roomDetails.isNotEmpty ? _roomDetails : widget.roomDetails,
                minTariff: _minTariff.isNotEmpty ? _minTariff : widget.minTariff,
                maxTariff: _maxTariff.isNotEmpty ? _maxTariff : widget.maxTariff,
                extraBedAvailable: _extraBedAvailable || widget.extraBedAvailable,
                totalRooms: _totalRooms > 0 ? _totalRooms : widget.totalRooms,
              ),

              // Amenities details Tab - updated with PAN number
              _AmenitiesDetailsTab(
                basicAmenities: _basicAmenities.isNotEmpty ? _basicAmenities : widget.basicAmenities,
                hotelFacilities: _hotelFacilities.isNotEmpty ? _hotelFacilities : widget.hotelFacilities,
                foodServices: _foodServices.isNotEmpty ? _foodServices : widget.foodServices,
                additionalAmenities: _additionalAmenities.isNotEmpty ? _additionalAmenities : widget.additionalAmenities,
                customAmenities: _customAmenities.isNotEmpty ? _customAmenities : widget.customAmenities,
                gstNumber: _gstNumber.isNotEmpty ? _gstNumber : widget.gstNumber,
                fssaiLicense: _fssaiLicense.isNotEmpty ? _fssaiLicense : widget.fssaiLicense,
                tradeLicense: _tradeLicense.isNotEmpty ? _tradeLicense : widget.tradeLicense,
                aadharNumber: _aadharNumber.isNotEmpty ? _aadharNumber : widget.aadharNumber,
              ),

              // Bank & Documents Tab - updated with all document fields
              _BankAndDocumentsTab(
                accountHolderName: _accountHolderName.isNotEmpty ? _accountHolderName : widget.accountHolderName,
                bankName: _bankName.isNotEmpty ? _bankName : widget.bankName,
                accountNumber: _accountNumber.isNotEmpty ? _accountNumber : widget.accountNumber,
                ifscCode: _ifscCode.isNotEmpty ? _ifscCode : widget.ifscCode,
                branch: _branch.isNotEmpty ? _branch : widget.branch,
                accountType: _accountType.isNotEmpty ? _accountType : widget.accountType,
                gstNumber: _gstNumber.isNotEmpty ? _gstNumber : widget.gstNumber,
                fssaiLicense: _fssaiLicense.isNotEmpty ? _fssaiLicense : widget.fssaiLicense,
                tradeLicense: _tradeLicense.isNotEmpty ? _tradeLicense : widget.tradeLicense,

                uploadedFiles: _uploadedFilesFromApi.isNotEmpty ? _uploadedFilesFromApi : widget.uploadedFiles,
                signatureName: _signatureName.isNotEmpty ? _signatureName : widget.signatureName,
                declarationName: _declarationName.isNotEmpty ? _declarationName : widget.declarationName,
                declarationDate: _declarationDate != null ? _declarationDate : widget.declarationDate,
                declarationAccepted: _declarationAccepted || widget.declarationAccepted,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
//
  // void _navigateToEditProfile(BuildContext context) async {
  //   // Prepare registration data from current profile
  //   Map<String, dynamic> registrationData = {
  //     'hotelName': widget.hotelName,
  //     'hotelType': widget.hotelType,
  //     'yearOfEstablishment': widget.yearOfEstablishment,
  //     'totalRooms': widget.totalRooms,
  //     'ownerName': widget.ownerName,
  //     'mobileNumber': widget.mobileNumber,
  //     'alternateContact': widget.alternateContact,
  //     'landlineNumbers': widget.landlineNumbers,
  //     'email': widget.email,
  //     'website': widget.website,
  //     'addressLine1': widget.addressLine1,
  //     'addressLine2': widget.addressLine2,
  //     'city': widget.city,
  //     'district': widget.district,
  //     'state': widget.state,
  //     'pinCode': widget.pinCode,
  //     'landmark': widget.landmark,
  //     'selectedRoomTypes': widget.selectedRoomTypes,
  //     'roomDetails': widget.roomDetails,
  //     'minTariff': widget.minTariff,
  //     'maxTariff': widget.maxTariff,
  //     'extraBedAvailable': widget.extraBedAvailable,
  //     'basicAmenities': widget.basicAmenities,
  //     'hotelFacilities': widget.hotelFacilities,
  //     'foodServices': widget.foodServices,
  //     'additionalAmenities': widget.additionalAmenities,
  //     'customAmenities': widget.customAmenities,
  //     'gstNumber': widget.gstNumber,
  //     'fssaiLicense': widget.fssaiLicense,
  //     'tradeLicense': widget.tradeLicense,
  //     'aadharNumber': widget.aadharNumber,
  //     'accountHolderName': widget.accountHolderName,
  //     'bankName': widget.bankName,
  //     'accountNumber': widget.accountNumber,
  //     'ifscCode': widget.ifscCode,
  //     'branch': widget.branch,
  //     'accountType': widget.accountType,
  //     'uploadedFiles': widget.uploadedFiles,
  //     'signatureName': widget.signatureName,
  //     'declarationName': widget.declarationName,
  //     'declarationDate': widget.declarationDate,
  //     'personPhotoInfo': widget.personPhotoInfo,
  //     'declarationAccepted': widget.declarationAccepted,
  //   };
  //
  //   final updatedData = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditHotelProfileScreen(
  //         registrationData: registrationData,
  //       ),
  //     ),
  //   );
  //
  //   if (updatedData != null && updatedData is Map<String, dynamic>) {
  //     // Instead of popping, pass the updated data back to dashboard
  //     Navigator.pop(context, updatedData);
  //   }
  // }

// Replace the current _navigateToEditProfile with this:
  void _navigateToEditProfile(BuildContext context) async {
    // Prepare registration data
    Map<String, dynamic> registrationData = {
      'hotelName': widget.hotelName,
      'hotelType': widget.hotelType,
      'yearOfEstablishment': widget.yearOfEstablishment,
      'totalRooms': widget.totalRooms,
      'ownerName': widget.ownerName,
      'mobileNumber': widget.mobileNumber,
      'alternateContact': widget.alternateContact,
      'landlineNumbers': widget.landlineNumbers,
      'email': widget.email,
      'website': widget.website,
      'addressLine1': widget.addressLine1,
      'addressLine2': widget.addressLine2,
      'city': widget.city,
      'district': widget.district,
      'state': widget.state,
      'pinCode': widget.pinCode,
      'landmark': widget.landmark,
      'selectedRoomTypes': widget.selectedRoomTypes,
      'roomDetails': widget.roomDetails,
      'minTariff': widget.minTariff,
      'maxTariff': widget.maxTariff,
      'extraBedAvailable': widget.extraBedAvailable,
      'basicAmenities': widget.basicAmenities,
      'hotelFacilities': widget.hotelFacilities,
      'foodServices': widget.foodServices,
      'additionalAmenities': widget.additionalAmenities,
      'customAmenities': widget.customAmenities,
      'gstNumber': widget.gstNumber,
      'fssaiLicense': widget.fssaiLicense,
      'tradeLicense': widget.tradeLicense,
      'aadharNumber': widget.aadharNumber,
      'accountHolderName': widget.accountHolderName,
      'bankName': widget.bankName,
      'accountNumber': widget.accountNumber,
      'ifscCode': widget.ifscCode,
      'branch': widget.branch,
      'accountType': widget.accountType,
      'uploadedFiles': widget.uploadedFiles,
      'signatureName': widget.signatureName,
      'declarationName': widget.declarationName,
      'declarationDate': widget.declarationDate,
      'personPhotoInfo': widget.personPhotoInfo,
      'declarationAccepted': widget.declarationAccepted,
    };

    // Use await and check for null
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHotelProfileScreen(
          registrationData: registrationData,
        ),
      ),
    );

    if (updatedData != null && updatedData is Map<String, dynamic>) {
      // Pass data back to previous screen (dashboard)
      _refreshStats();
      Navigator.pop(context, updatedData);
    }
  }
  Widget _buildOverviewStat({
    required String value,
    required String label,
    required IconData icon,
    Color color = Colors.white,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color.withOpacity(0.9), fontSize: 11),
        ),
      ],
    );
  }
}

// class _PersonalDetailsTab extends StatelessWidget {
//   final String ownerName;
//   final String mobileNumber;
//   final String email;
//   final String aadharNumber;
//   final Map<String, dynamic> personPhotoInfo;
//   final String alternateContact;
//   final List<String> landlineNumbers;
//   final String website;
//
//   const _PersonalDetailsTab({
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.email,
//     required this.aadharNumber,
//     required this.personPhotoInfo,
//     this.alternateContact = '',
//     this.landlineNumbers = const [],
//     this.website = '',
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Profile Photo'),
//           SizedBox(height: 12),
//           _buildProfilePhotoCard(),
//
//           SizedBox(height: 24),
//
//           _buildSectionHeader('Identity Cards'),
//           SizedBox(height: 12),
//           _buildAadharCard(),
//
//           SizedBox(height: 24),
//
//           _buildSectionHeader('Contact Information'),
//           SizedBox(height: 12),
//           _buildContactCard(),
//
//           if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty) ...[
//             SizedBox(height: 24),
//             _buildAdditionalContactCard(),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfilePhotoCard() {
//     final isUploaded = personPhotoInfo['uploaded'] as bool? ?? false;
//     final fileName = personPhotoInfo['name'] as String? ?? '';
//
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 70,
//             height: 70,
//             decoration: BoxDecoration(
//               color: Color(0xFF4F46E5).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Color(0xFF4F46E5).withOpacity(0.2), width: 2),
//             ),
//             child: isUploaded && personPhotoInfo['path'] != null
//                 ? ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.file(
//                 File(personPhotoInfo['path']),
//                 fit: BoxFit.cover,
//               ),
//             )
//                 : Icon(Icons.person, color: Color(0xFF4F46E5), size: 32),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Profile Photo',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Icon(
//                       isUploaded ? Icons.check_circle : Icons.pending,
//                       size: 16,
//                       color: isUploaded ? Color(0xFF4CAF50) : Colors.grey[500],
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       isUploaded ? 'Uploaded Successfully' : 'Not Uploaded',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: isUploaded ? Color(0xFF4CAF50) : Colors.grey[600],
//                         fontWeight: isUploaded ? FontWeight.w500 : FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (isUploaded && fileName.isNotEmpty) ...[
//                   SizedBox(height: 8),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[50],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.photo, size: 14, color: Colors.grey[600]),
//                         SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             fileName,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[700],
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAadharCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.credit_card, color: Colors.white, size: 26),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Aadhar Card Number',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       aadharNumber.isNotEmpty ? aadharNumber : 'Not provided',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: aadharNumber.isNotEmpty ? Colors.grey[800] : Colors.grey[400],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: aadharNumber.isNotEmpty ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       aadharNumber.isNotEmpty ? Icons.verified : Icons.pending,
//                       size: 14,
//                       color: aadharNumber.isNotEmpty ? Color(0xFF4CAF50) : Colors.grey,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       aadharNumber.isNotEmpty ? 'Verified' : 'Not Verified',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: aadharNumber.isNotEmpty ? Color(0xFF4CAF50) : Colors.grey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               if (aadharNumber.isNotEmpty)
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF4F46E5).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.fingerprint, size: 14, color: Color(0xFF4F46E5)),
//                       SizedBox(width: 6),
//                       Text(
//                         'UIDAI Verified',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF4F46E5),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF4F46E5),
//                 Color(0xFF7C3AED),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: 12),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: Colors.grey[800],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContactCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildContactRow(
//             icon: Icons.person_outline,
//             label: 'Owner Name',
//             value: ownerName,
//             isPrimary: true,
//           ),
//           Divider(height: 24, color: Colors.grey[200]),
//           _buildContactRow(
//             icon: Icons.phone_android,
//             label: 'Primary Mobile',
//             value: mobileNumber,
//             isPrimary: true,
//             isCopyable: true,
//             iconColor: Color(0xFF4CAF50),
//           ),
//           Divider(height: 24, color: Colors.grey[200]),
//           _buildContactRow(
//             icon: Icons.email_outlined,
//             label: 'Email Address',
//             value: email,
//             isPrimary: true,
//             isCopyable: true,
//             iconColor: Color(0xFF2196F3),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAdditionalContactCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Additional Contact Details',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 16),
//
//           if (alternateContact.isNotEmpty) ...[
//             _buildAdditionalContactRow(
//               icon: Icons.phone_iphone,
//               label: 'Alternate Contact',
//               value: alternateContact,
//               iconColor: Color(0xFFF59E0B),
//             ),
//             if (landlineNumbers.isNotEmpty || website.isNotEmpty)
//               Divider(height: 20, color: Colors.grey[200]),
//           ],
//
//           if (landlineNumbers.isNotEmpty) ...[
//             _buildLandlineSection(),
//             if (website.isNotEmpty)
//               Divider(height: 20, color: Colors.grey[200]),
//           ],
//
//           if (website.isNotEmpty)
//             _buildAdditionalContactRow(
//               icon: Icons.language,
//               label: 'Website',
//               value: website,
//               iconColor: Color(0xFF4F46E5),
//               isWebsite: true,
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isPrimary = false,
//     bool isCopyable = false,
//     Color iconColor = Colors.grey,
//     bool isWebsite = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: iconColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
//           ),
//           child: Icon(icon, size: 22, color: iconColor),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       value,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
//                         color: isWebsite ? Colors.blue[600] : Colors.grey[800],
//                         decoration: isWebsite ? TextDecoration.underline : TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   if (isCopyable)
//                     IconButton(
//                       icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
//                       onPressed: () {
//                         // Clipboard.setData(ClipboardData(text: value));
//                         // ScaffoldMessenger.of(context).showSnackBar(
//                         //   SnackBar(
//                         //     content: Text('Copied to clipboard'),
//                         //     duration: Duration(seconds: 1),
//                         //   ),
//                         // );
//                       },
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAdditionalContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color iconColor = Colors.grey,
//     bool isWebsite = false,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           Container(
//             width: 42,
//             height: 42,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, size: 20, color: iconColor),
//           ),
//           SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: isWebsite ? Colors.blue[600] : Colors.grey[800],
//                     decoration: isWebsite ? TextDecoration.underline : TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
//             onPressed: () {
//               // Clipboard.setData(ClipboardData(text: value));
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //   SnackBar(
//               //     content: Text('Copied to clipboard'),
//               //     duration: Duration(seconds: 1),
//               //   ),
//               // );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLandlineSection() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 42,
//             height: 42,
//             decoration: BoxDecoration(
//               color: Color(0xFF4F46E5).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(Icons.phone_in_talk, size: 20, color: Color(0xFF4F46E5)),
//           ),
//           SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Landline Numbers',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: landlineNumbers.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     String number = entry.value;
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 8),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 24,
//                             height: 24,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '${index + 1}',
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               number,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.phone, size: 16, color: Color(0xFF4CAF50)),
//                             onPressed: () {
//                               // Make call functionality
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _PersonalDetailsTab extends StatelessWidget {
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String aadharNumber;
  final Map<String, dynamic> personPhotoInfo;
  final String alternateContact;

  final String website;

  const _PersonalDetailsTab({
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.aadharNumber,
    required this.personPhotoInfo,
    this.alternateContact = '',
    this.website = '',
  });
  
  // Helper method to build profile photo image from base64, file path, or URL
  Widget _buildProfilePhotoImageForCard() {
    final base64Data = personPhotoInfo['base64'] as String?;
    final filePath = personPhotoInfo['path'] as String?;
    final url = personPhotoInfo['url'] as String?;
    
    // Try base64 first
    if (base64Data != null && base64Data.isNotEmpty) {
      try {
        final imageBytes = base64Decode(base64Data);
        return Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultPhotoPlaceholder();
          },
        );
      } catch (e) {
        print('Error decoding base64: $e');
      }
    }
    
    // Try file path
    if (filePath != null && filePath.isNotEmpty) {
      try {
        return Image.file(
          File(filePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultPhotoPlaceholder();
          },
        );
      } catch (e) {
        print('Error loading file: $e');
      }
    }
    
    // Try URL
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildDefaultPhotoPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultPhotoPlaceholder();
        },
      );
    }
    
    // Default placeholder
    return _buildDefaultPhotoPlaceholder();
  }
  
  Widget _buildDefaultPhotoPlaceholder() {
    return Container(
      color: Color(0xFF4F46E5).withOpacity(0.05),
      child: Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: Color(0xFF4F46E5).withOpacity(0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== SECTION 1: PROFILE DETAILS ====================
          _buildSectionHeader('Profile Details'),
          SizedBox(height: 16),
          _buildProfileDetailsCard(),

          SizedBox(height: 32),

          // ==================== SECTION 2: IDENTITY CARDS ====================
          _buildSectionHeader('Identity Cards'),
          SizedBox(height: 16),
          _buildIdentityCardsSection(),

          SizedBox(height: 32),

          // ==================== SECTION 3: PROFILE PHOTO UPLOAD ====================
          _buildSectionHeader('Profile Photo'),
          SizedBox(height: 16),
          _buildProfilePhotoUploadCard(),

          // if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty) ...[
          SizedBox(height: 32),

          // _buildAdditionalContactCard(),
        ],
        // ],
      ),
    );
  }

  // ==================== PROFILE DETAILS CARD ====================
  Widget _buildProfileDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Owner Name
          _buildDetailRow(
            icon: Icons.person_outline_rounded,
            iconColor: Color(0xFF4F46E5),
            label: 'Owner Name',
            value: ownerName.isNotEmpty ? ownerName : 'Not provided',
            isPrimary: true,
          ),

          Divider(height: 32, color: Colors.grey[200]),

          // Email Address
          _buildDetailRow(
            icon: Icons.email_outlined,
            iconColor: Color(0xFFEA4335),
            label: 'Email Address',
            value: email.isNotEmpty ? email : 'Not provided',
            isCopyable: email.isNotEmpty,
          ),

          Divider(height: 32, color: Colors.grey[200]),

          // Phone Number
          _buildDetailRow(
            icon: Icons.phone_android,
            iconColor: Color(0xFF34A853),
            label: 'Phone Number',
            value: mobileNumber.isNotEmpty ? mobileNumber : 'Not provided',
            isCopyable: mobileNumber.isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isPrimary = false,
    bool isCopyable = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          if (isCopyable)
            IconButton(
              icon: Icon(
                Icons.content_copy,
                size: 20,
                color: Color(0xFF4F46E5),
              ),
              onPressed: () {},
              // => _copyToClipboard(context, value),
            ),
        ],
      ),
    );
  }

  // ==================== IDENTITY CARDS SECTION ====================
  Widget _buildIdentityCardsSection() {
    return Column(
      children: [
        // Aadhar Card
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aadhar Card',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'UIDAI Verification',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: aadharNumber.isNotEmpty
                          ? Color(0xFF4CAF50).withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      aadharNumber.isNotEmpty ? 'Verified' : 'Not Verified',
                      style: TextStyle(
                        fontSize: 12,
                        color: aadharNumber.isNotEmpty
                            ? Color(0xFF4CAF50)
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(color: Colors.grey[200], width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aadhar Number',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      aadharNumber.isNotEmpty ? aadharNumber : 'Not provided',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: aadharNumber.isNotEmpty
                            ? Colors.grey[800]
                            : Colors.grey[400],
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Add other identity cards here (PAN, Driving License, etc.)
        SizedBox(height: 16),
        // Container(
        //   padding: EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(16),
        //     // border: Border.all(color: Colors.grey[200], width: 1),
        //   ),
        //   child: Row(
        //     children: [
        //       Container(
        //         width: 50,
        //         height: 50,
        //         decoration: BoxDecoration(
        //           color: Color(0xFFF59E0B).withOpacity(0.1),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Icon(Icons.add, color: Color(0xFFF59E0B), size: 24),
        //       ),
        //       SizedBox(width: 16),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Add Another Identity Card',
        //               style: TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w600,
        //                 color: Colors.grey[800],
        //               ),
        //             ),
        //             SizedBox(height: 4),
        //             Text(
        //               'PAN, Driving License, etc.',
        //               style: TextStyle(
        //                 fontSize: 13,
        //                 color: Colors.grey[500],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  // ==================== PROFILE PHOTO UPLOAD CARD ====================
  Widget _buildProfilePhotoUploadCard() {
    final isUploaded = personPhotoInfo['uploaded'] as bool? ?? false;
    final fileName = personPhotoInfo['name'] as String? ?? '';
    final base64Data = personPhotoInfo['base64'] as String?;
    final filePath = personPhotoInfo['path'] as String?;
    final url = personPhotoInfo['url'] as String?;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Photo Preview
          if (isUploaded && (base64Data != null || filePath != null || url != null))
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF4F46E5).withOpacity(0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: _buildProfilePhotoImageForCard(),
              ),
            )
          else
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF4F46E5).withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF4F46E5).withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF4F46E5).withOpacity(0.5),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'No Photo',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Container(
          //   width: 50,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: isUploaded && filePath != null
          //         ? Colors.transparent
          //         : Color(0xFF4F46E5).withOpacity(0.05),
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(
          //       color: isUploaded && filePath != null
          //           ? Colors.transparent
          //           : Color(0xFF4F46E5).withOpacity(0.2),
          //       width: 2,
          //     ),
          //     boxShadow: isUploaded && filePath != null
          //         ? [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 12,
          //         offset: Offset(0, 4),
          //       ),
          //     ]
          //         : null,
          //   ),
          //   child: isUploaded && filePath != null
          //       ? ClipRRect(
          //     borderRadius: BorderRadius.circular(18),
          //     child: Image.file(
          //       File(filePath),
          //       fit: BoxFit.cover,
          //       width: 120,
          //       height: 120,
          //     ),
          //   )
          //       : Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.person,
          //           size: 40,
          //           color: Color(0xFF4F46E5).withOpacity(0.5),
          //         ),
          //         SizedBox(height: 8),
          //         Text(
          //           'No Photo',
          //           style: TextStyle(
          //             fontSize: 12,
          //             color: Colors.grey[500],
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),

          // Upload Status
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isUploaded
                  ? Color(0xFF4CAF50).withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isUploaded ? Icons.check_circle : Icons.pending,
                  size: 18,
                  color: isUploaded ? Color(0xFF4CAF50) : Color(0xFFF59E0B),
                ),
                SizedBox(width: 8),
                Text(
                  isUploaded
                      ? 'Photo Uploaded Successfully'
                      : 'Photo Pending Upload',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUploaded ? Color(0xFF4CAF50) : Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
          ),

          // if (isUploaded && fileName.isNotEmpty) ...[
          //   SizedBox(height: 16),
          //   Container(
          //     width: double.infinity,
          //     padding: EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       color: Colors.grey[50],
          //       borderRadius: BorderRadius.circular(12),
          //       // border: Border.all(color: Colors.grey[200], width: 1),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Uploaded File',
          //           style: TextStyle(
          //             fontSize: 13,
          //             color: Colors.grey[600],
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         SizedBox(height: 8),
          //         Row(
          //           children: [
          //             Icon(Icons.photo, size: 18, color: Color(0xFF4F46E5)),
          //             SizedBox(width: 10),
          //             Expanded(
          //               child: Text(
          //                 fileName,
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   color: Colors.grey[800],
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ),
          //             IconButton(
          //               icon: Icon(Icons.visibility, size: 18, color: Color(0xFF4F46E5)),
          //               onPressed: () {
          //                 // View photo functionality
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ],
          SizedBox(height: 20),

          // Upload Button
          // ElevatedButton(
          //   onPressed: () {
          //     // Trigger photo upload functionality
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Color(0xFF4F46E5),
          //     foregroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(Icons.cloud_upload, size: 20),
          //       SizedBox(width: 10),
          //       Text(
          //         isUploaded ? 'Change Photo' : 'Upload Photo',
          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // ==================== ADDITIONAL CONTACTS ====================
  // Widget _buildAdditionalContactCard() {
  //   return Container(
  //     padding: EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.06),
  //           blurRadius: 16,
  //           offset: Offset(0, 6),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         if (alternateContact.isNotEmpty)
  //           _buildAdditionalContactRow(
  //             icon: Icons.phone_iphone,
  //             label: 'Alternate Contact',
  //             value: alternateContact,
  //             iconColor: Color(0xFFF59E0B),
  //           ),
  //
  //         if (landlineNumbers.isNotEmpty) ...[
  //           if (alternateContact.isNotEmpty) Divider(height: 24, color: Colors.grey[200]),
  //           _buildLandlineSection(),
  //         ],
  //
  //         if (website.isNotEmpty) ...[
  //           if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty)
  //             Divider(height: 24, color: Colors.grey[200]),
  //           _buildAdditionalContactRow(
  //             icon: Icons.language,
  //             label: 'Website',
  //             value: website,
  //             iconColor: Color(0xFF4F46E5),
  //             isWebsite: true,
  //           ),
  //         ],
  //       ],
  //     ),
  //   );
  // }

  Widget _buildAdditionalContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isWebsite = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
            ),
            child: Icon(icon, size: 22, color: iconColor),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                GestureDetector(
                  onTap: isWebsite ? () {} : null,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isWebsite ? Colors.blue[600] : Colors.grey[800],
                      decoration: isWebsite
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.content_copy, size: 20, color: Color(0xFF4F46E5)),
            onPressed: () {},
            // => _copyToClipboard(context, value),
          ),
        ],
      ),
    );
  }

  // Widget _buildLandlineSection() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 12),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               width: 48,
  //               height: 48,
  //               decoration: BoxDecoration(
  //                 color: Color(0xFF4F46E5).withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(color: Color(0xFF4F46E5).withOpacity(0.2), width: 1.5),
  //               ),
  //               child: Icon(Icons.phone_in_talk, size: 22, color: Color(0xFF4F46E5)),
  //             ),
  //             SizedBox(width: 16),
  //             Expanded(
  //               child: Text(
  //                 'Landline Numbers',
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.grey[800],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12),
  //         ...landlineNumbers.asMap().entries.map((entry) {
  //           int index = entry.key;
  //           String number = entry.value;
  //           return Padding(
  //             padding: EdgeInsets.symmetric(vertical: 8),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 32,
  //                   height: 32,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[100],
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     '${index + 1}',
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 12),
  //                 Expanded(
  //                   child: Text(
  //                     number,
  //                     style: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.grey[800],
  //                     ),
  //                   ),
  //                 ),
  //                 IconButton(
  //                   icon: Icon(Icons.phone, size: 20, color: Color(0xFF34A853)),
  //                   onPressed: () {
  //                     // Make call functionality
  //                   },
  //                 ),
  //                 IconButton(
  //                   icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
  //                   onPressed: () {},
  //                   // => _copyToClipboard(context, number),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //       ],
  //     ),
  //   );
  // }

  // ==================== HELPER METHODS ====================
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    // Uncomment when you have clipboard functionality
    // Clipboard.setData(ClipboardData(text: text));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Copied to clipboard'),
    //     duration: Duration(seconds: 1),
    //   ),
    // );
    print('Copied to clipboard: $text');
  }
}

// class _HotelDetailsTab extends StatelessWidget {
//   final String hotelName;
//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final String district;
//   final String state;
//   final String pinCode;
//   final int totalRooms;
//   final String hotelType;
//   final String yearOfEstablishment;
//   final String website;
//   final String landmark;
//
//   const _HotelDetailsTab({
//     required this.hotelName,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.pinCode,
//     required this.totalRooms,
//     required this.hotelType,
//     required this.yearOfEstablishment,
//     required this.website,
//     required this.landmark,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Hotel Information'),
//           SizedBox(height: 12),
//           _buildHotelInfoCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Address Details'),
//           SizedBox(height: 12),
//           _buildAddressCard(),
//
//           SizedBox(height: 20),
//
//           // Landmark card - now always shown
//           _buildSectionHeader('Landmark'),
//           SizedBox(height: 12),
//           _buildLandmarkCard(),
//
//           SizedBox(height: 20),
//
//           // Website card - now always shown
//           _buildSectionHeader('Website'),
//           SizedBox(height: 12),
//           _buildWebsiteCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF4F46E5),
//                 Color(0xFF7C3AED),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: 12),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: Colors.grey[800],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHotelInfoCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildInfoRow('Hotel Name', hotelName),
//           Divider(height: 20),
//           _buildInfoRow('Hotel Type', hotelType.isNotEmpty ? hotelType : 'Not specified'),
//           Divider(height: 20),
//           _buildInfoRow('Year of Establishment', yearOfEstablishment.isNotEmpty ? yearOfEstablishment : 'Not specified'),
//           Divider(height: 20),
//           _buildInfoRow('Total Rooms', '$totalRooms Rooms'),
//           Divider(height: 20),
//           _buildInfoRow('City', city),
//           Divider(height: 20),
//           _buildInfoRow('District', district),
//           Divider(height: 20),
//           _buildInfoRow('State', state),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.location_on, color: Color(0xFF4F46E5), size: 20),
//               SizedBox(width: 8),
//               Text(
//                 'Complete Address',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Text(
//             addressLine1,
//             style: TextStyle(
//               color: Colors.grey[700],
//               fontSize: 14,
//             ),
//           ),
//           if (addressLine2.isNotEmpty) ...[
//             SizedBox(height: 4),
//             Text(
//               addressLine2,
//               style: TextStyle(
//                 color: Colors.grey[700],
//                 fontSize: 14,
//               ),
//             ),
//           ],
//           SizedBox(height: 8),
//           Wrap(
//             spacing: 12,
//             runSpacing: 8,
//             children: [
//               _buildAddressTag(city),
//               _buildAddressTag(district),
//               _buildAddressTag(state),
//               _buildAddressTag('PIN: $pinCode'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLandmarkCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.place, color: Color(0xFF4F46E5), size: 24),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Nearest Landmark',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   landmark.isNotEmpty ? landmark : 'Not specified',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: landmark.isNotEmpty ? Colors.grey[700] : Colors.grey[400],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWebsiteCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.language, color: Color(0xFF4F46E5), size: 24),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hotel Website',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   website.isNotEmpty ? website : 'Not provided',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: website.isNotEmpty ? Colors.blue[600] : Colors.grey[400],
//                     decoration: website.isNotEmpty ? TextDecoration.underline : TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressTag(String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Color(0xFF4F46E5).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: Color(0xFF4F46E5),
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(
//               color: Colors.grey[800],
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _HotelDetailsTab extends StatelessWidget {
  final String hotelName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String district;
  final String state;
  final String pinCode;
  final int totalRooms;
  final String hotelType;
  final String yearOfEstablishment;
  final String website;
  final String landmark;
  final String hotelEmail;
  final String hotelPhone;
  final String alternatePhone;
  final List<String> additionalContacts;
  final double? latitude;
  final double? longitude;

  const _HotelDetailsTab({
    required this.hotelName,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.totalRooms,
    required this.hotelType,
    required this.yearOfEstablishment,
    required this.website,
    required this.landmark,
    required this.hotelEmail,
    required this.hotelPhone,
    this.alternatePhone = '',
    this.additionalContacts = const [],
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // ==================== HOTEL INFORMATION ====================
          _buildSectionHeader('Hotel Information'),
          SizedBox(height: 12),
          _buildHotelInfoCard(),

          SizedBox(height: 24),

          // ==================== CONTACT DETAILS ====================
          _buildSectionHeader('Contact Details'),
          SizedBox(height: 12),
          _buildContactCard(),

          SizedBox(height: 24),

          // ==================== ADDRESS DETAILS ====================
          _buildSectionHeader('Address Details'),
          SizedBox(height: 12),
          _buildAddressCard(),

          // ==================== MAP SECTION ====================
          if (latitude != null && longitude != null) ...[
            SizedBox(height: 24),
            _buildSectionHeader('Location'),
            SizedBox(height: 12),
            _buildMapCard(),
          ],

          SizedBox(height: 24),

          // ==================== LANDMARK ====================
          _buildSectionHeader('Landmark'),
          SizedBox(height: 12),
          _buildLandmarkCard(),

          SizedBox(height: 24),

          // ==================== WEBSITE ====================
          _buildSectionHeader('Website'),
          SizedBox(height: 12),
          _buildWebsiteCard(),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==================== HOTEL INFORMATION CARD ====================
  Widget _buildHotelInfoCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Hotel Name
          _buildInfoRow(
            icon: Icons.business,
            label: 'Hotel Name',
            value: hotelName,
            iconColor: Color(0xFF4F46E5),
          ),
          Divider(height: 20),

          // Hotel Type
          _buildInfoRow(
            icon: Icons.star,
            label: 'Hotel Type',
            value: hotelType.isNotEmpty ? hotelType : 'Not specified',
            iconColor: Color(0xFFF59E0B),
          ),
          Divider(height: 20),

          // Year of Establishment
          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Year Established',
            value: yearOfEstablishment.isNotEmpty
                ? yearOfEstablishment
                : 'Not specified',
            iconColor: Color(0xFF10B981),
          ),
          Divider(height: 20),

          // Total Rooms
          _buildInfoRow(
            icon: Icons.hotel,
            label: 'Total Rooms',
            value: '$totalRooms Rooms',
            iconColor: Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  // ==================== CONTACT CARD ====================
  Widget _buildContactCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Hotel Email
          _buildContactRow(
            icon: Icons.email_outlined,
            label: 'Hotel Email',
            value: hotelEmail,
            iconColor: Color(0xFFEA4335),
            isEmail: true,
          ),
          Divider(height: 20),

          // Primary Phone
          _buildContactRow(
            icon: Icons.phone,
            label: 'Primary Phone',
            value: hotelPhone,
            iconColor: Color(0xFF34A853),
            isPhone: true,
          ),

          // Alternate Phone
          if (alternatePhone.isNotEmpty) ...[
            Divider(height: 20),
            _buildContactRow(
              icon: Icons.phone_iphone,
              label: 'Alternate Phone',
              value: alternatePhone,
              iconColor: Color(0xFF4285F4),
              isPhone: true,
            ),
          ],

          // Additional Contacts
          if (additionalContacts.isNotEmpty) ...[
            Divider(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.contacts, color: Color(0xFF8B5CF6), size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Additional Contacts',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ...additionalContacts.asMap().entries.map((entry) {
                  int index = entry.key;
                  String contact = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            contact,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.phone,
                            size: 18,
                            color: Color(0xFF34A853),
                          ),
                          onPressed: () => _makePhoneCall(contact),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ],
      ),
    );
  }


  Widget _buildAddressCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address lines
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.home, size: 20, color: Color(0xFF4F46E5)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address Line 1',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            addressLine1,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (addressLine2.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home_work, size: 20, color: Color(0xFF4F46E5)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address Line 2',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              addressLine2,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 16),

          // Location chips - horizontal scrollable
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 4),
                _buildLocationChip(
                  icon: Icons.location_city,
                  title: 'City',
                  value: city,
                  color: Color(0xFF4F46E5),
                ),
                SizedBox(width: 12),
                _buildLocationChip(
                  icon: Icons.map,
                  title: 'District',
                  value: district,
                  color: Color(0xFF10B981),
                ),
                SizedBox(width: 12),
                _buildLocationChip(
                  icon: Icons.flag,
                  title: 'State',
                  value: state,
                  color: Color(0xFFF59E0B),
                ),
                SizedBox(width: 12),
                _buildLocationChip(
                  icon: Icons.numbers,
                  title: 'PIN Code',
                  value: pinCode,
                  color: Color(0xFFEF4444),
                ),
                SizedBox(width: 4),
              ],
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLocationChip({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Map Placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // Map View (Replace with actual map widget)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 50, color: Colors.grey[400]),
                      SizedBox(height: 12),
                      Text(
                        'Map View',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Coordinates: ${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // Map Controls
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.open_in_full,
                        size: 20,
                        color: Color(0xFF4F46E5),
                      ),
                      onPressed: () {
                        // Open full map
                        _openInMaps();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Map Actions
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _getDirections(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: Icon(Icons.directions, size: 20),
                    label: Text('Get Directions'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _shareLocation(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF4F46E5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: Icon(Icons.share, size: 20, color: Color(0xFF4F46E5)),
                    label: Text(
                      'Share Location',
                      style: TextStyle(color: Color(0xFF4F46E5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== LANDMARK CARD ====================
  Widget _buildLandmarkCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xFF10B981).withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Icon(Icons.place, color: Color(0xFF10B981), size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nearest Landmark',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  landmark.isNotEmpty ? landmark : 'Not specified',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: landmark.isNotEmpty
                        ? Colors.grey[800]
                        : Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (landmark.isNotEmpty)
            IconButton(
              icon: Icon(Icons.directions, color: Color(0xFF4F46E5)),
              onPressed: () => _searchLandmark(),
            ),
        ],
      ),
    );
  }

  // ==================== WEBSITE CARD ====================
  Widget _buildWebsiteCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF4F46E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xFF4F46E5).withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Icon(Icons.language, color: Color(0xFF4F46E5), size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Website',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 6),
                GestureDetector(
                  onTap: website.isNotEmpty
                      ? () => _launchWebsite(website)
                      : null,
                  child: Text(
                    website.isNotEmpty ? website : 'Not provided',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: website.isNotEmpty
                          ? Colors.blue[600]
                          : Colors.grey[400],
                      decoration: website.isNotEmpty
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (website.isNotEmpty)
            IconButton(
              icon: Icon(Icons.open_in_new, color: Color(0xFF4F46E5)),
              onPressed: () => _launchWebsite(website),
            ),
        ],
      ),
    );
  }

  // ==================== HELPER WIDGETS ====================
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF4F46E5).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF4F46E5),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  if (isEmail) _sendEmail(value);
                  if (isPhone) _makePhoneCall(value);
                },
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isEmail
                        ? Color(0xFFEA4335)
                        : isPhone
                        ? Color(0xFF34A853)
                        : Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.content_copy, size: 20, color: Color(0xFF4F46E5)),
          onPressed: () => _copyToClipboard(value),
        ),
      ],
    );
  }

  // ==================== ACTION METHODS ====================
  void _copyToClipboard(String text) {
    // Clipboard.setData(ClipboardData(text: text));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Copied to clipboard')),
    // );
    print('Copied: $text');
  }

  Future<void> _launchWebsite(String url) async {
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _makePhoneCall(String phoneNumber) {
    // final url = 'tel:$phoneNumber';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // }
    print('Calling: $phoneNumber');
  }

  void _sendEmail(String email) {
    // final url = 'mailto:$email';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // }
    print('Email: $email');
  }

  void _openInMaps() {
    if (latitude != null && longitude != null) {
      final url = 'https://www.google.com/maps?q=$latitude,$longitude';
      // if (await canLaunch(url)) {
      //   await launch(url);
      // }
      print('Opening maps: $url');
    }
  }

  void _getDirections() {
    if (latitude != null && longitude != null) {
      final url =
          'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
      // if (await canLaunch(url)) {
      //   await launch(url);
      // }
      print('Getting directions');
    }
  }

  void _shareLocation() {
    if (latitude != null && longitude != null) {
      final message =
          'Hotel Location: $hotelName\nCoordinates: $latitude,$longitude\nAddress: $addressLine1, $city';
      print('Share location: $message');
    }
  }

  void _searchLandmark() {
    final query = Uri.encodeComponent('$landmark near $addressLine1 $city');
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // }
    print('Searching landmark: $landmark');
  }
}

class _AmenitiesDetailsTab extends StatelessWidget {
  final Map<String, bool> basicAmenities;
  final Map<String, bool> hotelFacilities;
  final Map<String, bool> foodServices;
  final Map<String, bool> additionalAmenities;
  final List<String> customAmenities;
  final String gstNumber;
  final String fssaiLicense;
  final String tradeLicense;
  final String aadharNumber; // Added PAN number

  const _AmenitiesDetailsTab({
    required this.basicAmenities,
    required this.hotelFacilities,
    required this.foodServices,
    required this.additionalAmenities,
    required this.customAmenities,
    required this.gstNumber,
    required this.fssaiLicense,
    required this.tradeLicense,
    required this.aadharNumber, // Added parameter
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Basic Amenities'),
          SizedBox(height: 12),
          _buildAmenitiesGrid(basicAmenities),

          SizedBox(height: 20),

          _buildSectionHeader('Hotel Facilities'),
          SizedBox(height: 12),
          _buildAmenitiesGrid(hotelFacilities),

          SizedBox(height: 20),

          _buildSectionHeader('Food & Services'),
          SizedBox(height: 12),
          _buildAmenitiesGrid(foodServices),

          SizedBox(height: 20),

          _buildSectionHeader('Additional Amenities'),
          SizedBox(height: 12),
          _buildAmenitiesGrid(additionalAmenities),

          if (customAmenities.isNotEmpty) ...[
            SizedBox(height: 20),
            _buildSectionHeader('Custom Amenities'),
            SizedBox(height: 12),
            _buildCustomAmenitiesCard(),
          ],

          SizedBox(height: 20),

          _buildSectionHeader('Legal Documents'),
          SizedBox(height: 12),
          _buildLegalDocumentsCard(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildAmenitiesGrid(Map<String, bool> amenities) {
    final availableAmenities = amenities.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (availableAmenities.isEmpty) {
      return _buildEmptyAmenitiesCard();
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: availableAmenities.map((amenity) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF4F46E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 16, color: Color(0xFF4F46E5)),
                SizedBox(width: 6),
                Text(
                  amenity,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4F46E5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyAmenitiesCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey[400], size: 24),
          SizedBox(width: 12),
          Text(
            'No amenities selected',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAmenitiesCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: customAmenities.map((amenity) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, size: 16, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  amenity,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLegalDocumentsCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildLegalDocRow('GST Number', gstNumber),
          Divider(height: 20),
          _buildLegalDocRow('FSSAI License', fssaiLicense),
          Divider(height: 20),
          _buildLegalDocRow('Trade License', tradeLicense),
          Divider(height: 20),
        ],
      ),
    );
  }

  Widget _buildLegalDocRow(String label, String value) {
    final hasValue = value.isNotEmpty;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: hasValue
                ? Color(0xFF4CAF50).withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            hasValue ? Icons.verified : Icons.info_outline,
            size: 18,
            color: hasValue ? Color(0xFF4CAF50) : Colors.grey,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 2),
              Text(
                hasValue ? value : 'Not provided',
                style: TextStyle(
                  fontSize: 13,
                  color: hasValue ? Colors.grey[700] : Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: hasValue
                ? Color(0xFF4CAF50).withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            hasValue ? 'Verified' : 'Not Set',
            style: TextStyle(
              fontSize: 11,
              color: hasValue ? Color(0xFF4CAF50) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// class _RoomAvailabilityTab extends StatelessWidget {
//   final Map<String, bool> selectedRoomTypes;
//   final Map<String, Map<String, dynamic>> roomDetails;
//   final String minTariff;
//   final String maxTariff;
//   final bool extraBedAvailable;
//   final int totalRooms;
//
//   const _RoomAvailabilityTab({
//     required this.selectedRoomTypes,
//     required this.roomDetails,
//     required this.minTariff,
//     required this.maxTariff,
//     required this.extraBedAvailable,
//     required this.totalRooms,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final availableRoomTypes = selectedRoomTypes.entries
//         .where((entry) => entry.value)
//         .map((entry) => entry.key)
//         .toList();
//
//     int totalConfiguredRooms = 0;
//     roomDetails.forEach((key, value) {
//       if (value['rooms'] != null && value['rooms'].isNotEmpty) {
//         totalConfiguredRooms += int.tryParse(value['rooms'].toString()) ?? 0;
//       }
//     });
//
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionHeader('Room Summary'),
//           SizedBox(height: 12),
//           _buildSummaryCard(totalConfiguredRooms, availableRoomTypes.length),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Price Range'),
//           SizedBox(height: 12),
//           _buildPriceRangeCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Room Types Available (${availableRoomTypes.length})'),
//           SizedBox(height: 12),
//
//           if (availableRoomTypes.isEmpty)
//             _buildNoRoomsCard()
//           else
//             ...availableRoomTypes.map((roomType) {
//               return Container(
//                 margin: EdgeInsets.only(bottom: 16),
//                 child: _buildRoomTypeCard(roomType),
//               );
//             }).toList(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Extra Bed Facility'),
//           SizedBox(height: 12),
//           _buildExtraBedCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF4F46E5),
//                 Color(0xFF7C3AED),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: 12),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: Colors.grey[800],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSummaryCard(int configuredRooms, int roomTypesCount) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildSummaryItem(
//             value: totalRooms.toString(),
//             label: 'Total Rooms',
//             icon: Icons.meeting_room,
//             color: Color(0xFF4F46E5),
//           ),
//           _buildSummaryItem(
//             value: configuredRooms.toString(),
//             label: 'Configured',
//             icon: Icons.check_circle,
//             color: Color(0xFF4CAF50),
//           ),
//           _buildSummaryItem(
//             value: roomTypesCount.toString(),
//             label: 'Room Types',
//             icon: Icons.category,
//             color: Color(0xFF2196F3),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryItem({
//     required String value,
//     required String label,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: color, size: 24),
//         ),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPriceRangeCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.attach_money, color: Color(0xFF4CAF50), size: 24),
//               SizedBox(width: 12),
//               Text(
//                 'Price per Night',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildPriceBox('Minimum', minTariff.isNotEmpty ? '₹$minTariff' : 'Not set'),
//               SizedBox(width: 20),
//               Text('to', style: TextStyle(color: Colors.grey[600])),
//               SizedBox(width: 20),
//               _buildPriceBox('Maximum', maxTariff.isNotEmpty ? '₹$maxTariff' : 'Not set'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPriceBox(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//         SizedBox(height: 4),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.grey[50],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey[200]!),
//           ),
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF4F46E5),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNoRoomsCard() {
//     return Container(
//       padding: EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(Icons.hotel, size: 50, color: Colors.grey[300]),
//           SizedBox(height: 16),
//           Text(
//             'No Room Types Configured',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Please configure room types in hotel settings',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRoomTypeCard(String roomType) {
//     final details = roomDetails[roomType] ?? {};
//     final rooms = details['rooms']?.toString() ?? '0';
//     final occupancy = details['occupancy']?.toString() ?? '0';
//     final price = details['price']?.toString() ?? '0';
//     final isAC = details['ac'] ?? true;
//     final extraBed = details['extraBed'] ?? false;
//     final extraBedPrice = details['extraBedPrice']?.toString() ?? '0';
//
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 roomType,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: isAC ? Color(0xFF2196F3).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   isAC ? 'AC' : 'Non-AC',
//                   style: TextStyle(
//                     color: isAC ? Color(0xFF2196F3) : Colors.orange,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               _buildRoomDetailItem(Icons.meeting_room, '$rooms Rooms'),
//               SizedBox(width: 16),
//               _buildRoomDetailItem(Icons.people, '$occupancy Persons'),
//               SizedBox(width: 16),
//               _buildRoomDetailItem(Icons.attach_money, '₹$price'),
//             ],
//           ),
//           if (extraBed && extraBedPrice.isNotEmpty && extraBedPrice != '0')
//             Padding(
//               padding: EdgeInsets.only(top: 12),
//               child: Row(
//                 children: [
//                   Icon(Icons.airline_seat_flat, size: 16, color: Colors.green),
//                   SizedBox(width: 6),
//                   Text(
//                     'Extra Bed: ₹$extraBedPrice',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.green[700],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRoomDetailItem(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Color(0xFF4F46E5)),
//         SizedBox(width: 4),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey[700],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildExtraBedCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: extraBedAvailable ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(
//               extraBedAvailable ? Icons.check_circle : Icons.block,
//               color: extraBedAvailable ? Color(0xFF4CAF50) : Colors.grey,
//               size: 26,
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Extra Bed Facility',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   extraBedAvailable ? 'Available' : 'Not Available',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: extraBedAvailable ? Color(0xFF4CAF50) : Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _RoomAvailabilityTab extends StatelessWidget {
  final Map<String, bool> selectedRoomTypes;
  final Map<String, Map<String, dynamic>> roomDetails;
  final String minTariff;
  final String maxTariff;
  final bool extraBedAvailable;
  final int totalRooms;

  const _RoomAvailabilityTab({
    required this.selectedRoomTypes,
    required this.roomDetails,
    required this.minTariff,
    required this.maxTariff,
    required this.extraBedAvailable,
    required this.totalRooms,
  });

  @override
  Widget build(BuildContext context) {
    final availableRoomTypes = selectedRoomTypes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    int totalConfiguredRooms = 0;
    int totalOccupancy = 0;
    double totalRevenue = 0;

    // Calculate totals
    roomDetails.forEach((key, value) {
      final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
      final occupancy =
          int.tryParse(value['occupancy']?.toString() ?? '0') ?? 0;
      final price = double.tryParse(value['price']?.toString() ?? '0') ?? 0;

      totalConfiguredRooms += rooms;
      totalOccupancy += rooms * occupancy;
      totalRevenue += rooms * price;
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== HOTEL SUMMARY SECTION ====================
          // _buildSectionHeader('Hotel Summary'),
          // SizedBox(height: 16),
          // _buildHotelSummaryCard(totalConfiguredRooms, totalOccupancy, totalRevenue),
          SizedBox(height: 32),

          // ==================== ROOM TYPES DETAILS SECTION ====================
          _buildSectionHeader('Room Types & Availability'),
          SizedBox(height: 16),

          if (availableRoomTypes.isEmpty)
            _buildNoRoomsCard()
          else ...[
            Text(
              '${availableRoomTypes.length} Room Type${availableRoomTypes.length > 1 ? 's' : ''} Available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            ...availableRoomTypes.map((roomType) {
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                child: _buildRoomTypeDetailCard(roomType),
              );
            }).toList(),
          ],

          SizedBox(height: 32),

          // ==================== PRICE RANGE SECTION ====================
          _buildSectionHeader('Price Range'),
          SizedBox(height: 16),
          _buildPriceRangeCard(),

          SizedBox(height: 32),

          // ==================== EXTRA BED FACILITY ====================
          _buildSectionHeader('Additional Facilities'),
          SizedBox(height: 16),
          _buildExtraBedCard(),

          SizedBox(height: 40),
        ],
      ),
    );
  }

  // ==================== HOTEL SUMMARY CARD ====================
  Widget _buildHotelSummaryCard(
      int configuredRooms,
      int totalOccupancy,
      double totalRevenue,
      ) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHotelSummaryItem(
                value: totalRooms.toString(),
                label: 'Total Rooms',
                color: Color(0xFF4F46E5),
                icon: Icons.hotel,
              ),
              Container(width: 1, height: 40, color: Colors.grey[200]),
              _buildHotelSummaryItem(
                value: configuredRooms.toString(),
                label: 'Configured',
                color: Color(0xFF4CAF50),
                icon: Icons.done_all,
              ),
              Container(width: 1, height: 40, color: Colors.grey[200]),
              _buildHotelSummaryItem(
                value: selectedRoomTypes.entries
                    .where((e) => e.value)
                    .length
                    .toString(),
                label: 'Room Types',
                color: Color(0xFF2196F3),
                icon: Icons.category,
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHotelSummaryItem(
                value: totalOccupancy.toString(),
                label: 'Total Occupancy',
                color: Color(0xFFF59E0B),
                icon: Icons.people,
              ),
              Container(width: 1, height: 40, color: Colors.grey[200]),
              _buildHotelSummaryItem(
                value: '₹${totalRevenue.toInt()}',
                label: 'Daily Revenue',
                color: Color(0xFF10B981),
                icon: Icons.attach_money,
              ),
              Container(width: 1, height: 40, color: Colors.grey[200]),
              _buildHotelSummaryItem(
                value: totalRooms > 0
                    ? '${((configuredRooms / totalRooms) * 100).toStringAsFixed(0)}%'
                    : '0%',
                label: 'Utilization',
                color: Color(0xFF8B5CF6),
                icon: Icons.percent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotelSummaryItem({
    required String value,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== PRICE RANGE CARD ====================
  Widget _buildPriceRangeCard() {
    final hasMinPrice = minTariff.isNotEmpty && minTariff != '0';
    final hasMaxPrice = maxTariff.isNotEmpty && maxTariff != '0';

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF10B981)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.attach_money_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Range per Day',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'All room types inclusive',
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriceDetailCard(
                label: 'Minimum Tariff',
                value: hasMinPrice ? '₹$minTariff' : 'Not Set',
                icon: Icons.arrow_downward,
                color: Color(0xFF10B981),
              ),
              _buildPriceDetailCard(
                label: 'Maximum Tariff',
                value: hasMaxPrice ? '₹$maxTariff' : 'Not Set',
                icon: Icons.arrow_upward,
                color: Color(0xFFEF4444),
              ),
            ],
          ),
          if (hasMinPrice && hasMaxPrice) ...[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, size: 18, color: Colors.blue[600]),
                  SizedBox(width: 8),
                  Text(
                    'Price range: ₹$minTariff - ₹$maxTariff',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceDetailCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: color),
                SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: value.contains('Not Set') ? Colors.grey[400] : color,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== ROOM TYPE DETAIL CARD ====================
  Widget _buildRoomTypeDetailCard(String roomType) {
    final details = roomDetails[roomType] ?? {};
    final rooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
    final occupancy =
        int.tryParse(details['occupancy']?.toString() ?? '0') ?? 0;
    final price = double.tryParse(details['price']?.toString() ?? '0') ?? 0;
    final isAC = details['ac'] ?? true;
    final extraBed = details['extraBed'] ?? false;
    final extraBedPrice =
        double.tryParse(details['extraBedPrice']?.toString() ?? '0') ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room Type Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isAC
                        ? Color(0xFF2196F3).withOpacity(0.1)
                        : Color(0xFFF59E0B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isAC
                          ? Color(0xFF2196F3).withOpacity(0.3)
                          : Color(0xFFF59E0B).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    isAC ? Icons.maps_home_work_outlined : Icons.air,
                    color: isAC ? Color(0xFF2196F3) : Color(0xFFF59E0B),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomType,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isAC
                                  ? Color(0xFF2196F3).withOpacity(0.1)
                                  : Color(0xFFF59E0B).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isAC ? 'Air Conditioned' : 'Non-AC',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isAC
                                    ? Color(0xFF2196F3)
                                    : Color(0xFFF59E0B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹$price',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                    Text(
                      'per day',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Room Details
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Availability Section - Simplified
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rooms Available
                      _buildRoomDetailItem(
                        icon: Icons.meeting_room,
                        title: 'Rooms Available',
                        value: '$rooms',
                        subtitle: 'Total',
                        color: Color(0xFF4F46E5),
                      ),

                      // Divider
                      Container(width: 1, height: 50, color: Colors.grey[300]),

                      // Max Occupancy
                      _buildRoomDetailItem(
                        icon: Icons.people,
                        title: 'Max Occupancy',
                        value: '$occupancy',
                        subtitle: 'Persons',
                        color: Color(0xFF10B981),
                      ),
                    ],
                  ),
                ),

                // Price per Person Section
                // if (occupancy > 0) ...[
                //   SizedBox(height: 16),
                //   Container(
                //     padding: EdgeInsets.all(16),
                //     decoration: BoxDecoration(
                //       color: Color(0xFFF0F9FF),
                //       borderRadius: BorderRadius.circular(16),
                //       border: Border.all(color: Color(0xFFE0F2FE)),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.calculate, size: 20, color: Color(0xFF0284C7)),
                //         SizedBox(width: 10),
                //         Text(
                //           'Price per person: ',
                //           style: TextStyle(
                //             fontSize: 14,
                //             color: Colors.grey[700],
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         Text(
                //           '₹${(price / occupancy).toStringAsFixed(0)}',
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Color(0xFF0284C7),
                //             fontWeight: FontWeight.w700,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ],

                // Extra Bed Information
                if (extraBed) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFFDCFCE7)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.airline_seat_flat,
                            color: Color(0xFF10B981),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Extra Bed Available',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                extraBedPrice > 0
                                    ? 'Additional ₹$extraBedPrice per bed'
                                    : 'No additional charge',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Optional',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Room Features Summary
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, size: 18, color: Colors.blue[600]),
                          SizedBox(width: 8),
                          Text(
                            'Room Features',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildFeatureChip(
                            label: '${isAC ? 'AC' : 'Non-AC'} Room',
                            icon: isAC ? Icons.ac_unit : Icons.air,
                            color: isAC ? Color(0xFF2196F3) : Color(0xFFF59E0B),
                          ),
                          _buildFeatureChip(
                            label: 'Up to $occupancy Persons',
                            icon: Icons.people,
                            color: Color(0xFF10B981),
                          ),
                          if (extraBed)
                            _buildFeatureChip(
                              label: 'Extra Bed Option',
                              icon: Icons.airline_seat_flat,
                              color: Color(0xFF8B5CF6),
                            ),
                          _buildFeatureChip(
                            label: '₹$price / night',
                            icon: Icons.attach_money,
                            color: Color(0xFFEF4444),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomDetailItem({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2), width: 1.5),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ==================== NO ROOMS CARD ====================
  Widget _buildNoRoomsCard() {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.hotel, size: 40, color: Colors.grey[400]),
          ),
          SizedBox(height: 20),
          Text(
            'No Room Types Configured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Please configure room types and their details in the hotel settings section.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              // textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to room configuration
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            icon: Icon(Icons.settings, size: 18),
            label: Text('Configure Rooms'),
          ),
        ],
      ),
    );
  }

  // ==================== EXTRA BED CARD ====================
  Widget _buildExtraBedCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
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
                colors: extraBedAvailable
                    ? [Color(0xFF4CAF50), Color(0xFF10B981)]
                    : [Colors.grey, Colors.grey[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              extraBedAvailable ? Icons.airline_seat_flat : Icons.block,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Extra Bed Facility',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  extraBedAvailable
                      ? 'Available for select room types. Additional charges may apply.'
                      : 'Currently not available. Contact management for special requests.',
                  style: TextStyle(
                    fontSize: 14,
                    color: extraBedAvailable
                        ? Colors.grey[600]
                        : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: extraBedAvailable
                  ? Color(0xFF10B981).withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              extraBedAvailable ? 'Available' : 'Not Available',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: extraBedAvailable ? Color(0xFF10B981) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPER METHODS ====================
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _BankAndDocumentsTab extends StatelessWidget {
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branch;
  final String accountType;
  final String gstNumber;
  final String fssaiLicense;
  final String tradeLicense;

  // New document fields
  final Map<String, Map<String, dynamic>> uploadedFiles;
  final String signatureName;
  final String declarationName;
  final DateTime? declarationDate;
  final bool declarationAccepted;

  const _BankAndDocumentsTab({
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branch,
    required this.accountType,
    required this.gstNumber,
    required this.fssaiLicense,
    required this.tradeLicense,

    this.uploadedFiles = const {},
    this.signatureName = '',
    this.declarationName = '',
    this.declarationDate,
    this.declarationAccepted = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Bank Account Details'),
          SizedBox(height: 12),
          _buildAccountDetailsCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Business Documents'),
          SizedBox(height: 12),
          _buildBusinessDocumentsCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Uploaded Documents'),
          SizedBox(height: 12),
          _buildUploadedDocumentsCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Declaration'),
          SizedBox(height: 12),
          _buildDeclarationCard(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBankInfoRow('Account Holder', accountHolderName),
          Divider(height: 20),
          _buildBankInfoRow('Bank Name', bankName),
          Divider(height: 20),
          _buildBankInfoRow('Account Number', accountNumber, isSensitive: true),
          Divider(height: 20),
          _buildBankInfoRow('IFSC Code', ifscCode),
          Divider(height: 20),
          _buildBankInfoRow('Branch', branch),
          Divider(height: 20),
          _buildBankInfoRow('Account Type', accountType),
        ],
      ),
    );
  }

  Widget _buildBankInfoRow(
      String label,
      String value, {
        bool isSensitive = false,
      }) {
    // Handle empty values
    if (value.isEmpty) {
      value = 'Not provided';
    }

    String displayValue;
    if (isSensitive) {
      if (value == 'Not provided') {
        displayValue = value;
      } else if (value.length >= 4) {
        displayValue = '•••• ${value.substring(value.length - 4)}';
      } else {
        displayValue = '•••• $value';
      }
    } else {
      displayValue = value;
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            displayValue,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessDocumentsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDocumentItem(
            title: 'GST Certificate',
            number: gstNumber,
            icon: Icons.receipt_long,
            color: Color(0xFF4F46E5),
            isVerified: gstNumber.isNotEmpty,
          ),
          SizedBox(height: 12),
          _buildDocumentItem(
            title: 'FSSAI License',
            number: fssaiLicense,
            icon: Icons.restaurant,
            color: Color(0xFF4CAF50),
            isVerified: fssaiLicense.isNotEmpty,
            isOptional: true,
            optionalText: 'Required only if restaurant',
          ),
          SizedBox(height: 12),
          _buildDocumentItem(
            title: 'Trade License',
            number: tradeLicense,
            icon: Icons.business,
            color: Color(0xFFF59E0B),
            isVerified: tradeLicense.isNotEmpty,
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildUploadedDocumentsCard() {
    // Get all uploaded documents
    final documentTypes = [
      'GST Certificate',
      'FSSAI Certificate',
      'Trade License',
      'Cancelled Cheque',
      'Hotel Photos',
      'Owner ID Proof',
      'Signature',
    ];

    final uploadedDocs = documentTypes.where((doc) {
      return uploadedFiles[doc]?['uploaded'] == true;
    }).toList();

    if (uploadedDocs.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.folder_open, size: 40, color: Colors.grey[400]),
            SizedBox(height: 12),
            Text(
              'No Documents Uploaded',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Upload documents to complete your profile',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: uploadedDocs.map((docType) {
          final fileInfo = uploadedFiles[docType] ?? {};
          final fileName = fileInfo['name'] ?? '';
          final fileSize = fileInfo['size'] ?? 0;
          final isUploaded = fileInfo['uploaded'] ?? false;

          return Column(
            children: [
              _buildUploadedDocItem(
                documentName: docType,
                fileName: fileName,
                fileSize: fileSize,
                isUploaded: isUploaded,
              ),
              if (docType != uploadedDocs.last) SizedBox(height: 12),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUploadedDocItem({
    required String documentName,
    required String fileName,
    required int fileSize,
    required bool isUploaded,
  }) {
    IconData getDocumentIcon() {
      if (documentName.contains('Signature')) return Icons.draw;
      if (documentName.contains('GST')) return Icons.receipt;
      if (documentName.contains('FSSAI')) return Icons.restaurant;
      if (documentName.contains('License')) return Icons.badge;
      if (documentName.contains('Cheque')) return Icons.account_balance;
      if (documentName.contains('Photos')) return Icons.photo_library;
      if (documentName.contains('Proof')) return Icons.perm_identity;
      return Icons.description;
    }

    Color getIconColor() {
      if (documentName.contains('Signature')) return Colors.purple;
      if (documentName.contains('FSSAI')) return Colors.red;
      if (documentName.contains('GST')) return Color(0xFF4F46E5);
      if (documentName.contains('License')) return Color(0xFFF59E0B);
      if (documentName.contains('Cheque')) return Color(0xFF2196F3);
      if (documentName.contains('Photos')) return Color(0xFF4CAF50);
      if (documentName.contains('Proof')) return Color(0xFF9C27B0);
      return Color(0xFF4F46E5);
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: getIconColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(getDocumentIcon(), size: 20, color: getIconColor()),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 12, color: Color(0xFF4CAF50)),
                SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user, color: Color(0xFF4F46E5), size: 24),
              SizedBox(width: 12),
              Text(
                'Declaration Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Declaration Text
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Text(
              'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Declaration Status
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: declarationAccepted
                      ? Color(0xFF4CAF50).withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  declarationAccepted ? Icons.check_circle : Icons.pending,
                  size: 20,
                  color: declarationAccepted
                      ? Color(0xFF4CAF50)
                      : Colors.orange,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Declaration',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      declarationAccepted ? 'Accepted' : 'Not Accepted',
                      style: TextStyle(
                        fontSize: 13,
                        color: declarationAccepted
                            ? Color(0xFF4CAF50)
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Signature Details
          if (signatureName.isNotEmpty) ...[
            Divider(height: 20),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.draw, size: 20, color: Colors.purple),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signature',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        signatureName,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          // Declaration Name and Date
          if (declarationName.isNotEmpty || declarationDate != null) ...[
            Divider(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (declarationName.isNotEmpty)
                  _buildDeclarationInfoRow('Name', declarationName),
                if (declarationDate != null) ...[
                  SizedBox(height: 12),
                  _buildDeclarationInfoRow(
                    'Date',
                    '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeclarationInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem({
    required String title,
    required String number,
    required IconData icon,
    required Color color,
    required bool isVerified,
    bool isOptional = false,
    String? optionalText,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
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
            child: Icon(icon, color: color, size: 26),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    if (isOptional)
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Optional',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  number.isNotEmpty ? number : 'Not provided',
                  style: TextStyle(
                    color: number.isNotEmpty
                        ? Colors.grey[600]
                        : Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                if (isOptional && optionalText != null) ...[
                  SizedBox(height: 4),
                  Text(
                    optionalText,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isVerified
                            ? Color(0xFF4CAF50).withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isVerified ? Icons.verified : Icons.pending,
                            size: 12,
                            color: isVerified
                                ? Color(0xFF4CAF50)
                                : Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            isVerified ? 'Verified' : 'Pending',
                            style: TextStyle(
                              fontSize: 11,
                              color: isVerified
                                  ? Color(0xFF4CAF50)
                                  : Colors.orange,
                              fontWeight: FontWeight.w600,
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
    );
  }
}

class EditHotelProfileScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const EditHotelProfileScreen({
    super.key,
    required this.registrationData,
  });

  @override
  State<EditHotelProfileScreen> createState() => _EditHotelProfileScreenState();
}

class _EditHotelProfileScreenState extends State<EditHotelProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;


  late TextEditingController _hotelNameController;
  late TextEditingController _yearController;
  late TextEditingController _roomsController;
  late TextEditingController _ownerNameController;
  late TextEditingController _mobileController;
  late TextEditingController _altMobileController;
  late TextEditingController _emailController;
  late TextEditingController _websiteController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _pinController;
  late TextEditingController _minTariffController;
  late TextEditingController _maxTariffController;
  late TextEditingController _gstController;
  late TextEditingController _fssaiController;
  late TextEditingController _tradeLicenseController;
  late TextEditingController _accountNameController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _ifscController;
  late TextEditingController _branchController;
  late TextEditingController _extraAmenitiesController;
  late TextEditingController _landmarkController;
  late TextEditingController _aadharController;
  late TextEditingController _accountTypeController;
  late TextEditingController _declarationNameController;
  late TextEditingController _signatureNameController;

  // Color constants
  final Color _primaryColor = Color(0xFFFF5F6D);
  final Color _primaryLight = Color(0xFFEEF2FF);
  final Color _bgColor = Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _textPrimary = Color(0xFF111827);
  final Color _textSecondary = Color(0xFF6B7280);
  final Color _successColor = Color(0xFFFB717D);

  // State variables - initialize with existing data
  late String? _selectedHotelType;
  late bool _extraBedAvailable;
  late DateTime? _selectedDate;
  late bool _declarationAccepted;

  late List<TextEditingController> _landlineControllers;

  // Maps and lists - initialize with existing data
  late Map<String, Map<String, dynamic>> _roomDetails;
  late Map<String, bool> _selectedRoomTypes;
  late Map<String, bool> _basicAmenities;
  late Map<String, bool> _hotelFacilities;
  late Map<String, bool> _foodServices;
  late Map<String, bool> _additionalAmenities;
  late List<String> _customAmenities;
  late Map<String, bool> _documents;
  late Map<String, Map<String, dynamic>> _uploadedFiles;
  late Map<String, dynamic> _personPhotoInfo;

  // Steps
  final List<Map<String, dynamic>> _steps = [
    {'title': 'Basic Details', 'subtitle': 'Hotel information and contact'},
    {'title': 'Hotel Details', 'subtitle': 'Address and location'},
    {'title': 'Room Availability', 'subtitle': 'Room configuration and rates'},
    {'title': 'Amenities & Legal', 'subtitle': 'Facilities and compliance'},
    {'title': 'Bank & Documents', 'subtitle': 'Payment and documents'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeDataFromRegistration();
  }

  // void _initializeDataFromRegistration() {
  //   final data = widget.registrationData;
  //   _uploadedFiles = Map<String, Map<String, dynamic>>.from(data['uploadedFiles'] ?? {});
  //
  //   List<String> requiredDocuments = [
  //     'GST Certificate',
  //     'FSSAI Certificate',
  //     'Trade License',
  //     'Cancelled Cheque',
  //     'Hotel Photos',
  //     'Owner ID Proof',
  //     'Signature'
  //   ];
  //
  //   for (var doc in requiredDocuments) {
  //     if (!_uploadedFiles.containsKey(doc)) {
  //       _uploadedFiles[doc] = {
  //         'name': '',
  //         'size': 0,
  //         'path': '',
  //         'uploaded': false,
  //       };
  //     }
  //   }
  //
  //   // // Initialize controllers with existing data
  //   // _hotelNameController = TextEditingController(text: data['hotelName'] ?? '');
  //   // _yearController = TextEditingController(text: data['yearOfEstablishment'] ?? '');
  //   // _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
  //   // _ownerNameController = TextEditingController(text: data['ownerName'] ?? '');
  //   // _mobileController = TextEditingController(text: data['mobileNumber'] ?? '');
  //   // _altMobileController = TextEditingController(text: data['alternateContact'] ?? '');
  //   // _emailController = TextEditingController(text: data['email'] ?? '');
  //   // _websiteController = TextEditingController(text: data['website'] ?? '');
  //   // _address1Controller = TextEditingController(text: data['addressLine1'] ?? '');
  //   // _address2Controller = TextEditingController(text: data['addressLine2'] ?? '');
  //   // _cityController = TextEditingController(text: data['city'] ?? '');
  //   // _districtController = TextEditingController(text: data['district'] ?? '');
  //   // _stateController = TextEditingController(text: data['state'] ?? '');
  //   // _pinController = TextEditingController(text: data['pinCode'] ?? '');
  //   // _minTariffController = TextEditingController(text: data['minTariff'] ?? '');
  //   // _maxTariffController = TextEditingController(text: data['maxTariff'] ?? '');
  //   // _gstController = TextEditingController(text: data['gstNumber'] ?? '');
  //   // _fssaiController = TextEditingController(text: data['fssaiLicense'] ?? '');
  //   // _tradeLicenseController = TextEditingController(text: data['tradeLicense'] ?? '');
  //   // _accountNameController = TextEditingController(text: data['accountHolderName'] ?? '');
  //   // _bankNameController = TextEditingController(text: data['bankName'] ?? '');
  //   // _accountNumberController = TextEditingController(text: data['accountNumber'] ?? '');
  //   // _ifscController = TextEditingController(text: data['ifscCode'] ?? '');
  //   // _branchController = TextEditingController(text: data['branch'] ?? '');
  //   // _extraAmenitiesController = TextEditingController();
  //   // _landmarkController = TextEditingController(text: data['landmark'] ?? '');
  //   // _aadharController = TextEditingController(text: data['aadharNumber'] ?? '');
  //   // _accountTypeController = TextEditingController(text: data['accountType'] ?? '');
  //   // _declarationNameController = TextEditingController(text: data['declarationName'] ?? '');
  //   // _signatureNameController = TextEditingController(text: data['signatureName'] ?? '');
  //
  //   // Initialize other state variables
  //
  //   _hotelNameController = TextEditingController(text: data['hotelName']?.toString() ?? '');
  //   _yearController = TextEditingController(text: data['yearOfEstablishment']?.toString() ?? '');
  //   _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
  //   _ownerNameController = TextEditingController(text: data['ownerName']?.toString() ?? '');
  //   _mobileController = TextEditingController(text: data['mobileNumber']?.toString() ?? '');
  //   _altMobileController = TextEditingController(text: data['alternateContact']?.toString() ?? '');
  //   _emailController = TextEditingController(text: data['email']?.toString() ?? '');
  //   _websiteController = TextEditingController(text: data['website']?.toString() ?? '');
  //   _address1Controller = TextEditingController(text: data['addressLine1']?.toString() ?? '');
  //   _address2Controller = TextEditingController(text: data['addressLine2']?.toString() ?? '');
  //   _cityController = TextEditingController(text: data['city']?.toString() ?? '');
  //   _districtController = TextEditingController(text: data['district']?.toString() ?? '');
  //   _stateController = TextEditingController(text: data['state']?.toString() ?? '');
  //   _pinController = TextEditingController(text: data['pinCode']?.toString() ?? '');
  //   _minTariffController = TextEditingController(text: data['minTariff']?.toString() ?? '');
  //   _maxTariffController = TextEditingController(text: data['maxTariff']?.toString() ?? '');
  //   _gstController = TextEditingController(text: data['gstNumber']?.toString() ?? '');
  //   _fssaiController = TextEditingController(text: data['fssaiLicense']?.toString() ?? '');
  //   _tradeLicenseController = TextEditingController(text: data['tradeLicense']?.toString() ?? '');
  //   _accountNameController = TextEditingController(text: data['accountHolderName']?.toString() ?? '');
  //   _bankNameController = TextEditingController(text: data['bankName']?.toString() ?? '');
  //   _accountNumberController = TextEditingController(text: data['accountNumber']?.toString() ?? '');
  //   _ifscController = TextEditingController(text: data['ifscCode']?.toString() ?? '');
  //   _branchController = TextEditingController(text: data['branch']?.toString() ?? '');
  //   _extraAmenitiesController = TextEditingController();
  //   _landmarkController = TextEditingController(text: data['landmark']?.toString() ?? '');
  //   _aadharController = TextEditingController(text: data['aadharNumber']?.toString() ?? '');
  //   _accountTypeController = TextEditingController(text: data['accountType']?.toString() ?? '');
  //   _declarationNameController = TextEditingController(text: data['declarationName']?.toString() ?? '');
  //   _signatureNameController = TextEditingController(text: data['signatureName']?.toString() ?? '');
  //
  //   // _selectedHotelType = data['hotelType'] ?? '';
  //   // _extraBedAvailable = data['extraBedAvailable'] ?? false;
  //   // _selectedDate = data['declarationDate'];
  //   // _declarationAccepted = data['declarationAccepted'] ?? false;
  //
  //   // Initialize state variables with proper type checking
  //   _selectedHotelType = data['hotelType']?.toString() ?? '';
  //   _extraBedAvailable = data['extraBedAvailable'] == true;
  //   _selectedDate = data['declarationDate'] is DateTime ? data['declarationDate'] : null;
  //   _declarationAccepted = data['declarationAccepted'] == true;
  //
  //   // Initialize landline controllers
  //   final landlineNumbers = (data['landlineNumbers'] as List<dynamic>? ?? [])
  //       .map((e) => e.toString())
  //       .toList();
  //   _landlineControllers = landlineNumbers.isEmpty
  //       ? [TextEditingController()]
  //       : landlineNumbers.map((num) => TextEditingController(text: num)).toList();
  //
  //   // Initialize room details - ensure all room types have entries
  //   _roomDetails = Map<String, Map<String, dynamic>>.from(data['roomDetails'] ?? {});
  //
  //   // Ensure all possible room types have entries
  //   List<String> allRoomTypes = [
  //     'Single Room', 'Double Room', 'Deluxe Room',
  //     'Suite Room', 'Family Room', 'Executive Room'
  //   ];
  //
  //   for (var roomType in allRoomTypes) {
  //     if (!_roomDetails.containsKey(roomType)) {
  //       _roomDetails[roomType] = {
  //         'rooms': '',
  //         'occupancy': '',
  //         'ac': true,
  //         'price': '',
  //         'extraBed': false,
  //         'extraBedPrice': '',
  //       };
  //     }
  //   }
  //
  //
  //   Map<String, bool> savedSelections = Map<String, bool>.from(data['selectedRoomTypes'] ?? {});
  //   _selectedRoomTypes = {
  //     'Single Room': savedSelections['Single Room'] ?? false,
  //     'Double Room': savedSelections['Double Room'] ?? false,
  //     'Deluxe Room': savedSelections['Deluxe Room'] ?? false,
  //     'Suite Room': savedSelections['Suite Room'] ?? false,
  //     'Family Room': savedSelections['Family Room'] ?? false,
  //     'Executive Room': savedSelections['Executive Room'] ?? false,
  //   };
  //
  //
  //   Map<String, bool> savedBasicAmenities = Map<String, bool>.from(data['basicAmenities'] ?? {});
  //   _basicAmenities = {
  //     'Free Wi-Fi': savedBasicAmenities['Free Wi-Fi'] ?? false,
  //     'Television': savedBasicAmenities['Television'] ?? false,
  //     'Air Conditioning': savedBasicAmenities['Air Conditioning'] ?? false,
  //     'Attached Bathroom': savedBasicAmenities['Attached Bathroom'] ?? false,
  //     'Hot Water': savedBasicAmenities['Hot Water'] ?? false,
  //     'Room Service': savedBasicAmenities['Room Service'] ?? false,
  //   };
  //
  //   Map<String, bool> savedHotelFacilities = Map<String, bool>.from(data['hotelFacilities'] ?? {});
  //   _hotelFacilities = {
  //     '24-Hour Front Desk': savedHotelFacilities['24-Hour Front Desk'] ?? false,
  //     'Power Backup': savedHotelFacilities['Power Backup'] ?? false,
  //     'Lift / Elevator': savedHotelFacilities['Lift / Elevator'] ?? false,
  //     'Parking Facility': savedHotelFacilities['Parking Facility'] ?? false,
  //     'CCTV Security': savedHotelFacilities['CCTV Security'] ?? false,
  //   };
  //
  //   Map<String, bool> savedFoodServices = Map<String, bool>.from(data['foodServices'] ?? {});
  //   _foodServices = {
  //     'Restaurant': savedFoodServices['Restaurant'] ?? false,
  //     'Complimentary Breakfast': savedFoodServices['Complimentary Breakfast'] ?? false,
  //     'In-Room Dining': savedFoodServices['In-Room Dining'] ?? false,
  //     'Tea / Coffee Maker': savedFoodServices['Tea / Coffee Maker'] ?? false,
  //   };
  //
  //   Map<String, bool> savedAdditionalAmenities = Map<String, bool>.from(data['additionalAmenities'] ?? {});
  //   _additionalAmenities = {
  //     'Laundry Service': savedAdditionalAmenities['Laundry Service'] ?? false,
  //     'Travel Desk': savedAdditionalAmenities['Travel Desk'] ?? false,
  //     'Conference / Meeting Room': savedAdditionalAmenities['Conference / Meeting Room'] ?? false,
  //     'Wheelchair Access': savedAdditionalAmenities['Wheelchair Access'] ?? false,
  //   };
  //
  //
  //   _customAmenities = List<String>.from(data['customAmenities'] ?? []);
  //
  //
  //   Map<String, bool> savedDocuments = Map<String, bool>.from(data['documents'] ?? {});
  //   _documents = {
  //     'GST Certificate': savedDocuments['GST Certificate'] ?? false,
  //     'FSSAI Certificate': savedDocuments['FSSAI Certificate'] ?? false,
  //     'Trade License': savedDocuments['Trade License'] ?? false,
  //     'Cancelled Cheque': savedDocuments['Cancelled Cheque'] ?? false,
  //     'Hotel Photos': savedDocuments['Hotel Photos'] ?? false,
  //     'Owner ID Proof': savedDocuments['Owner ID Proof'] ?? false,
  //     'Signature': savedDocuments['Signature'] ?? false,
  //   };
  //
  //   _personPhotoInfo = Map<String, dynamic>.from(data['personPhotoInfo'] ?? {
  //     'name': '', 'size': 0, 'path': '', 'uploaded': false,
  //   });
  // }
  void _initializeDataFromRegistration() {
    final data = widget.registrationData;

    // Initialize uploadedFiles
    _uploadedFiles = Map<String, Map<String, dynamic>>.from(data['uploadedFiles'] ?? {});

    List<String> requiredDocuments = [
      'GST Certificate',
      'FSSAI Certificate',
      'Trade License',
      'Cancelled Cheque',
      'Hotel Photos',
      'Owner ID Proof',
      'Signature'
    ];

    for (var doc in requiredDocuments) {
      if (!_uploadedFiles.containsKey(doc)) {
        _uploadedFiles[doc] = {
          'name': '',
          'size': 0,
          'path': '',
          'uploaded': false,
        };
      }
    }

    // Initialize ALL controllers with proper null safety
    _hotelNameController = TextEditingController(text: data['hotelName']?.toString() ?? '');
    _yearController = TextEditingController(text: data['yearOfEstablishment']?.toString() ?? '');
    _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
    _ownerNameController = TextEditingController(text: data['ownerName']?.toString() ?? '');
    _mobileController = TextEditingController(text: data['mobileNumber']?.toString() ?? '');
    _altMobileController = TextEditingController(text: data['alternateContact']?.toString() ?? '');
    _emailController = TextEditingController(text: data['email']?.toString() ?? '');
    _websiteController = TextEditingController(text: data['website']?.toString() ?? '');
    _address1Controller = TextEditingController(text: data['addressLine1']?.toString() ?? '');
    _address2Controller = TextEditingController(text: data['addressLine2']?.toString() ?? '');
    _cityController = TextEditingController(text: data['city']?.toString() ?? '');
    _districtController = TextEditingController(text: data['district']?.toString() ?? '');
    _stateController = TextEditingController(text: data['state']?.toString() ?? '');
    _pinController = TextEditingController(text: data['pinCode']?.toString() ?? '');
    _minTariffController = TextEditingController(text: data['minTariff']?.toString() ?? '');
    _maxTariffController = TextEditingController(text: data['maxTariff']?.toString() ?? '');
    _gstController = TextEditingController(text: data['gstNumber']?.toString() ?? '');
    _fssaiController = TextEditingController(text: data['fssaiLicense']?.toString() ?? '');
    _tradeLicenseController = TextEditingController(text: data['tradeLicense']?.toString() ?? '');
    _accountNameController = TextEditingController(text: data['accountHolderName']?.toString() ?? '');
    _bankNameController = TextEditingController(text: data['bankName']?.toString() ?? '');
    _accountNumberController = TextEditingController(text: data['accountNumber']?.toString() ?? '');
    _ifscController = TextEditingController(text: data['ifscCode']?.toString() ?? '');
    _branchController = TextEditingController(text: data['branch']?.toString() ?? '');
    _extraAmenitiesController = TextEditingController();
    _landmarkController = TextEditingController(text: data['landmark']?.toString() ?? '');
    _aadharController = TextEditingController(text: data['aadharNumber']?.toString() ?? '');
    _accountTypeController = TextEditingController(text: data['accountType']?.toString() ?? '');
    _declarationNameController = TextEditingController(text: data['declarationName']?.toString() ?? '');
    _signatureNameController = TextEditingController(text: data['signatureName']?.toString() ?? '');

    // Initialize other state variables
    _selectedHotelType = data['hotelType']?.toString() ?? '';
    _extraBedAvailable = data['extraBedAvailable'] == true;

    // Handle date properly
    final rawDate = data['declarationDate'];
    if (rawDate is DateTime) {
      _selectedDate = rawDate;
    } else if (rawDate is String) {
      _selectedDate = DateTime.tryParse(rawDate);
    } else {
      _selectedDate = null;
    }

    _declarationAccepted = data['declarationAccepted'] == true;

    // Initialize landline controllers
    final landlineNumbers = (data['landlineNumbers'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    _landlineControllers = landlineNumbers.isEmpty
        ? [TextEditingController()]
        : landlineNumbers.map((num) => TextEditingController(text: num)).toList();

    // Initialize room details
    final roomDetailsData = data['roomDetails'];
    if (roomDetailsData is Map<String, dynamic>) {
      _roomDetails = Map<String, Map<String, dynamic>>.from(roomDetailsData);
    } else {
      _roomDetails = {};
    }

    // Ensure all room types have entries
    List<String> allRoomTypes = [
      'Single Room', 'Double Room', 'Deluxe Room',
      'Suite Room', 'Family Room', 'Executive Room'
    ];

    for (var roomType in allRoomTypes) {
      if (!_roomDetails.containsKey(roomType)) {
        _roomDetails[roomType] = {
          'rooms': '',
          'occupancy': '',
          'ac': true,
          'price': '',
          'extraBed': false,
          'extraBedPrice': '',
        };
      }
    }

    // Initialize selected room types
    Map<String, bool> savedSelections = Map<String, bool>.from(data['selectedRoomTypes'] ?? {});
    _selectedRoomTypes = {
      'Single Room': savedSelections['Single Room'] ?? false,
      'Double Room': savedSelections['Double Room'] ?? false,
      'Deluxe Room': savedSelections['Deluxe Room'] ?? false,
      'Suite Room': savedSelections['Suite Room'] ?? false,
      'Family Room': savedSelections['Family Room'] ?? false,
      'Executive Room': savedSelections['Executive Room'] ?? false,
    };

    // Initialize amenities
    Map<String, bool> savedBasicAmenities = Map<String, bool>.from(data['basicAmenities'] ?? {});
    _basicAmenities = {
      'Free Wi-Fi': savedBasicAmenities['Free Wi-Fi'] ?? false,
      'Television': savedBasicAmenities['Television'] ?? false,
      'Air Conditioning': savedBasicAmenities['Air Conditioning'] ?? false,
      'Attached Bathroom': savedBasicAmenities['Attached Bathroom'] ?? false,
      'Hot Water': savedBasicAmenities['Hot Water'] ?? false,
      'Room Service': savedBasicAmenities['Room Service'] ?? false,
    };

    Map<String, bool> savedHotelFacilities = Map<String, bool>.from(data['hotelFacilities'] ?? {});
    _hotelFacilities = {
      '24-Hour Front Desk': savedHotelFacilities['24-Hour Front Desk'] ?? false,
      'Power Backup': savedHotelFacilities['Power Backup'] ?? false,
      'Lift / Elevator': savedHotelFacilities['Lift / Elevator'] ?? false,
      'Parking Facility': savedHotelFacilities['Parking Facility'] ?? false,
      'CCTV Security': savedHotelFacilities['CCTV Security'] ?? false,
    };

    Map<String, bool> savedFoodServices = Map<String, bool>.from(data['foodServices'] ?? {});
    _foodServices = {
      'Restaurant': savedFoodServices['Restaurant'] ?? false,
      'Complimentary Breakfast': savedFoodServices['Complimentary Breakfast'] ?? false,
      'In-Room Dining': savedFoodServices['In-Room Dining'] ?? false,
      'Tea / Coffee Maker': savedFoodServices['Tea / Coffee Maker'] ?? false,
    };

    Map<String, bool> savedAdditionalAmenities = Map<String, bool>.from(data['additionalAmenities'] ?? {});
    _additionalAmenities = {
      'Laundry Service': savedAdditionalAmenities['Laundry Service'] ?? false,
      'Travel Desk': savedAdditionalAmenities['Travel Desk'] ?? false,
      'Conference / Meeting Room': savedAdditionalAmenities['Conference / Meeting Room'] ?? false,
      'Wheelchair Access': savedAdditionalAmenities['Wheelchair Access'] ?? false,
    };

    _customAmenities = List<String>.from(data['customAmenities'] ?? []);

    // Initialize documents
    Map<String, bool> savedDocuments = Map<String, bool>.from(data['documents'] ?? {});
    _documents = {
      'GST Certificate': savedDocuments['GST Certificate'] ?? false,
      'FSSAI Certificate': savedDocuments['FSSAI Certificate'] ?? false,
      'Trade License': savedDocuments['Trade License'] ?? false,
      'Cancelled Cheque': savedDocuments['Cancelled Cheque'] ?? false,
      'Hotel Photos': savedDocuments['Hotel Photos'] ?? false,
      'Owner ID Proof': savedDocuments['Owner ID Proof'] ?? false,
      'Signature': savedDocuments['Signature'] ?? false,
    };

    // Initialize person photo info
    _personPhotoInfo = Map<String, dynamic>.from(data['personPhotoInfo'] ?? {
      'name': '', 'size': 0, 'path': '', 'uploaded': false,
    });
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
          'Edit Hotel Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_steps.length, (index) {
                        bool isActive = index == _currentStep;
                        bool isCompleted = index < _currentStep;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () {
                              if (index <= _currentStep) {
                                setState(() => _currentStep = index);
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive ? _primaryColor :
                                    isCompleted ? _successColor : Colors.white,
                                    border: Border.all(
                                      color: isActive || isCompleted ?
                                      Colors.transparent : _borderColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? Icon(Icons.check, size: 18, color: Colors.white)
                                        : Text('${index + 1}', style: TextStyle(
                                      color: isActive || isCompleted ?
                                      Colors.white : _textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    )),
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    _steps[index]['title'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: isActive || isCompleted ?
                                      _textPrimary : _textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / _steps.length,
                    backgroundColor: _borderColor,
                    color: _primaryColor,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Step ${_currentStep + 1} of ${_steps.length}',
                          style: TextStyle(fontSize: 12, color: _textSecondary)),
                      Text('${((_currentStep + 1) / _steps.length * 100).toInt()}%',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _primaryColor)),
                    ],
                  ),
                ],
              ),
            ),

            // Step content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('${_currentStep + 1}', style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _primaryColor,
                              )),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_steps[_currentStep]['title'], style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                )),
                                SizedBox(height: 4),
                                Text(_steps[_currentStep]['subtitle'], style: TextStyle(
                                  fontSize: 12,
                                  color: _textSecondary,
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    _buildStepContent(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Navigation buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _borderColor)),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                )],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Back', style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _textPrimary,
                          )),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == _steps.length - 1 ? 'Update Profile' : 'Next',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: return _buildStep1();
      case 1: return _buildStep2();
      case 2: return _buildStep3();
      case 3: return _buildStep4();
      case 4: return _buildStep5();
      default: return Container();
    }
  }


  Widget _buildStep1() {
    return Column(
      children: [
        _buildCard(
          title: 'Hotel Information',
          children: [
            // Hotel Name - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hotel Name *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.business, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _hotelNameController.text.isNotEmpty
                              ? _hotelNameController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('Hotel name cannot be changed during edit',
                    style: TextStyle(fontSize: 11, color: _textSecondary, fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hotel Type *', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Lodge', 'Budget Hotel', 'Standard Hotel',
                    'Guest House', 'Heritage Hotel', 'Boutique Hotel',
                  ].map((type) => _buildChip(type)).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Year of Establishment',
                    controller: _yearController,
                    hint: 'YYYY',
                    keyboardType: TextInputType.number,
                    enabled: true, // Can be edited
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Total Number of Rooms',
                    controller: _roomsController,
                    hint: '0',
                    keyboardType: TextInputType.number,
                    enabled: true, // Can be edited
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Contact Information',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile Photo', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                _buildPhotoUploadItem(),
              ],
            ),
            SizedBox(height: 16),

            // Owner Name - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Owner / Manager Name *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _ownerNameController.text.isNotEmpty
                              ? _ownerNameController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('Owner name cannot be changed during edit',
                    style: TextStyle(fontSize: 11, color: _textSecondary, fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(height: 16),

            // Mobile Number - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mobile Number *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _mobileController.text.isNotEmpty
                              ? _mobileController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('Mobile number cannot be changed during edit',
                    style: TextStyle(fontSize: 11, color: _textSecondary, fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(height: 16),

            // Alternate Contact - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alternate Contact', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.phone_android, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _altMobileController.text.isNotEmpty
                              ? _altMobileController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('Alternate contact cannot be changed during edit',
                    style: TextStyle(fontSize: 11, color: _textSecondary, fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Landline Number(s)', style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _textPrimary,
                    )),
                    if (_landlineControllers.length < 3)
                      TextButton(
                        onPressed: _addLandlineField,
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 16, color: _primaryColor),
                            SizedBox(width: 4),
                            Text('Add Landline', style: TextStyle(
                              fontSize: 12,
                              color: _primaryColor,
                              fontWeight: FontWeight.w500,
                            )),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: _landlineControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < _landlineControllers.length - 1 ? 12 : 0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter landline number ${index + 1}',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: _borderColor),
                                ),
                              ),
                            ),
                          ),
                          if (_landlineControllers.length > 1)
                            IconButton(
                              onPressed: () => _removeLandlineField(index),
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              padding: EdgeInsets.only(left: 8),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Email ID',
              controller: _emailController,
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
              enabled: true, // Can be edited
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Website (if any)',
              controller: _websiteController,
              hint: 'https://example.com',
              enabled: true, // Can be edited
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        _buildCard(
          title: 'Hotel Address',
          children: [
            // Address Line 1 - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address Line 1 *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _address1Controller.text.isNotEmpty
                              ? _address1Controller.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('Address cannot be changed during edit',
                    style: TextStyle(fontSize: 11, color: _textSecondary, fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(height: 16),

            // Address Line 2 - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address Line 2', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _address2Controller.text.isNotEmpty
                              ? _address2Controller.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // City - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_city, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _cityController.text.isNotEmpty
                              ? _cityController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // District - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('District *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.map, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _districtController.text.isNotEmpty
                              ? _districtController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // State - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('State *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.public, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _stateController.text.isNotEmpty
                              ? _stateController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // PIN Code - READ ONLY
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PIN Code *', style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                )),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.pin_drop, size: 20, color: _textSecondary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _pinController.text.isNotEmpty
                              ? _pinController.text
                              : 'Not provided',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            _buildInputField(
              label: 'Landmark (Optional)',
              controller: _landmarkController,
              hint: 'Nearby place',
              enabled: true, // Can be edited
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        _buildCard(
          title: 'Select Room Types Available',
          children: [
            Text('Select the room types available in your hotel:', style: TextStyle(
              fontSize: 13, color: _textSecondary,
            )),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedRoomTypes.entries.map((entry) {
                bool isSelected = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRoomTypes[entry.key] = !isSelected;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryLight : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? _primaryColor : _borderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          size: 16,
                          color: isSelected ? _primaryColor : _textSecondary,
                        ),
                        SizedBox(width: 6),
                        Text(entry.key, style: TextStyle(
                          fontSize: 13,
                          color: isSelected ? _primaryColor : _textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Divider(color: _borderColor),
            SizedBox(height: 16),
            Text('Configure selected room types:', style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            )),
            SizedBox(height: 12),
          ],
        ),

        ..._selectedRoomTypes.entries.where((entry) => entry.value).map((entry) {
          String roomType = entry.key;

          if (!_roomDetails.containsKey(roomType)) {
            _roomDetails[roomType] = {
              'rooms': '',
              'occupancy': '',
              'ac': true,
              'price': '',
              'extraBed': false,
              'extraBedPrice': '',
            };
          }

          final roomData = _roomDetails[roomType]!;

          return Container(
            margin: EdgeInsets.only(bottom: 16),
            child: _buildCard(
              title: '$roomType Details',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Number of Rooms',
                        controller: TextEditingController(
                          text: roomData['rooms'] ?? '',
                        ),
                        onChanged: (value) => roomData['rooms'] = value,
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Max Occupancy',
                        controller: TextEditingController(
                          text: roomData['occupancy'] ?? '',
                        ),
                        onChanged: (value) => roomData['occupancy'] = value,
                        hint: 'Persons',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSmallInput(
                        label: 'Price per Night (₹)',
                        controller: TextEditingController(
                          text: roomData['price'] ?? '',
                        ),
                        onChanged: (value) => roomData['price'] = value,
                        hint: '0',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('AC / Non-AC', style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildToggleChip(
                                  'AC',
                                  roomData['ac'] ?? true,
                                      () => setState(() => roomData['ac'] = true),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _buildToggleChip(
                                  'Non-AC',
                                  !(roomData['ac'] ?? true),
                                      () => setState(() => roomData['ac'] = false),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Extra Bed Available', style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              _buildToggleChip(
                                'Yes',
                                roomData['extraBed'] ?? false,
                                    () => setState(() => roomData['extraBed'] = true),
                              ),
                              SizedBox(width: 8),
                              _buildToggleChip(
                                'No',
                                !(roomData['extraBed'] ?? false),
                                    () => setState(() => roomData['extraBed'] = false),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    if (roomData['extraBed'] ?? false)
                      Expanded(
                        child: _buildSmallInput(
                          label: 'Extra Bed Price (₹)',
                          controller: TextEditingController(
                            text: roomData['extraBedPrice'] ?? '',
                          ),
                          onChanged: (value) => roomData['extraBedPrice'] = value,
                          hint: '0',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        }).toList(),

        SizedBox(height: 16),
        _buildCard(
          title: 'Select Price (per day):',
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _minTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rs',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('to', style: TextStyle(color: _textSecondary)),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _maxTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Rs',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Extra Bed Available Overall:', style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13,
                      )),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _extraBedAvailable,
                                  () => setState(() => _extraBedAvailable = true)),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_extraBedAvailable,
                                  () => setState(() => _extraBedAvailable = false)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      children: [
        _buildCard(
          title: 'Amenities Available',
          children: [
            _buildAmenitiesSelectionSection('Basic Amenities', _basicAmenities),
            SizedBox(height: 16),

            _buildAmenitiesSelectionSection('Hotel Facilities', _hotelFacilities),
            SizedBox(height: 16),

            _buildAmenitiesSelectionSection('Food & Services', _foodServices),
            SizedBox(height: 16),

            _buildAmenitiesSelectionSection('Additional Amenities', _additionalAmenities),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Extra Amenities',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Add any additional amenities not listed above',
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _extraAmenitiesController,
                        decoration: InputDecoration(
                          hintText: 'Enter amenities...',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.trim().isNotEmpty) _addCustomAmenity();
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _addCustomAmenity,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (_customAmenities.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _customAmenities.map((amenity) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _primaryLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _primaryColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                amenity,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _primaryColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => _removeCustomAmenity(amenity),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Legal Details',
          children: [
            _buildInputField(
              label: 'GST Number',
              controller: _gstController,
              hint: 'Enter GST number',
              enabled: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'FSSAI License No.',
                    controller: _fssaiController,
                    hint: 'If restaurant',
                    enabled: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Trade License No.',
                    controller: _tradeLicenseController,
                    hint: 'Enter license number',
                    enabled: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Aadhar Number (Owner)',
              controller: _aadharController,
              hint: 'Enter Aadhar number',
              enabled: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      children: [
        _buildCard(
          title: 'Bank Details',
          children: [
            _buildInputField(
              label: 'Account Holder Name *',
              controller: _accountNameController,
              hint: 'Enter name',
              enabled: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Bank Name *',
              controller: _bankNameController,
              hint: 'Enter bank name',
              enabled: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Account Number *',
                    controller: _accountNumberController,
                    hint: 'Enter account number',
                    keyboardType: TextInputType.number,
                    enabled: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'IFSC Code *',
                    controller: _ifscController,
                    hint: 'Enter IFSC code',
                    enabled: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Branch',
              controller: _branchController,
              hint: 'Enter branch name',
              enabled: true,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Account Type',
              controller: _accountTypeController,
              hint: 'Savings / Current',
              enabled: true,
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Documents Required',
          children: [
            Text('Please note: Uploaded documents cannot be deleted during edit. Contact admin for document changes.',
                style: TextStyle(fontSize: 12, color: _textSecondary)),
            SizedBox(height: 16),

            if (_uploadedFiles.containsKey('FSSAI Certificate'))
              _buildDocumentUploadItem(
                documentName: 'FSSAI Certificate',
                fileInfo: _uploadedFiles['FSSAI Certificate']!,
                onViewPressed: () => _viewDocument('FSSAI Certificate'),
                isOptional: true,
                optionalText: 'Required only if you have a restaurant',
              ),

            SizedBox(height: 12),
            ..._uploadedFiles.entries.where((entry) =>
            entry.key != 'FSSAI Certificate' &&
                entry.key != 'Signature').map((entry) =>
                _buildDocumentUploadItem(
                  documentName: entry.key,
                  fileInfo: entry.value,
                  onViewPressed: () => _viewDocument(entry.key),
                ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: 'Declaration',
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _declarationAccepted
                    ? _successColor.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _declarationAccepted ? _successColor : _borderColor,
                  width: _declarationAccepted ? 1.5 : 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _declarationAccepted,
                    onChanged: (value) => setState(() => _declarationAccepted = value ?? false),
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0C4A6E),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (_uploadedFiles.containsKey('Signature'))
              _buildDocumentUploadItem(
                documentName: 'Signature',
                fileInfo: _uploadedFiles['Signature']!,
                onViewPressed: () => _viewDocument('Signature'),
                isOptional: false,
                signatureHint: 'Uploaded signature',
              ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  label: 'Name',
                  controller: _declarationNameController,
                  hint: 'Enter your name',
                  enabled: true,
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date', style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13,
                    )),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: _borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : 'Select date',
                              style: TextStyle(
                                fontSize: 14,
                                color: _selectedDate != null
                                    ? _textPrimary : _textSecondary,
                              ),
                            ),
                            Icon(Icons.calendar_today, size: 18, color: _textSecondary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          )),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _textPrimary,
        )),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _borderColor),
            ),
            filled: !enabled,
            fillColor: Colors.grey.shade100,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _textPrimary,
        )),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: _borderColor),
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    bool isSelected = _selectedHotelType == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedHotelType = isSelected ? null : label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _primaryColor : _borderColor),
        ),
        child: Text(label, style: TextStyle(
          fontSize: 12,
          color: isSelected ? _primaryColor : _textSecondary,
        )),
      ),
    );
  }

  Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _primaryColor : _borderColor),
        ),
        child: Text(label, style: TextStyle(
          fontSize: 12,
          color: isSelected ? _primaryColor : _textSecondary,
        )),
      ),
    );
  }

  Widget _buildAmenitiesSelectionSection(String title, Map<String, bool> amenities) {
    return Column(
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
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected ${amenities.values.where((v) => v).length} of ${amenities.length}',
              style: TextStyle(
                fontSize: 11,
                color: _textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
            if (amenities.values.any((v) => v))
              GestureDetector(
                onTap: () {
                  amenities.forEach((key, value) {
                    amenities[key] = false;
                  });
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenities.entries.map((entry) {
            bool isSelected = entry.value;
            String amenityName = entry.key;

            return GestureDetector(
              onTap: () {
                setState(() {
                  amenities[amenityName] = !isSelected;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? _primaryColor : _borderColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      size: 16,
                      color: isSelected ? Colors.white : _textSecondary,
                    ),
                    SizedBox(width: 6),
                    Text(
                      amenityName,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? Colors.white : _textSecondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadItem() {
    final isUploaded = _personPhotoInfo['uploaded'] as bool? ?? false;
    final fileName = _personPhotoInfo['name'] as String? ?? '';

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person, size: 18,
                      color: isUploaded ? _successColor : _primaryColor),
                  SizedBox(width: 8),
                  Text('Profile Photo', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: isUploaded ? _successColor : _textPrimary,
                  )),
                ],
              ),
              if (isUploaded) Row(
                children: [
                  Icon(Icons.check_circle, color: _successColor, size: 16),
                  SizedBox(width: 4),
                  Text('Uploaded', style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ],
          ),
          if (isUploaded && fileName.isNotEmpty) Container(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(Icons.photo, size: 20, color: _primaryColor),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fileName, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: _textPrimary,
                        ), maxLines: 1, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 2),
                        Text('Photo already uploaded',
                            style: TextStyle(fontSize: 10, color: _textSecondary)),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: _viewPersonPhoto,
                    icon: Icon(Icons.remove_red_eye, size: 18, color: _primaryColor),
                    padding: EdgeInsets.all(4),
                    tooltip: 'View',
                  ),
                ],
              ),
            ),
          ),
          if (!isUploaded) SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _pickPersonPhoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_camera, size: 16, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Upload Photo', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Modified: Removed delete option, only view option available
  Widget _buildDocumentUploadItem({
    required String documentName,
    required Map<String, dynamic> fileInfo,
    required VoidCallback onViewPressed,
    bool isOptional = false,
    String? optionalText,
    String? signatureHint,
  }) {
    final fileName = fileInfo['name'] as String? ?? '';
    final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    IconData getDocumentIcon() {
      if (documentName.contains('Signature')) return Icons.draw;
      if (documentName.contains('GST')) return Icons.receipt;
      if (documentName.contains('FSSAI')) return Icons.restaurant;
      if (documentName.contains('License')) return Icons.badge;
      if (documentName.contains('Cheque')) return Icons.account_balance;
      if (documentName.contains('Photos')) return Icons.photo_library;
      if (documentName.contains('Proof')) return Icons.perm_identity;
      return Icons.description;
    }

    Color getIconColor() {
      if (isUploaded) return _successColor;
      if (documentName.contains('Signature')) return Colors.red;
      if (documentName.contains('FSSAI')) return Colors.red;
      return _primaryColor;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(getDocumentIcon(), size: 18, color: getIconColor()),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(documentName, style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: isUploaded ? _successColor : _textPrimary,
                      )),
                      if (isOptional && optionalText != null) Text(optionalText,
                          style: TextStyle(fontSize: 10, color: _textSecondary)),
                      if (signatureHint != null) Text(signatureHint,
                          style: TextStyle(fontSize: 10, color: _textSecondary)),
                    ],
                  ),
                ],
              ),
              if (isUploaded) Row(
                children: [
                  Icon(Icons.check_circle, color: _successColor, size: 16),
                  SizedBox(width: 4),
                  Text('Uploaded', style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ],
          ),
          if (isUploaded && fileName.isNotEmpty) Container(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  if (documentName.contains('Signature')) Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(Icons.draw, size: 20, color: Colors.purple),
                    ),
                  ) else Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(child: _getFileIcon(fileName)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fileName, style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: _textPrimary,
                        ), maxLines: 1, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 2),
                        Text('${(fileSize / 1024).toStringAsFixed(1)} KB • '
                            '${_getFileExtension(fileName).toUpperCase()}',
                            style: TextStyle(fontSize: 10, color: _textSecondary)),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: onViewPressed,
                    icon: Icon(Icons.remove_red_eye, size: 18, color: _primaryColor),
                    padding: EdgeInsets.all(4),
                    tooltip: 'View',
                  ),
                ],
              ),
            ),
          ),
          if (!isUploaded) SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _pickDocument(documentName),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 16, color: Colors.white),
                  SizedBox(width: 8),
                  Text(documentName.contains('Signature')
                      ? 'Upload Signature' : 'Upload $documentName',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getFileIcon(String fileName) {
    final ext = _getFileExtension(fileName).toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icon(Icons.image, size: 20, color: _primaryColor);
    } else if (['pdf'].contains(ext)) {
      return Icon(Icons.picture_as_pdf, size: 20, color: Colors.red);
    } else if (['doc', 'docx'].contains(ext)) {
      return Icon(Icons.description, size: 20, color: Colors.blue);
    } else {
      return Icon(Icons.insert_drive_file, size: 20, color: _primaryColor);
    }
  }

  String _getFileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }

  void _addLandlineField() {
    if (_landlineControllers.length < 3) {
      setState(() => _landlineControllers.add(TextEditingController()));
    }
  }

  void _removeLandlineField(int index) {
    if (_landlineControllers.length > 1) {
      setState(() {
        _landlineControllers[index].dispose();
        _landlineControllers.removeAt(index);
      });
    }
  }

  void _addCustomAmenity() {
    final amenity = _extraAmenitiesController.text.trim();
    if (amenity.isNotEmpty && !_customAmenities.contains(amenity)) {
      setState(() {
        _customAmenities.add(amenity);
        _extraAmenitiesController.clear();
      });
    }
  }

  void _removeCustomAmenity(String amenity) {
    setState(() => _customAmenities.remove(amenity));
  }

  Future<void> _pickPersonPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          _personPhotoInfo = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
          };
        });
      }
    } catch (e) {
      print('Error picking photo: $e');
    }
  }

  void _viewPersonPhoto() {
    final fileName = _personPhotoInfo['name'] as String? ?? '';
    if (fileName.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Profile Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                  image: _personPhotoInfo['path'] != null
                      ? DecorationImage(
                    image: FileImage(File(_personPhotoInfo['path'])),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _personPhotoInfo['path'] == null
                    ? Icon(Icons.person, size: 60, color: _primaryColor)
                    : null,
              ),
              SizedBox(height: 16),
              Text(fileName, textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _pickDocument(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          _uploadedFiles[documentType] = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
          };
        });
      }
    } catch (e) {
      print('Error picking document: $e');
    }
  }

  void _viewDocument(String documentType) {
    final fileInfo = _uploadedFiles[documentType]!;
    final fileName = fileInfo['name'] as String? ?? '';
    if (fileName.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(documentType.contains('Signature')
                  ? Icons.draw : Icons.description,
                  color: documentType.contains('Signature')
                      ? Colors.purple : _primaryColor),
              SizedBox(width: 12),
              Expanded(child: Text(documentType, overflow: TextOverflow.ellipsis)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(child: _getFileIcon(fileName)),
              ),
              SizedBox(height: 16),
              Text('File Details:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text('Name: $fileName'),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _updateProfile();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }


  // void _updateProfile() {
  //   // Collect all updated data
  //   Map<String, dynamic> updatedData = {
  //     'hotelName': _hotelNameController.text,
  //     'hotelType': _selectedHotelType,
  //     'yearOfEstablishment': _yearController.text,
  //     'totalRooms': int.tryParse(_roomsController.text) ?? 0,
  //     'ownerName': _ownerNameController.text,
  //     'mobileNumber': _mobileController.text,
  //     'alternateContact': _altMobileController.text,
  //     'landlineNumbers': _landlineControllers
  //         .map((c) => c.text)
  //         .where((text) => text.isNotEmpty)
  //         .toList(),
  //     'email': _emailController.text,
  //     'website': _websiteController.text,
  //     'addressLine1': _address1Controller.text,
  //     'addressLine2': _address2Controller.text,
  //     'city': _cityController.text,
  //     'district': _districtController.text,
  //     'state': _stateController.text,
  //     'pinCode': _pinController.text,
  //     'landmark': _landmarkController.text,
  //     'selectedRoomTypes': _selectedRoomTypes,
  //     'roomDetails': _roomDetails,
  //     'minTariff': _minTariffController.text,
  //     'maxTariff': _maxTariffController.text,
  //     'extraBedAvailable': _extraBedAvailable,
  //     'basicAmenities': _basicAmenities,
  //     'hotelFacilities': _hotelFacilities,
  //     'foodServices': _foodServices,
  //     'additionalAmenities': _additionalAmenities,
  //     'customAmenities': _customAmenities,
  //     'gstNumber': _gstController.text,
  //     'fssaiLicense': _fssaiController.text,
  //     'tradeLicense': _tradeLicenseController.text,
  //     'aadharNumber': _aadharController.text,
  //     'accountHolderName': _accountNameController.text,
  //     'bankName': _bankNameController.text,
  //     'accountNumber': _accountNumberController.text,
  //     'ifscCode': _ifscController.text,
  //     'branch': _branchController.text,
  //     'accountType': _accountTypeController.text,
  //     'uploadedFiles': _uploadedFiles,
  //     'signatureName': _signatureNameController.text,
  //     'declarationName': _declarationNameController.text,
  //     'declarationDate': _selectedDate,
  //     'personPhotoInfo': _personPhotoInfo,
  //     'declarationAccepted': _declarationAccepted,
  //   };
  //
  //   // Merge with existing registration data
  //   Map<String, dynamic> finalData = {
  //     ...widget.registrationData,
  //     ...updatedData,
  //   };
  //
  //   // Show success message
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Profile updated successfully!'),
  //       backgroundColor: _successColor,
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  //
  //   // Option 1: If you want to pass the data back to MyProfileScreen
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => HotelOwnerProfilePage(hotelName: '', ownerName: '', mobileNumber: '', email: '', addressLine1: '', addressLine2: '', city: '', district: '', state: '', pinCode: '', gstNumber: '', fssaiLicense: '', tradeLicense: '', aadharNumber: '', accountHolderName: '', bankName: '', accountNumber: '', ifscCode: '', branch: '', accountType: '', totalRooms: 0, personPhotoInfo: {}, selectedRoomTypes: {}, roomDetails: {}, basicAmenities: {}, hotelFacilities: {}, foodServices: {}, additionalAmenities: {}, customAmenities: []),
  //     ),
  //         (route) => false, // Remove all previous routes
  //   );
  //
  //
  // }

  void _updateProfile() {
    // Collect all updated data
    Map<String, dynamic> updatedData = {
      'hotelName': _hotelNameController.text,
      'hotelType': _selectedHotelType,
      'yearOfEstablishment': _yearController.text,
      'totalRooms': int.tryParse(_roomsController.text) ?? 0,
      'ownerName': _ownerNameController.text,
      'mobileNumber': _mobileController.text,
      'alternateContact': _altMobileController.text,
      'email': _emailController.text,
      'website': _websiteController.text,
      'addressLine1': _address1Controller.text,
      'addressLine2': _address2Controller.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'pinCode': _pinController.text,
      'selectedRoomTypes': _selectedRoomTypes,
      'roomDetails': _roomDetails,
      'minTariff': _minTariffController.text,
      'maxTariff': _maxTariffController.text,
      'extraBedAvailable': _extraBedAvailable,
      'basicAmenities': _basicAmenities,
      'hotelFacilities': _hotelFacilities,
      'foodServices': _foodServices,
      'additionalAmenities': _additionalAmenities,
      'customAmenities': _customAmenities,
      'gstNumber': _gstController.text,
      'fssaiLicense': _fssaiController.text,
      'tradeLicense': _tradeLicenseController.text,
      'aadharNumber': _aadharController.text,
      'accountHolderName': _accountNameController.text,
      'bankName': _bankNameController.text,
      'accountNumber': _accountNumberController.text,
      'ifscCode': _ifscController.text,
      'branch': _branchController.text,
      'accountType': _accountTypeController.text,
      'uploadedFiles': _uploadedFiles,
      'signatureName': _signatureNameController.text,
      'declarationName': _declarationNameController.text,
      'declarationDate': _selectedDate,
      'personPhotoInfo': _personPhotoInfo,
      'declarationAccepted': _declarationAccepted,
    };

    // Merge with existing registration data
    Map<String, dynamic> finalData = {
      ...widget.registrationData,
      ...updatedData,
    };

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: _successColor,
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate back with updated data
    Navigator.pop(context, finalData);
  }

  @override
  // void dispose() {
  //   // Dispose all controllers
  //   _hotelNameController.dispose();
  //   _yearController.dispose();
  //   _roomsController.dispose();
  //   _ownerNameController.dispose();
  //   _mobileController.dispose();
  //   _altMobileController.dispose();
  //   _emailController.dispose();
  //   _websiteController.dispose();
  //   _address1Controller.dispose();
  //   _address2Controller.dispose();
  //   _cityController.dispose();
  //   _districtController.dispose();
  //   _stateController.dispose();
  //   _pinController.dispose();
  //   _minTariffController.dispose();
  //   _maxTariffController.dispose();
  //   _gstController.dispose();
  //   _fssaiController.dispose();
  //   _tradeLicenseController.dispose();
  //   _accountNameController.dispose();
  //   _bankNameController.dispose();
  //   _accountNumberController.dispose();
  //   _ifscController.dispose();
  //   _branchController.dispose();
  //   _extraAmenitiesController.dispose();
  //   _landmarkController.dispose();
  //   _aadharController.dispose();
  //   _accountTypeController.dispose();
  //   _declarationNameController.dispose();
  //   _signatureNameController.dispose();
  //
  //   for (var controller in _landlineControllers) {
  //     controller.dispose();
  //   }
  //
  //   super.dispose();
  // }
  @override
  void dispose() {
    // Dispose all controllers
    _hotelNameController.dispose();
    _yearController.dispose();
    _roomsController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    _minTariffController.dispose();
    _maxTariffController.dispose();
    _gstController.dispose();
    _fssaiController.dispose();
    _tradeLicenseController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    _extraAmenitiesController.dispose();
    _landmarkController.dispose();
    _aadharController.dispose();
    _accountTypeController.dispose();
    _declarationNameController.dispose();
    _signatureNameController.dispose();

    // Dispose landline controllers
    for (var controller in _landlineControllers) {
      controller.dispose();
    }

    super.dispose();
  }

}

class TwoStarHotelRegistrationScreen extends StatefulWidget {
  const TwoStarHotelRegistrationScreen({super.key});

  @override
  State<TwoStarHotelRegistrationScreen> createState() => _TwoStarHotelRegistrationScreenState();
}

class _TwoStarHotelRegistrationScreenState extends State<TwoStarHotelRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final Color _primaryColor = Color(0xFF6B8E23);
  final Color _primaryLight = Color(0xFFF0F8E0);
  final Color _bgColor = Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _textPrimary = Color(0xFF111827);
  final Color _textSecondary = Color(0xFF6B7280);
  final Color _successColor = Color(0xFF8BC34A);

  // Controllers
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _altMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController(text: '14:00');
  final TextEditingController _checkOutController = TextEditingController(text: '12:00');
  final TextEditingController _minTariffController = TextEditingController();
  final TextEditingController _maxTariffController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _tradeLicenseController = TextEditingController();
  final TextEditingController _fssaiController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _declarationNameController = TextEditingController();

  // Room Details (Removed bedType)
  final Map<String, Map<String, dynamic>> _roomDetails = {
    'Single Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
    },
    'Double Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
    },
    'Deluxe Room': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'price': '',
    },
  };

  // Selected Room Types
  Map<String, bool> _selectedRoomTypes = {
    'Single Room': false,
    'Double Room': false,
    'Deluxe Room': false,
  };

  // Hotel Type Selection
  String? _selectedHotelType;

  // Extra Bed Facility
  bool _extraBedAvailable = false;

  // Amenities
  Map<String, bool> _roomAmenities = {
    'Air Conditioning': false,
    'Free Wi-Fi': false,
    'Television (Cable/DTH)': false,
    'Attached Bathroom': false,
    'Hot & Cold Water': false,
    'Wardrobe / Storage': false,
    'Study Table & Chair': false,
  };

  Map<String, bool> _hotelFacilities = {
    '24-Hour Front Desk': false,
    'Daily Housekeeping': false,
    'Power Backup': false,
    'Lift / Elevator': false,
    'Parking Facility': false,
    'CCTV Surveillance': false,
    'Fire Safety Equipment': false,
  };

  Map<String, bool> _foodServices = {
    'In-House Restaurant': false,
    'Complimentary Breakfast': false,
    'Room Service (Limited Hours)': false,
    'Drinking Water (Complimentary)': false,
  };

  Map<String, bool> _guestServices = {
    'Laundry / Ironing Service': false,
    'Wake-up Call Service': false,
    'Travel Desk / Taxi Assistance': false,
    'Doctor on Call': false,
  };

  // ID Proof Requirements - Single Selection (changed from multiple)
  String? _selectedIdProof;

  // Policies
  bool _coupleFriendly = true;
  bool _petsAllowed = false;
// Add this with other state variables
  final Map<String, dynamic> _signatureFile = {
    'name': '',
    'size': 0,
    'path': '',
    'uploaded': false,
  };
  // Document Uploads
  final Map<String, Map<String, dynamic>> _uploadedFiles = {
    'GST Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Trade License': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'FSSAI Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Cancelled Cheque': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Hotel Registration Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Room & Property Photos': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    // 'Signature of Authorized Person': {'name': '', 'size': 0, 'path': '', 'uploaded': false}, // Added signature upload
  };

  // Declaration
  bool _declarationAccepted = false;
  DateTime? _selectedDate;

  // Steps
  final List<Map<String, dynamic>> _steps = [
    {'title': 'Hotel Info', 'subtitle': 'Basic hotel details'},
    {'title': 'Contact & Address', 'subtitle': 'Contact and location'},
    {'title': 'Room Configuration', 'subtitle': 'Room types and rates'},
    {'title': 'Amenities & Policies', 'subtitle': 'Facilities and rules'},
    {'title': 'Legal & Documents', 'subtitle': 'Compliance and files'},
  ];

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
          '2-Star Hotel Vendor Registration Form',
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress Steps
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_steps.length, (index) {
                        bool isActive = index == _currentStep;
                        bool isCompleted = index < _currentStep;

                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () {
                              if (index <= _currentStep) {
                                setState(() {
                                  _currentStep = index;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive
                                        ? _primaryColor
                                        : isCompleted
                                        ? _successColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: isActive || isCompleted
                                          ? Colors.transparent
                                          : _borderColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? Icon(
                                      Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    )
                                        : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive || isCompleted
                                            ? Colors.white
                                            : _textSecondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    _steps[index]['title'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: isActive || isCompleted
                                          ? _textPrimary
                                          : _textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / _steps.length,
                    backgroundColor: _borderColor,
                    color: _primaryColor,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of ${_steps.length}',
                        style: TextStyle(fontSize: 12, color: _textSecondary),
                      ),
                      Text(
                        '${((_currentStep + 1) / _steps.length * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Header
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${_currentStep + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _steps[_currentStep]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _steps[_currentStep]['subtitle'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '2-Star',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Step Content
                    _buildStepContent(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == _steps.length - 1
                              ? 'Submit Registration'
                              : 'Continue',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1(); // Hotel Information
      case 1:
        return _buildStep2(); // Contact & Address
      case 2:
        return _buildStep3(); // Room Configuration
      case 3:
        return _buildStep4(); // Amenities & Policies
      case 4:
        return _buildStep5(); // Legal & Documents
      default:
        return Container();
    }
  }

  // Step 1: Hotel Information
  Widget _buildStep1() {
    return Column(
      children: [
        _buildCard(
          title: '1. Hotel Information',
          children: [
            _buildInputField(
              label: 'Hotel Name *',
              controller: _hotelNameController,
              hint: 'Enter hotel name',
            ),
            SizedBox(height: 16),

            // Hotel Category (Fixed as 2-Star)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Icon(Icons.star, size: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hotel Category',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _textSecondary,
                          ),
                        ),
                        Text(
                          '2-Star Hotel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Hotel Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Type *',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Business',
                    'Family',
                    'Tourist',
                    'Lodge',
                  ].map((type) => _buildHotelTypeChip(type)).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Year of Establishment',
                    controller: _yearController,
                    hint: 'YYYY',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Total Number of Rooms',
                    controller: _roomsController,
                    hint: '0',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 2: Contact & Address
  Widget _buildStep2() {
    return Column(
      children: [
        _buildCard(
          title: '2. Contact Details',
          children: [
            _buildInputField(
              label: 'Owner / Authorized Person Name *',
              controller: _ownerNameController,
              hint: 'Enter full name',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Designation',
              controller: _designationController,
              hint: 'e.g., Owner, Manager',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Mobile Number *',
              controller: _mobileController,
              hint: 'Enter 10-digit mobile number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Alternate Contact Number',
              controller: _altMobileController,
              hint: 'Optional',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Email ID',
              controller: _emailController,
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Website / Booking Link (if any)',
              controller: _websiteController,
              hint: 'https://example.com',
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '3. Hotel Address',
          children: [
            _buildInputField(
              label: 'Address Line 1 *',
              controller: _address1Controller,
              hint: 'Street address',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Address Line 2',
              controller: _address2Controller,
              hint: 'Apartment, suite, etc.',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'City *',
                    controller: _cityController,
                    hint: 'Enter city',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'District *',
                    controller: _districtController,
                    hint: 'Enter district',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'State *',
                    controller: _stateController,
                    hint: 'Enter state',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'PIN Code *',
                    controller: _pinController,
                    hint: '6-digit PIN',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return Column(
      children: [
        _buildCard(
          title: '4. Room Details',
          children: [
            // Room Types Selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Room Types Available:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedRoomTypes.entries.map((entry) {
                    bool isSelected = entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRoomTypes[entry.key] = !isSelected;
                        });
                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? _primaryLight : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? _primaryColor : _borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 16,
                              color: isSelected ? _primaryColor : _textSecondary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 13,
                                color: isSelected ? _primaryColor : _textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Room Configuration for selected types
            if (_selectedRoomTypes.entries.any((entry) => entry.value))
              Column(
                children: [
                  Text(
                    'Configure selected room types:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  SizedBox(height: 16),
                  ..._selectedRoomTypes.entries
                      .where((entry) => entry.value)
                      .map((entry) {
                    String roomType = entry.key;
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: _buildRoomConfigurationCard(roomType),
                    );
                  }).toList(),
                ],
              ),

            SizedBox(height: 20),
            Divider(color: _borderColor),
            SizedBox(height: 20),

            // Extra Bed Facility
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Extra Bed Facility:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildToggleChip('Yes', _extraBedAvailable, () {
                      setState(() => _extraBedAvailable = true);
                    }),
                    SizedBox(width: 12),
                    _buildToggleChip('No', !_extraBedAvailable, () {
                      setState(() => _extraBedAvailable = false);
                    }),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Room Tariff
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Tariff (per night):',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _minTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Minimum',
                          prefixText: '₹ ',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('to', style: TextStyle(color: _textSecondary)),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _maxTariffController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Maximum',
                          prefixText: '₹ ',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: _borderColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 4: Amenities & Policies
  Widget _buildStep4() {
    return Column(
      children: [
        _buildCard(
          title: '5. Amenities Available',
          children: [
            // Room Amenities
            _buildAmenitiesSection('Room Amenities', _roomAmenities),
            SizedBox(height: 20),

            // Hotel Facilities
            _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
            SizedBox(height: 20),

            // Food & Beverage
            _buildAmenitiesSection('Food & Beverage', _foodServices),
            SizedBox(height: 20),

            // Guest Services
            _buildAmenitiesSection('Guest Services', _guestServices),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '6. Check-in & Policies',
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Standard Check-in Time',
                    controller: _checkInController, // To this
                    hint: 'HH:MM',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Standard Check-out Time',
                    controller: _checkOutController,
                    hint: 'HH:MM',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // ID Proof Required - SINGLE SELECTION (Changed)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Proof Required: *',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Aadhaar'),
                      value: 'Aadhaar',
                      groupValue: _selectedIdProof,
                      onChanged: (value) {
                        setState(() {
                          _selectedIdProof = value;
                        });
                      },
                      activeColor: _primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    RadioListTile<String>(
                      title: Text('Passport'),
                      value: 'Passport',
                      groupValue: _selectedIdProof,
                      onChanged: (value) {
                        setState(() {
                          _selectedIdProof = value;
                        });
                      },
                      activeColor: _primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    RadioListTile<String>(
                      title: Text('Driving License'),
                      value: 'Driving License',
                      groupValue: _selectedIdProof,
                      onChanged: (value) {
                        setState(() {
                          _selectedIdProof = value;
                        });
                      },
                      activeColor: _primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Policies
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Couple Friendly:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _coupleFriendly, () {
                            setState(() => _coupleFriendly = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_coupleFriendly, () {
                            setState(() => _coupleFriendly = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pets Allowed:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _petsAllowed, () {
                            setState(() => _petsAllowed = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_petsAllowed, () {
                            setState(() => _petsAllowed = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 5: Legal & Documents
  Widget _buildStep5() {
    return Column(
      children: [
        _buildCard(
          title: '7. Legal & Compliance Details',
          children: [
            _buildInputField(
              label: 'GST Number',
              controller: _gstController,
              hint: 'Enter GST number',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Trade License Number',
              controller: _tradeLicenseController,
              hint: 'Enter trade license number',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'FSSAI License No. (if restaurant)',
              controller: _fssaiController,
              hint: 'Optional',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'PAN Number',
              controller: _panController,
              hint: 'Enter PAN number',
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '8. Bank Details (Payment Settlement)',
          children: [
            _buildInputField(
              label: 'Account Holder Name *',
              controller: _accountNameController,
              hint: 'Enter name as per bank',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Bank Name *',
              controller: _bankNameController,
              hint: 'Enter bank name',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Account Number *',
                    controller: _accountNumberController,
                    hint: 'Enter account number',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'IFSC Code *',
                    controller: _ifscController,
                    hint: 'Enter IFSC code',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Branch',
              controller: _branchController,
              hint: 'Enter branch name',
            ),
          ],
        ),
        SizedBox(height: 16),
        // _buildCard(
        //   title: '9. Documents to be Submitted',
        //   children: [
        //     Text(
        //       'Please upload clear scanned copies of the following documents:',
        //       style: TextStyle(fontSize: 12, color: _textSecondary),
        //     ),
        //     SizedBox(height: 16),
        //     ..._uploadedFiles.entries.map((entry) {
        //       return _buildDocumentUploadItem(
        //         documentName: entry.key,
        //         fileInfo: entry.value,
        //         onUploadPressed: () => _pickDocument(entry.key),
        //         onViewPressed: () => _viewDocument(entry.key),
        //         onRemovePressed: () => _removeDocument(entry.key),
        //         isOptional: entry.key == 'FSSAI Certificate',
        //         // isSignature: entry.key == 'Signature of Authorized Person', // Special handling for signature
        //       );
        //     }).toList(),
        //   ],
        // ),

        _buildCard(
          title: '9. Documents to be Submitted',
          children: [
            Text(
              'Please upload clear scanned copies of the following documents:',
              style: TextStyle(fontSize: 12, color: _textSecondary),
            ),
            SizedBox(height: 16),

            // GST Certificate
            _buildDocumentUploadItem(
              documentName: 'GST Certificate',
              fileInfo: _uploadedFiles['GST Certificate']!,
              onUploadPressed: () => _pickDocument('GST Certificate'),
              onViewPressed: () => _viewDocument('GST Certificate'),
              onRemovePressed: () => _removeDocument('GST Certificate'),
              isOptional: false,
            ),

            // Trade License
            _buildDocumentUploadItem(
              documentName: 'Trade License',
              fileInfo: _uploadedFiles['Trade License']!,
              onUploadPressed: () => _pickDocument('Trade License'),
              onViewPressed: () => _viewDocument('Trade License'),
              onRemovePressed: () => _removeDocument('Trade License'),
              isOptional: false,
            ),

            // FSSAI Certificate
            _buildDocumentUploadItem(
              documentName: 'FSSAI Certificate',
              fileInfo: _uploadedFiles['FSSAI Certificate']!,
              onUploadPressed: () => _pickDocument('FSSAI Certificate'),
              onViewPressed: () => _viewDocument('FSSAI Certificate'),
              onRemovePressed: () => _removeDocument('FSSAI Certificate'),
              isOptional: true,
            ),

            // Cancelled Cheque
            _buildDocumentUploadItem(
              documentName: 'Cancelled Cheque',
              fileInfo: _uploadedFiles['Cancelled Cheque']!,
              onUploadPressed: () => _pickDocument('Cancelled Cheque'),
              onViewPressed: () => _viewDocument('Cancelled Cheque'),
              onRemovePressed: () => _removeDocument('Cancelled Cheque'),
              isOptional: false,
            ),

            // Hotel Registration Certificate
            _buildDocumentUploadItem(
              documentName: 'Hotel Registration Certificate',
              fileInfo: _uploadedFiles['Hotel Registration Certificate']!,
              onUploadPressed: () => _pickDocument('Hotel Registration Certificate'),
              onViewPressed: () => _viewDocument('Hotel Registration Certificate'),
              onRemovePressed: () => _removeDocument('Hotel Registration Certificate'),
              isOptional: false,
            ),

            // Room & Property Photos
            _buildDocumentUploadItem(
              documentName: 'Room & Property Photos',
              fileInfo: _uploadedFiles['Room & Property Photos']!,
              onUploadPressed: () => _pickDocument('Room & Property Photos'),
              onViewPressed: () => _viewDocument('Room & Property Photos'),
              onRemovePressed: () => _removeDocument('Room & Property Photos'),
              isOptional: false,
            ),

            // NO SIGNATURE ITEM HERE
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '10. Declaration',
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _declarationAccepted
                    ? _successColor.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _declarationAccepted ? _successColor : _borderColor,
                  width: _declarationAccepted ? 1.5 : 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _declarationAccepted,
                    onChanged: (value) {
                      setState(() {
                        _declarationAccepted = value ?? false;
                      });
                    },
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'I hereby confirm that all the information provided above is true and accurate. I agree to abide by the terms and conditions of the company/platform.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0C4A6E),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Signature of Authorized Person',
            //       style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w600,
            //         color: _textPrimary,
            //       ),
            //     ),
            //
            //     SizedBox(height: 16),
            //
            //     // Signature upload widget
            //     _buildSignatureUploadItem(),
            //   ],
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signature of Authorized Person',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 16),

                // Signature upload widget
                _buildSignatureUploadItem(),
              ],
            ),
            SizedBox(height: 16),

            // Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date *',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: _borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select date',
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedDate != null
                                ? _textPrimary
                                : _textSecondary,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: _textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildSignatureUploadItem() {
  //   final signatureInfo = _uploadedFiles['Signature of Authorized Person']!;
  //   final fileName = signatureInfo['name'] as String? ?? '';
  //   final isUploaded = (signatureInfo['uploaded'] as bool?) ?? false;
  //   final fileSize = (signatureInfo['size'] as int?) ?? 0;
  //
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(
  //         color: isUploaded ? _successColor : _borderColor,
  //         width: isUploaded ? 1.5 : 1,
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.note_alt_outlined,
  //                   size: 20,
  //                   color: _primaryColor,
  //                 ),
  //                 SizedBox(width: 10),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Digital Signature',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 14,
  //                         color: _textPrimary,
  //                       ),
  //                     ),
  //                     Text(
  //                       'PNG, JPG, or PDF format',
  //                       style: TextStyle(
  //                         fontSize: 11,
  //                         color: _textSecondary,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             if (isUploaded)
  //               Row(
  //                 children: [
  //                   Icon(Icons.check_circle, color: _successColor, size: 16),
  //                   SizedBox(width: 4),
  //                   Text(
  //                     'Uploaded',
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       color: _successColor,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //           ],
  //         ),
  //         SizedBox(height: 12),
  //
  //         if (!isUploaded)
  //           Column(
  //             children: [
  //               Container(
  //                 padding: EdgeInsets.all(6),
  //                 decoration: BoxDecoration(
  //                   color: _primaryLight.withOpacity(0.2),
  //                   borderRadius: BorderRadius.circular(6),
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     // Icon(Icons.info, size: 16, color: _primaryColor),
  //                     // SizedBox(width: 8),
  //                     // Expanded(
  //                     //   // child: Text(
  //                     //   //   'Upload a clear scanned signature of the authorized person who signs this declaration.',
  //                     //   //   style: TextStyle(
  //                     //   //     fontSize: 12,
  //                     //   //     color: _textSecondary,
  //                     //   //   ),
  //                     //   // ),
  //                     // ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // SizedBox(
  //               //   width: double.infinity,
  //               //   child: ElevatedButton.icon(
  //               //     onPressed: () => _pickDocument('Signature of Authorized Person'),
  //               //     style: ElevatedButton.styleFrom(
  //               //       backgroundColor: _primaryColor,
  //               //       padding: EdgeInsets.symmetric(vertical: 14, horizontal: 7),
  //               //       shape: RoundedRectangleBorder(
  //               //         borderRadius: BorderRadius.circular(8),
  //               //       ),
  //               //     ),
  //               //     icon: Icon(Icons.upload, size: 18, color: Colors.white),
  //               //     label: Text(
  //               //       'Upload Signature',
  //               //       style: TextStyle(
  //               //         fontSize: 14,
  //               //         fontWeight: FontWeight.w500,
  //               //         color: Colors.white,
  //               //       ),
  //               //     ),
  //               //   ),
  //               // ),
  //             ],
  //           ),
  //
  //         // if (isUploaded && fileName.isNotEmpty)
  //         //   Container(
  //         //     padding: EdgeInsets.all(12),
  //         //     decoration: BoxDecoration(
  //         //       color: _primaryLight,
  //         //       borderRadius: BorderRadius.circular(8),
  //         //     ),
  //         //     child: Row(
  //         //       children: [
  //         //         Container(
  //         //           width: 50,
  //         //           height: 50,
  //         //           decoration: BoxDecoration(
  //         //             color: _primaryColor.withOpacity(0.1),
  //         //             borderRadius: BorderRadius.circular(6),
  //         //             border: Border.all(color: _primaryColor.withOpacity(0.3)),
  //         //           ),
  //         //           child: Center(
  //         //             child: Icon(
  //         //               Icons.note_alt_outlined,
  //         //               size: 24,
  //         //               color: _primaryColor,
  //         //             ),
  //         //           ),
  //         //         ),
  //         //         SizedBox(width: 12),
  //         //         Expanded(
  //         //           child: Column(
  //         //             crossAxisAlignment: CrossAxisAlignment.start,
  //         //             children: [
  //         //               Text(
  //         //                 fileName,
  //         //                 style: TextStyle(
  //         //                   fontWeight: FontWeight.w500,
  //         //                   fontSize: 13,
  //         //                   color: _textPrimary,
  //         //                 ),
  //         //                 overflow: TextOverflow.ellipsis,
  //         //                 maxLines: 1,
  //         //               ),
  //         //               SizedBox(height: 4),
  //         //               Text(
  //         //                 '${(fileSize / 1024).toStringAsFixed(1)} KB • Signature File',
  //         //                 style: TextStyle(
  //         //                   fontSize: 11,
  //         //                   color: _textSecondary,
  //         //                 ),
  //         //               ),
  //         //             ],
  //         //           ),
  //         //         ),
  //         //         SizedBox(width: 8),
  //         //         Row(
  //         //           children: [
  //         //             IconButton(
  //         //               onPressed: () => _viewDocument('Signature of Authorized Person'),
  //         //               icon: Icon(
  //         //                 Icons.remove_red_eye,
  //         //                 size: 20,
  //         //                 color: _primaryColor,
  //         //               ),
  //         //               tooltip: 'Preview Signature',
  //         //             ),
  //         //             IconButton(
  //         //               onPressed: () => _removeDocument('Signature of Authorized Person'),
  //         //               icon: Icon(Icons.delete, size: 20, color: Colors.red),
  //         //               tooltip: 'Remove Signature',
  //         //             ),
  //         //           ],
  //         //         ),
  //         //       ],
  //         //     ),
  //         //   ),
  //       ],
  //     ),
  //   );
  // }

  // Signature Upload in Declaration Section
  Widget _buildSignatureUploadItem() {
    final fileName = _signatureFile['name'] as String? ?? '';
    final isUploaded = (_signatureFile['uploaded'] as bool?) ?? false;
    final fileSize = (_signatureFile['size'] as int?) ?? 0;

    Future<void> _pickSignature() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
          allowMultiple: false,
        );

        if (result != null && result.files.isNotEmpty) {
          final file = result.files.first;

          if (file.size > 2 * 1024 * 1024) { // 2MB limit for signature
            _showErrorDialog(
              'File too large',
              'Please select a signature file smaller than 2MB',
            );
            return;
          }

          setState(() {
            _signatureFile['name'] = file.name;
            _signatureFile['size'] = file.size;
            _signatureFile['path'] = file.path ?? '';
            _signatureFile['uploaded'] = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signature uploaded successfully'),
              backgroundColor: _successColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        _showErrorDialog(
          'Upload Error',
          'Failed to upload signature: ${e.toString()}',
        );
      }
    }

    void _viewSignature() {
      if (fileName.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Signature'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('File: $fileName'),
                Text('Size: ${(fileSize / 1024).toStringAsFixed(1)} KB'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    }

    void _removeSignature() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Remove Signature'),
          content: Text('Are you sure you want to remove this signature?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _signatureFile['name'] = '';
                  _signatureFile['size'] = 0;
                  _signatureFile['path'] = '';
                  _signatureFile['uploaded'] = false;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Signature removed'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 20,
                    color: isUploaded ? _successColor : _primaryColor,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Digital Signature',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isUploaded ? _successColor : _textPrimary,
                        ),
                      ),
                      Text(
                        'PNG or JPG format',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 12),

          if (!isUploaded)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickSignature,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.upload, size: 18, color: Colors.white),
                label: Text(
                  'Upload Signature',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _successColor.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.note_alt_outlined,
                        size: 24,
                        color: _successColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB',
                          style: TextStyle(
                            fontSize: 11,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _viewSignature,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: _primaryColor,
                        ),
                        tooltip: 'Preview Signature',
                      ),
                      IconButton(
                        onPressed: _removeSignature,
                        icon: Icon(Icons.delete, size: 20, color: Colors.red),
                        tooltip: 'Remove Signature',
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


  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHotelTypeChip(String type) {
    bool isSelected = _selectedHotelType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHotelType = isSelected ? null : type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryColor : _borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRoomConfigurationCard(String roomType) {
    final details = _roomDetails[roomType]!;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: [
          Text(
            roomType,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSmallInput(
                  label: 'No. of Rooms',
                  controller: TextEditingController(text: details['rooms']),
                  onChanged: (value) => details['rooms'] = value,
                  hint: '0',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildSmallInput(
                  label: 'Max Occupancy',
                  controller: TextEditingController(text: details['occupancy']),
                  onChanged: (value) => details['occupancy'] = value,
                  hint: 'Persons',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AC / Non-AC',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        _buildToggleChip('AC', details['ac'], () {
                          setState(() => details['ac'] = true);
                        }),
                        SizedBox(width: 8),
                        _buildToggleChip('Non-AC', !details['ac'], () {
                          setState(() => details['ac'] = false);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              // REMOVED: Bed Type section
            ],
          ),
          SizedBox(height: 12),
          _buildSmallInput(
            label: 'Price per Night (₹)',
            controller: TextEditingController(text: details['price']),
            onChanged: (value) => details['price'] = value,
            hint: '0',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: _borderColor),
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryColor : _borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
    return Column(
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
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenities.entries.map((entry) {
            bool isSelected = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  amenities[entry.key] = !isSelected;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? _primaryColor : _borderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      size: 14,
                      color: isSelected ? _primaryColor : _textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? _primaryColor : _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadItem({
    required String documentName,
    required Map<String, dynamic> fileInfo,
    required VoidCallback onUploadPressed,
    required VoidCallback onViewPressed,
    required VoidCallback onRemovePressed,
    bool isOptional = false,
    bool isSignature = false, // New parameter for signature
  }) {
    final fileName = fileInfo['name'] as String? ?? '';
    final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isSignature ? Icons.note_alt_outlined : Icons.description,
                    size: 18,
                    color: _primaryColor,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        documentName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: isUploaded ? _successColor : _textPrimary,
                        ),
                      ),
                      if (isOptional)
                        Text(
                          'Optional',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 8),

          if (!isUploaded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSignature)
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _primaryLight.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _primaryColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, size: 14, color: _primaryColor),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Upload scanned signature of authorized person (PNG/JPG format)',
                            style: TextStyle(
                              fontSize: 11,
                              color: _textSecondary,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onUploadPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      isSignature ? 'Upload Signature' : 'Upload $documentName',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(
                        isSignature ? Icons.note_alt_outlined : Icons.insert_drive_file,
                        size: 20,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB',
                          style:
                          TextStyle(fontSize: 10, color: _textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onViewPressed,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: _primaryColor,
                        ),
                        padding: EdgeInsets.all(4),
                        tooltip: 'View',
                      ),
                      IconButton(
                        onPressed: onRemovePressed,
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        padding: EdgeInsets.all(4),
                        tooltip: 'Remove',
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

  // Navigation Methods
  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // // File Upload Methods
  // Future<void> _pickDocument(String documentType) async {
  //   // Implement file picking logic
  //   print('Picking document: $documentType');
  //
  //   // Simulating file upload
  //   setState(() {
  //     _uploadedFiles[documentType] = {
  //       'name': '${documentType.replaceAll(' ', '_')}_signed.pdf',
  //       'size': 2048,
  //       'path': '/temp/uploaded_file.pdf',
  //       'uploaded': true,
  //     };
  //   });
  // }
  //
  // void _viewDocument(String documentType) {
  //   // Implement document viewing
  //   print('Viewing document: $documentType');
  // }
  //
  // void _removeDocument(String documentType) {
  //   setState(() {
  //     _uploadedFiles[documentType] = {
  //       'name': '',
  //       'size': 0,
  //       'path': '',
  //       'uploaded': false,
  //     };
  //   });
  // }
// Add these methods to handle file uploads

  Future<void> _pickDocument(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Check file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog(
            'File too large',
            'Please select a file smaller than 5MB',
          );
          return;
        }

        setState(() {
          _uploadedFiles[documentType] = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
          };
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${file.name} uploaded successfully'),
            backgroundColor: _successColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(
        'Upload Error',
        'Failed to upload file: ${e.toString()}',
      );
    }
  }

  void _viewDocument(String documentType) {
    final fileInfo = _uploadedFiles[documentType]!;
    final fileName = fileInfo['name'] as String? ?? '';
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    if (fileName.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(
                _getDocumentIcon(documentType),
                color: _primaryColor,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(documentType, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(child: _getFileIcon(fileName)),
              ),
              SizedBox(height: 16),
              Text('File Details:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text('Name: $fileName'),
              Text('Size: ${(fileSize / 1024).toStringAsFixed(1)} KB'),
              Text('Type: ${_getFileExtension(fileName).toUpperCase()}'),
              if (documentType == 'FSSAI Certificate')
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Note: Required for hotels with restaurant facilities',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _removeDocument(String documentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Document'),
        content: Text('Are you sure you want to remove this document?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uploadedFiles[documentType] = {
                  'name': '',
                  'size': 0,
                  'path': '',
                  'uploaded': false,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document removed'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

// Helper methods for file icons
  Widget _getFileIcon(String fileName) {
    final ext = _getFileExtension(fileName).toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icon(Icons.image, size: 20, color: _primaryColor);
    } else if (['pdf'].contains(ext)) {
      return Icon(Icons.picture_as_pdf, size: 20, color: Colors.red);
    } else if (['doc', 'docx'].contains(ext)) {
      return Icon(Icons.description, size: 20, color: Colors.blue);
    } else {
      return Icon(Icons.insert_drive_file, size: 20, color: _primaryColor);
    }
  }

  String _getFileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }

  IconData _getDocumentIcon(String documentName) {
    if (documentName.contains('GST')) return Icons.receipt;
    if (documentName.contains('FSSAI')) return Icons.restaurant;
    if (documentName.contains('License')) return Icons.badge;
    if (documentName.contains('Cheque')) return Icons.account_balance;
    if (documentName.contains('Photos')) return Icons.photo_library;
    if (documentName.contains('Proof')) return Icons.perm_identity;
    if (documentName.contains('Signature')) return Icons.draw;
    return Icons.description;
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  // void _submitForm() {
  //   if (!_formKey.currentState!.validate()) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please fill all required fields correctly'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   if (!_declarationAccepted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please accept the declaration to proceed'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     return;
  //   }
  //
  //
  //
  //      final signatureInfo = _uploadedFiles['Signature of Authorized Person']!;
  //   final isSignatureUploaded = (signatureInfo['uploaded'] as bool?) ?? false;
  //
  //   if (!isSignatureUploaded) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please upload signature of authorized person'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //     return;
  //   }
  //
  //
  //   // Collect form data
  //   Map<String, dynamic> formData = {
  //     'hotelName': _hotelNameController.text,
  //     'hotelCategory': '2-Star',
  //     'hotelType': _selectedHotelType,
  //     'yearOfEstablishment': _yearController.text,
  //     'totalRooms': _roomsController.text,
  //     'ownerName': _ownerNameController.text,
  //     'designation': _designationController.text,
  //     'mobileNumber': _mobileController.text,
  //     'alternateContact': _altMobileController.text,
  //     'email': _emailController.text,
  //     'website': _websiteController.text,
  //     'addressLine1': _address1Controller.text,
  //     'addressLine2': _address2Controller.text,
  //     'city': _cityController.text,
  //     'district': _districtController.text,
  //     'state': _stateController.text,
  //     'pinCode': _pinController.text,
  //     'selectedRoomTypes': _selectedRoomTypes,
  //     'roomDetails': _roomDetails,
  //     'extraBedAvailable': _extraBedAvailable,
  //     'roomTariff': {
  //       'min': _minTariffController.text,
  //       'max': _maxTariffController.text,
  //     },
  //     'checkInTime': _checkInController.text,
  //     'checkOutTime': _checkOutController.text,
  //     'roomAmenities': _roomAmenities,
  //     'hotelFacilities': _hotelFacilities,
  //     'foodServices': _foodServices,
  //     'guestServices': _guestServices,
  //     'idProofRequired': _selectedIdProof,
  //     'coupleFriendly': _coupleFriendly,
  //     'petsAllowed': _petsAllowed,
  //     'gstNumber': _gstController.text,
  //     'tradeLicense': _tradeLicenseController.text,
  //     'fssaiLicense': _fssaiController.text,
  //     'panNumber': _panController.text,
  //     'bankDetails': {
  //       'accountHolderName': _accountNameController.text,
  //       'bankName': _bankNameController.text,
  //       'accountNumber': _accountNumberController.text,
  //       'ifscCode': _ifscController.text,
  //       'branch': _branchController.text,
  //     },
  //     'uploadedFiles': _uploadedFiles,
  //     'declarationDate': _selectedDate,
  //     'declarationAccepted': _declarationAccepted,
  //   };
  //
  //   // Navigate to summary or submit
  //   print('Form submitted: $formData');
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Registration submitted successfully!'),
  //       backgroundColor: _successColor,
  //     ),
  //   );
  //
  // }

  void _submitForm() {
    // Check if signature is uploaded
    if (!(_signatureFile['uploaded'] ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload Digital Signature'),
          backgroundColor: Colors.red,
        ),
      );

      // Navigate to last step where signature is
      setState(() => _currentStep = 4);
      return;
    }

    // Check if any required document is missing
    final requiredDocuments = [
      'GST Certificate',
      'Trade License',
      'Cancelled Cheque',
      'Hotel Registration Certificate',
      'Room & Property Photos',
    ];

    for (var doc in requiredDocuments) {
      final fileInfo = _uploadedFiles[doc];
      if (!(fileInfo?['uploaded'] ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please upload $doc'),
            backgroundColor: Colors.red,
          ),
        );

        // Navigate to documents step
        setState(() => _currentStep = 4);
        return;
      }
    }

    if (!_declarationAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the declaration to proceed'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Prepare form data - include signature file
    Map<String, dynamic> formData = {
      'hotelName': _hotelNameController.text,
      'hotelCategory': '2-Star',
      'hotelType': _selectedHotelType,
      'yearOfEstablishment': _yearController.text,
      'totalRooms': _roomsController.text,
      'ownerName': _ownerNameController.text,
      'designation': _designationController.text,
      'mobileNumber': _mobileController.text,
      'alternateContact': _altMobileController.text,
      'email': _emailController.text,
      'website': _websiteController.text,
      'addressLine1': _address1Controller.text,
      'addressLine2': _address2Controller.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'pinCode': _pinController.text,
      'selectedRoomTypes': _selectedRoomTypes,
      'roomDetails': _roomDetails,
      'extraBedAvailable': _extraBedAvailable,
      'minTariff': _minTariffController.text,
      'maxTariff': _maxTariffController.text,
      'checkInTime': _checkInController.text, // FIXED: Changed to _checkInController
      'checkOutTime': _checkOutController.text, // FIXED: Changed to _checkOutController
      'roomAmenities': Map<String, bool>.from(_roomAmenities),
      'hotelFacilities': Map<String, bool>.from(_hotelFacilities),
      'foodServices': Map<String, bool>.from(_foodServices),
      'guestServices': Map<String, bool>.from(_guestServices),
      'idProofRequired': _selectedIdProof,
      'coupleFriendly': _coupleFriendly,
      'petsAllowed': _petsAllowed,
      'gstNumber': _gstController.text,
      'tradeLicense': _tradeLicenseController.text,
      'fssaiLicense': _fssaiController.text,
      'panNumber': _panController.text,
      'accountHolderName': _accountNameController.text,
      'bankName': _bankNameController.text,
      'accountNumber': _accountNumberController.text,
      'ifscCode': _ifscController.text,
      'branch': _branchController.text,
      'uploadedFiles': _uploadedFiles,
      'signatureFile': _signatureFile, // Add signature file
      'declarationDate': _selectedDate,
      'declarationAccepted': _declarationAccepted,
    };

    // Navigate to summary screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationSummaryScreen(
          registrationData: formData,
          hotelCategory: '2-Star',
          declarationAccepted: _declarationAccepted,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    _hotelNameController.dispose();
    _yearController.dispose();
    _roomsController.dispose();
    _ownerNameController.dispose();
    _designationController.dispose();
    _mobileController.dispose();
    // _checkInTimeController.dispose(); // Use new name
    // _checkOutTimeController.dispose();
    _altMobileController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _minTariffController.dispose();
    _maxTariffController.dispose();
    _gstController.dispose();
    _tradeLicenseController.dispose();
    _fssaiController.dispose();
    _panController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    _declarationNameController.dispose();
    super.dispose();
  }
}


class ThreeStarHotelRegistrationScreen extends StatefulWidget {
  const ThreeStarHotelRegistrationScreen({super.key});

  @override
  State<ThreeStarHotelRegistrationScreen> createState() =>
      _ThreeStarHotelRegistrationScreenState();
}

class _ThreeStarHotelRegistrationScreenState extends State<ThreeStarHotelRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final Color _primaryColor = Color(0xFFDAA520); // Golden color for 3-star
  final Color _primaryLight = Color(0xFFFFF8E1);
  final Color _bgColor = Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _textPrimary = Color(0xFF111827);
  final Color _textSecondary = Color(0xFF6B7280);
  final Color _successColor = Color(0xFFFFB74D);

  // Controllers
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _altMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController(text: '14:00');
  final TextEditingController _checkOutController = TextEditingController(text: '12:00');
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _tradeLicenseController = TextEditingController();
  final TextEditingController _fssaiController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _signatoryNameController = TextEditingController();

  // Room Details
  final Map<String, Map<String, dynamic>> _roomDetails = {
    'Standard': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'bedType': 'Queen',
      'price': '',
    },
    'Deluxe': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'bedType': 'King',
      'price': '',
    },
    'Suite': {
      'rooms': '',
      'occupancy': '',
      'ac': true,
      'bedType': 'King',
      'price': '',
    },
  };

  // Selected Room Types
  Map<String, bool> _selectedRoomTypes = {
    'Standard': true, // Default selected for 3-star
    'Deluxe': false,
    'Suite': false,
  };

  // Hotel Type Selection
  String? _selectedHotelType;

  // Policies
  bool _extraBedAvailable = false;
  bool _seasonalPricing = false;
  bool _earlyCheckinAllowed = false;
  bool _earlyCheckinChargeable = true;
  bool _coupleFriendly = true;
  bool _petsAllowed = false;
  bool _fireSafetyCertificate = false;
  //
  // // Amenities Categories
  // Map<String, bool> _roomAmenities = {
  //   'Air Conditioning': true,
  //   'Free High-Speed Wi-Fi': true,
  //   'LED TV (Cable/DTH)': true,
  //   'Work Desk & Chair': true,
  //   'Wardrobe / Closet': true,
  //   'Tea / Coffee Maker': true,
  //   'Mini Refrigerator': true,
  //   'Electronic Safe': true,
  //   'Attached Bathroom with Toiletries': true,
  //   'Hot & Cold Water': true,
  // };
  //
  // Map<String, bool> _hotelFacilities = {
  //   '24-Hour Front Desk': true,
  //   'Lift / Elevator': true,
  //   'Power Backup': true,
  //   'Daily Housekeeping': true,
  //   'Luggage Storage': true,
  //   'CCTV Surveillance': true,
  //   'Fire Safety System': true,
  //   'Disabled-Friendly Access': true,
  // };
  //
  // Map<String, bool> _foodServices = {
  //   'Multi-Cuisine Restaurant': false,
  //   'Complimentary Breakfast': true,
  //   'In-Room Dining': true,
  //   'Bar / Lounge': false,
  //   'Banquet / Event Hall': false,
  // };
  //
  // Map<String, bool> _businessServices = {
  //   'Conference / Meeting Room': false,
  //   'Business Center': true,
  //   'Laundry / Dry Cleaning': true,
  //   'Travel Desk / Taxi Service': true,
  //   'Doctor on Call': true,
  //   'Wake-Up Call': true,
  //   'Concierge Service': true,
  // };

  // Correct the amenities initialization - change from true to false

// Room Amenities - CHANGED: All from true to false
  Map<String, bool> _roomAmenities = {
    'Air Conditioning': false,
    'Free High-Speed Wi-Fi': false,
    'LED TV (Cable/DTH)': false,
    'Work Desk & Chair': false,
    'Wardrobe / Closet': false,
    'Tea / Coffee Maker': false,
    'Mini Refrigerator': false,
    'Electronic Safe': false,
    'Attached Bathroom with Toiletries': false,
    'Hot & Cold Water': false,
  };

// Hotel Facilities - CHANGED: All from true to false
  Map<String, bool> _hotelFacilities = {
    '24-Hour Front Desk': false,
    'Lift / Elevator': false,
    'Power Backup': false,
    'Daily Housekeeping': false,
    'Luggage Storage': false,
    'CCTV Surveillance': false,
    'Fire Safety System': false,
    'Disabled-Friendly Access': false,
  };

// Food Services - CHANGED: All from true/false to false
  Map<String, bool> _foodServices = {
    'Multi-Cuisine Restaurant': false,
    'Complimentary Breakfast': false,
    'In-Room Dining': false,
    'Bar / Lounge': false,
    'Banquet / Event Hall': false,
  };

// Business Services - CHANGED: All from true to false
  Map<String, bool> _businessServices = {
    'Conference / Meeting Room': false,
    'Business Center': false,
    'Laundry / Dry Cleaning': false,
    'Travel Desk / Taxi Service': false,
    'Doctor on Call': false,
    'Wake-Up Call': false,
    'Concierge Service': false,
  };

  // Bed Type Options
  final List<String> _bedTypes = ['Single', 'Double', 'Queen', 'King', 'Twin'];

  // Document Uploads
  final Map<String, Map<String, dynamic>> _uploadedFiles = {
    'GST Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'PAN Card': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Trade License': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'FSSAI Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Fire Safety Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Cancelled Cheque': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Hotel & Room Photos': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
  };

  // Signature
  final Map<String, dynamic> _signatureFile = {
    'name': '',
    'size': 0,
    'path': '',
    'uploaded': false,
  };

  // Declaration
  bool _declarationAccepted = false;
  DateTime? _selectedDate;

  // Steps
  final List<Map<String, dynamic>> _steps = [
    {'title': 'Hotel Info', 'subtitle': 'Basic hotel details'},
    {'title': 'Contact & Address', 'subtitle': 'Contact and location'},
    {'title': 'Room Configuration', 'subtitle': 'Room types and rates'},
    {'title': 'Amenities & Policies', 'subtitle': 'Facilities and rules'},
    {'title': 'Legal & Documents', 'subtitle': 'Compliance and files'},
  ];

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
          '3-Star Hotel Vendor Registration Form',
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress Steps
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_steps.length, (index) {
                        bool isActive = index == _currentStep;
                        bool isCompleted = index < _currentStep;

                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () {
                              if (index <= _currentStep) {
                                setState(() {
                                  _currentStep = index;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive
                                        ? _primaryColor
                                        : isCompleted
                                        ? _successColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: isActive || isCompleted
                                          ? Colors.transparent
                                          : _borderColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? Icon(
                                      Icons.check,
                                      size: 18,
                                      color: Colors.white,
                                    )
                                        : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive || isCompleted
                                            ? Colors.white
                                            : _textSecondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    _steps[index]['title'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: isActive || isCompleted
                                          ? _textPrimary
                                          : _textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / _steps.length,
                    backgroundColor: _borderColor,
                    color: _primaryColor,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStep + 1} of ${_steps.length}',
                        style: TextStyle(fontSize: 12, color: _textSecondary),
                      ),
                      Text(
                        '${((_currentStep + 1) / _steps.length * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Header
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${_currentStep + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _steps[_currentStep]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _steps[_currentStep]['subtitle'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.white),
                                Icon(Icons.star, size: 14, color: Colors.white),
                                Icon(Icons.star, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  '3-Star',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Step Content
                    _buildStepContent(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentStep == _steps.length - 1
                              ? 'Submit Registration'
                              : 'Continue',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1(); // Hotel Information
      case 1:
        return _buildStep2(); // Contact & Address
      case 2:
        return _buildStep3(); // Room Configuration
      case 3:
        return _buildStep4(); // Amenities & Policies
      case 4:
        return _buildStep5(); // Legal & Documents
      default:
        return Container();
    }
  }

  // Step 1: Hotel Information
  Widget _buildStep1() {
    return Column(
      children: [
        _buildCard(
          title: '1. Hotel Information',
          children: [
            _buildInputField(
              label: 'Hotel Name *',
              controller: _hotelNameController,
              hint: 'Enter hotel name',
            ),
            SizedBox(height: 16),

            // Hotel Category (Fixed as 3-Star)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.white),
                          Icon(Icons.star, size: 12, color: Colors.white),
                          Icon(Icons.star, size: 12, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hotel Category',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _textSecondary,
                          ),
                        ),
                        Text(
                          '3-Star Hotel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Hotel Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Type *',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Business', 'Family', 'Tourist', 'Boutique']
                      .map((type) => _buildHotelTypeChip(type))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Year of Establishment',
                    controller: _yearController,
                    hint: 'YYYY',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Total Number of Rooms',
                    controller: _roomsController,
                    hint: '0',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // _buildInputField(
            //   label: 'Total Number of Rooms',
            //   controller: _roomsController,
            //   hint: '0',
            //   keyboardType: TextInputType.number,
            // ),
          ],
        ),
      ],
    );
  }

  // Step 2: Contact & Address
  Widget _buildStep2() {
    return Column(
      children: [
        _buildCard(
          title: '2. Contact Details',
          children: [
            _buildInputField(
              label: 'Owner / Authorized Person Name *',
              controller: _ownerNameController,
              hint: 'Enter full name',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Designation',
              controller: _designationController,
              hint: 'e.g., Owner, Manager, Director',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Mobile Number *',
              controller: _mobileController,
              hint: 'Enter 10-digit mobile number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Alternate Contact Number',
              controller: _altMobileController,
              hint: 'Optional',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Email ID',
              controller: _emailController,
              hint: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Website / Booking Link',
              controller: _websiteController,
              hint: 'https://example.com',
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '3. Hotel Address',
          children: [
            _buildInputField(
              label: 'Address Line 1 *',
              controller: _address1Controller,
              hint: 'Street address',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Address Line 2',
              controller: _address2Controller,
              hint: 'Apartment, suite, etc.',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'City *',
                    controller: _cityController,
                    hint: 'Enter city',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'District *',
                    controller: _districtController,
                    hint: 'Enter district',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'State *',
                    controller: _stateController,
                    hint: 'Enter state',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'PIN Code *',
                    controller: _pinController,
                    hint: '6-digit PIN',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 3: Room Configuration
  Widget _buildStep3() {
    return Column(
      children: [
        _buildCard(
          title: '4. Room Inventory & Tariff',
          children: [
            // Room Type Selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Room Types Available:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedRoomTypes.entries.map((entry) {
                    bool isSelected = entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRoomTypes[entry.key] = !isSelected;
                        });
                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? _primaryLight : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? _primaryColor : _borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 16,
                              color: isSelected ? _primaryColor : _textSecondary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                isSelected ? _primaryColor : _textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Room Configuration Table
            if (_selectedRoomTypes.entries.any((entry) => entry.value))
              Column(
                children: [
                  Text(
                    'Configure selected room types:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                  SizedBox(height: 16),
                  ..._selectedRoomTypes.entries
                      .where((entry) => entry.value)
                      .map((entry) {
                    String roomType = entry.key;
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: _buildRoomConfigurationCard(roomType),
                    );
                  }).toList(),
                ],
              ),

            SizedBox(height: 20),
            Divider(color: _borderColor),
            SizedBox(height: 20),

            // Extra Bed & Seasonal Pricing
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Extra Bed Available:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _extraBedAvailable, () {
                            setState(() => _extraBedAvailable = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_extraBedAvailable, () {
                            setState(() => _extraBedAvailable = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seasonal Pricing:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _seasonalPricing, () {
                            setState(() => _seasonalPricing = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_seasonalPricing, () {
                            setState(() => _seasonalPricing = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 4: Amenities & Policies
  Widget _buildStep4() {
    return Column(
      children: [
        _buildCard(
          title: '5. Amenities Available',
          children: [
            // Room Amenities
            _buildAmenitiesSection('Room Amenities', _roomAmenities),
            SizedBox(height: 20),

            // Hotel Facilities
            _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
            SizedBox(height: 20),

            // Food & Beverage
            _buildAmenitiesSection('Food & Beverage', _foodServices),
            SizedBox(height: 20),

            // Business & Guest Services
            _buildAmenitiesSection('Business & Guest Services', _businessServices),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '6. Check-in Policies',
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Standard Check-in Time',
                    controller: _checkInController,
                    hint: 'HH:MM',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Standard Check-out Time',
                    controller: _checkOutController,
                    hint: 'HH:MM',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Early Check-in Policies
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Early Check-in / Late Check-out:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildToggleChip('Allowed', _earlyCheckinAllowed, () {
                              setState(() => _earlyCheckinAllowed = true);
                            }),
                            SizedBox(width: 8),
                            _buildToggleChip('Not Allowed', !_earlyCheckinAllowed,
                                    () {
                                  setState(() {
                                    _earlyCheckinAllowed = false;
                                    _earlyCheckinChargeable = false;
                                  });
                                }),
                          ],
                        ),
                        SizedBox(height: 8),
                        if (_earlyCheckinAllowed)
                          Row(
                            children: [
                              _buildToggleChip(
                                  'Chargeable', _earlyCheckinChargeable, () {
                                setState(() => _earlyCheckinChargeable = true);
                              }),
                              SizedBox(width: 8),
                              _buildToggleChip(
                                  'Free', !_earlyCheckinChargeable, () {
                                setState(() => _earlyCheckinChargeable = false);
                              }),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Couple & Pets Policies
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Couple Friendly:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _coupleFriendly, () {
                            setState(() => _coupleFriendly = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_coupleFriendly, () {
                            setState(() => _coupleFriendly = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pets Allowed:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildToggleChip('Yes', _petsAllowed, () {
                            setState(() => _petsAllowed = true);
                          }),
                          SizedBox(width: 8),
                          _buildToggleChip('No', !_petsAllowed, () {
                            setState(() => _petsAllowed = false);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Step 5: Legal & Documents
  Widget _buildStep5() {
    return Column(
      children: [
        _buildCard(
          title: '7. Legal & Compliance Details',
          children: [
            _buildInputField(
              label: 'GST Number *',
              controller: _gstController,
              hint: 'Enter GST number',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'PAN Number *',
              controller: _panController,
              hint: 'Enter PAN number',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Trade License Number',
                    controller: _tradeLicenseController,
                    hint: 'Enter license number',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'FSSAI License',
                    controller: _fssaiController,
                    hint: 'If restaurant',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fire Safety Certificate:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildToggleChip('Yes', _fireSafetyCertificate, () {
                      setState(() => _fireSafetyCertificate = true);
                    }),
                    SizedBox(width: 12),
                    _buildToggleChip('No', !_fireSafetyCertificate, () {
                      setState(() => _fireSafetyCertificate = false);
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '8. Bank Details (Payment Settlement)',
          children: [
            _buildInputField(
              label: 'Account Holder Name *',
              controller: _accountNameController,
              hint: 'Enter name as per bank',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Bank Name *',
              controller: _bankNameController,
              hint: 'Enter bank name',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Account Number *',
                    controller: _accountNumberController,
                    hint: 'Enter account number',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'IFSC Code *',
                    controller: _ifscController,
                    hint: 'Enter IFSC code',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Branch',
              controller: _branchController,
              hint: 'Enter branch name',
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '9. Documents Required',
          children: [
            Text(
              'Please upload clear scanned copies of the following documents:',
              style: TextStyle(fontSize: 12, color: _textSecondary),
            ),
            SizedBox(height: 16),

            // GST Certificate
            _buildDocumentUploadItem(
              documentName: 'GST Certificate',
              fileInfo: _uploadedFiles['GST Certificate']!,
              onUploadPressed: () => _pickDocument('GST Certificate'),
              onViewPressed: () => _viewDocument('GST Certificate'),
              onRemovePressed: () => _removeDocument('GST Certificate'),
              isOptional: false,
            ),

            // PAN Card
            _buildDocumentUploadItem(
              documentName: 'PAN Card',
              fileInfo: _uploadedFiles['PAN Card']!,
              onUploadPressed: () => _pickDocument('PAN Card'),
              onViewPressed: () => _viewDocument('PAN Card'),
              onRemovePressed: () => _removeDocument('PAN Card'),
              isOptional: false,
            ),

            // Trade License
            _buildDocumentUploadItem(
              documentName: 'Trade License',
              fileInfo: _uploadedFiles['Trade License']!,
              onUploadPressed: () => _pickDocument('Trade License'),
              onViewPressed: () => _viewDocument('Trade License'),
              onRemovePressed: () => _removeDocument('Trade License'),
              isOptional: false,
            ),

            // FSSAI Certificate
            _buildDocumentUploadItem(
              documentName: 'FSSAI Certificate',
              fileInfo: _uploadedFiles['FSSAI Certificate']!,
              onUploadPressed: () => _pickDocument('FSSAI Certificate'),
              onViewPressed: () => _viewDocument('FSSAI Certificate'),
              onRemovePressed: () => _removeDocument('FSSAI Certificate'),
              isOptional: true,
            ),

            // Fire Safety Certificate
            _buildDocumentUploadItem(
              documentName: 'Fire Safety Certificate',
              fileInfo: _uploadedFiles['Fire Safety Certificate']!,
              onUploadPressed: () => _pickDocument('Fire Safety Certificate'),
              onViewPressed: () => _viewDocument('Fire Safety Certificate'),
              onRemovePressed: () => _removeDocument('Fire Safety Certificate'),
              isOptional: false,
              optionalText: 'Required if available',
            ),

            // Cancelled Cheque
            _buildDocumentUploadItem(
              documentName: 'Cancelled Cheque',
              fileInfo: _uploadedFiles['Cancelled Cheque']!,
              onUploadPressed: () => _pickDocument('Cancelled Cheque'),
              onViewPressed: () => _viewDocument('Cancelled Cheque'),
              onRemovePressed: () => _removeDocument('Cancelled Cheque'),
              isOptional: false,
            ),

            // Hotel & Room Photos
            _buildDocumentUploadItem(
              documentName: 'Hotel & Room Photos',
              fileInfo: _uploadedFiles['Hotel & Room Photos']!,
              onUploadPressed: () => _pickDocument('Hotel & Room Photos'),
              onViewPressed: () => _viewDocument('Hotel & Room Photos'),
              onRemovePressed: () => _removeDocument('Hotel & Room Photos'),
              isOptional: false,
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCard(
          title: '10. Declaration',
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _declarationAccepted
                    ? _successColor.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _declarationAccepted ? _successColor : _borderColor,
                  width: _declarationAccepted ? 1.5 : 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _declarationAccepted,
                    onChanged: (value) {
                      setState(() {
                        _declarationAccepted = value ?? false;
                      });
                    },
                    activeColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'I hereby declare that the above information is true and correct. I agree to comply with all vendor terms, service standards, and policies.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0C4A6E),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Signature Upload
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signature & Hotel Seal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 8),
                _buildSignatureUploadItem(),
              ],
            ),
            SizedBox(height: 16),

            // Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date *',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: _borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select date',
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedDate != null
                                ? _textPrimary
                                : _textSecondary,
                          ),
                        ),
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: _textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Helper Widgets

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _textPrimary,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: _primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHotelTypeChip(String type) {
    bool isSelected = _selectedHotelType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHotelType = isSelected ? null : type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryColor : _borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRoomConfigurationCard(String roomType) {
    final details = _roomDetails[roomType]!;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: [
          Text(
            roomType,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSmallInput(
                  label: 'No. of Rooms',
                  controller: TextEditingController(text: details['rooms']),
                  onChanged: (value) => details['rooms'] = value,
                  hint: '0',
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildSmallInput(
                  label: 'Max Occupancy',
                  controller: TextEditingController(text: details['occupancy']),
                  onChanged: (value) => details['occupancy'] = value,
                  hint: 'Persons',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AC',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        _buildToggleChip('Yes', details['ac'], () {
                          setState(() => details['ac'] = true);
                        }),
                        SizedBox(width: 8),
                        _buildToggleChip('No', !details['ac'], () {
                          setState(() => details['ac'] = false);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed Type',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: _borderColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: details['bedType'],
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, size: 20),
                          items: _bedTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              details['bedType'] = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildSmallInput(
            label: 'Average Tariff (₹)',
            controller: TextEditingController(text: details['price']),
            onChanged: (value) => details['price'] = value,
            hint: '0',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInput({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _textPrimary,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: _borderColor),
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _primaryColor : _borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? _primaryColor : _textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
    return Column(
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
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: amenities.entries.map((entry) {
            bool isSelected = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  amenities[entry.key] = !isSelected;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? _primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? _primaryColor : _borderColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      size: 14,
                      color: isSelected ? _primaryColor : _textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? _primaryColor : _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadItem({
    required String documentName,
    required Map<String, dynamic> fileInfo,
    required VoidCallback onUploadPressed,
    required VoidCallback onViewPressed,
    required VoidCallback onRemovePressed,
    bool isOptional = false,
    String? optionalText,
  }) {
    final fileName = fileInfo['name'] as String? ?? '';
    final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    _getDocumentIcon(documentName),
                    size: 18,
                    color: isUploaded ? _successColor : _primaryColor,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        documentName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: isUploaded ? _successColor : _textPrimary,
                        ),
                      ),
                      if (isOptional && optionalText != null)
                        Text(
                          optionalText,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 8),

          if (!isUploaded)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onUploadPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Upload $documentName',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: _getFileIcon(fileName),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB • ${_getFileExtension(fileName).toUpperCase()}',
                          style: TextStyle(fontSize: 10, color: _textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onViewPressed,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: _primaryColor,
                        ),
                        padding: EdgeInsets.all(4),
                        tooltip: 'View',
                      ),
                      IconButton(
                        onPressed: onRemovePressed,
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        padding: EdgeInsets.all(4),
                        tooltip: 'Remove',
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

  Widget _buildSignatureUploadItem() {
    final fileName = _signatureFile['name'] as String? ?? '';
    final isUploaded = (_signatureFile['uploaded'] as bool?) ?? false;
    final fileSize = (_signatureFile['size'] as int?) ?? 0;

    Future<void> _pickSignature() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
          allowMultiple: false,
        );

        if (result != null && result.files.isNotEmpty) {
          final file = result.files.first;

          if (file.size > 2 * 1024 * 1024) {
            _showErrorDialog(
              'File too large',
              'Please select a signature file smaller than 2MB',
            );
            return;
          }

          setState(() {
            _signatureFile['name'] = file.name;
            _signatureFile['size'] = file.size;
            _signatureFile['path'] = file.path ?? '';
            _signatureFile['uploaded'] = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signature uploaded successfully'),
              backgroundColor: _successColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        _showErrorDialog(
          'Upload Error',
          'Failed to upload signature: ${e.toString()}',
        );
      }
    }

    void _viewSignature() {
      if (fileName.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Signature'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Text(
                      'Signature Preview',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('File: $fileName'),
                Text('Size: ${(fileSize / 1024).toStringAsFixed(1)} KB'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    }

    void _removeSignature() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Remove Signature'),
          content: Text('Are you sure you want to remove this signature?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _signatureFile['name'] = '';
                  _signatureFile['size'] = 0;
                  _signatureFile['path'] = '';
                  _signatureFile['uploaded'] = false;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Signature removed'),
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUploaded ? _successColor : _borderColor,
          width: isUploaded ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 20,
                    color: isUploaded ? _successColor : _primaryColor,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Digital Signature',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isUploaded ? _successColor : _textPrimary,
                        ),
                      ),
                      Text(
                        'PNG or JPG format',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isUploaded)
                Row(
                  children: [
                    Icon(Icons.check_circle, color: _successColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Uploaded',
                      style: TextStyle(
                        fontSize: 11,
                        color: _successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 12),

          if (!isUploaded)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickSignature,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.upload, size: 18, color: Colors.white),
                label: Text(
                  'Upload Signature',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          if (isUploaded && fileName.isNotEmpty)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _successColor.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.note_alt_outlined,
                        size: 24,
                        color: _successColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB',
                          style: TextStyle(
                            fontSize: 11,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _viewSignature,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: _primaryColor,
                        ),
                        tooltip: 'Preview Signature',
                      ),
                      IconButton(
                        onPressed: _removeSignature,
                        icon: Icon(Icons.delete, size: 20, color: Colors.red),
                        tooltip: 'Remove Signature',
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

  // File Helper Methods
  Widget _getFileIcon(String fileName) {
    final ext = _getFileExtension(fileName).toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icon(Icons.image, size: 20, color: _primaryColor);
    } else if (['pdf'].contains(ext)) {
      return Icon(Icons.picture_as_pdf, size: 20, color: Colors.red);
    } else if (['doc', 'docx'].contains(ext)) {
      return Icon(Icons.description, size: 20, color: Colors.blue);
    } else {
      return Icon(Icons.insert_drive_file, size: 20, color: _primaryColor);
    }
  }

  String _getFileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
  }

  IconData _getDocumentIcon(String documentName) {
    if (documentName.contains('GST')) return Icons.receipt;
    if (documentName.contains('PAN')) return Icons.credit_card;
    if (documentName.contains('License')) return Icons.badge;
    if (documentName.contains('FSSAI')) return Icons.restaurant;
    if (documentName.contains('Fire')) return Icons.fire_extinguisher;
    if (documentName.contains('Cheque')) return Icons.account_balance;
    if (documentName.contains('Photos')) return Icons.photo_library;
    return Icons.description;
  }

  // File Upload Methods
  Future<void> _pickDocument(String documentType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog(
            'File too large',
            'Please select a file smaller than 5MB',
          );
          return;
        }

        setState(() {
          _uploadedFiles[documentType] = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
          };
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${file.name} uploaded successfully'),
            backgroundColor: _successColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(
        'Upload Error',
        'Failed to upload file: ${e.toString()}',
      );
    }
  }

  void _viewDocument(String documentType) {
    final fileInfo = _uploadedFiles[documentType]!;
    final fileName = fileInfo['name'] as String? ?? '';
    final fileSize = (fileInfo['size'] as int?) ?? 0;

    if (fileName.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(
                _getDocumentIcon(documentType),
                color: _primaryColor,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(documentType, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(child: _getFileIcon(fileName)),
              ),
              SizedBox(height: 16),
              Text('File Details:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text('Name: $fileName'),
              Text('Size: ${(fileSize / 1024).toStringAsFixed(1)} KB'),
              Text('Type: ${_getFileExtension(fileName).toUpperCase()}'),
              if (documentType == 'FSSAI Certificate')
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Required for hotels with restaurant facilities',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _removeDocument(String documentType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Document'),
        content: Text('Are you sure you want to remove this document?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uploadedFiles[documentType] = {
                  'name': '',
                  'size': 0,
                  'path': '',
                  'uploaded': false,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document removed'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Navigation Methods
  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Form Submission
  void _submitForm() {
    // Check required fields
    if (_hotelNameController.text.isEmpty ||
        _ownerNameController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _address1Controller.text.isEmpty ||
        _cityController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _pinController.text.isEmpty ||
        _gstController.text.isEmpty ||
        _panController.text.isEmpty ||
        _accountNameController.text.isEmpty ||
        _bankNameController.text.isEmpty ||
        _accountNumberController.text.isEmpty ||
        _ifscController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields marked with *'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_declarationAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the declaration to proceed'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!(_signatureFile['uploaded'] ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload Digital Signature'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _currentStep = 4);
      return;
    }

    // Check required documents
    final requiredDocs = [
      'GST Certificate',
      'PAN Card',
      'Trade License',
      'Cancelled Cheque',
      'Hotel & Room Photos',
    ];

    for (var doc in requiredDocs) {
      if (!(_uploadedFiles[doc]?['uploaded'] ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please upload $doc'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _currentStep = 4);
        return;
      }
    }

    // Prepare form data
    Map<String, dynamic> formData = {
      'hotelName': _hotelNameController.text,
      'hotelCategory': '3-Star',
      'hotelType': _selectedHotelType,
      'yearOfEstablishment': _yearController.text,
      'registrationNumber': _registrationNumberController.text,
      'totalRooms': _roomsController.text,
      'ownerName': _ownerNameController.text,
      'designation': _designationController.text,
      'mobileNumber': _mobileController.text,
      'alternateContact': _altMobileController.text,
      'email': _emailController.text,
      'website': _websiteController.text,
      'addressLine1': _address1Controller.text,
      'addressLine2': _address2Controller.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'pinCode': _pinController.text,
      'selectedRoomTypes': Map<String, bool>.from(_selectedRoomTypes),
      'roomDetails': Map<String, Map<String, dynamic>>.from(_roomDetails),
      'extraBedAvailable': _extraBedAvailable,
      'seasonalPricing': _seasonalPricing,
      'checkInTime': _checkInController.text,
      'checkOutTime': _checkOutController.text,
      'earlyCheckinAllowed': _earlyCheckinAllowed,
      'earlyCheckinChargeable': _earlyCheckinChargeable,
      'coupleFriendly': _coupleFriendly,
      'petsAllowed': _petsAllowed,
      'roomAmenities': Map<String, bool>.from(_roomAmenities),
      'hotelFacilities': Map<String, bool>.from(_hotelFacilities),
      'foodServices': Map<String, bool>.from(_foodServices),
      'businessServices': Map<String, bool>.from(_businessServices),
      'gstNumber': _gstController.text,
      'panNumber': _panController.text,
      'tradeLicense': _tradeLicenseController.text,
      'fssaiLicense': _fssaiController.text,
      'fireSafetyCertificate': _fireSafetyCertificate,
      'accountHolderName': _accountNameController.text,
      'bankName': _bankNameController.text,
      'accountNumber': _accountNumberController.text,
      'ifscCode': _ifscController.text,
      'branch': _branchController.text,
      'uploadedFiles': _uploadedFiles,
      'signatureFile': _signatureFile,
      'signatoryName': _signatoryNameController.text,
      'declarationDate': _selectedDate,
      'declarationAccepted': _declarationAccepted,
    };

    // Navigate to summary screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationSummaryScreen(
          registrationData: formData,
          hotelCategory: '3-Star',
          declarationAccepted: _declarationAccepted,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    _hotelNameController.dispose();
    _yearController.dispose();
    _registrationNumberController.dispose();
    _roomsController.dispose();
    _ownerNameController.dispose();
    _designationController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _gstController.dispose();
    _panController.dispose();
    _tradeLicenseController.dispose();
    _fssaiController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    _signatoryNameController.dispose();
    super.dispose();
  }
}