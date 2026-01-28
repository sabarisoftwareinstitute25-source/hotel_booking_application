import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import '../login_screen/forget_password.dart';

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

  // Widget _buildStep3() {
  //   return Column(
  //     children: [
  //       _buildCard(
  //         title: 'Select Room Types Available',
  //         children: [
  //           Text(
  //             'Select the room types available in your hotel:',
  //             style: TextStyle(
  //               fontSize: 13,
  //               color: _textSecondary,
  //             ),
  //           ),
  //           SizedBox(height: 12),
  //           Wrap(
  //             spacing: 8,
  //             runSpacing: 8,
  //             children: _selectedRoomTypes.entries.map((entry) {
  //               bool isSelected = entry.value;
  //               return GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     _selectedRoomTypes[entry.key] = !isSelected;
  //                   });
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  //                   decoration: BoxDecoration(
  //                     color: isSelected ? _primaryLight : Colors.white,
  //                     borderRadius: BorderRadius.circular(20),
  //                     border: Border.all(
  //                       color: isSelected ? _primaryColor : _borderColor,
  //                       width: isSelected ? 2 : 1,
  //                     ),
  //                   ),
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Icon(
  //                         isSelected ? Icons.check_circle : Icons.circle_outlined,
  //                         size: 16,
  //                         color: isSelected ? _primaryColor : _textSecondary,
  //                       ),
  //                       SizedBox(width: 6),
  //                       Text(
  //                         entry.key,
  //                         style: TextStyle(
  //                           fontSize: 13,
  //                           color: isSelected ? _primaryColor : _textSecondary,
  //                           fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //           SizedBox(height: 16),
  //           Divider(color: _borderColor),
  //           SizedBox(height: 16),
  //           Text(
  //             'Configure selected room types:',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w600,
  //               color: _textPrimary,
  //             ),
  //           ),
  //           SizedBox(height: 12),
  //         ],
  //       ),
  //
  //
  //       ..._selectedRoomTypes.entries.where((entry) => entry.value).map((entry) {
  //         String roomType = entry.key;
  //         return Container(
  //           margin: EdgeInsets.only(bottom: 16),
  //           child: _buildCard(
  //             title: '$roomType Details',
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: _buildSmallInput(
  //                       label: 'Number of Rooms',
  //                       controller: TextEditingController(text: _roomDetails[roomType]!['rooms']),
  //                       onChanged: (value) => _roomDetails[roomType]!['rooms'] = value,
  //                       hint: '0',
  //                       keyboardType: TextInputType.number,
  //                     ),
  //                   ),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: _buildSmallInput(
  //                       label: 'Max Occupancy',
  //                       controller: TextEditingController(text: _roomDetails[roomType]!['occupancy']),
  //                       onChanged: (value) => _roomDetails[roomType]!['occupancy'] = value,
  //                       hint: 'Persons',
  //                       keyboardType: TextInputType.number,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: _buildSmallInput(
  //                       label: 'Price per Night (₹)',
  //                       controller: TextEditingController(text: _roomDetails[roomType]!['price']),
  //                       onChanged: (value) => _roomDetails[roomType]!['price'] = value,
  //                       hint: '0',
  //                       keyboardType: TextInputType.number,
  //                     ),
  //                   ),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'AC / Non-AC',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         SizedBox(height: 8),
  //                         Row(
  //                           children: [
  //                             Expanded(
  //                               child: _buildToggleChip('AC', _roomDetails[roomType]!['ac'], () {
  //                                 setState(() {
  //                                   _roomDetails[roomType]!['ac'] = true;
  //                                 });
  //                               }),
  //                             ),
  //                             SizedBox(width: 8),
  //                             Expanded(
  //                               child: _buildToggleChip('Non-AC', !_roomDetails[roomType]!['ac'], () {
  //                                 setState(() {
  //                                   _roomDetails[roomType]!['ac'] = false;
  //                                 });
  //                               }),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 12),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Extra Bed Available',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         SizedBox(height: 8),
  //                         Row(
  //                           children: [
  //                             _buildToggleChip('Yes', _roomDetails[roomType]!['extraBed'], () {
  //                               setState(() {
  //                                 _roomDetails[roomType]!['extraBed'] = true;
  //                               });
  //                             }),
  //                             SizedBox(width: 8),
  //                             _buildToggleChip('No', !_roomDetails[roomType]!['extraBed'], () {
  //                               setState(() {
  //                                 _roomDetails[roomType]!['extraBed'] = false;
  //                               });
  //                             }),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 12),
  //                   if (_roomDetails[roomType]!['extraBed'])
  //                     Expanded(
  //                       child: _buildSmallInput(
  //                         label: 'Extra Bed Price (₹)',
  //                         controller: TextEditingController(text: _roomDetails[roomType]!['extraBedPrice']),
  //                         onChanged: (value) => _roomDetails[roomType]!['extraBedPrice'] = value,
  //                         hint: '0',
  //                         keyboardType: TextInputType.number,
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               SizedBox(height: 8),
  //             ],
  //           ),
  //         );
  //       }).toList(),
  //
  //       SizedBox(height: 16),
  //       _buildCard(
  //         title: 'General Room Information',
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Select Price (per night):',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 13,
  //                 ),
  //               ),
  //               SizedBox(height: 8),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: TextFormField(
  //                       controller: _minTariffController,
  //                       keyboardType: TextInputType.number,
  //                       decoration: InputDecoration(
  //                         hintText: 'Minimum Price',
  //                         prefixText: '₹ ',
  //                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           borderSide: BorderSide(color: _borderColor),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 8),
  //                     child: Text('to', style: TextStyle(color: _textSecondary)),
  //                   ),
  //                   Expanded(
  //                     child: TextFormField(
  //                       controller: _maxTariffController,
  //                       keyboardType: TextInputType.number,
  //                       decoration: InputDecoration(
  //                         hintText: 'Maximum Price',
  //                         prefixText: '₹ ',
  //                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           borderSide: BorderSide(color: _borderColor),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Extra Bed Available Overall:',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 13,
  //                       ),
  //                     ),
  //                     SizedBox(height: 8),
  //                     Row(
  //                       children: [
  //                         _buildToggleChip('Yes', _extraBedAvailable, () {
  //                           setState(() => _extraBedAvailable = true);
  //                         }),
  //                         SizedBox(width: 8),
  //                         _buildToggleChip('No', !_extraBedAvailable, () {
  //                           setState(() => _extraBedAvailable = false);
  //                         }),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
                // Text(
                //   'Select Price (per day):',
                //   style: TextStyle(
                //     fontWeight: FontWeight.w500,
                //     fontSize: 13,
                //   ),
                // ),
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
                // SizedBox(height: 4),
                // Text(
                //   'Enter price range in Indian Rupees',
                //   style: TextStyle(
                //     fontSize: 11,
                //     color: _textSecondary,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
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

  // Widget _buildStep4() {
  //   return Column(
  //     children: [
  //       _buildCard(
  //         title: 'Amenities Available',
  //         children: [
  //           _buildAmenitiesSection('Basic Amenities', _basicAmenities),
  //           SizedBox(height: 16),
  //           _buildAmenitiesSection('Hotel Facilities', _hotelFacilities),
  //           SizedBox(height: 16),
  //           _buildAmenitiesSection('Food & Services', _foodServices),
  //           SizedBox(height: 16),
  //           _buildAmenitiesSection('Additional Amenities', _additionalAmenities),
  //
  //           // Extra Amenities Option
  //           SizedBox(height: 16),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Add Extra Amenities',
  //                 style: TextStyle(
  //                   fontSize: 13,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               SizedBox(height: 8),
  //               Text(
  //                 'Add any additional amenities not listed above',
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   color: _textSecondary,
  //                 ),
  //               ),
  //               SizedBox(height: 8),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: TextFormField(
  //                       controller: _extraAmenitiesController,
  //                       decoration: InputDecoration(
  //                         hintText: 'e.g., Swimming Pool, Gym, etc.',
  //                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           borderSide: BorderSide(color: _borderColor),
  //                         ),
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           borderSide: BorderSide(color: _borderColor),
  //                         ),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(8),
  //                           borderSide: BorderSide(color: _primaryColor),
  //                         ),
  //                         suffixIcon: IconButton(
  //                           onPressed: _addCustomAmenity,
  //                           icon: Icon(Icons.add_circle, color: _primaryColor),
  //                         ),
  //                       ),
  //                       onFieldSubmitted: (value) {
  //                         if (value.trim().isNotEmpty) {
  //                           _addCustomAmenity();
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //
  //
  //               if (_customAmenities.isNotEmpty)
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 8),
  //                   child: Wrap(
  //                     spacing: 8,
  //                     runSpacing: 8,
  //                     children: _customAmenities.map((amenity) {
  //                       return Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                         decoration: BoxDecoration(
  //                           color: _primaryLight,
  //                           borderRadius: BorderRadius.circular(16),
  //                           border: Border.all(color: _primaryColor),
  //                         ),
  //                         child: Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Text(
  //                               amenity,
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: _primaryColor,
  //                               ),
  //                             ),
  //                             SizedBox(width: 4),
  //                             GestureDetector(
  //                               onTap: () => _removeCustomAmenity(amenity),
  //                               child: Icon(Icons.close, size: 14, color: _primaryColor),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     }).toList(),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 16),
  //       _buildCard(
  //         title: 'Legal Details',
  //         children: [
  //           _buildInputField(
  //             label: 'GST Number',
  //             controller: _gstController,
  //             hint: 'Enter GST number',
  //           ),
  //           SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildInputField(
  //                   label: 'FSSAI License No.',
  //                   controller: _fssaiController,
  //                   hint: 'If restaurant',
  //                 ),
  //               ),
  //               SizedBox(width: 16),
  //               Expanded(
  //                 child: _buildInputField(
  //                   label: 'Trade License No.',
  //                   controller: _tradeLicenseController,
  //                   hint: 'Enter license number',
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //           SizedBox(height: 16),
  //           _buildInputField(
  //             label: 'Aadhar Number (Owner)',
  //             controller: _aadharController,
  //             hint: 'Enter Aadhar number',
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
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

            // Extra Amenities Option
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
                      height: 48, // Match the text field height
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
      // Show error if form is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check if declaration is accepted
    if (!_declarationAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please accept the declaration to proceed'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    // Collect all form data
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
      'declarationAccepted': _declarationAccepted, // Add this
    };

    // Navigate to Registration Summary Screen with all data
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
          declarationAccepted: _declarationAccepted, // Add this
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
    required this.declarationAccepted,
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
              Map<String, dynamic> registrationData = {
                'hotelName': hotelName,
                'ownerName': ownerName,
                'mobileNumber': mobileNumber,
                'email': email,
                'addressLine1': addressLine1,
                'addressLine2': addressLine2,
                'city': city,
                'district': district,
                'state': state,
                'pinCode': pinCode,
                'gstNumber': gstNumber,
                'fssaiLicense': fssaiLicense,
                'tradeLicense': tradeLicense,
                'panNumber': panNumber,
                'aadharNumber': aadharNumber,
                'accountHolderName': accountHolderName,
                'bankName': bankName,
                'accountNumber': accountNumber,
                'ifscCode': ifscCode,
                'branch': branch,
                'accountType': accountType,
                'totalRooms': totalRooms,
                'personPhotoInfo': personPhotoInfo,
              };

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    registeredEmail: email,
                    registeredPassword: "12345",
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

            // _section('Declaration', [
            //   _info('Authorized Signatory', signatureName),
            //   _info('Name', declarationName),
            //   if (declarationDate != null)
            //     _info(
            //       'Date',
            //       '${declarationDate!.day}/${declarationDate!.month}/${declarationDate!.year}',
            //     ),
            // ]),

            // In RegistrationSummaryScreen build method, keep the original declaration section:
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

class LoginPage extends StatefulWidget {
  final String? registeredEmail;
  final String? registeredPassword;
  final Map<String, dynamic>? registrationData;

  const LoginPage({
    super.key,
    this.registeredEmail,
    this.registeredPassword,
    this.registrationData,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
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

  @override
  void initState() {
    super.initState();

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

  void _submitForm() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
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

      if (_emailController.text.trim() == widget.registeredEmail &&
          _passwordController.text.trim() == widget.registeredPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Login Successful!"),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HotelOwnerDashboard(
                hotelName: widget.registrationData?['hotelName'] ?? '',
                ownerName: widget.registrationData?['ownerName'] ?? '',
                mobileNumber: widget.registrationData?['mobileNumber'] ?? '',
                email: widget.registrationData?['email'] ?? '',
                addressLine1: widget.registrationData?['addressLine1'] ?? '',
                addressLine2: widget.registrationData?['addressLine2'] ?? '',
                city: widget.registrationData?['city'] ?? '',
                district: widget.registrationData?['district'] ?? '',
                state: widget.registrationData?['state'] ?? '',
                pinCode: widget.registrationData?['pinCode'] ?? '',
                gstNumber: widget.registrationData?['gstNumber'] ?? '',
                fssaiLicense: widget.registrationData?['fssaiLicense'] ?? '',
                tradeLicense: widget.registrationData?['tradeLicense'] ?? '',
                panNumber: widget.registrationData?['panNumber'] ?? '',
                aadharNumber: widget.registrationData?['aadharNumber'] ?? '',
                accountHolderName:
                    widget.registrationData?['accountHolderName'] ?? '',
                bankName: widget.registrationData?['bankName'] ?? '',
                accountNumber: widget.registrationData?['accountNumber'] ?? '',
                ifscCode: widget.registrationData?['ifscCode'] ?? '',
                branch: widget.registrationData?['branch'] ?? '',
                accountType: widget.registrationData?['accountType'] ?? '',
                totalRooms:
                    int.tryParse(
                      widget.registrationData?['totalRooms']?.toString() ?? '0',
                    ) ??
                    0,
                personPhotoInfo:
                    widget.registrationData?['personPhotoInfo']?.toString() ??
                    '',
              ),
            ),
            (route) => false,
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Text("Invalid email or password"),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
                                "Email Address",
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),

                              SizedBox(height: h * 0.02),

                              _buildPasswordField(
                                Icons.lock_outline,
                                "Password",
                                controller: _passwordController,
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
                                            registeredEmail:
                                                widget.registeredEmail,
                                            registeredPassword:
                                                widget.registeredPassword,
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

                              SizedBox(height: h * 0.025),

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
                                            Navigator.pop(context);
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Don't have an account? ",
                                              style: TextStyle(
                                                color: Colors.black,
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
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        offset: Offset(
                                                          1.0,
                                                          1.0,
                                                        ),
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: h * 0.04),
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
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    IconData icon,
    String hint, {
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
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
  final String personPhotoInfo;
  final int totalRooms;

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
    required this.personPhotoInfo,
    required this.totalRooms,
  }) : super(key: key);

  @override
  State<HotelOwnerDashboard> createState() => _HotelOwnerDashboardState();
}

class _HotelOwnerDashboardState extends State<HotelOwnerDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = Color(0xFFFF5F6D);
  final Color _bgColor = Color(0xFFF9FAFB);
  final Color _textDark = Color(0xFF111827);
  final Color _textLight = Color(0xFF6B7280);
  final Color _borderColor = Color(0xFFE5E7EB);

  List<Map<String, dynamic>> _todayBookings = [
    {
      'room': '101',
      'guest': 'John Doe',
      'checkIn': '14:00',
      'checkOut': '12:00',
      'status': 'Checked In',
    },
    {
      'room': '203',
      'guest': 'Jane Smith',
      'checkIn': '15:30',
      'checkOut': '11:00',
      'status': 'Pending',
    },
    {
      'room': '305',
      'guest': 'Robert Brown',
      'checkIn': '12:00',
      'checkOut': '10:00',
      'status': 'Checked Out',
    },
  ];

  List<Map<String, dynamic>> _recentReviews = [
    {
      'guest': 'Alice Johnson',
      'rating': 4.5,
      'comment': 'Great service!',
      'date': '2024-01-20',
    },
    {
      'guest': 'Mark Wilson',
      'rating': 3.8,
      'comment': 'Clean rooms',
      'date': '2024-01-19',
    },
    {
      'guest': 'Sarah Lee',
      'rating': 5.0,
      'comment': 'Excellent experience',
      'date': '2024-01-18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: _buildAppBar(w),
      drawer: _buildDrawer(w),
      // body: _buildBody(w, h),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              backgroundColor: _primaryColor,
              onPressed: () {},
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  AppBar _buildAppBar(double w) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: _textDark),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back ${widget.ownerName}!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat('EEEE, MMMM d').format(DateTime.now()),
            style: TextStyle(fontSize: 12, color: _textLight),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person_outline, color: _textDark),
          onPressed: () => _showProfile(),
        ),
      ],
    );
  }

  Drawer _buildDrawer(double w) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, Color(0xFFFF8A7A)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.hotel, size: 32, color: _primaryColor),
                ),
                SizedBox(height: 10),
                Text(
                  widget.hotelName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Owner: ${widget.ownerName}',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
          _buildDrawerItem(Icons.bed, 'Room Management', 1),
          _buildDrawerItem(Icons.calendar_today, 'Bookings', 2),
          _buildDrawerItem(Icons.attach_money, 'Revenue', 3),
          _buildDrawerItem(Icons.star, 'Reviews & Ratings', 4),
          _buildDrawerItem(Icons.people, 'Staff Management', 5),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Hotel Settings', 6),
          _buildDrawerItem(Icons.help_outline, 'Help & Support', 7),
          _buildDrawerItem(Icons.logout, 'Logout', 8),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: _textDark),
      title: Text(title, style: TextStyle(color: _textDark)),
      selected: _selectedIndex == index,
      selectedTileColor: _primaryColor.withOpacity(0.1),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBody(double w, double h) {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard(w, h);
      case 1:
        return _buildRoomManagement();
      case 2:
        return _buildBookings();
      case 3:
        return _buildRevenue();
      case 4:
        return _buildReviews();
      default:
        return _buildDashboard(w, h);
    }
  }

  Widget _buildDashboard(double w, double h) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(26),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, Color(0xFFFF8A7A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'Welcome back, ${widget.ownerName}!',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      SizedBox(height: 8),
                      Text(
                        'Manage your hotel efficiently with real-time updates',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.hotel, size: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _statCard(
                icon: Icons.bed,
                title: 'Total Rooms',
                value: widget.totalRooms.toString(),
                color: Colors.blue,
              ),
              _statCard(
                icon: Icons.people,
                title: 'Occupied Today',
                value: '8',
                color: Colors.green,
              ),
              _statCard(
                icon: Icons.attach_money,
                title: 'Today\'s Revenue',
                value: '₹25,400',
                color: Colors.orange,
              ),
              _statCard(
                icon: Icons.star,
                title: 'Avg Rating',
                value: '4.2',
                color: Colors.purple,
              ),
            ],
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Bookings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('View All', style: TextStyle(color: _primaryColor)),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildBookingsList(),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See All', style: TextStyle(color: _primaryColor)),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildReviewsList(),

          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Icon(icon, size: 20, color: color)),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 13, color: _textLight)),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: _todayBookings.map((booking) {
          Color statusColor = Colors.grey;
          if (booking['status'] == 'Checked In') statusColor = Colors.green;
          if (booking['status'] == 'Pending') statusColor = Colors.orange;
          if (booking['status'] == 'Checked Out') statusColor = Colors.blue;

          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    _todayBookings.indexOf(booking) < _todayBookings.length - 1
                    ? BorderSide(color: _borderColor)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      booking['room'],
                      style: TextStyle(
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
                        booking['guest'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Check-in: ${booking['checkIn']} | Check-out: ${booking['checkOut']}',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    booking['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReviewsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        children: _recentReviews.map((review) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    _recentReviews.indexOf(review) < _recentReviews.length - 1
                    ? BorderSide(color: _borderColor)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.person, color: Colors.amber)),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review['guest'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _textDark,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                review['rating'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _textDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        review['comment'],
                        style: TextStyle(color: _textLight),
                      ),
                      SizedBox(height: 4),
                      Text(
                        review['date'],
                        style: TextStyle(fontSize: 11, color: _textLight),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoomManagement() {
    return Center(child: Text('Room Management - Coming Soon'));
  }

  Widget _buildBookings() {
    return Center(child: Text('Bookings - Coming Soon'));
  }

  Widget _buildRevenue() {
    return Center(child: Text('Revenue - Coming Soon'));
  }

  Widget _buildReviews() {
    return Center(child: Text('Reviews - Coming Soon'));
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: _primaryColor,
      unselectedItemColor: _textLight,
      showUnselectedLabels: true,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bed), label: 'Rooms'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Revenue',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Reviews'),
      ],
    );
  }

  void _showProfile() {
    Navigator.push(
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
          panNumber: widget.panNumber,
          aadharNumber: widget.aadharNumber,
          accountHolderName: widget.accountHolderName,
          bankName: widget.bankName,
          accountNumber: widget.accountNumber,
          ifscCode: widget.ifscCode,
          branch: widget.branch,
          accountType: widget.accountType,
          totalRooms: widget.totalRooms, // Convert int to String
          personPhotoInfo: {
            'url': widget.personPhotoInfo,
            'fileName': 'profile_photo.jpg',
            'uploadDate': DateTime.now().toIso8601String(),
            'fileSize': 0,
            'description': 'Profile photo',
          }, selectedRoomTypes: {}, roomDetails: {}, basicAmenities: {}, hotelFacilities: {}, foodServices: {}, additionalAmenities: {}, customAmenities: [],
         // Changed to bool
        ),
      ),
    );
  }
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
  });

  @override
  State<HotelOwnerProfilePage> createState() => _HotelOwnerProfilePageState();
}

