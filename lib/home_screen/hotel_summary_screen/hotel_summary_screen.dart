import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import '../../onboarding_screen/choose_role_screen.dart';

class NormalHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

  NormalHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for Normal hotels
  final Color _primaryColor = const Color(0xFFFF5F6D);
  final Color _primaryLight =  Color(0xFFFF5F6D).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Standard Hotel',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelBasicInfo(),
            _buildContactInfo(),
            _buildAddressInfo(),
            _buildRoomConfiguration(),
            _buildAmenitiesSection(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration Submitted Successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelBasicInfo() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
        _infoRow('Hotel Category', 'Standard Hotel'),
        if (_get('hotelType') != null)
          _infoRow('Hotel Type', _get('hotelType')),

        // Year of Establishment as integer
        if (_get('yearOfEstablishment') != null &&
            _get('yearOfEstablishment').toString().isNotEmpty)
          _infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))),

        // Total Rooms as integer
        if (_get('totalRooms') != null &&
            _get('totalRooms').toString().isNotEmpty)
          _infoRow('Total Rooms', _formatInteger(_get('totalRooms'))),
      ],
    );
  }

  Widget _buildContactInfo() {
    final List<Widget> children = [
      _infoRow('Owner/Manager', _get('ownerName', 'Not Provided')),
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ];

    // Alternate Contact
    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    // Landline Numbers
    final landlineNumbers = _get('landlineNumbers', []);
    if (landlineNumbers is List && landlineNumbers.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Landline Numbers', style: _labelStyle),
            const SizedBox(height: 8),
            ...landlineNumbers
                .map(
                  (number) => Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: _textLight),
                    const SizedBox(width: 8),
                    Text(number.toString(), style: _valueStyle),
                  ],
                ),
              ),
            )
                .toList(),
          ],
        ),
      );
    }

    // Email
    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    // Website
    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('personPhotoInfo');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('District', _get('district', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Country
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    // Landmark
    if (_get('landmark') != null && _get('landmark').toString().isNotEmpty) {
      children.add(_infoRow('Landmark', _get('landmark')));
    }

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildRoomConfiguration() {
    final selectedRoomTypes = _get('selectedRoomTypes', {});
    final roomDetails = _get('roomDetails', {});

    // Check if any rooms are selected
    bool hasRooms = false;
    if (selectedRoomTypes is Map) {
      hasRooms = selectedRoomTypes.entries.any((entry) => entry.value == true);
    }

    if (!hasRooms) return const SizedBox.shrink();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Types Available', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var roomType in selectedTypes) {
      final details = roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    child: Icon(Icons.hotel, size: 18, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Rooms', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // AC/Non-AC
              if (details['ac'] != null)
                _detailRow(
                  'AC/Non-AC',
                  details['ac'] == true ? 'AC' : 'Non-AC',
                ),

              // Price per Night (double)
              if (details['price'] != null && details['price'].toString().isNotEmpty)
                _detailRow('Price per Night', '₹${_formatPrice(details['price'])}'),

              // Extra Bed
              if (details['extraBed'] != null)
                _detailRow(
                  'Extra Bed',
                  details['extraBed'] == true ? 'Yes' : 'No',
                ),

              // Extra Bed Price (double)
              if (details['extraBed'] == true &&
                  details['extraBedPrice'] != null &&
                  details['extraBedPrice'].toString().isNotEmpty)
                _detailRow('Extra Bed Price', '₹${_formatPrice(details['extraBedPrice'])}'),
            ],
          ),
        ),
      );
    }

    // Overall pricing
    final minTariff = _get('minTariff', '');
    final maxTariff = _get('maxTariff', '');

    if (minTariff.toString().isNotEmpty || maxTariff.toString().isNotEmpty) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Tariff Range',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${_formatPrice(minTariff)} - ₹${_formatPrice(maxTariff)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _successColor,
                    ),
                  ),
                ],
              ),
              if (_get('extraBedAvailable') != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _successColor),
                  ),
                  child: Text(
                    _get('extraBedAvailable') == true
                        ? 'Extra Bed Available'
                        : 'No Extra Bed',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _successColor,
                    ),
                  ),
                ),
            ],
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
    final List<Widget> amenitySections = [];

    // Basic Amenities
    final basicAmenities = _getAmenities('basicAmenities');
    if (basicAmenities != null && basicAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Basic Amenities', basicAmenities),
      );
    }

    // Hotel Facilities
    final hotelFacilities = _getAmenities('hotelFacilities');
    if (hotelFacilities != null &&
        hotelFacilities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Hotel Facilities', hotelFacilities));
    }

    // Food Services
    final foodServices = _getAmenities('foodServices');
    if (foodServices != null && foodServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Food Services', foodServices));
    }

    // Additional Amenities
    final additionalAmenities = _getAmenities('additionalAmenities');
    if (additionalAmenities != null &&
        additionalAmenities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Additional Amenities', additionalAmenities));
    }

    // Custom Amenities
    final customAmenities = _get('customAmenities', []);
    if (customAmenities is List && customAmenities.isNotEmpty) {
      amenitySections.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Custom Amenities', style: _labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: customAmenities
                  .map(
                    (amenity) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _primaryColor,
                        _primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    amenity.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Amenities & Facilities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('aadharNumber') != null &&
        _get('aadharNumber').toString().isNotEmpty) {
      children.add(_infoRow('Aadhaar Number', _get('aadharNumber')));
    }

    if (_get('panNumber') != null &&
        _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    if (_get('hasDigitalSignature') == true) {
      children.add(
        Container(
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
                child: const Icon(Icons.draw, size: 20, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Signature')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Photos')) return Icons.photo_library;
      if (docName.contains('Proof')) return Icons.perm_identity;
      if (docName.contains('PAN')) return Icons.credit_card;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Signature')) return Colors.purple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('GST')) return _primaryColor;
      if (docName.contains('PAN')) return Colors.orange;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    if (_get('declarationName') != null &&
        _get('declarationName').toString().isNotEmpty) {
      children.add(_infoRow('Name', _get('declarationName')));
    }

    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _get('declarationAccepted', false) == true
              ? _successColor.withOpacity(0.1)
              : _dangerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'I hereby declare that the information provided above is true and correct to the best of my knowledge.',
                    style: TextStyle(fontSize: 12, color: _textLight),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text(
            'Your hotel has been registered successfully!',
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['fullName']?.toString() ??
                            registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['phone']?.toString() ??
                            registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
    }
    return value.toString();
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class TwoStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

  TwoStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 2-Star hotels
  final Color _primaryColor = const Color(0xFF6B8E23); // Olive Green
  final Color _primaryLight =  Color(0xFF6B8E23).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '2-Star Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(2, (index) =>
                    Icon(Icons.star, size: 12, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelBasicInfo(),
            _buildContactInfo(),
            _buildAddressInfo(),
            _buildRoomConfiguration(),
            _buildAmenitiesSection(),
            _buildPoliciesSection(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration Submitted Successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(2, (index) =>
                Icon(Icons.star, size: 16, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelBasicInfo() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
        _infoRow('Hotel Category', '2-Star Hotel'),
        if (_get('hotelType') != null)
          _infoRow('Hotel Type', _get('hotelType')),

        // Year of Establishment as integer
        if (_get('yearOfEstablishment') != null &&
            _get('yearOfEstablishment').toString().isNotEmpty)
          _infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))),

        // Total Rooms as integer
        if (_get('totalRooms') != null &&
            _get('totalRooms').toString().isNotEmpty)
          _infoRow('Total Rooms', _formatInteger(_get('totalRooms'))),

        // Designation (2-Star specific)
        if (_get('designation') != null &&
            _get('designation').toString().isNotEmpty)
          _infoRow('Designation', _get('designation')),
      ],
    );
  }

  Widget _buildContactInfo() {
    final List<Widget> children = [
      _infoRow('Owner/Manager', _get('ownerName', 'Not Provided')),
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ];

    // Alternate Contact
    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    // Email
    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    // Website
    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('District', _get('district', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Country
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    // Additional Addresses
    final additionalAddresses = _get('additionalAddresses', []);
    if (additionalAddresses is List && additionalAddresses.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Addresses', style: _labelStyle),
            const SizedBox(height: 8),
            ...additionalAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1;
              dynamic addr = entry.value;
              String addressText = '';

              if (addr is Map) {
                addressText = addr['address']?.toString() ?? '';
              } else if (addr is String) {
                addressText = addr;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        addressText.isNotEmpty
                            ? addressText
                            : 'Additional Address',
                        style: _valueStyle,
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

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildRoomConfiguration() {
    final selectedRoomTypes = _get('selectedRoomTypes', {});
    final roomDetails = _get('roomDetails', {});

    // Check if any rooms are selected
    bool hasRooms = false;
    if (selectedRoomTypes is Map) {
      hasRooms = selectedRoomTypes.entries.any((entry) => entry.value == true);
    }

    if (!hasRooms) return const SizedBox.shrink();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Types Available', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var roomType in selectedTypes) {
      final details = roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    child: Icon(Icons.hotel, size: 18, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Rooms', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // AC/Non-AC
              if (details['ac'] != null)
                _detailRow(
                  'AC/Non-AC',
                  details['ac'] == true ? 'AC' : 'Non-AC',
                ),

              // Price per Night (double)
              if (details['price'] != null && details['price'].toString().isNotEmpty)
                _detailRow('Price per Night', '₹${_formatPrice(details['price'])}'),
            ],
          ),
        ),
      );
    }

    // Overall pricing
    final minTariff = _get('minTariff', '');
    final maxTariff = _get('maxTariff', '');

    if (minTariff.toString().isNotEmpty || maxTariff.toString().isNotEmpty) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Tariff Range',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${_formatPrice(minTariff)} - ₹${_formatPrice(maxTariff)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _successColor,
                    ),
                  ),
                ],
              ),
              if (_get('extraBedAvailable') != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _successColor),
                  ),
                  child: Text(
                    _get('extraBedAvailable') == true
                        ? 'Extra Bed Available'
                        : 'No Extra Bed',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _successColor,
                    ),
                  ),
                ),
            ],
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
    final List<Widget> amenitySections = [];

    // Room Amenities
    final roomAmenities = _getAmenities('roomAmenities');
    if (roomAmenities != null && roomAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Room Amenities', roomAmenities),
      );
    }

    // Hotel Facilities
    final hotelFacilities = _getAmenities('hotelFacilities');
    if (hotelFacilities != null &&
        hotelFacilities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Hotel Facilities', hotelFacilities));
    }

    // Food Services
    final foodServices = _getAmenities('foodServices');
    if (foodServices != null && foodServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Food Services', foodServices));
    }

    // Guest Services
    final guestServices = _getAmenities('guestServices');
    if (guestServices != null && guestServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Guest Services', guestServices));
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Amenities & Facilities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildPoliciesSection() {
    final List<Widget> children = [];


    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-in Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkIn.toString()),
                          style: _valueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-out Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkOut.toString()),
                          style: _valueStyle,
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

    // // Couple Friendly
    // if (_get('coupleFriendly') != null) {
    //   children.add(
    //     _infoRow(
    //       'Couple Friendly',
    //       _get('coupleFriendly') == true ? 'Yes' : 'No',
    //     ),
    //   );
    // }

    // Pets Allowed
    if (_get('petsAllowed') != null) {
      children.add(
        _infoRow('Pets Allowed', _get('petsAllowed') == true ? 'Yes' : 'No'),
      );
    }

    // ID Proof Required
    final idProof = _get('idProofRequired', '');
    if (idProof.toString().isNotEmpty) {
      children.add(_infoRow('ID Proof Required', idProof));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Policies & Timings',
      icon: Icons.policy,
      children: children,
    );
  }

  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    if (_get('panNumber') != null &&
        _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    if (_get('hasDigitalSignature') == true) {
      children.add(
        Container(
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
                child: const Icon(Icons.draw, size: 20, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Signature')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Photos')) return Icons.photo_library;
      if (docName.contains('Proof')) return Icons.perm_identity;
      if (docName.contains('PAN')) return Icons.credit_card;
      if (docName.contains('Registration')) return Icons.assignment;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Signature')) return Colors.purple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('GST')) return _primaryColor;
      if (docName.contains('PAN')) return Colors.orange;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    if (_get('declarationName') != null &&
        _get('declarationName').toString().isNotEmpty) {
      children.add(_infoRow('Name', _get('declarationName')));
    }

    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _get('declarationAccepted', false) == true
              ? _successColor.withOpacity(0.1)
              : _dangerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'I hereby confirm that all the information provided above is true and accurate.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text(
            'Your 2-Star hotel has been registered successfully!',
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['fullName']?.toString() ??
                            registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['phone']?.toString() ??
                            registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class ThreeStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

  ThreeStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 3-Star hotels (Gold)
  final Color _primaryColor = const Color(0xFFDAA520);
  final Color _primaryLight =  Color(0xFFDAA520).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '3-Star Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(3, (index) =>
                    Icon(Icons.star, size: 12, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelBasicInfo(),
            _buildContactInfo(),
            _buildAddressInfo(),
            _buildRoomConfiguration(),
            _buildAmenitiesSection(),
            _buildPoliciesSection(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration Submitted Successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(3, (index) =>
                Icon(Icons.star, size: 16, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelBasicInfo() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
        _infoRow('Hotel Category', '3-Star Hotel'),
        if (_get('hotelType') != null)
          _infoRow('Hotel Type', _get('hotelType')),

        // Year of Establishment as integer
        if (_get('yearOfEstablishment') != null &&
            _get('yearOfEstablishment').toString().isNotEmpty)
          _infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))),

        // Total Rooms as integer
        if (_get('totalRooms') != null &&
            _get('totalRooms').toString().isNotEmpty)
          _infoRow('Total Rooms', _formatInteger(_get('totalRooms'))),

        // Registration Number (3-Star specific)
        if (_get('registrationNumber') != null &&
            _get('registrationNumber').toString().isNotEmpty)
          _infoRow('Registration Number', _get('registrationNumber')),

        // Designation
        if (_get('designation') != null &&
            _get('designation').toString().isNotEmpty)
          _infoRow('Designation', _get('designation')),
      ],
    );
  }

  Widget _buildContactInfo() {
    final List<Widget> children = [
      _infoRow('Owner/Manager', _get('ownerName', 'Not Provided')),
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ];

    // Alternate Contact
    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    // Email
    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    // Website
    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('District', _get('district', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Country
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    // Additional Addresses
    final additionalAddresses = _get('additionalAddresses', []);
    if (additionalAddresses is List && additionalAddresses.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Addresses', style: _labelStyle),
            const SizedBox(height: 8),
            ...additionalAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1;
              dynamic addr = entry.value;
              String addressText = '';

              if (addr is Map) {
                addressText = addr['address']?.toString() ?? '';
              } else if (addr is String) {
                addressText = addr;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        addressText.isNotEmpty
                            ? addressText
                            : 'Additional Address',
                        style: _valueStyle,
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

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildRoomConfiguration() {
    final selectedRoomTypes = _get('selectedRoomTypes', {});
    final roomDetails = _get('roomDetails', {});

    // Check if any rooms are selected
    bool hasRooms = false;
    if (selectedRoomTypes is Map) {
      hasRooms = selectedRoomTypes.entries.any((entry) => entry.value == true);
    }

    if (!hasRooms) return const SizedBox.shrink();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Types Available', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var roomType in selectedTypes) {
      final details = roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    child: Icon(Icons.hotel, size: 18, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Rooms', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // AC
              if (details['ac'] != null)
                _detailRow('AC', details['ac'] == true ? 'Yes' : 'No'),

              // Bed Type (3-Star specific)
              if (details['bedType'] != null &&
                  details['bedType'].toString().isNotEmpty)
                _detailRow('Bed Type', details['bedType']),

              // Price per Night (double)
              if (details['price'] != null && details['price'].toString().isNotEmpty)
                _detailRow('Price per Night', '₹${_formatPrice(details['price'])}'),
            ],
          ),
        ),
      );
    }

    // Overall pricing (not applicable for 3-Star as they have individual room prices)
    // But we can show seasonal pricing if available
    if (_get('seasonalPricing') != null) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seasonal Pricing',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _get('seasonalPricing') == true ? 'Available' : 'Not Available',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _get('seasonalPricing') == true ? _successColor : _textLight,
                    ),
                  ),
                ],
              ),
              if (_get('extraBedAvailable') != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _successColor),
                  ),
                  child: Text(
                    _get('extraBedAvailable') == true
                        ? 'Extra Bed Available'
                        : 'No Extra Bed',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _successColor,
                    ),
                  ),
                ),
            ],
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
    final List<Widget> amenitySections = [];

    // Room Amenities
    final roomAmenities = _getAmenities('roomAmenities');
    if (roomAmenities != null && roomAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Room Amenities', roomAmenities),
      );
    }

    // Hotel Facilities
    final hotelFacilities = _getAmenities('hotelFacilities');
    if (hotelFacilities != null &&
        hotelFacilities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Hotel Facilities', hotelFacilities));
    }

    // Food Services
    final foodServices = _getAmenities('foodServices');
    if (foodServices != null && foodServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Food Services', foodServices));
    }

    // Business Services (3-Star specific)
    final businessServices = _getAmenities('businessServices');
    if (businessServices != null && businessServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Business Services', businessServices));
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Amenities & Facilities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  // Widget _buildPoliciesSection() {
  //   final List<Widget> children = [];
  //
  //   // Check-in/Check-out times
  //   final checkIn = _get('checkInTime', '');
  //   final checkOut = _get('checkOutTime', '');
  //
  //   if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
  //     children.add(
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text('Check-in Time', style: _labelStyle),
  //                 const SizedBox(height: 4),
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 12,
  //                     vertical: 8,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[50],
  //                     borderRadius: BorderRadius.circular(8),
  //                     border: Border.all(color: _borderColor),
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.access_time, size: 14, color: _primaryColor),
  //                       const SizedBox(width: 8),
  //                       Text(
  //                         _formatTime(checkIn.toString()),
  //                         style: _valueStyle,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text('Check-out Time', style: _labelStyle),
  //                 const SizedBox(height: 4),
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 12,
  //                     vertical: 8,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[50],
  //                     borderRadius: BorderRadius.circular(8),
  //                     border: Border.all(color: _borderColor),
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.access_time, size: 14, color: _primaryColor),
  //                       const SizedBox(width: 8),
  //                       Text(
  //                         _formatTime(checkOut.toString()),
  //                         style: _valueStyle,
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
  //   // Early Check-in / Late Check-out (3-Star specific)
  //   if (_get('earlyCheckinAllowed') != null) {
  //     children.add(
  //       _infoRow(
  //         'Early Check-in / Late Check-out',
  //         _get('earlyCheckinAllowed') == true
  //             ? (_get('earlyCheckinChargeable') == true
  //             ? 'Chargeable'
  //             : 'Complimentary')
  //             : 'Not Available',
  //       ),
  //     );
  //   }
  //
  //   // Pets Allowed
  //   if (_get('petsAllowed') != null) {
  //     children.add(
  //       _infoRow('Pets Allowed', _get('petsAllowed') == true ? 'Yes' : 'No'),
  //     );
  //   }
  //
  //   if (children.isEmpty) return const SizedBox.shrink();
  //
  //   return _buildSectionCard(
  //     title: 'Policies & Timings',
  //     icon: Icons.policy,
  //     children: children,
  //   );
  // }
  Widget _buildPoliciesSection() {
    final List<Widget> children = [];

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-in Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkIn.toString()),
                          style: _valueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-out Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkOut.toString()),
                          style: _valueStyle,
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

    // Early Check-in / Late Check-out (3-Star specific) - FIXED
    if (_get('earlyCheckinAllowed') != null) {
      String earlyCheckinStatus = 'Not Allowed';

      if (_get('earlyCheckinAllowed') == true) {
        earlyCheckinStatus = _get('earlyCheckinChargeable') == true
            ? 'Chargeable'
            : 'Free'; // Changed from 'Complimentary' to 'Free'
      }

      children.add(
        _infoRow('Early Check-in / Late Check-out', earlyCheckinStatus),
      );
    }

    // Pets Allowed
    if (_get('petsAllowed') != null) {
      children.add(
        _infoRow('Pets Allowed', _get('petsAllowed') == true ? 'Yes' : 'No'),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Policies & Timings',
      icon: Icons.policy,
      children: children,
    );
  }


  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('panNumber') != null && _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    // Fire Safety Certificate (3-Star specific)
    if (_get('fireSafetyCertificate') != null) {
      children.add(
        _infoRow(
          'Fire Safety Certificate',
          _get('fireSafetyCertificate') == true ? 'Available' : 'Not Available',
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      // Skip Digital Signature as it's handled separately
      if (entry.key == 'Digital Signature') continue;
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    if (_get('hasDigitalSignature') == true) {
      children.add(
        Container(
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
                child: const Icon(Icons.draw, size: 20, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    // Uploaded Signature File
    final signatureFile = _get('signatureFile');
    if (signatureFile != null && signatureFile['uploaded'] == true) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.note_alt_outlined, size: 20, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uploaded Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      signatureFile['name'] ?? 'Signature uploaded',
                      style: TextStyle(fontSize: 12, color: _textLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Signature')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('PAN')) return Icons.credit_card;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Photos')) return Icons.photo_library;
      if (docName.contains('Fire')) return Icons.fire_extinguisher;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Signature')) return Colors.purple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('Fire')) return Colors.red;
      if (docName.contains('GST')) return _primaryColor;
      if (docName.contains('PAN')) return Colors.orange;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    // Signatory Name
    if (_get('signatoryName') != null &&
        _get('signatoryName').toString().isNotEmpty) {
      children.add(_infoRow('Signatory Name', _get('signatoryName')));
    }

    // Declaration Date
    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    // Declaration Status
    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _get('declarationAccepted', false) == true
              ? _successColor.withOpacity(0.1)
              : _dangerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'I hereby declare that the above information is true and correct. I agree to comply with all vendor terms, service standards, and policies.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text(
            'Your 3-Star hotel has been registered successfully!',
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['fullName']?.toString() ??
                            registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['phone']?.toString() ??
                            registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class FourStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

  FourStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 4-Star hotels (Indigo/Purple)
  final Color _primaryColor = const Color(0xFF4F46E5);
  final Color _primaryLight =  Color(0xFF4F46E5).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '4-Star Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(4, (index) =>
                    Icon(Icons.star, size: 12, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
                  '4-Star',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelBasicInfo(),
            _buildContactInfo(),
            _buildAddressInfo(),
            _buildRoomConfiguration(),
            _buildAmenitiesSection(),
            _buildPoliciesSection(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration Submitted Successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(4, (index) =>
                Icon(Icons.star, size: 16, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelBasicInfo() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
        _infoRow('Hotel Category', '4-Star Hotel'),
        if (_get('hotelType') != null)
          _infoRow('Hotel Type', _get('hotelType')),

        // Year of Establishment as integer
        if (_get('yearOfEstablishment') != null &&
            _get('yearOfEstablishment').toString().isNotEmpty)
          _infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))),

        // Total Rooms as integer
        if (_get('totalRooms') != null &&
            _get('totalRooms').toString().isNotEmpty)
          _infoRow('Total Rooms', _formatInteger(_get('totalRooms'))),

        // Registration Number (4-Star specific)
        if (_get('registrationNumber') != null &&
            _get('registrationNumber').toString().isNotEmpty)
          _infoRow('Registration Number', _get('registrationNumber')),

        // Designation
        if (_get('designation') != null &&
            _get('designation').toString().isNotEmpty)
          _infoRow('Designation', _get('designation')),
      ],
    );
  }

  Widget _buildContactInfo() {
    final List<Widget> children = [
      _infoRow('Owner/Manager', _get('ownerName', 'Not Provided')),
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ];

    // Alternate Contact
    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    // Email
    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    // Website
    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('District', _get('district', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Country
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    // Additional Addresses
    final additionalAddresses = _get('additionalAddresses', []);
    if (additionalAddresses is List && additionalAddresses.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Addresses', style: _labelStyle),
            const SizedBox(height: 8),
            ...additionalAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1;
              dynamic addr = entry.value;
              String addressText = '';

              if (addr is Map) {
                addressText = addr['address']?.toString() ?? '';
              } else if (addr is String) {
                addressText = addr;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        addressText.isNotEmpty
                            ? addressText
                            : 'Additional Address',
                        style: _valueStyle,
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

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildRoomConfiguration() {
    final selectedRoomTypes = _get('selectedRoomTypes', {});
    final roomDetails = _get('roomDetails', {});

    // Check if any rooms are selected
    bool hasRooms = false;
    if (selectedRoomTypes is Map) {
      hasRooms = selectedRoomTypes.entries.any((entry) => entry.value == true);
    }

    if (!hasRooms) return const SizedBox.shrink();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Types Available', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var roomType in selectedTypes) {
      final details = roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    child: Icon(Icons.hotel, size: 18, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Rooms', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // AC
              if (details['ac'] != null)
                _detailRow('AC', details['ac'] == true ? 'Yes' : 'No'),

              // Bed Type (4-Star specific)
              if (details['bedType'] != null &&
                  details['bedType'].toString().isNotEmpty)
                _detailRow('Bed Type', details['bedType']),

              // Price per Night (double)
              if (details['price'] != null && details['price'].toString().isNotEmpty)
                _detailRow('Price per Night', '₹${_formatPrice(details['price'])}'),
            ],
          ),
        ),
      );
    }

    // Extra Bed and Seasonal Pricing
    if (_get('extraBedAvailable') != null || _get('seasonalPricing') != null) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_get('seasonalPricing') != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month, size: 16, color: _successColor),
                          const SizedBox(width: 8),
                          Text(
                            'Seasonal Pricing',
                            style: TextStyle(
                              fontSize: 13,
                              color: _textLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _get('seasonalPricing') == true ? 'Yes' : 'No',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _get('seasonalPricing') == true ? _successColor : _textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_get('extraBedAvailable') != null)
                    Row(
                      children: [
                        Icon(Icons.bed, size: 16, color: _successColor),
                        const SizedBox(width: 8),
                        Text(
                          'Extra Bed Available',
                          style: TextStyle(
                            fontSize: 13,
                            color: _textLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _get('extraBedAvailable') == true ? 'Yes' : 'No',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _get('extraBedAvailable') == true ? _successColor : _textLight,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
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
    final List<Widget> amenitySections = [];

    // Room Amenities
    final roomAmenities = _getAmenities('roomAmenities');
    if (roomAmenities != null && roomAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Room Amenities', roomAmenities),
      );
    }

    // Hotel Facilities
    final hotelFacilities = _getAmenities('hotelFacilities');
    if (hotelFacilities != null &&
        hotelFacilities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Hotel Facilities', hotelFacilities));
    }

    // Food Services
    final foodServices = _getAmenities('foodServices');
    if (foodServices != null && foodServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Food Services', foodServices));
    }

    // Business Services (4-Star specific)
    final businessServices = _getAmenities('businessServices');
    if (businessServices != null && businessServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Business Services', businessServices));
    }

    // Wellness & Recreation (4-Star specific)
    final wellnessRecreation = _getAmenities('wellnessRecreation');
    if (wellnessRecreation != null && wellnessRecreation.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Wellness & Recreation', wellnessRecreation));
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Amenities & Facilities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildPoliciesSection() {
    final List<Widget> children = [];

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-in Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkIn.toString()),
                          style: _valueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-out Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkOut.toString()),
                          style: _valueStyle,
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

    // Early Check-in / Late Check-out (4-Star specific)
    // if (_get('earlyCheckinAllowed') != null) {
    //   children.add(
    //     _infoRow(
    //       'Early Check-in / Late Check-out',
    //       _get('earlyCheckinAllowed') == true
    //           ? (_get('earlyCheckinChargeable') == true
    //           ? 'Chargeable'
    //           : 'Complimentary')
    //           : 'Not Available',
    //     ),
    //   );
    // }
    if (_get('earlyCheckinAllowed') != null) {
      String earlyCheckinStatus = 'Not Allowed';

      if (_get('earlyCheckinAllowed') == true) {
        earlyCheckinStatus = _get('earlyCheckinChargeable') == true
            ? 'Chargeable'
            : 'Free'; // Changed from 'Complimentary' to 'Free'
      }

      children.add(
        _infoRow('Early Check-in / Late Check-out', earlyCheckinStatus),
      );
    }

    // Pets Allowed
    if (_get('petsAllowed') != null) {
      children.add(
        _infoRow('Pets Allowed', _get('petsAllowed') == true ? 'Yes' : 'No'),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Policies & Timings',
      icon: Icons.policy,
      children: children,
    );
  }

  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('panNumber') != null && _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    // Fire Safety Certificate (4-Star specific)
    if (_get('fireSafetyCertificate') != null) {
      children.add(
        _infoRow(
          'Fire Safety Certificate',
          _get('fireSafetyCertificate') == true ? 'Available' : 'Not Available',
        ),
      );
    }

    // Star Certificate (4-Star specific)
    if (_get('starCertificate') != null) {
      children.add(
        _infoRow(
          'Star Classification Certificate',
          _get('starCertificate') == true ? 'Available' : 'Not Available',
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      // Skip Digital Signature as it's handled separately
      if (entry.key == 'Digital Signature') continue;
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    if (_get('hasDigitalSignature') == true) {
      children.add(
        Container(
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
                child: const Icon(Icons.draw, size: 20, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    // Uploaded Signature File
    final signatureFile = _get('signatureFile');
    if (signatureFile != null && signatureFile['uploaded'] == true) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.note_alt_outlined, size: 20, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uploaded Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      signatureFile['name'] ?? 'Signature uploaded',
                      style: TextStyle(fontSize: 12, color: _textLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Signature')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('PAN')) return Icons.credit_card;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Photos')) return Icons.photo_library;
      if (docName.contains('Fire')) return Icons.fire_extinguisher;
      if (docName.contains('Star')) return Icons.star;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Signature')) return Colors.purple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('Fire')) return Colors.red;
      if (docName.contains('GST')) return _primaryColor;
      if (docName.contains('PAN')) return Colors.orange;
      if (docName.contains('Star')) return _starColor;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    // Signatory Name
    if (_get('signatoryName') != null &&
        _get('signatoryName').toString().isNotEmpty) {
      children.add(_infoRow('Signatory Name', _get('signatoryName')));
    }

    // Declaration Date
    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    // Declaration Status
    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _get('declarationAccepted', false) == true
              ? _successColor.withOpacity(0.1)
              : _dangerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'I hereby declare that the above information is true and correct. I agree to comply with all vendor terms, service standards, and policies.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text(
            'Your 4-Star hotel has been registered successfully!',
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['fullName']?.toString() ??
                            registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['phone']?.toString() ??
                            registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class FiveStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

  FiveStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 5-Star hotels (Pink/Rose Gold)
  final Color _primaryColor = const Color(0xFFFB717D);
  final Color _primaryLight =  Color(0xFFFB717D).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);
  final Color _goldColor = const Color(0xFFFB717D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '5-Star Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(5, (index) =>
                    Icon(Icons.star, size: 12, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
                  '5-Star Luxury',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelBasicInfo(),
            _buildContactInfo(),
            _buildAddressInfo(),
            _buildRoomConfiguration(),
            _buildAmenitiesSection(),
            _buildPoliciesSection(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration Submitted Successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) =>
                Icon(Icons.star, size: 16, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelBasicInfo() {
    return _buildSectionCard(
      title: 'Hotel Information',
      icon: Icons.business,
      children: [
        _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
        _infoRow('Hotel Category', '5-Star Luxury Hotel'),
        if (_get('hotelType') != null)
          _infoRow('Hotel Type', _get('hotelType')),
        if (_get('brandName') != null && _get('brandName').toString().isNotEmpty)
          _infoRow('Brand Name', _get('brandName')),

        // Year of Establishment as integer
        if (_get('yearOfEstablishment') != null &&
            _get('yearOfEstablishment').toString().isNotEmpty)
          _infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))),

        // Total Rooms as integer
        if (_get('totalRooms') != null &&
            _get('totalRooms').toString().isNotEmpty)
          _infoRow('Total Rooms', _formatInteger(_get('totalRooms'))),

        // Star Certificate Number (5-Star specific)
        if (_get('starCertNumber') != null &&
            _get('starCertNumber').toString().isNotEmpty)
          _infoRow('Star Certificate No.', _get('starCertNumber')),

        // Designation
        if (_get('designation') != null &&
            _get('designation').toString().isNotEmpty)
          _infoRow('Designation', _get('designation')),
      ],
    );
  }

  Widget _buildContactInfo() {
    final List<Widget> children = [
      _infoRow('Owner/Manager', _get('ownerName', 'Not Provided')),
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ];

    // Alternate Contact
    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    // Email
    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    // Website
    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_phone,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('District', _get('district', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Country
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    // Additional Addresses
    final additionalAddresses = _get('additionalAddresses', []);
    if (additionalAddresses is List && additionalAddresses.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Addresses', style: _labelStyle),
            const SizedBox(height: 8),
            ...additionalAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1;
              dynamic addr = entry.value;
              String addressText = '';

              if (addr is Map) {
                addressText = addr['address']?.toString() ?? '';
              } else if (addr is String) {
                addressText = addr;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        addressText.isNotEmpty
                            ? addressText
                            : 'Additional Address',
                        style: _valueStyle,
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

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildRoomConfiguration() {
    final selectedRoomTypes = _get('selectedRoomTypes', {});
    final roomDetails = _get('roomDetails', {});

    // Check if any rooms are selected
    bool hasRooms = false;
    if (selectedRoomTypes is Map) {
      hasRooms = selectedRoomTypes.entries.any((entry) => entry.value == true);
    }

    if (!hasRooms) return const SizedBox.shrink();

    final selectedTypes = (selectedRoomTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Types Available', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(5, (index) =>
                        Icon(Icons.star, size: 8, color: _primaryColor)
                    ),
                    const SizedBox(width: 6),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryColor,
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

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var roomType in selectedTypes) {
      final details = roomDetails[roomType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
                    child: Icon(Icons.hotel, size: 18, color: _primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    roomType,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Units', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // Climate Control
              if (details['ac'] != null)
                _detailRow(
                  'Climate Control',
                  details['ac'] == true ? 'Yes' : 'No',
                ),

              // Bed Type (5-Star specific)
              if (details['bedType'] != null &&
                  details['bedType'].toString().isNotEmpty)
                _detailRow('Bed Type', details['bedType']),

              // Price Range (double)
              if (details['minPrice'] != null && details['minPrice'].toString().isNotEmpty &&
                  details['maxPrice'] != null && details['maxPrice'].toString().isNotEmpty)
                _detailRow('Price Range', '₹${_formatPrice(details['minPrice'])} - ₹${_formatPrice(details['maxPrice'])}'),
            ],
          ),
        ),
      );
    }

    // Extra Bed and Seasonal Pricing
    if (_get('extraBedAvailable') != null || _get('seasonalPricing') != null) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_get('seasonalPricing') != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month, size: 16, color: _successColor),
                          const SizedBox(width: 8),
                          Text(
                            'Dynamic/Seasonal Pricing',
                            style: TextStyle(
                              fontSize: 13,
                              color: _textLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _get('seasonalPricing') == true ? 'Yes' : 'No',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _get('seasonalPricing') == true ? _successColor : _textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_get('extraBedAvailable') != null)
                    Row(
                      children: [
                        Icon(Icons.bed, size: 16, color: _successColor),
                        const SizedBox(width: 8),
                        Text(
                          'Extra Bed / Rollaway',
                          style: TextStyle(
                            fontSize: 13,
                            color: _textLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _get('extraBedAvailable') == true ? 'Yes' : 'No',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _get('extraBedAvailable') == true ? _successColor : _textLight,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
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
    final List<Widget> amenitySections = [];

    // Room Amenities
    final roomAmenities = _getAmenities('roomAmenities');
    if (roomAmenities != null && roomAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('In-Room Luxury Amenities', roomAmenities),
      );
    }

    // Hotel Facilities
    final hotelFacilities = _getAmenities('hotelFacilities');
    if (hotelFacilities != null &&
        hotelFacilities.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Hotel Infrastructure', hotelFacilities));
    }

    // Dining Services
    final diningServices = _getAmenities('diningServices');
    if (diningServices != null && diningServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Dining & Events', diningServices));
    }

    // Wellness & Recreation
    final wellnessRecreation = _getAmenities('wellnessRecreation');
    if (wellnessRecreation != null && wellnessRecreation.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Wellness & Recreation', wellnessRecreation));
    }

    // Guest Services
    final guestServices = _getAmenities('guestServices');
    if (guestServices != null && guestServices.entries.any((e) => e.value)) {
      amenitySections.add(_buildAmenityCategory('Premium Guest Services', guestServices));
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Luxury Amenities & Facilities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildPoliciesSection() {
    final List<Widget> children = [];

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-in Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkIn.toString()),
                          style: _valueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-out Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkOut.toString()),
                          style: _valueStyle,
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

    // Early Check-in / Late Check-out (5-Star specific)
    // if (_get('earlyCheckinAllowed') != null) {
    //   children.add(
    //     _infoRow(
    //       'Early Check-in / Late Check-out',
    //       _get('earlyCheckinAllowed') == true
    //           ? (_get('earlyCheckinChargeable') == true
    //           ? 'Chargeable'
    //           : 'Complimentary')
    //           : 'Not Available',
    //     ),
    //   );
    // }
    if (_get('earlyCheckinAllowed') != null) {
      String earlyCheckinStatus = 'Not Allowed';

      if (_get('earlyCheckinAllowed') == true) {
        earlyCheckinStatus = _get('earlyCheckinChargeable') == true
            ? 'Chargeable'
            : 'Free'; // Changed from 'Complimentary' to 'Free'
      }

      children.add(
        _infoRow('Early Check-in / Late Check-out', earlyCheckinStatus),
      );
    }

    // Couple Friendly
    if (_get('coupleFriendly') != null) {
      children.add(
        _infoRow(
          'Couple Friendly',
          _get('coupleFriendly') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Pets Allowed
    if (_get('petsAllowed') != null) {
      children.add(
        _infoRow('Pets Allowed', _get('petsAllowed') == true ? 'Yes' : 'No'),
      );
    }

    // Smoking/Non-Smoking
    if (_get('smokingRooms') != null || _get('nonSmokingRooms') != null) {
      String smokingPolicy = '';
      if (_get('smokingRooms') == true) smokingPolicy += 'Smoking Rooms';
      if (_get('nonSmokingRooms') == true) {
        if (smokingPolicy.isNotEmpty) smokingPolicy += ', ';
        smokingPolicy += 'Non-Smoking Rooms';
      }
      if (smokingPolicy.isNotEmpty) {
        children.add(_infoRow('Smoking Policy', smokingPolicy));
      }
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Policies & Timings',
      icon: Icons.policy,
      children: children,
    );
  }

  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('panNumber') != null && _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    // Compliance Certificates (5-Star specific)
    final List<String> certificates = [];
    if (_get('fireSafetyCertificate') == true) certificates.add('Fire Safety NOC');
    if (_get('pollutionCertificate') == true) certificates.add('Pollution Control');
    if (_get('starCertificate') == true) certificates.add('Star Classification');
    if (_get('liftCertificate') == true) certificates.add('Lift Fitness');

    if (certificates.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Compliance Certificates', style: _labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: certificates.map((cert) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _successColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: _successColor),
                    const SizedBox(width: 4),
                    Text(
                      cert,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _successColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      // Skip Digital Signature as it's handled separately
      if (entry.key == 'Digital Signature') continue;
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    if (_get('hasDigitalSignature') == true) {
      children.add(
        Container(
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
                child: const Icon(Icons.draw, size: 20, color: Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    // Uploaded Signature File
    final signatureFile = _get('signatureFile');
    if (signatureFile != null && signatureFile['uploaded'] == true) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.note_alt_outlined, size: 20, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uploaded Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      signatureFile['name'] ?? 'Signature uploaded',
                      style: TextStyle(fontSize: 12, color: _textLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Signature')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('PAN')) return Icons.credit_card;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Photographs')) return Icons.photo_library;
      if (docName.contains('Fire')) return Icons.fire_extinguisher;
      if (docName.contains('Star')) return Icons.star;
      if (docName.contains('Pollution')) return Icons.eco;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Signature')) return Colors.purple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('Fire')) return Colors.red;
      if (docName.contains('GST')) return _primaryColor;
      if (docName.contains('PAN')) return Colors.orange;
      if (docName.contains('Star')) return _starColor;
      if (docName.contains('Pollution')) return Colors.teal;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    // Signatory Name
    if (_get('signatoryName') != null &&
        _get('signatoryName').toString().isNotEmpty) {
      children.add(_infoRow('Signatory Name', _get('signatoryName')));
    }

    // Signatory Designation
    if (_get('signatoryDesignation') != null &&
        _get('signatoryDesignation').toString().isNotEmpty) {
      children.add(_infoRow('Designation', _get('signatoryDesignation')));
    }

    // Declaration Date
    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    // Declaration Status
    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _get('declarationAccepted', false) == true
              ? _successColor.withOpacity(0.1)
              : _dangerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'I hereby certify that all information provided above is true and correct.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: const Text(
            'Your 5-Star Luxury hotel has been registered successfully!',
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['fullName']?.toString() ??
                            registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['phone']?.toString() ??
                            registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class SixStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

   SixStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 6-Star hotels
  final Color _primaryColor = const Color(0xFFD4AF37); // Royal Gold
  final Color _primaryLight =  Color(0xFFD4AF37).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);
  final Color _platinumColor = const Color(0xFFE5E4E2);
  final Color _royalPurple = const Color(0xFF7851A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '6-Star Hotel Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _royalPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(6, (index) =>
                    Icon(Icons.star, size: 10, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
                  '6-Star',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildHotelProfile(),
            _buildExecutiveManagement(),
            _buildAddressInfo(),
            _buildAccommodationInventory(),
            _buildLuxuryAmenities(),
            _buildGuestPolicies(),
            _buildLegalCompliance(),
            _buildBankDetails(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _royalPurple],
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ultra-Luxury Registration Submitted!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('hotelName', 'Hotel Name') ?? 'Hotel',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: 6S-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(6, (index) =>
                Icon(Icons.star, size: 14, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelProfile() {
    final List<Widget> children = [
      _infoRow('Hotel Name', _get('hotelName', 'Not Provided')),
      _infoRow('Hotel Category', '6-Star Ultra-Luxury Hotel'),
      _infoRow('Brand Name', _get('brandName', 'Not Provided')),
    ];

    if (_get('hotelType') != null) {
      children.add(_infoRow('Hotel Type', _get('hotelType')));
    }

    // Year of Establishment as integer
    if (_get('yearOfEstablishment') != null &&
        _get('yearOfEstablishment').toString().isNotEmpty) {
      children.add(_infoRow('Year Established', _formatInteger(_get('yearOfEstablishment'))));
    }

    // Total Rooms as integer
    if (_get('totalRooms') != null &&
        _get('totalRooms').toString().isNotEmpty) {
      children.add(_infoRow('Total Rooms', _formatInteger(_get('totalRooms'))));
    }

    // Global Recognition
    if (_get('globalRecognition') != null &&
        _get('globalRecognition').toString().isNotEmpty) {
      children.add(_buildRecognitionInfo());
    }

    return _buildSectionCard(
      title: 'Hotel Profile',
      icon: Icons.business,
      children: children,
    );
  }

  Widget _buildRecognitionInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Recognition', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.workspace_premium, color: _primaryColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _get('globalRecognition'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textDark,
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

  Widget _buildExecutiveManagement() {
    final List<Widget> children = [
      _infoRow('Owner / Signatory', _get('ownerName', 'Not Provided')),
      _infoRow('Designation', _get('designation', 'Not Provided')),
      _infoRow('General Manager', _get('gmName', 'Not Provided')),
    ];

    // Contact Details
    children.addAll([
      _infoRow('Mobile Number', _get('mobileNumber', 'Not Provided')),
    ]);

    if (_get('alternateContact') != null &&
        _get('alternateContact').toString().isNotEmpty) {
      children.add(_infoRow('Alternate Contact', _get('alternateContact')));
    }

    if (_get('email') != null && _get('email').toString().isNotEmpty) {
      children.add(_infoRow('Email', _get('email')));
    }

    if (_get('website') != null && _get('website').toString().isNotEmpty) {
      children.add(_infoRow('Website', _get('website')));
    }

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    return _buildSectionCard(
      title: 'Executive Management',
      icon: Icons.people,
      children: children,
    );
  }

  Widget _buildAddressInfo() {
    final List<Widget> children = [
      _infoRow('Address Line 1', _get('addressLine1', 'Not Provided')),
    ];

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    children.addAll([
      _infoRow('City', _get('city', 'Not Provided')),
      _infoRow('State', _get('state', 'Not Provided')),
      _infoRow('Country', _get('country', 'Not Provided')),
      _infoRow('PIN Code', _get('pinCode', 'Not Provided')),
    ]);

    // Additional Addresses
    final additionalAddresses = _get('additionalAddresses', []);
    if (additionalAddresses is List && additionalAddresses.isNotEmpty) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Addresses', style: _labelStyle),
            const SizedBox(height: 8),
            ...additionalAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1;
              dynamic addr = entry.value;
              String addressText = '';

              if (addr is Map) {
                addressText = addr['address']?.toString() ?? '';
              } else if (addr is String) {
                addressText = addr;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        addressText.isNotEmpty
                            ? addressText
                            : 'Additional Address',
                        style: _valueStyle,
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

    return _buildSectionCard(
      title: 'Address Details',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildAccommodationInventory() {
    final roomDetails = _get('roomDetails', {});

    if (roomDetails is! Map || roomDetails.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> children = [];

    // Room Details for each type
    for (var entry in roomDetails.entries) {
      String roomType = entry.key;
      Map<String, dynamic> details = entry.value is Map
          ? Map<String, dynamic>.from(entry.value)
          : {};

      // Check if this room type has any data
      bool hasData = details['rooms']?.toString().isNotEmpty == true ||
          details['occupancy']?.toString().isNotEmpty == true ||
          details['minPrice']?.toString().isNotEmpty == true ||
          details['maxPrice']?.toString().isNotEmpty == true;

      if (!hasData) continue;

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
            gradient: LinearGradient(
              colors: [Colors.white, _primaryLight.withOpacity(0.3)],
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
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.villa, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      roomType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _royalPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _royalPurple.withOpacity(0.3)),
                    ),
                    child: Text(
                      details['bedType'] ?? 'King',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _royalPurple,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Number of Rooms (integer)
              if (details['rooms'] != null && details['rooms'].toString().isNotEmpty)
                _detailRow('Number of Units', _formatInteger(details['rooms'])),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty)
                _detailRow('Max Occupancy', '${_formatInteger(details['occupancy'])} Persons'),

              // Price Range (double)
              if (details['minPrice'] != null && details['maxPrice'] != null &&
                  details['minPrice'].toString().isNotEmpty &&
                  details['maxPrice'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _successColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price Range',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _textLight,
                          ),
                        ),
                        Text(
                          '₹${_formatPrice(details['minPrice'])} - ₹${_formatPrice(details['maxPrice'])}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _successColor,
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

    // Personal Butler & AI Pricing
    final hasButler = _get('personalButler') != null;
    final hasAIPricing = _get('aiPricing') != null;

    if (hasButler || hasAIPricing) {
      children.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
          ),
          child: Row(
            children: [
              if (hasButler)
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        size: 20,
                        color: _get('personalButler') == true
                            ? _successColor
                            : _textLight,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Personal Butler',
                        style: TextStyle(
                          fontSize: 13,
                          color: _get('personalButler') == true
                              ? _textDark
                              : _textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              if (hasAIPricing)
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 20,
                        color: _get('aiPricing') == true
                            ? _successColor
                            : _textLight,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI Pricing',
                        style: TextStyle(
                          fontSize: 13,
                          color: _get('aiPricing') == true
                              ? _textDark
                              : _textLight,
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Accommodation Inventory',
      icon: Icons.meeting_room,
      children: children,
    );
  }

  Widget _buildLuxuryAmenities() {
    final List<Widget> amenitySections = [];

    // Room Amenities
    final roomAmenities = _getAmenities('roomAmenities');
    if (roomAmenities != null && roomAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('In-Room Ultra-Luxury Amenities', roomAmenities),
      );
    }

    // Hotel Infrastructure
    final hotelInfrastructure = _getAmenities('hotelInfrastructure');
    if (hotelInfrastructure != null &&
        hotelInfrastructure.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Hotel Infrastructure & Elite Services', hotelInfrastructure),
      );
    }

    // Dining Experiences
    final diningExperiences = _getAmenities('diningExperiences');
    if (diningExperiences != null &&
        diningExperiences.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Dining, Events & Experiences', diningExperiences),
      );
    }

    // Wellness & Leisure
    final wellnessLeisure = _getAmenities('wellnessLeisure');
    if (wellnessLeisure != null &&
        wellnessLeisure.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Wellness, Leisure & Lifestyle', wellnessLeisure),
      );
    }

    // Guest Privileges
    final guestPrivileges = _getAmenities('guestPrivileges');
    if (guestPrivileges != null &&
        guestPrivileges.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Exclusive Guest Privileges', guestPrivileges),
      );
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Ultra-Luxury Amenities',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildGuestPolicies() {
    final List<Widget> children = [];

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-In Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkIn.toString()),
                          style: _valueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Check-Out Time', style: _labelStyle),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: _primaryColor),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(checkOut.toString()),
                          style: _valueStyle,
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

    // VIP Protocols
    if (_get('vipProtocols') != null) {
      children.add(
        _infoRow(
          'VIP / Diplomatic Protocols',
          _get('vipProtocols') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Pet Luxury Services
    if (_get('petLuxuryServices') != null) {
      children.add(
        _infoRow(
          'Pet Luxury Services',
          _get('petLuxuryServices') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Smoking Policy
    if (_get('smokingPrivateAreas') != null || _get('nonSmoking') != null) {
      String smokingPolicy = '';
      if (_get('smokingPrivateAreas') == true) {
        smokingPolicy = 'Private Areas Only';
      } else if (_get('nonSmoking') == true) {
        smokingPolicy = 'Non-Smoking';
      }

      if (smokingPolicy.isNotEmpty) {
        children.add(_infoRow('Smoking Policy', smokingPolicy));
      }
    }

    // Early/Late Check-out
    children.add(
      _infoRow(
        'Early / Late Check-Out',
        'By Approval', // Default value
      ),
    );

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Guest Policies & Timings',
      icon: Icons.policy,
      children: children,
    );
  }

  Widget _buildLegalCompliance() {
    final List<Widget> children = [];

    if (_get('gstNumber') != null && _get('gstNumber').toString().isNotEmpty) {
      children.add(_infoRow('GST Number', _get('gstNumber')));
    }

    if (_get('panNumber') != null && _get('panNumber').toString().isNotEmpty) {
      children.add(_infoRow('PAN Number', _get('panNumber')));
    }

    if (_get('tradeLicense') != null &&
        _get('tradeLicense').toString().isNotEmpty) {
      children.add(_infoRow('Trade License', _get('tradeLicense')));
    }

    if (_get('fssaiLicense') != null &&
        _get('fssaiLicense').toString().isNotEmpty) {
      children.add(_infoRow('FSSAI License', _get('fssaiLicense')));
    }

    // Compliance Certificates
    final List<String> certificates = [];

    if (_get('fireSafetyNoc') == true) {
      certificates.add('Fire Safety & Disaster NOC');
    }
    if (_get('environmentalCert') == true) {
      certificates.add('Environmental & Sustainability Certification');
    }
    if (_get('internationalCert') == true) {
      certificates.add('International Safety/Quality Certification');
    }

    if (certificates.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Compliance Certificates', style: _labelStyle),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: certificates
                    .map(
                      (cert) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _primaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      cert,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Legal & Global Compliance',
      icon: Icons.gavel,
      children: children,
    );
  }

  Widget _buildBankDetails() {
    final List<Widget> children = [];

    if (_get('accountHolderName') != null &&
        _get('accountHolderName').toString().isNotEmpty) {
      children.add(_infoRow('Account Holder', _get('accountHolderName')));
    }

    if (_get('bankName') != null && _get('bankName').toString().isNotEmpty) {
      children.add(_infoRow('Bank Name', _get('bankName')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('ifscCode') != null && _get('ifscCode').toString().isNotEmpty) {
      children.add(_infoRow('IFSC / SWIFT Code', _get('ifscCode')));
    }

    if (_get('branch') != null && _get('branch').toString().isNotEmpty) {
      children.add(_infoRow('Branch / Country', _get('branch')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Bank & Financial Details',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildDocumentsSection() {
    final uploadedFiles = _get('uploadedFiles', {});

    if (uploadedFiles is! Map || uploadedFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = uploadedFiles.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    // Digital Signature
    final hasDigitalSignature = _get('hasDigitalSignature') == true ||
        (_get('digitalSignature') != null &&
            _get('digitalSignature') > 0);

    if (hasDigitalSignature) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _royalPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _royalPurple.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _royalPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.draw, size: 20, color: Color(0xFF7851A9)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    return _buildSectionCard(
      title: 'Uploaded Documents',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Digital')) return Icons.draw;
      if (docName.contains('GST')) return Icons.receipt;
      if (docName.contains('PAN')) return Icons.credit_card;
      if (docName.contains('License')) return Icons.badge;
      if (docName.contains('FSSAI')) return Icons.restaurant;
      if (docName.contains('Fire')) return Icons.fire_extinguisher;
      if (docName.contains('Environmental')) return Icons.eco;
      if (docName.contains('International')) return Icons.star;
      if (docName.contains('Luxury')) return Icons.workspace_premium;
      if (docName.contains('Cheque')) return Icons.account_balance;
      if (docName.contains('Images')) return Icons.photo_library;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Digital')) return _royalPurple;
      if (docName.contains('FSSAI')) return Colors.green;
      if (docName.contains('Fire')) return Colors.orange;
      if (docName.contains('Environmental')) return Colors.teal;
      if (docName.contains('International')) return Colors.blue;
      if (docName.contains('Luxury')) return _primaryColor;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    if (_get('signatoryName') != null &&
        _get('signatoryName').toString().isNotEmpty) {
      children.add(_infoRow('Signatory Name', _get('signatoryName')));
    }

    if (_get('signatoryDesignation') != null &&
        _get('signatoryDesignation').toString().isNotEmpty) {
      children.add(_infoRow('Signatory Designation', _get('signatoryDesignation')));
    }

    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _get('declarationAccepted', false) == true
                  ? _successColor.withOpacity(0.1)
                  : _dangerColor.withOpacity(0.1),
              _primaryLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'We agree to maintain the highest global standards of luxury, safety, and service excellence.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish & Proceed to Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your 6-Star ultra-luxury hotel has been registered successfully!',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: _primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _get('hotelName', 'Hotel'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    // Save to SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['email']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['ownerName']?.toString() ?? '',
                        'phone': registrationData['mobileNumber']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    // Navigate to dashboard
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _subSectionStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedAmenities
              .map(
                (amenity) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 14, color: _primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class SevenStarHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

   SevenStarHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for 7-Star Sovereign hotels
  final Color _primaryColor = const Color(0xFF1A94F6); // Royal Blue
  final Color _primaryLight =  Color(0xFF1A94F6).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);
  final Color _royalGold = const Color(0xFFD4AF37);
  final Color _sovereignPurple = const Color(0xFF7851A9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '7-Star Sovereign Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _sovereignPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(7, (index) =>
                    Icon(Icons.star, size: 10, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
                  '7-Star',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildSovereignIdentity(),
            _buildSupremeAuthority(),
            _buildGlobalAccess(),
            _buildRoyalAccommodations(),
            _buildSupremeExperience(),
            _buildGastronomicWellness(),
            _buildSecurityCompliance(),
            _buildTreasuryFinancial(),
            _buildHyperDigitalIntegration(),
            _buildCredentialsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _sovereignPurple],
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sovereign Registration Submitted!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('estateName', 'Estate Name') ?? 'Estate',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: 7S-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(7, (index) =>
                Icon(Icons.star, size: 14, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSovereignIdentity() {
    final List<Widget> children = [
      _infoRow('Estate Name', _get('estateName', 'Not Provided')),
      _infoRow('Hotel Category', '7-Star Sovereign'),
    ];

    if (_get('sovereignClassification') != null) {
      children.add(_infoRow('Sovereign Classification', _get('sovereignClassification')));
    }

    if (_get('heritageStatus') != null) {
      children.add(_infoRow('Heritage Status', _get('heritageStatus')));
    }

    if (_get('ownershipCategory') != null) {
      children.add(_infoRow('Ownership Category', _get('ownershipCategory')));
    }

    // Year of Origin as integer
    if (_get('yearOfOrigin') != null &&
        _get('yearOfOrigin').toString().isNotEmpty &&
        _get('yearOfOrigin') != 0) {
      children.add(_infoRow('Year of Origin', _formatInteger(_get('yearOfOrigin'))));
    }

    // Total Guest Capacity as integer
    if (_get('totalGuestCapacity') != null &&
        _get('totalGuestCapacity').toString().isNotEmpty &&
        _get('totalGuestCapacity') != 0) {
      children.add(_infoRow('Total Guest Capacity', _formatInteger(_get('totalGuestCapacity'))));
    }

    if (_get('historicSignificance') != null &&
        _get('historicSignificance').toString().isNotEmpty) {
      children.add(_buildHistoricSignificance());
    }

    if (_get('globalPrestigeRank') != null &&
        _get('globalPrestigeRank').toString().isNotEmpty) {
      children.add(_infoRow('Global Prestige Rank', _get('globalPrestigeRank')));
    }

    if (_get('estateSize') != null &&
        _get('estateSize').toString().isNotEmpty) {
      children.add(_infoRow('Estate Size', _get('estateSize')));
    }

    if (_get('staffToGuestRatio') != null &&
        _get('staffToGuestRatio').toString().isNotEmpty) {
      children.add(_infoRow('Staff-to-Guest Ratio', _get('staffToGuestRatio')));
    }

    return _buildSectionCard(
      title: 'Sovereign Identity',
      icon: Icons.workspace_premium,
      children: children,
    );
  }

  Widget _buildHistoricSignificance() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Historic Significance', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: _primaryColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _get('historicSignificance'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textDark,
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

  Widget _buildSupremeAuthority() {
    final List<Widget> children = [];

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    if (_get('legalHoldingEntity') != null &&
        _get('legalHoldingEntity').toString().isNotEmpty) {
      children.add(_infoRow('Legal Holding Entity', _get('legalHoldingEntity')));
    }

    if (_get('sovereignOwner') != null &&
        _get('sovereignOwner').toString().isNotEmpty) {
      children.add(_infoRow('Sovereign Owner / Royal Patron', _get('sovereignOwner')));
    }

    if (_get('chiefExecutiveCustodian') != null &&
        _get('chiefExecutiveCustodian').toString().isNotEmpty) {
      children.add(_infoRow('Chief Executive Custodian', _get('chiefExecutiveCustodian')));
    }

    if (_get('protocolAffairsDirector') != null &&
        _get('protocolAffairsDirector').toString().isNotEmpty) {
      children.add(_infoRow('Protocol Affairs Director', _get('protocolAffairsDirector')));
    }

    if (_get('headOfGuestExperience') != null &&
        _get('headOfGuestExperience').toString().isNotEmpty) {
      children.add(_infoRow('Head of Guest Experience', _get('headOfGuestExperience')));
    }

    if (_get('eliteGuestLiaison') != null &&
        _get('eliteGuestLiaison').toString().isNotEmpty) {
      children.add(_infoRow('Elite Guest Liaison', _get('eliteGuestLiaison')));
    }

    if (_get('directCommandContact') != null &&
        _get('directCommandContact').toString().isNotEmpty) {
      children.add(_infoRow('Direct Command Contact', _get('directCommandContact')));
    }

    if (_get('encryptedCommunication') != null &&
        _get('encryptedCommunication').toString().isNotEmpty) {
      children.add(_infoRow('Encrypted Communication', _get('encryptedCommunication')));
    }

    if (_get('executiveEmail') != null &&
        _get('executiveEmail').toString().isNotEmpty) {
      children.add(_infoRow('Executive Email', _get('executiveEmail')));
    }

    if (_get('officialPortfolio') != null &&
        _get('officialPortfolio').toString().isNotEmpty) {
      children.add(_infoRow('Official Portfolio', _get('officialPortfolio')));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Supreme Authority & Governance',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildGlobalAccess() {
    final List<Widget> children = [];

    if (_get('estateAddress') != null &&
        _get('estateAddress').toString().isNotEmpty) {
      children.add(_infoRow('Estate Address', _get('estateAddress')));
    }

    if (_get('city') != null && _get('city').toString().isNotEmpty) {
      children.add(_infoRow('City', _get('city')));
    }

    if (_get('state') != null && _get('state').toString().isNotEmpty) {
      children.add(_infoRow('State', _get('state')));
    }

    // Country field
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    if (_get('postalCode') != null &&
        _get('postalCode').toString().isNotEmpty) {
      children.add(_infoRow('Postal Code', _get('postalCode')));
    }

    if (_get('distanceFromHub') != null &&
        _get('distanceFromHub').toString().isNotEmpty) {
      children.add(_infoRow('Distance from Hub', '${_get('distanceFromHub')} km'));
    }

    // Arrival Infrastructure
    final arrivalInfrastructure = _getAmenities('arrivalInfrastructure');
    if (arrivalInfrastructure != null &&
        arrivalInfrastructure.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Exclusive Arrival Infrastructure', arrivalInfrastructure));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Global Access & Entry Privileges',
      icon: Icons.public,
      children: children,
    );
  }

  Widget _buildRoyalAccommodations() {
    final royalAccommodations = _get('royalAccommodations', {});
    final selectedRoyalAccommodations = _get('selectedRoyalAccommodations', {});

    if (royalAccommodations is! Map || royalAccommodations.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get selected room types
    final selectedTypes = (selectedRoyalAccommodations as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    if (selectedTypes.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    // Room Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Royal Residence Types', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Room Details for each type
    for (var residenceType in selectedTypes) {
      final details = royalAccommodations[residenceType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
            gradient: LinearGradient(
              colors: [Colors.white, _primaryLight.withOpacity(0.3)],
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
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.account_balance, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      residenceType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Units (integer)
              if (details['units'] != null && details['units'].toString().isNotEmpty && details['units'] != 0)
                _detailRow('Number of Units', _formatInteger(details['units'])),

              // Area
              if (details['area'] != null && details['area'].toString().isNotEmpty)
                _detailRow('Area', '${details['area']} sq m'),

              // Max Guests (integer)
              if (details['maxGuests'] != null && details['maxGuests'].toString().isNotEmpty && details['maxGuests'] != 0)
                _detailRow('Max Guests', _formatInteger(details['maxGuests'])),

              // Signature Features
              if (details['signatureFeatures'] != null && details['signatureFeatures'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Signature Features', style: TextStyle(fontSize: 13, color: _textLight)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _primaryLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          details['signatureFeatures'].toString(),
                          style: TextStyle(fontSize: 13, color: _textDark),
                        ),
                      ),
                    ],
                  ),
                ),

              // Avg Nightly Rate (double)
              if (details['avgNightlyRate'] != null && details['avgNightlyRate'].toString().isNotEmpty && details['avgNightlyRate'] != 0)
                _detailRow('Avg Nightly Rate', '\$${_formatPrice(details['avgNightlyRate'])}'),

              // Peak Rate (double)
              if (details['peakRate'] != null && details['peakRate'].toString().isNotEmpty && details['peakRate'] != 0)
                _detailRow('Peak Rate', '\$${_formatPrice(details['peakRate'])}'),
            ],
          ),
        ),
      );
    }

    // Pricing Engine
    if (_get('pricingEngine') != null) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: _successColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pricing Intelligence Engine',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _textLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _get('pricingEngine'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _successColor,
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Royal Accommodation Intelligence Matrix',
      icon: Icons.meeting_room,
      children: children,
    );
  }

  Widget _buildSupremeExperience() {
    final List<Widget> amenitySections = [];

    // In-Residence Systems
    final inResidenceSystems = _getAmenities('inResidenceSystems');
    if (inResidenceSystems != null && inResidenceSystems.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('In-Residence Intelligence Systems', inResidenceSystems),
      );
    }

    // Signature Royal Amenities
    final signatureRoyalAmenities = _getAmenities('signatureRoyalAmenities');
    if (signatureRoyalAmenities != null && signatureRoyalAmenities.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Signature Royal Amenities', signatureRoyalAmenities),
      );
    }

    // Arrival Ceremonial Protocols
    final arrivalCeremonialProtocols = _getAmenities('arrivalCeremonialProtocols');
    if (arrivalCeremonialProtocols != null && arrivalCeremonialProtocols.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Arrival Ceremonial Protocols', arrivalCeremonialProtocols),
      );
    }

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      amenitySections.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arrival (Check-In) Time', style: _labelStyle),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: _primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(checkIn.toString()),
                            style: _valueStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Departure (Check-Out) Time', style: _labelStyle),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: _primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(checkOut.toString()),
                            style: _valueStyle,
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
      );
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Supreme Experience Architecture',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildGastronomicWellness() {
    final List<Widget> children = [];

    // Gastronomic Supremacy
    final gastronomicSupremacy = _getAmenities('gastronomicSupremacy');
    if (gastronomicSupremacy != null && gastronomicSupremacy.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Gastronomic Supremacy', gastronomicSupremacy),
      );
    }

    // Wellness Dominion
    final wellnessDominion = _getAmenities('wellnessDominion');
    if (wellnessDominion != null && wellnessDominion.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Holistic Wellness Dominion', wellnessDominion),
      );
    }

    // Ultra-Elite Privileges
    final ultraElitePrivileges = _getAmenities('ultraElitePrivileges');
    if (ultraElitePrivileges != null && ultraElitePrivileges.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Ultra-Elite Guest Privileges', ultraElitePrivileges),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Gastronomic & Wellness Dominion',
      icon: Icons.restaurant,
      children: children,
    );
  }

  Widget _buildSecurityCompliance() {
    final List<Widget> children = [];

    if (_get('internationalTaxId') != null &&
        _get('internationalTaxId').toString().isNotEmpty) {
      children.add(_infoRow('International Tax / Registry ID', _get('internationalTaxId')));
    }

    if (_get('securityCertificationLevel') != null &&
        _get('securityCertificationLevel').toString().isNotEmpty) {
      children.add(_infoRow('Security Certification Level', _get('securityCertificationLevel')));
    }

    // Fire & Disaster Clearance
    if (_get('fireDisasterClearance') != null) {
      children.add(
        _infoRow(
          'Fire & Disaster Clearance',
          _get('fireDisasterClearance') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Environmental Sovereign Certification
    if (_get('environmentalSovereignCertification') != null) {
      children.add(
        _infoRow(
          'Environmental Sovereign Certification',
          _get('environmentalSovereignCertification') == true ? 'Yes' : 'No',
        ),
      );
    }

    if (_get('cyberIntelligenceProtection') != null &&
        _get('cyberIntelligenceProtection').toString().isNotEmpty) {
      children.add(_infoRow('Cyber Intelligence Protection', _get('cyberIntelligenceProtection')));
    }

    // Crisis Command System
    if (_get('crisisCommandSystem') != null) {
      children.add(
        _infoRow(
          'Crisis Command System',
          _get('crisisCommandSystem') == true ? 'Active' : 'In Development',
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Sovereign Security & Compliance',
      icon: Icons.security,
      children: children,
    );
  }

  Widget _buildTreasuryFinancial() {
    final List<Widget> children = [];

    if (_get('treasuryAccountName') != null &&
        _get('treasuryAccountName').toString().isNotEmpty) {
      children.add(_infoRow('Treasury Account Name', _get('treasuryAccountName')));
    }

    if (_get('globalBankInstitution') != null &&
        _get('globalBankInstitution').toString().isNotEmpty) {
      children.add(_infoRow('Global Bank Institution', _get('globalBankInstitution')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('swiftIban') != null &&
        _get('swiftIban').toString().isNotEmpty) {
      children.add(_infoRow('SWIFT / IBAN', _get('swiftIban')));
    }

    if (_get('settlementCurrency') != null &&
        _get('settlementCurrency').toString().isNotEmpty) {
      children.add(_infoRow('Settlement Currency', _get('settlementCurrency')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    // Alternative Settlement Options
    final alternativeSettlementOptions = _getAmenities('alternativeSettlementOptions');
    if (alternativeSettlementOptions != null &&
        alternativeSettlementOptions.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Alternative Settlement Options', alternativeSettlementOptions));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Treasury & Financial Protocol',
      icon: Icons.account_balance_wallet,
      children: children,
    );
  }

  Widget _buildHyperDigitalIntegration() {
    final hyperDigitalIntegration = _getAmenities('hyperDigitalIntegration');

    if (hyperDigitalIntegration == null ||
        !hyperDigitalIntegration.entries.any((e) => e.value)) {
      return const SizedBox.shrink();
    }

    return _buildSectionCard(
      title: 'Hyper-Digital Integration',
      icon: Icons.dashboard,
      children: [
        _buildAmenityCategory('Integration Capabilities', hyperDigitalIntegration),
      ],
    );
  }

  Widget _buildCredentialsSection() {
    final sovereignCredentials = _get('sovereignCredentials', {});

    if (sovereignCredentials is! Map || sovereignCredentials.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = sovereignCredentials.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    return _buildSectionCard(
      title: 'Mandatory Credentials',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Royal Authorization')) return Icons.verified_user;
      if (docName.contains('Estate Ownership')) return Icons.home_work;
      if (docName.contains('Security Clearance')) return Icons.security;
      if (docName.contains('Insurance')) return Icons.account_balance;
      if (docName.contains('Accreditation')) return Icons.star;
      if (docName.contains('Financial Verification')) return Icons.account_balance_wallet;
      if (docName.contains('Estate Portfolio')) return Icons.photo_library;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Royal Authorization')) return _sovereignPurple;
      if (docName.contains('Security Clearance')) return Colors.orange;
      if (docName.contains('Insurance')) return Colors.green;
      if (docName.contains('Financial Verification')) return Colors.blue;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    if (_get('authorizedAuthority') != null &&
        _get('authorizedAuthority').toString().isNotEmpty) {
      children.add(_infoRow('Authorized Authority', _get('authorizedAuthority')));
    }

    if (_get('titleRank') != null &&
        _get('titleRank').toString().isNotEmpty) {
      children.add(_infoRow('Title / Rank', _get('titleRank')));
    }

    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    // Digital Signature
    final hasDigitalSignature = _get('hasDigitalSignature') == true ||
        (_get('digitalSignatureImage') != null);

    if (hasDigitalSignature) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _sovereignPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _sovereignPurple.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _sovereignPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.draw, size: 20, color: Color(0xFF7851A9)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature & Royal Seal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _get('declarationAccepted', false) == true
                  ? _successColor.withOpacity(0.1)
                  : _dangerColor.withOpacity(0.1),
              _primaryLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Sovereign Prestige Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'We affirm that our estate maintains the highest level of global luxury, discretion, security, and guest excellence.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return _buildSectionCard(
      title: 'Sovereign Prestige Declaration',
      icon: Icons.verified_user,
      children: children,
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish & Proceed to Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your 7-Star Sovereign Estate has been registered successfully!',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: _primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _get('estateName', 'Estate'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    // Save to SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['executiveEmail']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['sovereignOwner']?.toString() ?? '',
                        'phone': registrationData['directCommandContact']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    // Navigate to dashboard
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _subSectionStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedAmenities
                .map(
                  (amenity) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      amenity,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryColor,
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

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty || displayValue == '0' || displayValue == '0.0') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty || displayValue == '0' || displayValue == '0.0') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}

class GlobalEliteLuxuryHotelSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> registrationData;
  final bool declarationAccepted;

   GlobalEliteLuxuryHotelSummaryScreen({
    super.key,
    required this.registrationData,
    this.declarationAccepted = false,
  });

  // Helper method to safely get values
  dynamic _get(String key, [dynamic defaultValue]) {
    return registrationData[key] ?? defaultValue;
  }

  // Color scheme for Global Elite Luxury hotels
  final Color _primaryColor = const Color(0xFF10B981); // Emerald Green
  final Color _primaryLight =  Color(0xFF10B981).withOpacity(0.1);
  final Color _bgColor = const Color(0xFFFAFAFA);
  final Color _cardColor = Colors.white;
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _successColor = const Color(0xFF10B981);
  final Color _dangerColor = const Color(0xFFEF4444);
  final Color _starColor = const Color(0xFFFFD700);
  final Color _accentColor = const Color(0xFF10B981);
  final Color _eliteGold = const Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Global Elite Luxury Registration Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_primaryColor, _eliteGold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ...List.generate(6, (index) =>
                    Icon(Icons.star, size: 10, color: Colors.white)
                ),
                const SizedBox(width: 4),
                const Text(
                  'Global Elite',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSuccessHeader(),
            _buildPrestigeIdentity(),
            _buildExecutiveCommand(),
            _buildLocationAccess(),
            _buildAccommodationMatrix(),
            _buildUltraEliteFacilities(),
            _buildGastronomyWellness(),
            _buildSecurityCompliance(),
            _buildFinancialDetails(),
            _buildDigitalIntegration(),
            _buildDocumentsSection(),
            _buildDeclarationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildFinishButton(context),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _eliteGold],
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Global Elite Registration Submitted!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _get('propertyName', 'Property Name') ?? 'Property',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'Reference ID: GE-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: List.generate(6, (index) =>
                Icon(Icons.star, size: 14, color: _starColor)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrestigeIdentity() {
    final List<Widget> children = [
      _infoRow('Property Name', _get('propertyName', 'Not Provided')),
      _infoRow('Hotel Category', 'Global Elite Luxury'),
    ];

    if (_get('brandAffiliation') != null &&
        _get('brandAffiliation').toString().isNotEmpty) {
      children.add(_infoRow('Brand Affiliation', _get('brandAffiliation')));
    }

    if (_get('luxuryClassification') != null) {
      children.add(_infoRow('Luxury Classification', _get('luxuryClassification')));
    }

    if (_get('propertyPositioning') != null) {
      children.add(_infoRow('Property Positioning', _get('propertyPositioning')));
    }

    // Year Established as integer
    if (_get('yearEstablished') != null &&
        _get('yearEstablished').toString().isNotEmpty &&
        _get('yearEstablished') != 0) {
      children.add(_infoRow('Year Established', _formatInteger(_get('yearEstablished'))));
    }

    // Year Renovated as integer
    if (_get('yearRenovated') != null &&
        _get('yearRenovated').toString().isNotEmpty &&
        _get('yearRenovated') != 0) {
      children.add(_infoRow('Year Last Renovated', _formatInteger(_get('yearRenovated'))));
    }

    if (_get('awardsRankings') != null &&
        _get('awardsRankings').toString().isNotEmpty) {
      children.add(_buildAwardsRankings());
    }

    if (_get('recognitionLevel') != null) {
      children.add(_infoRow('Recognition Level', _get('recognitionLevel')));
    }

    // Total Inventory as integer
    if (_get('totalInventory') != null &&
        _get('totalInventory').toString().isNotEmpty &&
        _get('totalInventory') != 0) {
      children.add(_infoRow('Total Inventory', _formatInteger(_get('totalInventory'))));
    }

    if (_get('staffToGuestRatio') != null &&
        _get('staffToGuestRatio').toString().isNotEmpty) {
      children.add(_infoRow('Staff-to-Guest Ratio', _get('staffToGuestRatio')));
    }

    return _buildSectionCard(
      title: 'Prestige Identity',
      icon: Icons.workspace_premium,
      children: children,
    );
  }

  Widget _buildAwardsRankings() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Global Awards & Rankings', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.emoji_events, color: _primaryColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _get('awardsRankings'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _textDark,
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

  Widget _buildExecutiveCommand() {
    final List<Widget> children = [];

    // Profile Photo
    final profilePhoto = _get('profilePhoto');
    if (profilePhoto != null && profilePhoto['uploaded'] == true) {
      children.add(_buildProfilePhotoInfo(profilePhoto));
    }

    if (_get('legalEntity') != null &&
        _get('legalEntity').toString().isNotEmpty) {
      children.add(_infoRow('Legal Entity Name', _get('legalEntity')));
    }

    if (_get('ubo') != null &&
        _get('ubo').toString().isNotEmpty) {
      children.add(_infoRow('Ultimate Beneficial Owner (UBO)', _get('ubo')));
    }

    if (_get('authorizedSignatory') != null &&
        _get('authorizedSignatory').toString().isNotEmpty) {
      children.add(_infoRow('Authorized Signatory', _get('authorizedSignatory')));
    }

    if (_get('designation') != null &&
        _get('designation').toString().isNotEmpty) {
      children.add(_infoRow('Designation', _get('designation')));
    }

    if (_get('generalManager') != null &&
        _get('generalManager').toString().isNotEmpty) {
      children.add(_infoRow('General Manager', _get('generalManager')));
    }

    if (_get('vipRelationsDirector') != null &&
        _get('vipRelationsDirector').toString().isNotEmpty) {
      children.add(_infoRow('VIP Relations Director', _get('vipRelationsDirector')));
    }

    if (_get('primaryContact') != null &&
        _get('primaryContact').toString().isNotEmpty) {
      children.add(_infoRow('Primary Contact', _get('primaryContact')));
    }

    if (_get('secondaryContact') != null &&
        _get('secondaryContact').toString().isNotEmpty) {
      children.add(_infoRow('Secondary Contact', _get('secondaryContact')));
    }

    if (_get('executiveEmail') != null &&
        _get('executiveEmail').toString().isNotEmpty) {
      children.add(_infoRow('Executive Email', _get('executiveEmail')));
    }

    if (_get('websitePortfolio') != null &&
        _get('websitePortfolio').toString().isNotEmpty) {
      children.add(_infoRow('Website / Portfolio', _get('websitePortfolio')));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Executive Command',
      icon: Icons.account_balance,
      children: children,
    );
  }

  Widget _buildLocationAccess() {
    final List<Widget> children = [];

    if (_get('addressLine1') != null &&
        _get('addressLine1').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 1', _get('addressLine1')));
    }

    if (_get('addressLine2') != null &&
        _get('addressLine2').toString().isNotEmpty) {
      children.add(_infoRow('Address Line 2', _get('addressLine2')));
    }

    if (_get('city') != null && _get('city').toString().isNotEmpty) {
      children.add(_infoRow('City', _get('city')));
    }

    if (_get('state') != null && _get('state').toString().isNotEmpty) {
      children.add(_infoRow('State / Province', _get('state')));
    }

    // Country field
    if (_get('country') != null && _get('country').toString().isNotEmpty) {
      children.add(_infoRow('Country', _get('country')));
    }

    if (_get('postalCode') != null &&
        _get('postalCode').toString().isNotEmpty) {
      children.add(_infoRow('Postal Code', _get('postalCode')));
    }

    if (_get('nearestAirport') != null &&
        _get('nearestAirport').toString().isNotEmpty) {
      children.add(_infoRow('Nearest Airport', _get('nearestAirport')));
    }

    if (_get('distanceFromAirport') != null &&
        _get('distanceFromAirport').toString().isNotEmpty) {
      children.add(_infoRow('Distance from Airport', '${_get('distanceFromAirport')} km'));
    }

    // Private Access Options
    final privateAccessOptions = _getAmenities('privateAccessOptions');
    if (privateAccessOptions != null &&
        privateAccessOptions.entries.any((e) => e.value)) {
      children.add(_buildAmenityCategory('Private Access Options', privateAccessOptions));
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Location & Access Matrix',
      icon: Icons.location_on,
      children: children,
    );
  }

  Widget _buildAccommodationMatrix() {
    final accommodationMatrix = _get('accommodationMatrix', {});
    final selectedAccommodationTypes = _get('selectedAccommodationTypes', {});

    if (accommodationMatrix is! Map || accommodationMatrix.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get selected accommodation types
    final selectedTypes = (selectedAccommodationTypes as Map).entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();

    if (selectedTypes.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    // Accommodation Type Chips
    children.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Accommodation Categories', style: _labelStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedTypes
                .map(
                  (type) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );

    children.add(const SizedBox(height: 16));

    // Accommodation Details for each type
    for (var accommodationType in selectedTypes) {
      final details = accommodationMatrix[accommodationType] ?? {};

      children.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
            gradient: LinearGradient(
              colors: [Colors.white, _primaryLight.withOpacity(0.3)],
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
                      color: _primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.hotel, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      accommodationType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Units (integer)
              if (details['units'] != null && details['units'].toString().isNotEmpty && details['units'] != 0)
                _detailRow('Number of Units', _formatInteger(details['units'])),

              // Size
              if (details['size'] != null && details['size'].toString().isNotEmpty)
                _detailRow('Size', '${details['size']} sq ft'),

              // Max Occupancy (integer)
              if (details['occupancy'] != null && details['occupancy'].toString().isNotEmpty && details['occupancy'] != 0)
                _detailRow('Max Occupancy', _formatInteger(details['occupancy'])),

              // Bed Type
              if (details['bedType'] != null && details['bedType'].toString().isNotEmpty)
                _detailRow('Bed Type', details['bedType'].toString()),

              // Avg Nightly Rate (double)
              if (details['avgNightlyRate'] != null && details['avgNightlyRate'].toString().isNotEmpty && details['avgNightlyRate'] != 0)
                _detailRow('Avg Nightly Rate', '\$${_formatPrice(details['avgNightlyRate'])}'),

              // Peak Rate (double)
              if (details['peakRate'] != null && details['peakRate'].toString().isNotEmpty && details['peakRate'] != 0)
                _detailRow('Peak Rate', '\$${_formatPrice(details['peakRate'])}'),
            ],
          ),
        ),
      );
    }

    // Rate Engine Type
    if (_get('rateEngineType') != null) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _successColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: _successColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rate Engine Type',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _textLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _get('rateEngineType'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _successColor,
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

    // Check-in/Check-out times
    final checkIn = _get('checkInTime', '');
    final checkOut = _get('checkOutTime', '');

    if (checkIn.toString().isNotEmpty || checkOut.toString().isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check-In Time', style: _labelStyle),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: _primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(checkIn.toString()),
                            style: _valueStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check-Out Time', style: _labelStyle),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: _primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(checkOut.toString()),
                            style: _valueStyle,
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
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Accommodation Matrix & Rate Intelligence',
      icon: Icons.meeting_room,
      children: children,
    );
  }

  Widget _buildUltraEliteFacilities() {
    final List<Widget> amenitySections = [];

    // In-Suite Technology
    final inSuiteTechnology = _getAmenities('inSuiteTechnology');
    if (inSuiteTechnology != null && inSuiteTechnology.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('In-Suite Technology', inSuiteTechnology),
      );
    }

    // Signature Luxury Features
    final signatureLuxuryFeatures = _getAmenities('signatureLuxuryFeatures');
    if (signatureLuxuryFeatures != null && signatureLuxuryFeatures.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Signature Luxury Features', signatureLuxuryFeatures),
      );
    }

    // Luxury Linen Brand (if specified)
    if (_get('luxuryLinenBrand') != null &&
        _get('luxuryLinenBrand').toString().isNotEmpty) {
      amenitySections.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _infoRow('Luxury Linen Brand', _get('luxuryLinenBrand')),
        ),
      );
    }

    // Arrival Experience
    final arrivalExperience = _getAmenities('arrivalExperience');
    if (arrivalExperience != null && arrivalExperience.entries.any((e) => e.value)) {
      amenitySections.add(
        _buildAmenityCategory('Arrival Experience', arrivalExperience),
      );
    }

    if (amenitySections.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Ultra-Elite Facilities Index',
      icon: Icons.workspaces_filled,
      children: amenitySections,
    );
  }

  Widget _buildGastronomyWellness() {
    final List<Widget> children = [];

    // Gastronomy Features
    final gastronomyFeatures = _getAmenities('gastronomyFeatures');
    if (gastronomyFeatures != null && gastronomyFeatures.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Gastronomy Features', gastronomyFeatures),
      );
    }

    // Michelin Count (integer)
    if (_get('michelinCount') != null &&
        _get('michelinCount').toString().isNotEmpty &&
        _get('michelinCount') != 0) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24),
          child: _infoRow('Michelin-Star Restaurants', _formatInteger(_get('michelinCount'))),
        ),
      );
    }

    // Banquet Hall Capacity (integer)
    if (_get('banquetHallCapacity') != null &&
        _get('banquetHallCapacity').toString().isNotEmpty &&
        _get('banquetHallCapacity') != 0) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24),
          child: _infoRow('Banquet Hall Capacity', '${_formatInteger(_get('banquetHallCapacity'))} seats'),
        ),
      );
    }

    // Global Event Hosting
    if (_get('globalEventHosting') != null) {
      children.add(
        _infoRow(
          'Global Event Hosting',
          _get('globalEventHosting') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Wellness Features
    final wellnessFeatures = _getAmenities('wellnessFeatures');
    if (wellnessFeatures != null && wellnessFeatures.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Wellness Features', wellnessFeatures),
      );
    }

    // Guest Privileges
    final guestPrivileges = _getAmenities('guestPrivileges');
    if (guestPrivileges != null && guestPrivileges.entries.any((e) => e.value)) {
      children.add(
        _buildAmenityCategory('Guest Privileges', guestPrivileges),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Gastronomy, Wellness & Privileges',
      icon: Icons.restaurant,
      children: children,
    );
  }

  Widget _buildSecurityCompliance() {
    final List<Widget> children = [];

    if (_get('taxId') != null &&
        _get('taxId').toString().isNotEmpty) {
      children.add(_infoRow('GST / Tax ID', _get('taxId')));
    }

    if (_get('complianceStandard') != null &&
        _get('complianceStandard').toString().isNotEmpty) {
      children.add(_infoRow('Compliance Standard', _get('complianceStandard')));
    }

    // Fire & Safety Certification
    if (_get('fireSafetyCertification') != null) {
      children.add(
        _infoRow(
          'Fire & Safety Certification',
          _get('fireSafetyCertification') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Environmental Certification
    if (_get('environmentalCertification') != null) {
      children.add(
        _infoRow(
          'Environmental Certification',
          _get('environmentalCertification') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Cybersecurity Certification
    if (_get('cybersecurityCertification') != null) {
      children.add(
        _infoRow(
          'Cybersecurity Certification',
          _get('cybersecurityCertification') == true ? 'Yes' : 'No',
        ),
      );
    }

    // Crisis Management Protocol
    if (_get('crisisManagementProtocol') != null) {
      children.add(
        _infoRow(
          'Crisis Management Protocol',
          _get('crisisManagementProtocol') == true ? 'Active' : 'Inactive',
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Security, Compliance & Certifications',
      icon: Icons.security,
      children: children,
    );
  }

  Widget _buildFinancialDetails() {
    final List<Widget> children = [];

    if (_get('accountName') != null &&
        _get('accountName').toString().isNotEmpty) {
      children.add(_infoRow('Account Name', _get('accountName')));
    }

    if (_get('bank') != null &&
        _get('bank').toString().isNotEmpty) {
      children.add(_infoRow('Bank', _get('bank')));
    }

    if (_get('accountNumber') != null &&
        _get('accountNumber').toString().isNotEmpty) {
      children.add(
        _infoRow(
          'Account Number',
          _maskAccountNumber(_get('accountNumber').toString()),
        ),
      );
    }

    if (_get('swiftIfsc') != null &&
        _get('swiftIfsc').toString().isNotEmpty) {
      children.add(_infoRow('SWIFT / IFSC', _get('swiftIfsc')));
    }

    if (_get('bankCountry') != null &&
        _get('bankCountry').toString().isNotEmpty) {
      children.add(_infoRow('Bank Country', _get('bankCountry')));
    }

    if (_get('settlementCurrency') != null &&
        _get('settlementCurrency').toString().isNotEmpty) {
      children.add(_infoRow('Settlement Currency', _get('settlementCurrency')));
    }

    // Account Type
    if (_get('accountType') != null &&
        _get('accountType').toString().isNotEmpty) {
      String accountType = _get('accountType').toString();
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: Text('Account Type', style: _labelStyle)),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accountType == 'Savings'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accountType == 'Savings'
                          ? Colors.green.withOpacity(0.3)
                          : Colors.blue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        accountType == 'Savings'
                            ? Icons.savings
                            : Icons.account_balance,
                        size: 14,
                        color: accountType == 'Savings'
                            ? Colors.green
                            : Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        accountType,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: accountType == 'Savings'
                              ? Colors.green[700]
                              : Colors.blue[700],
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

    if (children.isEmpty) return const SizedBox.shrink();

    return _buildSectionCard(
      title: 'Financial & Settlement Details',
      icon: Icons.account_balance_wallet,
      children: children,
    );
  }

  Widget _buildDigitalIntegration() {
    final digitalIntegration = _getAmenities('digitalIntegration');

    if (digitalIntegration == null ||
        !digitalIntegration.entries.any((e) => e.value)) {
      return const SizedBox.shrink();
    }

    return _buildSectionCard(
      title: 'Digital Integration Capabilities',
      icon: Icons.dashboard,
      children: [
        _buildAmenityCategory('Integration Capabilities', digitalIntegration),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    final requiredDocuments = _get('requiredDocuments', {});

    if (requiredDocuments is! Map || requiredDocuments.isEmpty) {
      return const SizedBox.shrink();
    }

    final uploadedDocs = requiredDocuments.entries
        .where((entry) => entry.value['uploaded'] == true)
        .toList();

    if (uploadedDocs.isEmpty) return const SizedBox.shrink();

    final List<Widget> children = [];

    for (var entry in uploadedDocs) {
      children.add(_buildDocumentItem(entry.key, entry.value));
    }

    return _buildSectionCard(
      title: 'Required Documentation',
      icon: Icons.folder,
      children: children,
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Business')) return Icons.business;
      if (docName.contains('Luxury')) return Icons.star;
      if (docName.contains('Insurance')) return Icons.security;
      if (docName.contains('Safety')) return Icons.health_and_safety;
      if (docName.contains('Bank')) return Icons.account_balance;
      if (docName.contains('Portfolio')) return Icons.folder;
      if (docName.contains('Visuals')) return Icons.image;
      return Icons.description;
    }

    Color getColor() {
      if (docName.contains('Business')) return _primaryColor;
      if (docName.contains('Luxury')) return _eliteGold;
      if (docName.contains('Insurance')) return Colors.green;
      if (docName.contains('Safety')) return Colors.orange;
      if (docName.contains('Bank')) return Colors.blue;
      return _primaryColor;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: getColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: getColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 12, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${(fileSize / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 11, color: _textLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 14, color: _successColor),
                const SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: _successColor,
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

  Widget _buildDeclarationSection() {
    final List<Widget> children = [];

    if (_get('authorizedSignatoryName') != null &&
        _get('authorizedSignatoryName').toString().isNotEmpty) {
      children.add(_infoRow('Authorized Signatory', _get('authorizedSignatoryName')));
    }

    if (_get('nameTitle') != null &&
        _get('nameTitle').toString().isNotEmpty) {
      children.add(_infoRow('Name & Title', _get('nameTitle')));
    }

    final declarationDate = _get('declarationDate');
    if (declarationDate != null) {
      String dateStr = '';
      if (declarationDate is DateTime) {
        dateStr = '${declarationDate.day}/${declarationDate.month}/${declarationDate.year}';
      } else if (declarationDate is String) {
        try {
          DateTime parsedDate = DateTime.parse(declarationDate);
          dateStr = '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
        } catch (e) {
          dateStr = declarationDate;
        }
      }
      if (dateStr.isNotEmpty) {
        children.add(_infoRow('Date', dateStr));
      }
    }

    // Digital Signature
    final hasDigitalSignature = _get('hasDigitalSignature') == true ||
        (_get('digitalSignatureImage') != null);

    if (hasDigitalSignature) {
      children.add(
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _primaryColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.draw, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Digital Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Saved successfully',
                      style: TextStyle(fontSize: 12, color: _textLight),
                    ),
                  ],
                ),
              ),
              Icon(Icons.check_circle, size: 20, color: _successColor),
            ],
          ),
        ),
      );
    }

    children.add(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _get('declarationAccepted', false) == true
                  ? _successColor.withOpacity(0.1)
                  : _dangerColor.withOpacity(0.1),
              _primaryLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _get('declarationAccepted', false) == true
                ? _successColor.withOpacity(0.3)
                : _dangerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _get('declarationAccepted', false) == true
                  ? Icons.check_circle
                  : Icons.error,
              color: _get('declarationAccepted', false) == true
                  ? _successColor
                  : _dangerColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _get('declarationAccepted', false) == true
                        ? 'Brand Alignment Declaration Accepted'
                        : 'Declaration Not Accepted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _get('declarationAccepted', false) == true
                          ? _successColor
                          : _dangerColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'We certify that our property operates at globally recognized ultra-luxury standards.',
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return _buildSectionCard(
      title: 'Brand Alignment Declaration',
      icon: Icons.verified_user,
      children: children,
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: _borderColor)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showSuccessDialogAndNavigate(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish & Proceed to Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
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

  void _showSuccessDialogAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Complete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Global Elite Luxury Hotel has been registered successfully!',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: _primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _get('propertyName', 'Property'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    // Save to SharedPreferences
                    final prefs = await SharedPreferences.getInstance();
                    final String usersJson = prefs.getString('registered_users') ?? '[]';
                    final List<dynamic> usersList = jsonDecode(usersJson);

                    List<Map<String, dynamic>> users = [];
                    for (var user in usersList) {
                      if (user is Map) {
                        Map<String, dynamic> safeUserMap = {};
                        user.forEach((key, value) {
                          safeUserMap[key.toString()] = _convertToJsonSafe(value);
                        });
                        users.add(safeUserMap);
                      }
                    }

                    String userEmail = registrationData['executiveEmail']?.toString() ?? '';

                    Map<String, dynamic> safeRegistrationData = _convertToJsonSafe(registrationData);

                    int userIndex = -1;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['email'] == userEmail) {
                        userIndex = i;
                        break;
                      }
                    }

                    Map<String, dynamic> userData;

                    if (userIndex >= 0) {
                      userData = Map<String, dynamic>.from(users[userIndex]);

                      if (!userData.containsKey('hotels')) {
                        userData['hotels'] = [];
                      }

                      List<dynamic> hotels = List.from(userData['hotels'] ?? []);
                      hotels.add(safeRegistrationData);
                      userData['hotels'] = hotels;
                      userData['propertyType'] = 'hotel';

                      users[userIndex] = userData;
                    } else {
                      userData = {
                        'email': userEmail,
                        'fullName': registrationData['ubo']?.toString() ?? '',
                        'phone': registrationData['primaryContact']?.toString() ?? '',
                        'propertyType': 'hotel',
                        'hotels': [safeRegistrationData],
                        'registeredAt': DateTime.now().toIso8601String(),
                      };

                      users.add(userData);
                    }

                    await prefs.setString('registered_users', jsonEncode(users));

                    // Navigate to dashboard
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboardScreen(
                          userData: userData,
                          userEmail: userEmail,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== HELPER METHODS ====================

  Map<String, bool>? _getAmenities(String key) {
    final value = _get(key);
    if (value is Map) {
      return Map<String, bool>.from(
        value.map((k, v) => MapEntry(k.toString(), v is bool ? v : false)),
      );
    }
    return null;
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    if (price is double) {
      return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    }
    if (price is int) {
      return price.toString();
    }
    if (price is String) {
      if (price.isEmpty) return '0';
      double? parsed = double.tryParse(price);
      if (parsed != null) {
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
    }
    return price.toString();
  }

  String _formatInteger(dynamic value) {
    if (value == null) return '0';
    if (value is int) {
      return value.toString();
    }
    if (value is double) {
      return value.toInt().toString();
    }
    if (value is String) {
      if (value.isEmpty) return '0';
      int? parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed.toString();
      }
      double? parsedDouble = double.tryParse(value);
      if (parsedDouble != null) {
        return parsedDouble.toInt().toString();
      }
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
    } catch (e) {
      // Return as is if parsing fails
    }
    return time;
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  dynamic _convertToJsonSafe(dynamic obj) {
    if (obj == null) return null;
    if (obj is DateTime) {
      return obj.toIso8601String();
    }
    if (obj is Uint8List) {
      return base64Encode(obj);
    }
    if (obj is Map) {
      Map<String, dynamic> result = {};
      obj.forEach((key, value) {
        result[key.toString()] = _convertToJsonSafe(value);
      });
      return result;
    }
    if (obj is List) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is Set) {
      return obj.map((item) => _convertToJsonSafe(item)).toList();
    }
    if (obj is String || obj is num || obj is Bool) {
      return obj;
    }
    try {
      return obj.toString();
    } catch (e) {
      return null;
    }
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: _borderColor),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAmenityCategory(String title, Map<String, bool> amenities) {
    final selectedAmenities = amenities.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedAmenities.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _subSectionStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedAmenities
                .map(
                  (amenity) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      amenity,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _primaryColor,
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

  Widget _infoRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty || displayValue == '0' || displayValue == '0.0') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: _labelStyle)),
          Expanded(
            flex: 6,
            child: Text(
              displayValue,
              style: _valueStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    if (value == null) return const SizedBox.shrink();

    String displayValue;

    if (value is int) {
      displayValue = value.toString();
    } else if (value is double) {
      displayValue = value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    } else {
      displayValue = value.toString();
    }

    if (displayValue.isEmpty || displayValue == '0' || displayValue == '0.0') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: _textLight)),
          Text(
            displayValue,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoInfo(Map<String, dynamic> photoInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo', style: _labelStyle),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.person, size: 24, color: _primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photoInfo['name'] ?? 'Profile Photo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${(photoInfo['size'] ?? 0 / 1024).toStringAsFixed(1)} KB',
                        style: TextStyle(fontSize: 12, color: _textLight),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check_circle, size: 20, color: _successColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle =>
      TextStyle(fontSize: 13, color: _textLight, fontWeight: FontWeight.w500);

  TextStyle get _valueStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);

  TextStyle get _subSectionStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark);
}