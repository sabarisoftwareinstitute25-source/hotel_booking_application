import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
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
import 'package:shared_preferences/shared_preferences.dart';


class HotelRegistrationScreen extends StatefulWidget {
  const HotelRegistrationScreen({super.key});

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
              label: 'Hotel Name *',
              controller: _hotelNameController,
              hint: 'Enter hotel name',
            ),
            SizedBox(height: 16),
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
                    'Lodge',
                    'Budget Hotel',
                    'Standard Hotel',
                    'Guest House',
                    'Heritage Hotel',
                    'Boutique Hotel',
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
              label: 'Owner / Manager Name *',
              controller: _ownerNameController,
              hint: 'Enter name',
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Mobile Number *',
              controller: _mobileController,
              hint: 'Enter mobile number',
              keyboardType: TextInputType.phone,
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
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: 'Website (if any)',
              controller: _websiteController,
              hint: 'https://example.com',
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
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'FSSAI License No.',
                    controller: _fssaiController,
                    hint: 'If restaurant',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Trade License No.',
                    controller: _tradeLicenseController,
                    hint: 'Enter license number',
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildInputField(
              label: 'Aadhar Number (Owner)',
              controller: _aadharController,
              hint: 'Enter Aadhar number',
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
            SizedBox(height: 16),
            _buildInputField(
              label: 'Account Type',
              controller: _accountTypeController,
              hint: 'Savings / Current',
            ),
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
        type: FileType.image,
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

        setState(() {
          _personPhotoInfo = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
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

        setState(() {
          _uploadedFiles[documentType] = {
            'name': file.name,
            'size': file.size,
            'path': file.path ?? '',
            'uploaded': true,
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

    if (fileName.isNotEmpty) {
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
              if (documentType.contains('Signature'))
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

  void _submitForm() {
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

    Map<String, dynamic> formData = {
      'hotelName': _hotelNameController.text,
      'hotelType': _selectedHotelType,
      'yearOfEstablishment': _yearController.text,
      'totalRooms': _roomsController.text,
      'ownerName': _ownerNameController.text,
      'mobileNumber': _mobileController.text,
      'alternateContact': _altMobileController.text,
      'landlineNumbers': _landlineControllers
          .map((c) => c.text)
          .where((text) => text.isNotEmpty)
          .toList(),
      'email': _emailController.text,
      'website': _websiteController.text,
      'addressLine1': _address1Controller.text,
      'addressLine2': _address2Controller.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'pinCode': _pinController.text,
      'landmark': _landmarkController.text,
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
      'panNumber': _panController.text,
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


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationSummaryScreen(
          formData: formData,
          hotelName: _hotelNameController.text,
          hotelType: _selectedHotelType,
          yearOfEstablishment: _yearController.text,
          totalRooms: _roomsController.text,
          ownerName: _ownerNameController.text,
          mobileNumber: _mobileController.text,
          alternateContact: _altMobileController.text,
          landlineNumbers: _landlineControllers
              .map((c) => c.text)
              .where((text) => text.isNotEmpty)
              .toList(),
          email: _emailController.text,
          website: _websiteController.text,
          addressLine1: _address1Controller.text,
          addressLine2: _address2Controller.text,
          city: _cityController.text,
          district: _districtController.text,
          state: _stateController.text,
          pinCode: _pinController.text,
          landmark: _landmarkController.text,
          selectedRoomTypes: _selectedRoomTypes,
          roomDetails: _roomDetails,
          minTariff: _minTariffController.text,
          maxTariff: _maxTariffController.text,
          extraBedAvailable: _extraBedAvailable,
          basicAmenities: _basicAmenities,
          hotelFacilities: _hotelFacilities,
          foodServices: _foodServices,
          additionalAmenities: _additionalAmenities,
          customAmenities: _customAmenities,
          gstNumber: _gstController.text,
          fssaiLicense: _fssaiController.text,
          tradeLicense: _tradeLicenseController.text,
          panNumber: _panController.text,
          aadharNumber: _aadharController.text,
          accountHolderName: _accountNameController.text,
          bankName: _bankNameController.text,
          accountNumber: _accountNumberController.text,
          ifscCode: _ifscController.text,
          branch: _branchController.text,
          accountType: _accountTypeController.text,
          uploadedFiles: _uploadedFiles,
          signatureName: _signatureNameController.text,
          declarationName: _declarationNameController.text,
          declarationDate: _selectedDate,
          personPhotoInfo: _personPhotoInfo,
          declarationAccepted: _declarationAccepted, isTwoStar: true,
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
}

class RegistrationSummaryScreen extends StatelessWidget {
  final Map<String, dynamic>? formData;
  final bool declarationAccepted;
  final String hotelName;
  final String? hotelType;
  final String yearOfEstablishment;
  final String totalRooms;
  final String ownerName;
  final String mobileNumber;
  final String alternateContact;
  final List<String> landlineNumbers;
  final String email;
  final String website;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String district;
  final String state;
  final String pinCode;
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
  final Map<String, Map<String, dynamic>> uploadedFiles;
  final String signatureName;
  final String declarationName;
  final DateTime? declarationDate;
  final Map<String, dynamic> personPhotoInfo;

  const RegistrationSummaryScreen({
    super.key,
    this.formData,
    required this.hotelName,
    this.hotelType,
    required this.yearOfEstablishment,
    required this.totalRooms,
    required this.ownerName,
    required this.mobileNumber,
    required this.alternateContact,
    required this.landlineNumbers,
    required this.email,
    required this.website,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.district,
    required this.state,
    required this.pinCode,
    required this.landmark,
    required this.selectedRoomTypes,
    required this.roomDetails,
    required this.minTariff,
    required this.maxTariff,
    required this.extraBedAvailable,
    required this.basicAmenities,
    required this.hotelFacilities,
    required this.foodServices,
    required this.additionalAmenities,
    required this.customAmenities,
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
    required this.uploadedFiles,
    required this.signatureName,
    required this.declarationName,
    this.declarationDate,
    required this.personPhotoInfo,
    required this.declarationAccepted, required bool isTwoStar,
  });

  static const Color primary = Color(0xFFFF5F6D);
  static const Color bg = Color(0xFFF9FAFB);
  static const Color textDark = Color(0xFF111827);
  static const Color textLight = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color green = Color(0xFF10B981);
  static const Color greenLight = Color(0xFFD1FAE5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Registration Summary',
          style: TextStyle(fontWeight: FontWeight.w600, color: textDark),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: textDark),
      ),
      // Replace the bottomNavigationBar in RegistrationSummaryScreen with this:

      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: primary,
      //         padding: const EdgeInsets.symmetric(vertical: 16),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //       ),
      //       onPressed: () {
      //         // Collect all registration data
      //         Map<String, dynamic> registrationData = {
      //           'hotelName': hotelName,
      //           'hotelType': hotelType,
      //           'yearOfEstablishment': yearOfEstablishment,
      //           'totalRooms': totalRooms,
      //           'ownerName': ownerName,
      //           'mobileNumber': mobileNumber,
      //           'alternateContact': alternateContact,
      //           'landlineNumbers': landlineNumbers,
      //           'email': email,
      //           'website': website,
      //           'addressLine1': addressLine1,
      //           'addressLine2': addressLine2,
      //           'city': city,
      //           'district': district,
      //           'state': state,
      //           'pinCode': pinCode,
      //           'landmark': landmark,
      //           'selectedRoomTypes': selectedRoomTypes,
      //           'roomDetails': roomDetails,
      //           'minTariff': minTariff,
      //           'maxTariff': maxTariff,
      //           'extraBedAvailable': extraBedAvailable,
      //           'basicAmenities': basicAmenities,
      //           'hotelFacilities': hotelFacilities,
      //           'foodServices': foodServices,
      //           'additionalAmenities': additionalAmenities,
      //           'customAmenities': customAmenities,
      //           'gstNumber': gstNumber,
      //           'fssaiLicense': fssaiLicense,
      //           'tradeLicense': tradeLicense,
      //           'aadharNumber': aadharNumber,
      //           'accountHolderName': accountHolderName,
      //           'bankName': bankName,
      //           'accountNumber': accountNumber,
      //           'ifscCode': ifscCode,
      //           'branch': branch,
      //           'accountType': accountType,
      //           'uploadedFiles': uploadedFiles,
      //           'signatureName': signatureName,
      //           'declarationName': declarationName,
      //           'declarationDate': declarationDate,
      //           'personPhotoInfo': personPhotoInfo,
      //           'declarationAccepted': declarationAccepted,
      //         };
      //
      //         // Navigate to LoginPage with ALL registration data
      //         Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => LoginPage(
      //               registrationData: registrationData,
      //               registeredEmail: email,
      //               registeredPassword: '', // Default password
      //             ),
      //           ),
      //               (route) => false,
      //         );
      //       },
      //       child: const Text(
      //         'Finish',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Collect all registration data
              Map<String, dynamic> registrationData = {
                'hotelName': hotelName,
                'hotelType': hotelType,
                'yearOfEstablishment': yearOfEstablishment,
                'totalRooms': totalRooms,
                'ownerName': ownerName,
                'mobileNumber': mobileNumber,
                'alternateContact': alternateContact,
                'landlineNumbers': landlineNumbers,
                'email': email,
                'website': website,
                'addressLine1': addressLine1,
                'addressLine2': addressLine2,
                'city': city,
                'district': district,
                'state': state,
                'pinCode': pinCode,
                'landmark': landmark,
                'selectedRoomTypes': selectedRoomTypes,
                'roomDetails': roomDetails,
                'minTariff': minTariff,
                'maxTariff': maxTariff,
                'extraBedAvailable': extraBedAvailable,
                'basicAmenities': basicAmenities,
                'hotelFacilities': hotelFacilities,
                'foodServices': foodServices,
                'additionalAmenities': additionalAmenities,
                'customAmenities': customAmenities,
                'gstNumber': gstNumber,
                'fssaiLicense': fssaiLicense,
                'tradeLicense': tradeLicense,
                'aadharNumber': aadharNumber,
                'accountHolderName': accountHolderName,
                'bankName': bankName,
                'accountNumber': accountNumber,
                'ifscCode': ifscCode,
                'branch': branch,
                'accountType': accountType,
                'uploadedFiles': uploadedFiles,
                'signatureName': signatureName,
                'declarationName': declarationName,
                'declarationDate': declarationDate,
                'personPhotoInfo': personPhotoInfo,
                'declarationAccepted': declarationAccepted,
              };



              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => PropertyAuthScreen(
                    registrationData: registrationData,
                  ),
                ),
                    (route) => false,
              );
            },
            child: const Text(
              'Finish',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _successCard(),

            _section('Hotel Information', [
              _info('Hotel Name', hotelName),
              _info('Hotel Type', hotelType ?? 'Not selected'),
              _info('Year of Establishment', yearOfEstablishment),
              _info('Total Rooms', totalRooms),
            ]),

            _section('Contact Information', [
              _info('Owner Name', ownerName),
              if (personPhotoInfo['uploaded'] == true)
                _fileInfo('Profile Photo', personPhotoInfo['name'] ?? 'Photo'),
              _info('Mobile', mobileNumber),
              if (alternateContact.isNotEmpty)
                _info('Alternate Contact', alternateContact),
              ...landlineNumbers
                  .where((e) => e.isNotEmpty)
                  .map((e) => _info('Landline', e)),
              if (email.isNotEmpty) _info('Email', email),
              if (website.isNotEmpty) _info('Website', website),
            ]),

            _section('Hotel Address', [
              _info('Address Line 1', addressLine1),
              if (addressLine2.isNotEmpty)
                _info('Address Line 2', addressLine2),
              _info('City', city),
              _info('District', district),
              _info('State', state),
              _info('PIN Code', pinCode),
              if (landmark.isNotEmpty) _info('Landmark', landmark),
            ]),

            if (selectedRoomTypes.entries.any((entry) => entry.value))
              _section('Room Configuration', [
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
                  children: selectedRoomTypes.entries
                      .where((entry) => entry.value)
                      .map(
                        (entry) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primary.withOpacity(0.3)),
                      ),
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
                const SizedBox(height: 16),

                ...selectedRoomTypes.entries.where((entry) => entry.value).map((
                    entry,
                    ) {
                  String roomType = entry.key;
                  var details = roomDetails[roomType]!;
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
                            if (details['rooms'] != null &&
                                details['rooms'].toString().isNotEmpty)
                              _row(
                                'Number of Rooms',
                                details['rooms'].toString(),
                              ),
                            if (details['occupancy'] != null &&
                                details['occupancy'].toString().isNotEmpty)
                              _row(
                                'Max Occupancy',
                                '${details['occupancy']} Persons',
                              ),
                            if (details['price'] != null &&
                                details['price'].toString().isNotEmpty)
                              _row('Price per Night', '₹${details['price']}'),
                            _row(
                              'AC/Non-AC',
                              details['ac'] == true ? 'AC' : 'Non-AC',
                            ),
                            _row(
                              'Extra Bed Available',
                              details['extraBed'] == true ? 'Yes' : 'No',
                            ),
                            if (details['extraBed'] == true &&
                                details['extraBedPrice'] != null &&
                                details['extraBedPrice'].toString().isNotEmpty)
                              _row(
                                'Extra Bed Price',
                                '₹${details['extraBedPrice']}',
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),

                if (minTariff.isNotEmpty || maxTariff.isNotEmpty)
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
                            Text(
                              'Room Tariff Range',
                              style: TextStyle(fontSize: 13, color: textLight),
                            ),
                            Text(
                              '₹$minTariff - ₹$maxTariff',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: green,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: green),
                          ),
                          child: Text(
                            extraBedAvailable
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
              ]),

            _section('Amenities & Facilities', [
              if (basicAmenities.entries.any((entry) => entry.value))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _amenityCategory('Basic Amenities', basicAmenities),
                    const SizedBox(height: 12),
                  ],
                ),

              if (hotelFacilities.entries.any((entry) => entry.value))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _amenityCategory('Hotel Facilities', hotelFacilities),
                    const SizedBox(height: 12),
                  ],
                ),

              if (foodServices.entries.any((entry) => entry.value))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _amenityCategory('Food & Services', foodServices),
                    const SizedBox(height: 12),
                  ],
                ),

              if (additionalAmenities.entries.any((entry) => entry.value))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _amenityCategory(
                      'Additional Amenities',
                      additionalAmenities,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),

              if (customAmenities.isNotEmpty)
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
                      children: customAmenities
                          .map(
                            (amenity) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: primary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primary,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
            ]),

            _section('Legal Details', [
              if (gstNumber.isNotEmpty) _info('GST Number', gstNumber),
              if (fssaiLicense.isNotEmpty) _info('FSSAI License', fssaiLicense),
              if (tradeLicense.isNotEmpty) _info('Trade License', tradeLicense),

              if (aadharNumber.isNotEmpty) _info('Aadhar Number', aadharNumber),
            ]),

            _section('Bank Details', [
              _info('Account Holder', accountHolderName),
              _info('Bank Name', bankName),
              _info('Account Number', accountNumber),
              _info('IFSC Code', ifscCode),
              if (branch.isNotEmpty) _info('Branch', branch),
              if (accountType.isNotEmpty) _info('Account Type', accountType),
            ]),

            if (uploadedFiles.entries.any(
                  (entry) => entry.value['uploaded'] == true,
            ))
              _section('Uploaded Documents', [
                ...uploadedFiles.entries
                    .where((entry) => entry.value['uploaded'] == true)
                    .map((entry) => _documentFile(entry.key, entry.value)),
              ]),

            _section('Declaration', [
              _info('Authorized Signatory', signatureName),
              _info('Name', declarationName),
              if (declarationDate != null)
                _info(
                  'Date',
                  '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
                ),
              // Add declaration status
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: declarationAccepted
                      ? Color(0xFFD1FAE5)
                      : Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      declarationAccepted ? Icons.check_circle : Icons.error,
                      color: declarationAccepted
                          ? Color(0xFF059669)
                          : Color(0xFFDC2626),
                    ),
                    SizedBox(width: 8),
                    Text(
                      declarationAccepted
                          ? 'Declaration accepted'
                          : 'Declaration not accepted',
                      style: TextStyle(
                        color: declarationAccepted
                            ? Color(0xFF059669)
                            : Color(0xFFDC2626),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ]),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _successCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [primary, Color(0xFFFF8A7A)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          Icon(Icons.verified, color: Colors.white, size: 36),
          SizedBox(width: 14),
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
                SizedBox(height: 4),
                Text(
                  'Your application has been submitted for review',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _info(String label, String value) {
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
                value,
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
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
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
            ),
          )
              .toList(),
        ),
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
      if (fileName.endsWith('.jpg') ||
          fileName.endsWith('.jpeg') ||
          fileName.endsWith('.png'))
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
      if (fileName.endsWith('.jpg') ||
          fileName.endsWith('.jpeg') ||
          fileName.endsWith('.png'))
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
                            (fileInfo['name']
                                ?.toString()
                                .split('.')
                                .last
                                .toUpperCase() ??
                                'FILE'),
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

// class LoginPage extends StatefulWidget {
//   final String? registeredEmail;
//   final String? registeredPassword;
//   final Map<String, dynamic>? registrationData;
//
//   const LoginPage({
//     super.key,
//     this.registeredEmail,
//     this.registeredPassword,
//     this.registrationData,
//   });
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;
//   bool _rememberMe = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Pre-fill email if available
//     if (widget.registeredEmail != null) {
//       _emailController.text = widget.registeredEmail!;
//     }
//
//     // For demo, set default password
//     if (widget.registeredPassword != null) {
//       _passwordController.text = widget.registeredPassword!;
//     } else {
//       // Default password for demo
//       _passwordController.text = 'hotel@123';
//     }
//
//     // Animation setup
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
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _submitForm() {
//     if (_emailController.text.trim().isEmpty ||
//         _passwordController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please fill all fields"),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         _isLoading = false;
//       });
//
//       // For demo purposes: Accept ANY login if registrationData exists
//       // OR check against registered credentials
//       if (widget.registrationData != null ||
//           (_emailController.text.trim() == widget.registeredEmail &&
//               _passwordController.text.trim() == widget.registeredPassword)) {
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.white),
//                 SizedBox(width: 8),
//                 Text("Login Successful!"),
//               ],
//             ),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             duration: Duration(seconds: 2),
//           ),
//         );
//
//         Future.delayed(const Duration(seconds: 2), () {
//           // Use registrationData if available, otherwise use individual fields
//           Map<String, dynamic> regData = widget.registrationData ?? {};
//
//           // Extract hotel owner data from registration data
//           String hotelName = regData['hotelName'] ?? 'Raj Bhavan Hotel';
//           String ownerName = regData['ownerName'] ?? 'John Alexandar';
//           String mobileNumber = regData['mobileNumber'] ?? '99933366677';
//           String email = regData['email'] ?? 'hotel@gmail.com';
//           String addressLine1 = regData['addressLine1'] ?? '123 Main Street';
//           String addressLine2 = regData['addressLine2'] ?? '';
//           String city = regData['city'] ?? 'Mumbai';
//           String district = regData['district'] ?? 'Mumbai District';
//           String state = regData['state'] ?? 'Maharashtra';
//           String pinCode = regData['pinCode'] ?? '400001';
//           String gstNumber = regData['gstNumber'] ?? '27ABCDE1234F1Z5';
//           String fssaiLicense = regData['fssaiLicense'] ?? '12345678901234';
//           String tradeLicense = regData['tradeLicense'] ?? 'TL78901234';
//           String aadharNumber = regData['aadharNumber'] ?? '1234 5678 9012';
//           String accountHolderName = regData['accountHolderName'] ?? 'John Alexandar';
//           String bankName = regData['bankName'] ?? 'State Bank of India';
//           String accountNumber = regData['accountNumber'] ?? '123456789012';
//           String ifscCode = regData['ifscCode'] ?? 'SBIN0001234';
//           String branch = regData['branch'] ?? 'Mumbai Main';
//           String accountType = regData['accountType'] ?? 'Savings';
//           int totalRooms = int.tryParse(regData['totalRooms']?.toString() ?? '58') ?? 58;
//
//           // Person photo info
//           Map<String, dynamic> personPhotoInfo = regData['personPhotoInfo'] ??
//               {'name': '', 'size': 0, 'path': '', 'uploaded': false};
//
//           // Other registration data
//           String hotelType = regData['hotelType'] ?? 'Standard Hotel';
//           String yearOfEstablishment = regData['yearOfEstablishment'] ?? '2015';
//           String website = regData['website'] ?? 'https://rajbhavanhotel.com';
//           String landmark = regData['landmark'] ?? 'Near City Center';
//           Map<String, bool> selectedRoomTypes = regData['selectedRoomTypes'] ?? {};
//           Map<String, Map<String, dynamic>> roomDetails = regData['roomDetails'] ?? {};
//           String minTariff = regData['minTariff'] ?? '2500';
//           String maxTariff = regData['maxTariff'] ?? '6000';
//           bool extraBedAvailable = regData['extraBedAvailable'] ?? true;
//           Map<String, bool> basicAmenities = regData['basicAmenities'] ?? {};
//           Map<String, bool> hotelFacilities = regData['hotelFacilities'] ?? {};
//           Map<String, bool> foodServices = regData['foodServices'] ?? {};
//           Map<String, bool> additionalAmenities = regData['additionalAmenities'] ?? {};
//           List<String> customAmenities = List<String>.from(regData['customAmenities'] ?? []);
//           String alternateContact = regData['alternateContact'] ?? '';
//           List<String> landlineNumbers = List<String>.from(regData['landlineNumbers'] ?? []);
//           Map<String, Map<String, dynamic>> uploadedFiles = Map<String, Map<String, dynamic>>.from(regData['uploadedFiles'] ?? {});
//           String signatureName = regData['signatureName'] ?? 'John Alexandar';
//           String declarationName = regData['declarationName'] ?? 'John Alexandar';
//           DateTime? declarationDate = regData['declarationDate'];
//           bool declarationAccepted = regData['declarationAccepted'] ?? true;
//
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HotelOwnerDashboard(
//                 hotelName: hotelName,
//                 ownerName: ownerName,
//                 mobileNumber: mobileNumber,
//                 email: email,
//                 addressLine1: addressLine1,
//                 addressLine2: addressLine2,
//                 city: city,
//                 district: district,
//                 state: state,
//                 pinCode: pinCode,
//                 gstNumber: gstNumber,
//                 fssaiLicense: fssaiLicense,
//                 tradeLicense: tradeLicense,
//                 aadharNumber: aadharNumber,
//                 accountHolderName: accountHolderName,
//                 bankName: bankName,
//                 accountNumber: accountNumber,
//                 ifscCode: ifscCode,
//                 branch: branch,
//                 accountType: accountType,
//                 totalRooms: totalRooms,
//                 personPhotoInfo: personPhotoInfo,
//                 registrationData: {
//                   'hotelName': hotelName,
//                   'ownerName': ownerName,
//                   'mobileNumber': mobileNumber,
//                   'email': email,
//                   'addressLine1': addressLine1,
//                   'addressLine2': addressLine2,
//                   'city': city,
//                   'district': district,
//                   'state': state,
//                   'pinCode': pinCode,
//                   'gstNumber': gstNumber,
//                   'fssaiLicense': fssaiLicense,
//                   'tradeLicense': tradeLicense,
//                   'aadharNumber': aadharNumber,
//                   'accountHolderName': accountHolderName,
//                   'bankName': bankName,
//                   'accountNumber': accountNumber,
//                   'ifscCode': ifscCode,
//                   'branch': branch,
//                   'accountType': accountType,
//                   'totalRooms': totalRooms,
//                   'personPhotoInfo': personPhotoInfo,
//                   'hotelType': hotelType,
//                   'yearOfEstablishment': yearOfEstablishment,
//                   'website': website,
//                   'landmark': landmark,
//                   'selectedRoomTypes': selectedRoomTypes,
//                   'roomDetails': roomDetails,
//                   'minTariff': minTariff,
//                   'maxTariff': maxTariff,
//                   'extraBedAvailable': extraBedAvailable,
//                   'basicAmenities': basicAmenities,
//                   'hotelFacilities': hotelFacilities,
//                   'foodServices': foodServices,
//                   'additionalAmenities': additionalAmenities,
//                   'customAmenities': customAmenities,
//                   'alternateContact': alternateContact,
//                   'landlineNumbers': landlineNumbers,
//                   'uploadedFiles': uploadedFiles,
//                   'signatureName': signatureName,
//                   'declarationName': declarationName,
//                   'declarationDate': declarationDate,
//                   'declarationAccepted': declarationAccepted,
//                 }, panNumber: '',
//               ),
//             ),
//                 (route) => false,
//           );
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 Icon(Icons.error, color: Colors.white),
//                 SizedBox(width: 8),
//                 Text("Invalid email or password"),
//               ],
//             ),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     });
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
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.02),
//                 SizedBox(height: h * 0.09),
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
//                               "Welcome Back",
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
//                               "Login to continue your journey with us",
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
//                           child: Column(
//                             children: [
//                               _buildTextField(
//                                 Icons.email_outlined,
//                                 "Email Address",
//                                 controller: _emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                               ),
//
//                               SizedBox(height: h * 0.02),
//
//                               _buildPasswordField(
//                                 Icons.lock_outline,
//                                 "Password",
//                                 controller: _passwordController,
//                               ),
//
//                               SizedBox(height: h * 0.03),
//
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             _rememberMe = !_rememberMe;
//                                           });
//                                         },
//                                         child: Container(
//                                           width: 20,
//                                           height: 20,
//                                           decoration: BoxDecoration(
//                                             color: _rememberMe
//                                                 ? Color(0xFFFF7043)
//                                                 : Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               4,
//                                             ),
//                                             border: Border.all(
//                                               color: _rememberMe
//                                                   ? Color(0xFFFF7043)
//                                                   : Colors.grey,
//                                               width: 1.5,
//                                             ),
//                                           ),
//                                           child: _rememberMe
//                                               ? Icon(
//                                             Icons.check,
//                                             size: 16,
//                                             color: Colors.white,
//                                           )
//                                               : null,
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         "Remember me",
//                                         style: TextStyle(
//                                           color: Colors.grey[700],
//                                           fontSize: w * 0.035,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => ForgotPasswordScreen(
//                                             registeredEmail:
//                                             widget.registeredEmail,
//                                             registeredPassword:
//                                             widget.registeredPassword,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       "Forgot Password?",
//                                       style: TextStyle(
//                                         color: Color(0xFFFF7043),
//                                         fontSize: w * 0.035,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: h * 0.05),
//
//                               AnimatedBuilder(
//                                 animation: _controller,
//                                 builder: (context, child) {
//                                   return Transform.scale(
//                                     scale: _scaleAnimation.value,
//                                     child: GestureDetector(
//                                       onTap: _submitForm,
//                                       child: Container(
//                                         width: w * 0.7,
//                                         height: h * 0.07,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(
//                                             15,
//                                           ),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color(0xFFFF5F6D),
//                                               Color(0xFFFF8061),
//                                             ],
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                           ),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black.withOpacity(
//                                                 0.3,
//                                               ),
//                                               blurRadius: 10,
//                                               offset: Offset(0, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Center(
//                                           child: _isLoading
//                                               ? SizedBox(
//                                             width: 20,
//                                             height: 20,
//                                             child: CircularProgressIndicator(
//                                               valueColor:
//                                               AlwaysStoppedAnimation<
//                                                   Color
//                                               >(Colors.white),
//                                               strokeWidth: 2,
//                                             ),
//                                           )
//                                               : Text(
//                                             "Login",
//                                             style: TextStyle(
//                                               fontSize: w * 0.045,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//
//                               SizedBox(height: h * 0.025),
//
//                               AnimatedBuilder(
//                                 animation: _controller,
//                                 builder: (context, child) {
//                                   return Transform.translate(
//                                     offset: Offset(0, _slideAnimation.value),
//                                     child: Opacity(
//                                       opacity: _fadeAnimation.value,
//                                       child: Center(
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: RichText(
//                                             text: TextSpan(
//                                               text: "Don't have an account? ",
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: w * 0.04,
//                                               ),
//                                               children: [
//                                                 TextSpan(
//                                                   text: "Sign Up",
//                                                   style: TextStyle(
//                                                     color: Color(0xFFFF7043),
//                                                     fontWeight: FontWeight.bold,
//                                                     shadows: [
//                                                       Shadow(
//                                                         blurRadius: 2.0,
//                                                         color: Colors.black
//                                                             .withOpacity(0.3),
//                                                         offset: Offset(
//                                                           1.0,
//                                                           1.0,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: h * 0.04),
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
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!, width: 1),
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: TextStyle(color: Colors.black87),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.grey[600]),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPasswordField(
//       IconData icon,
//       String hint, {
//         required TextEditingController controller,
//       }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!, width: 1),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: !_isPasswordVisible,
//         style: TextStyle(color: Colors.black87),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.grey[600]),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//               color: Colors.grey[600],
//             ),
//             onPressed: () {
//               setState(() {
//                 _isPasswordVisible = !_isPasswordVisible;
//               });
//             },
//           ),
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
//         ),
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
  String _selectedRoomType = 'All';
  String _selectedGraphFilter = 'Daily';
  List<String> _months = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];
  List<Map<String, dynamic>> _roomTypeData = [];
  DateTime _selectedStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now();




  @override
  void initState() {
    super.initState();
    _initializeRoomData();
  }

  void _initializeRoomData() {
    final roomDetails = widget.registrationData?['roomDetails'] ?? {};
    _roomTypeData.clear();

    roomDetails.forEach((type, details) {
      int totalRooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
      double price = double.tryParse(details['price']?.toString() ?? '0') ?? 0;
      bool isAC = details['ac'] ?? false;

      // Calculate detailed room status
      int acRooms = isAC ? totalRooms : 0;
      int nonAcRooms = !isAC ? totalRooms : 0;

      // Generate detailed breakdown (for demo purposes)
      int availableAC = isAC ? (totalRooms * 0.35).round() : 0;
      int bookedAC = isAC ? (totalRooms * 0.55).round() : 0;
      int maintenanceAC = isAC ? (totalRooms * 0.10).round() : 0;

      int availableNonAC = !isAC ? (totalRooms * 0.35).round() : 0;
      int bookedNonAC = !isAC ? (totalRooms * 0.55).round() : 0;
      int maintenanceNonAC = !isAC ? (totalRooms * 0.10).round() : 0;

      _roomTypeData.add({
        'type': type,
        'total': totalRooms,
        'price': price,
        'isAC': isAC,
        'acRooms': acRooms,
        'nonAcRooms': nonAcRooms,
        'availableAC': availableAC,
        'bookedAC': bookedAC,
        'maintenanceAC': maintenanceAC,
        'availableNonAC': availableNonAC,
        'bookedNonAC': bookedNonAC,
        'maintenanceNonAC': maintenanceNonAC,
        'totalAvailable': availableAC + availableNonAC,
        'totalBooked': bookedAC + bookedNonAC,
        'totalMaintenance': maintenanceAC + maintenanceNonAC,
      });
    });
  }

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

  // AppBar (unchanged)
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
        setState(() {
          _initializeRoomData();
        });
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 2: Summary Section
            _buildSummarySection(),

            SizedBox(height: 24),

            // Step 3: Detailed Room Types Table (Replacing Description)
            _buildRoomTypesTable(),

            SizedBox(height: 24),

            // Step 5: Booking Insights with Wave Line Graph
            _buildBookingInsightsGraph(),

            SizedBox(height: 24),

            // Step 6: Monthly Booking Statistics
            _buildMonthlyBookingStats(),

            SizedBox(height: 40),

            _buildPaymentOverview(),

            SizedBox(height: 24),

          ],
        ),
      ),
    );
  }

  // Step 2: Summary Section (unchanged)
  Widget _buildSummarySection() {
    final roomDetails = widget.registrationData?['roomDetails'] ?? {};
    int totalConfiguredRooms = 0;
    int totalAvailableRooms = 0;
    int totalOccupiedRooms = 0;

    roomDetails.forEach((type, details) {
      int rooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
      totalConfiguredRooms += rooms;
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


  Widget _buildRoomTypesTable() {
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
                'Detailed Room Types',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.table_chart_rounded, size: 14, color: _primaryColor),
                    SizedBox(width: 6),
                    Text(
                      'Room Status',
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

          // Table Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 12),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
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
                    'AC',
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
                    'Non-AC',
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
                    'Available',
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
                    'Booked',
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

          SizedBox(height: 12),


          ..._generateStaticRoomData().map((room) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        // Container(
                        //   width: 36,
                        //   height: 36,
                        //   decoration: BoxDecoration(
                        //     // color: room['isAC'] ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   // child: Center(
                        //   //   child: Icon(
                        //   //     room['isAC'] ? Icons.ac_unit_rounded : Icons.air_rounded,
                        //   //     size: 18,
                        //   //     color: room['isAC'] ? Colors.blue : Colors.green,
                        //   //   ),
                        //   // ),
                        // ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room['type'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _textDark,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '₹${room['price']}/night',
                              style: TextStyle(
                                fontSize: 10,
                                color: _textLight,
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
                        Text(
                          '${room['acRooms']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Rooms',
                          style: TextStyle(
                            fontSize: 10,
                            color: _textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${room['nonAcRooms']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Rooms',
                          style: TextStyle(
                            fontSize: 10,
                            color: _textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _successColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${room['available']}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _successColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 10,
                            color: _successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${room['booked']}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Booked',
                          style: TextStyle(
                            fontSize: 10,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          SizedBox(height: 16),

          // Summary Row
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Summary:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),
                Row(
                  children: [
                    _buildSummaryItem('AC:', '58', Colors.blue),
                    SizedBox(width: 16),
                    _buildSummaryItem('Non-AC:', '0', Colors.green),
                    SizedBox(width: 16),
                    _buildSummaryItem('Available:', '19', _successColor),
                    SizedBox(width: 16),
                    _buildSummaryItem('Booked:', '39', _primaryColor),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16),


          // GestureDetector(
          //   onTap: () {
          //
          //     _showDetailedRoomBreakdown();
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: _primaryColor.withOpacity(0.05),
          //       borderRadius: BorderRadius.circular(12),
          //       border: Border.all(color: _primaryColor.withOpacity(0.2)),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.visibility_rounded, size: 16, color: _primaryColor),
          //         SizedBox(width: 8),
          //         Text(
          //           'View Detailed Breakdown',
          //           style: TextStyle(
          //             fontSize: 12,
          //             fontWeight: FontWeight.w700,
          //             color: _primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

// Helper method to generate static room data
  List<Map<String, dynamic>> _generateStaticRoomData() {
    return [
      {
        'type': 'Standard',
        'price': '2,500',
        'isAC': true,
        'acRooms': 20,
        'nonAcRooms': 0,
        'available': 7,
        'booked': 13,
        'total': 20,
      },
      {
        'type': 'Deluxe',
        'price': '3,500',
        'isAC': true,
        'acRooms': 15,
        'nonAcRooms': 0,
        'available': 5,
        'booked': 10,
        'total': 15,
      },
      {
        'type': 'Suite',
        'price': '5,000',
        'isAC': true,
        'acRooms': 10,
        'nonAcRooms': 0,
        'available': 3,
        'booked': 7,
        'total': 10,
      },

      {
        'type': 'Family',
        'price': '4,200',
        'isAC': true,
        'acRooms': 8,
        'nonAcRooms': 0,
        'available': 3,
        'booked': 5,
        'total': 8,
      },
      {
        'type': 'Executive',
        'price': '6,000',
        'isAC': true,
        'acRooms': 5,
        'nonAcRooms': 0,
        'available': 1,
        'booked': 4,
        'total': 5,
      },
    ];
  }

// Helper method for summary items
  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: _textLight,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }


  List<Widget> _getRoomTypeLabels(List<String> roomTypesList) {
    // When "All" is selected, show all room types
    if (_selectedRoomType == 'All') {
      return roomTypesList.asMap().entries.map((entry) {
        int index = entry.key;
        String roomType = entry.value;

        return Container(
          height: 44, // 220 height / 5 room types = 44 each
          alignment: Alignment.centerLeft,
          child: Text(
            roomType,
            style: TextStyle(
              fontSize: 10,
              color: _textLight,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList();
    }
    // When specific room type is selected, show only that
    else {
      return [
        Container(
          height: 220,
          alignment: Alignment.centerLeft,
          child: RotatedBox(
            quarterTurns: 3, // Rotate text vertically
            child: Text(
              _selectedRoomType,
              style: TextStyle(
                fontSize: 10,
                color: _textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ];
    }
  }



  Widget _buildBookingInsightsGraph() {
    // List of room types for dropdown
    List<String> roomTypesList = ['Standard', 'Deluxe', 'Suite', 'Family', 'Executive'];

    // Generate sample data for wave line graph
    Map<String, List<double>> _generateWaveData(String roomType) {
      Map<String, List<double>> data = {};

      // Generate data for each room type
      for (String type in roomTypesList) {
        if (roomType == 'All' || roomType == type) {
          List<double> wavePoints = [];
          int days = 30; // 30 days of data

          for (int i = 0; i < days; i++) {
            // Different base values for different room types
            double baseValue = 0;
            switch (type) {
              case 'Standard':
                baseValue = 15;
                break;
              case 'Deluxe':
                baseValue = 12;
                break;
              case 'Suite':
                baseValue = 8;
                break;
              case 'Family':
                baseValue = 10;
                break;
              case 'Executive':
                baseValue = 6;
                break;
            }

            // Add wave pattern
            double variation = sin(i * 0.3) * 5 + cos(i * 0.5) * 3;
            double trend = i * 0.1; // Slight upward trend
            double noise = (Random().nextDouble() * 3) - 1.5; // Small random noise

            wavePoints.add(baseValue + variation + trend + noise);
          }
          data[type] = wavePoints;
        }
      }

      // If "All" is selected, create combined data
      if (roomType == 'All') {
        List<double> combinedData = [];
        int days = 30;

        for (int i = 0; i < days; i++) {
          double combinedValue = 0;
          data.forEach((type, wavePoints) {
            combinedValue += wavePoints[i];
          });
          combinedData.add(combinedValue);
        }
        data['All'] = combinedData;
      }

      return data;
    }

    Map<String, List<double>> waveData = _generateWaveData(_selectedRoomType);
    List<double> currentWaveData = waveData[_selectedRoomType] ?? waveData['All'] ?? [];

    double maxValue = currentWaveData.reduce((a, b) => a > b ? a : b);
    double minValue = currentWaveData.reduce((a, b) => a < b ? a : b);

    // Calculate statistics
    double average = currentWaveData.isNotEmpty
        ? currentWaveData.reduce((a, b) => a + b) / currentWaveData.length
        : 0;
    double currentValue = currentWaveData.isNotEmpty ? currentWaveData.last : 0;

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
                  'Booking Trends Analysis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Filters
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Type',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textLight,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: _cardBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: _borderColor),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedRoomType,
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down_rounded, color: _primaryColor),
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'All',
                                      child: Text('All Rooms'),
                                    ),
                                    ...roomTypesList.map<DropdownMenuItem<String>>((String type) {
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRoomType = value!;
                                    });
                                  },
                                ),
                              ),
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
                              'Date Range',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textLight,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: _cardBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: _borderColor),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Start Date
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _showStartDatePicker(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.calendar_month_rounded, size: 12, color: _primaryColor),
                                              SizedBox(width: 4),
                                              Text(
                                                '${_selectedStartDate.day}/${_selectedStartDate.month}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: _textDark,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Separator
                                    Container(
                                      width: 1,
                                      color: _borderColor,
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                    ),

                                    // End Date
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _showEndDatePicker(),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${_selectedEndDate.day}/${_selectedEndDate.month}',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: _textDark,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(Icons.calendar_month_rounded, size: 12, color: _primaryColor),
                                            ],
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
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Date Range',
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           color: _textLight,
                      //         ),
                      //       ),
                      //       SizedBox(height: 4),
                      //       Container(
                      //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      //         decoration: BoxDecoration(
                      //           color: _cardBg,
                      //           borderRadius: BorderRadius.circular(8),
                      //           border: Border.all(color: _borderColor),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Expanded(
                      //               child: GestureDetector(
                      //                 onTap: () => _showStartDatePicker(),
                      //                 child: Row(
                      //                   children: [
                      //                     Icon(Icons.calendar_month_rounded, size: 16, color: _primaryColor),
                      //                     SizedBox(width: 8),
                      //                     Text(
                      //                       '${_selectedStartDate.day}/${_selectedStartDate.month}/${_selectedStartDate.year}',
                      //                       style: TextStyle(
                      //                         fontSize: 12,
                      //                         color: _textDark,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(horizontal: 8),
                      //               child: Icon(Icons.arrow_forward_rounded, size: 16, color: _textLight),
                      //             ),
                      //             Expanded(
                      //               child: GestureDetector(
                      //                 onTap: () => _showEndDatePicker(),
                      //                 child: Row(
                      //                   mainAxisAlignment: MainAxisAlignment.end,
                      //                   children: [
                      //                     Text(
                      //                       '${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}',
                      //                       style: TextStyle(
                      //                         fontSize: 12,
                      //                         color: _textDark,
                      //                       ),
                      //                     ),
                      //                     SizedBox(width: 8),
                      //                     Icon(Icons.calendar_month_rounded, size: 16, color: _primaryColor),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 12),


                ],
              ),
            ),

            SizedBox(height: 20),







            Container(
              height: 280,
              child: Column(
                children: [
                  // Y-axis labels (Room Types) and Graph Area
                  Container(
                    height: 220,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Y-axis label (Room Types)
                        Container(
                          width: 40,
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _getRoomTypeLabels(roomTypesList),
                          ),
                        ),

                        // Graph Area
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: _borderColor, width: 1),
                                right: BorderSide(color: _borderColor, width: 1),
                                bottom: BorderSide(color: _borderColor, width: 1),
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Grid lines
                                for (int i = 0; i <= 4; i++)
                                  Positioned(
                                    top: (220 * i / 4),
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 1,
                                      color: _borderColor.withOpacity(0.3),
                                    ),
                                  ),

                                // Wave graph
                                CustomPaint(
                                  size: Size(double.infinity, 220),
                                  painter: _BookingTrendGraphPainter(
                                    data: currentWaveData,
                                    maxValue: maxValue,
                                    minValue: minValue,
                                    primaryColor: _primaryColor,
                                    secondaryColor: _secondaryColor,
                                    showRoomTypes: _selectedRoomType == 'All',
                                    roomTypes: _selectedRoomType == 'All' ? roomTypesList : [_selectedRoomType],
                                    roomTypeColors: {
                                      'Standard': Colors.blue,
                                      'Deluxe': Colors.purple,
                                      'Suite': Colors.orange,
                                      'Family': Colors.pink,
                                      'Executive': Colors.red,
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // X-axis labels and title
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 40), // Match Y-axis width
                    child: Column(
                      children: [
                        // X-axis line with markers
                        Expanded(
                          child: Stack(
                            children: [
                              // Horizontal line for X-axis
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 1,
                                  color: _borderColor,
                                ),
                              ),

                              // X-axis markers (0, 15, 30, 45)
                              Positioned.fill(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Day 0
                                    Column(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 8,
                                          color: _borderColor,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '0 day',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: _textLight,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Day 15
                                    Column(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 8,
                                          color: _borderColor,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '15 day',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: _textLight,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Day 30
                                    Column(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 8,
                                          color: _borderColor,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '30 day',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: _textLight,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Day 45
                                    Column(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 8,
                                          color: _borderColor,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '45',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: _textLight,
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

                        // X-axis title
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Days',
                            style: TextStyle(
                              fontSize: 10,
                              color: _textLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),


            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Statistics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGraphStatItem(
                        title: 'Current',
                        value: currentValue.toStringAsFixed(1),
                        color: _primaryColor,
                      ),
                      _buildGraphStatItem(
                        title: 'Average',
                        value: average.toStringAsFixed(1),
                        color: _secondaryColor,
                      ),
                      _buildGraphStatItem(
                        title: 'Maximum',
                        value: maxValue.toStringAsFixed(1),
                        color: _successColor,
                      ),
                      _buildGraphStatItem(
                        title: 'Minimum',
                        value: minValue.toStringAsFixed(1),
                        color: _warningColor,
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Legend (only shown when "All" is selected)
                  if (_selectedRoomType == 'All')
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room Type Legend:',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _textDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            runSpacing: 6,
                            children: roomTypesList.map((type) {
                              Color color = {
                                'Standard': Colors.blue,
                                'Deluxe': Colors.purple,
                                'Suite': Colors.orange,
                                'Family': Colors.pink,
                                'Executive': Colors.red,
                              }[type] ?? _primaryColor;

                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    type,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _textLight,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 8),


          ],

        ),
    );


  }
  Future<void> _showStartDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2001),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              onSurface: _textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;

        // Auto-fix end date if needed
        if (_selectedEndDate.isBefore(picked)) {
          _selectedEndDate = picked;
        }
      });
    }
  }
  Future<void> _showEndDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              onSurface: _textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }




  Widget _buildGraphStatItem({
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: _textLight,
          ),
        ),
      ],
    );
  }
  Widget _buildMonthlyBookingStats() {
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
                'Monthly Statistics ($_selectedMonth)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),

            ],
          ),

          SizedBox(height: 20),

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


// In _showProfile() method of HotelOwnerDashboard:

  // void _showProfile() {
  //   Navigator.push(
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
  //
  //         // Pass all registration data fields
  //         hotelType: widget.registrationData['hotelType'] ?? '',
  //         yearOfEstablishment: widget.registrationData['yearOfEstablishment'] ?? '',
  //         website: widget.registrationData['website'] ?? '',
  //         landmark: widget.registrationData['landmark'] ?? '',
  //         selectedRoomTypes: widget.registrationData['selectedRoomTypes'] ?? {},
  //         roomDetails: widget.registrationData['roomDetails'] ?? {},
  //         minTariff: widget.registrationData['minTariff'] ?? '',
  //         maxTariff: widget.registrationData['maxTariff'] ?? '',
  //         extraBedAvailable: widget.registrationData['extraBedAvailable'] ?? false,
  //         basicAmenities: widget.registrationData['basicAmenities'] ?? {},
  //         hotelFacilities: widget.registrationData['hotelFacilities'] ?? {},
  //         foodServices: widget.registrationData['foodServices'] ?? {},
  //         additionalAmenities: widget.registrationData['additionalAmenities'] ?? {},
  //         customAmenities: widget.registrationData['customAmenities'] ?? [],
  //         alternateContact: widget.registrationData['alternateContact'] ?? '',
  //         landlineNumbers: widget.registrationData['landlineNumbers'] ?? [],
  //         uploadedFiles: widget.registrationData['uploadedFiles'] ?? {},
  //         signatureName: widget.registrationData['signatureName'] ?? '',
  //         declarationName: widget.registrationData['declarationName'] ?? '',
  //         declarationDate: widget.registrationData['declarationDate'],
  //         declarationAccepted: widget.registrationData['declarationAccepted'] ?? false,
  //       ),
  //     ),
  //   );
  // }


  void _showProfile() async {
    // Prepare registration data
    Map<String, dynamic> regData = widget.registrationData;

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
          hotelType: regData['hotelType'] ?? '',
          yearOfEstablishment: regData['yearOfEstablishment'] ?? '',
          website: regData['website'] ?? '',
          landmark: regData['landmark'] ?? '',
          selectedRoomTypes: regData['selectedRoomTypes'] ?? {},
          roomDetails: regData['roomDetails'] ?? {},
          minTariff: regData['minTariff'] ?? '',
          maxTariff: regData['maxTariff'] ?? '',
          extraBedAvailable: regData['extraBedAvailable'] ?? false,
          basicAmenities: regData['basicAmenities'] ?? {},
          hotelFacilities: regData['hotelFacilities'] ?? {},
          foodServices: regData['foodServices'] ?? {},
          additionalAmenities: regData['additionalAmenities'] ?? {},
          customAmenities: regData['customAmenities'] ?? [],
          alternateContact: regData['alternateContact'] ?? '',
          landlineNumbers: regData['landlineNumbers'] ?? [],
          uploadedFiles: regData['uploadedFiles'] ?? {},
          signatureName: regData['signatureName'] ?? '',
          declarationName: regData['declarationName'] ?? '',
          declarationDate: regData['declarationDate'],
          declarationAccepted: regData['declarationAccepted'] ?? false,
        ),
      ),
    );

    if (updatedData != null && updatedData is Map<String, dynamic>) {
      // Update the dashboard with new data
      setState(() {
        // Update widget data (you need to make widgets mutable or use state management)
        // Since widget properties are final, you need to rebuild the entire dashboard
        // Or better, use a state management solution

        // For now, show a snackbar and refresh the page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // You could navigate to a new dashboard with updated data
        _refreshDashboard(updatedData);
      });
    }
  }

  void _refreshDashboard(Map<String, dynamic> updatedData) {
    // Create a new HotelOwnerDashboard with updated data
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
          panNumber: '', // Add if you have this field
          aadharNumber: updatedData['aadharNumber'] ?? widget.aadharNumber,
          accountHolderName: updatedData['accountHolderName'] ?? widget.accountHolderName,
          bankName: updatedData['bankName'] ?? widget.bankName,
          accountNumber: updatedData['accountNumber'] ?? widget.accountNumber,
          ifscCode: updatedData['ifscCode'] ?? widget.ifscCode,
          branch: updatedData['branch'] ?? widget.branch,
          accountType: updatedData['accountType'] ?? widget.accountType,
          totalRooms: int.tryParse(updatedData['totalRooms']?.toString() ?? widget.totalRooms.toString()) ?? widget.totalRooms,
          personPhotoInfo: updatedData['personPhotoInfo'] ?? widget.personPhotoInfo,
          registrationData: updatedData,
        ),
      ),
    );
  }



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


//
// class HotelOwnerProfilePage extends StatefulWidget {
//   final String hotelName;
//   final String ownerName;
//   final String mobileNumber;
//   final String email;
//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final String district;
//   final String state;
//   final String pinCode;
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
//
//   final String aadharNumber;
//   final String accountHolderName;
//   final String bankName;
//   final String accountNumber;
//   final String ifscCode;
//   final String branch;
//   final String accountType;
//   final int totalRooms;
//   final Map<String, dynamic> personPhotoInfo;
//
//   // New fields for additional tabs
//   final String hotelType;
//   final String yearOfEstablishment;
//   final String website;
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
//   // Additional fields for Personal Details tab
//   final String alternateContact;
//   final List<String> landlineNumbers;
//   // Document and declaration fields for Bank & Documents tab
//   final Map<String, Map<String, dynamic>> uploadedFiles;
//   final String signatureName;
//   final String declarationName;
//   final DateTime? declarationDate;
//   final bool declarationAccepted;
//
//   const HotelOwnerProfilePage({
//     super.key,
//     required this.hotelName,
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.email,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.pinCode,
//     required this.gstNumber,
//     required this.fssaiLicense,
//     required this.tradeLicense,
//     // required this.panNumber,
//     required this.aadharNumber,
//     required this.accountHolderName,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifscCode,
//     required this.branch,
//     required this.accountType,
//     required this.totalRooms,
//     required this.personPhotoInfo,
//
//     // Initialize new fields
//     this.hotelType = '',
//     this.yearOfEstablishment = '',
//     this.website = '',
//     this.landmark = '',
//     required this.selectedRoomTypes,
//     required this.roomDetails,
//     this.minTariff = '',
//     this.maxTariff = '',
//     this.extraBedAvailable = false,
//     required this.basicAmenities,
//     required this.hotelFacilities,
//     required this.foodServices,
//     required this.additionalAmenities,
//     required this.customAmenities,
//     this.alternateContact = '',
//     this.landlineNumbers = const [],
//     this.uploadedFiles = const {},
//     this.signatureName = '',
//     this.declarationName = '',
//     this.declarationDate,
//     this.declarationAccepted = false,
//   });
//
//   @override
//   State<HotelOwnerProfilePage> createState() => _HotelOwnerProfilePageState();
// }
//
// class _HotelOwnerProfilePageState extends State<HotelOwnerProfilePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final List<String> _tabTitles = [
//     'Person details',
//     'Hotel details',
//     'Room Availability',
//     'Amenity details',
//     'Bank & Documents',
//   ];
//   final int _activeRooms = 5;
//   final double _occupancyRate = 84.0;
//   final double _rating = 4.8;
//
//   late int _availableRooms =
//       widget.totalRooms - _activeRooms;
//   late int _occupiedRooms = _activeRooms;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(length: 5, vsync: this);
//   }
//
//
//   int getAvailableRooms() {
//     int totalConfiguredRooms = 0;
//     widget.roomDetails.forEach((key, value) {
//       final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
//       totalConfiguredRooms += rooms;
//     });
//     return widget.totalRooms - totalConfiguredRooms;
//   }
//
//   int getOccupiedRooms() {
//     int totalConfiguredRooms = 0;
//     widget.roomDetails.forEach((key, value) {
//       final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
//       totalConfiguredRooms += rooms;
//     });
//     return totalConfiguredRooms;
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//
//   Widget _buildDefaultProfileImage() {
//     return Container(
//       color: Colors.white.withOpacity(0.2),
//       child: Image.network(
//         'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return Center(
//             child: Icon(Icons.person, color: Colors.white, size: 36),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Center(
//             child: Icon(Icons.person, color: Colors.white, size: 36),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.dark,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//
//               SliverAppBar(
//                 expandedHeight: 340,
//                 floating: false,
//                 pinned: true,
//                 backgroundColor: Colors.white,
//                 flexibleSpace: FlexibleSpaceBar(
//                   collapseMode: CollapseMode.pin,
//                   background: Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//
//                         Container(
//                           padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).padding.top + 10,
//                             left: 20,
//                             right: 20,
//                             bottom: 20,
//                           ),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
//                             ),
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(30),
//                               bottomRight: Radius.circular(30),
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               // **TOP BAR WITH BACK AND EDIT BUTTONS**
//                               Row(
//                                 children: [
//                                   // IconButton(
//                                   //   icon: Icon(Icons.arrow_back, color: Colors.white),
//                                   //   onPressed: () => Navigator.pop(context),
//                                   // ),
//                                   Spacer(),
//                                   // Container(
//                                   //   padding: EdgeInsets.symmetric(
//                                   //     horizontal: 12,
//                                   //     vertical: 6,
//                                   //   ),
//                                   //   decoration: BoxDecoration(
//                                   //     color: Colors.white.withOpacity(0.2),
//                                   //     borderRadius: BorderRadius.circular(20),
//                                   //   ),
//                                   //   child: Row(
//                                   //     children: [
//                                   //       Icon(
//                                   //         Icons.edit,
//                                   //         size: 14,
//                                   //         color: Colors.white,
//                                   //       ),
//                                   //       SizedBox(width: 6),
//                                   //       Text(
//                                   //         'Edit Profile',
//                                   //         style: TextStyle(
//                                   //           color: Colors.white,
//                                   //           fontSize: 12,
//                                   //           fontWeight: FontWeight.w500,
//                                   //         ),
//                                   //       ),
//                                   //     ],
//                                   //   ),
//                                   // ),
//
//                                   Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: GestureDetector(
//                                       onTap: () => _navigateToEditProfile(context),
//                                       child: Row(
//                                         children: [
//                                           Icon(Icons.edit, size: 14, color: Colors.white),
//                                           SizedBox(width: 6),
//                                           Text('Edit Profile', style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           )),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: 10),
//
//                               // **PROFILE AND HOTEL INFO**
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // **PROFILE PHOTO**
//                                   Container(
//                                     width: 80,
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 3,
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 10,
//                                         ),
//                                       ],
//                                     ),
//                                     child: ClipOval(
//                                       child:
//                                           widget.personPhotoInfo['uploaded'] ==
//                                               true
//                                           ? Image.network(
//                                               widget.personPhotoInfo['url'],
//                                               fit: BoxFit.cover,
//                                               errorBuilder:
//                                                   (context, error, stackTrace) {
//                                                     return _buildDefaultProfileImage();
//                                                   },
//                                             )
//                                           : _buildDefaultProfileImage(),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 16),
//
//                                   // **OWNER AND HOTEL DETAILS**
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // **OWNER NAME**
//                                         Text(
//                                           // widget.ownerName,
//                                           'John Alexandar',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//
//                                         SizedBox(height: 6),
//
//                                         // **HOTEL NAME**
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.hotel,
//                                               size: 18,
//                                               color: Colors.white.withOpacity(
//                                                 0.9,
//                                               ),
//                                             ),
//                                             SizedBox(width: 6),
//                                             Expanded(
//                                               child: Text(
//                                                 // widget.hotelName,
//                                                 'Raj Bhavan Hotel',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//                                         SizedBox(height: 12),
//
//                                         // **CONTACT INFO**
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.phone,
//                                               size: 16,
//                                               color: Colors.white,
//                                             ),
//                                             SizedBox(width: 6),
//                                             Text(
//                                               // widget.mobileNumber,
//                                               '99933366677',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             SizedBox(width: 10),
//                                             Icon(
//                                               Icons.email,
//                                               size: 16,
//                                               color: Colors.white,
//                                             ),
//                                             SizedBox(width: 6),
//                                             Expanded(
//                                               child: Text(
//                                                 // widget.email,
//                                                 'hotel@gmail.com',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 14,
//                                                 ),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               SizedBox(height: 20),
//
//                               // **STATS BOX**
//                               // Container(
//                               //   padding: EdgeInsets.all(16),
//                               //   decoration: BoxDecoration(
//                               //     color: Colors.white.withOpacity(0.15),
//                               //     borderRadius: BorderRadius.circular(20),
//                               //     border: Border.all(color: Colors.white.withOpacity(0.3)),
//                               //   ),
//                               //   child: Row(
//                               //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               //     children: [
//                               //       // **TOTAL ROOMS**
//                               //       _buildOverviewStat(
//                               //         value: widget.totalRooms.toString(),
//                               //         label: 'Total Rooms',
//                               //         icon: Icons.meeting_room,
//                               //       ),
//                               //
//                               //       // **ACTIVE ROOMS**
//                               //       _buildOverviewStat(
//                               //         value: _activeRooms.toString(),
//                               //         label: 'Active Now',
//                               //         icon: Icons.check_circle,
//                               //         color: Colors.white,
//                               //       ),
//                               //
//                               //       // **OCCUPANCY**
//                               //       _buildOverviewStat(
//                               //         value: '${_occupancyRate.toStringAsFixed(1)}%',
//                               //         label: 'Occupancy',
//                               //         icon: Icons.trending_up,
//                               //         color: Colors.white,
//                               //       ),
//                               //
//                               //       // **RATING**
//                               //       _buildOverviewStat(
//                               //         value: _rating.toStringAsFixed(1),
//                               //         label: 'Rating',
//                               //         icon: Icons.star,
//                               //         color: Colors.white,
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//
//                               // **STATS BOX**
//                               Container(
//                                 padding: EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     // **TOTAL ROOMS**
//                                     _buildOverviewStat(
//                                       value: widget.totalRooms.toString(),
//                                       label: 'Total Rooms',
//                                       icon: Icons.meeting_room,
//                                     ),
//
//                                     // **AVAILABLE ROOMS**
//                                     _buildOverviewStat(
//                                       value: _availableRooms
//                                           .toString(), // You need to calculate this
//                                       label: 'Available Rooms',
//                                       icon: Icons.hotel,
//                                       color: Colors.white,
//                                     ),
//
//                                     // **OCCUPIED ROOMS**
//                                     _buildOverviewStat(
//                                       value: _occupiedRooms
//                                           .toString(), // You need to calculate this
//                                       label: 'Occupied Rooms',
//                                       icon: Icons.people,
//                                       color: Colors.white,
//                                     ),
//
//                                     // **RATING**
//                                     _buildOverviewStat(
//                                       value: _rating.toStringAsFixed(1),
//                                       label: 'Rating',
//                                       icon: Icons.star,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // bottom: PreferredSize(
//                 //   preferredSize: Size.fromHeight(60),
//                 //   child: Container(
//                 //     color: Colors.white,
//                 //     child: TabBar(
//                 //       controller: _tabController,
//                 //       indicatorColor: Color(0xFF4F46E5),
//                 //       indicatorWeight: 3,
//                 //       labelColor: Color(0xFF4F46E5),
//                 //       unselectedLabelColor: Colors.grey[600],
//                 //       labelStyle: TextStyle(
//                 //         fontWeight: FontWeight.w600,
//                 //         fontSize: 14,
//                 //       ),
//                 //       // isScrollable: true, // Added to accommodate 5 tabs
//                 //       tabs: _tabTitles.map((title) {
//                 //         return Tab(
//                 //           child: Container(
//                 //             padding: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
//                 //             child: Text(title),
//                 //           ),
//                 //         );
//                 //       }).toList(),
//                 //     ),
//                 //   ),
//                 // ),
//                 bottom: PreferredSize(
//                   preferredSize: Size.fromHeight(60),
//                   child: Container(
//                     color: Colors.white,
//                     child: TabBar(
//                       controller: _tabController,
//                       indicatorColor: Color(0xFF4F46E5),
//                       indicatorWeight: 3,
//                       labelColor: Color(0xFF4F46E5),
//                       unselectedLabelColor: Colors.grey[600],
//                       labelStyle: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12, // Reduced from 14 to 12
//                       ),
//                       unselectedLabelStyle: TextStyle(
//                         fontWeight: FontWeight.normal,
//                         fontSize: 12, // Reduced from 14 to 12
//                       ),
//                       tabs: _tabTitles.map((title) {
//                         return Tab(
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 1,
//                               vertical: 7,
//                             ),
//                             child: Text(
//                               title,
//                               textAlign: TextAlign.center,
//                               maxLines: 5,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//           body: TabBarView(
//             controller: _tabController,
//             children: [
//               // Personal details Tab - updated with new fields
//               _PersonalDetailsTab(
//                 ownerName: widget.ownerName,
//                 mobileNumber: widget.mobileNumber,
//                 email: widget.email,
//                 aadharNumber: widget.aadharNumber,
//
//                 personPhotoInfo: widget.personPhotoInfo,
//                 alternateContact: widget.alternateContact,
//                 // landlineNumbers: widget.landlineNumbers,
//                 website: widget.website,
//               ),
//
//               // Hotel details Tab
//               _HotelDetailsTab(
//                 hotelName: widget.hotelName,
//                 addressLine1: widget.addressLine1,
//                 addressLine2: widget.addressLine2,
//                 city: widget.city,
//                 district: widget.district,
//                 state: widget.state,
//                 pinCode: widget.pinCode,
//                 totalRooms: widget.totalRooms,
//                 hotelType: widget.hotelType,
//                 yearOfEstablishment: widget.yearOfEstablishment,
//                 website: widget.website,
//                 landmark: widget.landmark,
//                 hotelEmail: '',
//                 hotelPhone: '',
//               ),
//
//               // Room Availability Tab
//               _RoomAvailabilityTab(
//                 selectedRoomTypes: widget.selectedRoomTypes,
//                 roomDetails: widget.roomDetails,
//                 minTariff: widget.minTariff,
//                 maxTariff: widget.maxTariff,
//                 extraBedAvailable: widget.extraBedAvailable,
//                 totalRooms: widget.totalRooms,
//               ),
//
//               // Amenities details Tab - updated with PAN number
//               _AmenitiesDetailsTab(
//                 basicAmenities: widget.basicAmenities,
//                 hotelFacilities: widget.hotelFacilities,
//                 foodServices: widget.foodServices,
//                 additionalAmenities: widget.additionalAmenities,
//                 customAmenities: widget.customAmenities,
//                 gstNumber: widget.gstNumber,
//                 fssaiLicense: widget.fssaiLicense,
//                 tradeLicense: widget.tradeLicense,
//                 aadharNumber: widget.aadharNumber,
//               ),
//
//               // Bank & Documents Tab - updated with all document fields
//               _BankAndDocumentsTab(
//                 accountHolderName: widget.accountHolderName,
//                 bankName: widget.bankName,
//                 accountNumber: widget.accountNumber,
//                 ifscCode: widget.ifscCode,
//                 branch: widget.branch,
//                 accountType: widget.accountType,
//                 gstNumber: widget.gstNumber,
//                 fssaiLicense: widget.fssaiLicense,
//                 tradeLicense: widget.tradeLicense,
//
//                 uploadedFiles: widget.uploadedFiles,
//                 signatureName: widget.signatureName,
//                 declarationName: widget.declarationName,
//                 declarationDate: widget.declarationDate,
//                 declarationAccepted: widget.declarationAccepted,
//               ),
//             ],
//           ),
//         ),
//       ),
//
//
//     );
//   }
//
//   // void _navigateToEditProfile(BuildContext context) async {
//   //   // Prepare registration data from current profile
//   //   Map<String, dynamic> registrationData = {
//   //     'hotelName': widget.hotelName,
//   //     'hotelType': widget.hotelType,
//   //     'yearOfEstablishment': widget.yearOfEstablishment,
//   //     'totalRooms': widget.totalRooms,
//   //     'ownerName': widget.ownerName,
//   //     'mobileNumber': widget.mobileNumber,
//   //     'alternateContact': widget.alternateContact,
//   //     'landlineNumbers': widget.landlineNumbers,
//   //     'email': widget.email,
//   //     'website': widget.website,
//   //     'addressLine1': widget.addressLine1,
//   //     'addressLine2': widget.addressLine2,
//   //     'city': widget.city,
//   //     'district': widget.district,
//   //     'state': widget.state,
//   //     'pinCode': widget.pinCode,
//   //     'landmark': widget.landmark,
//   //     'selectedRoomTypes': widget.selectedRoomTypes,
//   //     'roomDetails': widget.roomDetails,
//   //     'minTariff': widget.minTariff,
//   //     'maxTariff': widget.maxTariff,
//   //     'extraBedAvailable': widget.extraBedAvailable,
//   //     'basicAmenities': widget.basicAmenities,
//   //     'hotelFacilities': widget.hotelFacilities,
//   //     'foodServices': widget.foodServices,
//   //     'additionalAmenities': widget.additionalAmenities,
//   //     'customAmenities': widget.customAmenities,
//   //     'gstNumber': widget.gstNumber,
//   //     'fssaiLicense': widget.fssaiLicense,
//   //     'tradeLicense': widget.tradeLicense,
//   //     'aadharNumber': widget.aadharNumber,
//   //     'accountHolderName': widget.accountHolderName,
//   //     'bankName': widget.bankName,
//   //     'accountNumber': widget.accountNumber,
//   //     'ifscCode': widget.ifscCode,
//   //     'branch': widget.branch,
//   //     'accountType': widget.accountType,
//   //     'uploadedFiles': widget.uploadedFiles,
//   //     'signatureName': widget.signatureName,
//   //     'declarationName': widget.declarationName,
//   //     'declarationDate': widget.declarationDate,
//   //     'personPhotoInfo': widget.personPhotoInfo,
//   //     'declarationAccepted': widget.declarationAccepted,
//   //   };
//   //
//   //   final updatedData = await Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => EditHotelProfileScreen(
//   //         registrationData: registrationData,
//   //       ),
//   //     ),
//   //   );
//   //
//   //   if (updatedData != null) {
//   //     // Update the dashboard with new data
//   //     Navigator.pop(context); // Go back to dashboard
//   //     // You might want to refresh the dashboard here with updated data
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('Profile updated successfully!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //   }
//   // }
//
//   void _navigateToEditProfile(BuildContext context) async {
//     // Prepare registration data from current profile
//     Map<String, dynamic> registrationData = {
//       'hotelName': widget.hotelName,
//       'hotelType': widget.hotelType,
//       'yearOfEstablishment': widget.yearOfEstablishment,
//       'totalRooms': widget.totalRooms,
//       'ownerName': widget.ownerName,
//       'mobileNumber': widget.mobileNumber,
//       'alternateContact': widget.alternateContact,
//       'landlineNumbers': widget.landlineNumbers,
//       'email': widget.email,
//       'website': widget.website,
//       'addressLine1': widget.addressLine1,
//       'addressLine2': widget.addressLine2,
//       'city': widget.city,
//       'district': widget.district,
//       'state': widget.state,
//       'pinCode': widget.pinCode,
//       'landmark': widget.landmark,
//       'selectedRoomTypes': widget.selectedRoomTypes,
//       'roomDetails': widget.roomDetails,
//       'minTariff': widget.minTariff,
//       'maxTariff': widget.maxTariff,
//       'extraBedAvailable': widget.extraBedAvailable,
//       'basicAmenities': widget.basicAmenities,
//       'hotelFacilities': widget.hotelFacilities,
//       'foodServices': widget.foodServices,
//       'additionalAmenities': widget.additionalAmenities,
//       'customAmenities': widget.customAmenities,
//       'gstNumber': widget.gstNumber,
//       'fssaiLicense': widget.fssaiLicense,
//       'tradeLicense': widget.tradeLicense,
//       'aadharNumber': widget.aadharNumber,
//       'accountHolderName': widget.accountHolderName,
//       'bankName': widget.bankName,
//       'accountNumber': widget.accountNumber,
//       'ifscCode': widget.ifscCode,
//       'branch': widget.branch,
//       'accountType': widget.accountType,
//       'uploadedFiles': widget.uploadedFiles,
//       'signatureName': widget.signatureName,
//       'declarationName': widget.declarationName,
//       'declarationDate': widget.declarationDate,
//       'personPhotoInfo': widget.personPhotoInfo,
//       'declarationAccepted': widget.declarationAccepted,
//     };
//
//     final updatedData = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditHotelProfileScreen(
//           registrationData: registrationData,
//         ),
//       ),
//     );
//
//     if (updatedData != null && updatedData is Map<String, dynamic>) {
//       // Instead of popping, pass the updated data back to dashboard
//       Navigator.pop(context, updatedData);
//     }
//   }
//   Widget _buildOverviewStat({
//     required String value,
//     required String label,
//     required IconData icon,
//     Color color = Colors.white,
//   }) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 20, color: color),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             color: color,
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(color: color.withOpacity(0.9), fontSize: 11),
//         ),
//       ],
//     );
//   }
// }
//
// class _PersonalDetailsTab extends StatelessWidget {
//   final String ownerName;
//   final String mobileNumber;
//   final String email;
//   final String aadharNumber;
//   final Map<String, dynamic> personPhotoInfo;
//   final String alternateContact;
//
//   final String website;
//
//   const _PersonalDetailsTab({
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.email,
//     required this.aadharNumber,
//     required this.personPhotoInfo,
//     this.alternateContact = '',
//
//     this.website = '',
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ==================== SECTION 1: PROFILE DETAILS ====================
//           _buildSectionHeader('Profile Details'),
//           SizedBox(height: 16),
//           _buildProfileDetailsCard(),
//
//           SizedBox(height: 32),
//
//           // ==================== SECTION 2: IDENTITY CARDS ====================
//           _buildSectionHeader('Identity Cards'),
//           SizedBox(height: 16),
//           _buildIdentityCardsSection(),
//
//           SizedBox(height: 32),
//
//           // ==================== SECTION 3: PROFILE PHOTO UPLOAD ====================
//           _buildSectionHeader('Profile Photo'),
//           SizedBox(height: 16),
//           _buildProfilePhotoUploadCard(),
//
//           // if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty) ...[
//           SizedBox(height: 32),
//
//           // _buildAdditionalContactCard(),
//         ],
//         // ],
//       ),
//     );
//   }
//
//   // ==================== PROFILE DETAILS CARD ====================
//   Widget _buildProfileDetailsCard() {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 16,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Owner Name
//           _buildDetailRow(
//             icon: Icons.person_outline_rounded,
//             iconColor: Color(0xFF4F46E5),
//             label: 'Owner Name',
//             value: ownerName,
//             isPrimary: true,
//           ),
//
//           Divider(height: 32, color: Colors.grey[200]),
//
//           // Email Address
//           _buildDetailRow(
//             icon: Icons.email_outlined,
//             iconColor: Color(0xFFEA4335),
//             label: 'Email Address',
//             value: email,
//             isCopyable: true,
//           ),
//
//           Divider(height: 32, color: Colors.grey[200]),
//
//           // Phone Number
//           _buildDetailRow(
//             icon: Icons.phone_android,
//             iconColor: Color(0xFF34A853),
//             label: 'Phone Number',
//             value: mobileNumber,
//             isCopyable: true,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//     bool isPrimary = false,
//     bool isCopyable = false,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
//             ),
//             child: Icon(icon, size: 24, color: iconColor),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (isCopyable)
//             IconButton(
//               icon: Icon(
//                 Icons.content_copy,
//                 size: 20,
//                 color: Color(0xFF4F46E5),
//               ),
//               onPressed: () {},
//               // => _copyToClipboard(context, value),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== IDENTITY CARDS SECTION ====================
//   Widget _buildIdentityCardsSection() {
//     return Column(
//       children: [
//         // Aadhar Card
//         Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.06),
//                 blurRadius: 16,
//                 offset: Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       Icons.credit_card,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Aadhar Card',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                         Text(
//                           'UIDAI Verification',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: aadharNumber.isNotEmpty
//                           ? Color(0xFF4CAF50).withOpacity(0.1)
//                           : Colors.grey.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       aadharNumber.isNotEmpty ? 'Verified' : 'Not Verified',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: aadharNumber.isNotEmpty
//                             ? Color(0xFF4CAF50)
//                             : Colors.grey,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12),
//                   // border: Border.all(color: Colors.grey[200], width: 1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Aadhar Number',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       aadharNumber.isNotEmpty ? aadharNumber : 'Not provided',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: aadharNumber.isNotEmpty
//                             ? Colors.grey[800]
//                             : Colors.grey[400],
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // Add other identity cards here (PAN, Driving License, etc.)
//         SizedBox(height: 16),
//         // Container(
//         //   padding: EdgeInsets.all(20),
//         //   decoration: BoxDecoration(
//         //     color: Colors.white,
//         //     borderRadius: BorderRadius.circular(16),
//         //     // border: Border.all(color: Colors.grey[200], width: 1),
//         //   ),
//         //   child: Row(
//         //     children: [
//         //       Container(
//         //         width: 50,
//         //         height: 50,
//         //         decoration: BoxDecoration(
//         //           color: Color(0xFFF59E0B).withOpacity(0.1),
//         //           borderRadius: BorderRadius.circular(10),
//         //         ),
//         //         child: Icon(Icons.add, color: Color(0xFFF59E0B), size: 24),
//         //       ),
//         //       SizedBox(width: 16),
//         //       Expanded(
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             Text(
//         //               'Add Another Identity Card',
//         //               style: TextStyle(
//         //                 fontSize: 15,
//         //                 fontWeight: FontWeight.w600,
//         //                 color: Colors.grey[800],
//         //               ),
//         //             ),
//         //             SizedBox(height: 4),
//         //             Text(
//         //               'PAN, Driving License, etc.',
//         //               style: TextStyle(
//         //                 fontSize: 13,
//         //                 color: Colors.grey[500],
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   // ==================== PROFILE PHOTO UPLOAD CARD ====================
//   Widget _buildProfilePhotoUploadCard() {
//     final isUploaded = personPhotoInfo['uploaded'] as bool? ?? false;
//     final fileName = personPhotoInfo['name'] as String? ?? '';
//     final filePath = personPhotoInfo['path'] as String?;
//
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 16,
//             offset: Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Photo Preview
//           // Container(
//           //   width: 50,
//           //   height: 50,
//           //   decoration: BoxDecoration(
//           //     color: isUploaded && filePath != null
//           //         ? Colors.transparent
//           //         : Color(0xFF4F46E5).withOpacity(0.05),
//           //     borderRadius: BorderRadius.circular(20),
//           //     border: Border.all(
//           //       color: isUploaded && filePath != null
//           //           ? Colors.transparent
//           //           : Color(0xFF4F46E5).withOpacity(0.2),
//           //       width: 2,
//           //     ),
//           //     boxShadow: isUploaded && filePath != null
//           //         ? [
//           //       BoxShadow(
//           //         color: Colors.black.withOpacity(0.1),
//           //         blurRadius: 12,
//           //         offset: Offset(0, 4),
//           //       ),
//           //     ]
//           //         : null,
//           //   ),
//           //   child: isUploaded && filePath != null
//           //       ? ClipRRect(
//           //     borderRadius: BorderRadius.circular(18),
//           //     child: Image.file(
//           //       File(filePath),
//           //       fit: BoxFit.cover,
//           //       width: 120,
//           //       height: 120,
//           //     ),
//           //   )
//           //       : Center(
//           //     child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       children: [
//           //         Icon(
//           //           Icons.person,
//           //           size: 40,
//           //           color: Color(0xFF4F46E5).withOpacity(0.5),
//           //         ),
//           //         SizedBox(height: 8),
//           //         Text(
//           //           'No Photo',
//           //           style: TextStyle(
//           //             fontSize: 12,
//           //             color: Colors.grey[500],
//           //             fontWeight: FontWeight.w500,
//           //           ),
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           SizedBox(height: 10),
//
//           // Upload Status
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: isUploaded
//                   ? Color(0xFF4CAF50).withOpacity(0.1)
//                   : Colors.orange.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   isUploaded ? Icons.check_circle : Icons.pending,
//                   size: 18,
//                   color: isUploaded ? Color(0xFF4CAF50) : Color(0xFFF59E0B),
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   isUploaded
//                       ? 'Photo Uploaded Successfully'
//                       : 'Photo Pending Upload',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: isUploaded ? Color(0xFF4CAF50) : Color(0xFFF59E0B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // if (isUploaded && fileName.isNotEmpty) ...[
//           //   SizedBox(height: 16),
//           //   Container(
//           //     width: double.infinity,
//           //     padding: EdgeInsets.all(16),
//           //     decoration: BoxDecoration(
//           //       color: Colors.grey[50],
//           //       borderRadius: BorderRadius.circular(12),
//           //       // border: Border.all(color: Colors.grey[200], width: 1),
//           //     ),
//           //     child: Column(
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       children: [
//           //         Text(
//           //           'Uploaded File',
//           //           style: TextStyle(
//           //             fontSize: 13,
//           //             color: Colors.grey[600],
//           //             fontWeight: FontWeight.w500,
//           //           ),
//           //         ),
//           //         SizedBox(height: 8),
//           //         Row(
//           //           children: [
//           //             Icon(Icons.photo, size: 18, color: Color(0xFF4F46E5)),
//           //             SizedBox(width: 10),
//           //             Expanded(
//           //               child: Text(
//           //                 fileName,
//           //                 style: TextStyle(
//           //                   fontSize: 14,
//           //                   color: Colors.grey[800],
//           //                   fontWeight: FontWeight.w500,
//           //                 ),
//           //                 overflow: TextOverflow.ellipsis,
//           //               ),
//           //             ),
//           //             IconButton(
//           //               icon: Icon(Icons.visibility, size: 18, color: Color(0xFF4F46E5)),
//           //               onPressed: () {
//           //                 // View photo functionality
//           //               },
//           //             ),
//           //           ],
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ],
//           SizedBox(height: 20),
//
//           // Upload Button
//           // ElevatedButton(
//           //   onPressed: () {
//           //     // Trigger photo upload functionality
//           //   },
//           //   style: ElevatedButton.styleFrom(
//           //     backgroundColor: Color(0xFF4F46E5),
//           //     foregroundColor: Colors.white,
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(12),
//           //     ),
//           //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           //   ),
//           //   child: Row(
//           //     mainAxisSize: MainAxisSize.min,
//           //     children: [
//           //       Icon(Icons.cloud_upload, size: 20),
//           //       SizedBox(width: 10),
//           //       Text(
//           //         isUploaded ? 'Change Photo' : 'Upload Photo',
//           //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== ADDITIONAL CONTACTS ====================
//   // Widget _buildAdditionalContactCard() {
//   //   return Container(
//   //     padding: EdgeInsets.all(24),
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(16),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black.withOpacity(0.06),
//   //           blurRadius: 16,
//   //           offset: Offset(0, 6),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Column(
//   //       children: [
//   //         if (alternateContact.isNotEmpty)
//   //           _buildAdditionalContactRow(
//   //             icon: Icons.phone_iphone,
//   //             label: 'Alternate Contact',
//   //             value: alternateContact,
//   //             iconColor: Color(0xFFF59E0B),
//   //           ),
//   //
//   //         if (landlineNumbers.isNotEmpty) ...[
//   //           if (alternateContact.isNotEmpty) Divider(height: 24, color: Colors.grey[200]),
//   //           _buildLandlineSection(),
//   //         ],
//   //
//   //         if (website.isNotEmpty) ...[
//   //           if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty)
//   //             Divider(height: 24, color: Colors.grey[200]),
//   //           _buildAdditionalContactRow(
//   //             icon: Icons.language,
//   //             label: 'Website',
//   //             value: website,
//   //             iconColor: Color(0xFF4F46E5),
//   //             isWebsite: true,
//   //           ),
//   //         ],
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildAdditionalContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//     bool isWebsite = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: iconColor.withOpacity(0.2), width: 1.5),
//             ),
//             child: Icon(icon, size: 22, color: iconColor),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 GestureDetector(
//                   onTap: isWebsite ? () {} : null,
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: isWebsite ? Colors.blue[600] : Colors.grey[800],
//                       decoration: isWebsite
//                           ? TextDecoration.underline
//                           : TextDecoration.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.content_copy, size: 20, color: Color(0xFF4F46E5)),
//             onPressed: () {},
//             // => _copyToClipboard(context, value),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget _buildLandlineSection() {
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(vertical: 12),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Container(
//   //               width: 48,
//   //               height: 48,
//   //               decoration: BoxDecoration(
//   //                 color: Color(0xFF4F46E5).withOpacity(0.1),
//   //                 borderRadius: BorderRadius.circular(12),
//   //                 border: Border.all(color: Color(0xFF4F46E5).withOpacity(0.2), width: 1.5),
//   //               ),
//   //               child: Icon(Icons.phone_in_talk, size: 22, color: Color(0xFF4F46E5)),
//   //             ),
//   //             SizedBox(width: 16),
//   //             Expanded(
//   //               child: Text(
//   //                 'Landline Numbers',
//   //                 style: TextStyle(
//   //                   fontSize: 15,
//   //                   fontWeight: FontWeight.w600,
//   //                   color: Colors.grey[800],
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 12),
//   //         ...landlineNumbers.asMap().entries.map((entry) {
//   //           int index = entry.key;
//   //           String number = entry.value;
//   //           return Padding(
//   //             padding: EdgeInsets.symmetric(vertical: 8),
//   //             child: Row(
//   //               children: [
//   //                 Container(
//   //                   width: 32,
//   //                   height: 32,
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.grey[100],
//   //                     borderRadius: BorderRadius.circular(8),
//   //                   ),
//   //                   alignment: Alignment.center,
//   //                   child: Text(
//   //                     '${index + 1}',
//   //                     style: TextStyle(
//   //                       fontSize: 12,
//   //                       fontWeight: FontWeight.w600,
//   //                       color: Colors.grey[600],
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 SizedBox(width: 12),
//   //                 Expanded(
//   //                   child: Text(
//   //                     number,
//   //                     style: TextStyle(
//   //                       fontSize: 15,
//   //                       fontWeight: FontWeight.w500,
//   //                       color: Colors.grey[800],
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 IconButton(
//   //                   icon: Icon(Icons.phone, size: 20, color: Color(0xFF34A853)),
//   //                   onPressed: () {
//   //                     // Make call functionality
//   //                   },
//   //                 ),
//   //                 IconButton(
//   //                   icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
//   //                   onPressed: () {},
//   //                   // => _copyToClipboard(context, number),
//   //                 ),
//   //               ],
//   //             ),
//   //           );
//   //         }).toList(),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   // ==================== HELPER METHODS ====================
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 22,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
//             letterSpacing: -0.5,
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _copyToClipboard(BuildContext context, String text) {
//     // Uncomment when you have clipboard functionality
//     // Clipboard.setData(ClipboardData(text: text));
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   SnackBar(
//     //     content: Text('Copied to clipboard'),
//     //     duration: Duration(seconds: 1),
//     //   ),
//     // );
//     print('Copied to clipboard: $text');
//   }
// }
//
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
//   final String hotelEmail;
//   final String hotelPhone;
//   final String alternatePhone;
//   final List<String> additionalContacts;
//   final double? latitude;
//   final double? longitude;
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
//     required this.hotelEmail,
//     required this.hotelPhone,
//     this.alternatePhone = '',
//     this.additionalContacts = const [],
//     this.latitude,
//     this.longitude,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // ==================== HOTEL INFORMATION ====================
//           _buildSectionHeader('Hotel Information'),
//           SizedBox(height: 12),
//           _buildHotelInfoCard(),
//
//           SizedBox(height: 24),
//
//           // ==================== CONTACT DETAILS ====================
//           _buildSectionHeader('Contact Details'),
//           SizedBox(height: 12),
//           _buildContactCard(),
//
//           SizedBox(height: 24),
//
//           // ==================== ADDRESS DETAILS ====================
//           _buildSectionHeader('Address Details'),
//           SizedBox(height: 12),
//           _buildAddressCard(),
//
//           // ==================== MAP SECTION ====================
//           if (latitude != null && longitude != null) ...[
//             SizedBox(height: 24),
//             _buildSectionHeader('Location'),
//             SizedBox(height: 12),
//             _buildMapCard(),
//           ],
//
//           SizedBox(height: 24),
//
//           // ==================== LANDMARK ====================
//           _buildSectionHeader('Landmark'),
//           SizedBox(height: 12),
//           _buildLandmarkCard(),
//
//           SizedBox(height: 24),
//
//           // ==================== WEBSITE ====================
//           _buildSectionHeader('Website'),
//           SizedBox(height: 12),
//           _buildWebsiteCard(),
//
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   // ==================== HOTEL INFORMATION CARD ====================
//   Widget _buildHotelInfoCard() {
//     return Container(
//       padding: EdgeInsets.all(24),
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
//           // Hotel Name
//           _buildInfoRow(
//             icon: Icons.business,
//             label: 'Hotel Name',
//             value: hotelName,
//             iconColor: Color(0xFF4F46E5),
//           ),
//           Divider(height: 20),
//
//           // Hotel Type
//           _buildInfoRow(
//             icon: Icons.star,
//             label: 'Hotel Type',
//             value: hotelType.isNotEmpty ? hotelType : 'Not specified',
//             iconColor: Color(0xFFF59E0B),
//           ),
//           Divider(height: 20),
//
//           // Year of Establishment
//           _buildInfoRow(
//             icon: Icons.calendar_today,
//             label: 'Year Established',
//             value: yearOfEstablishment.isNotEmpty
//                 ? yearOfEstablishment
//                 : 'Not specified',
//             iconColor: Color(0xFF10B981),
//           ),
//           Divider(height: 20),
//
//           // Total Rooms
//           _buildInfoRow(
//             icon: Icons.hotel,
//             label: 'Total Rooms',
//             value: '$totalRooms Rooms',
//             iconColor: Color(0xFFEF4444),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== CONTACT CARD ====================
//   Widget _buildContactCard() {
//     return Container(
//       padding: EdgeInsets.all(24),
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
//           // Hotel Email
//           _buildContactRow(
//             icon: Icons.email_outlined,
//             label: 'Hotel Email',
//             value: hotelEmail,
//             iconColor: Color(0xFFEA4335),
//             isEmail: true,
//           ),
//           Divider(height: 20),
//
//           // Primary Phone
//           _buildContactRow(
//             icon: Icons.phone,
//             label: 'Primary Phone',
//             value: hotelPhone,
//             iconColor: Color(0xFF34A853),
//             isPhone: true,
//           ),
//
//           // Alternate Phone
//           if (alternatePhone.isNotEmpty) ...[
//             Divider(height: 20),
//             _buildContactRow(
//               icon: Icons.phone_iphone,
//               label: 'Alternate Phone',
//               value: alternatePhone,
//               iconColor: Color(0xFF4285F4),
//               isPhone: true,
//             ),
//           ],
//
//           // Additional Contacts
//           if (additionalContacts.isNotEmpty) ...[
//             Divider(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.contacts, color: Color(0xFF8B5CF6), size: 20),
//                     SizedBox(width: 12),
//                     Text(
//                       'Additional Contacts',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 ...additionalContacts.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   String contact = entry.value;
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 8),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 28,
//                           height: 28,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             '${index + 1}',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             contact,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.phone,
//                             size: 18,
//                             color: Color(0xFF34A853),
//                           ),
//                           onPressed: () => _makePhoneCall(contact),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildAddressCard() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Address lines
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xFFF8FAFC),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.home, size: 20, color: Color(0xFF4F46E5)),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Address Line 1',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             addressLine1,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 if (addressLine2.isNotEmpty) ...[
//                   SizedBox(height: 12),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(Icons.home_work, size: 20, color: Color(0xFF4F46E5)),
//                       SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Address Line 2',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               addressLine2,
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//
//           SizedBox(height: 16),
//
//           // Location chips - horizontal scrollable
//           SizedBox(
//             height: 130,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 SizedBox(width: 4),
//                 _buildLocationChip(
//                   icon: Icons.location_city,
//                   title: 'City',
//                   value: city,
//                   color: Color(0xFF4F46E5),
//                 ),
//                 SizedBox(width: 12),
//                 _buildLocationChip(
//                   icon: Icons.map,
//                   title: 'District',
//                   value: district,
//                   color: Color(0xFF10B981),
//                 ),
//                 SizedBox(width: 12),
//                 _buildLocationChip(
//                   icon: Icons.flag,
//                   title: 'State',
//                   value: state,
//                   color: Color(0xFFF59E0B),
//                 ),
//                 SizedBox(width: 12),
//                 _buildLocationChip(
//                   icon: Icons.numbers,
//                   title: 'PIN Code',
//                   value: pinCode,
//                   color: Color(0xFFEF4444),
//                 ),
//                 SizedBox(width: 4),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLocationChip({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//   }) {
//     return Container(
//       width: 100,
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, size: 18, color: color),
//           ),
//           SizedBox(height: 8),
//           Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
//           SizedBox(height: 4),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMapCard() {
//     return Container(
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
//           // Map Placeholder
//           Container(
//             height: 200,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Stack(
//               children: [
//                 // Map View (Replace with actual map widget)
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.map, size: 50, color: Colors.grey[400]),
//                       SizedBox(height: 12),
//                       Text(
//                         'Map View',
//                         style: TextStyle(
//                           color: Colors.grey[500],
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Coordinates: ${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}',
//                         style: TextStyle(color: Colors.grey[400], fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Map Controls
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 4,
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.open_in_full,
//                         size: 20,
//                         color: Color(0xFF4F46E5),
//                       ),
//                       onPressed: () {
//                         // Open full map
//                         _openInMaps();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Map Actions
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(16),
//                 bottomRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () => _getDirections(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF4F46E5),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     icon: Icon(Icons.directions, size: 20),
//                     label: Text('Get Directions'),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () => _shareLocation(),
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Color(0xFF4F46E5)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     icon: Icon(Icons.share, size: 20, color: Color(0xFF4F46E5)),
//                     label: Text(
//                       'Share Location',
//                       style: TextStyle(color: Color(0xFF4F46E5)),
//                     ),
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
//   // ==================== LANDMARK CARD ====================
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
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: Color(0xFF10B981).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Color(0xFF10B981).withOpacity(0.2),
//                 width: 1.5,
//               ),
//             ),
//             child: Icon(Icons.place, color: Color(0xFF10B981), size: 24),
//           ),
//           SizedBox(width: 16),
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
//                 SizedBox(height: 6),
//                 Text(
//                   landmark.isNotEmpty ? landmark : 'Not specified',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                     color: landmark.isNotEmpty
//                         ? Colors.grey[800]
//                         : Colors.grey[400],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (landmark.isNotEmpty)
//             IconButton(
//               icon: Icon(Icons.directions, color: Color(0xFF4F46E5)),
//               onPressed: () => _searchLandmark(),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== WEBSITE CARD ====================
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
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: Color(0xFF4F46E5).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: Color(0xFF4F46E5).withOpacity(0.2),
//                 width: 1.5,
//               ),
//             ),
//             child: Icon(Icons.language, color: Color(0xFF4F46E5), size: 24),
//           ),
//           SizedBox(width: 16),
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
//                 SizedBox(height: 6),
//                 GestureDetector(
//                   onTap: website.isNotEmpty
//                       ? () => _launchWebsite(website)
//                       : null,
//                   child: Text(
//                     website.isNotEmpty ? website : 'Not provided',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: website.isNotEmpty
//                           ? Colors.blue[600]
//                           : Colors.grey[400],
//                       decoration: website.isNotEmpty
//                           ? TextDecoration.underline
//                           : TextDecoration.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (website.isNotEmpty)
//             IconButton(
//               icon: Icon(Icons.open_in_new, color: Color(0xFF4F46E5)),
//               onPressed: () => _launchWebsite(website),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== HELPER WIDGETS ====================
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: iconColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, size: 20, color: iconColor),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
//
//   Widget _buildContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color iconColor,
//     bool isEmail = false,
//     bool isPhone = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
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
//                   fontSize: 13,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 4),
//               GestureDetector(
//                 onTap: () {
//                   if (isEmail) _sendEmail(value);
//                   if (isPhone) _makePhoneCall(value);
//                 },
//                 child: Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: isEmail
//                         ? Color(0xFFEA4335)
//                         : isPhone
//                         ? Color(0xFF34A853)
//                         : Colors.grey[800],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.content_copy, size: 20, color: Color(0xFF4F46E5)),
//           onPressed: () => _copyToClipboard(value),
//         ),
//       ],
//     );
//   }
//
//   // ==================== ACTION METHODS ====================
//   void _copyToClipboard(String text) {
//     // Clipboard.setData(ClipboardData(text: text));
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   SnackBar(content: Text('Copied to clipboard')),
//     // );
//     print('Copied: $text');
//   }
//
//   Future<void> _launchWebsite(String url) async {
//     if (!url.startsWith('http')) {
//       url = 'https://$url';
//     }
//     if (await canLaunch(url)) {
//       await launch(url);
//     }
//   }
//
//   void _makePhoneCall(String phoneNumber) {
//     // final url = 'tel:$phoneNumber';
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     // }
//     print('Calling: $phoneNumber');
//   }
//
//   void _sendEmail(String email) {
//     // final url = 'mailto:$email';
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     // }
//     print('Email: $email');
//   }
//
//   void _openInMaps() {
//     if (latitude != null && longitude != null) {
//       final url = 'https://www.google.com/maps?q=$latitude,$longitude';
//       // if (await canLaunch(url)) {
//       //   await launch(url);
//       // }
//       print('Opening maps: $url');
//     }
//   }
//
//   void _getDirections() {
//     if (latitude != null && longitude != null) {
//       final url =
//           'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
//       // if (await canLaunch(url)) {
//       //   await launch(url);
//       // }
//       print('Getting directions');
//     }
//   }
//
//   void _shareLocation() {
//     if (latitude != null && longitude != null) {
//       final message =
//           'Hotel Location: $hotelName\nCoordinates: $latitude,$longitude\nAddress: $addressLine1, $city';
//       print('Share location: $message');
//     }
//   }
//
//   void _searchLandmark() {
//     final query = Uri.encodeComponent('$landmark near $addressLine1 $city');
//     final url = 'https://www.google.com/maps/search/?api=1&query=$query';
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     // }
//     print('Searching landmark: $landmark');
//   }
// }
//
// class _AmenitiesDetailsTab extends StatelessWidget {
//   final Map<String, bool> basicAmenities;
//   final Map<String, bool> hotelFacilities;
//   final Map<String, bool> foodServices;
//   final Map<String, bool> additionalAmenities;
//   final List<String> customAmenities;
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
//   final String aadharNumber; // Added PAN number
//
//   const _AmenitiesDetailsTab({
//     required this.basicAmenities,
//     required this.hotelFacilities,
//     required this.foodServices,
//     required this.additionalAmenities,
//     required this.customAmenities,
//     required this.gstNumber,
//     required this.fssaiLicense,
//     required this.tradeLicense,
//     required this.aadharNumber, // Added parameter
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionHeader('Basic Amenities'),
//           SizedBox(height: 12),
//           _buildAmenitiesGrid(basicAmenities),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Hotel Facilities'),
//           SizedBox(height: 12),
//           _buildAmenitiesGrid(hotelFacilities),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Food & Services'),
//           SizedBox(height: 12),
//           _buildAmenitiesGrid(foodServices),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Additional Amenities'),
//           SizedBox(height: 12),
//           _buildAmenitiesGrid(additionalAmenities),
//
//           if (customAmenities.isNotEmpty) ...[
//             SizedBox(height: 20),
//             _buildSectionHeader('Custom Amenities'),
//             SizedBox(height: 12),
//             _buildCustomAmenitiesCard(),
//           ],
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Legal Documents'),
//           SizedBox(height: 12),
//           _buildLegalDocumentsCard(),
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
//               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
//   Widget _buildAmenitiesGrid(Map<String, bool> amenities) {
//     final availableAmenities = amenities.entries
//         .where((entry) => entry.value)
//         .map((entry) => entry.key)
//         .toList();
//
//     if (availableAmenities.isEmpty) {
//       return _buildEmptyAmenitiesCard();
//     }
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
//       child: Wrap(
//         spacing: 12,
//         runSpacing: 12,
//         children: availableAmenities.map((amenity) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               color: Color(0xFF4F46E5).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.check_circle, size: 16, color: Color(0xFF4F46E5)),
//                 SizedBox(width: 6),
//                 Text(
//                   amenity,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFF4F46E5),
//                     fontWeight: FontWeight.w500,
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
//   Widget _buildEmptyAmenitiesCard() {
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
//           Icon(Icons.info_outline, color: Colors.grey[400], size: 24),
//           SizedBox(width: 12),
//           Text(
//             'No amenities selected',
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCustomAmenitiesCard() {
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
//       child: Wrap(
//         spacing: 12,
//         runSpacing: 12,
//         children: customAmenities.map((amenity) {
//           return Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.star, size: 16, color: Colors.white),
//                 SizedBox(width: 6),
//                 Text(
//                   amenity,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
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
//   Widget _buildLegalDocumentsCard() {
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
//           _buildLegalDocRow('GST Number', gstNumber),
//           Divider(height: 20),
//           _buildLegalDocRow('FSSAI License', fssaiLicense),
//           Divider(height: 20),
//           _buildLegalDocRow('Trade License', tradeLicense),
//           Divider(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLegalDocRow(String label, String value) {
//     final hasValue = value.isNotEmpty;
//
//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: hasValue
//                 ? Color(0xFF4CAF50).withOpacity(0.1)
//                 : Colors.grey.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             hasValue ? Icons.verified : Icons.info_outline,
//             size: 18,
//             color: hasValue ? Color(0xFF4CAF50) : Colors.grey,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 hasValue ? value : 'Not provided',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: hasValue ? Colors.grey[700] : Colors.grey[500],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//           decoration: BoxDecoration(
//             color: hasValue
//                 ? Color(0xFF4CAF50).withOpacity(0.1)
//                 : Colors.grey.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             hasValue ? 'Verified' : 'Not Set',
//             style: TextStyle(
//               fontSize: 11,
//               color: hasValue ? Color(0xFF4CAF50) : Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
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
//     int totalOccupancy = 0;
//     double totalRevenue = 0;
//
//     // Calculate totals
//     roomDetails.forEach((key, value) {
//       final rooms = int.tryParse(value['rooms']?.toString() ?? '0') ?? 0;
//       final occupancy =
//           int.tryParse(value['occupancy']?.toString() ?? '0') ?? 0;
//       final price = double.tryParse(value['price']?.toString() ?? '0') ?? 0;
//
//       totalConfiguredRooms += rooms;
//       totalOccupancy += rooms * occupancy;
//       totalRevenue += rooms * price;
//     });
//
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ==================== HOTEL SUMMARY SECTION ====================
//           // _buildSectionHeader('Hotel Summary'),
//           // SizedBox(height: 16),
//           // _buildHotelSummaryCard(totalConfiguredRooms, totalOccupancy, totalRevenue),
//           SizedBox(height: 32),
//
//           // ==================== ROOM TYPES DETAILS SECTION ====================
//           _buildSectionHeader('Room Types & Availability'),
//           SizedBox(height: 16),
//
//           if (availableRoomTypes.isEmpty)
//             _buildNoRoomsCard()
//           else ...[
//             Text(
//               '${availableRoomTypes.length} Room Type${availableRoomTypes.length > 1 ? 's' : ''} Available',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 12),
//             ...availableRoomTypes.map((roomType) {
//               return Container(
//                 margin: EdgeInsets.only(bottom: 20),
//                 child: _buildRoomTypeDetailCard(roomType),
//               );
//             }).toList(),
//           ],
//
//           SizedBox(height: 32),
//
//           // ==================== PRICE RANGE SECTION ====================
//           _buildSectionHeader('Price Range'),
//           SizedBox(height: 16),
//           _buildPriceRangeCard(),
//
//           SizedBox(height: 32),
//
//           // ==================== EXTRA BED FACILITY ====================
//           _buildSectionHeader('Additional Facilities'),
//           SizedBox(height: 16),
//           _buildExtraBedCard(),
//
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
//
//   // ==================== HOTEL SUMMARY CARD ====================
//   Widget _buildHotelSummaryCard(
//     int configuredRooms,
//     int totalOccupancy,
//     double totalRevenue,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildHotelSummaryItem(
//                 value: totalRooms.toString(),
//                 label: 'Total Rooms',
//                 color: Color(0xFF4F46E5),
//                 icon: Icons.hotel,
//               ),
//               Container(width: 1, height: 40, color: Colors.grey[200]),
//               _buildHotelSummaryItem(
//                 value: configuredRooms.toString(),
//                 label: 'Configured',
//                 color: Color(0xFF4CAF50),
//                 icon: Icons.done_all,
//               ),
//               Container(width: 1, height: 40, color: Colors.grey[200]),
//               _buildHotelSummaryItem(
//                 value: selectedRoomTypes.entries
//                     .where((e) => e.value)
//                     .length
//                     .toString(),
//                 label: 'Room Types',
//                 color: Color(0xFF2196F3),
//                 icon: Icons.category,
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Divider(height: 1, color: Colors.grey[200]),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildHotelSummaryItem(
//                 value: totalOccupancy.toString(),
//                 label: 'Total Occupancy',
//                 color: Color(0xFFF59E0B),
//                 icon: Icons.people,
//               ),
//               Container(width: 1, height: 40, color: Colors.grey[200]),
//               _buildHotelSummaryItem(
//                 value: '₹${totalRevenue.toInt()}',
//                 label: 'Daily Revenue',
//                 color: Color(0xFF10B981),
//                 icon: Icons.attach_money,
//               ),
//               Container(width: 1, height: 40, color: Colors.grey[200]),
//               _buildHotelSummaryItem(
//                 value: totalRooms > 0
//                     ? '${((configuredRooms / totalRooms) * 100).toStringAsFixed(0)}%'
//                     : '0%',
//                 label: 'Utilization',
//                 color: Color(0xFF8B5CF6),
//                 icon: Icons.percent,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHotelSummaryItem({
//     required String value,
//     required String label,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               shape: BoxShape.circle,
//               border: Border.all(color: color.withOpacity(0.3), width: 1),
//             ),
//             child: Icon(icon, color: color, size: 22),
//           ),
//           SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: color,
//               letterSpacing: -0.5,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0.3,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== PRICE RANGE CARD ====================
//   Widget _buildPriceRangeCard() {
//     final hasMinPrice = minTariff.isNotEmpty && minTariff != '0';
//     final hasMaxPrice = maxTariff.isNotEmpty && maxTariff != '0';
//
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF4CAF50), Color(0xFF10B981)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.attach_money_rounded,
//                   color: Colors.white,
//                   size: 26,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Price Range per Day',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'All room types inclusive',
//                       style: TextStyle(fontSize: 13, color: Colors.grey[500]),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildPriceDetailCard(
//                 label: 'Minimum Tariff',
//                 value: hasMinPrice ? '₹$minTariff' : 'Not Set',
//                 icon: Icons.arrow_downward,
//                 color: Color(0xFF10B981),
//               ),
//               _buildPriceDetailCard(
//                 label: 'Maximum Tariff',
//                 value: hasMaxPrice ? '₹$maxTariff' : 'Not Set',
//                 icon: Icons.arrow_upward,
//                 color: Color(0xFFEF4444),
//               ),
//             ],
//           ),
//           if (hasMinPrice && hasMaxPrice) ...[
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.blue[100]!),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.info, size: 18, color: Colors.blue[600]),
//                   SizedBox(width: 8),
//                   Text(
//                     'Price range: ₹$minTariff - ₹$maxTariff',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.blue[700],
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPriceDetailCard({
//     required String label,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey[200]!),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.03),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 18, color: color),
//                 SizedBox(width: 6),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//                 color: value.contains('Not Set') ? Colors.grey[400] : color,
//                 letterSpacing: -0.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ==================== ROOM TYPE DETAIL CARD ====================
//   Widget _buildRoomTypeDetailCard(String roomType) {
//     final details = roomDetails[roomType] ?? {};
//     final rooms = int.tryParse(details['rooms']?.toString() ?? '0') ?? 0;
//     final occupancy =
//         int.tryParse(details['occupancy']?.toString() ?? '0') ?? 0;
//     final price = double.tryParse(details['price']?.toString() ?? '0') ?? 0;
//     final isAC = details['ac'] ?? true;
//     final extraBed = details['extraBed'] ?? false;
//     final extraBedPrice =
//         double.tryParse(details['extraBedPrice']?.toString() ?? '0') ?? 0;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Room Type Header
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey[200]!, width: 1),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: isAC
//                         ? Color(0xFF2196F3).withOpacity(0.1)
//                         : Color(0xFFF59E0B).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: isAC
//                           ? Color(0xFF2196F3).withOpacity(0.3)
//                           : Color(0xFFF59E0B).withOpacity(0.3),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: Icon(
//                     isAC ? Icons.maps_home_work_outlined : Icons.air,
//                     color: isAC ? Color(0xFF2196F3) : Color(0xFFF59E0B),
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         roomType,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: isAC
//                                   ? Color(0xFF2196F3).withOpacity(0.1)
//                                   : Color(0xFFF59E0B).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               isAC ? 'Air Conditioned' : 'Non-AC',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: isAC
//                                     ? Color(0xFF2196F3)
//                                     : Color(0xFFF59E0B),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '₹$price',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xFF4F46E5),
//                       ),
//                     ),
//                     Text(
//                       'per day',
//                       style: TextStyle(fontSize: 11, color: Colors.grey[500]),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // Room Details
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Availability Section - Simplified
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.grey[200]!, width: 1),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Rooms Available
//                       _buildRoomDetailItem(
//                         icon: Icons.meeting_room,
//                         title: 'Rooms Available',
//                         value: '$rooms',
//                         subtitle: 'Total',
//                         color: Color(0xFF4F46E5),
//                       ),
//
//                       // Divider
//                       Container(width: 1, height: 50, color: Colors.grey[300]),
//
//                       // Max Occupancy
//                       _buildRoomDetailItem(
//                         icon: Icons.people,
//                         title: 'Max Occupancy',
//                         value: '$occupancy',
//                         subtitle: 'Persons',
//                         color: Color(0xFF10B981),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Price per Person Section
//                 // if (occupancy > 0) ...[
//                 //   SizedBox(height: 16),
//                 //   Container(
//                 //     padding: EdgeInsets.all(16),
//                 //     decoration: BoxDecoration(
//                 //       color: Color(0xFFF0F9FF),
//                 //       borderRadius: BorderRadius.circular(16),
//                 //       border: Border.all(color: Color(0xFFE0F2FE)),
//                 //     ),
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.center,
//                 //       children: [
//                 //         Icon(Icons.calculate, size: 20, color: Color(0xFF0284C7)),
//                 //         SizedBox(width: 10),
//                 //         Text(
//                 //           'Price per person: ',
//                 //           style: TextStyle(
//                 //             fontSize: 14,
//                 //             color: Colors.grey[700],
//                 //             fontWeight: FontWeight.w500,
//                 //           ),
//                 //         ),
//                 //         Text(
//                 //           '₹${(price / occupancy).toStringAsFixed(0)}',
//                 //           style: TextStyle(
//                 //             fontSize: 16,
//                 //             color: Color(0xFF0284C7),
//                 //             fontWeight: FontWeight.w700,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ],
//
//                 // Extra Bed Information
//                 if (extraBed) ...[
//                   SizedBox(height: 16),
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFF0FDF4),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Color(0xFFDCFCE7)),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF10B981).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(
//                             Icons.airline_seat_flat,
//                             color: Color(0xFF10B981),
//                             size: 20,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Extra Bed Available',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF10B981),
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 extraBedPrice > 0
//                                     ? 'Additional ₹$extraBedPrice per bed'
//                                     : 'No additional charge',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF10B981).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             'Optional',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF10B981),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//
//                 // Room Features Summary
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: Colors.blue[100]!),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.info, size: 18, color: Colors.blue[600]),
//                           SizedBox(width: 8),
//                           Text(
//                             'Room Features',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.blue[700],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Wrap(
//                         spacing: 10,
//                         runSpacing: 10,
//                         children: [
//                           _buildFeatureChip(
//                             label: '${isAC ? 'AC' : 'Non-AC'} Room',
//                             icon: isAC ? Icons.ac_unit : Icons.air,
//                             color: isAC ? Color(0xFF2196F3) : Color(0xFFF59E0B),
//                           ),
//                           _buildFeatureChip(
//                             label: 'Up to $occupancy Persons',
//                             icon: Icons.people,
//                             color: Color(0xFF10B981),
//                           ),
//                           if (extraBed)
//                             _buildFeatureChip(
//                               label: 'Extra Bed Option',
//                               icon: Icons.airline_seat_flat,
//                               color: Color(0xFF8B5CF6),
//                             ),
//                           _buildFeatureChip(
//                             label: '₹$price / night',
//                             icon: Icons.attach_money,
//                             color: Color(0xFFEF4444),
//                           ),
//                         ],
//                       ),
//                     ],
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
//   Widget _buildRoomDetailItem({
//     required IconData icon,
//     required String title,
//     required String value,
//     required String subtitle,
//     required Color color,
//   }) {
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: color.withOpacity(0.2), width: 1.5),
//             ),
//             child: Icon(icon, size: 24, color: color),
//           ),
//           SizedBox(height: 10),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: color,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 2),
//           Text(
//             subtitle,
//             style: TextStyle(fontSize: 11, color: Colors.grey[500]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFeatureChip({
//     required String label,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3), width: 1),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: color,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRoomStatItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: color.withOpacity(0.2), width: 1),
//           ),
//           child: Icon(icon, size: 22, color: color),
//         ),
//         SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(fontSize: 11, color: Colors.grey[600]),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   // ==================== NO ROOMS CARD ====================
//   Widget _buildNoRoomsCard() {
//     return Container(
//       padding: EdgeInsets.all(40),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.hotel, size: 40, color: Colors.grey[400]),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'No Room Types Configured',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(height: 12),
//           Text(
//             'Please configure room types and their details in the hotel settings section.',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//               // textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Navigate to room configuration
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF4F46E5),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//             ),
//             icon: Icon(Icons.settings, size: 18),
//             label: Text('Configure Rooms'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== EXTRA BED CARD ====================
//   Widget _buildExtraBedCard() {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: extraBedAvailable
//                     ? [Color(0xFF4CAF50), Color(0xFF10B981)]
//                     : [Colors.grey, Colors.grey[700]!],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(
//               extraBedAvailable ? Icons.airline_seat_flat : Icons.block,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Extra Bed Facility',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   extraBedAvailable
//                       ? 'Available for select room types. Additional charges may apply.'
//                       : 'Currently not available. Contact management for special requests.',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: extraBedAvailable
//                         ? Colors.grey[600]
//                         : Colors.grey[500],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: extraBedAvailable
//                   ? Color(0xFF10B981).withOpacity(0.1)
//                   : Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               extraBedAvailable ? 'Available' : 'Not Available',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: extraBedAvailable ? Color(0xFF10B981) : Colors.grey,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ==================== HELPER METHODS ====================
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 22,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
//             letterSpacing: -0.5,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _BankAndDocumentsTab extends StatelessWidget {
//   final String accountHolderName;
//   final String bankName;
//   final String accountNumber;
//   final String ifscCode;
//   final String branch;
//   final String accountType;
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
//
//   // New document fields
//   final Map<String, Map<String, dynamic>> uploadedFiles;
//   final String signatureName;
//   final String declarationName;
//   final DateTime? declarationDate;
//   final bool declarationAccepted;
//
//   const _BankAndDocumentsTab({
//     required this.accountHolderName,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifscCode,
//     required this.branch,
//     required this.accountType,
//     required this.gstNumber,
//     required this.fssaiLicense,
//     required this.tradeLicense,
//
//     this.uploadedFiles = const {},
//     this.signatureName = '',
//     this.declarationName = '',
//     this.declarationDate,
//     this.declarationAccepted = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionHeader('Bank Account Details'),
//           SizedBox(height: 12),
//           _buildAccountDetailsCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Business Documents'),
//           SizedBox(height: 12),
//           _buildBusinessDocumentsCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Uploaded Documents'),
//           SizedBox(height: 12),
//           _buildUploadedDocumentsCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Declaration'),
//           SizedBox(height: 12),
//           _buildDeclarationCard(),
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
//               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
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
//   Widget _buildAccountDetailsCard() {
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
//           _buildBankInfoRow('Account Holder', accountHolderName),
//           Divider(height: 20),
//           _buildBankInfoRow('Bank Name', bankName),
//           Divider(height: 20),
//           _buildBankInfoRow('Account Number', accountNumber, isSensitive: true),
//           Divider(height: 20),
//           _buildBankInfoRow('IFSC Code', ifscCode),
//           Divider(height: 20),
//           _buildBankInfoRow('Branch', branch),
//           Divider(height: 20),
//           _buildBankInfoRow('Account Type', accountType),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBankInfoRow(
//     String label,
//     String value, {
//     bool isSensitive = false,
//   }) {
//     // Handle empty values
//     if (value.isEmpty) {
//       value = 'Not provided';
//     }
//
//     String displayValue;
//     if (isSensitive) {
//       if (value == 'Not provided') {
//         displayValue = value;
//       } else if (value.length >= 4) {
//         displayValue = '•••• ${value.substring(value.length - 4)}';
//       } else {
//         displayValue = '•••• $value';
//       }
//     } else {
//       displayValue = value;
//     }
//
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             displayValue,
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
//
//   Widget _buildBusinessDocumentsCard() {
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
//         children: [
//           _buildDocumentItem(
//             title: 'GST Certificate',
//             number: gstNumber,
//             icon: Icons.receipt_long,
//             color: Color(0xFF4F46E5),
//             isVerified: gstNumber.isNotEmpty,
//           ),
//           SizedBox(height: 12),
//           _buildDocumentItem(
//             title: 'FSSAI License',
//             number: fssaiLicense,
//             icon: Icons.restaurant,
//             color: Color(0xFF4CAF50),
//             isVerified: fssaiLicense.isNotEmpty,
//             isOptional: true,
//             optionalText: 'Required only if restaurant',
//           ),
//           SizedBox(height: 12),
//           _buildDocumentItem(
//             title: 'Trade License',
//             number: tradeLicense,
//             icon: Icons.business,
//             color: Color(0xFFF59E0B),
//             isVerified: tradeLicense.isNotEmpty,
//           ),
//           SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUploadedDocumentsCard() {
//     // Get all uploaded documents
//     final documentTypes = [
//       'GST Certificate',
//       'FSSAI Certificate',
//       'Trade License',
//       'Cancelled Cheque',
//       'Hotel Photos',
//       'Owner ID Proof',
//       'Signature',
//     ];
//
//     final uploadedDocs = documentTypes.where((doc) {
//       return uploadedFiles[doc]?['uploaded'] == true;
//     }).toList();
//
//     if (uploadedDocs.isEmpty) {
//       return Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 12,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Icon(Icons.folder_open, size: 40, color: Colors.grey[400]),
//             SizedBox(height: 12),
//             Text(
//               'No Documents Uploaded',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Upload documents to complete your profile',
//               style: TextStyle(fontSize: 14, color: Colors.grey[500]),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       );
//     }
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
//         children: uploadedDocs.map((docType) {
//           final fileInfo = uploadedFiles[docType] ?? {};
//           final fileName = fileInfo['name'] ?? '';
//           final fileSize = fileInfo['size'] ?? 0;
//           final isUploaded = fileInfo['uploaded'] ?? false;
//
//           return Column(
//             children: [
//               _buildUploadedDocItem(
//                 documentName: docType,
//                 fileName: fileName,
//                 fileSize: fileSize,
//                 isUploaded: isUploaded,
//               ),
//               if (docType != uploadedDocs.last) SizedBox(height: 12),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildUploadedDocItem({
//     required String documentName,
//     required String fileName,
//     required int fileSize,
//     required bool isUploaded,
//   }) {
//     IconData getDocumentIcon() {
//       if (documentName.contains('Signature')) return Icons.draw;
//       if (documentName.contains('GST')) return Icons.receipt;
//       if (documentName.contains('FSSAI')) return Icons.restaurant;
//       if (documentName.contains('License')) return Icons.badge;
//       if (documentName.contains('Cheque')) return Icons.account_balance;
//       if (documentName.contains('Photos')) return Icons.photo_library;
//       if (documentName.contains('Proof')) return Icons.perm_identity;
//       return Icons.description;
//     }
//
//     Color getIconColor() {
//       if (documentName.contains('Signature')) return Colors.purple;
//       if (documentName.contains('FSSAI')) return Colors.red;
//       if (documentName.contains('GST')) return Color(0xFF4F46E5);
//       if (documentName.contains('License')) return Color(0xFFF59E0B);
//       if (documentName.contains('Cheque')) return Color(0xFF2196F3);
//       if (documentName.contains('Photos')) return Color(0xFF4CAF50);
//       if (documentName.contains('Proof')) return Color(0xFF9C27B0);
//       return Color(0xFF4F46E5);
//     }
//
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: getIconColor().withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(getDocumentIcon(), size: 20, color: getIconColor()),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   documentName,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   fileName,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   '${(fileSize / 1024).toStringAsFixed(1)} KB',
//                   style: TextStyle(fontSize: 11, color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Color(0xFF4CAF50).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.check_circle, size: 12, color: Color(0xFF4CAF50)),
//                 SizedBox(width: 4),
//                 Text(
//                   'Uploaded',
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: Color(0xFF4CAF50),
//                     fontWeight: FontWeight.w600,
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
//   Widget _buildDeclarationCard() {
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
//               Icon(Icons.verified_user, color: Color(0xFF4F46E5), size: 24),
//               SizedBox(width: 12),
//               Text(
//                 'Declaration Status',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//
//           // Declaration Text
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[200]!),
//             ),
//             child: Text(
//               'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//                 height: 1.5,
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//
//           // Declaration Status
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: declarationAccepted
//                       ? Color(0xFF4CAF50).withOpacity(0.1)
//                       : Colors.orange.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   declarationAccepted ? Icons.check_circle : Icons.pending,
//                   size: 20,
//                   color: declarationAccepted
//                       ? Color(0xFF4CAF50)
//                       : Colors.orange,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Declaration',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       declarationAccepted ? 'Accepted' : 'Not Accepted',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: declarationAccepted
//                             ? Color(0xFF4CAF50)
//                             : Colors.orange,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//
//           // Signature Details
//           if (signatureName.isNotEmpty) ...[
//             Divider(height: 20),
//             Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.purple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(Icons.draw, size: 20, color: Colors.purple),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Signature',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         signatureName,
//                         style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//
//           // Declaration Name and Date
//           if (declarationName.isNotEmpty || declarationDate != null) ...[
//             Divider(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (declarationName.isNotEmpty)
//                   _buildDeclarationInfoRow('Name', declarationName),
//                 if (declarationDate != null) ...[
//                   SizedBox(height: 12),
//                   _buildDeclarationInfoRow(
//                     'Date',
//                     '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDeclarationInfoRow(String label, String value) {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
//
//   Widget _buildDocumentItem({
//     required String title,
//     required String number,
//     required IconData icon,
//     required Color color,
//     required bool isVerified,
//     bool isOptional = false,
//     String? optionalText,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: color, size: 26),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     if (isOptional)
//                       Container(
//                         margin: EdgeInsets.only(left: 8),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.orange.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           'Optional',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.orange,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   number.isNotEmpty ? number : 'Not provided',
//                   style: TextStyle(
//                     color: number.isNotEmpty
//                         ? Colors.grey[600]
//                         : Colors.grey[400],
//                     fontSize: 13,
//                   ),
//                 ),
//                 if (isOptional && optionalText != null) ...[
//                   SizedBox(height: 4),
//                   Text(
//                     optionalText,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.grey[500],
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 ],
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isVerified
//                             ? Color(0xFF4CAF50).withOpacity(0.1)
//                             : Colors.orange.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             isVerified ? Icons.verified : Icons.pending,
//                             size: 12,
//                             color: isVerified
//                                 ? Color(0xFF4CAF50)
//                                 : Colors.orange,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             isVerified ? 'Verified' : 'Pending',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: isVerified
//                                   ? Color(0xFF4CAF50)
//                                   : Colors.orange,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class EditHotelProfileScreen extends StatefulWidget {
//   final Map<String, dynamic> registrationData;
//
//   const EditHotelProfileScreen({
//     super.key,
//     required this.registrationData,
//   });
//
//   @override
//   State<EditHotelProfileScreen> createState() => _EditHotelProfileScreenState();
// }
//
// class _EditHotelProfileScreenState extends State<EditHotelProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   int _currentStep = 0;
//
//   // Controllers - initialize with existing data
//   late TextEditingController _hotelNameController;
//   late TextEditingController _yearController;
//   late TextEditingController _roomsController;
//   late TextEditingController _ownerNameController;
//   late TextEditingController _mobileController;
//   late TextEditingController _altMobileController;
//   late TextEditingController _emailController;
//   late TextEditingController _websiteController;
//   late TextEditingController _address1Controller;
//   late TextEditingController _address2Controller;
//   late TextEditingController _cityController;
//   late TextEditingController _districtController;
//   late TextEditingController _stateController;
//   late TextEditingController _pinController;
//   late TextEditingController _minTariffController;
//   late TextEditingController _maxTariffController;
//   late TextEditingController _gstController;
//   late TextEditingController _fssaiController;
//   late TextEditingController _tradeLicenseController;
//   late TextEditingController _accountNameController;
//   late TextEditingController _bankNameController;
//   late TextEditingController _accountNumberController;
//   late TextEditingController _ifscController;
//   late TextEditingController _branchController;
//   late TextEditingController _extraAmenitiesController;
//   late TextEditingController _landmarkController;
//   late TextEditingController _aadharController;
//   late TextEditingController _accountTypeController;
//   late TextEditingController _declarationNameController;
//   late TextEditingController _signatureNameController;
//
//   // Color constants
//   final Color _primaryColor = Color(0xFFFF5F6D);
//   final Color _primaryLight = Color(0xFFEEF2FF);
//   final Color _bgColor = Color(0xFFFAFAFA);
//   final Color _cardColor = Colors.white;
//   final Color _borderColor = Color(0xFFE5E7EB);
//   final Color _textPrimary = Color(0xFF111827);
//   final Color _textSecondary = Color(0xFF6B7280);
//   final Color _successColor = Color(0xFFFB717D);
//
//   // State variables - initialize with existing data
//   late String? _selectedHotelType;
//   late bool _extraBedAvailable;
//   late DateTime? _selectedDate;
//   late bool _declarationAccepted;
//
//   late List<TextEditingController> _landlineControllers;
//
//   // Maps and lists - initialize with existing data
//   late Map<String, Map<String, dynamic>> _roomDetails;
//   late Map<String, bool> _selectedRoomTypes;
//   late Map<String, bool> _basicAmenities;
//   late Map<String, bool> _hotelFacilities;
//   late Map<String, bool> _foodServices;
//   late Map<String, bool> _additionalAmenities;
//   late List<String> _customAmenities;
//   late Map<String, bool> _documents;
//   late Map<String, Map<String, dynamic>> _uploadedFiles;
//   late Map<String, dynamic> _personPhotoInfo;
//
//   // Steps
//   final List<Map<String, dynamic>> _steps = [
//     {'title': 'Basic Details', 'subtitle': 'Hotel information and contact'},
//     {'title': 'Hotel Details', 'subtitle': 'Address and location'},
//     {'title': 'Room Availability', 'subtitle': 'Room configuration and rates'},
//     {'title': 'Amenities & Legal', 'subtitle': 'Facilities and compliance'},
//     {'title': 'Bank & Documents', 'subtitle': 'Payment and documents'},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeDataFromRegistration();
//     // _ensureAllAmenitiesInitialized();
//   }
//
//   void _ensureAllAmenitiesInitialized() {
//     // Ensure all basic amenities exist in the map
//     final allBasicAmenities = {
//       'Free Wi-Fi': false,
//       'Television': false,
//       'Air Conditioning': false,
//       'Attached Bathroom': false,
//       'Hot Water': false,
//       'Room Service': false,
//     };
//     allBasicAmenities.forEach((key, value) {
//       if (!_basicAmenities.containsKey(key)) {
//         _basicAmenities[key] = value;
//       }
//     });
//
//     // Ensure all hotel facilities exist in the map
//     final allHotelFacilities = {
//       '24-Hour Front Desk': false,
//       'Power Backup': false,
//       'Lift / Elevator': false,
//       'Parking Facility': false,
//       'CCTV Security': false,
//     };
//     allHotelFacilities.forEach((key, value) {
//       if (!_hotelFacilities.containsKey(key)) {
//         _hotelFacilities[key] = value;
//       }
//     });
//
//     // Ensure all food services exist in the map
//     final allFoodServices = {
//       'Restaurant': false,
//       'Complimentary Breakfast': false,
//       'In-Room Dining': false,
//       'Tea / Coffee Maker': false,
//     };
//     allFoodServices.forEach((key, value) {
//       if (!_foodServices.containsKey(key)) {
//         _foodServices[key] = value;
//       }
//     });
//
//     // Ensure all additional amenities exist in the map
//     final allAdditionalAmenities = {
//       'Laundry Service': false,
//       'Travel Desk': false,
//       'Conference / Meeting Room': false,
//       'Wheelchair Access': false,
//     };
//     allAdditionalAmenities.forEach((key, value) {
//       if (!_additionalAmenities.containsKey(key)) {
//         _additionalAmenities[key] = value;
//       }
//     });
//   }
//
//   // void _initializeDataFromRegistration() {
//   //   final data = widget.registrationData;
//   //   _uploadedFiles = Map<String, Map<String, dynamic>>.from(data['uploadedFiles'] ?? {});
//   //
//   //   List<String> requiredDocuments = [
//   //     'GST Certificate',
//   //     'FSSAI Certificate',
//   //     'Trade License',
//   //     'Cancelled Cheque',
//   //     'Hotel Photos',
//   //     'Owner ID Proof',
//   //     'Signature'
//   //   ];
//   //
//   //   for (var doc in requiredDocuments) {
//   //     if (!_uploadedFiles.containsKey(doc)) {
//   //       _uploadedFiles[doc] = {
//   //         'name': '',
//   //         'size': 0,
//   //         'path': '',
//   //         'uploaded': false,
//   //       };
//   //     }
//   //   }
//   //
//   //   // Initialize controllers with existing data
//   //   _hotelNameController = TextEditingController(text: data['hotelName'] ?? '');
//   //   _yearController = TextEditingController(text: data['yearOfEstablishment'] ?? '');
//   //   _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
//   //   _ownerNameController = TextEditingController(text: data['ownerName'] ?? '');
//   //   _mobileController = TextEditingController(text: data['mobileNumber'] ?? '');
//   //   _altMobileController = TextEditingController(text: data['alternateContact'] ?? '');
//   //   _emailController = TextEditingController(text: data['email'] ?? '');
//   //   _websiteController = TextEditingController(text: data['website'] ?? '');
//   //   _address1Controller = TextEditingController(text: data['addressLine1'] ?? '');
//   //   _address2Controller = TextEditingController(text: data['addressLine2'] ?? '');
//   //   _cityController = TextEditingController(text: data['city'] ?? '');
//   //   _districtController = TextEditingController(text: data['district'] ?? '');
//   //   _stateController = TextEditingController(text: data['state'] ?? '');
//   //   _pinController = TextEditingController(text: data['pinCode'] ?? '');
//   //   _minTariffController = TextEditingController(text: data['minTariff'] ?? '');
//   //   _maxTariffController = TextEditingController(text: data['maxTariff'] ?? '');
//   //   _gstController = TextEditingController(text: data['gstNumber'] ?? '');
//   //   _fssaiController = TextEditingController(text: data['fssaiLicense'] ?? '');
//   //   _tradeLicenseController = TextEditingController(text: data['tradeLicense'] ?? '');
//   //   _accountNameController = TextEditingController(text: data['accountHolderName'] ?? '');
//   //   _bankNameController = TextEditingController(text: data['bankName'] ?? '');
//   //   _accountNumberController = TextEditingController(text: data['accountNumber'] ?? '');
//   //   _ifscController = TextEditingController(text: data['ifscCode'] ?? '');
//   //   _branchController = TextEditingController(text: data['branch'] ?? '');
//   //   _extraAmenitiesController = TextEditingController();
//   //   _landmarkController = TextEditingController(text: data['landmark'] ?? '');
//   //   _aadharController = TextEditingController(text: data['aadharNumber'] ?? '');
//   //   _accountTypeController = TextEditingController(text: data['accountType'] ?? '');
//   //   _declarationNameController = TextEditingController(text: data['declarationName'] ?? '');
//   //   _signatureNameController = TextEditingController(text: data['signatureName'] ?? '');
//   //
//   //   // Initialize other state variables
//   //   _selectedHotelType = data['hotelType'] ?? '';
//   //   _extraBedAvailable = data['extraBedAvailable'] ?? false;
//   //   _selectedDate = data['declarationDate'];
//   //   _declarationAccepted = data['declarationAccepted'] ?? false;
//   //
//   //   // Initialize landline controllers
//   //   final landlineNumbers = (data['landlineNumbers'] as List<dynamic>? ?? [])
//   //       .map((e) => e.toString())
//   //       .toList();
//   //   _landlineControllers = landlineNumbers.isEmpty
//   //       ? [TextEditingController()]
//   //       : landlineNumbers.map((num) => TextEditingController(text: num)).toList();
//   //
//   //   // Initialize room details
//   //   _roomDetails = Map<String, Map<String, dynamic>>.from(data['roomDetails'] ?? {
//   //     'Single Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //     'Double Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //     'Deluxe Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //     'Suite Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //     'Family Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //     'Executive Room': {'rooms': '', 'occupancy': '', 'ac': true, 'price': '', 'extraBed': false, 'extraBedPrice': ''},
//   //   });
//   //
//   //   // Initialize room types selection - show all options with current selections
//   //   Map<String, bool> savedSelections = Map<String, bool>.from(data['selectedRoomTypes'] ?? {});
//   //   _selectedRoomTypes = {
//   //     'Single Room': savedSelections['Single Room'] ?? false,
//   //     'Double Room': savedSelections['Double Room'] ?? false,
//   //     'Deluxe Room': savedSelections['Deluxe Room'] ?? false,
//   //     'Suite Room': savedSelections['Suite Room'] ?? false,
//   //     'Family Room': savedSelections['Family Room'] ?? false,
//   //     'Executive Room': savedSelections['Executive Room'] ?? false,
//   //   };
//   //
//   //   // Initialize amenities - show ALL amenities with current selections preserved
//   //   Map<String, bool> savedBasicAmenities = Map<String, bool>.from(data['basicAmenities'] ?? {});
//   //   _basicAmenities = {
//   //     'Free Wi-Fi': savedBasicAmenities['Free Wi-Fi'] ?? false,
//   //     'Television': savedBasicAmenities['Television'] ?? false,
//   //     'Air Conditioning': savedBasicAmenities['Air Conditioning'] ?? false,
//   //     'Attached Bathroom': savedBasicAmenities['Attached Bathroom'] ?? false,
//   //     'Hot Water': savedBasicAmenities['Hot Water'] ?? false,
//   //     'Room Service': savedBasicAmenities['Room Service'] ?? false,
//   //   };
//   //
//   //   Map<String, bool> savedHotelFacilities = Map<String, bool>.from(data['hotelFacilities'] ?? {});
//   //   _hotelFacilities = {
//   //     '24-Hour Front Desk': savedHotelFacilities['24-Hour Front Desk'] ?? false,
//   //     'Power Backup': savedHotelFacilities['Power Backup'] ?? false,
//   //     'Lift / Elevator': savedHotelFacilities['Lift / Elevator'] ?? false,
//   //     'Parking Facility': savedHotelFacilities['Parking Facility'] ?? false,
//   //     'CCTV Security': savedHotelFacilities['CCTV Security'] ?? false,
//   //   };
//   //
//   //   Map<String, bool> savedFoodServices = Map<String, bool>.from(data['foodServices'] ?? {});
//   //   _foodServices = {
//   //     'Restaurant': savedFoodServices['Restaurant'] ?? false,
//   //     'Complimentary Breakfast': savedFoodServices['Complimentary Breakfast'] ?? false,
//   //     'In-Room Dining': savedFoodServices['In-Room Dining'] ?? false,
//   //     'Tea / Coffee Maker': savedFoodServices['Tea / Coffee Maker'] ?? false,
//   //   };
//   //
//   //   Map<String, bool> savedAdditionalAmenities = Map<String, bool>.from(data['additionalAmenities'] ?? {});
//   //   _additionalAmenities = {
//   //     'Laundry Service': savedAdditionalAmenities['Laundry Service'] ?? false,
//   //     'Travel Desk': savedAdditionalAmenities['Travel Desk'] ?? false,
//   //     'Conference / Meeting Room': savedAdditionalAmenities['Conference / Meeting Room'] ?? false,
//   //     'Wheelchair Access': savedAdditionalAmenities['Wheelchair Access'] ?? false,
//   //   };
//   //
//   //   // Initialize custom amenities
//   //   _customAmenities = List<String>.from(data['customAmenities'] ?? []);
//   //
//   //   // Initialize documents
//   //   Map<String, bool> savedDocuments = Map<String, bool>.from(data['documents'] ?? {});
//   //   _documents = {
//   //     'GST Certificate': savedDocuments['GST Certificate'] ?? false,
//   //     'FSSAI Certificate': savedDocuments['FSSAI Certificate'] ?? false,
//   //     'Trade License': savedDocuments['Trade License'] ?? false,
//   //     'Cancelled Cheque': savedDocuments['Cancelled Cheque'] ?? false,
//   //     'Hotel Photos': savedDocuments['Hotel Photos'] ?? false,
//   //     'Owner ID Proof': savedDocuments['Owner ID Proof'] ?? false,
//   //     'Signature': savedDocuments['Signature'] ?? false,
//   //   };
//   //
//   //   // Initialize person photo info
//   //   _personPhotoInfo = Map<String, dynamic>.from(data['personPhotoInfo'] ?? {
//   //     'name': '', 'size': 0, 'path': '', 'uploaded': false,
//   //   });
//   // }
//
//
//   void _initializeDataFromRegistration() {
//     final data = widget.registrationData;
//     _uploadedFiles = Map<String, Map<String, dynamic>>.from(data['uploadedFiles'] ?? {});
//
//     List<String> requiredDocuments = [
//       'GST Certificate',
//       'FSSAI Certificate',
//       'Trade License',
//       'Cancelled Cheque',
//       'Hotel Photos',
//       'Owner ID Proof',
//       'Signature'
//     ];
//
//     for (var doc in requiredDocuments) {
//       if (!_uploadedFiles.containsKey(doc)) {
//         _uploadedFiles[doc] = {
//           'name': '',
//           'size': 0,
//           'path': '',
//           'uploaded': false,
//         };
//       }
//     }
//
//     // Initialize controllers with existing data
//     _hotelNameController = TextEditingController(text: data['hotelName'] ?? '');
//     _yearController = TextEditingController(text: data['yearOfEstablishment'] ?? '');
//     _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
//     _ownerNameController = TextEditingController(text: data['ownerName'] ?? '');
//     _mobileController = TextEditingController(text: data['mobileNumber'] ?? '');
//     _altMobileController = TextEditingController(text: data['alternateContact'] ?? '');
//     _emailController = TextEditingController(text: data['email'] ?? '');
//     _websiteController = TextEditingController(text: data['website'] ?? '');
//     _address1Controller = TextEditingController(text: data['addressLine1'] ?? '');
//     _address2Controller = TextEditingController(text: data['addressLine2'] ?? '');
//     _cityController = TextEditingController(text: data['city'] ?? '');
//     _districtController = TextEditingController(text: data['district'] ?? '');
//     _stateController = TextEditingController(text: data['state'] ?? '');
//     _pinController = TextEditingController(text: data['pinCode'] ?? '');
//     _minTariffController = TextEditingController(text: data['minTariff'] ?? '');
//     _maxTariffController = TextEditingController(text: data['maxTariff'] ?? '');
//     _gstController = TextEditingController(text: data['gstNumber'] ?? '');
//     _fssaiController = TextEditingController(text: data['fssaiLicense'] ?? '');
//     _tradeLicenseController = TextEditingController(text: data['tradeLicense'] ?? '');
//     _accountNameController = TextEditingController(text: data['accountHolderName'] ?? '');
//     _bankNameController = TextEditingController(text: data['bankName'] ?? '');
//     _accountNumberController = TextEditingController(text: data['accountNumber'] ?? '');
//     _ifscController = TextEditingController(text: data['ifscCode'] ?? '');
//     _branchController = TextEditingController(text: data['branch'] ?? '');
//     _extraAmenitiesController = TextEditingController();
//     _landmarkController = TextEditingController(text: data['landmark'] ?? '');
//     _aadharController = TextEditingController(text: data['aadharNumber'] ?? '');
//     _accountTypeController = TextEditingController(text: data['accountType'] ?? '');
//     _declarationNameController = TextEditingController(text: data['declarationName'] ?? '');
//     _signatureNameController = TextEditingController(text: data['signatureName'] ?? '');
//
//     // Initialize other state variables
//     _selectedHotelType = data['hotelType'] ?? '';
//     _extraBedAvailable = data['extraBedAvailable'] ?? false;
//     _selectedDate = data['declarationDate'];
//     _declarationAccepted = data['declarationAccepted'] ?? false;
//
//     // Initialize landline controllers
//     final landlineNumbers = (data['landlineNumbers'] as List<dynamic>? ?? [])
//         .map((e) => e.toString())
//         .toList();
//     _landlineControllers = landlineNumbers.isEmpty
//         ? [TextEditingController()]
//         : landlineNumbers.map((num) => TextEditingController(text: num)).toList();
//
//     // Initialize room details - ensure all room types have entries
//     _roomDetails = Map<String, Map<String, dynamic>>.from(data['roomDetails'] ?? {});
//
//     // Ensure all possible room types have entries
//     List<String> allRoomTypes = [
//       'Single Room', 'Double Room', 'Deluxe Room',
//       'Suite Room', 'Family Room', 'Executive Room'
//     ];
//
//     for (var roomType in allRoomTypes) {
//       if (!_roomDetails.containsKey(roomType)) {
//         _roomDetails[roomType] = {
//           'rooms': '',
//           'occupancy': '',
//           'ac': true,
//           'price': '',
//           'extraBed': false,
//           'extraBedPrice': '',
//         };
//       }
//     }
//
//     // Initialize room types selection - show all options with current selections
//     Map<String, bool> savedSelections = Map<String, bool>.from(data['selectedRoomTypes'] ?? {});
//     _selectedRoomTypes = {
//       'Single Room': savedSelections['Single Room'] ?? false,
//       'Double Room': savedSelections['Double Room'] ?? false,
//       'Deluxe Room': savedSelections['Deluxe Room'] ?? false,
//       'Suite Room': savedSelections['Suite Room'] ?? false,
//       'Family Room': savedSelections['Family Room'] ?? false,
//       'Executive Room': savedSelections['Executive Room'] ?? false,
//     };
//
//     // // Initialize amenities - show ALL amenities with current selections preserved
//     // Map<String, bool> savedBasicAmenities = Map<String, bool>.from(data['basicAmenities'] ?? {});
//     // _basicAmenities = {
//     //   'Free Wi-Fi': savedBasicAmenities['Free Wi-Fi'] ?? false,
//     //   'Television': savedBasicAmenities['Television'] ?? false,
//     //   'Air Conditioning': savedBasicAmenities['Air Conditioning'] ?? false,
//     //   'Attached Bathroom': savedBasicAmenities['Attached Bathroom'] ?? false,
//     //   'Hot Water': savedBasicAmenities['Hot Water'] ?? false,
//     //   'Room Service': savedBasicAmenities['Room Service'] ?? false,
//     // };
//     //
//     // Map<String, bool> savedHotelFacilities = Map<String, bool>.from(data['hotelFacilities'] ?? {});
//     // _hotelFacilities = {
//     //   '24-Hour Front Desk': savedHotelFacilities['24-Hour Front Desk'] ?? false,
//     //   'Power Backup': savedHotelFacilities['Power Backup'] ?? false,
//     //   'Lift / Elevator': savedHotelFacilities['Lift / Elevator'] ?? false,
//     //   'Parking Facility': savedHotelFacilities['Parking Facility'] ?? false,
//     //   'CCTV Security': savedHotelFacilities['CCTV Security'] ?? false,
//     // };
//     //
//     // Map<String, bool> savedFoodServices = Map<String, bool>.from(data['foodServices'] ?? {});
//     // _foodServices = {
//     //   'Restaurant': savedFoodServices['Restaurant'] ?? false,
//     //   'Complimentary Breakfast': savedFoodServices['Complimentary Breakfast'] ?? false,
//     //   'In-Room Dining': savedFoodServices['In-Room Dining'] ?? false,
//     //   'Tea / Coffee Maker': savedFoodServices['Tea / Coffee Maker'] ?? false,
//     // };
//     //
//     // Map<String, bool> savedAdditionalAmenities = Map<String, bool>.from(data['additionalAmenities'] ?? {});
//     // _additionalAmenities = {
//     //   'Laundry Service': savedAdditionalAmenities['Laundry Service'] ?? false,
//     //   'Travel Desk': savedAdditionalAmenities['Travel Desk'] ?? false,
//     //   'Conference / Meeting Room': savedAdditionalAmenities['Conference / Meeting Room'] ?? false,
//     //   'Wheelchair Access': savedAdditionalAmenities['Wheelchair Access'] ?? false,
//     // };
//     // Initialize amenities - preserve existing selections
//     // Initialize ALL basic amenities - with their selection state
//     Map<String, bool> savedBasicAmenities = Map<String, bool>.from(data['basicAmenities'] ?? {});
//     _basicAmenities = {
//       'Free Wi-Fi': savedBasicAmenities['Free Wi-Fi'] ?? false,
//       'Television': savedBasicAmenities['Television'] ?? false,
//       'Air Conditioning': savedBasicAmenities['Air Conditioning'] ?? false,
//       'Attached Bathroom': savedBasicAmenities['Attached Bathroom'] ?? false,
//       'Hot Water': savedBasicAmenities['Hot Water'] ?? false,
//       'Room Service': savedBasicAmenities['Room Service'] ?? false,
//     };
//
//     // Initialize ALL hotel facilities - with their selection state
//     Map<String, bool> savedHotelFacilities = Map<String, bool>.from(data['hotelFacilities'] ?? {});
//     _hotelFacilities = {
//       '24-Hour Front Desk': savedHotelFacilities['24-Hour Front Desk'] ?? false,
//       'Power Backup': savedHotelFacilities['Power Backup'] ?? false,
//       'Lift / Elevator': savedHotelFacilities['Lift / Elevator'] ?? false,
//       'Parking Facility': savedHotelFacilities['Parking Facility'] ?? false,
//       'CCTV Security': savedHotelFacilities['CCTV Security'] ?? false,
//     };
//
//     // Initialize ALL food services - with their selection state
//     Map<String, bool> savedFoodServices = Map<String, bool>.from(data['foodServices'] ?? {});
//     _foodServices = {
//       'Restaurant': savedFoodServices['Restaurant'] ?? false,
//       'Complimentary Breakfast': savedFoodServices['Complimentary Breakfast'] ?? false,
//       'In-Room Dining': savedFoodServices['In-Room Dining'] ?? false,
//       'Tea / Coffee Maker': savedFoodServices['Tea / Coffee Maker'] ?? false,
//     };
//
//     // Initialize ALL additional amenities - with their selection state
//     Map<String, bool> savedAdditionalAmenities = Map<String, bool>.from(data['additionalAmenities'] ?? {});
//     _additionalAmenities = {
//       'Laundry Service': savedAdditionalAmenities['Laundry Service'] ?? false,
//       'Travel Desk': savedAdditionalAmenities['Travel Desk'] ?? false,
//       'Conference / Meeting Room': savedAdditionalAmenities['Conference / Meeting Room'] ?? false,
//       'Wheelchair Access': savedAdditionalAmenities['Wheelchair Access'] ?? false,
//     };
//
//     // Initialize custom amenities
//     _customAmenities = List<String>.from(data['customAmenities'] ?? []);
//
//     // Initialize documents
//     Map<String, bool> savedDocuments = Map<String, bool>.from(data['documents'] ?? {});
//     _documents = {
//       'GST Certificate': savedDocuments['GST Certificate'] ?? false,
//       'FSSAI Certificate': savedDocuments['FSSAI Certificate'] ?? false,
//       'Trade License': savedDocuments['Trade License'] ?? false,
//       'Cancelled Cheque': savedDocuments['Cancelled Cheque'] ?? false,
//       'Hotel Photos': savedDocuments['Hotel Photos'] ?? false,
//       'Owner ID Proof': savedDocuments['Owner ID Proof'] ?? false,
//       'Signature': savedDocuments['Signature'] ?? false,
//     };
//
//
//     _personPhotoInfo = Map<String, dynamic>.from(data['personPhotoInfo'] ?? {
//       'name': '', 'size': 0, 'path': '', 'uploaded': false,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _bgColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: _textPrimary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Edit Hotel Profile',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Progress indicator
//             Container(
//               padding: EdgeInsets.all(5),
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(_steps.length, (index) {
//                         bool isActive = index == _currentStep;
//                         bool isCompleted = index < _currentStep;
//                         return Container(
//                           margin: EdgeInsets.symmetric(horizontal: 2),
//                           child: GestureDetector(
//                             onTap: () {
//                               if (index <= _currentStep) {
//                                 setState(() => _currentStep = index);
//                               }
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 32,
//                                   height: 32,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: isActive ? _primaryColor :
//                                     isCompleted ? _successColor : Colors.white,
//                                     border: Border.all(
//                                       color: isActive || isCompleted ?
//                                       Colors.transparent : _borderColor,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: isCompleted
//                                         ? Icon(Icons.check, size: 18, color: Colors.white)
//                                         : Text('${index + 1}', style: TextStyle(
//                                       color: isActive || isCompleted ?
//                                       Colors.white : _textSecondary,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14,
//                                     )),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 SizedBox(
//                                   width: 70,
//                                   child: Text(
//                                     _steps[index]['title'],
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w500,
//                                       color: isActive || isCompleted ?
//                                       _textPrimary : _textSecondary,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   LinearProgressIndicator(
//                     value: (_currentStep + 1) / _steps.length,
//                     backgroundColor: _borderColor,
//                     color: _primaryColor,
//                     minHeight: 4,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Step ${_currentStep + 1} of ${_steps.length}',
//                           style: TextStyle(fontSize: 12, color: _textSecondary)),
//                       Text('${((_currentStep + 1) / _steps.length * 100).toInt()}%',
//                           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _primaryColor)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Step content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: _cardColor,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: _borderColor),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: _primaryLight,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(
//                               child: Text('${_currentStep + 1}', style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: _primaryColor,
//                               )),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(_steps[_currentStep]['title'], style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: _textPrimary,
//                                 )),
//                                 SizedBox(height: 4),
//                                 Text(_steps[_currentStep]['subtitle'], style: TextStyle(
//                                   fontSize: 12,
//                                   color: _textSecondary,
//                                 )),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     _buildStepContent(),
//                     SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Navigation buttons
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(top: BorderSide(color: _borderColor)),
//                 boxShadow: [BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 8,
//                   offset: Offset(0, -2),
//                 )],
//               ),
//               child: Row(
//                 children: [
//                   if (_currentStep > 0)
//                     Expanded(
//                       child: SizedBox(
//                         height: 55,
//                         child: OutlinedButton(
//                           onPressed: _previousStep,
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: _borderColor),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text('Back', style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: _textPrimary,
//                           )),
//                         ),
//                       ),
//                     ),
//                   if (_currentStep > 0) SizedBox(width: 12),
//                   Expanded(
//                     child: SizedBox(
//                       height: 58,
//                       child: ElevatedButton(
//                         onPressed: _nextStep,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: Text(
//                           _currentStep == _steps.length - 1 ? 'Update Profile' : 'Next',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStepContent() {
//     switch (_currentStep) {
//       case 0: return _buildStep1();
//       case 1: return _buildStep2();
//       case 2: return _buildStep3();
//       case 3: return _buildStep4();
//       case 4: return _buildStep5();
//       default: return Container();
//     }
//   }
//
//   // Step 1: Basic Details (same as registration form)
//   Widget _buildStep1() {
//     return Column(
//       children: [
//         _buildCard(
//           title: 'Hotel Information',
//           children: [
//             _buildInputField(
//               label: 'Hotel Name *',
//               controller: _hotelNameController,
//               hint: 'Enter hotel name',
//             ),
//             SizedBox(height: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Hotel Type *', style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: _textPrimary,
//                 )),
//                 SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: [
//                     'Lodge', 'Budget Hotel', 'Standard Hotel',
//                     'Guest House', 'Heritage Hotel', 'Boutique Hotel',
//                   ].map((type) => _buildChip(type)).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Year of Establishment',
//                     controller: _yearController,
//                     hint: 'YYYY',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Total Number of Rooms',
//                     controller: _roomsController,
//                     hint: '0',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: 'Contact Information',
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Profile Photo', style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: _textPrimary,
//                 )),
//                 SizedBox(height: 8),
//                 _buildPhotoUploadItem(),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Owner / Manager Name *',
//               controller: _ownerNameController,
//               hint: 'Enter name',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Mobile Number *',
//               controller: _mobileController,
//               hint: 'Enter mobile number',
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Alternate Contact',
//               controller: _altMobileController,
//               hint: 'Optional',
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Landline Number(s)', style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: _textPrimary,
//                     )),
//                     if (_landlineControllers.length < 3)
//                       TextButton(
//                         onPressed: _addLandlineField,
//                         child: Row(
//                           children: [
//                             Icon(Icons.add, size: 16, color: _primaryColor),
//                             SizedBox(width: 4),
//                             Text('Add Landline', style: TextStyle(
//                               fontSize: 12,
//                               color: _primaryColor,
//                               fontWeight: FontWeight.w500,
//                             )),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Column(
//                   children: _landlineControllers.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     TextEditingController controller = entry.value;
//                     return Padding(
//                       padding: EdgeInsets.only(
//                         bottom: index < _landlineControllers.length - 1 ? 12 : 0,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               controller: controller,
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter landline number ${index + 1}',
//                                 contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 12),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(color: _borderColor),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (_landlineControllers.length > 1)
//                             IconButton(
//                               onPressed: () => _removeLandlineField(index),
//                               icon: Icon(Icons.remove_circle, color: Colors.red),
//                               padding: EdgeInsets.only(left: 8),
//                             ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Email ID',
//               controller: _emailController,
//               hint: 'example@email.com',
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Website (if any)',
//               controller: _websiteController,
//               hint: 'https://example.com',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStep2() {
//     return Column(
//       children: [
//         _buildCard(
//           title: 'Hotel Address',
//           children: [
//             _buildInputField(
//               label: 'Address Line 1 *',
//               controller: _address1Controller,
//               hint: 'Street address',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Address Line 2',
//               controller: _address2Controller,
//               hint: 'Apartment, suite, etc.',
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'City *',
//                     controller: _cityController,
//                     hint: 'Enter city',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'District *',
//                     controller: _districtController,
//                     hint: 'Enter district',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'State *',
//                     controller: _stateController,
//                     hint: 'Enter state',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'PIN Code *',
//                     controller: _pinController,
//                     hint: '6-digit PIN',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Landmark (Optional)',
//               controller: _landmarkController,
//               hint: 'Nearby place',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Widget _buildStep3() {
//   //   return Column(
//   //     children: [
//   //       _buildCard(
//   //         title: 'Select Room Types Available',
//   //         children: [
//   //           Text('Select the room types available in your hotel:', style: TextStyle(
//   //             fontSize: 13, color: _textSecondary,
//   //           )),
//   //           SizedBox(height: 12),
//   //           Wrap(
//   //             spacing: 8,
//   //             runSpacing: 8,
//   //             children: _selectedRoomTypes.entries.map((entry) {
//   //               bool isSelected = entry.value;
//   //               return GestureDetector(
//   //                 onTap: () {
//   //                   setState(() {
//   //                     _selectedRoomTypes[entry.key] = !isSelected;
//   //                   });
//   //                 },
//   //                 child: Container(
//   //                   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//   //                   decoration: BoxDecoration(
//   //                     color: isSelected ? _primaryLight : Colors.white,
//   //                     borderRadius: BorderRadius.circular(20),
//   //                     border: Border.all(
//   //                       color: isSelected ? _primaryColor : _borderColor,
//   //                       width: isSelected ? 2 : 1,
//   //                     ),
//   //                   ),
//   //                   child: Row(
//   //                     mainAxisSize: MainAxisSize.min,
//   //                     children: [
//   //                       Icon(
//   //                         isSelected ? Icons.check_circle : Icons.circle_outlined,
//   //                         size: 16,
//   //                         color: isSelected ? _primaryColor : _textSecondary,
//   //                       ),
//   //                       SizedBox(width: 6),
//   //                       Text(entry.key, style: TextStyle(
//   //                         fontSize: 13,
//   //                         color: isSelected ? _primaryColor : _textSecondary,
//   //                         fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//   //                       )),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               );
//   //             }).toList(),
//   //           ),
//   //           SizedBox(height: 16),
//   //           Divider(color: _borderColor),
//   //           SizedBox(height: 16),
//   //           Text('Configure selected room types:', style: TextStyle(
//   //             fontSize: 14,
//   //             fontWeight: FontWeight.w600,
//   //             color: _textPrimary,
//   //           )),
//   //           SizedBox(height: 12),
//   //         ],
//   //       ),
//   //
//   //       ..._selectedRoomTypes.entries.where((entry) => entry.value).map((entry) {
//   //         String roomType = entry.key;
//   //         return Container(
//   //           margin: EdgeInsets.only(bottom: 16),
//   //           child: _buildCard(
//   //             title: '$roomType Details',
//   //             children: [
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: _buildSmallInput(
//   //                       label: 'Number of Rooms',
//   //                       controller: TextEditingController(
//   //                         text: _roomDetails[roomType]!['rooms'],
//   //                       ),
//   //                       onChanged: (value) => _roomDetails[roomType]!['rooms'] = value,
//   //                       hint: '0',
//   //                       keyboardType: TextInputType.number,
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 12),
//   //                   Expanded(
//   //                     child: _buildSmallInput(
//   //                       label: 'Max Occupancy',
//   //                       controller: TextEditingController(
//   //                         text: _roomDetails[roomType]!['occupancy'],
//   //                       ),
//   //                       onChanged: (value) => _roomDetails[roomType]!['occupancy'] = value,
//   //                       hint: 'Persons',
//   //                       keyboardType: TextInputType.number,
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //               SizedBox(height: 12),
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: _buildSmallInput(
//   //                       label: 'Price per Night (₹)',
//   //                       controller: TextEditingController(
//   //                         text: _roomDetails[roomType]!['price'],
//   //                       ),
//   //                       onChanged: (value) => _roomDetails[roomType]!['price'] = value,
//   //                       hint: '0',
//   //                       keyboardType: TextInputType.number,
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 12),
//   //                   Expanded(
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text('AC / Non-AC', style: TextStyle(
//   //                           fontSize: 12,
//   //                           fontWeight: FontWeight.w500,
//   //                         )),
//   //                         SizedBox(height: 8),
//   //                         Row(
//   //                           children: [
//   //                             Expanded(
//   //                               child: _buildToggleChip(
//   //                                 'AC',
//   //                                 _roomDetails[roomType]!['ac'],
//   //                                     () => setState(() => _roomDetails[roomType]!['ac'] = true),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 8),
//   //                             Expanded(
//   //                               child: _buildToggleChip(
//   //                                 'Non-AC',
//   //                                 !_roomDetails[roomType]!['ac'],
//   //                                     () => setState(() => _roomDetails[roomType]!['ac'] = false),
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //               SizedBox(height: 12),
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text('Extra Bed Available', style: TextStyle(
//   //                           fontSize: 12,
//   //                           fontWeight: FontWeight.w500,
//   //                         )),
//   //                         SizedBox(height: 8),
//   //                         Row(
//   //                           children: [
//   //                             _buildToggleChip(
//   //                               'Yes',
//   //                               _roomDetails[roomType]!['extraBed'],
//   //                                   () => setState(() => _roomDetails[roomType]!['extraBed'] = true),
//   //                             ),
//   //                             SizedBox(width: 8),
//   //                             _buildToggleChip(
//   //                               'No',
//   //                               !_roomDetails[roomType]!['extraBed'],
//   //                                   () => setState(() => _roomDetails[roomType]!['extraBed'] = false),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 12),
//   //                   if (_roomDetails[roomType]!['extraBed'])
//   //                     Expanded(
//   //                       child: _buildSmallInput(
//   //                         label: 'Extra Bed Price (₹)',
//   //                         controller: TextEditingController(
//   //                           text: _roomDetails[roomType]!['extraBedPrice'],
//   //                         ),
//   //                         onChanged: (value) => _roomDetails[roomType]!['extraBedPrice'] = value,
//   //                         hint: '0',
//   //                         keyboardType: TextInputType.number,
//   //                       ),
//   //                     ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         );
//   //       }).toList(),
//   //
//   //       SizedBox(height: 16),
//   //       _buildCard(
//   //         title: 'Select Price (per day):',
//   //         children: [
//   //           Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               SizedBox(height: 5),
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: _minTariffController,
//   //                       keyboardType: TextInputType.number,
//   //                       decoration: InputDecoration(
//   //                         hintText: 'Rs',
//   //                         contentPadding: EdgeInsets.symmetric(
//   //                             horizontal: 12, vertical: 10),
//   //                         border: OutlineInputBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                           borderSide: BorderSide(color: _borderColor),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   Padding(
//   //                     padding: EdgeInsets.symmetric(horizontal: 8),
//   //                     child: Text('to', style: TextStyle(color: _textSecondary)),
//   //                   ),
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: _maxTariffController,
//   //                       keyboardType: TextInputType.number,
//   //                       decoration: InputDecoration(
//   //                         hintText: 'Rs',
//   //                         contentPadding: EdgeInsets.symmetric(
//   //                             horizontal: 12, vertical: 10),
//   //                         border: OutlineInputBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                           borderSide: BorderSide(color: _borderColor),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //           SizedBox(height: 16),
//   //           Row(
//   //             children: [
//   //               Expanded(
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text('Extra Bed Available Overall:', style: TextStyle(
//   //                       fontWeight: FontWeight.w500, fontSize: 13,
//   //                     )),
//   //                     SizedBox(height: 8),
//   //                     Row(
//   //                       children: [
//   //                         _buildToggleChip('Yes', _extraBedAvailable,
//   //                                 () => setState(() => _extraBedAvailable = true)),
//   //                         SizedBox(width: 8),
//   //                         _buildToggleChip('No', !_extraBedAvailable,
//   //                                 () => setState(() => _extraBedAvailable = false)),
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
//   Widget _buildStep3() {
//     return Column(
//       children: [
//         _buildCard(
//           title: 'Select Room Types Available',
//           children: [
//             Text('Select the room types available in your hotel:', style: TextStyle(
//               fontSize: 13, color: _textSecondary,
//             )),
//             SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: _selectedRoomTypes.entries.map((entry) {
//                 bool isSelected = entry.value;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedRoomTypes[entry.key] = !isSelected;
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? _primaryLight : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: isSelected ? _primaryColor : _borderColor,
//                         width: isSelected ? 2 : 1,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           isSelected ? Icons.check_circle : Icons.circle_outlined,
//                           size: 16,
//                           color: isSelected ? _primaryColor : _textSecondary,
//                         ),
//                         SizedBox(width: 6),
//                         Text(entry.key, style: TextStyle(
//                           fontSize: 13,
//                           color: isSelected ? _primaryColor : _textSecondary,
//                           fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                         )),
//                       ],
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             Divider(color: _borderColor),
//             SizedBox(height: 16),
//             Text('Configure selected room types:', style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: _textPrimary,
//             )),
//             SizedBox(height: 12),
//           ],
//         ),
//
//         // Fix: Check if room type exists in _roomDetails before accessing
//         ..._selectedRoomTypes.entries.where((entry) => entry.value).map((entry) {
//           String roomType = entry.key;
//
//           // Check if room type exists in _roomDetails, create default if not
//           if (!_roomDetails.containsKey(roomType)) {
//             _roomDetails[roomType] = {
//               'rooms': '',
//               'occupancy': '',
//               'ac': true,
//               'price': '',
//               'extraBed': false,
//               'extraBedPrice': '',
//             };
//           }
//
//           final roomData = _roomDetails[roomType]!;
//
//           return Container(
//             margin: EdgeInsets.only(bottom: 16),
//             child: _buildCard(
//               title: '$roomType Details',
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildSmallInput(
//                         label: 'Number of Rooms',
//                         controller: TextEditingController(
//                           text: roomData['rooms'] ?? '',
//                         ),
//                         onChanged: (value) => roomData['rooms'] = value,
//                         hint: '0',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: _buildSmallInput(
//                         label: 'Max Occupancy',
//                         controller: TextEditingController(
//                           text: roomData['occupancy'] ?? '',
//                         ),
//                         onChanged: (value) => roomData['occupancy'] = value,
//                         hint: 'Persons',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildSmallInput(
//                         label: 'Price per Night (₹)',
//                         controller: TextEditingController(
//                           text: roomData['price'] ?? '',
//                         ),
//                         onChanged: (value) => roomData['price'] = value,
//                         hint: '0',
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('AC / Non-AC', style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           )),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildToggleChip(
//                                   'AC',
//                                   roomData['ac'] ?? true,
//                                       () => setState(() => roomData['ac'] = true),
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Expanded(
//                                 child: _buildToggleChip(
//                                   'Non-AC',
//                                   !(roomData['ac'] ?? true),
//                                       () => setState(() => roomData['ac'] = false),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Extra Bed Available', style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           )),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               _buildToggleChip(
//                                 'Yes',
//                                 roomData['extraBed'] ?? false,
//                                     () => setState(() => roomData['extraBed'] = true),
//                               ),
//                               SizedBox(width: 8),
//                               _buildToggleChip(
//                                 'No',
//                                 !(roomData['extraBed'] ?? false),
//                                     () => setState(() => roomData['extraBed'] = false),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     if (roomData['extraBed'] ?? false)
//                       Expanded(
//                         child: _buildSmallInput(
//                           label: 'Extra Bed Price (₹)',
//                           controller: TextEditingController(
//                             text: roomData['extraBedPrice'] ?? '',
//                           ),
//                           onChanged: (value) => roomData['extraBedPrice'] = value,
//                           hint: '0',
//                           keyboardType: TextInputType.number,
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//               ],
//             ),
//           );
//         }).toList(),
//
//         SizedBox(height: 16),
//         _buildCard(
//           title: 'Select Price (per day):',
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _minTariffController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Rs',
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: _borderColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Text('to', style: TextStyle(color: _textSecondary)),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         controller: _maxTariffController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Rs',
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: _borderColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Extra Bed Available Overall:', style: TextStyle(
//                         fontWeight: FontWeight.w500, fontSize: 13,
//                       )),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           _buildToggleChip('Yes', _extraBedAvailable,
//                                   () => setState(() => _extraBedAvailable = true)),
//                           SizedBox(width: 8),
//                           _buildToggleChip('No', !_extraBedAvailable,
//                                   () => setState(() => _extraBedAvailable = false)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//   // Widget _buildStep4() {
//   //   return Column(
//   //     children: [
//   //       _buildCard(
//   //         title: 'Amenities Available',
//   //         children: [
//   //           _buildAmenitiesSection('Basic Amenities', _basicAmenities),
//   //           SizedBox(height: 16),
//   //           _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
//   //           SizedBox(height: 16),
//   //           _buildAmenitiesSection('Food & Services', _foodServices),
//   //           SizedBox(height: 16),
//   //           _buildAmenitiesSection('Additional Amenities', _additionalAmenities),
//   //           SizedBox(height: 16),
//   //           Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text('Add Extra Amenities', style: TextStyle(
//   //                 fontSize: 13, fontWeight: FontWeight.w600,
//   //               )),
//   //               SizedBox(height: 8),
//   //               Text('Add any additional amenities not listed above', style: TextStyle(
//   //                 fontSize: 12, color: _textSecondary,
//   //               )),
//   //               SizedBox(height: 8),
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: _extraAmenitiesController,
//   //                       decoration: InputDecoration(
//   //                         hintText: 'Enter amenities...',
//   //                         contentPadding: EdgeInsets.symmetric(
//   //                             horizontal: 12, vertical: 12),
//   //                         border: OutlineInputBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                           borderSide: BorderSide(color: _borderColor),
//   //                         ),
//   //                       ),
//   //                       onFieldSubmitted: (value) {
//   //                         if (value.trim().isNotEmpty) _addCustomAmenity();
//   //                       },
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 8),
//   //                   SizedBox(
//   //                     height: 48,
//   //                     child: ElevatedButton(
//   //                       onPressed: _addCustomAmenity,
//   //                       style: ElevatedButton.styleFrom(
//   //                         backgroundColor: _primaryColor,
//   //                         shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                         ),
//   //                         padding: EdgeInsets.symmetric(horizontal: 16),
//   //                       ),
//   //                       child: Text('Add', style: TextStyle(
//   //                         fontSize: 14,
//   //                         fontWeight: FontWeight.w500,
//   //                         color: Colors.white,
//   //                       )),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //               if (_customAmenities.isNotEmpty)
//   //                 Padding(
//   //                   padding: EdgeInsets.only(top: 8),
//   //                   child: Wrap(
//   //                     spacing: 8,
//   //                     runSpacing: 8,
//   //                     children: _customAmenities.map((amenity) {
//   //                       return Container(
//   //                         padding: EdgeInsets.symmetric(
//   //                           horizontal: 12, vertical: 6,
//   //                         ),
//   //                         decoration: BoxDecoration(
//   //                           color: _primaryLight,
//   //                           borderRadius: BorderRadius.circular(16),
//   //                           border: Border.all(color: _primaryColor),
//   //                         ),
//   //                         child: Row(
//   //                           mainAxisSize: MainAxisSize.min,
//   //                           children: [
//   //                             Text(amenity, style: TextStyle(
//   //                               fontSize: 12, color: _primaryColor,
//   //                             )),
//   //                             SizedBox(width: 4),
//   //                             GestureDetector(
//   //                               onTap: () => _removeCustomAmenity(amenity),
//   //                               child: Icon(
//   //                                 Icons.close, size: 14, color: _primaryColor,
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       );
//   //                     }).toList(),
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //       SizedBox(height: 16),
//   //       _buildCard(
//   //         title: 'Legal Details',
//   //         children: [
//   //           _buildInputField(
//   //             label: 'GST Number',
//   //             controller: _gstController,
//   //             hint: 'Enter GST number',
//   //           ),
//   //           SizedBox(height: 16),
//   //           Row(
//   //             children: [
//   //               Expanded(
//   //                 child: _buildInputField(
//   //                   label: 'FSSAI License No.',
//   //                   controller: _fssaiController,
//   //                   hint: 'If restaurant',
//   //                 ),
//   //               ),
//   //               SizedBox(width: 16),
//   //               Expanded(
//   //                 child: _buildInputField(
//   //                   label: 'Trade License No.',
//   //                   controller: _tradeLicenseController,
//   //                   hint: 'Enter license number',
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           SizedBox(height: 16),
//   //           _buildInputField(
//   //             label: 'Aadhar Number (Owner)',
//   //             controller: _aadharController,
//   //             hint: 'Enter Aadhar number',
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
//   Widget _buildStep4() {
//     return Column(
//       children: [
//         _buildCard(
//           title: 'Amenities Available',
//           children: [
//             // Show ALL basic amenities with clear selection state
//             _buildAmenitiesSelectionSection('Basic Amenities', _basicAmenities),
//             SizedBox(height: 16),
//
//             // Show ALL hotel facilities with clear selection state
//             _buildAmenitiesSelectionSection('Hotel Facilities', _hotelFacilities),
//             SizedBox(height: 16),
//
//             // Show ALL food services with clear selection state
//             _buildAmenitiesSelectionSection('Food & Services', _foodServices),
//             SizedBox(height: 16),
//
//             // Show ALL additional amenities with clear selection state
//             _buildAmenitiesSelectionSection('Additional Amenities', _additionalAmenities),
//             SizedBox(height: 16),
//
//             // Custom Amenities Section
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Add Extra Amenities',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Add any additional amenities not listed above',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: _textSecondary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _extraAmenitiesController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter amenities...',
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 12,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: _borderColor),
//                           ),
//                         ),
//                         onFieldSubmitted: (value) {
//                           if (value.trim().isNotEmpty) _addCustomAmenity();
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     SizedBox(
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: _addCustomAmenity,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                         child: Text(
//                           'Add',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 if (_customAmenities.isNotEmpty)
//                   Padding(
//                     padding: EdgeInsets.only(top: 8),
//                     child: Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: _customAmenities.map((amenity) {
//                         return Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _primaryLight,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: _primaryColor),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 amenity,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: _primaryColor,
//                                 ),
//                               ),
//                               SizedBox(width: 4),
//                               GestureDetector(
//                                 onTap: () => _removeCustomAmenity(amenity),
//                                 child: Icon(
//                                   Icons.close,
//                                   size: 14,
//                                   color: _primaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: 'Legal Details',
//           children: [
//             _buildInputField(
//               label: 'GST Number',
//               controller: _gstController,
//               hint: 'Enter GST number',
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'FSSAI License No.',
//                     controller: _fssaiController,
//                     hint: 'If restaurant',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Trade License No.',
//                     controller: _tradeLicenseController,
//                     hint: 'Enter license number',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Aadhar Number (Owner)',
//               controller: _aadharController,
//               hint: 'Enter Aadhar number',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
// // Updated method to build amenities section with clear visual distinction
//   Widget _buildAmenitiesSelectionSection(String title, Map<String, bool> amenities) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           ),
//         ),
//         SizedBox(height: 8),
//
//         // Show selection count
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Selected ${amenities.values.where((v) => v).length} of ${amenities.length}',
//               style: TextStyle(
//                 fontSize: 11,
//                 color: _textSecondary,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             if (amenities.values.any((v) => v))
//               GestureDetector(
//                 onTap: () {
//                   // Clear all selections
//                   amenities.forEach((key, value) {
//                     amenities[key] = false;
//                   });
//                 },
//                 child: Text(
//                   'Clear All',
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: Colors.red,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         SizedBox(height: 8),
//
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: amenities.entries.map((entry) {
//             bool isSelected = entry.value;
//             String amenityName = entry.key;
//
//             return GestureDetector(
//               onTap: () {
//                 // Toggle selection - ALL amenities are clickable
//                 setState(() {
//                   amenities[amenityName] = !isSelected;
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? _primaryColor : Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: isSelected ? _primaryColor : _borderColor,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       isSelected ? Icons.check_circle : Icons.circle_outlined,
//                       size: 16,
//                       color: isSelected ? Colors.white : _textSecondary,
//                     ),
//                     SizedBox(width: 6),
//                     Text(
//                       amenityName,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: isSelected ? Colors.white : _textSecondary,
//                         fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   // Widget _buildStep4() {
//   //   return Column(
//   //     children: [
//   //       _buildCard(
//   //         title: 'Amenities Available',
//   //         children: [
//   //           // Show ALL basic amenities (selected and non-selected)
//   //           _buildAmenitiesSection('Basic Amenities', _basicAmenities),
//   //           SizedBox(height: 16),
//   //
//   //           // Show ALL hotel facilities (selected and non-selected)
//   //           _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
//   //           SizedBox(height: 16),
//   //
//   //           // Show ALL food services (selected and non-selected)
//   //           _buildAmenitiesSection('Food & Services', _foodServices),
//   //           SizedBox(height: 16),
//   //
//   //           // Show ALL additional amenities (selected and non-selected)
//   //           _buildAmenitiesSection('Additional Amenities', _additionalAmenities),
//   //           SizedBox(height: 16),
//   //
//   //           Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text('Add Extra Amenities', style: TextStyle(
//   //                 fontSize: 13, fontWeight: FontWeight.w600,
//   //               )),
//   //               SizedBox(height: 8),
//   //               Text('Add any additional amenities not listed above', style: TextStyle(
//   //                 fontSize: 12, color: _textSecondary,
//   //               )),
//   //               SizedBox(height: 8),
//   //               Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: _extraAmenitiesController,
//   //                       decoration: InputDecoration(
//   //                         hintText: 'Enter amenities...',
//   //                         contentPadding: EdgeInsets.symmetric(
//   //                             horizontal: 12, vertical: 12),
//   //                         border: OutlineInputBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                           borderSide: BorderSide(color: _borderColor),
//   //                         ),
//   //                       ),
//   //                       onFieldSubmitted: (value) {
//   //                         if (value.trim().isNotEmpty) _addCustomAmenity();
//   //                       },
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 8),
//   //                   SizedBox(
//   //                     height: 48,
//   //                     child: ElevatedButton(
//   //                       onPressed: _addCustomAmenity,
//   //                       style: ElevatedButton.styleFrom(
//   //                         backgroundColor: _primaryColor,
//   //                         shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                         ),
//   //                         padding: EdgeInsets.symmetric(horizontal: 16),
//   //                       ),
//   //                       child: Text('Add', style: TextStyle(
//   //                         fontSize: 14,
//   //                         fontWeight: FontWeight.w500,
//   //                         color: Colors.white,
//   //                       )),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //
//   //               if (_customAmenities.isNotEmpty)
//   //                 Padding(
//   //                   padding: EdgeInsets.only(top: 8),
//   //                   child: Wrap(
//   //                     spacing: 8,
//   //                     runSpacing: 8,
//   //                     children: _customAmenities.map((amenity) {
//   //                       return Container(
//   //                         padding: EdgeInsets.symmetric(
//   //                           horizontal: 12, vertical: 6,
//   //                         ),
//   //                         decoration: BoxDecoration(
//   //                           color: _primaryLight,
//   //                           borderRadius: BorderRadius.circular(16),
//   //                           border: Border.all(color: _primaryColor),
//   //                         ),
//   //                         child: Row(
//   //                           mainAxisSize: MainAxisSize.min,
//   //                           children: [
//   //                             Text(amenity, style: TextStyle(
//   //                               fontSize: 12, color: _primaryColor,
//   //                             )),
//   //                             SizedBox(width: 4),
//   //                             GestureDetector(
//   //                               onTap: () => _removeCustomAmenity(amenity),
//   //                               child: Icon(
//   //                                 Icons.close, size: 14, color: _primaryColor,
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       );
//   //                     }).toList(),
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //       SizedBox(height: 16),
//   //       _buildCard(
//   //         title: 'Legal Details',
//   //         children: [
//   //           _buildInputField(
//   //             label: 'GST Number',
//   //             controller: _gstController,
//   //             hint: 'Enter GST number',
//   //           ),
//   //           SizedBox(height: 16),
//   //           Row(
//   //             children: [
//   //               Expanded(
//   //                 child: _buildInputField(
//   //                   label: 'FSSAI License No.',
//   //                   controller: _fssaiController,
//   //                   hint: 'If restaurant',
//   //                 ),
//   //               ),
//   //               SizedBox(width: 16),
//   //               Expanded(
//   //                 child: _buildInputField(
//   //                   label: 'Trade License No.',
//   //                   controller: _tradeLicenseController,
//   //                   hint: 'Enter license number',
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           SizedBox(height: 16),
//   //           _buildInputField(
//   //             label: 'Aadhar Number (Owner)',
//   //             controller: _aadharController,
//   //             hint: 'Enter Aadhar number',
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
//
//
//
//   Widget _buildStep5() {
//     return Column(
//       children: [
//         _buildCard(
//           title: 'Bank Details',
//           children: [
//             _buildInputField(
//               label: 'Account Holder Name *',
//               controller: _accountNameController,
//               hint: 'Enter name',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Bank Name *',
//               controller: _bankNameController,
//               hint: 'Enter bank name',
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Account Number *',
//                     controller: _accountNumberController,
//                     hint: 'Enter account number',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'IFSC Code *',
//                     controller: _ifscController,
//                     hint: 'Enter IFSC code',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Branch',
//               controller: _branchController,
//               hint: 'Enter branch name',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Account Type',
//               controller: _accountTypeController,
//               hint: 'Savings / Current',
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: 'Documents Required',
//           children: [
//             Text('Please upload clear scanned copies of the following documents',
//                 style: TextStyle(fontSize: 12, color: _textSecondary)),
//             SizedBox(height: 16),
//
//             // Fix: Check if FSSAI Certificate exists in uploadedFiles
//             if (_uploadedFiles.containsKey('FSSAI Certificate'))
//               _buildDocumentUploadItem(
//                 documentName: 'FSSAI Certificate',
//                 fileInfo: _uploadedFiles['FSSAI Certificate']!,
//                 onUploadPressed: () => _pickDocument('FSSAI Certificate'),
//                 onViewPressed: () => _viewDocument('FSSAI Certificate'),
//                 onRemovePressed: () => _removeDocument('FSSAI Certificate'),
//                 isOptional: true,
//                 optionalText: 'Required only if you have a restaurant',
//               ),
//
//             SizedBox(height: 12),
//             ..._uploadedFiles.entries.where((entry) =>
//             entry.key != 'FSSAI Certificate' &&
//                 entry.key != 'Signature').map((entry) =>
//                 _buildDocumentUploadItem(
//                   documentName: entry.key,
//                   fileInfo: entry.value,
//                   onUploadPressed: () => _pickDocument(entry.key),
//                   onViewPressed: () => _viewDocument(entry.key),
//                   onRemovePressed: () => _removeDocument(entry.key),
//                 ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: 'Declaration',
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: _declarationAccepted
//                     ? _successColor.withOpacity(0.05)
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: _declarationAccepted ? _successColor : _borderColor,
//                   width: _declarationAccepted ? 1.5 : 1,
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _declarationAccepted,
//                     onChanged: (value) => setState(() => _declarationAccepted = value ?? false),
//                     activeColor: _primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF0C4A6E),
//                         height: 1.5,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             // Fix: Check if Signature exists in uploadedFiles
//             if (_uploadedFiles.containsKey('Signature'))
//               _buildDocumentUploadItem(
//                 documentName: 'Signature',
//                 fileInfo: _uploadedFiles['Signature']!,
//                 onUploadPressed: () => _pickDocument('Signature'),
//                 onViewPressed: () => _viewDocument('Signature'),
//                 onRemovePressed: () => _removeDocument('Signature'),
//                 isOptional: false,
//                 signatureHint: 'Upload scanned copy of your signature',
//               ),
//             SizedBox(height: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInputField(
//                   label: 'Name',
//                   controller: _declarationNameController,
//                   hint: 'Enter your name',
//                 ),
//                 SizedBox(height: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Date', style: TextStyle(
//                       fontWeight: FontWeight.w500, fontSize: 13,
//                     )),
//                     SizedBox(height: 8),
//                     GestureDetector(
//                       onTap: () => _selectDate(context),
//                       child: Container(
//                         height: 48,
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: _borderColor),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               _selectedDate != null
//                                   ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
//                                   : 'Select date',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: _selectedDate != null
//                                     ? _textPrimary : _textSecondary,
//                               ),
//                             ),
//                             Icon(Icons.calendar_today, size: 18, color: _textSecondary),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//   Widget _buildCard({required String title, required List<Widget> children}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _borderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           )),
//           SizedBox(height: 16),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//           color: _textPrimary,
//         )),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hint,
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: _borderColor),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSmallInput({
//     required String label,
//     required TextEditingController controller,
//     required ValueChanged<String> onChanged,
//     required String hint,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//           color: _textPrimary,
//         )),
//         SizedBox(height: 8),
//         SizedBox(
//           height: 40,
//           child: TextFormField(
//             controller: controller,
//             onChanged: onChanged,
//             keyboardType: keyboardType,
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(
//               hintText: hint,
//               contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(6),
//                 borderSide: BorderSide(color: _borderColor),
//               ),
//               isDense: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildChip(String label) {
//     bool isSelected = _selectedHotelType == label;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedHotelType = isSelected ? null : label),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryLight : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: isSelected ? _primaryColor : _borderColor),
//         ),
//         child: Text(label, style: TextStyle(
//           fontSize: 12,
//           color: isSelected ? _primaryColor : _textSecondary,
//         )),
//       ),
//     );
//   }
//
//   Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryLight : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: isSelected ? _primaryColor : _borderColor),
//         ),
//         child: Text(label, style: TextStyle(
//           fontSize: 12,
//           color: isSelected ? _primaryColor : _textSecondary,
//         )),
//       ),
//     );
//   }
//
//   // Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(title, style: TextStyle(
//   //         fontSize: 13,
//   //         fontWeight: FontWeight.w600,
//   //         color: _textPrimary,
//   //       )),
//   //       SizedBox(height: 8),
//   //       Wrap(
//   //         spacing: 8,
//   //         runSpacing: 8,
//   //         children: amenities.entries.map((entry) {
//   //           bool isSelected = entry.value;
//   //           return GestureDetector(
//   //             onTap: () => setState(() => amenities[entry.key] = !isSelected),
//   //             child: Container(
//   //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//   //               decoration: BoxDecoration(
//   //                 color: isSelected ? _primaryLight : Colors.white,
//   //                 borderRadius: BorderRadius.circular(16),
//   //                 border: Border.all(
//   //                   color: isSelected ? _primaryColor : _borderColor,
//   //                 ),
//   //               ),
//   //               child: Row(
//   //                 mainAxisSize: MainAxisSize.min,
//   //                 children: [
//   //                   Icon(
//   //                     isSelected ? Icons.check_circle : Icons.circle_outlined,
//   //                     size: 14,
//   //                     color: isSelected ? _primaryColor : _textSecondary,
//   //                   ),
//   //                   SizedBox(width: 4),
//   //                   Text(entry.key, style: TextStyle(
//   //                     fontSize: 12,
//   //                     color: isSelected ? _primaryColor : _textSecondary,
//   //                   )),
//   //                 ],
//   //               ),
//   //             ),
//   //           );
//   //         }).toList(),
//   //       ),
//   //     ],
//   //   );
//   // }
//   Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           ),
//         ),
//         SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: amenities.entries.map((entry) {
//             bool isSelected = entry.value;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   amenities[entry.key] = !isSelected;
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: isSelected ? _primaryLight : Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: isSelected ? _primaryColor : _borderColor,
//                     width: isSelected ? 2 : 1,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       isSelected ? Icons.check_circle : Icons.circle_outlined,
//                       size: 14,
//                       color: isSelected ? _primaryColor : _textSecondary,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       entry.key,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: isSelected ? _primaryColor : _textSecondary,
//                         fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//   Widget _buildPhotoUploadItem() {
//     final isUploaded = _personPhotoInfo['uploaded'] as bool? ?? false;
//     final fileName = _personPhotoInfo['name'] as String? ?? '';
//     final filePath = _personPhotoInfo['path'] as String?;
//
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isUploaded ? _successColor : _borderColor,
//           width: isUploaded ? 1.5 : 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.person, size: 18,
//                       color: isUploaded ? _successColor : _primaryColor),
//                   SizedBox(width: 8),
//                   Text('Profile Photo', style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 13,
//                     color: isUploaded ? _successColor : _textPrimary,
//                   )),
//                 ],
//               ),
//               if (isUploaded) Row(
//                 children: [
//                   Icon(Icons.check_circle, color: _successColor, size: 16),
//                   SizedBox(width: 4),
//                   Text('Uploaded', style: TextStyle(
//                     fontSize: 11,
//                     color: _successColor,
//                     fontWeight: FontWeight.w500,
//                   )),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           if (!isUploaded) SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _pickPersonPhoto,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _primaryColor,
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.photo_camera, size: 16, color: Colors.white),
//                   SizedBox(width: 8),
//                   Text('Upload Photo', style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//             ),
//           ),
//           if (isUploaded && fileName.isNotEmpty) Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: _primaryLight,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: _primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Center(
//                     child: Icon(Icons.photo, size: 20, color: _primaryColor),
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(fileName, style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12,
//                         color: _textPrimary,
//                       ), maxLines: 1, overflow: TextOverflow.ellipsis),
//                       SizedBox(height: 2),
//                       Text('Photo uploaded successfully',
//                           style: TextStyle(fontSize: 10, color: _textSecondary)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: _viewPersonPhoto,
//                       icon: Icon(Icons.remove_red_eye, size: 18, color: _primaryColor),
//                       padding: EdgeInsets.all(4),
//                       tooltip: 'View',
//                     ),
//                     IconButton(
//                       onPressed: _removePersonPhoto,
//                       icon: Icon(Icons.delete, size: 18, color: Colors.red),
//                       padding: EdgeInsets.all(4),
//                       tooltip: 'Remove',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDocumentUploadItem({
//     required String documentName,
//     required Map<String, dynamic> fileInfo,
//     required VoidCallback onUploadPressed,
//     required VoidCallback onViewPressed,
//     required VoidCallback onRemovePressed,
//     bool isOptional = false,
//     String? optionalText,
//     String? signatureHint,
//   }) {
//     final fileName = fileInfo['name'] as String? ?? '';
//     final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
//     final fileSize = (fileInfo['size'] as int?) ?? 0;
//
//     IconData getDocumentIcon() {
//       if (documentName.contains('Signature')) return Icons.draw;
//       if (documentName.contains('GST')) return Icons.receipt;
//       if (documentName.contains('FSSAI')) return Icons.restaurant;
//       if (documentName.contains('License')) return Icons.badge;
//       if (documentName.contains('Cheque')) return Icons.account_balance;
//       if (documentName.contains('Photos')) return Icons.photo_library;
//       if (documentName.contains('Proof')) return Icons.perm_identity;
//       return Icons.description;
//     }
//
//     Color getIconColor() {
//       if (isUploaded) return _successColor;
//       if (documentName.contains('Signature')) return Colors.red;
//       if (documentName.contains('FSSAI')) return Colors.red;
//       return _primaryColor;
//     }
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isUploaded ? _successColor : _borderColor,
//           width: isUploaded ? 1.5 : 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(getDocumentIcon(), size: 18, color: getIconColor()),
//                   SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(documentName, style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                         color: isUploaded ? _successColor : _textPrimary,
//                       )),
//                       if (isOptional && optionalText != null) Text(optionalText,
//                           style: TextStyle(fontSize: 10, color: _textSecondary)),
//                       if (signatureHint != null) Text(signatureHint,
//                           style: TextStyle(fontSize: 10, color: _textSecondary)),
//                     ],
//                   ),
//                 ],
//               ),
//               if (isUploaded) Row(
//                 children: [
//                   Icon(Icons.check_circle, color: _successColor, size: 16),
//                   SizedBox(width: 4),
//                   Text('Uploaded', style: TextStyle(
//                     fontSize: 11,
//                     color: _successColor,
//                     fontWeight: FontWeight.w500,
//                   )),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           if (!isUploaded) SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: onUploadPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _primaryColor,
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.cloud_upload, size: 16, color: Colors.white),
//                   SizedBox(width: 8),
//                   Text(documentName.contains('Signature')
//                       ? 'Upload Signature' : 'Upload $documentName',
//                       style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//             ),
//           ),
//           if (isUploaded && fileName.isNotEmpty) Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: _primaryLight,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Row(
//               children: [
//                 if (documentName.contains('Signature')) Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.purple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Center(
//                     child: Icon(Icons.draw, size: 20, color: Colors.purple),
//                   ),
//                 ) else Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: _primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Center(child: _getFileIcon(fileName)),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(fileName, style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12,
//                         color: _textPrimary,
//                       ), maxLines: 1, overflow: TextOverflow.ellipsis),
//                       SizedBox(height: 2),
//                       Text('${(fileSize / 1024).toStringAsFixed(1)} KB • '
//                           '${_getFileExtension(fileName).toUpperCase()}',
//                           style: TextStyle(fontSize: 10, color: _textSecondary)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: onViewPressed,
//                       icon: Icon(Icons.remove_red_eye, size: 18, color: _primaryColor),
//                       padding: EdgeInsets.all(4),
//                       tooltip: 'View',
//                     ),
//                     IconButton(
//                       onPressed: onRemovePressed,
//                       icon: Icon(Icons.delete, size: 18, color: Colors.red),
//                       padding: EdgeInsets.all(4),
//                       tooltip: 'Remove',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getFileIcon(String fileName) {
//     final ext = _getFileExtension(fileName).toLowerCase();
//     if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
//       return Icon(Icons.image, size: 20, color: _primaryColor);
//     } else if (['pdf'].contains(ext)) {
//       return Icon(Icons.picture_as_pdf, size: 20, color: Colors.red);
//     } else if (['doc', 'docx'].contains(ext)) {
//       return Icon(Icons.description, size: 20, color: Colors.blue);
//     } else {
//       return Icon(Icons.insert_drive_file, size: 20, color: _primaryColor);
//     }
//   }
//
//   String _getFileExtension(String fileName) {
//     final dotIndex = fileName.lastIndexOf('.');
//     return dotIndex != -1 ? fileName.substring(dotIndex + 1) : '';
//   }
//
//   void _addLandlineField() {
//     if (_landlineControllers.length < 3) {
//       setState(() => _landlineControllers.add(TextEditingController()));
//     }
//   }
//
//   void _removeLandlineField(int index) {
//     if (_landlineControllers.length > 1) {
//       setState(() {
//         _landlineControllers[index].dispose();
//         _landlineControllers.removeAt(index);
//       });
//     }
//   }
//
//   void _addCustomAmenity() {
//     final amenity = _extraAmenitiesController.text.trim();
//     if (amenity.isNotEmpty && !_customAmenities.contains(amenity)) {
//       setState(() {
//         _customAmenities.add(amenity);
//         _extraAmenitiesController.clear();
//       });
//     }
//   }
//
//   void _removeCustomAmenity(String amenity) {
//     setState(() => _customAmenities.remove(amenity));
//   }
//
//   Future<void> _pickPersonPhoto() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         allowedExtensions: ['jpg', 'jpeg', 'png'],
//         allowMultiple: false,
//       );
//
//       if (result != null && result.files.isNotEmpty) {
//         final file = result.files.first;
//         setState(() {
//           _personPhotoInfo = {
//             'name': file.name,
//             'size': file.size,
//             'path': file.path ?? '',
//             'uploaded': true,
//           };
//         });
//       }
//     } catch (e) {
//       print('Error picking photo: $e');
//     }
//   }
//
//   void _viewPersonPhoto() {
//     final fileName = _personPhotoInfo['name'] as String? ?? '';
//     if (fileName.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Profile Photo'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: _primaryLight,
//                   borderRadius: BorderRadius.circular(8),
//                   image: _personPhotoInfo['path'] != null
//                       ? DecorationImage(
//                     image: FileImage(File(_personPhotoInfo['path'])),
//                     fit: BoxFit.cover,
//                   )
//                       : null,
//                 ),
//                 child: _personPhotoInfo['path'] == null
//                     ? Icon(Icons.person, size: 60, color: _primaryColor)
//                     : null,
//               ),
//               SizedBox(height: 16),
//               Text(fileName, textAlign: TextAlign.center,
//                   style: TextStyle(fontWeight: FontWeight.w500)),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Close'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void _removePersonPhoto() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Photo'),
//         content: Text('Are you sure you want to remove this photo?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _personPhotoInfo = {
//                   'name': '',
//                   'size': 0,
//                   'path': '',
//                   'uploaded': false,
//                 };
//               });
//               Navigator.pop(context);
//             },
//             child: Text('Remove', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _pickDocument(String documentType) async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
//         allowMultiple: false,
//       );
//
//       if (result != null && result.files.isNotEmpty) {
//         final file = result.files.first;
//         setState(() {
//           _uploadedFiles[documentType] = {
//             'name': file.name,
//             'size': file.size,
//             'path': file.path ?? '',
//             'uploaded': true,
//           };
//         });
//       }
//     } catch (e) {
//       print('Error picking document: $e');
//     }
//   }
//
//   void _viewDocument(String documentType) {
//     final fileInfo = _uploadedFiles[documentType]!;
//     final fileName = fileInfo['name'] as String? ?? '';
//     if (fileName.isNotEmpty) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Row(
//             children: [
//               Icon(documentType.contains('Signature')
//                   ? Icons.draw : Icons.description,
//                   color: documentType.contains('Signature')
//                       ? Colors.purple : _primaryColor),
//               SizedBox(width: 12),
//               Expanded(child: Text(documentType, overflow: TextOverflow.ellipsis)),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 200,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey[300]!),
//                 ),
//                 child: Center(child: _getFileIcon(fileName)),
//               ),
//               SizedBox(height: 16),
//               Text('File Details:', style: TextStyle(fontWeight: FontWeight.w500)),
//               SizedBox(height: 8),
//               Text('Name: $fileName'),
//             ],
//           ),
//           actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
//         ),
//       );
//     }
//   }
//
//   void _removeDocument(String documentType) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Remove Document'),
//         content: Text('Are you sure you want to remove this document?'),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 _uploadedFiles[documentType] = {
//                   'name': '', 'size': 0, 'path': '', 'uploaded': false,
//                 };
//               });
//               Navigator.pop(context);
//             },
//             child: Text('Remove', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() => _selectedDate = picked);
//     }
//   }
//
//   void _nextStep() {
//     if (_currentStep < _steps.length - 1) {
//       setState(() => _currentStep++);
//     } else {
//       _updateProfile();
//     }
//   }
//
//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() => _currentStep--);
//     }
//   }
//
//   // void _updateProfile() {
//   //   // Collect all updated data
//   //   Map<String, dynamic> updatedData = {
//   //     'hotelName': _hotelNameController.text,
//   //     'hotelType': _selectedHotelType,
//   //     'yearOfEstablishment': _yearController.text,
//   //     'totalRooms': int.tryParse(_roomsController.text) ?? 0,
//   //     'ownerName': _ownerNameController.text,
//   //     'mobileNumber': _mobileController.text,
//   //     'alternateContact': _altMobileController.text,
//   //     'landlineNumbers': _landlineControllers
//   //         .map((c) => c.text)
//   //         .where((text) => text.isNotEmpty)
//   //         .toList(),
//   //     'email': _emailController.text,
//   //     'website': _websiteController.text,
//   //     'addressLine1': _address1Controller.text,
//   //     'addressLine2': _address2Controller.text,
//   //     'city': _cityController.text,
//   //     'district': _districtController.text,
//   //     'state': _stateController.text,
//   //     'pinCode': _pinController.text,
//   //     'landmark': _landmarkController.text,
//   //     'selectedRoomTypes': _selectedRoomTypes,
//   //     'roomDetails': _roomDetails,
//   //     'minTariff': _minTariffController.text,
//   //     'maxTariff': _maxTariffController.text,
//   //     'extraBedAvailable': _extraBedAvailable,
//   //     'basicAmenities': _basicAmenities,
//   //     'hotelFacilities': _hotelFacilities,
//   //     'foodServices': _foodServices,
//   //     'additionalAmenities': _additionalAmenities,
//   //     'customAmenities': _customAmenities,
//   //     'gstNumber': _gstController.text,
//   //     'fssaiLicense': _fssaiController.text,
//   //     'tradeLicense': _tradeLicenseController.text,
//   //     'aadharNumber': _aadharController.text,
//   //     'accountHolderName': _accountNameController.text,
//   //     'bankName': _bankNameController.text,
//   //     'accountNumber': _accountNumberController.text,
//   //     'ifscCode': _ifscController.text,
//   //     'branch': _branchController.text,
//   //     'accountType': _accountTypeController.text,
//   //     'uploadedFiles': _uploadedFiles,
//   //     'signatureName': _signatureNameController.text,
//   //     'declarationName': _declarationNameController.text,
//   //     'declarationDate': _selectedDate,
//   //     'personPhotoInfo': _personPhotoInfo,
//   //     'declarationAccepted': _declarationAccepted,
//   //   };
//   //
//   //   // Merge with existing registration data
//   //   Map<String, dynamic> finalData = {
//   //     ...widget.registrationData,
//   //     ...updatedData,
//   //   };
//   //
//   //   // Navigate back with updated data
//   //   Navigator.pop(context, finalData);
//   // }
//
//
//   void _updateProfile() {
//
//     Map<String, dynamic> updatedData = {
//       'hotelName': _hotelNameController.text,
//       'hotelType': _selectedHotelType,
//       'yearOfEstablishment': _yearController.text,
//       'totalRooms': int.tryParse(_roomsController.text) ?? 0,
//       'ownerName': _ownerNameController.text,
//       'mobileNumber': _mobileController.text,
//       'alternateContact': _altMobileController.text,
//       'landlineNumbers': _landlineControllers
//           .map((c) => c.text)
//           .where((text) => text.isNotEmpty)
//           .toList(),
//       'email': _emailController.text,
//       'website': _websiteController.text,
//       'addressLine1': _address1Controller.text,
//       'addressLine2': _address2Controller.text,
//       'city': _cityController.text,
//       'district': _districtController.text,
//       'state': _stateController.text,
//       'pinCode': _pinController.text,
//       'landmark': _landmarkController.text,
//       'selectedRoomTypes': _selectedRoomTypes,
//       'roomDetails': _roomDetails,
//       'minTariff': _minTariffController.text,
//       'maxTariff': _maxTariffController.text,
//       'extraBedAvailable': _extraBedAvailable,
//       'basicAmenities': _basicAmenities,
//       'hotelFacilities': _hotelFacilities,
//       'foodServices': _foodServices,
//       'additionalAmenities': _additionalAmenities,
//       'customAmenities': _customAmenities,
//       'gstNumber': _gstController.text,
//       'fssaiLicense': _fssaiController.text,
//       'tradeLicense': _tradeLicenseController.text,
//       'aadharNumber': _aadharController.text,
//       'accountHolderName': _accountNameController.text,
//       'bankName': _bankNameController.text,
//       'accountNumber': _accountNumberController.text,
//       'ifscCode': _ifscController.text,
//       'branch': _branchController.text,
//       'accountType': _accountTypeController.text,
//       'uploadedFiles': _uploadedFiles,
//       'signatureName': _signatureNameController.text,
//       'declarationName': _declarationNameController.text,
//       'declarationDate': _selectedDate,
//       'personPhotoInfo': _personPhotoInfo,
//       'declarationAccepted': _declarationAccepted,
//     };
//
//     // Merge with existing registration data
//     Map<String, dynamic> finalData = {
//       ...widget.registrationData,
//       ...updatedData,
//     };
//
//     // Navigate back with updated data
//     Navigator.pop(context, finalData);
//   }
//   @override
//   void dispose() {
//     // Dispose all controllers
//     _hotelNameController.dispose();
//     _yearController.dispose();
//     _roomsController.dispose();
//     _ownerNameController.dispose();
//     _mobileController.dispose();
//     _altMobileController.dispose();
//     _emailController.dispose();
//     _websiteController.dispose();
//     _address1Controller.dispose();
//     _address2Controller.dispose();
//     _cityController.dispose();
//     _districtController.dispose();
//     _stateController.dispose();
//     _pinController.dispose();
//     _minTariffController.dispose();
//     _maxTariffController.dispose();
//     _gstController.dispose();
//     _fssaiController.dispose();
//     _tradeLicenseController.dispose();
//     _accountNameController.dispose();
//     _bankNameController.dispose();
//     _accountNumberController.dispose();
//     _ifscController.dispose();
//     _branchController.dispose();
//     _extraAmenitiesController.dispose();
//     _landmarkController.dispose();
//     _aadharController.dispose();
//     _accountTypeController.dispose();
//     _declarationNameController.dispose();
//     _signatureNameController.dispose();
//
//     for (var controller in _landlineControllers) {
//       controller.dispose();
//     }
//
//     super.dispose();
//   }
// }


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
  final int _activeRooms = 5;
  final double _occupancyRate = 84.0;
  final double _rating = 4.8;

  late int _availableRooms =
      widget.totalRooms - _activeRooms;
  late int _occupiedRooms = _activeRooms;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
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


  Widget _buildDefaultProfileImage() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Image.network(
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: Icon(Icons.person, color: Colors.white, size: 36),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(Icons.person, color: Colors.white, size: 36),
          );
        },
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
                                      child:
                                      widget.personPhotoInfo['uploaded'] ==
                                          true
                                          ? Image.network(
                                        widget.personPhotoInfo['url'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return _buildDefaultProfileImage();
                                        },
                                      )
                                          : _buildDefaultProfileImage(),
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
                                          // widget.ownerName,
                                          'John Alexandar',
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
                                                // widget.hotelName,
                                                'Raj Bhavan Hotel',
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
                                              // widget.mobileNumber,
                                              '99933366677',
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
                                                // widget.email,
                                                'hotel@gmail.com',
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
                                      value: widget.totalRooms.toString(),
                                      label: 'Total Rooms',
                                      icon: Icons.meeting_room,
                                    ),

                                    // **AVAILABLE ROOMS**
                                    _buildOverviewStat(
                                      value: _availableRooms
                                          .toString(), // You need to calculate this
                                      label: 'Available Rooms',
                                      icon: Icons.hotel,
                                      color: Colors.white,
                                    ),

                                    // **OCCUPIED ROOMS**
                                    _buildOverviewStat(
                                      value: _occupiedRooms
                                          .toString(), // You need to calculate this
                                      label: 'Occupied Rooms',
                                      icon: Icons.people,
                                      color: Colors.white,
                                    ),

                                    // **RATING**
                                    _buildOverviewStat(
                                      value: _rating.toStringAsFixed(1),
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Personal details Tab - updated with new fields
                    _PersonalDetailsTab(
                      ownerName: widget.ownerName,
                      mobileNumber: widget.mobileNumber,
                      email: widget.email,
                      aadharNumber: widget.aadharNumber,

                      personPhotoInfo: widget.personPhotoInfo,
                      alternateContact: widget.alternateContact,
                      // landlineNumbers: widget.landlineNumbers,
                      website: widget.website,
                    ),

                    // Hotel details Tab
                    _HotelDetailsTab(
                      hotelName: widget.hotelName,
                      addressLine1: widget.addressLine1,
                      addressLine2: widget.addressLine2,
                      city: widget.city,
                      district: widget.district,
                      state: widget.state,
                      pinCode: widget.pinCode,
                      totalRooms: widget.totalRooms,
                      hotelType: widget.hotelType,
                      yearOfEstablishment: widget.yearOfEstablishment,
                      website: widget.website,
                      landmark: widget.landmark,
                      hotelEmail: '',
                      hotelPhone: '',
                    ),

                    // Room Availability Tab
                    _RoomAvailabilityTab(
                      selectedRoomTypes: widget.selectedRoomTypes,
                      roomDetails: widget.roomDetails,
                      minTariff: widget.minTariff,
                      maxTariff: widget.maxTariff,
                      extraBedAvailable: widget.extraBedAvailable,
                      totalRooms: widget.totalRooms,
                    ),

                    // Amenities details Tab - updated with PAN number
                    _AmenitiesDetailsTab(
                      basicAmenities: widget.basicAmenities,
                      hotelFacilities: widget.hotelFacilities,
                      foodServices: widget.foodServices,
                      additionalAmenities: widget.additionalAmenities,
                      customAmenities: widget.customAmenities,
                      gstNumber: widget.gstNumber,
                      fssaiLicense: widget.fssaiLicense,
                      tradeLicense: widget.tradeLicense,
                      aadharNumber: widget.aadharNumber,
                    ),

                    // Bank & Documents Tab - updated with all document fields
                    _BankAndDocumentsTab(
                      accountHolderName: widget.accountHolderName,
                      bankName: widget.bankName,
                      accountNumber: widget.accountNumber,
                      ifscCode: widget.ifscCode,
                      branch: widget.branch,
                      accountType: widget.accountType,
                      gstNumber: widget.gstNumber,
                      fssaiLicense: widget.fssaiLicense,
                      tradeLicense: widget.tradeLicense,

                      uploadedFiles: widget.uploadedFiles,
                      signatureName: widget.signatureName,
                      declarationName: widget.declarationName,
                      declarationDate: widget.declarationDate,
                      declarationAccepted: widget.declarationAccepted,
                    ),
                  ],
                ),
              ),

              // Navigation Buttons at Bottom
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Previous Button
                    if (_currentTabIndex > 0)
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: _goToPreviousTab,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xFF4F46E5)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back,
                                    size: 18,
                                    color: Color(0xFF4F46E5)),
                                SizedBox(width: 8),
                                Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4F46E5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (_currentTabIndex > 0) SizedBox(width: 12),

                    // Next Button
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _goToNextTab,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4F46E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentTabIndex == _tabTitles.length - 1
                                    ? 'Finish'
                                    : 'Next',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              if (_currentTabIndex < _tabTitles.length - 1)
                                SizedBox(width: 8),
                              if (_currentTabIndex < _tabTitles.length - 1)
                                Icon(Icons.arrow_forward,
                                    size: 18,
                                    color: Colors.white),
                            ],
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
      ),


    );
  }

  void _navigateToEditProfile(BuildContext context) async {
    // Prepare registration data from current profile
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

    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHotelProfileScreen(
          registrationData: registrationData,
        ),
      ),
    );

    if (updatedData != null && updatedData is Map<String, dynamic>) {
      // Instead of popping, pass the updated data back to dashboard
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
            value: ownerName,
            isPrimary: true,
          ),

          Divider(height: 32, color: Colors.grey[200]),

          // Email Address
          _buildDetailRow(
            icon: Icons.email_outlined,
            iconColor: Color(0xFFEA4335),
            label: 'Email Address',
            value: email,
            isCopyable: true,
          ),

          Divider(height: 32, color: Colors.grey[200]),

          // Phone Number
          _buildDetailRow(
            icon: Icons.phone_android,
            iconColor: Color(0xFF34A853),
            label: 'Phone Number',
            value: mobileNumber,
            isCopyable: true,
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
    final filePath = personPhotoInfo['path'] as String?;

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

  // Controllers - initialize with existing data
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

  void _initializeDataFromRegistration() {
    final data = widget.registrationData;
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

    // Initialize controllers with existing data
    _hotelNameController = TextEditingController(text: data['hotelName'] ?? '');
    _yearController = TextEditingController(text: data['yearOfEstablishment'] ?? '');
    _roomsController = TextEditingController(text: data['totalRooms']?.toString() ?? '');
    _ownerNameController = TextEditingController(text: data['ownerName'] ?? '');
    _mobileController = TextEditingController(text: data['mobileNumber'] ?? '');
    _altMobileController = TextEditingController(text: data['alternateContact'] ?? '');
    _emailController = TextEditingController(text: data['email'] ?? '');
    _websiteController = TextEditingController(text: data['website'] ?? '');
    _address1Controller = TextEditingController(text: data['addressLine1'] ?? '');
    _address2Controller = TextEditingController(text: data['addressLine2'] ?? '');
    _cityController = TextEditingController(text: data['city'] ?? '');
    _districtController = TextEditingController(text: data['district'] ?? '');
    _stateController = TextEditingController(text: data['state'] ?? '');
    _pinController = TextEditingController(text: data['pinCode'] ?? '');
    _minTariffController = TextEditingController(text: data['minTariff'] ?? '');
    _maxTariffController = TextEditingController(text: data['maxTariff'] ?? '');
    _gstController = TextEditingController(text: data['gstNumber'] ?? '');
    _fssaiController = TextEditingController(text: data['fssaiLicense'] ?? '');
    _tradeLicenseController = TextEditingController(text: data['tradeLicense'] ?? '');
    _accountNameController = TextEditingController(text: data['accountHolderName'] ?? '');
    _bankNameController = TextEditingController(text: data['bankName'] ?? '');
    _accountNumberController = TextEditingController(text: data['accountNumber'] ?? '');
    _ifscController = TextEditingController(text: data['ifscCode'] ?? '');
    _branchController = TextEditingController(text: data['branch'] ?? '');
    _extraAmenitiesController = TextEditingController();
    _landmarkController = TextEditingController(text: data['landmark'] ?? '');
    _aadharController = TextEditingController(text: data['aadharNumber'] ?? '');
    _accountTypeController = TextEditingController(text: data['accountType'] ?? '');
    _declarationNameController = TextEditingController(text: data['declarationName'] ?? '');
    _signatureNameController = TextEditingController(text: data['signatureName'] ?? '');

    // Initialize other state variables
    _selectedHotelType = data['hotelType'] ?? '';
    _extraBedAvailable = data['extraBedAvailable'] ?? false;
    _selectedDate = data['declarationDate'];
    _declarationAccepted = data['declarationAccepted'] ?? false;

    // Initialize landline controllers
    final landlineNumbers = (data['landlineNumbers'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    _landlineControllers = landlineNumbers.isEmpty
        ? [TextEditingController()]
        : landlineNumbers.map((num) => TextEditingController(text: num)).toList();

    // Initialize room details - ensure all room types have entries
    _roomDetails = Map<String, Map<String, dynamic>>.from(data['roomDetails'] ?? {});

    // Ensure all possible room types have entries
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


    Map<String, bool> savedSelections = Map<String, bool>.from(data['selectedRoomTypes'] ?? {});
    _selectedRoomTypes = {
      'Single Room': savedSelections['Single Room'] ?? false,
      'Double Room': savedSelections['Double Room'] ?? false,
      'Deluxe Room': savedSelections['Deluxe Room'] ?? false,
      'Suite Room': savedSelections['Suite Room'] ?? false,
      'Family Room': savedSelections['Family Room'] ?? false,
      'Executive Room': savedSelections['Executive Room'] ?? false,
    };


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

  // Step 2: Hotel Address - DISABLED FIELDS for address
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
  //   // Navigate back with updated data
  //   Navigator.pop(context, finalData);
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
      'landlineNumbers': _landlineControllers
          .map((c) => c.text)
          .where((text) => text.isNotEmpty)
          .toList(),
      'email': _emailController.text,
      'website': _websiteController.text,
      'addressLine1': _address1Controller.text,
      'addressLine2': _address2Controller.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'pinCode': _pinController.text,
      'landmark': _landmarkController.text,
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

    // Option 1: If you want to pass the data back to MyProfileScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HotelOwnerProfilePage(hotelName: '', ownerName: '', mobileNumber: '', email: '', addressLine1: '', addressLine2: '', city: '', district: '', state: '', pinCode: '', gstNumber: '', fssaiLicense: '', tradeLicense: '', aadharNumber: '', accountHolderName: '', bankName: '', accountNumber: '', ifscCode: '', branch: '', accountType: '', totalRooms: 0, personPhotoInfo: {}, selectedRoomTypes: {}, roomDetails: {}, basicAmenities: {}, hotelFacilities: {}, foodServices: {}, additionalAmenities: {}, customAmenities: []),
      ),
          (route) => false, // Remove all previous routes
    );


  }
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

    for (var controller in _landlineControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}



//
// class TwoStarHotelRegistrationScreen extends StatefulWidget {
//   const TwoStarHotelRegistrationScreen({super.key});
//
//   @override
//   State<TwoStarHotelRegistrationScreen> createState() => _TwoStarHotelRegistrationScreenState();
// }
//
// class _TwoStarHotelRegistrationScreenState extends State<TwoStarHotelRegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   int _currentStep = 0;
//
//
//   final Color _primaryColor = Color(0xFF6B8E23);
//   final Color _primaryLight = Color(0xFFF0F8E0);
//   final Color _bgColor = Color(0xFFFAFAFA);
//   final Color _cardColor = Colors.white;
//   final Color _borderColor = Color(0xFFE5E7EB);
//   final Color _textPrimary = Color(0xFF111827);
//   final Color _textSecondary = Color(0xFF6B7280);
//   final Color _successColor = Color(0xFF8BC34A);
//
//
//   final TextEditingController _hotelNameController = TextEditingController();
//   final TextEditingController _yearController = TextEditingController();
//   final TextEditingController _roomsController = TextEditingController();
//   final TextEditingController _ownerNameController = TextEditingController();
//   final TextEditingController _designationController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _altMobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _websiteController = TextEditingController();
//   final TextEditingController _address1Controller = TextEditingController();
//   final TextEditingController _address2Controller = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _districtController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _checkInController = TextEditingController(text: '14:00');
//   final TextEditingController _checkOutController = TextEditingController(text: '12:00');
//   final TextEditingController _minTariffController = TextEditingController();
//   final TextEditingController _maxTariffController = TextEditingController();
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _tradeLicenseController = TextEditingController();
//   final TextEditingController _fssaiController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _accountNameController = TextEditingController();
//   final TextEditingController _bankNameController = TextEditingController();
//   final TextEditingController _accountNumberController = TextEditingController();
//   final TextEditingController _ifscController = TextEditingController();
//   final TextEditingController _branchController = TextEditingController();
//   final TextEditingController _declarationNameController = TextEditingController();
//
//   // Room Details
//   final Map<String, Map<String, dynamic>> _roomDetails = {
//     'Single Room': {
//       'rooms': '',
//       'occupancy': '',
//       'ac': true,
//       'bedType': 'Single',
//       'price': '',
//     },
//     'Double Room': {
//       'rooms': '',
//       'occupancy': '',
//       'ac': true,
//       'bedType': 'Double',
//       'price': '',
//     },
//     'Deluxe Room': {
//       'rooms': '',
//       'occupancy': '',
//       'ac': true,
//       'bedType': 'Queen',
//       'price': '',
//     },
//   };
//
//   // Selected Room Types
//   Map<String, bool> _selectedRoomTypes = {
//     'Single Room': false,
//     'Double Room': false,
//     'Deluxe Room': false,
//   };
//
//   // Hotel Type Selection
//   String? _selectedHotelType;
//
//   // Extra Bed Facility
//   bool _extraBedAvailable = false;
//
//   // Amenities
//   Map<String, bool> _roomAmenities = {
//     'Air Conditioning': false,
//     'Free Wi-Fi': false,
//     'Television (Cable/DTH)': false,
//     'Attached Bathroom': false,
//     'Hot & Cold Water': false,
//     'Wardrobe / Storage': false,
//     'Study Table & Chair': false,
//   };
//
//   Map<String, bool> _hotelFacilities = {
//     '24-Hour Front Desk': false,
//     'Daily Housekeeping': false,
//     'Power Backup': false,
//     'Lift / Elevator': false,
//     'Parking Facility': false,
//     'CCTV Surveillance': false,
//     'Fire Safety Equipment': false,
//   };
//
//   Map<String, bool> _foodServices = {
//     'In-House Restaurant': false,
//     'Complimentary Breakfast': false,
//     'Room Service (Limited Hours)': false,
//     'Drinking Water (Complimentary)': false,
//   };
//
//   Map<String, bool> _guestServices = {
//     'Laundry / Ironing Service': false,
//     'Wake-up Call Service': false,
//     'Travel Desk / Taxi Assistance': false,
//     'Doctor on Call': false,
//   };
//
//   // ID Proof Requirements
//   Map<String, bool> _idProofs = {
//     'Aadhaar': true,
//     'Passport': false,
//     'Driving License': false,
//   };
//
//   // Policies
//   bool _coupleFriendly = true;
//   bool _petsAllowed = false;
//
//   // Document Uploads
//   final Map<String, Map<String, dynamic>> _uploadedFiles = {
//     'GST Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//     'Trade License': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//     'FSSAI Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//     'Cancelled Cheque': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//     'Hotel Registration Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//     'Room & Property Photos': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
//   };
//
//   // Declaration
//   bool _declarationAccepted = false;
//   DateTime? _selectedDate;
//
//   // Steps
//   final List<Map<String, dynamic>> _steps = [
//     {'title': 'Hotel Info', 'subtitle': 'Basic hotel details'},
//     {'title': 'Contact & Address', 'subtitle': 'Contact and location'},
//     {'title': 'Room Configuration', 'subtitle': 'Room types and rates'},
//     {'title': 'Amenities & Policies', 'subtitle': 'Facilities and rules'},
//     {'title': 'Legal & Documents', 'subtitle': 'Compliance and files'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _bgColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: _textPrimary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           '2-Star Hotel Vendor Registration Form',
//           style: TextStyle(
//             fontSize: 17.5,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             // Progress Steps
//             Container(
//               padding: EdgeInsets.all(5),
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(_steps.length, (index) {
//                         bool isActive = index == _currentStep;
//                         bool isCompleted = index < _currentStep;
//
//                         return Container(
//                           margin: EdgeInsets.symmetric(horizontal: 2),
//                           child: GestureDetector(
//                             onTap: () {
//                               if (index <= _currentStep) {
//                                 setState(() {
//                                   _currentStep = index;
//                                 });
//                               }
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 32,
//                                   height: 32,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: isActive
//                                         ? _primaryColor
//                                         : isCompleted
//                                         ? _successColor
//                                         : Colors.white,
//                                     border: Border.all(
//                                       color: isActive || isCompleted
//                                           ? Colors.transparent
//                                           : _borderColor,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: isCompleted
//                                         ? Icon(
//                                       Icons.check,
//                                       size: 18,
//                                       color: Colors.white,
//                                     )
//                                         : Text(
//                                       '${index + 1}',
//                                       style: TextStyle(
//                                         color: isActive || isCompleted
//                                             ? Colors.white
//                                             : _textSecondary,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 SizedBox(
//                                   width: 70,
//                                   child: Text(
//                                     _steps[index]['title'],
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w500,
//                                       color: isActive || isCompleted
//                                           ? _textPrimary
//                                           : _textSecondary,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   LinearProgressIndicator(
//                     value: (_currentStep + 1) / _steps.length,
//                     backgroundColor: _borderColor,
//                     color: _primaryColor,
//                     minHeight: 4,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Step ${_currentStep + 1} of ${_steps.length}',
//                         style: TextStyle(fontSize: 12, color: _textSecondary),
//                       ),
//                       Text(
//                         '${((_currentStep + 1) / _steps.length * 100).toInt()}%',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: _primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Step Header
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: _cardColor,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: _borderColor),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: _primaryLight,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 '${_currentStep + 1}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: _primaryColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   _steps[_currentStep]['title'],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: _textPrimary,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   _steps[_currentStep]['subtitle'],
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: _textSecondary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: _primaryColor,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.star, size: 14, color: Colors.white),
//                                 SizedBox(width: 4),
//                                 Text(
//                                   '2-Star',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // Step Content
//                     _buildStepContent(),
//                     SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Navigation Buttons
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(top: BorderSide(color: _borderColor)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   if (_currentStep > 0)
//                     Expanded(
//                       child: SizedBox(
//                         height: 55,
//                         child: OutlinedButton(
//                           onPressed: _previousStep,
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: _borderColor),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Back',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: _textPrimary,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   if (_currentStep > 0) SizedBox(width: 12),
//                   Expanded(
//                     child: SizedBox(
//                       height: 58,
//                       child: ElevatedButton(
//                         onPressed: _nextStep,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: Text(
//                           _currentStep == _steps.length - 1
//                               ? 'Submit Registration'
//                               : 'Continue',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStepContent() {
//     switch (_currentStep) {
//       case 0:
//         return _buildStep1(); // Hotel Information
//       case 1:
//         return _buildStep2(); // Contact & Address
//       case 2:
//         return _buildStep3(); // Room Configuration
//       case 3:
//         return _buildStep4(); // Amenities & Policies
//       case 4:
//         return _buildStep5(); // Legal & Documents
//       default:
//         return Container();
//     }
//   }
//
//   // Step 1: Hotel Information
//   Widget _buildStep1() {
//     return Column(
//       children: [
//         _buildCard(
//           title: '1. Hotel Information',
//           children: [
//             _buildInputField(
//               label: 'Hotel Name *',
//               controller: _hotelNameController,
//               hint: 'Enter hotel name',
//             ),
//             SizedBox(height: 16),
//
//             // Hotel Category (Fixed as 2-Star)
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: _primaryLight,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: _primaryColor.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: _primaryColor,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Center(
//                       child: Icon(Icons.star, size: 18, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Hotel Category',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                             color: _textSecondary,
//                           ),
//                         ),
//                         Text(
//                           '2-Star Hotel',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: _primaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Hotel Type
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hotel Type *',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: _textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: [
//                     'Business',
//                     'Family',
//                     'Tourist',
//                     'Lodge',
//                   ].map((type) => _buildHotelTypeChip(type)).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Year of Establishment',
//                     controller: _yearController,
//                     hint: 'YYYY',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Total Number of Rooms',
//                     controller: _roomsController,
//                     hint: '0',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Step 2: Contact & Address
//   Widget _buildStep2() {
//     return Column(
//       children: [
//         _buildCard(
//           title: '2. Contact Details',
//           children: [
//             _buildInputField(
//               label: 'Owner / Authorized Person Name *',
//               controller: _ownerNameController,
//               hint: 'Enter full name',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Designation',
//               controller: _designationController,
//               hint: 'e.g., Owner, Manager',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Mobile Number *',
//               controller: _mobileController,
//               hint: 'Enter 10-digit mobile number',
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Alternate Contact Number',
//               controller: _altMobileController,
//               hint: 'Optional',
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Email ID',
//               controller: _emailController,
//               hint: 'example@email.com',
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Website / Booking Link (if any)',
//               controller: _websiteController,
//               hint: 'https://example.com',
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: '3. Hotel Address',
//           children: [
//             _buildInputField(
//               label: 'Address Line 1 *',
//               controller: _address1Controller,
//               hint: 'Street address',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Address Line 2',
//               controller: _address2Controller,
//               hint: 'Apartment, suite, etc.',
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'City *',
//                     controller: _cityController,
//                     hint: 'Enter city',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'District *',
//                     controller: _districtController,
//                     hint: 'Enter district',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'State *',
//                     controller: _stateController,
//                     hint: 'Enter state',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'PIN Code *',
//                     controller: _pinController,
//                     hint: '6-digit PIN',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Step 3: Room Configuration
//   Widget _buildStep3() {
//     return Column(
//       children: [
//         _buildCard(
//           title: '4. Room Details',
//           children: [
//             // Room Types Selection
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Select Room Types Available:',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: _textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: _selectedRoomTypes.entries.map((entry) {
//                     bool isSelected = entry.value;
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedRoomTypes[entry.key] = !isSelected;
//                         });
//                       },
//                       child: Container(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: isSelected ? _primaryLight : Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: isSelected ? _primaryColor : _borderColor,
//                             width: isSelected ? 2 : 1,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               isSelected
//                                   ? Icons.check_circle
//                                   : Icons.circle_outlined,
//                               size: 16,
//                               color: isSelected ? _primaryColor : _textSecondary,
//                             ),
//                             SizedBox(width: 6),
//                             Text(
//                               entry.key,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: isSelected ? _primaryColor : _textSecondary,
//                                 fontWeight: isSelected
//                                     ? FontWeight.w600
//                                     : FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//
//             // Room Configuration for selected types
//             if (_selectedRoomTypes.entries.any((entry) => entry.value))
//               Column(
//                 children: [
//                   Text(
//                     'Configure selected room types:',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: _textPrimary,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ..._selectedRoomTypes.entries
//                       .where((entry) => entry.value)
//                       .map((entry) {
//                     String roomType = entry.key;
//                     return Container(
//                       margin: EdgeInsets.only(bottom: 16),
//                       child: _buildRoomConfigurationCard(roomType),
//                     );
//                   }).toList(),
//                 ],
//               ),
//
//             SizedBox(height: 20),
//             Divider(color: _borderColor),
//             SizedBox(height: 20),
//
//             // Extra Bed Facility
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Extra Bed Facility:',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: _textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     _buildToggleChip('Yes', _extraBedAvailable, () {
//                       setState(() => _extraBedAvailable = true);
//                     }),
//                     SizedBox(width: 12),
//                     _buildToggleChip('No', !_extraBedAvailable, () {
//                       setState(() => _extraBedAvailable = false);
//                     }),
//                   ],
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             // Room Tariff
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Room Tariff (per night):',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: _textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _minTariffController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Minimum',
//                           prefixText: '₹ ',
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: _borderColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Text('to', style: TextStyle(color: _textSecondary)),
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                         controller: _maxTariffController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Maximum',
//                           prefixText: '₹ ',
//                           contentPadding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: _borderColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Step 4: Amenities & Policies
//   Widget _buildStep4() {
//     return Column(
//       children: [
//         _buildCard(
//           title: '5. Amenities Available',
//           children: [
//             // Room Amenities
//             _buildAmenitiesSection('Room Amenities', _roomAmenities),
//             SizedBox(height: 20),
//
//             // Hotel Facilities
//             _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
//             SizedBox(height: 20),
//
//             // Food & Beverage
//             _buildAmenitiesSection('Food & Beverage', _foodServices),
//             SizedBox(height: 20),
//
//             // Guest Services
//             _buildAmenitiesSection('Guest Services', _guestServices),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: '6. Check-in & Policies',
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Standard Check-in Time',
//                     controller: _checkInController,
//                     hint: 'HH:MM',
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Standard Check-out Time',
//                     controller: _checkOutController,
//                     hint: 'HH:MM',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//
//             // ID Proof Required
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ID Proof Required:',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: _textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Wrap(
//                   spacing: 12,
//                   runSpacing: 8,
//                   children: _idProofs.entries.map((entry) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _idProofs[entry.key] = !entry.value;
//                         });
//                       },
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Checkbox(
//                             value: entry.value,
//                             onChanged: (value) {
//                               setState(() {
//                                 _idProofs[entry.key] = value ?? false;
//                               });
//                             },
//                             activeColor: _primaryColor,
//                           ),
//                           Text(entry.key,
//                               style: TextStyle(fontSize: 13)),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//
//             // Policies
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Couple Friendly:',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           _buildToggleChip('Yes', _coupleFriendly, () {
//                             setState(() => _coupleFriendly = true);
//                           }),
//                           SizedBox(width: 8),
//                           _buildToggleChip('No', !_coupleFriendly, () {
//                             setState(() => _coupleFriendly = false);
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pets Allowed:',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           _buildToggleChip('Yes', _petsAllowed, () {
//                             setState(() => _petsAllowed = true);
//                           }),
//                           SizedBox(width: 8),
//                           _buildToggleChip('No', !_petsAllowed, () {
//                             setState(() => _petsAllowed = false);
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Step 5: Legal & Documents
//   Widget _buildStep5() {
//     return Column(
//       children: [
//         _buildCard(
//           title: '7. Legal & Compliance Details',
//           children: [
//             _buildInputField(
//               label: 'GST Number',
//               controller: _gstController,
//               hint: 'Enter GST number',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Trade License Number',
//               controller: _tradeLicenseController,
//               hint: 'Enter trade license number',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'FSSAI License No. (if restaurant)',
//               controller: _fssaiController,
//               hint: 'Optional',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'PAN Number',
//               controller: _panController,
//               hint: 'Enter PAN number',
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: '8. Bank Details (Payment Settlement)',
//           children: [
//             _buildInputField(
//               label: 'Account Holder Name *',
//               controller: _accountNameController,
//               hint: 'Enter name as per bank',
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Bank Name *',
//               controller: _bankNameController,
//               hint: 'Enter bank name',
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'Account Number *',
//                     controller: _accountNumberController,
//                     hint: 'Enter account number',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: _buildInputField(
//                     label: 'IFSC Code *',
//                     controller: _ifscController,
//                     hint: 'Enter IFSC code',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             _buildInputField(
//               label: 'Branch',
//               controller: _branchController,
//               hint: 'Enter branch name',
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: '9. Documents to be Submitted',
//           children: [
//             Text(
//               'Please upload clear scanned copies of the following documents:',
//               style: TextStyle(fontSize: 12, color: _textSecondary),
//             ),
//             SizedBox(height: 16),
//             ..._uploadedFiles.entries.map((entry) {
//               return _buildDocumentUploadItem(
//                 documentName: entry.key,
//                 fileInfo: entry.value,
//                 onUploadPressed: () => _pickDocument(entry.key),
//                 onViewPressed: () => _viewDocument(entry.key),
//                 onRemovePressed: () => _removeDocument(entry.key),
//                 isOptional: entry.key == 'FSSAI Certificate',
//               );
//             }).toList(),
//           ],
//         ),
//         SizedBox(height: 16),
//         _buildCard(
//           title: '10. Declaration',
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: _declarationAccepted
//                     ? _successColor.withOpacity(0.05)
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: _declarationAccepted ? _successColor : _borderColor,
//                   width: _declarationAccepted ? 1.5 : 1,
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _declarationAccepted,
//                     onChanged: (value) {
//                       setState(() {
//                         _declarationAccepted = value ?? false;
//                       });
//                     },
//                     activeColor: _primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'I hereby confirm that all the information provided above is true and accurate. I agree to abide by the terms and conditions of the company/platform.',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF0C4A6E),
//                         height: 1.5,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInputField(
//                   label: 'Authorized Signatory Name & Designation',
//                   controller: _declarationNameController,
//                   hint: 'Enter name and designation',
//                 ),
//                 SizedBox(height: 16),
//
//                 // Date
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Date',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     GestureDetector(
//                       onTap: () => _selectDate(context),
//                       child: Container(
//                         height: 48,
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: _borderColor),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               _selectedDate != null
//                                   ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
//                                   : 'Select date',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: _selectedDate != null
//                                     ? _textPrimary
//                                     : _textSecondary,
//                               ),
//                             ),
//                             Icon(
//                               Icons.calendar_today,
//                               size: 18,
//                               color: _textSecondary,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Helper Widgets
//   Widget _buildCard({required String title, required List<Widget> children}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _cardColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _borderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: _textPrimary,
//             ),
//           ),
//           SizedBox(height: 16),
//           ...children,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     required String hint,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             color: _textPrimary,
//           ),
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hint,
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: _borderColor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: _borderColor),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: _primaryColor),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHotelTypeChip(String type) {
//     bool isSelected = _selectedHotelType == type;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedHotelType = isSelected ? null : type;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryLight : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected ? _primaryColor : _borderColor,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Text(
//           type,
//           style: TextStyle(
//             fontSize: 12,
//             color: isSelected ? _primaryColor : _textSecondary,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoomConfigurationCard(String roomType) {
//     final details = _roomDetails[roomType]!;
//
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: _borderColor),
//       ),
//       child: Column(
//         children: [
//           Text(
//             roomType,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: _primaryColor,
//             ),
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildSmallInput(
//                   label: 'No. of Rooms',
//                   controller: TextEditingController(text: details['rooms']),
//                   onChanged: (value) => details['rooms'] = value,
//                   hint: '0',
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: _buildSmallInput(
//                   label: 'Max Occupancy',
//                   controller: TextEditingController(text: details['occupancy']),
//                   onChanged: (value) => details['occupancy'] = value,
//                   hint: 'Persons',
//                   keyboardType: TextInputType.number,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'AC / Non-AC',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         _buildToggleChip('AC', details['ac'], () {
//                           setState(() => details['ac'] = true);
//                         }),
//                         SizedBox(width: 8),
//                         _buildToggleChip('Non-AC', !details['ac'], () {
//                           setState(() => details['ac'] = false);
//                         }),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Bed Type',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: _borderColor),
//                       ),
//                       child: Text(
//                         details['bedType'],
//                         style: TextStyle(fontSize: 13),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           _buildSmallInput(
//             label: 'Price per Night (₹)',
//             controller: TextEditingController(text: details['price']),
//             onChanged: (value) => details['price'] = value,
//             hint: '0',
//             keyboardType: TextInputType.number,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSmallInput({
//     required String label,
//     required TextEditingController controller,
//     required ValueChanged<String> onChanged,
//     required String hint,
//     TextInputType? keyboardType,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//             color: _textPrimary,
//           ),
//         ),
//         SizedBox(height: 8),
//         SizedBox(
//           height: 40,
//           child: TextFormField(
//             controller: controller,
//             onChanged: onChanged,
//             keyboardType: keyboardType,
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(
//               hintText: hint,
//               contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(6),
//                 borderSide: BorderSide(color: _borderColor),
//               ),
//               isDense: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryLight : Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected ? _primaryColor : _borderColor,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: isSelected ? _primaryColor : _textSecondary,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAmenitiesSection(String title, Map<String, bool> amenities) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: _textPrimary,
//           ),
//         ),
//         SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: amenities.entries.map((entry) {
//             bool isSelected = entry.value;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   amenities[entry.key] = !isSelected;
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: isSelected ? _primaryLight : Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: isSelected ? _primaryColor : _borderColor,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       isSelected ? Icons.check_circle : Icons.circle_outlined,
//                       size: 14,
//                       color: isSelected ? _primaryColor : _textSecondary,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       entry.key,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: isSelected ? _primaryColor : _textSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDocumentUploadItem({
//     required String documentName,
//     required Map<String, dynamic> fileInfo,
//     required VoidCallback onUploadPressed,
//     required VoidCallback onViewPressed,
//     required VoidCallback onRemovePressed,
//     bool isOptional = false,
//   }) {
//     final fileName = fileInfo['name'] as String? ?? '';
//     final isUploaded = (fileInfo['uploaded'] as bool?) ?? false;
//     final fileSize = (fileInfo['size'] as int?) ?? 0;
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isUploaded ? _successColor.withOpacity(0.05) : Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isUploaded ? _successColor : _borderColor,
//           width: isUploaded ? 1.5 : 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.description, size: 18, color: _primaryColor),
//                   SizedBox(width: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         documentName,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 13,
//                           color: isUploaded ? _successColor : _textPrimary,
//                         ),
//                       ),
//                       if (isOptional)
//                         Text(
//                           'Optional',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.orange,
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//               if (isUploaded)
//                 Row(
//                   children: [
//                     Icon(Icons.check_circle, color: _successColor, size: 16),
//                     SizedBox(width: 4),
//                     Text(
//                       'Uploaded',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: _successColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//           SizedBox(height: 8),
//
//           if (!isUploaded)
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onUploadPressed,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _primaryColor,
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 child: Text(
//                   'Upload $documentName',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//
//           if (isUploaded && fileName.isNotEmpty)
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: _primaryLight,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: _primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Center(
//                       child: Icon(Icons.insert_drive_file,
//                           size: 20, color: _primaryColor),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           fileName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 12,
//                             color: _textPrimary,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         SizedBox(height: 2),
//                         Text(
//                           '${(fileSize / 1024).toStringAsFixed(1)} KB',
//                           style:
//                           TextStyle(fontSize: 10, color: _textSecondary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: onViewPressed,
//                         icon: Icon(
//                           Icons.remove_red_eye,
//                           size: 18,
//                           color: _primaryColor,
//                         ),
//                         padding: EdgeInsets.all(4),
//                         tooltip: 'View',
//                       ),
//                       IconButton(
//                         onPressed: onRemovePressed,
//                         icon: Icon(Icons.delete, size: 18, color: Colors.red),
//                         padding: EdgeInsets.all(4),
//                         tooltip: 'Remove',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Navigation Methods
//   void _nextStep() {
//     if (_currentStep < _steps.length - 1) {
//       setState(() {
//         _currentStep++;
//       });
//     } else {
//       _submitForm();
//     }
//   }
//
//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() {
//         _currentStep--;
//       });
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
//
//   // File Upload Methods (simplified - you can implement actual file upload)
//   Future<void> _pickDocument(String documentType) async {
//     // Implement file picking logic
//     print('Picking document: $documentType');
//   }
//
//   void _viewDocument(String documentType) {
//     // Implement document viewing
//     print('Viewing document: $documentType');
//   }
//
//   void _removeDocument(String documentType) {
//     // Implement document removal
//     setState(() {
//       _uploadedFiles[documentType] = {
//         'name': '',
//         'size': 0,
//         'path': '',
//         'uploaded': false,
//       };
//     });
//   }
//
//   void _submitForm() {
//     if (!_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please fill all required fields correctly'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     if (!_declarationAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please accept the declaration to proceed'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }
//
//     // Collect form data
//     Map<String, dynamic> formData = {
//       'hotelName': _hotelNameController.text,
//       'hotelCategory': '2-Star',
//       'hotelType': _selectedHotelType,
//       'yearOfEstablishment': _yearController.text,
//       'totalRooms': _roomsController.text,
//       'ownerName': _ownerNameController.text,
//       'designation': _designationController.text,
//       'mobileNumber': _mobileController.text,
//       'alternateContact': _altMobileController.text,
//       'email': _emailController.text,
//       'website': _websiteController.text,
//       'addressLine1': _address1Controller.text,
//       'addressLine2': _address2Controller.text,
//       'city': _cityController.text,
//       'district': _districtController.text,
//       'state': _stateController.text,
//       'pinCode': _pinController.text,
//       'selectedRoomTypes': _selectedRoomTypes,
//       'roomDetails': _roomDetails,
//       'extraBedAvailable': _extraBedAvailable,
//       'roomTariff': {
//         'min': _minTariffController.text,
//         'max': _maxTariffController.text,
//       },
//       'checkInTime': _checkInController.text,
//       'checkOutTime': _checkOutController.text,
//       'roomAmenities': _roomAmenities,
//       'hotelFacilities': _hotelFacilities,
//       'foodServices': _foodServices,
//       'guestServices': _guestServices,
//       'idProofRequired': _idProofs,
//       'coupleFriendly': _coupleFriendly,
//       'petsAllowed': _petsAllowed,
//       'gstNumber': _gstController.text,
//       'tradeLicense': _tradeLicenseController.text,
//       'fssaiLicense': _fssaiController.text,
//       'panNumber': _panController.text,
//       'bankDetails': {
//         'accountHolderName': _accountNameController.text,
//         'bankName': _bankNameController.text,
//         'accountNumber': _accountNumberController.text,
//         'ifscCode': _ifscController.text,
//         'branch': _branchController.text,
//       },
//       'uploadedFiles': _uploadedFiles,
//       'declarationName': _declarationNameController.text,
//       'declarationDate': _selectedDate,
//       'declarationAccepted': _declarationAccepted,
//     };
//
//     // Navigate to summary or submit
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RegistrationSummaryScreen(
//           formData: formData,
//           isTwoStar: true, hotelName: '', yearOfEstablishment: '', totalRooms: '', ownerName: '', mobileNumber: '', alternateContact: '', landlineNumbers: [], email: '', website: '', addressLine1: '', addressLine2: '', city: '', district: '', state: '', pinCode: '', landmark: '', selectedRoomTypes: {}, roomDetails: {}, minTariff: '', maxTariff: '', extraBedAvailable: true, basicAmenities: {}, hotelFacilities: {}, foodServices: {}, additionalAmenities: {}, customAmenities: [], gstNumber: '', fssaiLicense: '', tradeLicense: '', panNumber: '', aadharNumber: '', accountHolderName: '', bankName: '', accountNumber: '', ifscCode: '', branch: '', accountType: '', uploadedFiles: {}, signatureName: '', declarationName: '', personPhotoInfo: {}, declarationAccepted: true,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers
//     _hotelNameController.dispose();
//     _yearController.dispose();
//     _roomsController.dispose();
//     _ownerNameController.dispose();
//     _designationController.dispose();
//     _mobileController.dispose();
//     _altMobileController.dispose();
//     _emailController.dispose();
//     _websiteController.dispose();
//     _address1Controller.dispose();
//     _address2Controller.dispose();
//     _cityController.dispose();
//     _districtController.dispose();
//     _stateController.dispose();
//     _pinController.dispose();
//     _checkInController.dispose();
//     _checkOutController.dispose();
//     _minTariffController.dispose();
//     _maxTariffController.dispose();
//     _gstController.dispose();
//     _tradeLicenseController.dispose();
//     _fssaiController.dispose();
//     _panController.dispose();
//     _accountNameController.dispose();
//     _bankNameController.dispose();
//     _accountNumberController.dispose();
//     _ifscController.dispose();
//     _branchController.dispose();
//     _declarationNameController.dispose();
//     super.dispose();
//   }
// }




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

  // Document Uploads
  final Map<String, Map<String, dynamic>> _uploadedFiles = {
    'GST Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Trade License': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'FSSAI Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Cancelled Cheque': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Hotel Registration Certificate': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Room & Property Photos': {'name': '', 'size': 0, 'path': '', 'uploaded': false},
    'Signature of Authorized Person': {'name': '', 'size': 0, 'path': '', 'uploaded': false}, // Added signature upload
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
        _buildCard(
          title: '9. Documents to be Submitted',
          children: [
            Text(
              'Please upload clear scanned copies of the following documents:',
              style: TextStyle(fontSize: 12, color: _textSecondary),
            ),
            SizedBox(height: 16),
            ..._uploadedFiles.entries.map((entry) {
              return _buildDocumentUploadItem(
                documentName: entry.key,
                fileInfo: entry.value,
                onUploadPressed: () => _pickDocument(entry.key),
                onViewPressed: () => _viewDocument(entry.key),
                onRemovePressed: () => _removeDocument(entry.key),
                isOptional: entry.key == 'FSSAI Certificate',
                isSignature: entry.key == 'Signature of Authorized Person', // Special handling for signature
              );
            }).toList(),
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

  Widget _buildSignatureUploadItem() {
    final signatureInfo = _uploadedFiles['Signature of Authorized Person']!;
    final fileName = signatureInfo['name'] as String? ?? '';
    final isUploaded = (signatureInfo['uploaded'] as bool?) ?? false;
    final fileSize = (signatureInfo['size'] as int?) ?? 0;

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
                    color: _primaryColor,
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
                          color: _textPrimary,
                        ),
                      ),
                      Text(
                        'PNG, JPG, or PDF format',
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
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _primaryLight.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      // Icon(Icons.info, size: 16, color: _primaryColor),
                      // SizedBox(width: 8),
                      // Expanded(
                      //   // child: Text(
                      //   //   'Upload a clear scanned signature of the authorized person who signs this declaration.',
                      //   //   style: TextStyle(
                      //   //     fontSize: 12,
                      //   //     color: _textSecondary,
                      //   //   ),
                      //   // ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _pickDocument('Signature of Authorized Person'),
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
              ],
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
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _primaryColor.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.note_alt_outlined,
                        size: 24,
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
                            fontSize: 13,
                            color: _textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${(fileSize / 1024).toStringAsFixed(1)} KB • Signature File',
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
                        onPressed: () => _viewDocument('Signature of Authorized Person'),
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: _primaryColor,
                        ),
                        tooltip: 'Preview Signature',
                      ),
                      IconButton(
                        onPressed: () => _removeDocument('Signature of Authorized Person'),
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

  // File Upload Methods
  Future<void> _pickDocument(String documentType) async {
    // Implement file picking logic
    print('Picking document: $documentType');

    // Simulating file upload
    setState(() {
      _uploadedFiles[documentType] = {
        'name': '${documentType.replaceAll(' ', '_')}_signed.pdf',
        'size': 2048,
        'path': '/temp/uploaded_file.pdf',
        'uploaded': true,
      };
    });
  }

  void _viewDocument(String documentType) {
    // Implement document viewing
    print('Viewing document: $documentType');
  }

  void _removeDocument(String documentType) {
    setState(() {
      _uploadedFiles[documentType] = {
        'name': '',
        'size': 0,
        'path': '',
        'uploaded': false,
      };
    });
  }

  void _submitForm() {
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

    // // Check if signature is uploaded
    // if (!_uploadedFiles['Signature of Authorized Person']!['uploaded']) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please upload signature of authorized person'),
    //       backgroundColor: Colors.orange,
    //     ),
    //   );
    //   return;
    // }

       final signatureInfo = _uploadedFiles['Signature of Authorized Person']!;
    final isSignatureUploaded = (signatureInfo['uploaded'] as bool?) ?? false;

    if (!isSignatureUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload signature of authorized person'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }


    // Collect form data
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
      'roomTariff': {
        'min': _minTariffController.text,
        'max': _maxTariffController.text,
      },
      'checkInTime': _checkInController.text,
      'checkOutTime': _checkOutController.text,
      'roomAmenities': _roomAmenities,
      'hotelFacilities': _hotelFacilities,
      'foodServices': _foodServices,
      'guestServices': _guestServices,
      'idProofRequired': _selectedIdProof, // Changed to single value
      'coupleFriendly': _coupleFriendly,
      'petsAllowed': _petsAllowed,
      'gstNumber': _gstController.text,
      'tradeLicense': _tradeLicenseController.text,
      'fssaiLicense': _fssaiController.text,
      'panNumber': _panController.text,
      'bankDetails': {
        'accountHolderName': _accountNameController.text,
        'bankName': _bankNameController.text,
        'accountNumber': _accountNumberController.text,
        'ifscCode': _ifscController.text,
        'branch': _branchController.text,
      },
      'uploadedFiles': _uploadedFiles,
      'declarationDate': _selectedDate,
      'declarationAccepted': _declarationAccepted,
    };

    // Navigate to summary or submit
    print('Form submitted: $formData');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration submitted successfully!'),
        backgroundColor: _successColor,
      ),
    );

    // For now, just show success message
    // In real app, you would navigate to summary screen or submit to API
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