class _HotelOwnerProfilePageState extends State<HotelOwnerProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Updated to 5 tab titles
  final List<String> _tabTitles = ['Personal details', 'Hotel details', 'Room Availability', 'Amenities details', 'Bank & Documents'];
  final int _activeRooms = 18;
  final double _occupancyRate = 84.0;
  final double _rating = 4.8;

  @override
  void initState() {
    super.initState();
    // Updated length to 5
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              // **APP BAR WITH OVERVIEW SECTION**
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
                        // **GRADIENT HEADER SECTION**
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
                              colors: [
                                Color(0xFF4F46E5),
                                Color(0xFF7C3AED),
                              ],
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
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, size: 14, color: Colors.white),
                                        SizedBox(width: 6),
                                        Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
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
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: widget.personPhotoInfo['uploaded'] == true
                                          ? Image.network(
                                        widget.personPhotoInfo['url'],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.white.withOpacity(0.2),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 36,
                                            ),
                                          );
                                        },
                                      )
                                          : Container(
                                        color: Colors.white.withOpacity(0.2),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 36,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 16),

                                  // **OWNER AND HOTEL DETAILS**
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: Colors.white.withOpacity(0.9),
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
                                            Icon(Icons.phone, size: 16, color: Colors.white),
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
                                            Icon(Icons.email, size: 16, color: Colors.white),
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
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // **TOTAL ROOMS**
                                    _buildOverviewStat(
                                      value: widget.totalRooms.toString(),
                                      label: 'Total Rooms',
                                      icon: Icons.meeting_room,
                                    ),

                                    // **ACTIVE ROOMS**
                                    _buildOverviewStat(
                                      value: _activeRooms.toString(),
                                      label: 'Active Now',
                                      icon: Icons.check_circle,
                                      color: Colors.white,
                                    ),

                                    // **OCCUPANCY**
                                    _buildOverviewStat(
                                      value: '${_occupancyRate.toStringAsFixed(1)}%',
                                      label: 'Occupancy',
                                      icon: Icons.trending_up,
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
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
                        fontSize: 14,
                      ),
                      // isScrollable: true, // Added to accommodate 5 tabs
                      tabs: _tabTitles.map((title) {
                        return Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                            child: Text(title),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // Personal details Tab - updated with new fields
              _PersonalDetailsTab(
                ownerName: widget.ownerName,
                mobileNumber: widget.mobileNumber,
                email: widget.email,
                aadharNumber: widget.aadharNumber,
                panNumber: widget.panNumber,
                personPhotoInfo: widget.personPhotoInfo,
                alternateContact: widget.alternateContact,
                landlineNumbers: widget.landlineNumbers,
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
                aadharNumber: widget.aadharNumber, // Added PAN number
              ),

              // Bank & Documents Tab
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
                panNumber: widget.panNumber,
              ),
            ],
          ),
        ),
      ),

      // Edit Profile Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Edit profile action
        },
        backgroundColor: Color(0xFF4F46E5),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
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
          style: TextStyle(
            color: color.withOpacity(0.9),
            fontSize: 11,
          ),
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
  final String panNumber;
  final Map<String, dynamic> personPhotoInfo;
  final String alternateContact;
  final List<String> landlineNumbers;
  final String website;

  const _PersonalDetailsTab({
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.aadharNumber,
    required this.panNumber,
    required this.personPhotoInfo,
    this.alternateContact = '',
    this.landlineNumbers = const [],
    this.website = '',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSectionHeader('Profile Photo'),
          SizedBox(height: 12),
          _buildProfilePhotoCard(),

          SizedBox(height: 24),

          _buildSectionHeader('Identity Cards'),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildIDCard(
                  title: 'Aadhar Card',
                  number: aadharNumber,
                  icon: Icons.credit_card,
                  color: Color(0xFF4CAF50),
                  isVerified: true,
                ),
              ),
              SizedBox(width: 12),

            ],
          ),

          SizedBox(height: 24),

          _buildSectionHeader('Contact Information'),
          SizedBox(height: 12),
          _buildContactCard(),

          SizedBox(height: 24),

          if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty)
            _buildSectionHeader('Additional Contact Information'),
          if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty)
            SizedBox(height: 12),
          if (alternateContact.isNotEmpty || landlineNumbers.isNotEmpty || website.isNotEmpty)
            _buildAdditionalContactCard(),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoCard() {
    final isUploaded = personPhotoInfo['uploaded'] ?? false;
    final fileName = personPhotoInfo['name'] ?? '';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF4F46E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.person, color: Color(0xFF4F46E5), size: 26),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      isUploaded ? 'Uploaded' : 'Not Uploaded',
                      style: TextStyle(
                        fontSize: 13,
                        color: isUploaded ? Color(0xFF4CAF50) : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isUploaded && fileName.isNotEmpty) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.photo, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fileName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4F46E5),
                Color(0xFF7C3AED),
              ],
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

  Widget _buildIDCard({
    required String title,
    required String number,
    required IconData icon,
    required Color color,
    required bool isVerified,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      number,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isVerified ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isVerified ? Icons.verified : Icons.pending,
                      size: 12,
                      color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
                    ),
                    SizedBox(width: 4),
                    Text(
                      isVerified ? 'Verified' : 'Pending',
                      style: TextStyle(
                        fontSize: 11,
                        color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
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
    );
  }

  Widget _buildContactCard() {
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
          _buildContactRow(
            icon: Icons.person,
            label: 'Full Name',
            value: ownerName,
          ),
          Divider(height: 20),
          _buildContactRow(
            icon: Icons.phone,
            label: 'Mobile',
            value: mobileNumber,
            isCopyable: true,
          ),
          Divider(height: 20),
          _buildContactRow(
            icon: Icons.email,
            label: 'Email',
            value: email,
            isCopyable: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalContactCard() {
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
          if (alternateContact.isNotEmpty)
            Column(
              children: [
                _buildContactRow(
                  icon: Icons.phone_android,
                  label: 'Alternate Contact',
                  value: alternateContact,
                  isCopyable: true,
                ),
                if (landlineNumbers.isNotEmpty || website.isNotEmpty) Divider(height: 20),
              ],
            ),

          if (landlineNumbers.isNotEmpty)
            Column(
              children: [
                _buildLandlineSection(),
                if (website.isNotEmpty) Divider(height: 20),
              ],
            ),

          if (website.isNotEmpty)
            Column(
              children: [
                _buildContactRow(
                  icon: Icons.language,
                  label: 'Website',
                  value: website,
                  isCopyable: true,
                  isWebsite: true,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLandlineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFF4F46E5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.phone_in_talk, size: 18, color: Color(0xFF4F46E5)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Landline Numbers',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: landlineNumbers.map((number) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          number,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    bool isCopyable = false,
    bool isWebsite = false,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFF4F46E5).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: Color(0xFF4F46E5)),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isWebsite ? Colors.blue[600] : Colors.grey[800],
                  decoration: isWebsite ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        if (isCopyable)
          IconButton(
            icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
            onPressed: () {
              // Clipboard.setData(ClipboardData(text: value));
            },
          ),
      ],
    );
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
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSectionHeader('Hotel Information'),
          SizedBox(height: 12),
          _buildHotelInfoCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Address Details'),
          SizedBox(height: 12),
          _buildAddressCard(),

          SizedBox(height: 20),

          // Landmark card - now always shown
          _buildSectionHeader('Landmark'),
          SizedBox(height: 12),
          _buildLandmarkCard(),

          SizedBox(height: 20),

          // Website card - now always shown
          _buildSectionHeader('Website'),
          SizedBox(height: 12),
          _buildWebsiteCard(),
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
              colors: [
                Color(0xFF4F46E5),
                Color(0xFF7C3AED),
              ],
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

  Widget _buildHotelInfoCard() {
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
          _buildInfoRow('Hotel Name', hotelName),
          Divider(height: 20),
          _buildInfoRow('Hotel Type', hotelType.isNotEmpty ? hotelType : 'Not specified'),
          Divider(height: 20),
          _buildInfoRow('Year of Establishment', yearOfEstablishment.isNotEmpty ? yearOfEstablishment : 'Not specified'),
          Divider(height: 20),
          _buildInfoRow('Total Rooms', '$totalRooms Rooms'),
          Divider(height: 20),
          _buildInfoRow('City', city),
          Divider(height: 20),
          _buildInfoRow('District', district),
          Divider(height: 20),
          _buildInfoRow('State', state),
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
              Icon(Icons.location_on, color: Color(0xFF4F46E5), size: 20),
              SizedBox(width: 8),
              Text(
                'Complete Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            addressLine1,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          if (addressLine2.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              addressLine2,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ],
          SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildAddressTag(city),
              _buildAddressTag(district),
              _buildAddressTag(state),
              _buildAddressTag('PIN: $pinCode'),
            ],
          ),
        ],
      ),
    );
  }

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
          Icon(Icons.place, color: Color(0xFF4F46E5), size: 24),
          SizedBox(width: 12),
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
                SizedBox(height: 4),
                Text(
                  landmark.isNotEmpty ? landmark : 'Not specified',
                  style: TextStyle(
                    fontSize: 14,
                    color: landmark.isNotEmpty ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          Icon(Icons.language, color: Color(0xFF4F46E5), size: 24),
          SizedBox(width: 12),
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
                SizedBox(height: 4),
                Text(
                  website.isNotEmpty ? website : 'Not provided',
                  style: TextStyle(
                    fontSize: 14,
                    color: website.isNotEmpty ? Colors.blue[600] : Colors.grey[400],
                    decoration: website.isNotEmpty ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
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
              colors: [
                Color(0xFF4F46E5),
                Color(0xFF7C3AED),
              ],
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
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
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
                colors: [
                  Color(0xFF4F46E5),
                  Color(0xFF7C3AED),
                ],
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
            color: hasValue ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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
            color: hasValue ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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


// // **PERSONAL DETAILS TAB**
// class _PersonalDetailsTab extends StatelessWidget {
//   final String ownerName;
//   final String mobileNumber;
//   final String email;
//   final String aadharNumber;
//   final String panNumber;
//   final Map<String, dynamic> personPhotoInfo;
//
//   const _PersonalDetailsTab({
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.email,
//     required this.aadharNumber,
//     required this.panNumber,
//     required this.personPhotoInfo,
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
//           Row(
//             children: [
//               Expanded(
//                 child: _buildIDCard(
//                   title: 'Aadhar Card',
//                   number: aadharNumber,
//                   icon: Icons.credit_card,
//                   color: Color(0xFF4CAF50),
//                   isVerified: true,
//                 ),
//               ),
//               SizedBox(width: 12),
//
//
//             ],
//           ),
//
//           SizedBox(height: 24),
//
//           _buildSectionHeader('Contact Information'),
//           SizedBox(height: 12),
//           _buildContactCard(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfilePhotoCard() {
//     final isUploaded = personPhotoInfo['uploaded'] ?? false;
//     final fileName = personPhotoInfo['name'] ?? '';
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
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xFF4F46E5).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(Icons.person, color: Color(0xFF4F46E5), size: 26),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Profile Photo',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       isUploaded ? 'Uploaded' : 'Not Uploaded',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: isUploaded ? Color(0xFF4CAF50) : Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           if (isUploaded && fileName.isNotEmpty) ...[
//             SizedBox(height: 12),
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.photo, color: Colors.grey[600]),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       fileName,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[700],
//                       ),
//                       overflow: TextOverflow.ellipsis,
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
//   Widget _buildIDCard({
//     required String title,
//     required String number,
//     required IconData icon,
//     required Color color,
//     required bool isVerified,
//   }) {
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
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: color, size: 22),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       number,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: isVerified ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       isVerified ? Icons.verified : Icons.pending,
//                       size: 12,
//                       color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       isVerified ? 'Verified' : 'Pending',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
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
//             icon: Icons.person,
//             label: 'Full Name',
//             value: ownerName,
//           ),
//           Divider(height: 20),
//           _buildContactRow(
//             icon: Icons.phone,
//             label: 'Mobile',
//             value: mobileNumber,
//             isCopyable: true,
//           ),
//           Divider(height: 20),
//           _buildContactRow(
//             icon: Icons.email,
//             label: 'Email',
//             value: email,
//             isCopyable: true,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isCopyable = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Color(0xFF4F46E5).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 18, color: Color(0xFF4F46E5)),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (isCopyable)
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
//       ],
//     );
//   }
// }
//
// // **HOTEL DETAILS TAB**
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
//           if (landmark.isNotEmpty) ...[
//             _buildSectionHeader('Landmark'),
//             SizedBox(height: 12),
//             _buildLandmarkCard(),
//             SizedBox(height: 20),
//           ],
//
//           if (website.isNotEmpty) ...[
//             _buildSectionHeader('Website'),
//             SizedBox(height: 12),
//             _buildWebsiteCard(),
//           ],
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
//             child: Text(
//               landmark,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
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
//             child: Text(
//               website,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.blue[600],
//                 decoration: TextDecoration.underline,
//               ),
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

// **ROOM AVAILABILITY TAB**
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
    roomDetails.forEach((key, value) {
      if (value['rooms'] != null && value['rooms'].isNotEmpty) {
        totalConfiguredRooms += int.tryParse(value['rooms'].toString()) ?? 0;
      }
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Room Summary'),
          SizedBox(height: 12),
          _buildSummaryCard(totalConfiguredRooms, availableRoomTypes.length),

          SizedBox(height: 20),

          _buildSectionHeader('Price Range'),
          SizedBox(height: 12),
          _buildPriceRangeCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Room Types Available (${availableRoomTypes.length})'),
          SizedBox(height: 12),

          if (availableRoomTypes.isEmpty)
            _buildNoRoomsCard()
          else
            ...availableRoomTypes.map((roomType) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                child: _buildRoomTypeCard(roomType),
              );
            }).toList(),

          SizedBox(height: 20),

          _buildSectionHeader('Extra Bed Facility'),
          SizedBox(height: 12),
          _buildExtraBedCard(),
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
              colors: [
                Color(0xFF4F46E5),
                Color(0xFF7C3AED),
              ],
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

  Widget _buildSummaryCard(int configuredRooms, int roomTypesCount) {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            value: totalRooms.toString(),
            label: 'Total Rooms',
            icon: Icons.meeting_room,
            color: Color(0xFF4F46E5),
          ),
          _buildSummaryItem(
            value: configuredRooms.toString(),
            label: 'Configured',
            icon: Icons.check_circle,
            color: Color(0xFF4CAF50),
          ),
          _buildSummaryItem(
            value: roomTypesCount.toString(),
            label: 'Room Types',
            icon: Icons.category,
            color: Color(0xFF2196F3),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
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
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeCard() {
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
              Icon(Icons.attach_money, color: Color(0xFF4CAF50), size: 24),
              SizedBox(width: 12),
              Text(
                'Price per Night',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPriceBox('Minimum', minTariff.isNotEmpty ? '₹$minTariff' : 'Not set'),
              SizedBox(width: 20),
              Text('to', style: TextStyle(color: Colors.grey[600])),
              SizedBox(width: 20),
              _buildPriceBox('Maximum', maxTariff.isNotEmpty ? '₹$maxTariff' : 'Not set'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBox(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4F46E5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoRoomsCard() {
    return Container(
      padding: EdgeInsets.all(30),
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
          Icon(Icons.hotel, size: 50, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            'No Room Types Configured',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please configure room types in hotel settings',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRoomTypeCard(String roomType) {
    final details = roomDetails[roomType] ?? {};
    final rooms = details['rooms']?.toString() ?? '0';
    final occupancy = details['occupancy']?.toString() ?? '0';
    final price = details['price']?.toString() ?? '0';
    final isAC = details['ac'] ?? true;
    final extraBed = details['extraBed'] ?? false;
    final extraBedPrice = details['extraBedPrice']?.toString() ?? '0';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                roomType,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isAC ? Color(0xFF2196F3).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isAC ? 'AC' : 'Non-AC',
                  style: TextStyle(
                    color: isAC ? Color(0xFF2196F3) : Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildRoomDetailItem(Icons.meeting_room, '$rooms Rooms'),
              SizedBox(width: 16),
              _buildRoomDetailItem(Icons.people, '$occupancy Persons'),
              SizedBox(width: 16),
              _buildRoomDetailItem(Icons.attach_money, '₹$price'),
            ],
          ),
          if (extraBed && extraBedPrice.isNotEmpty && extraBedPrice != '0')
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Icon(Icons.airline_seat_flat, size: 16, color: Colors.green),
                  SizedBox(width: 6),
                  Text(
                    'Extra Bed: ₹$extraBedPrice',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRoomDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Color(0xFF4F46E5)),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildExtraBedCard() {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: extraBedAvailable ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              extraBedAvailable ? Icons.check_circle : Icons.block,
              color: extraBedAvailable ? Color(0xFF4CAF50) : Colors.grey,
              size: 26,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Extra Bed Facility',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  extraBedAvailable ? 'Available' : 'Not Available',
                  style: TextStyle(
                    fontSize: 14,
                    color: extraBedAvailable ? Color(0xFF4CAF50) : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// // **AMENITIES DETAILS TAB**
// class _AmenitiesDetailsTab extends StatelessWidget {
//   final Map<String, bool> basicAmenities;
//   final Map<String, bool> hotelFacilities;
//   final Map<String, bool> foodServices;
//   final Map<String, bool> additionalAmenities;
//   final List<String> customAmenities;
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
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
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
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
//                 colors: [
//                   Color(0xFF4F46E5),
//                   Color(0xFF7C3AED),
//                 ],
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
//             color: hasValue ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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
//             color: hasValue ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
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

// **BANK & DOCUMENTS TAB**

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
  final String panNumber;

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
    required this.panNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSectionHeader('Bank Account Details'),
          SizedBox(height: 12),
          _buildAccountDetailsCard(),

          SizedBox(height: 20),

          _buildSectionHeader('Business Documents'),
          SizedBox(height: 12),
          _buildDocumentsCard(),
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
              colors: [
                Color(0xFF4F46E5),
                Color(0xFF7C3AED),
              ],
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

  Widget _buildBankInfoRow(String label, String value, {bool isSensitive = false}) {
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
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
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

  Widget _buildDocumentsCard() {
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

  Widget _buildDocumentItem({
    required String title,
    required String number,
    required IconData icon,
    required Color color,
    required bool isVerified,
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  number.isNotEmpty ? number : 'Not provided',
                  style: TextStyle(
                    color: number.isNotEmpty ? Colors.grey[600] : Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isVerified ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isVerified ? Icons.verified : Icons.pending,
                            size: 12,
                            color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            isVerified ? 'Verified' : 'Pending',
                            style: TextStyle(
                              fontSize: 11,
                              color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
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
//   final String panNumber;
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
//     required this.panNumber,
//     required this.aadharNumber,
//     required this.accountHolderName,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifscCode,
//     required this.branch,
//     required this.accountType,
//     required this.totalRooms,
//     required this.personPhotoInfo,
//   });
//
//   @override
//   State<HotelOwnerProfilePage> createState() => _HotelOwnerProfilePageState();
// }
//
// class _HotelOwnerProfilePageState extends State<HotelOwnerProfilePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final List<String> _tabTitles = ['Personal', 'Hotel', 'Documents', 'Bank'];
//   final int _activeRooms = 18;
//   final double _occupancyRate = 84.0;
//   final double _rating = 4.8;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
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
//               // **APP BAR WITH OVERVIEW SECTION**
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
//                         // **GRADIENT HEADER SECTION**
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
//                               colors: [
//                                 Color(0xFF4F46E5),
//                                 Color(0xFF7C3AED),
//                               ],
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
//                                   Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.edit, size: 14, color: Colors.white),
//                                         SizedBox(width: 6),
//                                         Text(
//                                           'Edit Profile',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
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
//                                       border: Border.all(color: Colors.white, width: 3),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 10,
//                                         ),
//                                       ],
//                                     ),
//                                     child: ClipOval(
//                                       child: widget.personPhotoInfo['uploaded'] == true
//                                           ? Image.network(
//                                         widget.personPhotoInfo['url'],
//                                         fit: BoxFit.cover,
//                                         errorBuilder: (context, error, stackTrace) {
//                                           return Container(
//                                             color: Colors.white.withOpacity(0.2),
//                                             child: Icon(
//                                               Icons.person,
//                                               color: Colors.white,
//                                               size: 36,
//                                             ),
//                                           );
//                                         },
//                                       )
//                                           : Container(
//                                         color: Colors.white.withOpacity(0.2),
//                                         child: Icon(
//                                           Icons.person,
//                                           color: Colors.white,
//                                           size: 36,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   SizedBox(width: 16),
//
//                                   // **OWNER AND HOTEL DETAILS**
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // **OWNER NAME**
//                                         Text(
//                                           // widget.ownerName,
//                                           'john doe',
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
//                                               color: Colors.white.withOpacity(0.9),
//                                             ),
//                                             SizedBox(width: 6),
//                                             Expanded(
//                                               child: Text(
//                                                 // widget.hotelName,
//                                                ' Raj Bhavan Hotel',
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
//                                             Icon(Icons.phone, size: 16, color: Colors.white),
//                                             SizedBox(width: 6),
//                                             Text(
//                                               // widget.mobileNumber,
//                                               '9998884442',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             SizedBox(width: 20),
//                                             Icon(Icons.email, size: 16, color: Colors.white),
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
//                               Container(
//                                 padding: EdgeInsets.all(16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: Colors.white.withOpacity(0.3)),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     // **TOTAL ROOMS**
//                                     _buildOverviewStat(
//                                       value: widget.totalRooms.toString(),
//                                       label: 'Total Rooms',
//                                       icon: Icons.meeting_room,
//                                     ),
//
//                                     // **ACTIVE ROOMS**
//                                     _buildOverviewStat(
//                                       value: _activeRooms.toString(),
//                                       label: 'Active Now',
//                                       icon: Icons.check_circle,
//                                       color: Colors.white,
//                                     ),
//
//                                     // **OCCUPANCY**
//                                     _buildOverviewStat(
//                                       value: '${_occupancyRate.toStringAsFixed(1)}%',
//                                       label: 'Occupancy',
//                                       icon: Icons.trending_up,
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
//                 bottom: PreferredSize(
//                   preferredSize: Size.fromHeight(50),
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
//                         fontSize: 14,
//                       ),
//                       tabs: _tabTitles.map((title) {
//                         return Tab(
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Text(title),
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
//               // Personal Tab
//               _PersonalInfoTab(
//                 ownerName: widget.ownerName,
//                 mobileNumber: widget.mobileNumber,
//                 email: widget.email,
//                 aadharNumber: widget.aadharNumber,
//                 panNumber: widget.panNumber,
//               ),
//
//               // Hotel Tab
//               _HotelInfoTab(
//                 hotelName: widget.hotelName,
//                 addressLine1: widget.addressLine1,
//                 addressLine2: widget.addressLine2,
//                 city: widget.city,
//                 district: widget.district,
//                 state: widget.state,
//                 pinCode: widget.pinCode,
//                 totalRooms: widget.totalRooms,
//               ),
//
//               // Documents Tab
//               _DocumentsTab(
//                 gstNumber: widget.gstNumber,
//                 fssaiLicense: widget.fssaiLicense,
//                 tradeLicense: widget.tradeLicense,
//               ),
//
//               // Bank Tab
//               _BankInfoTab(
//                 accountHolderName: widget.accountHolderName,
//                 bankName: widget.bankName,
//                 accountNumber: widget.accountNumber,
//                 ifscCode: widget.ifscCode,
//                 branch: widget.branch,
//                 accountType: widget.accountType,
//               ),
//             ],
//           ),
//         ),
//       ),
//
//       // Edit Profile Floating Button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Edit profile action
//         },
//         backgroundColor: Color(0xFF4F46E5),
//         child: Icon(Icons.edit, color: Colors.white),
//       ),
//     );
//   }
//
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
//           style: TextStyle(
//             color: color.withOpacity(0.9),
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // **PERSONAL INFO TAB** (keep your existing)
// class _PersonalInfoTab extends StatelessWidget {
//   final String ownerName;
//   final String mobileNumber;
//   final String email;
//   final String aadharNumber;
//   final String panNumber;
//
//   const _PersonalInfoTab({
//     required this.ownerName,
//     required this.mobileNumber,
//     required this.email,
//     required this.aadharNumber,
//     required this.panNumber,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Identity Cards'),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildIDCard(
//                   title: 'Aadhar Card',
//                   number: aadharNumber,
//                   icon: Icons.credit_card,
//                   color: Color(0xFF4CAF50),
//                   isVerified: true,
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: _buildIDCard(
//                   title: 'PAN Card',
//                   number: panNumber,
//                   icon: Icons.assignment,
//                   color: Color(0xFF2196F3),
//                   isVerified: true,
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 24),
//
//           _buildSectionHeader('Contact Information'),
//           SizedBox(height: 12),
//           _buildContactCard(),
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
//   Widget _buildIDCard({
//     required String title,
//     required String number,
//     required IconData icon,
//     required Color color,
//     required bool isVerified,
//   }) {
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
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: color, size: 22),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       number,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: isVerified ? Color(0xFF4CAF50).withOpacity(0.1) : Colors.orange.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       isVerified ? Icons.verified : Icons.pending,
//                       size: 12,
//                       color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       isVerified ? 'Verified' : 'Pending',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: isVerified ? Color(0xFF4CAF50) : Colors.orange,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
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
//             icon: Icons.person,
//             label: 'Full Name',
//             value: ownerName,
//           ),
//           Divider(height: 20),
//           _buildContactRow(
//             icon: Icons.phone,
//             label: 'Mobile',
//             value: mobileNumber,
//             isCopyable: true,
//           ),
//           Divider(height: 20),
//           _buildContactRow(
//             icon: Icons.email,
//             label: 'Email',
//             value: email,
//             isCopyable: true,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     bool isCopyable = false,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Color(0xFF4F46E5).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 18, color: Color(0xFF4F46E5)),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 2),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // if (isCopyable)
//           // IconButton(
//           //   icon: Icon(Icons.content_copy, size: 18, color: Color(0xFF4F46E5)),
//           //   onPressed: () {
//           //     Clipboard.setData(ClipboardData(text: value));
//           //     ScaffoldMessenger.of(context).showSnackBar(
//           //       SnackBar(
//           //         content: Text('Copied to clipboard'),
//           //         duration: Duration(seconds: 1),
//           //       ),
//           //     );
//           //   },
//           // ),
//       ],
//     );
//   }
// }
//
// // **HOTEL TAB** (keep your existing)
// class _HotelInfoTab extends StatelessWidget {
//   final String hotelName;
//   final String addressLine1;
//   final String addressLine2;
//   final String city;
//   final String district;
//   final String state;
//   final String pinCode;
//   final int totalRooms;
//
//   const _HotelInfoTab({
//     required this.hotelName,
//     required this.addressLine1,
//     required this.addressLine2,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.pinCode,
//     required this.totalRooms,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Address Details'),
//           SizedBox(height: 12),
//           _buildAddressCard(),
//
//           SizedBox(height: 20),
//
//           _buildSectionHeader('Hotel Details'),
//           SizedBox(height: 12),
//           _buildHotelDetailsCard(),
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
//   Widget _buildHotelDetailsCard() {
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
//           _buildInfoRow('Total Rooms', '$totalRooms Rooms'),
//           Divider(height: 20),
//           _buildInfoRow('City', city),
//           Divider(height: 20),
//           _buildInfoRow('State', state),
//         ],
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
//
// // **DOCUMENTS TAB** (keep your existing)
// class _DocumentsTab extends StatelessWidget {
//   final String gstNumber;
//   final String fssaiLicense;
//   final String tradeLicense;
//
//   const _DocumentsTab({
//     required this.gstNumber,
//     required this.fssaiLicense,
//     required this.tradeLicense,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Business Documents'),
//           SizedBox(height: 12),
//           _buildDocumentCard(
//             title: 'GST Certificate',
//             number: gstNumber,
//             expiryDate: '2025-12-31',
//             status: 'Active',
//             icon: Icons.receipt_long,
//             color: Color(0xFF4F46E5),
//           ),
//
//           SizedBox(height: 16),
//
//           _buildDocumentCard(
//             title: 'FSSAI License',
//             number: fssaiLicense,
//             expiryDate: '2024-12-31',
//             status: 'Active',
//             icon: Icons.restaurant,
//             color: Color(0xFF4CAF50),
//           ),
//
//           SizedBox(height: 16),
//
//           _buildDocumentCard(
//             title: 'Trade License',
//             number: tradeLicense,
//             expiryDate: '2025-03-31',
//             status: 'Renewed',
//             icon: Icons.business,
//             color: Color(0xFFF59E0B),
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
//   Widget _buildDocumentCard({
//     required String title,
//     required String number,
//     required String expiryDate,
//     required String status,
//     required IconData icon,
//     required Color color,
//   }) {
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
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   number,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 13,
//                   ),
//                 ),
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: status == 'Active'
//                             ? Colors.green.withOpacity(0.1)
//                             : Colors.orange.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         status,
//                         style: TextStyle(
//                           color: status == 'Active' ? Colors.green : Colors.orange,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Expires: $expiryDate',
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                         fontSize: 11,
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
//
// // **BANK TAB** (keep your existing)
// class _BankInfoTab extends StatelessWidget {
//   final String accountHolderName;
//   final String bankName;
//   final String accountNumber;
//   final String ifscCode;
//   final String branch;
//   final String accountType;
//
//   const _BankInfoTab({
//     required this.accountHolderName,
//     required this.bankName,
//     required this.accountNumber,
//     required this.ifscCode,
//     required this.branch,
//     required this.accountType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildSectionHeader('Bank Account Details'),
//           SizedBox(height: 12),
//           _buildAccountDetailsCard(),
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
//   Widget _buildBankInfoRow(String label, String value, {bool isSensitive = false}) {
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
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
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
// }

































