import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../onboarding_screen/choose_role_screen.dart';
import '../hotel_summary_screen/hotel_summary_screen.dart';

class VillaRegistrationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  final String? villaId;
  final int? villaIndex;

  const VillaRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
    this.villaId,
    this.villaIndex,
  }) : super(key: key);

  @override
  State<VillaRegistrationDetailsScreen> createState() => _VillaRegistrationDetailsScreenState();
}

class _VillaRegistrationDetailsScreenState extends State<VillaRegistrationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;



  late Map<String, bool> _villaAmenities;
  late List<String> _customAmenities;
  Map<String, bool> _editModes = {};


  bool _isEditingPhone = false;
  late TextEditingController _phoneController;
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;

  late Map<String, bool> _priceEditModes;
  late String _checkInTime;
  late String _checkOutTime;

  late Map<String, bool> _mediaEditModes;
  late Map<String, int> _mediaMaxLimits;

  late Map<String, bool> _documentEditModes;


  final Color primaryColor = const Color(0xFF00897B);
  final Color primaryLight = const Color(0xFF00897B).withOpacity(0.1);
  final Color primarySoft = const Color(0xFF00897B).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFF00897B).withOpacity(0.03);


  final Color darkText = const Color(0xFF1A1E2B);
  final Color mediumText = const Color(0xFF4A5568);
  final Color lightText = const Color(0xFF8E9AAB);
  final Color bgColor = const Color(0xFFF5F7FA);
  final Color cardColor = Colors.white;
  final Color borderColor = const Color(0xFFE9EDF2);
  final Color shadowColor = const Color(0xFF1A1E2B).withOpacity(0.03);




  String _getOfficeAddress() {
    // Check in location.officeAddress first
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
          print('Found office address in location.officeAddress: ${office['address']}');
          return office['address'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
        print('Found office address in direct officeAddress: ${office['address']}');
        return office['address'].toString();
      }
    }

    // Check in basicInfo.officeAddress
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('officeAddress') && basicInfo['officeAddress'] != null) {
        final office = basicInfo['officeAddress'] as Map;
        if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
          print('Found office address in basicInfo.officeAddress: ${office['address']}');
          return office['address'].toString();
        }
      }
    }

    print('No office address found anywhere');
    return 'Not provided';
  }

  String _getOfficeArea() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('area') && office['area'].toString().isNotEmpty) {
          return office['area'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('area') && office['area'].toString().isNotEmpty) {
        return office['area'].toString();
      }
    }

    return '';
  }

  String _getOfficeCity() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('city') && office['city'].toString().isNotEmpty) {
          return office['city'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('city') && office['city'].toString().isNotEmpty) {
        return office['city'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeState() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('state') && office['state'].toString().isNotEmpty) {
          return office['state'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('state') && office['state'].toString().isNotEmpty) {
        return office['state'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficePincode() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
          return office['pincode'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
        return office['pincode'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeGoogleMapLink() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
          return office['googleMapLink'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
        return office['googleMapLink'].toString();
      }
    }

    return '';
  }



  @override
  void initState() {
    super.initState();
    _data = widget.registrationData;
    _tabController = TabController(length:7, vsync: this);

    _phoneController = TextEditingController(text: _getUserPhone());
    _checkInController = TextEditingController(
        text: _data['checkInTime']?.toString() ?? ''
    );
    _checkOutController = TextEditingController(
        text: _data['checkOutTime']?.toString() ?? ''
    );


    print('=== DETAILS SCREEN INIT ===');
    print('widget.villaId: ${widget.villaId}');
    print('_data["id"]: ${_data['id']}');
    print('_data["basicInfo"] keys: ${_data.containsKey('basicInfo') ? (_data['basicInfo'] as Map).keys.toList() : 'No basicInfo'}');

    // If widget.villaId is null, try to extract from _data
    if (widget.villaId == null && _data.containsKey('id')) {
      print('Setting villaId from _data["id"]: ${_data['id']}');
    }



    print('=== DETAILS SCREEN RECEIVED DATA ===');
    print('virtualTourLink: ${_data['virtualTourLink']}');
    print('media: ${_data['media']}');
    print('basicInfo: ${_data['basicInfo']}');
    _initializeTimes();
    _priceEditModes = {};
    // _debugPrintData();
    _debugPrintMediaData();
    _initializeAmenities();
  }

  void _debugPrintMediaData() {
    print('=== DEBUG MEDIA DATA ===');
    print('Full data keys: ${_data.keys.toList()}');

    if (_data.containsKey('media')) {
      final media = _data['media'] as Map;
      print('Media keys: ${media.keys.toList()}');
      media.forEach((key, value) {
        print('Key: $key, Value: $value, Type: ${value.runtimeType}');
      });
    }

    if (_data.containsKey('virtualTourLink')) {
      print('virtualTourLink (direct): ${_data['virtualTourLink']}');
    }

    if (_data.containsKey('basicInfo')) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('virtualTourLink')) {
        print('virtualTourLink in basicInfo: ${basicInfo['virtualTourLink']}');
      }
    }

    final tourLink = _getVirtualTourLink();
    print('Final virtual tour link: $tourLink');
  }

  void _initializeTimes() {
    // Get pricing data from nested structure
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    // Initialize Check-in Time
    _checkInTime = _data['checkInTime']?.toString() ??
        pricingData['checkInTime']?.toString() ??
        '12:00';
    _checkInController = TextEditingController(text: _checkInTime);

    // Initialize Check-out Time
    _checkOutTime = _data['checkOutTime']?.toString() ??
        pricingData['checkOutTime']?.toString() ??
        '11:00';
    _checkOutController = TextEditingController(text: _checkOutTime);
  }

  void _autoSaveTimes() {
    _data['checkInTime'] = _checkInTime;
    _data['checkOutTime'] = _checkOutTime;

    // Also save in pricing nested structure if exists
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      final pricing = _data['pricing'] as Map;
      pricing['checkInTime'] = _checkInTime;
      pricing['checkOutTime'] = _checkOutTime;
      _data['pricing'] = pricing;
    }
  }


  Widget _buildEditableTimeField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: darkText,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectTime(context, controller, onChanged),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text.isNotEmpty
                      ? _formatTimeForDisplay(controller.text)
                      : 'Select time',
                  style: TextStyle(
                    fontSize: 14,
                    color: controller.text.isNotEmpty ? darkText : lightText,
                  ),
                ),
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(
      BuildContext context,
      TextEditingController controller,
      ValueChanged<String> onChanged,
      ) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (controller.text.isNotEmpty) {
      try {
        List<String> parts = controller.text.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          initialTime = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e) {
        initialTime = TimeOfDay.now();
      }
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      controller.text = formattedTime;
      onChanged(formattedTime);
    }
  }

  String _formatTimeForDisplay(String time24) {
    if (time24.isEmpty) return '';
    try {
      List<String> parts = time24.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1].substring(0, 2));
        String period = hour >= 12 ? 'PM' : 'AM';
        int hour12 = hour % 12;
        if (hour12 == 0) hour12 = 12;
        return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
    } catch (e) {
      return time24;
    }
    return time24;
  }

  Future<void> _uploadMediaFile(String mediaKey, String mediaName, int maxLimit) async {
    try {
      // Check if already at max limit
      final currentFiles = _getMediaFiles(mediaKey);
      if (currentFiles.length >= maxLimit) {
        _showErrorDialog(
          'Maximum Limit Reached',
          'You can only upload up to $maxLimit $mediaName. Please remove some files first.',
        );
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Validate file size (max 10MB for videos, 5MB for images)
        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog(
            'File too large',
            'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB',
          );
          return;
        }

        // Validate file type for videos
        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          // Add to media files
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).add(fileInfo);
            } else {
              media[mediaKey] = [fileInfo];
            }
            _data['media'] = media;
          } else {
            _data['media'] = {mediaKey: [fileInfo]};
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$mediaName uploaded successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog('Upload Error', 'Failed to upload file: ${e.toString()}');
    }
  }

  void _viewMediaFile(Map<String, dynamic> file, String mediaName) {
    if (file['path'] != null && file['path'].isNotEmpty) {
      final fileName = file['name'] ?? 'File';
      final filePath = file['path'];
      final ext = fileName.split('.').last.toLowerCase();

      // For images, show image preview
      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mediaName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: lightText),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.file(
                      File(filePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
        // For videos, show video player
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mediaName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: lightText),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: VideoPlayerWidget(filePath: filePath),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        // For other files, show file info dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(mediaName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getFileIcon(fileName),
                  size: 48,
                  color: primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  fileName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Size: ${(file['size'] / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 12, color: lightText),
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
  }

  void _removeMediaFile(String mediaKey, int index, String mediaName) {
    _showConfirmationDialog(
      'Remove File',
      'Are you sure you want to remove this $mediaName?',
          () {
        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).removeAt(index);
              _data['media'] = media;
            }
          }
          _mediaEditModes[mediaKey] = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$mediaName removed successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _initializeAmenities() {
    _editModes = {
      'amenities': false,
      'custom': false,
    };

    // Initialize price edit modes for all price fields
    _priceEditModes = {
      'basePrice': false,
      'weekendPrice': false,
      'peakPrice': false,
      'securityDeposit': false,
      'minimumStay': false,
    };
    _documentEditModes = {
      'ownershipProof': false,
      'idProof': false,
      'cancellationPolicy': false,
      'availabilityCalendar': false,
      'cancelledCheque': false,
    };

    _mediaEditModes = {
      'villa_exterior': false,
      'villa_interior': false,
      'bedroom': false,
      'bathroom': false,
      'amenities': false,
      'short_video': false,
    };


    _mediaMaxLimits = {
      'villa_exterior': 2,
      'villa_interior': 2,
      'bedroom': 1,
      'bathroom': 1,
      'amenities': 5,
      'short_video': 1,
    };
    // Initialize Villa Amenities
    if (_data['selectedAmenities'] != null && _data['selectedAmenities'] is Map) {
      _villaAmenities = Map<String, bool>.from(_data['selectedAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['selected'] is Map) {
      _villaAmenities = Map<String, bool>.from(_data['amenities']['selected']);
    } else {
      _villaAmenities = {
        'Private Swimming Pool': false,
        'WiFi': false,
        'Air Conditioning': false,
        'Kitchen': false,
        'Parking': false,
        'Power Backup': false,
        'CCTV Security': false,
        'Caretaker Available': false,
        'Garden': false,
        'BBQ Area': false,
        'TV': false,
        'Washing Machine': false,
        'Pet Friendly': false,
        'Event Allowed': false,
      };
    }

    // Initialize Custom Amenities
    if (_data['customAmenities'] != null && _data['customAmenities'] is List) {
      _customAmenities = List<String>.from(_data['customAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['custom'] is List) {
      _customAmenities = List<String>.from(_data['amenities']['custom']);
    } else {
      _customAmenities = [];
    }
  }

  void _autoSaveAmenities() {
    _data['selectedAmenities'] = Map<String, bool>.from(_villaAmenities);
    _data['customAmenities'] = List<String>.from(_customAmenities);
  }

  void _savePhoneChanges() {
    setState(() {
      if (_data.containsKey('phone')) {
        _data['phone'] = _phoneController.text;
      }
      if (_data.containsKey('mobile')) {
        _data['mobile'] = _phoneController.text;
      }
      if (_data.containsKey('basicInfo')) {
        final basicInfo = _data['basicInfo'] as Map;
        basicInfo['mobile'] = _phoneController.text;
        _data['basicInfo'] = basicInfo;
      }
      _isEditingPhone = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number updated successfully'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickAndUploadPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Choose Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: primaryColor),
                  ),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: primaryColor),
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _data['ownerPhoto'] = {
            'uploaded': true,
            'name': image.name,
            'path': image.path,
          };
          if (_data.containsKey('basicInfo')) {
            final basicInfo = _data['basicInfo'] as Map;
            basicInfo['ownerPhoto'] = {
              'uploaded': true,
              'name': image.name,
              'path': image.path,
            };
            _data['basicInfo'] = basicInfo;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo uploaded successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
        return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      }
      return value;
    }
    return value.toString();
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num) return true; // This includes 0
    if (value is Map) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;
    if (value is bool) return true;
    return true;
  }

  String _getRegistrationId() {
    final villaName = _getVillaName();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final namePrefix = villaName.length >= 3
        ? villaName.substring(0, 3).toUpperCase()
        : villaName.toUpperCase();
    return 'VILLA-$namePrefix-$timestamp';
  }

  String _getUserFullName() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName') && basicInfo['ownerName'].toString().isNotEmpty) {
        return basicInfo['ownerName'].toString();
      }
      if (basicInfo.containsKey('fullName') && basicInfo['fullName'].toString().isNotEmpty) {
        return basicInfo['fullName'].toString();
      }
    }

    // Direct keys
    if (_data.containsKey('fullName') && _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') && _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }

    return 'User';
  }

  String _getUserEmail() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('email') && basicInfo['email'].toString().isNotEmpty) {
        return basicInfo['email'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('email') && _data['email'].toString().isNotEmpty) {
      return _data['email'].toString();
    }

    return 'Not provided';
  }

  String _getUserPhone() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('mobile') && basicInfo['mobile'].toString().isNotEmpty) {
        return basicInfo['mobile'].toString();
      }
      if (basicInfo.containsKey('phone') && basicInfo['phone'].toString().isNotEmpty) {
        return basicInfo['phone'].toString();
      }
    }

    // Direct keys
    if (_data.containsKey('phone') && _data['phone'].toString().isNotEmpty) {
      return _data['phone'].toString();
    }
    if (_data.containsKey('mobile') && _data['mobile'].toString().isNotEmpty) {
      return _data['mobile'].toString();
    }

    return 'Not provided';
  }

  String _getVillaName() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('villaName') && basicInfo['villaName'].toString().isNotEmpty) {
        return basicInfo['villaName'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('villaName') && _data['villaName'].toString().isNotEmpty) {
      return _data['villaName'].toString();
    }

    return 'Villa';
  }

  String _getAlternateMobile() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('altMobile') && basicInfo['altMobile'].toString().isNotEmpty) {
        return basicInfo['altMobile'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('altMobile') && _data['altMobile'].toString().isNotEmpty) {
      return _data['altMobile'].toString();
    }

    return '';
  }

  String _getWebsite() {
    // Check in basicInfo nested structure
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('website') && basicInfo['website'].toString().isNotEmpty) {
        return basicInfo['website'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('website') && _data['website'].toString().isNotEmpty) {
      return _data['website'].toString();
    }

    return '';
  }

  String _getGoogleMapLink() {
    // Check in location nested structure
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('googleMapLink') && location['googleMapLink'].toString().isNotEmpty) {
        return location['googleMapLink'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('googleMapLink') && _data['googleMapLink'].toString().isNotEmpty) {
      return _data['googleMapLink'].toString();
    }

    return '';
  }

  String _getPropertySize() {
    // Check in propertyDetails nested structure
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('propertySize') && details['propertySize'].toString().isNotEmpty) {
        return details['propertySize'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('propertySize') && _data['propertySize'].toString().isNotEmpty) {
      return _data['propertySize'].toString();
    }

    return '';
  }

  String _getYearConstruction() {
    // Check in propertyDetails nested structure
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('yearConstruction') && details['yearConstruction'].toString().isNotEmpty) {
        return details['yearConstruction'].toString();
      }
    }

    // Direct key
    if (_data.containsKey('yearConstruction') && _data['yearConstruction'].toString().isNotEmpty) {
      return _data['yearConstruction'].toString();
    }

    return '';
  }

  // String _getVirtualTourLink() {
  //   print('=== GETTING VIRTUAL TOUR LINK ===');
  //
  //   // Check direct key first
  //   if (_data.containsKey('virtualTourLink')) {
  //     final value = _data['virtualTourLink'];
  //     print('Direct virtualTourLink found: $value (type: ${value.runtimeType})');
  //     if (value != null && value.toString().isNotEmpty) {
  //       return value.toString();
  //     }
  //   }
  //
  //   // Check in media nested structure
  //   if (_data.containsKey('media') && _data['media'] != null) {
  //     final media = _data['media'] as Map;
  //     print('Media keys: ${media.keys.toList()}');
  //
  //     // Check for virtual_tour as List
  //     if (media.containsKey('virtual_tour')) {
  //       final tours = media['virtual_tour'];
  //       print('virtual_tour found: $tours (type: ${tours.runtimeType})');
  //
  //       if (tours is List && tours.isNotEmpty) {
  //         if (tours[0] is Map && tours[0]['path'] != null && tours[0]['path'].toString().isNotEmpty) {
  //           return tours[0]['path'].toString();
  //         } else if (tours[0] is String && tours[0].toString().isNotEmpty) {
  //           return tours[0].toString();
  //         }
  //       } else if (tours is String && tours.isNotEmpty) {
  //         return tours;
  //       }
  //     }
  //
  //     // Check for virtualTourLink in media
  //     if (media.containsKey('virtualTourLink')) {
  //       final value = media['virtualTourLink'];
  //       print('virtualTourLink in media: $value');
  //       if (value != null && value.toString().isNotEmpty) {
  //         return value.toString();
  //       }
  //     }
  //   }
  //
  //   // Check in basicInfo
  //   if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
  //     final basicInfo = _data['basicInfo'] as Map;
  //     if (basicInfo.containsKey('virtualTourLink')) {
  //       final value = basicInfo['virtualTourLink'];
  //       print('virtualTourLink in basicInfo: $value');
  //       if (value != null && value.toString().isNotEmpty) {
  //         return value.toString();
  //       }
  //     }
  //   }
  //
  //   print('No virtual tour link found');
  //   return '';
  // }

  String _getVirtualTourLink() {
    print('=== GETTING VIRTUAL TOUR LINK ===');

    // Check in media.virtual_tour (string or list)
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      print('Media keys: ${media.keys.toList()}');

      // Check for virtual_tour as a direct string
      if (media.containsKey('virtual_tour')) {
        final tour = media['virtual_tour'];
        print('virtual_tour found: $tour (type: ${tour.runtimeType})');

        if (tour is String && tour.isNotEmpty) {
          return tour;
        }

        // If it's a list, check the first element
        if (tour is List && tour.isNotEmpty) {
          if (tour[0] is Map && tour[0]['path'] != null && tour[0]['path'].toString().isNotEmpty) {
            return tour[0]['path'].toString();
          } else if (tour[0] is String && tour[0].toString().isNotEmpty) {
            return tour[0].toString();
          }
        }
      }

      // Check for virtualTourLink in media
      if (media.containsKey('virtualTourLink')) {
        final value = media['virtualTourLink'];
        print('virtualTourLink in media: $value');
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }

      // Check for virtual_tour_url
      if (media.containsKey('virtual_tour_url')) {
        final value = media['virtual_tour_url'];
        print('virtual_tour_url in media: $value');
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }
    }

    // Check direct key
    if (_data.containsKey('virtualTourLink')) {
      final value = _data['virtualTourLink'];
      print('Direct virtualTourLink found: $value');
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }

    // Check in basicInfo
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('virtualTourLink')) {
        final value = basicInfo['virtualTourLink'];
        print('virtualTourLink in basicInfo: $value');
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }
      if (basicInfo.containsKey('virtual_tour')) {
        final value = basicInfo['virtual_tour'];
        print('virtual_tour in basicInfo: $value');
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }
    }

    // Check in propertyDetails
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('virtualTourLink')) {
        final value = details['virtualTourLink'];
        print('virtualTourLink in propertyDetails: $value');
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }
    }

    print('No virtual tour link found');
    return '';
  }

  String _getPropertyType() {
    // Check in propertyDetails nested structure
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('propertyType') && details['propertyType'].toString().isNotEmpty) {
        return details['propertyType'].toString();
      }
    }

    // Check direct propertyTypeValue
    if (_data.containsKey('propertyTypeValue') && _data['propertyTypeValue'].toString().isNotEmpty) {
      return _data['propertyTypeValue'].toString();
    }

    // Check direct propertyType
    if (_data.containsKey('propertyType') && _data['propertyType'].toString().isNotEmpty) {
      return _data['propertyType'].toString();
    }

    return 'Luxury Villa';
  }


  List<Map<String, dynamic>> _getMediaFiles(String mediaKey) {
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      if (media.containsKey(mediaKey) && media[mediaKey] is List) {
        return List<Map<String, dynamic>>.from(media[mediaKey]);
      }
    }

    // Check direct key
    if (_data.containsKey(mediaKey) && _data[mediaKey] is List) {
      return List<Map<String, dynamic>>.from(_data[mediaKey]);
    }

    return [];
  }


  Map<String, dynamic> _getFileInfo(String key) {
    // Check in pricing nested structure
    if (_data.containsKey('pricing') && _data['pricing'] != null) {
      final pricing = _data['pricing'] as Map;
      if (pricing.containsKey(key) && pricing[key] is Map) {
        return Map<String, dynamic>.from(pricing[key]);
      }
    }

    // Direct key
    if (_data.containsKey(key) && _data[key] is Map) {
      return Map<String, dynamic>.from(_data[key]);
    }

    return {'uploaded': false};
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [

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
                            Container(
                              width: 80,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.villa,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getVillaName(),
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
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _getPropertyType(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
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

            actions: [
              // Logout Button
              GestureDetector(
                onTap: () => _showLogoutConfirmationDialog(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
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
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: _getOwnerPhotoWidget(),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickAndUploadPhoto,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: cardColor,
                  //     borderRadius: const BorderRadius.only(
                  //       topLeft: Radius.circular(20),
                  //       topRight: Radius.circular(20),
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: shadowColor,
                  //         blurRadius: 10,
                  //         offset: const Offset(0, -2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: TabBar(
                  //     controller: _tabController,
                  //     isScrollable: true,
                  //     labelColor: primaryColor,
                  //     unselectedLabelColor: lightText,
                  //     indicatorColor: primaryColor,
                  //     indicatorWeight: 3,
                  //     indicatorSize: TabBarIndicatorSize.label,
                  //     labelStyle: const TextStyle(
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     unselectedLabelStyle: const TextStyle(
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     tabs: const [
                  //       Tab(text: 'Basic Info'),
                  //       Tab(text: 'Location'),
                  //       Tab(text: 'Property Details'),
                  //       Tab(text: 'Amenities'),
                  //       Tab(text: 'Pricing & Policies'),
                  //       Tab(text: 'Legal & Bank'),
                  //     ],
                  //   ),
                  // ),

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
                        Tab(text: 'Location'),
                        Tab(text: 'Property Details'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Pricing & Policies'),
                        Tab(text: 'Media & Virtual Tour'),
                        Tab(text: 'Legal & Bank'),

                      ],
                    ),
                  ),
                  // Tab Bar Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildBasicInfo(),
                        _buildLocation(),
                        _buildPropertyDetails(),
                        _buildAmenities(),
                        _buildPricingPolicies(),
                        _buildMediaAndVirtualTour(),
                        _buildLegalBank(),

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

  Widget _buildMediaAndVirtualTour() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [



          // const SizedBox(height: 16),

          _buildMediaSection(),

          // _buildVirtualTourSection(),
        ],
      ),
    );
  }

  Widget _buildVirtualTourSection() {
    final String virtualTourLink = _getVirtualTourLink();

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
                child: Icon(Icons.videocam, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                'Virtual Tour',
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

          if (virtualTourLink.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.link, size: 18, color: primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      virtualTourLink,
                      style: TextStyle(fontSize: 12, color: darkText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                      _launchURL(virtualTourLink);
                    },
                    icon: Icon(Icons.open_in_new, size: 18, color: primaryColor),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No virtual tour link available',
                      style: TextStyle(fontSize: 12, color: lightText),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog('Error', 'Could not launch URL');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showLogoutPurposeDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Yes, Logout',style:TextStyle(color:Colors.white)),
            ),
          ],
        );
      },
    );
  }


  void _showLogoutPurposeDialog(BuildContext context) {
    final List<String> purposes = [
      'Technical Issue',
      'User Interface Issue',
      'Found Better Alternative',
      'Not Satisfied with Service',
      'Security Concerns',
      'Account Management',
      'Other',
    ];

    String? selectedPurpose;
    String? customPurpose;
    TextEditingController customController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Reason for Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Please help us improve by sharing your reason for leaving:',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      ...purposes.map((purpose) {
                        return RadioListTile<String>(
                          title: Text(purpose),
                          value: purpose,
                          groupValue: selectedPurpose,
                          onChanged: (value) {
                            setState(() {
                              selectedPurpose = value;
                              if (value != 'Other') {
                                customPurpose = null;
                              }
                            });
                          },
                          activeColor: primaryColor,
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                      if (selectedPurpose == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: 'Please specify...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                            onChanged: (value) {
                              customPurpose = value;
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final reason = selectedPurpose == 'Other'
                        ? customPurpose
                        : selectedPurpose;
                    if (reason != null && reason.isNotEmpty) {
                      Navigator.pop(context);
                      _showFeedbackDialog(context, reason);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a reason'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Continue',style:TextStyle(color:Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void _showFeedbackDialog(BuildContext context, String reason) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Your Feedback Matters!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Reason: $reason',
                        style: TextStyle(
                          fontSize: 13,
                          color: darkText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Any additional feedback?',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Your feedback helps us improve...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showFinalLogoutConfirmation(context, reason, feedbackController.text);
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showFinalLogoutConfirmation(context, reason, feedbackController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit & Logout', style:TextStyle(color:Colors.white)),
            ),
          ],
        );
      },
    );
  }


  // void _showFinalLogoutConfirmation(BuildContext context, String reason, String feedback) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text(
  //           'Final Confirmation',
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Icon(
  //               Icons.warning_amber_rounded,
  //               size: 48,
  //               color: Colors.orange,
  //             ),
  //             const SizedBox(height: 16),
  //             const Text(
  //               'Are you absolutely sure you want to logout?',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             const SizedBox(height: 12),
  //             Container(
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[100],
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     'You will be logged out of your account.',
  //                     style: TextStyle(fontSize: 12, color: lightText),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     'Your registration data is saved.',
  //                     style: TextStyle(fontSize: 12, color: Colors.green),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(color: Colors.grey[600]),
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //
  //               await _saveLogoutFeedback(reason, feedback);
  //
  //               // Navigate back to login/home screen
  //               Navigator.of(context).pushAndRemoveUntil(
  //                 MaterialPageRoute(
  //                   builder: (context) => LoginScreen1(),
  //                 ),
  //                     (route) => false,
  //               );
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.red,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             child: const Text('Logout Permanently', style: TextStyle(color:Colors.white)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showFinalLogoutConfirmation(BuildContext context, String reason, String feedback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Final Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you absolutely sure you want to logout and remove this villa?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Villa: ${_getVillaName()}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This villa will be removed from your list.',
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveLogoutFeedback(reason, feedback);

                // Remove only this specific villa
                await _removeCurrentVillaFromList();

                // Navigate back to villa list with updated data
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => VillaListScreen(
                      userData: widget.registrationData,
                      removedVillaId: widget.villaId ?? _data['id'],
                      userEmail: _getUserEmail(), // Add this line - pass the user email
                    ),
                  ),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout & Remove Villa', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeCurrentVillaFromList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String userEmail = _getUserEmail();

      // Get villa ID properly
      String villaIdToRemove = '';

      if (widget.villaId != null && widget.villaId!.isNotEmpty) {
        villaIdToRemove = widget.villaId!;
      } else if (_data.containsKey('id') && _data['id'] != null && _data['id'].toString().isNotEmpty) {
        villaIdToRemove = _data['id'].toString();
      } else if (_data.containsKey('basicInfo') && _data['basicInfo'] is Map) {
        final basicInfo = _data['basicInfo'] as Map;
        if (basicInfo.containsKey('id') && basicInfo['id'].toString().isNotEmpty) {
          villaIdToRemove = basicInfo['id'].toString();
        }
      }

      print('=== REMOVING VILLA ===');
      print('User Email: $userEmail');
      print('Villa ID to remove: "$villaIdToRemove"');

      if (villaIdToRemove.isEmpty) {
        print('ERROR: Villa ID is empty!');
        return;
      }

      // Get users list
      final String usersJson = prefs.getString('registered_users') ?? '[]';
      List<dynamic> usersList = jsonDecode(usersJson);

      // Find user
      int userIndex = -1;
      for (int i = 0; i < usersList.length; i++) {
        if (usersList[i]['email'] == userEmail) {
          userIndex = i;
          break;
        }
      }

      if (userIndex == -1) return;

      Map<String, dynamic> userData = Map<String, dynamic>.from(usersList[userIndex]);

      if (userData.containsKey('villlas') && userData['villlas'] is List) {
        List<dynamic> villasList = userData['villlas'];

        // Remove matching villa
        villasList.removeWhere((villa) {
          Map<String, dynamic> villaMap = Map<String, dynamic>.from(villa);
          String currentId = villaMap['id']?.toString() ??
              villaMap['basicInfo']?['id']?.toString() ??
              '';
          return currentId == villaIdToRemove;
        });

        userData['villlas'] = villasList;
        usersList[userIndex] = userData;

        await prefs.setString('registered_users', jsonEncode(usersList));
        print('Villa removed successfully');
      }
    } catch (e) {
      print('Error removing villa: $e');
    }
  }


  // Future<void> _removeCurrentVillaFromList() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //
  //     // Get the current villa ID or name to identify which one to remove
  //     final currentVillaId = _getRegistrationId(); // or use villa name
  //     final currentVillaName = _getVillaName();
  //
  //     // Get the list of registered villas
  //     List<String> registeredVillas = prefs.getStringList('registered_villas') ?? [];
  //
  //     print('=== REMOVING VILLA ===');
  //     print('Current villa to remove: $currentVillaName (ID: $currentVillaId)');
  //     print('Current registered villas count: ${registeredVillas.length}');
  //
  //     // Filter out the current villa
  //     List<String> updatedVillas = registeredVillas.where((villa) {
  //       try {
  //         Map<String, dynamic> villaData = jsonDecode(villa);
  //         // Check if this is the current villa
  //         return villaData['villaName'] != currentVillaName &&
  //             villaData['registrationId'] != currentVillaId;
  //       } catch (e) {
  //         return true; // Keep if can't parse
  //       }
  //     }).toList();
  //
  //     // Save the updated list
  //     await prefs.setStringList('registered_villas', updatedVillas);
  //
  //     print('Villa removed successfully');
  //     print('Remaining villas count: ${updatedVillas.length}');
  //
  //   } catch (e) {
  //     print('Error removing villa: $e');
  //   }
  // }


  // Future<void> _saveLogoutFeedback(String reason, String feedback) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final List<String> feedbackList = prefs.getStringList('logout_feedback') ?? [];
  //
  //     final feedbackEntry = {
  //       'timestamp': DateTime.now().toIso8601String(),
  //       'reason': reason,
  //       'feedback': feedback,
  //       'userEmail': _getUserEmail(),
  //       'villaName': _getVillaName(),
  //     };
  //
  //     feedbackList.add(jsonEncode(feedbackEntry));
  //     await prefs.setStringList('logout_feedback', feedbackList);
  //
  //     print('Logout feedback saved: $feedbackEntry');
  //   } catch (e) {
  //     print('Error saving feedback: $e');
  //   }
  // }

  Future<void> _saveLogoutFeedback(String reason, String feedback) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> feedbackList = prefs.getStringList('logout_feedback') ?? [];

      final feedbackEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'reason': reason,
        'feedback': feedback,
        'userEmail': _getUserEmail(),
        'villaName': _getVillaName(),
        'villaId': widget.villaId ?? _data['id'],
        'action': 'remove_villa',
      };

      feedbackList.add(jsonEncode(feedbackEntry));
      await prefs.setStringList('logout_feedback', feedbackList);

      print('Logout feedback saved: $feedbackEntry');
    } catch (e) {
      print('Error saving feedback: $e');
    }
  }

  Widget _getOwnerPhotoWidget() {
    // Check in basicInfo nested structure
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) {
        ownerPhoto = basicInfo['ownerPhoto'];
      }
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) {
      ownerPhoto = _data['ownerPhoto'];
    }

    if (ownerPhoto != null && ownerPhoto['path'] != null) {
      return Image.file(
        File(ownerPhoto['path']),
        fit: BoxFit.cover,
        width: 60,
        height: 60,
      );
    }

    return Center(
      child: Icon(
        Icons.person_rounded,
        size: 35,
        color: primaryColor,
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

  Widget _buildEditablePhoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Mobile Number',
              style: TextStyle(
                fontSize: 13,
                color: lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: TextStyle(fontSize: 13, color: lightText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Villa Information',
            icon: Icons.villa,
            children: [
              _buildInfoRow('Villa Name', _getVillaName()),
              _buildInfoRow('Property Type', _getPropertyType()),
              if (_hasValue(_data['bedrooms']) || _hasValue(_data['propertyDetails']?['bedrooms']))
                _buildInfoRow('Bedrooms', _data['bedrooms'] ?? _data['propertyDetails']?['bedrooms']),
              if (_hasValue(_data['bathrooms']) || _hasValue(_data['propertyDetails']?['bathrooms']))
                _buildInfoRow('Bathrooms', _data['bathrooms'] ?? _data['propertyDetails']?['bathrooms']),
              if (_hasValue(_data['guestCapacity']) || _hasValue(_data['propertyDetails']?['guestCapacity']))
                _buildInfoRow('Guest Capacity', '${_data['guestCapacity'] ?? _data['propertyDetails']?['guestCapacity']} guests'),
              // Property Size - ADD THIS
              if (_getPropertySize().isNotEmpty)
                _buildInfoRow('Property Size', '${_getPropertySize()} sq.ft.'),
              // Year of Construction - ADD THIS
              if (_getYearConstruction().isNotEmpty)
                _buildInfoRow('Year Built', _getYearConstruction()),
            ],
          ),
          const SizedBox(height: 16),

          // Contact Information Card
          Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(Icons.contact_phone, size: 18, color: primaryColor),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    if (!_isEditingPhone)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEditingPhone = true;
                            _phoneController.text = _getUserPhone();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primarySoft,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: primaryColor.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit, size: 14, color: primaryColor),
                              const SizedBox(width: 4),
                              Text(
                                'Edit Phone',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildInfoRow('Owner/Manager', _getUserFullName()),

                if (_isEditingPhone)
                  _buildEditablePhoneField()
                else
                  _buildInfoRow('Mobile Number', _getUserPhone()),

                // Alternate Mobile - ADD THIS
                if (_getAlternateMobile().isNotEmpty && !_isEditingPhone)
                  _buildInfoRow('Alternate Mobile', _getAlternateMobile()),

                if (_isEditingPhone)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isEditingPhone = false;
                              _phoneController.text = _getUserPhone();
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: lightText,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _savePhoneChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),

                _buildInfoRow('Email', _getUserEmail()),

                // Website - ADD THIS
                if (_getWebsite().isNotEmpty)
                  _buildInfoRow('Website', _getWebsite()),
              ],
            ),
          ),

          if (_getOwnerPhotoWidget() is Image)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildPhotoTile(),
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoTile() {
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) {
        ownerPhoto = basicInfo['ownerPhoto'];
      }
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) {
      ownerPhoto = _data['ownerPhoto'];
    }

    if (ownerPhoto == null) return const SizedBox.shrink();

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ownerPhoto['path'] != null
                  ? Image.file(File(ownerPhoto['path']), fit: BoxFit.cover)
                  : const Center(
                child: Icon(Icons.photo_camera, color: Colors.white, size: 24),
              ),
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
                  ownerPhoto['name'] ?? 'Uploaded successfully',
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

  Widget _buildLocation() {
    final officeAddressChildren = <Widget>[];

    // Debug prints
    print('=== BUILDING LOCATION SECTION ===');
    print('Office Address: ${_getOfficeAddress()}');
    print('Office Area: ${_getOfficeArea()}');
    print('Office City: ${_getOfficeCity()}');
    print('Office State: ${_getOfficeState()}');
    print('Office Pincode: ${_getOfficePincode()}');
    print('Office GoogleMap: ${_getOfficeGoogleMapLink()}');

    // Build office address section only if there's data
    if (_getOfficeAddress() != 'Not provided' ||
        _getOfficeArea().isNotEmpty ||
        _getOfficeCity() != 'Not provided' ||
        _getOfficeGoogleMapLink().isNotEmpty) {
      officeAddressChildren.addAll([
        _buildInfoRow('Office Address', _getOfficeAddress()),
        if (_getOfficeArea().isNotEmpty)
          _buildInfoRow('Area / Locality', _getOfficeArea()),
        _buildInfoRow('City', _getOfficeCity()),
        _buildInfoRow('State', _getOfficeState()),
        _buildInfoRow('Pincode', _getOfficePincode()),
        if (_getOfficeGoogleMapLink().isNotEmpty)
          _buildOfficeGoogleMapLink(),
      ]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Office Address Card - Only show if there's data
          if (officeAddressChildren.isNotEmpty)
            _buildGlassCard(
              title: 'Permanent Office Address',
              icon: Icons.business,
              children: officeAddressChildren,
            ),

          if (officeAddressChildren.isNotEmpty)
            const SizedBox(height: 16),

          // Villa Address Card
          _buildGlassCard(
            title: 'Villa Location Details',
            icon: Icons.location_on,
            children: [
              _buildInfoRow('Villa Address', _getAddress()),
              if (_getArea().isNotEmpty)
                _buildInfoRow('Area / Locality', _getArea()),
              _buildInfoRow('City', _getCity()),
              _buildInfoRow('State', _getState()),
              _buildInfoRow('Pincode', _getPincode()),
              if (_getGoogleMapLink().isNotEmpty)
                _buildGoogleMapLink(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getOfficeGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getAddress() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('address') && location['address'].toString().isNotEmpty) {
        return location['address'].toString();
      }
    }
    return _data['address']?.toString() ?? 'Not provided';
  }

  String _getArea() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('area') && location['area'].toString().isNotEmpty) {
        return location['area'].toString();
      }
    }
    return _data['area']?.toString() ?? '';
  }

  String _getCity() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('city') && location['city'].toString().isNotEmpty) {
        return location['city'].toString();
      }
    }
    return _data['city']?.toString() ?? 'Not provided';
  }

  String _getState() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('state') && location['state'].toString().isNotEmpty) {
        return location['state'].toString();
      }
    }
    return _data['state']?.toString() ?? 'Not provided';
  }

  String _getPincode() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('pincode') && location['pincode'].toString().isNotEmpty) {
        return location['pincode'].toString();
      }
    }
    return _data['pincode']?.toString() ?? 'Not provided';
  }

  Widget _buildGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetails() {
    final description = _getDescription();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Property Description',
            icon: Icons.description,
            children: [
              if (description.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: darkText, height: 1.5),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          _buildGlassCard(
            title: 'Property Specifications',
            icon: Icons.architecture,
            children: [
              if (_hasValue(_data['bedrooms']) || _hasValue(_data['propertyDetails']?['bedrooms']))
                _buildInfoRow('Bedrooms', _data['bedrooms'] ?? _data['propertyDetails']?['bedrooms']),
              if (_hasValue(_data['bathrooms']) || _hasValue(_data['propertyDetails']?['bathrooms']))
                _buildInfoRow('Bathrooms', _data['bathrooms'] ?? _data['propertyDetails']?['bathrooms']),
              if (_hasValue(_data['guestCapacity']) || _hasValue(_data['propertyDetails']?['guestCapacity']))
                _buildInfoRow('Guest Capacity', '${_data['guestCapacity'] ?? _data['propertyDetails']?['guestCapacity']} guests'),
              if (_getPropertySize().isNotEmpty)
                _buildInfoRow('Property Size', '${_getPropertySize()} sq.ft.'),
              if (_getYearConstruction().isNotEmpty)
                _buildInfoRow('Year Built', _getYearConstruction()),
              _buildInfoRow('Property Type', _getPropertyType()),
            ],
          ),
        ],
      ),
    );
  }

  String _getDescription() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('description') && details['description'].toString().isNotEmpty) {
        return details['description'].toString();
      }
    }
    return _data['description']?.toString() ?? '';
  }

  Widget _buildAmenities() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Villa Amenities - With edit mode
          if (_villaAmenities.isNotEmpty)
            _buildEditableSection(
              title: 'Villa Amenities',
              icon: Icons.workspaces_filled,
              amenities: _villaAmenities,
              sectionId: 'amenities',
            ),

          // Custom Amenities
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildCustomAmenitiesCard(),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadNewDocument(String docType, String docName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Validate file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog('File too large', 'Please select a file smaller than 5MB');
          return;
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          // Update based on document type
          switch (docType) {
            case 'ownershipProof':
              _data['ownershipProof'] = fileInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['ownershipProof'] = fileInfo;
              }
              break;
            case 'idProof':
              _data['idProof'] = fileInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['idProof'] = fileInfo;
              }
              break;
            case 'cancellationPolicy':
              _data['cancellationPolicy'] = fileInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['cancellationPolicy'] = fileInfo;
              }
              break;
            case 'availabilityCalendar':
              _data['availabilityCalendar'] = fileInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['availabilityCalendar'] = fileInfo;
              }
              break;
            case 'cancelledCheque':
              _data['cancelledCheque'] = fileInfo;
              if (_data.containsKey('bank') && _data['bank'] is Map) {
                (_data['bank'] as Map)['cancelledCheque'] = fileInfo;
              }
              break;
          }
          _documentEditModes[docType] = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$docName uploaded successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog('Upload Error', 'Failed to upload file: ${e.toString()}');
    }
  }

  void _viewDocument(Map<String, dynamic> fileInfo, String docName) {
    if (fileInfo['path'] != null && fileInfo['path'].isNotEmpty) {
      final fileName = fileInfo['name'] ?? 'Document';
      final filePath = fileInfo['path'];
      final ext = fileName.split('.').last.toLowerCase();

      // For images, show image preview
      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          docName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: lightText),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.file(
                      File(filePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        // For other files, show file info dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(docName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getFileIcon(fileName),
                  size: 48,
                  color: primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  fileName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'Size: ${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB',
                  style: TextStyle(fontSize: 12, color: lightText),
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
  }

  void _removeDocument(String docType, String docName) {
    _showConfirmationDialog(
      'Remove Document',
      'Are you sure you want to remove $docName?',
          () {
        setState(() {
          Map<String, dynamic> emptyInfo = {
            'name': '',
            'size': 0,
            'path': '',
            'uploaded': false,
          };

          switch (docType) {
            case 'ownershipProof':
              _data['ownershipProof'] = emptyInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['ownershipProof'] = emptyInfo;
              }
              break;
            case 'idProof':
              _data['idProof'] = emptyInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['idProof'] = emptyInfo;
              }
              break;
            case 'cancellationPolicy':
              _data['cancellationPolicy'] = emptyInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['cancellationPolicy'] = emptyInfo;
              }
              break;
            case 'availabilityCalendar':
              _data['availabilityCalendar'] = emptyInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['availabilityCalendar'] = emptyInfo;
              }
              break;
            case 'cancelledCheque':
              _data['cancelledCheque'] = emptyInfo;
              if (_data.containsKey('bank') && _data['bank'] is Map) {
                (_data['bank'] as Map)['cancelledCheque'] = emptyInfo;
              }
              break;
          }
          _documentEditModes[docType] = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$docName removed successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text('Confirm', style: TextStyle(color: Colors.red)),
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


  Widget _buildEditableSection({
    required String title,
    required IconData icon,
    required Map<String, bool> amenities,
    required String sectionId,
  }) {
    bool isEditMode = _editModes[sectionId] ?? false;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 16, color: primaryColor),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) {
                      _autoSaveAmenities();
                      _editModes[sectionId] = false;
                    } else {
                      _editModes[sectionId] = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isEditMode ? Icons.check : Icons.edit,
                        size: 14,
                        color: isEditMode ? Colors.white : primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isEditMode ? 'Submit' : 'Edit',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isEditMode ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.entries.map((entry) {
              bool isSelected = entry.value;
              return GestureDetector(
                onTap: isEditMode
                    ? () {
                  setState(() {
                    amenities[entry.key] = !isSelected;
                    _autoSaveAmenities();
                  });
                }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.8)],
                    )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : borderColor,
                      width: isSelected ? 0 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Icon(Icons.check_circle, size: 14, color: Colors.white)
                      else
                        Icon(
                          isEditMode ? Icons.circle_outlined : Icons.circle,
                          size: 14,
                          color: isEditMode ? lightText : borderColor,
                        ),
                      const SizedBox(width: 6),
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : darkText,
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
    );
  }

  Widget _buildCustomAmenitiesCard() {
    final TextEditingController _customController = TextEditingController();
    bool isEditMode = _editModes['custom'] ?? false;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
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
                      color: darkText,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) {
                      _editModes['custom'] = false;
                      _autoSaveAmenities();
                    } else {
                      _editModes['custom'] = true;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isEditMode ? Icons.check : Icons.edit,
                        size: 14,
                        color: isEditMode ? Colors.white : primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isEditMode ? 'Submit' : 'Edit',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isEditMode ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (isEditMode)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _customController,
                        decoration: InputDecoration(
                          hintText: 'Enter new amenity...',
                          hintStyle: TextStyle(fontSize: 12, color: lightText),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_customController.text.trim().isNotEmpty) {
                            setState(() {
                              _customAmenities.add(_customController.text.trim());
                              _autoSaveAmenities();
                              _customController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),

          if (_customAmenities.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _customAmenities.asMap().entries.map((entry) {
                int index = entry.key;
                String amenity = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primarySoft : cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isEditMode ? primaryColor.withOpacity(0.3) : borderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        amenity,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isEditMode ? primaryColor : darkText,
                        ),
                      ),
                      if (isEditMode) ...[
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _customAmenities.removeAt(index);
                              _autoSaveAmenities();
                            });
                          },
                          child: Icon(Icons.close, size: 14, color: Colors.red),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

          if (_customAmenities.isEmpty && !isEditMode)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No custom amenities added',
                style: TextStyle(fontSize: 12, color: lightText, fontStyle: FontStyle.italic),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPricingPolicies() {
    // Get pricing data from nested structure
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    // Get values from either top-level or nested
    final basePrice = _data['basePrice'] ?? pricingData['basePrice'];
    final weekendPrice = _data['weekendPrice'] ?? pricingData['weekendPrice'];
    final peakPrice = _data['peakPrice'] ?? pricingData['peakPrice'];
    final securityDeposit = _data['securityDeposit'] ?? pricingData['securityDeposit'];
    final minimumStay = _data['minimumStay'] ?? pricingData['minimumStay'];

    // Get cancellation policy and availability calendar
    final cancellationPolicy = _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};
    final availabilityCalendar = _data['availabilityCalendar'] ?? pricingData['availabilityCalendar'] ?? {'uploaded': false};

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Pricing Information',
            icon: Icons.attach_money,
            children: [
              // Base Price - Editable
              _buildEditablePriceField(
                label: 'Base Price',
                value: basePrice,
                key: 'basePrice',
              ),
              // Weekend Price - Editable
              _buildEditablePriceField(
                label: 'Weekend Price',
                value: weekendPrice,
                key: 'weekendPrice',
              ),
              // Peak Season Price - Editable
              if (_hasValue(peakPrice))
                _buildEditablePriceField(
                  label: 'Peak Season Price',
                  value: peakPrice,
                  key: 'peakPrice',
                ),
              // Security Deposit - Editable
              if (_hasValue(securityDeposit))
                _buildEditablePriceField(
                  label: 'Security Deposit',
                  value: securityDeposit,
                  key: 'securityDeposit',
                ),
              // Minimum Stay - Editable
              if (_hasValue(minimumStay))
                _buildEditableIntegerField(
                  label: 'Minimum Stay',
                  value: minimumStay,
                  key: 'minimumStay',
                  suffix: ' nights',
                ),
            ],
          ),
          const SizedBox(height: 16),

          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildEditableTimeField(
                label: 'Check-in Time',
                controller: _checkInController,
                onChanged: (value) {
                  setState(() {
                    _checkInTime = value;
                    _autoSaveTimes();
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildEditableTimeField(
                label: 'Check-out Time',
                controller: _checkOutController,
                onChanged: (value) {
                  setState(() {
                    _checkOutTime = value;
                    _autoSaveTimes();
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Policy Documents
          _buildGlassCard(
            title: 'Policy Documents',
            icon: Icons.description,
            children: [
              _buildEditableDocumentItem(
                docName: 'Cancellation Policy',
                docType: 'cancellationPolicy',
                fileInfo: cancellationPolicy,
              ),
              _buildEditableDocumentItem(
                docName: 'Availability Calendar',
                docType: 'availabilityCalendar',
                fileInfo: availabilityCalendar,
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildEditablePriceField({
    required String label,
    required dynamic value,
    required String key,
  }) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      // Display mode - show value with edit button
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
                style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _hasValue(value) ? '₹${_formatPrice(value)}' : 'Not set',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Set all other price fields to false, then set this one to true
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    hintText: 'Enter amount',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _priceEditModes[key] = false;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  double? newValue = double.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      // Update in top-level
                      _data[key] = newValue;

                      // Update in pricing nested structure
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }

                      _priceEditModes[key] = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$label updated to ₹${_formatPrice(newValue)}'),
                        backgroundColor: primaryColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid amount'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 11,color:Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableIntegerField({
    required String label,
    required dynamic value,
    required String key,
    String suffix = '',
  }) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      // Display mode
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
                style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _hasValue(value) ? '${_formatInteger(value)}$suffix' : 'Not set',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }


    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    suffixText: suffix,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _priceEditModes[key] = false;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  int? newValue = int.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      _data[key] = newValue;

                      // Update in pricing nested structure
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }

                      _priceEditModes[key] = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$label updated to $newValue$suffix'),
                        backgroundColor: primaryColor,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid number'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 11, color:Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }




  // Widget _buildEditablePriceFieldSimple({
  //   required String label,
  //   required dynamic value,
  //   required String key,
  // }) {
  //   bool isEditing = _priceEditModes[key] ?? false;
  //   final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');
  //
  //   if (!isEditing) {
  //     return _buildPriceRow(label, value);
  //   }
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: primarySoft,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: primaryColor),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 3,
  //               child: Text(
  //                 label,
  //                 style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 4,
  //               child: TextField(
  //                 controller: controller,
  //                 decoration: InputDecoration(
  //                   prefixText: '₹ ',
  //                   hintText: 'Enter amount',
  //                   border: InputBorder.none,
  //                   contentPadding: const EdgeInsets.symmetric(vertical: 4),
  //                 ),
  //                 keyboardType: TextInputType.number,
  //                 textAlign: TextAlign.right,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             TextButton(
  //               onPressed: () {
  //                 setState(() {
  //                   _priceEditModes[key] = false;
  //                 });
  //               },
  //               child: const Text('Cancel', style: TextStyle(fontSize: 11)),
  //             ),
  //             const SizedBox(width: 8),
  //             ElevatedButton(
  //               onPressed: () {
  //                 double? newValue = double.tryParse(controller.text);
  //                 if (newValue != null) {
  //                   setState(() {
  //                     _data[key] = newValue;
  //                     // Also update in pricing nested structure
  //                     if (_data.containsKey('pricing') && _data['pricing'] is Map) {
  //                       final pricing = _data['pricing'] as Map;
  //                       pricing[key] = newValue;
  //                       _data['pricing'] = pricing;
  //                     }
  //                     _priceEditModes[key] = false;
  //                   });
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: Text('$label updated successfully'),
  //                       backgroundColor: primaryColor,
  //                       duration: Duration(seconds: 2),
  //                     ),
  //                   );
  //                 }
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: primaryColor,
  //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //                 minimumSize: Size.zero,
  //               ),
  //               child: const Text('Save', style: TextStyle(fontSize: 11)),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }




  // Widget _buildLegalBank() {
  //   print('=== LEGAL BANK DATA DEBUG ===');
  //   print('_data keys: ${_data.keys.toList()}');
  //
  //   // Get legal data from the correct location
  //   Map<String, dynamic> legalData = {};
  //   Map<String, dynamic> bankData = {};
  //   Map<String, dynamic> pricingData = {};
  //
  //   if (_data.containsKey('legal') && _data['legal'] is Map) {
  //     legalData = Map<String, dynamic>.from(_data['legal']);
  //   }
  //
  //   if (_data.containsKey('bank') && _data['bank'] is Map) {
  //     bankData = Map<String, dynamic>.from(_data['bank']);
  //   }
  //
  //   if (_data.containsKey('pricing') && _data['pricing'] is Map) {
  //     pricingData = Map<String, dynamic>.from(_data['pricing']);
  //   }
  //
  //   // Get file info from various locations
  //   final ownershipProof = _data['ownershipProof'] ?? legalData['ownershipProof'] ?? {'uploaded': false};
  //   final idProof = _data['idProof'] ?? legalData['idProof'] ?? {'uploaded': false};
  //   final cancellationPolicy = _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};
  //   final availabilityCalendar = _data['availabilityCalendar'] ?? pricingData['availabilityCalendar'] ?? {'uploaded': false};
  //   final cancelledCheque = _data['cancelledCheque'] ?? bankData['cancelledCheque'] ?? {'uploaded': false};
  //
  //   final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
  //   final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];
  //
  //   final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
  //   final bankName = bankData['bankName'] ?? _data['bankName'];
  //   final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
  //   final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
  //   final upiId = bankData['upiId'] ?? _data['upiId'];
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         // Legal & Verification Section
  //         _buildGlassCard(
  //           title: 'Legal & Verification',
  //           icon: Icons.gavel,
  //           children: [
  //             if (_hasValue(gstNumber))
  //               _buildInfoRow('GST Number', gstNumber),
  //             if (_hasValue(tradeLicense))
  //               _buildInfoRow('Trade License', tradeLicense),
  //             _buildEditableDocumentItem(
  //               docName: 'Ownership Proof',
  //               docType: 'ownershipProof',
  //               fileInfo: ownershipProof,
  //             ),
  //             _buildEditableDocumentItem(
  //               docName: 'ID Proof',
  //               docType: 'idProof',
  //               fileInfo: idProof,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //
  //         // Bank Details Section
  //         _buildGlassCard(
  //           title: 'Bank Details',
  //           icon: Icons.account_balance,
  //           children: [
  //             if (_hasValue(accountHolder))
  //               _buildInfoRow('Account Holder', accountHolder),
  //             if (_hasValue(bankName))
  //               _buildInfoRow('Bank Name', bankName),
  //             if (_hasValue(accountNumber))
  //               _buildInfoRow('Account Number', accountNumber),
  //             if (_hasValue(ifscCode))
  //               _buildInfoRow('IFSC Code', ifscCode),
  //             if (_hasValue(upiId))
  //               _buildInfoRow('UPI ID', upiId),
  //             _buildEditableDocumentItem(
  //               docName: 'Cancelled Cheque',
  //               docType: 'cancelledCheque',
  //               fileInfo: cancelledCheque,
  //             ),
  //           ],
  //         ),
  //
  //         const SizedBox(height: 16),
  //
  //         // Policy Documents Section
  //         _buildGlassCard(
  //           title: 'Policy Documents',
  //           icon: Icons.description,
  //           children: [
  //             _buildEditableDocumentItem(
  //               docName: 'Cancellation Policy',
  //               docType: 'cancellationPolicy',
  //               fileInfo: cancellationPolicy,
  //             ),
  //             _buildEditableDocumentItem(
  //               docName: 'Availability Calendar',
  //               docType: 'availabilityCalendar',
  //               fileInfo: availabilityCalendar,
  //             ),
  //           ],
  //         ),
  //
  //         const SizedBox(height: 16),
  //
  //         // Media Section
  //         _buildMediaSection(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLegalBank() {
    print('=== LEGAL BANK DATA DEBUG ===');
    print('_data keys: ${_data.keys.toList()}');

    // Get legal data from the correct location
    Map<String, dynamic> legalData = {};
    Map<String, dynamic> bankData = {};
    Map<String, dynamic> pricingData = {};

    if (_data.containsKey('legal') && _data['legal'] is Map) {
      legalData = Map<String, dynamic>.from(_data['legal']);
    }

    if (_data.containsKey('bank') && _data['bank'] is Map) {
      bankData = Map<String, dynamic>.from(_data['bank']);
    }

    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    // Get file info from various locations
    final ownershipProof = _data['ownershipProof'] ?? legalData['ownershipProof'] ?? {'uploaded': false};
    final idProof = _data['idProof'] ?? legalData['idProof'] ?? {'uploaded': false};
    final cancellationPolicy = _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};
    final availabilityCalendar = _data['availabilityCalendar'] ?? pricingData['availabilityCalendar'] ?? {'uploaded': false};
    final cancelledCheque = _data['cancelledCheque'] ?? bankData['cancelledCheque'] ?? {'uploaded': false};

    final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
    final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];

    final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
    final bankName = bankData['bankName'] ?? _data['bankName'];
    final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
    final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
    final upiId = bankData['upiId'] ?? _data['upiId'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Legal & Verification Section
          _buildGlassCard(
            title: 'Legal & Verification',
            icon: Icons.gavel,
            children: [
              if (_hasValue(gstNumber))
                _buildInfoRow('GST Number', gstNumber),
              if (_hasValue(tradeLicense))
                _buildInfoRow('Trade License', tradeLicense),
              _buildEditableDocumentItem(
                docName: 'Ownership Proof',
                docType: 'ownershipProof',
                fileInfo: ownershipProof,
              ),
              _buildEditableDocumentItem(
                docName: 'ID Proof',
                docType: 'idProof',
                fileInfo: idProof,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bank Details Section
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(accountHolder))
                _buildInfoRow('Account Holder', accountHolder),
              if (_hasValue(bankName))
                _buildInfoRow('Bank Name', bankName),
              if (_hasValue(accountNumber))
                _buildInfoRow('Account Number', accountNumber),
              if (_hasValue(ifscCode))
                _buildInfoRow('IFSC Code', ifscCode),
              if (_hasValue(upiId))
                _buildInfoRow('UPI ID', upiId),
              _buildEditableDocumentItem(
                docName: 'Cancelled Cheque',
                docType: 'cancelledCheque',
                fileInfo: cancelledCheque,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Policy Documents Section
          // _buildGlassCard(
          //   title: 'Policy Documents',
          //   icon: Icons.description,
          //   children: [
          //     _buildEditableDocumentItem(
          //       docName: 'Cancellation Policy',
          //       docType: 'cancellationPolicy',
          //       fileInfo: cancellationPolicy,
          //     ),
          //     _buildEditableDocumentItem(
          //       docName: 'Availability Calendar',
          //       docType: 'availabilityCalendar',
          //       fileInfo: availabilityCalendar,
          //     ),
          //   ],
          // ),

          // const SizedBox(height: 16),


          // _buildMediaSection(),
        ],
      ),
    );
  }

  Widget _buildMediaSection() {
    final List<Widget> mediaWidgets = [];

    final mediaCategories = {
      'villa_exterior': {'label': 'Villa Exterior Photos', 'maxLimit': 2},
      'villa_interior': {'label': 'Interior Photos', 'maxLimit': 2},
      'bedroom': {'label': 'Bedroom Photos', 'maxLimit': 1},
      'bathroom': {'label': 'Bathroom Photos', 'maxLimit': 1},
      'amenities': {'label': 'Amenities Photos', 'maxLimit': 5},
      'short_video': {'label': 'Short Video', 'maxLimit': 1},
    };

    mediaCategories.forEach((key, data) {
      final files = _getMediaFiles(key);
      final label = data['label'] as String;
      final maxLimit = data['maxLimit'] as int;
      bool isEditing = _mediaEditModes[key] ?? false;

      mediaWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildEditableMediaSection(
            label: label,
            mediaKey: key,
            files: files,
            maxLimit: maxLimit,
            isEditing: isEditing,
            onEditToggle: () {
              setState(() {
                _mediaEditModes[key] = !isEditing;
              });
            },
            onUpload: () => _uploadMediaFile(key, label, maxLimit),
            onView: (file) => _viewMediaFile(file, label),
            onRemove: (index) => _removeMediaFile(key, index, label),
            onReplace: (index) => _replaceMediaFile(key, index, label), // Add this line
          ),
        ),
      );
    });

    // Virtual Tour Link
    final String virtualTourLink = _getVirtualTourLink();
    if (virtualTourLink.isNotEmpty) {
      mediaWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Virtual Tour Link',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.link, size: 18, color: primaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        virtualTourLink,
                        style: TextStyle(fontSize: 12, color: darkText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

    if (mediaWidgets.isEmpty) return const SizedBox.shrink();

    return _buildGlassCard(
      title: 'Media & Virtual Tour',
      icon: Icons.photo_library,
      children: mediaWidgets,
    );
  }

  // Widget _buildMediaSection() {
  //   final List<Widget> mediaWidgets = [];
  //
  //   final mediaCategories = {
  //     'villa_exterior': {'label': 'Villa Exterior Photos', 'maxLimit': 2},
  //     'villa_interior': {'label': 'Interior Photos', 'maxLimit': 2},
  //     'bedroom': {'label': 'Bedroom Photos', 'maxLimit': 1},
  //     'bathroom': {'label': 'Bathroom Photos', 'maxLimit': 1},
  //     'amenities': {'label': 'Amenities Photos', 'maxLimit': 5},
  //     'short_video': {'label': 'Short Video', 'maxLimit': 1},
  //   };
  //
  //   mediaCategories.forEach((key, data) {
  //     final files = _getMediaFiles(key);
  //     final label = data['label'] as String;
  //     final maxLimit = data['maxLimit'] as int;
  //     bool isEditing = _mediaEditModes[key] ?? false;
  //
  //     mediaWidgets.add(
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 16),
  //         child: _buildEditableMediaSection(
  //           label: label,
  //           mediaKey: key,
  //           files: files,
  //           maxLimit: maxLimit,
  //           isEditing: isEditing,
  //           onEditToggle: () {
  //             setState(() {
  //               _mediaEditModes[key] = !isEditing;
  //             });
  //           },
  //           onUpload: () => _uploadMediaFile(key, label, maxLimit),
  //           onView: (file) => _viewMediaFile(file, label),
  //           onRemove: (index) => _removeMediaFile(key, index, label),
  //         ),
  //       ),
  //     );
  //   });
  //
  //   // Virtual Tour Link
  //   final String virtualTourLink = _getVirtualTourLink();
  //   if (virtualTourLink.isNotEmpty) {
  //     mediaWidgets.add(
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Virtual Tour Link',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w600,
  //                 color: darkText,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Container(
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 color: primarySoft,
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(color: primaryColor.withOpacity(0.2)),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.link, size: 18, color: primaryColor),
  //                   const SizedBox(width: 8),
  //                   Expanded(
  //                     child: Text(
  //                       virtualTourLink,
  //                       style: TextStyle(fontSize: 12, color: darkText),
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
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
  //   if (mediaWidgets.isEmpty) return const SizedBox.shrink();
  //
  //   return _buildGlassCard(
  //     title: 'Media & Virtual Tour',
  //     icon: Icons.photo_library,
  //     children: mediaWidgets,
  //   );
  // }

  // Widget _buildEditableMediaSection({
  //   required String label,
  //   required String mediaKey,
  //   required List<Map<String, dynamic>> files,
  //   required int maxLimit,
  //   required bool isEditing,
  //   required VoidCallback onEditToggle,
  //   required VoidCallback onUpload,
  //   required Function(Map<String, dynamic>) onView,
  //   required Function(int) onRemove,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Header with label and edit button
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w600,
  //               color: darkText,
  //             ),
  //           ),
  //           if (!isEditing && files.isNotEmpty)
  //             GestureDetector(
  //               onTap: onEditToggle,
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 decoration: BoxDecoration(
  //                   color: primarySoft,
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(Icons.edit, size: 12, color: primaryColor),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       'Edit',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: primaryColor,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //       const SizedBox(height: 8),
  //
  //       if (isEditing) ...[
  //         // Edit mode - show upload button and file list with remove options
  //         if (files.length < maxLimit)
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton.icon(
  //               onPressed: onUpload,
  //               icon: Icon(Icons.cloud_upload, size: 18),
  //               label: Text('Upload ${files.length + 1}/$maxLimit'),
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: primaryColor,
  //                 foregroundColor: Colors.white,
  //                 padding: const EdgeInsets.symmetric(vertical: 12),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         const SizedBox(height: 8),
  //         ...files.asMap().entries.map((entry) {
  //           int index = entry.key;
  //           var file = entry.value;
  //           return Container(
  //             margin: const EdgeInsets.only(bottom: 8),
  //             padding: const EdgeInsets.all(12),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: borderColor),
  //             ),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                     color: primaryColor.withOpacity(0.1),
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Icon(
  //                     _getFileIcon(file['name'] ?? ''),
  //                     size: 20,
  //                     color: primaryColor,
  //                   ),
  //                 ),
  //                 const SizedBox(width: 12),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         file['name'] ?? 'File',
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w500,
  //                           color: darkText,
  //                         ),
  //                         maxLines: 1,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       Text(
  //                         '${(file['size'] / 1024).toStringAsFixed(1)} KB',
  //                         style: TextStyle(fontSize: 10, color: lightText),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Row(
  //                   children: [
  //                     IconButton(
  //                       onPressed: () => onView(file),
  //                       icon: Icon(Icons.visibility, size: 18, color: primaryColor),
  //                       padding: EdgeInsets.zero,
  //                     ),
  //                     const SizedBox(width: 8),
  //                     IconButton(
  //                       onPressed: () => onRemove(index),
  //                       icon: Icon(Icons.delete, size: 18, color: Colors.red),
  //                       padding: EdgeInsets.zero,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             TextButton(
  //               onPressed: onEditToggle,
  //               child: Text('Done', style: TextStyle(color: primaryColor)),
  //             ),
  //           ],
  //         ),
  //       ] else ...[
  //         // View mode - show file list
  //         if (files.isNotEmpty)
  //           ...files.map((file) => GestureDetector(
  //             onTap: () => onView(file),
  //             child: Container(
  //               margin: const EdgeInsets.only(bottom: 8),
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(8),
  //                 border: Border.all(color: borderColor),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: primaryColor.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: Icon(
  //                       _getFileIcon(file['name'] ?? ''),
  //                       size: 20,
  //                       color: primaryColor,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           file['name'] ?? 'File',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                             color: darkText,
  //                           ),
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           '${(file['size'] / 1024).toStringAsFixed(1)} KB',
  //                           style: TextStyle(fontSize: 10, color: lightText),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Icon(
  //                     Icons.chevron_right,
  //                     size: 20,
  //                     color: lightText,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ))
  //         else
  //           Container(
  //             padding: const EdgeInsets.all(12),
  //             decoration: BoxDecoration(
  //               color: Colors.grey[50],
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(color: borderColor),
  //             ),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.cloud_upload_outlined, size: 20, color: lightText),
  //                 const SizedBox(width: 12),
  //                 Expanded(
  //                   child: Text(
  //                     'No files uploaded. Tap Edit to add.',
  //                     style: TextStyle(fontSize: 12, color: lightText),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //       ],
  //     ],
  //   );
  // }

  Widget _buildEditableMediaSection({
    required String label,
    required String mediaKey,
    required List<Map<String, dynamic>> files,
    required int maxLimit,
    required bool isEditing,
    required VoidCallback onEditToggle,
    required VoidCallback onUpload,
    required Function(Map<String, dynamic>) onView,
    required Function(int) onRemove,
    required Function(int) onReplace,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with label and edit button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
            ),
            if (!isEditing && files.isNotEmpty)
              GestureDetector(
                onTap: onEditToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primarySoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: 12, color: primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        if (isEditing) ...[
          // Edit mode - show upload button and file list with remove/ replace options
          if (files.length < maxLimit)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onUpload,
                icon: Icon(Icons.cloud_upload, size: 18),
                label: Text('Upload ${files.length + 1}/$maxLimit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),
          ...files.asMap().entries.map((entry) {
            int index = entry.key;
            var file = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: [
                  // File info row
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getFileIcon(file['name'] ?? ''),
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              file['name'] ?? 'File',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: darkText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${(file['size'] / 1024).toStringAsFixed(1)} KB',
                              style: TextStyle(fontSize: 10, color: lightText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Action buttons row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onView(file),
                          icon: Icon(Icons.visibility, size: 16),
                          label: Text('View'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            foregroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onReplace(index),
                          icon: Icon(Icons.refresh, size: 16),
                          label: Text('Replace'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.orange),
                            foregroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onRemove(index),
                          icon: Icon(Icons.delete, size: 16),
                          label: Text('Remove'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            foregroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onEditToggle,
                child: Text('Done', style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
        ] else ...[
          // View mode - show file list
          if (files.isNotEmpty)
            ...files.map((file) => GestureDetector(
              onTap: () => onView(file),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getFileIcon(file['name'] ?? ''),
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file['name'] ?? 'File',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: darkText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(file['size'] / 1024).toStringAsFixed(1)} KB',
                            style: TextStyle(fontSize: 10, color: lightText),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: lightText,
                    ),
                  ],
                ),
              ),
            ))
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No files uploaded. Tap Edit to add.',
                      style: TextStyle(fontSize: 12, color: lightText),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Future<void> _replaceMediaFile(String mediaKey, int index, String mediaName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Validate file size (max 10MB for videos, 5MB for images)
        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog(
            'File too large',
            'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB',
          );
          return;
        }

        // Validate file type for videos
        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List)[index] = fileInfo;
            }
            _data['media'] = media;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$mediaName replaced successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog('Replace Error', 'Failed to replace file: ${e.toString()}');
    }
  }



  IconData _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icons.image;
    } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
      return Icons.video_file;
    } else if (['pdf'].contains(ext)) {
      return Icons.picture_as_pdf;
    } else {
      return Icons.insert_drive_file;
    }
  }



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

  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue = value.toString();

    if (label.contains('Year') || label.contains('Rooms') || label.contains('Bathrooms') ||
        label == 'Bedrooms' || label == 'Guest Capacity') {
      displayValue = _formatInteger(value);
    } else if (label.contains('Price') || label.contains('Deposit') || label == 'Base Price' ||
        label == 'Weekend Price' || label == 'Peak Season Price') {
      displayValue = '₹${_formatPrice(value)}';
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
              style: TextStyle(fontSize: 13, color: lightText, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              displayValue,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

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
              style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '₹${_formatPrice(value)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      String key = label.toLowerCase().replaceAll(' ', '_');
                      _priceEditModes[key] = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, size: 12, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildEditableDocumentItem({
    required String docName,
    required String docType,
    required Map<String, dynamic> fileInfo,
  }) {
    bool isUploaded = fileInfo['uploaded'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUploaded ? primaryColor.withOpacity(0.3) : borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with document name (No edit button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                docName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
              // No edit button for documents
              Container(),
            ],
          ),
          const SizedBox(height: 8),

          // View mode - show document info (View Only)
          if (isUploaded)
            GestureDetector(
              onTap: () => _viewDocument(fileInfo, docName),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getFileIcon(fileInfo['name'] ?? ''),
                        size: 20,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileInfo['name'] ?? 'Document',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: darkText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB',
                            style: TextStyle(fontSize: 10, color: lightText),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: lightText,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.file_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No file uploaded',
                      style: TextStyle(fontSize: 12, color: lightText),
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

class LoginScreen1 extends StatelessWidget  {
  final String? removedVillaId;
  final String? userEmail;

  const LoginScreen1({
    Key? key,
    this.removedVillaId,
    this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00897B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.villa,
                size: 80,
                color: Color(0xFF00897B),
              ),
              const SizedBox(height: 24),
              const Text(
                'Villa Removed Successfully',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The selected villa has been removed from your list.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VillaListScreen(
                          userData: {},
                          userEmail: userEmail ?? '',
                          removedVillaId: removedVillaId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back to Villa List',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApartmentRegistrationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  final String? apartmentId;
  final int apartmentIndex;

  const ApartmentRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
    this.apartmentId,
    required this.apartmentIndex,
  }) : super(key: key);

  @override
  State<ApartmentRegistrationDetailsScreen> createState() => _ApartmentRegistrationDetailsScreenState();
}

class _ApartmentRegistrationDetailsScreenState extends State<ApartmentRegistrationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  late Map<String, bool> _apartmentAmenities;
  late List<String> _customAmenities;
  Map<String, bool> _editModes = {};

  bool _isEditingPhone = false;
  late TextEditingController _phoneController;
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;

  late Map<String, bool> _priceEditModes;
  late String _checkInTime;
  late String _checkOutTime;
  late Map<String, bool> _mediaEditModes;
  late Map<String, int> _mediaMaxLimits;
////
  late Map<String, bool> _documentEditModes;

  final Color primaryColor = const Color(0xFF5C6BC0);
  final Color primaryLight = const Color(0xFF5C6BC0).withOpacity(0.1);
  final Color primarySoft = const Color(0xFF5C6BC0).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFF5C6BC0).withOpacity(0.03);
  final Color _successColor = const Color(0xFF10B981);
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
    _tabController = TabController(length: 7, vsync: this);

    _phoneController = TextEditingController(text: _getUserPhone());
    _checkInController = TextEditingController(text: _getCheckInTime());
    _checkOutController = TextEditingController(text: _getCheckOutTime());
    print('=== INIT STATE DATA ===');
    print('_data keys: ${_data.keys.toList()}');
    if (_data.containsKey('location')) {
      final location = _data['location'];
      if (location is Map) {
        print('location keys: ${location.keys.toList()}');
        if (location.containsKey('officeAddress')) {
          print('officeAddress exists in location');
          final office = location['officeAddress'];
          if (office is Map) {
            print('officeAddress keys: ${office.keys.toList()}');
          }
        }
      }
    }
    _initializeTimes();
    _priceEditModes = {};
    _initializeAmenities();
    _debugPrintData();
    _debugBHKData();
  }

  void _debugBHKData() {
    print('=== DEBUG BHK DATA ===');
    final propertyDetails = _data['propertyDetails'] as Map?;
    if (propertyDetails != null) {
      print('propertyDetails keys: ${propertyDetails.keys.toList()}');
      final bhkDetails = propertyDetails['bhkDetails'];
      print('bhkDetails: $bhkDetails');
      print('bhkDetails type: ${bhkDetails.runtimeType}');
      if (bhkDetails is List) {
        print('bhkDetails length: ${bhkDetails.length}');
        for (var i = 0; i < bhkDetails.length; i++) {
          print('bhkDetails[$i]: ${bhkDetails[i]}');
        }
      }
    } else {
      print('propertyDetails is null');
      print('_data keys: ${_data.keys.toList()}');
    }
  }

  void _debugPrintData() {
    print('=== APARTMENT DETAILS SCREEN DATA ===');
    print('Data keys: ${_data.keys.toList()}');
    print('Virtual Tour Link: ${_getVirtualTourLink()}');
    print('Media: ${_data['media']}');
  }

  void _initializeTimes() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    _checkInTime = _data['checkInTime']?.toString() ??
        pricingData['checkInTime']?.toString() ??
        '12:00';
    _checkInController = TextEditingController(text: _checkInTime);

    _checkOutTime = _data['checkOutTime']?.toString() ??
        pricingData['checkOutTime']?.toString() ??
        '11:00';
    _checkOutController = TextEditingController(text: _checkOutTime);
  }

  void _autoSaveTimes() {
    _data['checkInTime'] = _checkInTime;
    _data['checkOutTime'] = _checkOutTime;

    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      final pricing = _data['pricing'] as Map;
      pricing['checkInTime'] = _checkInTime;
      pricing['checkOutTime'] = _checkOutTime;
      _data['pricing'] = pricing;
    }
  }

  void _initializeAmenities() {
    _editModes = {
      'amenities': false,
      'custom': false,
    };

    _priceEditModes = {
      'basePrice': false,
      'weekendPrice': false,
      'peakPrice': false,
      'securityDeposit': false,
      'minimumStay': false,
    };

    _documentEditModes = {
      'ownershipProof': false,
      'idProof': false,
      'cancellationPolicy': false,
      'availabilityCalendar': false,
      'cancelledCheque': false,
    };

    _mediaEditModes = {
      'exterior': false,
      'interior': false,
      'bedroom': false,
      'bathroom': false,
      'amenities': false,
      'short_video': false,
    };

    _mediaMaxLimits = {
      'exterior': 2,
      'interior': 2,
      'bedroom': 1,
      'bathroom': 1,
      'amenities': 5,
      'short_video': 1,
    };

    if (_data['selectedAmenities'] != null && _data['selectedAmenities'] is Map) {
      _apartmentAmenities = Map<String, bool>.from(_data['selectedAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['selected'] is Map) {
      _apartmentAmenities = Map<String, bool>.from(_data['amenities']['selected']);
    } else {
      _apartmentAmenities = {
        'WiFi': false,
        'Air Conditioning': false,
        'Kitchen': false,
        'Refrigerator': false,
        'Microwave': false,
        'TV': false,
        'Washing Machine': false,
        'Parking': false,
        'Power Backup': false,
        '24/7 Security': false,
        'CCTV': false,
        'Housekeeping': false,
        'Geyser': false,
        'Balcony': false,
        'Gym': false,
        'Swimming Pool': false,
        'Pet Friendly': false,
        'Smoking Allowed': false,
      };
    }

    if (_data['customAmenities'] != null && _data['customAmenities'] is List) {
      _customAmenities = List<String>.from(_data['customAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['custom'] is List) {
      _customAmenities = List<String>.from(_data['amenities']['custom']);
    } else {
      _customAmenities = [];
    }
  }

  void _autoSaveAmenities() {
    _data['selectedAmenities'] = Map<String, bool>.from(_apartmentAmenities);
    _data['customAmenities'] = List<String>.from(_customAmenities);
  }


  String _getFloorNumber() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('floorNumber') && details['floorNumber'].toString().isNotEmpty) {
        return details['floorNumber'].toString();
      }
    }
    return _data['floorNumber']?.toString() ?? '';
  }

  String _getTotalFloors() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('totalFloors') && details['totalFloors'].toString().isNotEmpty) {
        return details['totalFloors'].toString();
      }
    }
    return _data['totalFloors']?.toString() ?? '';
  }

  String _getWeeklyPrice() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['weeklyPrice']?.toString() ?? pricingData['weeklyPrice']?.toString() ?? '';
  }

  String _getMonthlyPrice() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['monthlyPrice']?.toString() ?? pricingData['monthlyPrice']?.toString() ?? '';
  }

  String _getAdvancePayment() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['advancePayment']?.toString() ?? pricingData['advancePayment']?.toString() ?? '';
  }

  DateTime? _getAvailableFromDate() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      if (availability.containsKey('availableFromDate') && availability['availableFromDate'] != null) {
        if (availability['availableFromDate'] is DateTime) {
          return availability['availableFromDate'] as DateTime;
        } else if (availability['availableFromDate'] is String) {
          try {
            return DateTime.parse(availability['availableFromDate'].toString());
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  String _getBlackoutDates() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['blackoutDates']?.toString() ?? '';
    }
    return _data['blackoutDates']?.toString() ?? '';
  }

  String _getInstantBooking() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['instantBooking']?.toString() ?? 'No';
    }
    return _data['instantBooking']?.toString() ?? 'No';
  }

  String _getPoliceVerification() {
    if (_data.containsKey('legal') && _data['legal'] != null) {
      final legal = _data['legal'] as Map;
      return legal['policeVerification']?.toString() ?? '';
    }
    return _data['policeVerification']?.toString() ?? '';
  }

  Map<String, dynamic> _getCalendarSync() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      if (availability.containsKey('calendarSync') && availability['calendarSync'] is Map) {
        return Map<String, dynamic>.from(availability['calendarSync']);
      }
    }
    return _data['calendarSync'] ?? {'uploaded': false};
  }

  String _getCheckInTime() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['checkInTime']?.toString() ?? pricingData['checkInTime']?.toString() ?? '12:00';
  }

  String _getCheckOutTime() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['checkOutTime']?.toString() ?? pricingData['checkOutTime']?.toString() ?? '11:00';
  }

  String _getApartmentName() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('apartmentName') && basicInfo['apartmentName'].toString().isNotEmpty) {
        return basicInfo['apartmentName'].toString();
      }
    }
    return _data['apartmentName']?.toString() ?? 'Apartment';
  }

  String _getPropertyType() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('propertyType') && details['propertyType'].toString().isNotEmpty) {
        return details['propertyType'].toString();
      }
    }
    if (_data.containsKey('propertyTypeValue') && _data['propertyTypeValue'].toString().isNotEmpty) {
      return _data['propertyTypeValue'].toString();
    }
    if (_data.containsKey('propertyType') && _data['propertyType'].toString().isNotEmpty) {
      return _data['propertyType'].toString();
    }
    return 'Service Apartment';
  }

  String _getUserFullName() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName') && basicInfo['ownerName'].toString().isNotEmpty) {
        return basicInfo['ownerName'].toString();
      }
      if (basicInfo.containsKey('fullName') && basicInfo['fullName'].toString().isNotEmpty) {
        return basicInfo['fullName'].toString();
      }
    }
    if (_data.containsKey('fullName') && _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') && _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('email') && basicInfo['email'].toString().isNotEmpty) {
        return basicInfo['email'].toString();
      }
    }
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('mobile') && basicInfo['mobile'].toString().isNotEmpty) {
        return basicInfo['mobile'].toString();
      }
      if (basicInfo.containsKey('phone') && basicInfo['phone'].toString().isNotEmpty) {
        return basicInfo['phone'].toString();
      }
    }
    return _data['phone']?.toString() ?? _data['mobile']?.toString() ?? 'Not provided';
  }

  String _getAlternateMobile() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('altMobile') && basicInfo['altMobile'].toString().isNotEmpty) {
        return basicInfo['altMobile'].toString();
      }
    }
    return _data['altMobile']?.toString() ?? '';
  }

  String _getWebsite() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('website') && basicInfo['website'].toString().isNotEmpty) {
        return basicInfo['website'].toString();
      }
    }
    return _data['website']?.toString() ?? '';
  }

  String _getAddress() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('address') && location['address'].toString().isNotEmpty) {
        return location['address'].toString();
      }
    }
    return _data['address']?.toString() ?? 'Not provided';
  }

  String _getArea() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('area') && location['area'].toString().isNotEmpty) {
        return location['area'].toString();
      }
    }
    return _data['area']?.toString() ?? '';
  }

  String _getCity() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('city') && location['city'].toString().isNotEmpty) {
        return location['city'].toString();
      }
    }
    return _data['city']?.toString() ?? 'Not provided';
  }

  String _getState() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('state') && location['state'].toString().isNotEmpty) {
        return location['state'].toString();
      }
    }
    return _data['state']?.toString() ?? 'Not provided';
  }

  String _getPincode() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('pincode') && location['pincode'].toString().isNotEmpty) {
        return location['pincode'].toString();
      }
    }
    return _data['pincode']?.toString() ?? 'Not provided';
  }



  String _getOfficeAddress() {
    // Debug print to see what's in _data
    print('=== _getOfficeAddress DEBUG ===');
    print('_data keys: ${_data.keys.toList()}');

    // Check if location exists
    if (_data.containsKey('location')) {
      final location = _data['location'];
      print('location type: ${location.runtimeType}');

      if (location is Map) {
        print('location keys: ${location.keys.toList()}');

        // Check for officeAddress inside location
        if (location.containsKey('officeAddress')) {
          final office = location['officeAddress'];
          print('officeAddress type: ${office.runtimeType}');

          if (office is Map) {
            print('office keys: ${office.keys.toList()}');
            if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
              print('Found office address: ${office['address']}');
              return office['address'].toString();
            }
          }
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map) {
        if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
          print('Found office address in direct officeAddress: ${office['address']}');
          return office['address'].toString();
        }
      }
    }

    // Check in basicInfo.officeAddress
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'];
      if (basicInfo is Map) {
        if (basicInfo.containsKey('officeAddress') && basicInfo['officeAddress'] != null) {
          final office = basicInfo['officeAddress'];
          if (office is Map) {
            if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
              print('Found office address in basicInfo.officeAddress: ${office['address']}');
              return office['address'].toString();
            }
          }
        }
      }
    }

    print('No office address found anywhere');
    return 'Not provided';
  }

  String _getOfficeArea() {
    // Check in location.officeAddress
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'];
      if (location is Map && location.containsKey('officeAddress')) {
        final office = location['officeAddress'];
        if (office is Map && office.containsKey('area') && office['area'].toString().isNotEmpty) {
          return office['area'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map && office.containsKey('area') && office['area'].toString().isNotEmpty) {
        return office['area'].toString();
      }
    }

    return '';
  }

  String _getOfficeCity() {
    // Check in location.officeAddress
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'];
      if (location is Map && location.containsKey('officeAddress')) {
        final office = location['officeAddress'];
        if (office is Map && office.containsKey('city') && office['city'].toString().isNotEmpty) {
          return office['city'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map && office.containsKey('city') && office['city'].toString().isNotEmpty) {
        return office['city'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeState() {
    // Check in location.officeAddress
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'];
      if (location is Map && location.containsKey('officeAddress')) {
        final office = location['officeAddress'];
        if (office is Map && office.containsKey('state') && office['state'].toString().isNotEmpty) {
          return office['state'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map && office.containsKey('state') && office['state'].toString().isNotEmpty) {
        return office['state'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficePincode() {
    // Check in location.officeAddress
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'];
      if (location is Map && location.containsKey('officeAddress')) {
        final office = location['officeAddress'];
        if (office is Map && office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
          return office['pincode'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map && office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
        return office['pincode'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeGoogleMapLink() {
    // Check in location.officeAddress
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'];
      if (location is Map && location.containsKey('officeAddress')) {
        final office = location['officeAddress'];
        if (office is Map && office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
          return office['googleMapLink'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'];
      if (office is Map && office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
        return office['googleMapLink'].toString();
      }
    }

    return '';
  }

  Widget _buildOfficeGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getOfficeGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  String _getGoogleMapLink() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('googleMapLink') && location['googleMapLink'].toString().isNotEmpty) {
        return location['googleMapLink'].toString();
      }
    }
    return _data['googleMapLink']?.toString() ?? '';
  }

  String _getTotalUnits() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('totalUnits') && details['totalUnits'].toString().isNotEmpty) {
        return details['totalUnits'].toString();
      }
    }
    return _data['totalUnits']?.toString() ?? '0';
  }

  String _getTotalBedrooms() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('totalBedrooms') && details['totalBedrooms'].toString().isNotEmpty) {
        return details['totalBedrooms'].toString();
      }
    }
    return _data['totalBedrooms']?.toString() ?? '0';
  }

  String _getTotalBathrooms() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('totalBathrooms') && details['totalBathrooms'].toString().isNotEmpty) {
        return details['totalBathrooms'].toString();
      }
    }
    return _data['totalBathrooms']?.toString() ?? '0';
  }

  String _getGuestCapacity() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('guestCapacity') && details['guestCapacity'].toString().isNotEmpty) {
        return details['guestCapacity'].toString();
      }
    }
    return _data['guestCapacity']?.toString() ?? '0';
  }

  String _getPropertySize() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('propertySize') && details['propertySize'].toString().isNotEmpty) {
        return details['propertySize'].toString();
      }
    }
    return _data['propertySize']?.toString() ?? '';
  }

  String _getYearConstruction() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('yearConstruction') && details['yearConstruction'].toString().isNotEmpty) {
        return details['yearConstruction'].toString();
      }
    }
    return _data['yearConstruction']?.toString() ?? '';
  }

  String _getElevatorAvailable() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('elevatorAvailable') && details['elevatorAvailable'].toString().isNotEmpty) {
        return details['elevatorAvailable'].toString();
      }
    }
    return _data['elevatorAvailable']?.toString() ?? 'No';
  }

  String _getDescription() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('description') && details['description'].toString().isNotEmpty) {
        return details['description'].toString();
      }
    }
    return _data['description']?.toString() ?? '';
  }

  String _getVirtualTourLink() {
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      if (media.containsKey('virtual_tour')) {
        final tour = media['virtual_tour'];
        if (tour is String && tour.isNotEmpty) return tour;
        if (tour is List && tour.isNotEmpty && tour[0] is Map) {
          return tour[0]['path']?.toString() ?? '';
        }
      }
    }
    return _data['virtualTourLink']?.toString() ?? '';
  }

  dynamic _getPriceValue(String key) {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data[key] ?? pricingData[key];
  }

  dynamic _get(String key, [dynamic defaultValue]) {
    try {
      final keys = key.split('.');
      dynamic value = _data;

      for (final k in keys) {
        if (value is Map) {
          value = value[k];
        } else {
          return defaultValue;
        }
      }
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  Map<String, dynamic> _getDocumentInfo(String key) {
    Map<String, dynamic> legalData = {};
    Map<String, dynamic> pricingData = {};
    Map<String, dynamic> bankData = {};

    if (_data.containsKey('legal') && _data['legal'] is Map) {
      legalData = Map<String, dynamic>.from(_data['legal']);
    }
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    if (_data.containsKey('bank') && _data['bank'] is Map) {
      bankData = Map<String, dynamic>.from(_data['bank']);
    }

    if (key == 'ownershipProof') return _data['ownershipProof'] ?? legalData['ownershipProof'] ?? {'uploaded': false};
    if (key == 'idProof') return _data['idProof'] ?? legalData['idProof'] ?? {'uploaded': false};
    if (key == 'cancellationPolicy') return _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};
    if (key == 'availabilityCalendar') return _data['availabilityCalendar'] ?? pricingData['availabilityCalendar'] ?? {'uploaded': false};
    if (key == 'cancelledCheque') return _data['cancelledCheque'] ?? bankData['cancelledCheque'] ?? {'uploaded': false};

    return {'uploaded': false};
  }

  List<Map<String, dynamic>> _getMediaFiles(String mediaKey) {
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      if (media.containsKey(mediaKey) && media[mediaKey] is List) {
        return List<Map<String, dynamic>>.from(media[mediaKey]);
      }
    }
    return [];
  }

  void _savePhoneChanges() {
    setState(() {
      if (_data.containsKey('phone')) _data['phone'] = _phoneController.text;
      if (_data.containsKey('mobile')) _data['mobile'] = _phoneController.text;
      if (_data.containsKey('basicInfo')) {
        final basicInfo = _data['basicInfo'] as Map;
        basicInfo['mobile'] = _phoneController.text;
        _data['basicInfo'] = basicInfo;
      }
      _isEditingPhone = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number updated successfully'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickAndUploadPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Choose Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: primaryColor),
                  ),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: primaryColor),
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _data['ownerPhoto'] = {
            'uploaded': true,
            'name': image.name,
            'path': image.path,
          };
          if (_data.containsKey('basicInfo')) {
            final basicInfo = _data['basicInfo'] as Map;
            basicInfo['ownerPhoto'] = {
              'uploaded': true,
              'name': image.name,
              'path': image.path,
            };
            _data['basicInfo'] = basicInfo;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo uploaded successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _uploadMediaFile(String mediaKey, String mediaName, int maxLimit) async {
    try {
      final currentFiles = _getMediaFiles(mediaKey);
      if (currentFiles.length >= maxLimit) {
        _showErrorDialog('Maximum Limit Reached', 'You can only upload up to $maxLimit $mediaName.');
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog('File too large', 'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB');
          return;
        }

        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).add(fileInfo);
            } else {
              media[mediaKey] = [fileInfo];
            }
            _data['media'] = media;
          } else {
            _data['media'] = {mediaKey: [fileInfo]};
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName uploaded successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      _showErrorDialog('Upload Error', 'Failed to upload file: ${e.toString()}');
    }
  }

  Future<void> _replaceMediaFile(String mediaKey, int index, String mediaName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog('File too large', 'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB');
          return;
        }

        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List)[index] = fileInfo;
            }
            _data['media'] = media;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName replaced successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      _showErrorDialog('Replace Error', 'Failed to replace file: ${e.toString()}');
    }
  }

  void _viewMediaFile(Map<String, dynamic> file, String mediaName) {
    if (file['path'] != null && file['path'].isNotEmpty) {
      final fileName = file['name'] ?? 'File';
      final filePath = file['path'];
      final ext = fileName.split('.').last.toLowerCase();

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mediaName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: Image.file(File(filePath), fit: BoxFit.contain)),
                ],
              ),
            ),
          ),
        );
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mediaName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: VideoPlayerWidget(filePath: filePath)),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(mediaName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getFileIcon(fileName), size: 48, color: primaryColor),
                SizedBox(height: 16),
                Text(fileName, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text('Size: ${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 12, color: lightText)),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
          ),
        );
      }
    }
  }

  void _removeMediaFile(String mediaKey, int index, String mediaName) {
    _showConfirmationDialog(
      'Remove File',
      'Are you sure you want to remove this $mediaName?',
          () {
        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).removeAt(index);
              _data['media'] = media;
            }
          }
          _mediaEditModes[mediaKey] = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName removed successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      },
    );
  }

  Future<void> _uploadNewDocument(String docType, String docName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          _showErrorDialog('File too large', 'Please select a file smaller than 5MB');
          return;
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          switch (docType) {
            case 'ownershipProof':
              _data['ownershipProof'] = fileInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['ownershipProof'] = fileInfo;
              }
              break;
            case 'idProof':
              _data['idProof'] = fileInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['idProof'] = fileInfo;
              }
              break;
            case 'cancellationPolicy':
              _data['cancellationPolicy'] = fileInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['cancellationPolicy'] = fileInfo;
              }
              break;
            case 'availabilityCalendar':
              _data['availabilityCalendar'] = fileInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['availabilityCalendar'] = fileInfo;
              }
              break;
            case 'cancelledCheque':
              _data['cancelledCheque'] = fileInfo;
              if (_data.containsKey('bank') && _data['bank'] is Map) {
                (_data['bank'] as Map)['cancelledCheque'] = fileInfo;
              }
              break;
          }
          _documentEditModes[docType] = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$docName uploaded successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      _showErrorDialog('Upload Error', 'Failed to upload file: ${e.toString()}');
    }
  }

  void _viewDocument(Map<String, dynamic> fileInfo, String docName) {
    if (fileInfo['path'] != null && fileInfo['path'].isNotEmpty) {
      final fileName = fileInfo['name'] ?? 'Document';
      final filePath = fileInfo['path'];
      final ext = fileName.split('.').last.toLowerCase();

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(docName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: Image.file(File(filePath), fit: BoxFit.contain)),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(docName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getFileIcon(fileName), size: 48, color: primaryColor),
                SizedBox(height: 16),
                Text(fileName, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text('Size: ${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 12, color: lightText)),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
          ),
        );
      }
    }
  }

  void _removeDocument(String docType, String docName) {
    _showConfirmationDialog(
      'Remove Document',
      'Are you sure you want to remove $docName?',
          () {
        setState(() {
          Map<String, dynamic> emptyInfo = {'name': '', 'size': 0, 'path': '', 'uploaded': false};

          switch (docType) {
            case 'ownershipProof':
              _data['ownershipProof'] = emptyInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['ownershipProof'] = emptyInfo;
              }
              break;
            case 'idProof':
              _data['idProof'] = emptyInfo;
              if (_data.containsKey('legal') && _data['legal'] is Map) {
                (_data['legal'] as Map)['idProof'] = emptyInfo;
              }
              break;
            case 'cancellationPolicy':
              _data['cancellationPolicy'] = emptyInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['cancellationPolicy'] = emptyInfo;
              }
              break;
            case 'availabilityCalendar':
              _data['availabilityCalendar'] = emptyInfo;
              if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                (_data['pricing'] as Map)['availabilityCalendar'] = emptyInfo;
              }
              break;
            case 'cancelledCheque':
              _data['cancelledCheque'] = emptyInfo;
              if (_data.containsKey('bank') && _data['bank'] is Map) {
                (_data['bank'] as Map)['cancelledCheque'] = emptyInfo;
              }
              break;
          }
          _documentEditModes[docType] = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$docName removed successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      },
    );
  }

  String _getRegistrationId() {
    final apartmentName = _getApartmentName();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final namePrefix = apartmentName.length >= 3 ? apartmentName.substring(0, 3).toUpperCase() : apartmentName.toUpperCase();
    return 'APT-$namePrefix-$timestamp';
  }

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
    if (value is double) return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      return value;
    }
    return value.toString();
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num) return true;
    if (value is Map) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;
    if (value is bool) return true;
    return true;
  }

  IconData _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) return Icons.image;
    if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) return Icons.video_file;
    if (['pdf'].contains(ext)) return Icons.picture_as_pdf;
    return Icons.insert_drive_file;
  }

  void _showConfirmationDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () { Navigator.pop(context); onConfirm(); }, child: Text('Confirm', style: TextStyle(color: Colors.red))),
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
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog('Error', 'Could not launch URL');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Are you sure you want to logout?', style: TextStyle(fontSize: 16)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showLogoutPurposeDialog(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Yes, Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutPurposeDialog(BuildContext context) {
    final List<String> purposes = [
      'Technical Issue',
      'User Interface Issue',
      'Found Better Alternative',
      'Not Satisfied with Service',
      'Security Concerns',
      'Account Management',
      'Other',
    ];

    String? selectedPurpose;
    String? customPurpose;
    TextEditingController customController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Reason for Logout', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Please help us improve by sharing your reason for leaving:', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 16),
                      ...purposes.map((purpose) => RadioListTile<String>(
                        title: Text(purpose),
                        value: purpose,
                        groupValue: selectedPurpose,
                        onChanged: (value) { setState(() { selectedPurpose = value; if (value != 'Other') customPurpose = null; }); },
                        activeColor: primaryColor,
                        contentPadding: EdgeInsets.zero,
                      )),
                      if (selectedPurpose == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: 'Please specify...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            onChanged: (value) { customPurpose = value; },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Back', style: TextStyle(color: Colors.grey[600]))),
                ElevatedButton(
                  onPressed: () {
                    final reason = selectedPurpose == 'Other' ? customPurpose : selectedPurpose;
                    if (reason != null && reason.isNotEmpty) {
                      Navigator.pop(context);
                      _showFeedbackDialog(context, reason);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a reason'), backgroundColor: Colors.red));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Continue', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context, String reason) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Feedback Matters!', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Reason: $reason', style: TextStyle(fontSize: 13, color: darkText, fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Any additional feedback?', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Your feedback helps us improve...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () { Navigator.pop(context); _showFinalLogoutConfirmation(context, reason, feedbackController.text); }, child: Text('Skip', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () { Navigator.pop(context); _showFinalLogoutConfirmation(context, reason, feedbackController.text); },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Submit & Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showFinalLogoutConfirmation(BuildContext context, String reason, String feedback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Final Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text('Are you absolutely sure you want to logout and remove this apartment?', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text('Apartment: ${_getApartmentName()}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('This apartment will be removed from your list.', style: TextStyle(fontSize: 12, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () async {
                await _saveLogoutFeedback(reason, feedback);
                await _removeCurrentApartmentFromList();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ApartmentListScreen(
                    userData: widget.registrationData,
                    removedApartmentId: widget.apartmentId ?? _data['id'],
                    userEmail: _getUserEmail(),
                  )),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Logout & Remove Apartment', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveLogoutFeedback(String reason, String feedback) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> feedbackList = prefs.getStringList('logout_feedback') ?? [];

      final feedbackEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'reason': reason,
        'feedback': feedback,
        'userEmail': _getUserEmail(),
        'apartmentName': _getApartmentName(),
        'apartmentId': widget.apartmentId ?? _data['id'],
        'action': 'remove_apartment',
      };

      feedbackList.add(jsonEncode(feedbackEntry));
      await prefs.setStringList('logout_feedback', feedbackList);
    } catch (e) {
      print('Error saving feedback: $e');
    }
  }

  Future<void> _removeCurrentApartmentFromList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String userEmail = _getUserEmail();
      final String apartmentIdToRemove = widget.apartmentId ?? _data['id'];

      final String? userDataString = prefs.getString('user_${userEmail}_data');

      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);

        if (userData.containsKey('apartments') && userData['apartments'] is List) {
          List<dynamic> apartmentsList = userData['apartments'];
          apartmentsList.removeWhere((apartment) {
            Map<String, dynamic> apartmentMap = Map<String, dynamic>.from(apartment);
            return apartmentMap['id']?.toString() == apartmentIdToRemove;
          });
          userData['apartments'] = apartmentsList;
          await prefs.setString('user_${userEmail}_data', jsonEncode(userData));
        } else {
          await prefs.remove('user_${userEmail}_data');
        }
      }
    } catch (e) {
      print('Error removing apartment: $e');
    }
  }

  Widget _getOwnerPhotoWidget() {
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) {
        ownerPhoto = basicInfo['ownerPhoto'];
      }
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) {
      ownerPhoto = _data['ownerPhoto'];
    }

    if (ownerPhoto != null && ownerPhoto['path'] != null) {
      return Image.file(File(ownerPhoto['path']), fit: BoxFit.cover, width: 60, height: 60);
    }

    return Center(child: Icon(Icons.person_rounded, size: 35, color: primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
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
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(child: Icon(Icons.apartment, color: Colors.white, size: 32)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getApartmentName(),
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _getPropertyType(),
                                          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.qr_code, size: 14, color: Colors.white.withOpacity(0.7)),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500),
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
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              GestureDetector(
                onTap: () => _showLogoutConfirmationDialog(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.logout, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
                        BoxShadow(color: primaryColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(18)),
                                  child: ClipRRect(borderRadius: BorderRadius.circular(18), child: _getOwnerPhotoWidget()),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickAndUploadPhoto,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                  child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(child: _buildInfoChip(icon: Icons.phone_outlined, value: _getUserPhone())),
                                  const SizedBox(width: 8),
                                  Expanded(child: _buildInfoChip(icon: Icons.email_outlined, value: _getUserEmail())),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      boxShadow: [BoxShadow(color: shadowColor, blurRadius: 10, offset: const Offset(0, -2))],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Location'),
                        Tab(text: 'Property Details'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Pricing & Policies'),
                        Tab(text: 'Media & Virtual Tour'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildBasicInfo(),
                        _buildLocation(),
                        _buildPropertyDetails(),
                        _buildAmenities(),
                        _buildPricingPolicies(),
                        _buildMediaAndVirtualTour(),
                        _buildLegalBank(),
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
                style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditablePhoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(color: primaryMedium, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Mobile Number', style: TextStyle(fontSize: 13, color: lightText, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: TextStyle(fontSize: 13, color: lightText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue = value.toString();
    if (label.contains('Price') || label.contains('Deposit') || label == 'Base Price' || label == 'Weekend Price' || label == 'Peak Season Price') {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Units') || label.contains('Rooms') || label.contains('Bathrooms') || label == 'Bedrooms' || label == 'Guest Capacity') {
      displayValue = _formatInteger(value);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: primaryMedium, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.05))),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: lightText, fontWeight: FontWeight.w500))),
          Expanded(flex: 4, child: Text(displayValue, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.15))),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500))),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('₹${_formatPrice(value)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      String key = label.toLowerCase().replaceAll(' ', '_');
                      _priceEditModes[key] = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(Icons.edit, size: 12, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required String title, required IconData icon, required List<Widget> children}) {
    final filteredChildren = children.where((child) => child is Widget && child is! SizedBox).toList();
    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
          BoxShadow(color: primaryColor.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)), child: Icon(icon, size: 18, color: primaryColor)),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Apartment Information',
            icon: Icons.apartment,
            children: [
              _buildInfoRow('Apartment Name', _getApartmentName()),
              _buildInfoRow('Property Type', _getPropertyType()),
              // _buildInfoRow('Total Units', _getTotalUnits()),
              // _buildInfoRow('Bedrooms', _getTotalBedrooms()),
              // _buildInfoRow('Bathrooms', _getTotalBathrooms()),
              // _buildInfoRow('Guest Capacity', '${_getGuestCapacity()} guests'),
              // if (_getPropertySize().isNotEmpty) _buildInfoRow('Property Size', '${_getPropertySize()} sq.ft.'),
              if (_getYearConstruction().isNotEmpty) _buildInfoRow('Year Built', _getYearConstruction()),
              // _buildInfoRow('Elevator Available', _getElevatorAvailable()),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
                BoxShadow(color: primaryColor.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)), child: Icon(Icons.contact_phone, size: 18, color: primaryColor)),
                        const SizedBox(width: 12),
                        Text('Contact Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                      ],
                    ),
                    if (!_isEditingPhone)
                      GestureDetector(
                        onTap: () { setState(() { _isEditingPhone = true; _phoneController.text = _getUserPhone(); }); },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(20), border: Border.all(color: primaryColor.withOpacity(0.2))),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.edit, size: 14, color: primaryColor),
                            const SizedBox(width: 4),
                            Text('Edit Phone', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                          ]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Owner/Manager', _getUserFullName()),
                if (_isEditingPhone) _buildEditablePhoneField() else _buildInfoRow('Mobile Number', _getUserPhone()),
                if (_getAlternateMobile().isNotEmpty && !_isEditingPhone) _buildInfoRow('Alternate Mobile', _getAlternateMobile()),
                if (_isEditingPhone)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () { setState(() { _isEditingPhone = false; _phoneController.text = _getUserPhone(); }); }, child: Text('Cancel', style: TextStyle(color: lightText))),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _savePhoneChanges,
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                _buildInfoRow('Email', _getUserEmail()),
                if (_getWebsite().isNotEmpty) _buildInfoRow('Website', _getWebsite()),
              ],
            ),
          ),
          if (_getOwnerPhotoWidget() is Image) Padding(padding: const EdgeInsets.only(top: 16), child: _buildPhotoTile()),
        ],
      ),
    );
  }

  Widget _buildPhotoTile() {
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) ownerPhoto = basicInfo['ownerPhoto'];
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) ownerPhoto = _data['ownerPhoto'];

    if (ownerPhoto == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]), borderRadius: BorderRadius.circular(14)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ownerPhoto['path'] != null ? Image.file(File(ownerPhoto['path']), fit: BoxFit.cover) : const Center(child: Icon(Icons.photo_camera, color: Colors.white, size: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profile Photo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(ownerPhoto['name'] ?? 'Uploaded successfully', style: TextStyle(fontSize: 12, color: lightText), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.check_circle, size: 18, color: primaryColor)),
        ],
      ),
    );
  }

  // Widget _buildLocation() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Apartment Location Details',
  //           icon: Icons.location_on,
  //           children: [
  //             _buildInfoRow('Apartment Address', _getAddress()),
  //             if (_getArea().isNotEmpty) _buildInfoRow('Area / Locality', _getArea()),
  //             _buildInfoRow('City', _getCity()),
  //             _buildInfoRow('State', _getState()),
  //             _buildInfoRow('Pincode', _getPincode()),
  //             if (_getGoogleMapLink().isNotEmpty)
  //               Container(
  //                 margin: const EdgeInsets.only(bottom: 12),
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.2))),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.map, size: 18, color: primaryColor),
  //                     const SizedBox(width: 8),
  //                     Expanded(child: Text(_getGoogleMapLink(), style: TextStyle(fontSize: 12, color: darkText), maxLines: 2, overflow: TextOverflow.ellipsis)),
  //                   ],
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLocation() {
    final officeAddressChildren = <Widget>[];

    // Debug prints
    print('=== BUILDING APARTMENT LOCATION SECTION ===');
    print('Office Address: ${_getOfficeAddress()}');
    print('Office Area: ${_getOfficeArea()}');
    print('Office City: ${_getOfficeCity()}');
    print('Office State: ${_getOfficeState()}');
    print('Office Pincode: ${_getOfficePincode()}');
    print('Office GoogleMap: ${_getOfficeGoogleMapLink()}');

    // Build office address section only if there's data
    if (_getOfficeAddress() != 'Not provided' ||
        _getOfficeArea().isNotEmpty ||
        _getOfficeCity() != 'Not provided' ||
        _getOfficeGoogleMapLink().isNotEmpty) {
      officeAddressChildren.addAll([
        _buildInfoRow('Office Address', _getOfficeAddress()),
        if (_getOfficeArea().isNotEmpty)
          _buildInfoRow('Area / Locality', _getOfficeArea()),
        _buildInfoRow('City', _getOfficeCity()),
        _buildInfoRow('State', _getOfficeState()),
        _buildInfoRow('Pincode', _getOfficePincode()),
        if (_getOfficeGoogleMapLink().isNotEmpty)
          _buildOfficeGoogleMapLink(),
      ]);
    }

    // Apartment address children
    final apartmentAddressChildren = <Widget>[
      _buildInfoRow('Apartment Address', _getAddress()),
      if (_getArea().isNotEmpty)
        _buildInfoRow('Area / Locality', _getArea()),
      _buildInfoRow('City', _getCity()),
      _buildInfoRow('State', _getState()),
      _buildInfoRow('Pincode', _getPincode()),
    ];

    if (_getGoogleMapLink().isNotEmpty) {
      apartmentAddressChildren.add(_buildGoogleMapLink());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Office Address Card - Only show if there's data
          if (officeAddressChildren.isNotEmpty)
            _buildGlassCard(
              title: 'Permanent Office Address',
              icon: Icons.business,
              children: officeAddressChildren,
            ),

          if (officeAddressChildren.isNotEmpty)
            const SizedBox(height: 16),

          // Apartment Address Card
          _buildGlassCard(
            title: 'Apartment Location Details',
            icon: Icons.location_on,
            children: apartmentAddressChildren,
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPropertyDetails() {
  //   final description = _getDescription();
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Property Specifications',
  //           icon: Icons.architecture,
  //           children: [
  //             _buildInfoRow('Property Type', _getPropertyType()),
  //             _buildInfoRow('Total Units', _getTotalUnits()),
  //             _buildInfoRow('Total Bedrooms', _getTotalBedrooms()),
  //             _buildInfoRow('Total Bathrooms', _getTotalBathrooms()),
  //             _buildInfoRow('Guest Capacity', '${_getGuestCapacity()} guests'),
  //             if (_getFloorNumber().isNotEmpty)
  //               _buildInfoRow('Floor Number', _getFloorNumber()),
  //             if (_getTotalFloors().isNotEmpty)
  //               _buildInfoRow('Total Floors', _getTotalFloors()),
  //             _buildInfoRow('Elevator Available', _getElevatorAvailable()),
  //             if (_getPropertySize().isNotEmpty)
  //               _buildInfoRow('Property Size', '${_getPropertySize()} sq.ft.'),
  //             if (_getYearConstruction().isNotEmpty)
  //               _buildInfoRow('Year Built', _getYearConstruction()),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         if (description.isNotEmpty)
  //           _buildGlassCard(
  //             title: 'Property Description',
  //             icon: Icons.description,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: primarySoft,
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: borderColor),
  //                 ),
  //                 child: Text(
  //                   description,
  //                   style: TextStyle(fontSize: 14, color: darkText, height: 1.5),
  //                 ),
  //               ),
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPropertyDetails() {
    final description = _getDescription();
    final bhkDetails = _get('propertyDetails.bhkDetails', []);
    final hasBHKDetails = bhkDetails is List && bhkDetails.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Property Specifications',
            icon: Icons.architecture,
            children: [
              _buildInfoRow('Property Type', _getPropertyType()),

              if (!hasBHKDetails) ...[
                _buildInfoRow('Total Units', _getTotalUnits()),
                _buildInfoRow('Total Bedrooms', _getTotalBedrooms()),
                _buildInfoRow('Total Bathrooms', _getTotalBathrooms()),
                _buildInfoRow('Guest Capacity', '${_getGuestCapacity()} guests'),
                if (_getFloorNumber().isNotEmpty)
                  _buildInfoRow('Floor Number', _getFloorNumber()),
                if (_getTotalFloors().isNotEmpty)
                  _buildInfoRow('Total Floors', _getTotalFloors()),
                _buildInfoRow('Elevator Available', _getElevatorAvailable()),
                if (_getPropertySize().isNotEmpty)
                  _buildInfoRow('Property Size', '${_getPropertySize()} sq.ft.'),
              ],
              if (_getYearConstruction().isNotEmpty)
                _buildInfoRow('Year Built', _getYearConstruction()),
            ],
          ),
          const SizedBox(height: 16),
          _buildBHKDetailsSection(),
          if (description.isNotEmpty && !hasBHKDetails)
            _buildGlassCard(
              title: 'Property Description',
              icon: Icons.description,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: darkText, height: 1.5),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAmenities() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_apartmentAmenities.isNotEmpty)
            _buildEditableSection(
              title: 'Apartment Amenities',
              icon: Icons.workspaces_filled,
              amenities: _apartmentAmenities,
              sectionId: 'amenities',
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildCustomAmenitiesCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableSection({
    required String title,
    required IconData icon,
    required Map<String, bool> amenities,
    required String sectionId,
  }) {
    bool isEditMode = _editModes[sectionId] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 16, color: primaryColor)),
                  const SizedBox(width: 12),
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) { _autoSaveAmenities(); _editModes[sectionId] = false; }
                    else { _editModes[sectionId] = true; }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isEditMode ? Icons.check : Icons.edit, size: 14, color: isEditMode ? Colors.white : primaryColor),
                      const SizedBox(width: 4),
                      Text(isEditMode ? 'Submit' : 'Edit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? Colors.white : primaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.entries.map((entry) {
              bool isSelected = entry.value;
              return GestureDetector(
                onTap: isEditMode ? () { setState(() { amenities[entry.key] = !isSelected; _autoSaveAmenities(); }); } : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.8)]) : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: isSelected ? Colors.transparent : borderColor, width: isSelected ? 0 : 1),
                    boxShadow: isSelected ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))] : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) Icon(Icons.check_circle, size: 14, color: Colors.white)
                      else Icon(isEditMode ? Icons.circle_outlined : Icons.circle, size: 14, color: isEditMode ? lightText : borderColor),
                      const SizedBox(width: 6),
                      Text(entry.key, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? Colors.white : darkText)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAmenitiesCard() {
    final TextEditingController _customController = TextEditingController();
    bool isEditMode = _editModes['custom'] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.stars, size: 16, color: primaryColor)),
                  const SizedBox(width: 12),
                  Text('Custom Amenities', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) { _editModes['custom'] = false; _autoSaveAmenities(); }
                    else { _editModes['custom'] = true; }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isEditMode ? Icons.check : Icons.edit, size: 14, color: isEditMode ? Colors.white : primaryColor),
                      const SizedBox(width: 4),
                      Text(isEditMode ? 'Submit' : 'Edit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? Colors.white : primaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isEditMode)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _customController,
                        decoration: InputDecoration(
                          hintText: 'Enter new amenity...',
                          hintStyle: TextStyle(fontSize: 12, color: lightText),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: borderColor)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_customController.text.trim().isNotEmpty) {
                            setState(() {
                              _customAmenities.add(_customController.text.trim());
                              _autoSaveAmenities();
                              _customController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          if (_customAmenities.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _customAmenities.asMap().entries.map((entry) {
                int index = entry.key;
                String amenity = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primarySoft : cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? primaryColor.withOpacity(0.3) : borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(amenity, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? primaryColor : darkText)),
                      if (isEditMode) ...[
                        const SizedBox(width: 4),
                        GestureDetector(onTap: () { setState(() { _customAmenities.removeAt(index); _autoSaveAmenities(); }); }, child: Icon(Icons.close, size: 14, color: Colors.red)),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          if (_customAmenities.isEmpty && !isEditMode)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No custom amenities added', style: TextStyle(fontSize: 12, color: lightText, fontStyle: FontStyle.italic)),
            ),
        ],
      ),
    );
  }

  // Widget _buildPricingPolicies() {
  //   final basePrice = _getPriceValue('basePrice');
  //   final weekendPrice = _getPriceValue('weekendPrice');
  //   final peakPrice = _getPriceValue('peakPrice');
  //   final securityDeposit = _getPriceValue('securityDeposit');
  //   final minimumStay = _getPriceValue('minimumStay');
  //   final cancellationPolicy = _getDocumentInfo('cancellationPolicy');
  //   final availabilityCalendar = _getDocumentInfo('availabilityCalendar');
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Pricing Information',
  //           icon: Icons.attach_money,
  //           children: [
  //             _buildEditablePriceField(label: 'Base Price', value: basePrice, key: 'basePrice'),
  //             _buildEditablePriceField(label: 'Weekend Price', value: weekendPrice, key: 'weekendPrice'),
  //             if (_hasValue(peakPrice)) _buildEditablePriceField(label: 'Peak Season Price', value: peakPrice, key: 'peakPrice'),
  //             if (_hasValue(securityDeposit)) _buildEditablePriceField(label: 'Security Deposit', value: securityDeposit, key: 'securityDeposit'),
  //             if (_hasValue(minimumStay)) _buildEditableIntegerField(label: 'Minimum Stay', value: minimumStay, key: 'minimumStay', suffix: ' nights'),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _buildGlassCard(
  //           title: 'Check-in/Check-out Timings',
  //           icon: Icons.access_time,
  //           children: [
  //             _buildEditableTimeField(
  //               label: 'Check-in Time',
  //               controller: _checkInController,
  //               onChanged: (value) { setState(() { _checkInTime = value; _autoSaveTimes(); }); },
  //             ),
  //             const SizedBox(height: 16),
  //             _buildEditableTimeField(
  //               label: 'Check-out Time',
  //               controller: _checkOutController,
  //               onChanged: (value) { setState(() { _checkOutTime = value; _autoSaveTimes(); }); },
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _buildGlassCard(
  //           title: 'Policy Documents',
  //           icon: Icons.description,
  //           children: [
  //             _buildEditableDocumentItem(docName: 'Cancellation Policy', docType: 'cancellationPolicy', fileInfo: cancellationPolicy),
  //             _buildEditableDocumentItem(docName: 'Availability Calendar', docType: 'availabilityCalendar', fileInfo: availabilityCalendar),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPricingPolicies() {
    final basePrice = _getPriceValue('basePrice');
    final weeklyPrice = _getWeeklyPrice();
    final monthlyPrice = _getMonthlyPrice();
    final weekendPrice = _getPriceValue('weekendPrice');
    final peakPrice = _getPriceValue('peakPrice');
    final securityDeposit = _getPriceValue('securityDeposit');
    final minimumStay = _getPriceValue('minimumStay');
    final advancePayment = _getAdvancePayment();
    final cancellationPolicy = _getDocumentInfo('cancellationPolicy');
    final availableFromDate = _getAvailableFromDate();
    final blackoutDates = _getBlackoutDates();
    final calendarSync = _getCalendarSync();
    final instantBooking = _getInstantBooking();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Pricing Information',
            icon: Icons.attach_money,
            children: [
              _buildEditablePriceField(label: 'Base Price', value: basePrice, key: 'basePrice'),
              if (_hasValue(weeklyPrice))
                _buildEditablePriceField(label: 'Weekly Price', value: weeklyPrice, key: 'weeklyPrice'),
              if (_hasValue(monthlyPrice))
                _buildEditablePriceField(label: 'Monthly Price', value: monthlyPrice, key: 'monthlyPrice'),
              _buildEditablePriceField(label: 'Weekend Price', value: weekendPrice, key: 'weekendPrice'),
              if (_hasValue(peakPrice))
                _buildEditablePriceField(label: 'Peak Season Price', value: peakPrice, key: 'peakPrice'),
              if (_hasValue(securityDeposit))
                _buildEditablePriceField(label: 'Security Deposit', value: securityDeposit, key: 'securityDeposit'),
              _buildEditableIntegerField(label: 'Minimum Stay', value: minimumStay, key: 'minimumStay', suffix: ' nights'),
              if (_hasValue(advancePayment))
                _buildEditableIntegerField(label: 'Advance Payment', value: advancePayment, key: 'advancePayment', suffix: '%'),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildEditableTimeField(
                label: 'Check-in Time',
                controller: _checkInController,
                onChanged: (value) { setState(() { _checkInTime = value; _autoSaveTimes(); }); },
              ),
              const SizedBox(height: 16),
              _buildEditableTimeField(
                label: 'Check-out Time',
                controller: _checkOutController,
                onChanged: (value) { setState(() { _checkOutTime = value; _autoSaveTimes(); }); },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Availability Management',
            icon: Icons.calendar_today,
            children: [
              _buildInfoRow('Available From Date', availableFromDate != null
                  ? '${availableFromDate.day}/${availableFromDate.month}/${availableFromDate.year}'
                  : 'Not set'),
              if (blackoutDates.isNotEmpty)
                _buildInfoRow('Blackout Dates', blackoutDates),
              if (calendarSync['uploaded'] == true)
                _buildDocumentItem('Calendar Sync', calendarSync),
              _buildInfoRow('Instant Booking', instantBooking),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Policy Documents',
            icon: Icons.description,
            children: [
              _buildEditableDocumentItem(docName: 'Cancellation Policy', docType: 'cancellationPolicy', fileInfo: cancellationPolicy),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String docName, Map<String, dynamic> fileInfo) {
    IconData getIcon() {
      if (docName.contains('Cancellation')) return Icons.policy;
      if (docName.contains('Calendar')) return Icons.calendar_month;
      if (docName.contains('Ownership')) return Icons.home;
      if (docName.contains('ID Proof')) return Icons.badge;
      if (docName.contains('Cheque')) return Icons.account_balance;
      return Icons.description;
    }

    final fileName = fileInfo['name']?.toString() ?? 'Document';
    final fileSize = fileInfo['size'] ?? 0;
    final isUploaded = fileInfo['uploaded'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? primarySoft : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isUploaded ? primaryColor.withOpacity(0.3) : borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(), size: 24, color: primaryColor),
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
                    color: darkText,
                  ),
                ),
                if (isUploaded) ...[
                  const SizedBox(height: 4),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 12, color: lightText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${(fileSize / 1024).toStringAsFixed(1)} KB',
                    style: TextStyle(fontSize: 11, color: lightText),
                  ),
                ],
              ],
            ),
          ),
          if (isUploaded)
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
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Not Uploaded',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditablePriceField({required String label, required dynamic value, required String key}) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.15))),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500))),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_hasValue(value) ? '₹${_formatPrice(value)}' : 'Not set', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor, width: 1.5)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500))),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    hintText: 'Enter amount',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () { setState(() { _priceEditModes[key] = false; }); }, child: Text('Cancel', style: TextStyle(fontSize: 11))),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  double? newValue = double.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      _data[key] = newValue;
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }
                      _priceEditModes[key] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label updated to ₹${_formatPrice(newValue)}'), backgroundColor: primaryColor, duration: Duration(seconds: 2)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid amount'), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Save', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableIntegerField({required String label, required dynamic value, required String key, String suffix = ''}) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.15))),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500))),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_hasValue(value) ? '${_formatInteger(value)}$suffix' : 'Not set', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor, width: 1.5)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500))),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    suffixText: suffix,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () { setState(() { _priceEditModes[key] = false; }); }, child: Text('Cancel', style: TextStyle(fontSize: 11))),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  int? newValue = int.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      _data[key] = newValue;
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }
                      _priceEditModes[key] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label updated to $newValue$suffix'), backgroundColor: primaryColor, duration: Duration(seconds: 2)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid number'), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Save', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTimeField({required String label, required TextEditingController controller, required ValueChanged<String> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: darkText)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectTime(context, controller, onChanged),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.text.isNotEmpty ? _formatTimeForDisplay(controller.text) : 'Select time', style: TextStyle(fontSize: 14, color: controller.text.isNotEmpty ? darkText : lightText)),
                Icon(Icons.access_time, size: 20, color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller, ValueChanged<String> onChanged) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (controller.text.isNotEmpty) {
      try {
        List<String> parts = controller.text.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          initialTime = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e) { initialTime = TimeOfDay.now(); }
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!),
    );

    if (pickedTime != null) {
      String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      controller.text = formattedTime;
      onChanged(formattedTime);
    }
  }

  String _formatTimeForDisplay(String time24) {
    if (time24.isEmpty) return '';
    try {
      List<String> parts = time24.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1].substring(0, 2));
        String period = hour >= 12 ? 'PM' : 'AM';
        int hour12 = hour % 12;
        if (hour12 == 0) hour12 = 12;
        return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
    } catch (e) { return time24; }
    return time24;
  }

  Widget _buildEditableDocumentItem({required String docName, required String docType, required Map<String, dynamic> fileInfo}) {
    bool isUploaded = fileInfo['uploaded'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isUploaded ? primaryColor.withOpacity(0.3) : borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(docName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText)),
              Container(),
            ],
          ),
          const SizedBox(height: 8),
          if (isUploaded)
            GestureDetector(
              onTap: () => _viewDocument(fileInfo, docName),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Icon(_getFileIcon(fileInfo['name'] ?? ''), size: 20, color: primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fileInfo['name'] ?? 'Document', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20, color: lightText),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Row(
                children: [
                  Icon(Icons.file_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(child: Text('No file uploaded', style: TextStyle(fontSize: 12, color: lightText))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaAndVirtualTour() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMediaSection(),
          const SizedBox(height: 16),
          _buildVirtualTourSection(),
        ],
      ),
    );
  }

  Widget _buildVirtualTourSection() {
    final String virtualTourLink = _getVirtualTourLink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.videocam, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                'Virtual Tour',
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
          if (virtualTourLink.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.link, size: 18, color: primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      virtualTourLink,
                      style: TextStyle(fontSize: 12, color: darkText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _launchURL(virtualTourLink),
                    icon: Icon(Icons.open_in_new, size: 18, color: primaryColor),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No virtual tour link available',
                      style: TextStyle(fontSize: 12, color: lightText),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBHKDetailsSection() {

    List? bhkDetails = [];


    if (_data.containsKey('propertyDetails')) {
      final propertyDetails = _data['propertyDetails'];
      if (propertyDetails is Map) {
        if (propertyDetails.containsKey('bhkDetails')) {
          bhkDetails = propertyDetails['bhkDetails'];
          print('Found bhkDetails in propertyDetails.bhkDetails: $bhkDetails');
        }
      }
    }

    // If not found, try direct bhkDetails
    if (bhkDetails == null || bhkDetails.isEmpty) {
      if (_data.containsKey('bhkDetails')) {
        bhkDetails = _data['bhkDetails'];
        print('Found bhkDetails in _data.bhkDetails: $bhkDetails');
      }
    }

    // If still not found, try selectedSubOptionsDetails
    if (bhkDetails == null || bhkDetails.isEmpty) {
      if (_data.containsKey('selectedSubOptionsDetails')) {
        final subOptions = _data['selectedSubOptionsDetails'];
        if (subOptions is Map) {
          bhkDetails = subOptions.values.toList();
          print('Found bhkDetails in selectedSubOptionsDetails: $bhkDetails');
        }
      }
    }

    // If still not found, try selectedSubOptions
    if (bhkDetails == null || bhkDetails.isEmpty) {
      if (_data.containsKey('selectedSubOptions')) {
        bhkDetails = _data['selectedSubOptions'];
        print('Found selectedSubOptions: $bhkDetails');
      }
    }

    if (bhkDetails is! List || bhkDetails.isEmpty) {
      print('No BHK details found');
      return SizedBox.shrink();
    }

    print('Building BHK cards for ${bhkDetails.length} items');

    List<Widget> bhkCards = [];

    for (var bhk in bhkDetails) {

      Map<String, dynamic> bhkMap;

      if (bhk is BHKDetails) {
        bhkMap = bhk.toJson();
      } else if (bhk is Map) {
        // Convert Map<dynamic, dynamic> to Map<String, dynamic>
        bhkMap = Map<String, dynamic>.from(bhk);
      } else if (bhk is String) {
        print('Found string bhk: $bhk - looking for details');
        continue;
      } else {
        continue;
      }

      String bhkType = bhkMap['type']?.toString() ??
          bhkMap['bhkType']?.toString() ??
          'BHK Unit';

      // Format elevator text
      String elevatorText = '';
      if (bhkMap['elevatorAvailable']?.toString().isNotEmpty ?? false) {
        String elevatorValue = bhkMap['elevatorAvailable'].toString();
        if (elevatorValue.toLowerCase() == 'yes') {
          elevatorText = 'Elevator Available';
        } else if (elevatorValue.toLowerCase() == 'no') {
          elevatorText = 'Elevator Not Available';
        } else {
          elevatorText = elevatorValue;
        }
      }

      print('Building card for: $bhkType');
      print('BHK data: $bhkMap');

      bhkCards.add(
        Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withOpacity(0.05), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      bhkType,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  if (bhkMap['totalUnits']?.toString().isNotEmpty ?? false)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${bhkMap['totalUnits']} Units',
                        style: TextStyle(
                          fontSize: 11,
                          color: _successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (bhkMap['totalBedrooms']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.bed, '${bhkMap['totalBedrooms']} Bedrooms'),
                  if (bhkMap['totalBathrooms']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.bathtub, '${bhkMap['totalBathrooms']} Bathrooms'),
                  if (bhkMap['guestCapacity']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.people, '${bhkMap['guestCapacity']} Guests'),
                  if (bhkMap['propertySize']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.square_foot, '${bhkMap['propertySize']} sq.ft'),
                  if (bhkMap['floorNumber']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.apartment, 'Floor ${bhkMap['floorNumber']}'),
                  if (bhkMap['totalFloors']?.toString().isNotEmpty ?? false)
                    _buildDetailChip(Icons.business, 'Total Floors ${bhkMap['totalFloors']}'),
                  if (elevatorText.isNotEmpty)
                    _buildDetailChip(
                      Icons.elevator,
                      elevatorText,
                      // Optional: different color based on availability
                      iconColor: elevatorText == 'Elevator Available' ? _successColor : Colors.red,
                    ),
                ],
              ),
              if (bhkMap['propertyDescription']?.toString().isNotEmpty ?? false) ...[
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        bhkMap['propertyDescription'].toString(),
                        style: TextStyle(fontSize: 13, color: darkText, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (bhkCards.isEmpty) {
      print('No BHK cards were built');
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.house, size: 18, color: primaryColor),
              ),
              SizedBox(width: 12),
              Text(
                'BHK Unit Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: borderColor),
          ...bhkCards,
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label, {Color? iconColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? primaryColor),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: darkText, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection() {
    final List<Widget> mediaWidgets = [];

    final mediaCategories = {
      'exterior': {'label': 'Exterior Photos', 'maxLimit': 2},
      'interior': {'label': 'Interior Photos', 'maxLimit': 2},
      'bedroom': {'label': 'Bedroom Photos', 'maxLimit': 1},
      'bathroom': {'label': 'Bathroom Photos', 'maxLimit': 1},
      'amenities': {'label': 'Amenities Photos', 'maxLimit': 5},
      'short_video': {'label': 'Short Video', 'maxLimit': 1},
    };

    mediaCategories.forEach((key, data) {
      final files = _getMediaFiles(key);
      final label = data['label'] as String;
      final maxLimit = data['maxLimit'] as int;
      bool isEditing = _mediaEditModes[key] ?? false;

      mediaWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildEditableMediaSection(
            label: label,
            mediaKey: key,
            files: files,
            maxLimit: maxLimit,
            isEditing: isEditing,
            onEditToggle: () { setState(() { _mediaEditModes[key] = !isEditing; }); },
            onUpload: () => _uploadMediaFile(key, label, maxLimit),
            onView: (file) => _viewMediaFile(file, label),
            onRemove: (index) => _removeMediaFile(key, index, label),
            onReplace: (index) => _replaceMediaFile(key, index, label),
          ),
        ),
      );
    });

    final String virtualTourLink = _getVirtualTourLink();
    if (virtualTourLink.isNotEmpty) {
      mediaWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Virtual Tour Link', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkText)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.2))),
                child: Row(
                  children: [
                    Icon(Icons.link, size: 18, color: primaryColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text(virtualTourLink, style: TextStyle(fontSize: 12, color: darkText), maxLines: 2, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (mediaWidgets.isEmpty) return const SizedBox.shrink();

    return _buildGlassCard(
      title: 'Media & Virtual Tour',
      icon: Icons.photo_library,
      children: mediaWidgets,
    );
  }

  Widget _buildEditableMediaSection({
    required String label,
    required String mediaKey,
    required List<Map<String, dynamic>> files,
    required int maxLimit,
    required bool isEditing,
    required VoidCallback onEditToggle,
    required VoidCallback onUpload,
    required Function(Map<String, dynamic>) onView,
    required Function(int) onRemove,
    required Function(int) onReplace,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkText)),
            if (!isEditing && files.isNotEmpty)
              GestureDetector(
                onTap: onEditToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.edit, size: 12, color: primaryColor),
                    const SizedBox(width: 4),
                    Text('Edit', style: TextStyle(fontSize: 10, color: primaryColor, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (isEditing) ...[
          if (files.length < maxLimit)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onUpload,
                icon: Icon(Icons.cloud_upload, size: 18),
                label: Text('Upload ${files.length + 1}/$maxLimit'),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              ),
            ),
          const SizedBox(height: 8),
          ...files.asMap().entries.map((entry) {
            int index = entry.key;
            var file = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(_getFileIcon(file['name'] ?? ''), size: 20, color: primaryColor)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(file['name'] ?? 'File', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onView(file),
                          icon: Icon(Icons.visibility, size: 16),
                          label: Text('View'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: primaryColor), foregroundColor: primaryColor, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onReplace(index),
                          icon: Icon(Icons.refresh, size: 16),
                          label: Text('Replace'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.orange), foregroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onRemove(index),
                          icon: Icon(Icons.delete, size: 16),
                          label: Text('Remove'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red), foregroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onEditToggle, child: Text('Done', style: TextStyle(color: primaryColor))),
            ],
          ),
        ] else ...[
          if (files.isNotEmpty)
            ...files.map((file) => GestureDetector(
              onTap: () => onView(file),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                child: Row(
                  children: [
                    Container(width: 40, height: 40, decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(_getFileIcon(file['name'] ?? ''), size: 20, color: primaryColor)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(file['name'] ?? 'File', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20, color: lightText),
                  ],
                ),
              ),
            ))
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Row(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(child: Text('No files uploaded. Tap Edit to add.', style: TextStyle(fontSize: 12, color: lightText))),
                ],
              ),
            ),
        ],
      ],
    );
  }

  // Widget _buildLegalBank() {
  //   final ownershipProof = _getDocumentInfo('ownershipProof');
  //   final idProof = _getDocumentInfo('idProof');
  //   final cancelledCheque = _getDocumentInfo('cancelledCheque');
  //
  //   Map<String, dynamic> legalData = {};
  //   Map<String, dynamic> bankData = {};
  //
  //   if (_data.containsKey('legal') && _data['legal'] is Map) legalData = Map<String, dynamic>.from(_data['legal']);
  //   if (_data.containsKey('bank') && _data['bank'] is Map) bankData = Map<String, dynamic>.from(_data['bank']);
  //
  //   final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
  //   final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];
  //   final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
  //   final bankName = bankData['bankName'] ?? _data['bankName'];
  //   final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
  //   final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
  //   final upiId = bankData['upiId'] ?? _data['upiId'];
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Legal & Verification',
  //           icon: Icons.gavel,
  //           children: [
  //             if (_hasValue(gstNumber)) _buildInfoRow('GST Number', gstNumber),
  //             if (_hasValue(tradeLicense)) _buildInfoRow('Trade License', tradeLicense),
  //             _buildEditableDocumentItem(docName: 'Ownership Proof', docType: 'ownershipProof', fileInfo: ownershipProof),
  //             _buildEditableDocumentItem(docName: 'ID Proof', docType: 'idProof', fileInfo: idProof),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _buildGlassCard(
  //           title: 'Bank Details',
  //           icon: Icons.account_balance,
  //           children: [
  //             if (_hasValue(accountHolder)) _buildInfoRow('Account Holder', accountHolder),
  //             if (_hasValue(bankName)) _buildInfoRow('Bank Name', bankName),
  //             if (_hasValue(accountNumber)) _buildInfoRow('Account Number', accountNumber),
  //             if (_hasValue(ifscCode)) _buildInfoRow('IFSC Code', ifscCode),
  //             if (_hasValue(upiId)) _buildInfoRow('UPI ID', upiId),
  //             _buildEditableDocumentItem(docName: 'Cancelled Cheque', docType: 'cancelledCheque', fileInfo: cancelledCheque),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLegalBank() {
    final ownershipProof = _getDocumentInfo('ownershipProof');
    final idProof = _getDocumentInfo('idProof');
    final cancelledCheque = _getDocumentInfo('cancelledCheque');
    final policeVerification = _getPoliceVerification();

    Map<String, dynamic> legalData = {};
    Map<String, dynamic> bankData = {};

    if (_data.containsKey('legal') && _data['legal'] is Map) legalData = Map<String, dynamic>.from(_data['legal']);
    if (_data.containsKey('bank') && _data['bank'] is Map) bankData = Map<String, dynamic>.from(_data['bank']);

    final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
    final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];
    final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
    final bankName = bankData['bankName'] ?? _data['bankName'];
    final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
    final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
    final upiId = bankData['upiId'] ?? _data['upiId'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal & Verification',
            icon: Icons.gavel,
            children: [
              if (_hasValue(gstNumber)) _buildInfoRow('GST Number', gstNumber),
              if (_hasValue(tradeLicense)) _buildInfoRow('Trade License', tradeLicense),
              if (policeVerification.isNotEmpty) _buildInfoRow('Police Verification', policeVerification),
              _buildEditableDocumentItem(docName: 'Ownership Proof', docType: 'ownershipProof', fileInfo: ownershipProof),
              _buildEditableDocumentItem(docName: 'ID Proof', docType: 'idProof', fileInfo: idProof),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(accountHolder)) _buildInfoRow('Account Holder', accountHolder),
              if (_hasValue(bankName)) _buildInfoRow('Bank Name', bankName),
              if (_hasValue(accountNumber)) _buildInfoRow('Account Number', accountNumber),
              if (_hasValue(ifscCode)) _buildInfoRow('IFSC Code', ifscCode),
              if (_hasValue(upiId)) _buildInfoRow('UPI ID', upiId),
              _buildEditableDocumentItem(docName: 'Cancelled Cheque', docType: 'cancelledCheque', fileInfo: cancelledCheque),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }
}


class VideoPlayerWidget extends StatefulWidget {
  final String filePath;

  const VideoPlayerWidget({Key? key, required this.filePath}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
              ),
            ],
          ),
        ),
      ],
    )
        : const Center(child: CircularProgressIndicator());
  }
}


class ResortRegistrationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  final String? resortId;
  final int? resortIndex;

  const ResortRegistrationDetailsScreen({
    Key? key,
    required this.registrationData,
    this.resortId,
    this.resortIndex,
  }) : super(key: key);

  @override
  State<ResortRegistrationDetailsScreen> createState() => _ResortRegistrationDetailsScreenState();
}

class _ResortRegistrationDetailsScreenState extends State<ResortRegistrationDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  late Map<String, bool> _resortAmenities;
  late Map<String, bool> _roomTypes;
  late List<String> _customAmenities;
  Map<String, bool> _editModes = {};

  bool _isEditingPhone = false;
  late TextEditingController _phoneController;
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;

  late Map<String, bool> _priceEditModes;
  late String _checkInTime;
  late String _checkOutTime;

  late Map<String, bool> _mediaEditModes;
  late Map<String, int> _mediaMaxLimits;

  late Map<String, bool> _documentEditModes;

  final Color primaryColor = const Color(0xFF2E7D32);
  final Color primaryLight = const Color(0xFF2E7D32).withOpacity(0.1);
  final Color primarySoft = const Color(0xFF2E7D32).withOpacity(0.05);
  final Color primaryMedium = const Color(0xFF2E7D32).withOpacity(0.03);
  final Color _successColor = const Color(0xFF10B981);

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
    _tabController = TabController(length: 7, vsync: this);

    _phoneController = TextEditingController(text: _getUserPhone());
    _checkInController = TextEditingController(text: _getCheckInTime());
    _checkOutController = TextEditingController(text: _getCheckOutTime());

    _initializeTimes();
    _priceEditModes = {};
    _initializeAmenities();
    _debugPrintData();
    _debugStarRatingData();

  }

  void _debugStarRatingData() {
    print('=== DEBUG STAR RATING DATA ===');
    final propertyDetails = _data['propertyDetails'] as Map?;
    if (propertyDetails != null) {
      print('propertyDetails keys: ${propertyDetails.keys.toList()}');
      final starRatingDetails = propertyDetails['starRatingDetails'];
      print('starRatingDetails: $starRatingDetails');
      print('starRatingDetails type: ${starRatingDetails.runtimeType}');
      if (starRatingDetails is List) {
        print('starRatingDetails length: ${starRatingDetails.length}');
        for (var i = 0; i < starRatingDetails.length; i++) {
          print('starRatingDetails[$i]: ${starRatingDetails[i]}');
          if (starRatingDetails[i] is Map) {
            print('  - type: ${starRatingDetails[i]['type']}');
            print('  - totalRooms: ${starRatingDetails[i]['totalRooms']}');
            print('  - totalCapacity: ${starRatingDetails[i]['totalCapacity']}');
          }
        }
      }
    } else {
      print('propertyDetails is null');
      print('_data keys: ${_data.keys.toList()}');
    }
  }

  void _debugPrintData() {
    print('=== RESORT DETAILS SCREEN DATA ===');
    print('Data keys: ${_data.keys.toList()}');
    print('Virtual Tour Link: ${_getVirtualTourLink()}');
    print('Media: ${_data['media']}');
  }

  void _initializeTimes() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    _checkInTime = _data['checkInTime']?.toString() ??
        pricingData['checkInTime']?.toString() ??
        '12:00';
    _checkInController = TextEditingController(text: _checkInTime);

    _checkOutTime = _data['checkOutTime']?.toString() ??
        pricingData['checkOutTime']?.toString() ??
        '11:00';
    _checkOutController = TextEditingController(text: _checkOutTime);
  }

  void _autoSaveTimes() {
    _data['checkInTime'] = _checkInTime;
    _data['checkOutTime'] = _checkOutTime;

    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      final pricing = _data['pricing'] as Map;
      pricing['checkInTime'] = _checkInTime;
      pricing['checkOutTime'] = _checkOutTime;
      _data['pricing'] = pricing;
    }
  }

  dynamic _get(String key, [dynamic defaultValue]) {
    try {
      final keys = key.split('.');
      dynamic value = _data;

      for (final k in keys) {
        if (value is Map) {
          value = value[k];
        } else {
          return defaultValue;
        }
      }
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  void _initializeAmenities() {
    _editModes = {
      'amenities': false,
      'custom': false,
      'roomTypes': false,
    };

    _priceEditModes = {
      'basePrice': false,
      'weekendPrice': false,
      'peakPrice': false,
      'extraBedCharges': false,
      'minimumStay': false,
      'advancePayment': false,
    };

    _documentEditModes = {
      'businessReg': false,
      'idProof': false,
      'ownershipProof': false,
      'fireSafety': false,
      'cancelledCheque': false,
    };

    _mediaEditModes = {
      'exterior': false,
      'reception': false,
      'rooms': false,
      'pool_amenities': false,
      'restaurant': false,
      'short_video': false,
    };

    _mediaMaxLimits = {
      'exterior': 2,
      'reception': 2,
      'rooms': 2,
      'pool_amenities': 5,
      'restaurant': 2,
      'short_video': 1,
    };

    // Initialize Resort Amenities
    if (_data['selectedAmenities'] != null && _data['selectedAmenities'] is Map) {
      _resortAmenities = Map<String, bool>.from(_data['selectedAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['selected'] is Map) {
      _resortAmenities = Map<String, bool>.from(_data['amenities']['selected']);
    } else {
      _resortAmenities = {
        'Swimming Pool': false,
        'Private Beach Access': false,
        'Spa & Wellness Center': false,
        'Gym': false,
        'Restaurant': false,
        'Bar': false,
        'Banquet Hall': false,
        'Conference Hall': false,
        'Free WiFi': false,
        'Air Conditioning': false,
        'Parking': false,
        '24/7 Front Desk': false,
        'Room Service': false,
        'Power Backup': false,
        'CCTV & Security': false,
        'Kids Play Area': false,
        'Outdoor Activities': false,
        'Indoor Games': false,
        'Airport Transfer': false,
        'Pet Friendly': false,
      };
    }

    // Initialize Room Types
    if (_data['roomTypes'] != null && _data['roomTypes'] is Map) {
      _roomTypes = Map<String, bool>.from(_data['roomTypes']);
    } else if (_data['propertyDetails'] != null && _data['propertyDetails']['roomTypes'] is Map) {
      _roomTypes = Map<String, bool>.from(_data['propertyDetails']['roomTypes']);
    } else {
      _roomTypes = {
        'Standard': false,
        'Deluxe': false,
        'Suite': false,
        'Villa': false,
        'Cottage': false,
        'Family Room': false,
      };
    }

    // Initialize Custom Amenities
    if (_data['customAmenities'] != null && _data['customAmenities'] is List) {
      _customAmenities = List<String>.from(_data['customAmenities']);
    } else if (_data['amenities'] != null && _data['amenities']['custom'] is List) {
      _customAmenities = List<String>.from(_data['amenities']['custom']);
    } else {
      _customAmenities = [];
    }
  }

  void _autoSaveAmenities() {
    _data['selectedAmenities'] = Map<String, bool>.from(_resortAmenities);
    _data['customAmenities'] = List<String>.from(_customAmenities);
    _data['roomTypes'] = Map<String, bool>.from(_roomTypes);
  }

  String _getResortName() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('resortName') && basicInfo['resortName'].toString().isNotEmpty) {
        return basicInfo['resortName'].toString();
      }
    }
    return _data['resortName']?.toString() ?? 'Resort';
  }

  String _getResortCategory() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      if (details.containsKey('resortCategory') && details['resortCategory'].toString().isNotEmpty) {
        return details['resortCategory'].toString();
      }
    }
    return _data['resortCategory']?.toString() ?? 'Resort';
  }

  String _getTotalRooms() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      return details['totalRooms']?.toString() ?? '0';
    }
    return _data['totalRooms']?.toString() ?? '0';
  }

  String _getTotalCapacity() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      return details['totalCapacity']?.toString() ?? '0';
    }
    return _data['totalCapacity']?.toString() ?? '0';
  }

  String _getPropertyArea() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      return details['propertyArea']?.toString() ?? '';
    }
    return _data['propertyArea']?.toString() ?? '';
  }

  String _getYearEstablished() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      return details['yearEstablished']?.toString() ?? '';
    }
    return _data['yearEstablished']?.toString() ?? '';
  }

  String _getDescription() {
    if (_data.containsKey('propertyDetails') && _data['propertyDetails'] != null) {
      final details = _data['propertyDetails'] as Map;
      return details['description']?.toString() ?? '';
    }
    return _data['description']?.toString() ?? '';
  }

  String _getCheckInTime() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['checkInTime']?.toString() ?? pricingData['checkInTime']?.toString() ?? '12:00';
  }

  String _getCheckOutTime() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['checkOutTime']?.toString() ?? pricingData['checkOutTime']?.toString() ?? '11:00';
  }

  String _getUserFullName() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerName') && basicInfo['ownerName'].toString().isNotEmpty) {
        return basicInfo['ownerName'].toString();
      }
      if (basicInfo.containsKey('fullName') && basicInfo['fullName'].toString().isNotEmpty) {
        return basicInfo['fullName'].toString();
      }
    }
    if (_data.containsKey('fullName') && _data['fullName'].toString().isNotEmpty) {
      return _data['fullName'].toString();
    }
    if (_data.containsKey('ownerName') && _data['ownerName'].toString().isNotEmpty) {
      return _data['ownerName'].toString();
    }
    return 'User';
  }

  String _getUserEmail() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('email') && basicInfo['email'].toString().isNotEmpty) {
        return basicInfo['email'].toString();
      }
    }
    return _data['email']?.toString() ?? 'Not provided';
  }

  String _getUserPhone() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('mobile') && basicInfo['mobile'].toString().isNotEmpty) {
        return basicInfo['mobile'].toString();
      }
      if (basicInfo.containsKey('phone') && basicInfo['phone'].toString().isNotEmpty) {
        return basicInfo['phone'].toString();
      }
    }
    return _data['phone']?.toString() ?? _data['mobile']?.toString() ?? 'Not provided';
  }

  String _getAlternateMobile() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('altMobile') && basicInfo['altMobile'].toString().isNotEmpty) {
        return basicInfo['altMobile'].toString();
      }
    }
    return _data['altMobile']?.toString() ?? '';
  }

  String _getWebsite() {
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('website') && basicInfo['website'].toString().isNotEmpty) {
        return basicInfo['website'].toString();
      }
    }
    return _data['website']?.toString() ?? '';
  }

  String _getAddress() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('address') && location['address'].toString().isNotEmpty) {
        return location['address'].toString();
      }
    }
    return _data['address']?.toString() ?? 'Not provided';
  }

  String _getArea() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('area') && location['area'].toString().isNotEmpty) {
        return location['area'].toString();
      }
    }
    return _data['area']?.toString() ?? '';
  }

  String _getCity() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('city') && location['city'].toString().isNotEmpty) {
        return location['city'].toString();
      }
    }
    return _data['city']?.toString() ?? 'Not provided';
  }

  String _getState() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('state') && location['state'].toString().isNotEmpty) {
        return location['state'].toString();
      }
    }
    return _data['state']?.toString() ?? 'Not provided';
  }

  String _getPincode() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('pincode') && location['pincode'].toString().isNotEmpty) {
        return location['pincode'].toString();
      }
    }
    return _data['pincode']?.toString() ?? 'Not provided';
  }

  String _getGoogleMapLink() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('googleMapLink') && location['googleMapLink'].toString().isNotEmpty) {
        return location['googleMapLink'].toString();
      }
    }
    return _data['googleMapLink']?.toString() ?? '';
  }

  String _getNearestAirport() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('nearestAirport') && location['nearestAirport'].toString().isNotEmpty) {
        return location['nearestAirport'].toString();
      }
    }
    return _data['nearestAirport']?.toString() ?? '';
  }

  String _getNearestRailway() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('nearestRailway') && location['nearestRailway'].toString().isNotEmpty) {
        return location['nearestRailway'].toString();
      }
    }
    return _data['nearestRailway']?.toString() ?? '';
  }

  String _getOfficeAddress() {
    // Check in location.officeAddress first
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
          print('Found office address in location.officeAddress: ${office['address']}');
          return office['address'].toString();
        }
      }
    }

    // Check direct officeAddress
    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
        print('Found office address in direct officeAddress: ${office['address']}');
        return office['address'].toString();
      }
    }

    // Check in basicInfo.officeAddress
    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('officeAddress') && basicInfo['officeAddress'] != null) {
        final office = basicInfo['officeAddress'] as Map;
        if (office.containsKey('address') && office['address'].toString().isNotEmpty) {
          print('Found office address in basicInfo.officeAddress: ${office['address']}');
          return office['address'].toString();
        }
      }
    }

    print('No office address found anywhere');
    return 'Not provided';
  }

  String _getOfficeArea() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('area') && office['area'].toString().isNotEmpty) {
          return office['area'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('area') && office['area'].toString().isNotEmpty) {
        return office['area'].toString();
      }
    }

    return '';
  }

  String _getOfficeCity() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('city') && office['city'].toString().isNotEmpty) {
          return office['city'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('city') && office['city'].toString().isNotEmpty) {
        return office['city'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeState() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('state') && office['state'].toString().isNotEmpty) {
          return office['state'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('state') && office['state'].toString().isNotEmpty) {
        return office['state'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficePincode() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
          return office['pincode'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('pincode') && office['pincode'].toString().isNotEmpty) {
        return office['pincode'].toString();
      }
    }

    return 'Not provided';
  }

  String _getOfficeGoogleMapLink() {
    if (_data.containsKey('location') && _data['location'] != null) {
      final location = _data['location'] as Map;
      if (location.containsKey('officeAddress') && location['officeAddress'] != null) {
        final office = location['officeAddress'] as Map;
        if (office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
          return office['googleMapLink'].toString();
        }
      }
    }

    if (_data.containsKey('officeAddress') && _data['officeAddress'] != null) {
      final office = _data['officeAddress'] as Map;
      if (office.containsKey('googleMapLink') && office['googleMapLink'].toString().isNotEmpty) {
        return office['googleMapLink'].toString();
      }
    }

    return '';
  }

  dynamic _getPriceValue(String key) {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data[key] ?? pricingData[key];
  }

  Widget _buildOfficeGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getOfficeGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getWeeklyPrice() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['weeklyPrice']?.toString() ?? pricingData['weeklyPrice']?.toString() ?? '';
  }

  String _getMonthlyPrice() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['monthlyPrice']?.toString() ?? pricingData['monthlyPrice']?.toString() ?? '';
  }

  String _getExtraBedCharges() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['extraBedCharges']?.toString() ?? pricingData['extraBedCharges']?.toString() ?? '';
  }

  String _getChildPolicy() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['childPolicy']?.toString() ?? pricingData['childPolicy']?.toString() ?? '';
  }

  String _getAdvancePayment() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['advancePayment']?.toString() ?? pricingData['advancePayment']?.toString() ?? '';
  }

  DateTime? _getAvailableFromDate() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      if (availability.containsKey('availableFromDate') && availability['availableFromDate'] != null) {
        if (availability['availableFromDate'] is DateTime) {
          return availability['availableFromDate'] as DateTime;
        } else if (availability['availableFromDate'] is String) {
          try {
            return DateTime.parse(availability['availableFromDate'].toString());
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  String _getBlackoutDates() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['blackoutDates']?.toString() ?? '';
    }
    return _data['blackoutDates']?.toString() ?? '';
  }

  String _getInstantBooking() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['instantBooking']?.toString() ?? 'No';
    }
    return _data['instantBooking']?.toString() ?? 'No';
  }

  String _getManualApproval() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['manualApproval']?.toString() ?? 'No';
    }
    return _data['manualApproval']?.toString() ?? 'No';
  }

  String _getSeasonalPricing() {
    if (_data.containsKey('availability') && _data['availability'] != null) {
      final availability = _data['availability'] as Map;
      return availability['seasonalPricing']?.toString() ?? '';
    }
    return _data['seasonalPricing']?.toString() ?? '';
  }

  String _getVirtualTourLink() {
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      if (media.containsKey('virtual_tour')) {
        final tour = media['virtual_tour'];
        if (tour is String && tour.isNotEmpty) return tour;
        if (tour is List && tour.isNotEmpty && tour[0] is Map) {
          return tour[0]['path']?.toString() ?? '';
        }
      }
    }
    return _data['virtualTourLink']?.toString() ?? '';
  }

  String _getGstBillingDetails() {
    if (_data.containsKey('bank') && _data['bank'] != null) {
      final bank = _data['bank'] as Map;
      if (bank.containsKey('gstBilling') && bank['gstBilling'].toString().isNotEmpty) {
        return bank['gstBilling'].toString();
      }
    }
    return _data['gstBilling']?.toString() ?? '';
  }



  Map<String, dynamic> _getCancellationPolicy() {
    Map<String, dynamic> pricingData = {};
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }
    return _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};
  }

  List<Map<String, dynamic>> _getMediaFiles(String mediaKey) {
    if (_data.containsKey('media') && _data['media'] != null) {
      final media = _data['media'] as Map;
      if (media.containsKey(mediaKey) && media[mediaKey] is List) {
        return List<Map<String, dynamic>>.from(media[mediaKey]);
      }
    }
    return [];
  }

  void _savePhoneChanges() {
    setState(() {
      if (_data.containsKey('phone')) _data['phone'] = _phoneController.text;
      if (_data.containsKey('mobile')) _data['mobile'] = _phoneController.text;
      if (_data.containsKey('basicInfo')) {
        final basicInfo = _data['basicInfo'] as Map;
        basicInfo['mobile'] = _phoneController.text;
        _data['basicInfo'] = basicInfo;
      }
      _isEditingPhone = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number updated successfully'),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickAndUploadPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Choose Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.photo_library, color: primaryColor),
                  ),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: primaryColor),
                  ),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImageFromSource(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _data['ownerPhoto'] = {
            'uploaded': true,
            'name': image.name,
            'path': image.path,
          };
          if (_data.containsKey('basicInfo')) {
            final basicInfo = _data['basicInfo'] as Map;
            basicInfo['ownerPhoto'] = {
              'uploaded': true,
              'name': image.name,
              'path': image.path,
            };
            _data['basicInfo'] = basicInfo;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo uploaded successfully'),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _uploadMediaFile(String mediaKey, String mediaName, int maxLimit) async {
    try {
      final currentFiles = _getMediaFiles(mediaKey);
      if (currentFiles.length >= maxLimit) {
        _showErrorDialog('Maximum Limit Reached', 'You can only upload up to $maxLimit $mediaName.');
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog('File too large', 'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB');
          return;
        }

        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).add(fileInfo);
            } else {
              media[mediaKey] = [fileInfo];
            }
            _data['media'] = media;
          } else {
            _data['media'] = {mediaKey: [fileInfo]};
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName uploaded successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      _showErrorDialog('Upload Error', 'Failed to upload file: ${e.toString()}');
    }
  }

  Future<void> _replaceMediaFile(String mediaKey, int index, String mediaName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        int maxSize = mediaKey == 'short_video' ? 10 * 1024 * 1024 : 5 * 1024 * 1024;
        if (file.size > maxSize) {
          _showErrorDialog('File too large', 'Please select a file smaller than ${maxSize ~/ (1024 * 1024)}MB');
          return;
        }

        if (mediaKey == 'short_video') {
          final ext = file.name.split('.').last.toLowerCase();
          if (!['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
            _showErrorDialog('Invalid Format', 'Please select a video file (MP4, MOV, AVI, MKV)');
            return;
          }
        }

        Map<String, dynamic> fileInfo = {
          'name': file.name,
          'size': file.size,
          'path': file.path ?? '',
          'uploaded': true,
        };

        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List)[index] = fileInfo;
            }
            _data['media'] = media;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName replaced successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      _showErrorDialog('Replace Error', 'Failed to replace file: ${e.toString()}');
    }
  }

  void _viewMediaFile(Map<String, dynamic> file, String mediaName) {
    if (file['path'] != null && file['path'].isNotEmpty) {
      final fileName = file['name'] ?? 'File';
      final filePath = file['path'];
      final ext = fileName.split('.').last.toLowerCase();

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mediaName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: Image.file(File(filePath), fit: BoxFit.contain)),
                ],
              ),
            ),
          ),
        );
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mediaName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: VideoPlayerWidget(filePath: filePath)),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(mediaName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getFileIcon(fileName), size: 48, color: primaryColor),
                SizedBox(height: 16),
                Text(fileName, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text('Size: ${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 12, color: lightText)),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
          ),
        );
      }
    }
  }

  void _removeMediaFile(String mediaKey, int index, String mediaName) {
    _showConfirmationDialog(
      'Remove File',
      'Are you sure you want to remove this $mediaName?',
          () {
        setState(() {
          if (_data.containsKey('media') && _data['media'] is Map) {
            final media = _data['media'] as Map;
            if (media.containsKey(mediaKey) && media[mediaKey] is List) {
              (media[mediaKey] as List).removeAt(index);
              _data['media'] = media;
            }
          }
          _mediaEditModes[mediaKey] = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mediaName removed successfully'), backgroundColor: primaryColor, duration: Duration(seconds: 2)),
        );
      },
    );
  }

  void _viewDocument(Map<String, dynamic> fileInfo, String docName) {
    if (fileInfo['path'] != null && fileInfo['path'].isNotEmpty) {
      final fileName = fileInfo['name'] ?? 'Document';
      final filePath = fileInfo['path'];
      final ext = fileName.split('.').last.toLowerCase();

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(docName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText)),
                        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: lightText)),
                      ],
                    ),
                  ),
                  Expanded(child: Image.file(File(filePath), fit: BoxFit.contain)),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(docName),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getFileIcon(fileName), size: 48, color: primaryColor),
                SizedBox(height: 16),
                Text(fileName, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Text('Size: ${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 12, color: lightText)),
              ],
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))],
          ),
        );
      }
    }
  }

  String _getRegistrationId() {
    final resortName = _getResortName();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    final namePrefix = resortName.length >= 3 ? resortName.substring(0, 3).toUpperCase() : resortName.toUpperCase();
    return 'RST-$namePrefix-$timestamp';
  }

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
    if (value is double) return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    if (value is int) return value.toString();
    if (value is String) {
      double? parsed = double.tryParse(value);
      if (parsed != null) return parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 2);
      return value;
    }
    return value.toString();
  }

  bool _hasValue(dynamic value) {
    if (value == null) return false;
    if (value is String && value.isEmpty) return false;
    if (value is num) return true;
    if (value is Map) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;
    if (value is bool) return true;
    return true;
  }

  IconData _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) return Icons.image;
    if (['mp4', 'mov', 'avi', 'mkv'].contains(ext)) return Icons.video_file;
    if (['pdf'].contains(ext)) return Icons.picture_as_pdf;
    return Icons.insert_drive_file;
  }

  void _showConfirmationDialog(String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () { Navigator.pop(context); onConfirm(); }, child: Text('Confirm', style: TextStyle(color: Colors.red))),
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
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog('Error', 'Could not launch URL');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Are you sure you want to logout?', style: TextStyle(fontSize: 16)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showLogoutPurposeDialog(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Yes, Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutPurposeDialog(BuildContext context) {
    final List<String> purposes = [
      'Technical Issue',
      'User Interface Issue',
      'Found Better Alternative',
      'Not Satisfied with Service',
      'Security Concerns',
      'Account Management',
      'Other',
    ];

    String? selectedPurpose;
    String? customPurpose;
    TextEditingController customController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Reason for Logout', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Please help us improve by sharing your reason for leaving:', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 16),
                      ...purposes.map((purpose) => RadioListTile<String>(
                        title: Text(purpose),
                        value: purpose,
                        groupValue: selectedPurpose,
                        onChanged: (value) { setState(() { selectedPurpose = value; if (value != 'Other') customPurpose = null; }); },
                        activeColor: primaryColor,
                        contentPadding: EdgeInsets.zero,
                      )),
                      if (selectedPurpose == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: 'Please specify...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            onChanged: (value) { customPurpose = value; },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Back', style: TextStyle(color: Colors.grey[600]))),
                ElevatedButton(
                  onPressed: () {
                    final reason = selectedPurpose == 'Other' ? customPurpose : selectedPurpose;
                    if (reason != null && reason.isNotEmpty) {
                      Navigator.pop(context);
                      _showFeedbackDialog(context, reason);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a reason'), backgroundColor: Colors.red));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Continue', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context, String reason) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Feedback Matters!', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Reason: $reason', style: TextStyle(fontSize: 13, color: darkText, fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Any additional feedback?', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Your feedback helps us improve...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () { Navigator.pop(context); _showFinalLogoutConfirmation(context, reason, feedbackController.text); }, child: Text('Skip', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () { Navigator.pop(context); _showFinalLogoutConfirmation(context, reason, feedbackController.text); },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Submit & Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showFinalLogoutConfirmation(BuildContext context, String reason, String feedback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Final Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              const Text('Are you absolutely sure you want to logout and remove this resort?', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text('Resort: ${_getResortName()}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('This resort will be removed from your list.', style: TextStyle(fontSize: 12, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[600]))),
            ElevatedButton(
              onPressed: () async {
                await _saveLogoutFeedback(reason, feedback);
                await _removeCurrentResortFromList();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => ResortListScreen(
                      userData: widget.registrationData,
                      removedResortId: widget.resortId ?? _data['id'],
                      userEmail: _getUserEmail(),
                    ),
                  ),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Logout & Remove Resort', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveLogoutFeedback(String reason, String feedback) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> feedbackList = prefs.getStringList('logout_feedback') ?? [];

      final feedbackEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'reason': reason,
        'feedback': feedback,
        'userEmail': _getUserEmail(),
        'resortName': _getResortName(),
        'resortId': widget.resortId ?? _data['id'],
        'action': 'remove_resort',
      };

      feedbackList.add(jsonEncode(feedbackEntry));
      await prefs.setStringList('logout_feedback', feedbackList);

      print('Logout feedback saved: $feedbackEntry');
    } catch (e) {
      print('Error saving feedback: $e');
    }
  }

  Future<void> _removeCurrentResortFromList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String userEmail = _getUserEmail();

      String resortIdToRemove = '';

      if (widget.resortId != null && widget.resortId!.isNotEmpty) {
        resortIdToRemove = widget.resortId!;
      } else if (_data.containsKey('id') && _data['id'] != null && _data['id'].toString().isNotEmpty) {
        resortIdToRemove = _data['id'].toString();
      } else if (_data.containsKey('basicInfo') && _data['basicInfo'] is Map) {
        final basicInfo = _data['basicInfo'] as Map;
        if (basicInfo.containsKey('id')) {
          resortIdToRemove = basicInfo['id'].toString();
        }
      }

      print('=== REMOVING RESORT ===');
      print('User Email: $userEmail');
      print('Resort ID to remove: "$resortIdToRemove"');
      print('Resort Name: ${_getResortName()}');

      if (resortIdToRemove.isEmpty) {
        print('ERROR: Resort ID is empty! Cannot remove.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Could not identify resort to remove'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final String usersJson = prefs.getString('registered_users') ?? '[]';
      List<dynamic> usersList = jsonDecode(usersJson);

      int userIndex = -1;
      for (int i = 0; i < usersList.length; i++) {
        if (usersList[i]['email'] == userEmail) {
          userIndex = i;
          break;
        }
      }

      if (userIndex == -1) {
        print('User not found!');
        return;
      }

      Map<String, dynamic> userData = Map<String, dynamic>.from(usersList[userIndex]);

      if (userData.containsKey('resorts') && userData['resorts'] is List) {
        List<dynamic> resortsList = userData['resorts'];
        print('Original resorts count: ${resortsList.length}');

        final int initialCount = resortsList.length;
        resortsList.removeWhere((resort) {
          Map<String, dynamic> resortMap = Map<String, dynamic>.from(resort);
          String currentId = resortMap['id']?.toString() ?? '';
          return currentId == resortIdToRemove;
        });

        print('Removed ${initialCount - resortsList.length} resort(s)');
        print('Remaining resorts count: ${resortsList.length}');

        userData['resorts'] = resortsList;
        usersList[userIndex] = userData;

        await prefs.setString('registered_users', jsonEncode(usersList));
        print('Resort removed successfully!');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resort removed successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('No resorts list found in user data');
      }
    } catch (e) {
      print('Error removing resort: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error removing resort: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildGoogleMapLink() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.map, size: 18, color: primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getGoogleMapLink(),
              style: TextStyle(fontSize: 12, color: darkText),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOwnerPhotoWidget() {
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) {
        ownerPhoto = basicInfo['ownerPhoto'];
      }
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) {
      ownerPhoto = _data['ownerPhoto'];
    }

    if (ownerPhoto != null && ownerPhoto['path'] != null) {
      return Image.file(File(ownerPhoto['path']), fit: BoxFit.cover, width: 60, height: 60);
    }

    return Center(child: Icon(Icons.person_rounded, size: 35, color: primaryColor));
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
                style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditablePhoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(color: primaryMedium, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Mobile Number', style: TextStyle(fontSize: 13, color: lightText, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: TextStyle(fontSize: 13, color: lightText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                isDense: true,
              ),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    if (!_hasValue(value)) return const SizedBox.shrink();

    String displayValue = value.toString();
    if (label.contains('Price') || label.contains('Deposit') || label == 'Base Price' || label == 'Weekend Price' || label == 'Peak Season Price' || label == 'Extra Bed Charges') {
      displayValue = '₹${_formatPrice(value)}';
    } else if (label.contains('Rooms') || label == 'Guest Capacity' || label == 'Minimum Stay' || label == 'Advance Payment') {
      displayValue = _formatInteger(value);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: primaryMedium, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.05))),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: lightText, fontWeight: FontWeight.w500))),
          Expanded(flex: 4, child: Text(displayValue, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required String title, required IconData icon, required List<Widget> children}) {
    final filteredChildren = children.where((child) => child is Widget && child is! SizedBox).toList();
    if (filteredChildren.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
          BoxShadow(color: primaryColor.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)), child: Icon(icon, size: 18, color: primaryColor)),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredChildren,
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Resort Information',
            icon: Icons.nature_people,
            children: [
              _buildInfoRow('Resort Name', _getResortName()),
              _buildInfoRow('Resort Category', _getResortCategory()),
              // _buildInfoRow('Total Rooms', _getTotalRooms()),
              // _buildInfoRow('Room Capacity', _getTotalCapacity()),
              // if (_getPropertyArea().isNotEmpty) _buildInfoRow('Property Area', '${_getPropertyArea()} sq.ft./acres'),
              if (_getYearEstablished().isNotEmpty) _buildInfoRow('Year Established', _getYearEstablished()),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
                BoxShadow(color: primaryColor.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)), child: Icon(Icons.contact_phone, size: 18, color: primaryColor)),
                        const SizedBox(width: 12),
                        Text('Contact Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                      ],
                    ),
                    if (!_isEditingPhone)
                      GestureDetector(
                        onTap: () { setState(() { _isEditingPhone = true; _phoneController.text = _getUserPhone(); }); },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(20), border: Border.all(color: primaryColor.withOpacity(0.2))),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.edit, size: 14, color: primaryColor),
                            const SizedBox(width: 4),
                            Text('Edit Phone', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                          ]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Owner/Manager', _getUserFullName()),
                _buildInfoRow('Contact Person', _data['basicInfo']?['contactPerson']?.toString() ?? _data['contactPerson']?.toString() ?? 'Not provided'),
                if (_isEditingPhone) _buildEditablePhoneField() else _buildInfoRow('Mobile Number', _getUserPhone()),
                if (_getAlternateMobile().isNotEmpty && !_isEditingPhone) _buildInfoRow('Alternate Mobile', _getAlternateMobile()),
                if (_isEditingPhone)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () { setState(() { _isEditingPhone = false; _phoneController.text = _getUserPhone(); }); }, child: Text('Cancel', style: TextStyle(color: lightText))),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _savePhoneChanges,
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                _buildInfoRow('Email', _getUserEmail()),
                if (_getWebsite().isNotEmpty) _buildInfoRow('Website', _getWebsite()),
                if (_data['basicInfo']?['companyName']?.toString().isNotEmpty ?? false)
                  _buildInfoRow('Company Name', _data['basicInfo']['companyName'].toString()),
              ],
            ),
          ),
          if (_getOwnerPhotoWidget() is Image) Padding(padding: const EdgeInsets.only(top: 16), child: _buildPhotoTile()),
        ],
      ),
    );
  }

  Widget _buildPhotoTile() {
    Map<String, dynamic>? ownerPhoto;

    if (_data.containsKey('basicInfo') && _data['basicInfo'] != null) {
      final basicInfo = _data['basicInfo'] as Map;
      if (basicInfo.containsKey('ownerPhoto') && basicInfo['ownerPhoto']['uploaded'] == true) ownerPhoto = basicInfo['ownerPhoto'];
    }

    if (ownerPhoto == null && _data.containsKey('ownerPhoto') && _data['ownerPhoto']['uploaded'] == true) ownerPhoto = _data['ownerPhoto'];

    if (ownerPhoto == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]), borderRadius: BorderRadius.circular(14)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ownerPhoto['path'] != null ? Image.file(File(ownerPhoto['path']), fit: BoxFit.cover) : const Center(child: Icon(Icons.photo_camera, color: Colors.white, size: 24)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profile Photo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(ownerPhoto['name'] ?? 'Uploaded successfully', style: TextStyle(fontSize: 12, color: lightText), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.check_circle, size: 18, color: primaryColor)),
        ],
      ),
    );
  }

  // Widget _buildLocation() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Resort Location Details',
  //           icon: Icons.location_on,
  //           children: [
  //             _buildInfoRow('Address', _getAddress()),
  //             if (_getArea().isNotEmpty) _buildInfoRow('Area / Landmark', _getArea()),
  //             _buildInfoRow('City', _getCity()),
  //             _buildInfoRow('State', _getState()),
  //             _buildInfoRow('Pincode', _getPincode()),
  //             if (_getNearestAirport().isNotEmpty) _buildInfoRow('Nearest Airport', _getNearestAirport()),
  //             if (_getNearestRailway().isNotEmpty) _buildInfoRow('Nearest Railway', _getNearestRailway()),
  //             if (_getGoogleMapLink().isNotEmpty)
  //               Container(
  //                 margin: const EdgeInsets.only(bottom: 12),
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.2))),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.map, size: 18, color: primaryColor),
  //                     const SizedBox(width: 8),
  //                     Expanded(child: Text(_getGoogleMapLink(), style: TextStyle(fontSize: 12, color: darkText), maxLines: 2, overflow: TextOverflow.ellipsis)),
  //                   ],
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLocation() {
    final officeAddressChildren = <Widget>[];

    // Debug prints
    print('=== BUILDING LOCATION SECTION ===');
    print('Office Address: ${_getOfficeAddress()}');
    print('Office Area: ${_getOfficeArea()}');
    print('Office City: ${_getOfficeCity()}');
    print('Office State: ${_getOfficeState()}');
    print('Office Pincode: ${_getOfficePincode()}');
    print('Office GoogleMap: ${_getOfficeGoogleMapLink()}');

    // Build office address section only if there's data
    if (_getOfficeAddress() != 'Not provided' ||
        _getOfficeArea().isNotEmpty ||
        _getOfficeCity() != 'Not provided' ||
        _getOfficeGoogleMapLink().isNotEmpty) {
      officeAddressChildren.addAll([
        _buildInfoRow('Office Address', _getOfficeAddress()),
        if (_getOfficeArea().isNotEmpty)
          _buildInfoRow('Area / Locality', _getOfficeArea()),
        _buildInfoRow('City', _getOfficeCity()),
        _buildInfoRow('State', _getOfficeState()),
        _buildInfoRow('Pincode', _getOfficePincode()),
        if (_getOfficeGoogleMapLink().isNotEmpty)
          _buildOfficeGoogleMapLink(),
      ]);
    }

    // Resort Address children
    final resortAddressChildren = <Widget>[
      _buildInfoRow('Resort Address', _getAddress()),
      if (_getArea().isNotEmpty)
        _buildInfoRow('Area / Landmark', _getArea()),
      _buildInfoRow('City', _getCity()),
      _buildInfoRow('State', _getState()),
      _buildInfoRow('Pincode', _getPincode()),
      if (_getNearestAirport().isNotEmpty)
        _buildInfoRow('Nearest Airport', _getNearestAirport()),
      if (_getNearestRailway().isNotEmpty)
        _buildInfoRow('Nearest Railway', _getNearestRailway()),
      if (_getGoogleMapLink().isNotEmpty)
        _buildGoogleMapLink(),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Office Address Card - Only show if there's data
          if (officeAddressChildren.isNotEmpty)
            _buildGlassCard(
              title: 'Permanent Office Address',
              icon: Icons.business,
              children: officeAddressChildren,
            ),

          if (officeAddressChildren.isNotEmpty)
            const SizedBox(height: 16),

          // Resort Location Card
          _buildGlassCard(
            title: 'Resort Location Details',
            icon: Icons.location_on,
            children: resortAddressChildren,
          ),
        ],
      ),
    );
  }



  // Widget _buildPropertyDetails() {
  //   final description = _getDescription();
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Property Specifications',
  //           icon: Icons.architecture,
  //           children: [
  //             _buildInfoRow('Resort Category', _getResortCategory()),
  //             _buildInfoRow('Total Rooms', _getTotalRooms()),
  //             _buildInfoRow('Room Capacity', _getTotalCapacity()),
  //             if (_getPropertyArea().isNotEmpty)
  //               _buildInfoRow('Property Area', '${_getPropertyArea()} sq.ft./acres'),
  //             // if (_getYearEstablished().isNotEmpty)
  //             //   _buildInfoRow('Year Established', _getYearEstablished()),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         if (description.isNotEmpty)
  //           _buildGlassCard(
  //             title: 'Property Description',
  //             icon: Icons.description,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: primarySoft,
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: borderColor),
  //                 ),
  //                 child: Text(
  //                   description,
  //                   style: TextStyle(fontSize: 14, color: darkText, height: 1.5),
  //                 ),
  //               ),
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPropertyDetails() {
    final description = _getDescription();
    final starRatingDetails = _get('propertyDetails.starRatingDetails', []);
    final hasStarRatingDetails = starRatingDetails is List && starRatingDetails.isNotEmpty;

    print('Building property details, hasStarRatingDetails: $hasStarRatingDetails');
    if (hasStarRatingDetails) {
      print('Star rating details count: ${starRatingDetails.length}');
      for (var detail in starRatingDetails) {
        print('Star rating: ${detail['type']}, Rooms: ${detail['totalRooms']}, Capacity: ${detail['totalCapacity']}');
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Property Specifications',
            icon: Icons.architecture,
            children: [
              _buildInfoRow('Resort Category', _getResortCategory()),
              // Only show these if no star rating details
              if (!hasStarRatingDetails) ...[
                _buildInfoRow('Total Rooms', _getTotalRooms()),
                _buildInfoRow('Room Capacity', _getTotalCapacity()),
                if (_getPropertyArea().isNotEmpty)
                  _buildInfoRow('Property Area', '${_getPropertyArea()} sq.ft./acres'),
              ],
              if (_getYearEstablished().isNotEmpty)
                _buildInfoRow('Year Established', _getYearEstablished()),
            ],
          ),
          const SizedBox(height: 16),
          _buildStarRatingDetailsSection(),
          if (description.isNotEmpty && !hasStarRatingDetails)
            _buildGlassCard(
              title: 'Property Description',
              icon: Icons.description,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: darkText, height: 1.5),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }



  // Widget _buildStarRatingDetailsSection() {
  //   // Try multiple paths to find star rating details
  //   List? starRatingDetails = [];
  //
  //   // Try propertyDetails.starRatingDetails
  //   if (_data.containsKey('propertyDetails')) {
  //     final propertyDetails = _data['propertyDetails'];
  //     if (propertyDetails is Map) {
  //       if (propertyDetails.containsKey('starRatingDetails')) {
  //         starRatingDetails = propertyDetails['starRatingDetails'];
  //         print('Found starRatingDetails in propertyDetails.starRatingDetails: $starRatingDetails');
  //       }
  //     }
  //   }
  //
  //   // If not found, try direct starRatingDetails
  //   if (starRatingDetails == null || starRatingDetails.isEmpty) {
  //     if (_data.containsKey('starRatingDetails')) {
  //       starRatingDetails = _data['starRatingDetails'];
  //       print('Found starRatingDetails in _data.starRatingDetails: $starRatingDetails');
  //     }
  //   }
  //
  //   // If still not found, try selectedStarRatingDetails
  //   if (starRatingDetails == null || starRatingDetails.isEmpty) {
  //     if (_data.containsKey('selectedStarRatingDetails')) {
  //       final selectedDetails = _data['selectedStarRatingDetails'];
  //       if (selectedDetails is Map) {
  //         starRatingDetails = selectedDetails.values.toList();
  //         print('Found starRatingDetails in selectedStarRatingDetails: $starRatingDetails');
  //       }
  //     }
  //   }
  //
  //   // If still not found, try selectedStarRatings
  //   if (starRatingDetails == null || starRatingDetails.isEmpty) {
  //     if (_data.containsKey('selectedStarRatings')) {
  //       starRatingDetails = _data['selectedStarRatings'];
  //       print('Found selectedStarRatings: $starRatingDetails');
  //     }
  //   }
  //
  //   if (starRatingDetails is! List || starRatingDetails.isEmpty) {
  //     print('No star rating details found');
  //     return SizedBox.shrink();
  //   }
  //
  //   print('Building star rating cards for ${starRatingDetails.length} items');
  //
  //   List<Widget> starRatingCards = [];
  //
  //   for (var starRating in starRatingDetails) {
  //     // Handle both Map and StarRatingDetails objects
  //     Map<String, dynamic> starRatingMap;
  //
  //     if (starRating is StarRatingDetails) {
  //       starRatingMap = starRating.toJson();
  //     } else if (starRating is Map) {
  //       // Convert Map<dynamic, dynamic> to Map<String, dynamic>
  //       starRatingMap = Map<String, dynamic>.from(starRating);
  //     } else if (starRating is String) {
  //       // If it's just a string, skip it
  //       print('Found string star rating: $starRating - looking for details');
  //       continue;
  //     } else {
  //       continue;
  //     }
  //
  //     String ratingType = starRatingMap['type']?.toString() ??
  //         starRatingMap['starRating']?.toString() ??
  //         'Star Rating';
  //
  //     // Get selected room types
  //     final roomTypes = starRatingMap['roomTypes'] as Map? ?? {};
  //     final selectedRoomTypes = roomTypes.entries
  //         .where((e) => e.value == true)
  //         .map((e) => e.key.toString())
  //         .toList();
  //
  //     print('Building card for: $ratingType');
  //     print('Star rating data: $starRatingMap');
  //
  //     starRatingCards.add(
  //       Container(
  //         margin: EdgeInsets.only(bottom: 16),
  //         padding: EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [primaryColor.withOpacity(0.05), Colors.white],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(16),
  //           border: Border.all(color: primaryColor.withOpacity(0.2)),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //                   decoration: BoxDecoration(
  //                     color: primaryColor,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Text(
  //                     ratingType,
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //                 Spacer(),
  //                 if (starRatingMap['totalRooms']?.toString().isNotEmpty ?? false)
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //                     decoration: BoxDecoration(
  //                       color: _successColor.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     child: Text(
  //                       '${starRatingMap['totalRooms']} Rooms',
  //                       style: TextStyle(
  //                         fontSize: 11,
  //                         color: _successColor,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //             SizedBox(height: 16),
  //             Wrap(
  //               spacing: 12,
  //               runSpacing: 12,
  //               children: [
  //                 if (starRatingMap['totalRooms']?.toString().isNotEmpty ?? false)
  //                   _buildDetailChip(Icons.meeting_room, '${starRatingMap['totalRooms']} Rooms'),
  //                 if (starRatingMap['totalCapacity']?.toString().isNotEmpty ?? false)
  //                   _buildDetailChip(Icons.people, '${starRatingMap['totalCapacity']} Capacity'),
  //                 if (starRatingMap['propertyArea']?.toString().isNotEmpty ?? false)
  //                   _buildDetailChip(Icons.square_foot, starRatingMap['propertyArea']),
  //               ],
  //             ),
  //             if (selectedRoomTypes.isNotEmpty) ...[
  //               SizedBox(height: 12),
  //               Text('Room Types:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primaryColor)),
  //               SizedBox(height: 8),
  //               Wrap(
  //                 spacing: 8,
  //                 runSpacing: 8,
  //                 children: selectedRoomTypes.map((roomType) => Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                   decoration: BoxDecoration(
  //                     color: primarySoft,
  //                     borderRadius: BorderRadius.circular(12),
  //                     border: Border.all(color: primaryColor.withOpacity(0.3)),
  //                   ),
  //                   child: Text(roomType, style: TextStyle(fontSize: 11, color: primaryColor)),
  //                 )).toList(),
  //               ),
  //             ],
  //             if (starRatingMap['description']?.toString().isNotEmpty ?? false) ...[
  //               SizedBox(height: 12),
  //               Container(
  //                 padding: EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[50],
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: borderColor),
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Description',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w600,
  //                         color: primaryColor,
  //                       ),
  //                     ),
  //                     SizedBox(height: 6),
  //                     Text(
  //                       starRatingMap['description'].toString(),
  //                       style: TextStyle(fontSize: 13, color: darkText, height: 1.4),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //
  //   if (starRatingCards.isEmpty) {
  //     print('No star rating cards were built');
  //     return SizedBox.shrink();
  //   }
  //
  //   return Container(
  //     width: double.infinity,
  //     margin: EdgeInsets.only(bottom: 16),
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: cardColor,
  //       borderRadius: BorderRadius.circular(24),
  //       border: Border.all(color: borderColor),
  //       boxShadow: [
  //         BoxShadow(color: shadowColor, blurRadius: 20, offset: Offset(0, 8)),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 color: primarySoft,
  //                 borderRadius: BorderRadius.circular(14),
  //               ),
  //               child: Icon(Icons.star, size: 18, color: primaryColor),
  //             ),
  //             SizedBox(width: 12),
  //             Text(
  //               'Star Rating Details',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w700,
  //                 color: darkText,
  //                 letterSpacing: -0.3,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Divider(height: 24, color: borderColor),
  //         ...starRatingCards,
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStarRatingDetailsSection() {
    final starRatingDetails = _get('propertyDetails.starRatingDetails', []);

    if (starRatingDetails is! List || starRatingDetails.isEmpty) {
      print('No star rating details found');
      return SizedBox.shrink();
    }

    print('Building star rating cards for ${starRatingDetails.length} items');

    List<Widget> starRatingCards = [];

    for (var starRating in starRatingDetails) {
      if (starRating is Map) {
        String ratingType = starRating['type']?.toString() ?? '';

        // Get selected room types
        final roomTypes = starRating['roomTypes'] as Map? ?? {};
        final selectedRoomTypes = roomTypes.entries
            .where((e) => e.value == true)
            .map((e) => e.key.toString())
            .toList();

        starRatingCards.add(
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withOpacity(0.05), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        ratingType,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (starRating['totalRooms']?.toString().isNotEmpty ?? false)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${starRating['totalRooms']} Rooms',
                          style: TextStyle(
                            fontSize: 11,
                            color: _successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (starRating['totalRooms']?.toString().isNotEmpty ?? false)
                      _buildDetailChip(Icons.meeting_room, '${starRating['totalRooms']} Rooms'),
                    if (starRating['totalCapacity']?.toString().isNotEmpty ?? false)
                      _buildDetailChip(Icons.people, '${starRating['totalCapacity']} Capacity'),
                    if (starRating['yearEstablished']?.toString().isNotEmpty ?? false)
                      _buildDetailChip(Icons.calendar_today, 'Est. ${starRating['yearEstablished']}'), // Add this line
                    if (starRating['propertyArea']?.toString().isNotEmpty ?? false)
                      _buildDetailChip(Icons.square_foot, starRating['propertyArea']),
                  ],
                ),
                if (selectedRoomTypes.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text('Room Types:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primaryColor)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedRoomTypes.map((roomType) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: primarySoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor.withOpacity(0.3)),
                      ),
                      child: Text(roomType, style: TextStyle(fontSize: 11, color: primaryColor)),
                    )).toList(),
                  ),
                ],
                if (starRating['description']?.toString().isNotEmpty ?? false) ...[
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          starRating['description'].toString(),
                          style: TextStyle(fontSize: 13, color: darkText, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }
    }

    if (starRatingCards.isEmpty) {
      print('No star rating cards were built');
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.star, size: 18, color: primaryColor),
              ),
              SizedBox(width: 12),
              Text(
                'Star Rating Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: borderColor),
          ...starRatingCards,
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryColor),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: darkText, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Widget _buildRoomTypes() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Room Types Available', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkText)),
  //       const SizedBox(height: 12),
  //       Wrap(
  //         spacing: 8,
  //         runSpacing: 8,
  //         children: _roomTypes.entries.map((entry) {
  //           bool isSelected = entry.value;
  //           return Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //             decoration: BoxDecoration(
  //               color: isSelected ? primaryLight : Colors.grey[100],
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(color: isSelected ? primaryColor : Colors.grey[300]),
  //             ),
  //             child: Text(
  //               entry.key,
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: isSelected ? primaryColor : darkText,
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildAmenities() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (_resortAmenities.isNotEmpty)
            _buildEditableSection(
              title: 'Resort Amenities',
              icon: Icons.workspaces_filled,
              amenities: _resortAmenities,
              sectionId: 'amenities',
            ),
          const SizedBox(height: 16),
          _buildEditableSection(
            title: 'Room Types',
            icon: Icons.meeting_room,
            amenities: _roomTypes,
            sectionId: 'roomTypes',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildCustomAmenitiesCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableSection({
    required String title,
    required IconData icon,
    required Map<String, bool> amenities,
    required String sectionId,
  }) {
    bool isEditMode = _editModes[sectionId] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 16, color: primaryColor)),
                  const SizedBox(width: 12),
                  Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) { _autoSaveAmenities(); _editModes[sectionId] = false; }
                    else { _editModes[sectionId] = true; }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isEditMode ? Icons.check : Icons.edit, size: 14, color: isEditMode ? Colors.white : primaryColor),
                      const SizedBox(width: 4),
                      Text(isEditMode ? 'Submit' : 'Edit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? Colors.white : primaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.entries.map((entry) {
              bool isSelected = entry.value;
              return GestureDetector(
                onTap: isEditMode ? () { setState(() { amenities[entry.key] = !isSelected; _autoSaveAmenities(); }); } : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.8)]) : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: isSelected ? Colors.transparent : borderColor, width: isSelected ? 0 : 1),
                    boxShadow: isSelected ? [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))] : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) Icon(Icons.check_circle, size: 14, color: Colors.white)
                      else Icon(isEditMode ? Icons.circle_outlined : Icons.circle, size: 14, color: isEditMode ? lightText : borderColor),
                      const SizedBox(width: 6),
                      Text(entry.key, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? Colors.white : darkText)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAmenitiesCard() {
    final TextEditingController _customController = TextEditingController();
    bool isEditMode = _editModes['custom'] ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.stars, size: 16, color: primaryColor)),
                  const SizedBox(width: 12),
                  Text('Custom Amenities', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isEditMode) { _editModes['custom'] = false; _autoSaveAmenities(); }
                    else { _editModes['custom'] = true; }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primaryColor : primarySoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? Colors.transparent : primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isEditMode ? Icons.check : Icons.edit, size: 14, color: isEditMode ? Colors.white : primaryColor),
                      const SizedBox(width: 4),
                      Text(isEditMode ? 'Submit' : 'Edit', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? Colors.white : primaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isEditMode)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _customController,
                        decoration: InputDecoration(
                          hintText: 'Enter new amenity...',
                          hintStyle: TextStyle(fontSize: 12, color: lightText),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: borderColor)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_customController.text.trim().isNotEmpty) {
                            setState(() {
                              _customAmenities.add(_customController.text.trim());
                              _autoSaveAmenities();
                              _customController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          if (_customAmenities.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _customAmenities.asMap().entries.map((entry) {
                int index = entry.key;
                String amenity = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isEditMode ? primarySoft : cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isEditMode ? primaryColor.withOpacity(0.3) : borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(amenity, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isEditMode ? primaryColor : darkText)),
                      if (isEditMode) ...[
                        const SizedBox(width: 4),
                        GestureDetector(onTap: () { setState(() { _customAmenities.removeAt(index); _autoSaveAmenities(); }); }, child: Icon(Icons.close, size: 14, color: Colors.red)),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          if (_customAmenities.isEmpty && !isEditMode)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No custom amenities added', style: TextStyle(fontSize: 12, color: lightText, fontStyle: FontStyle.italic)),
            ),
        ],
      ),
    );
  }

  Widget _buildPricingPolicies() {
    final basePrice = _getPriceValue('basePrice');
    final weekendPrice = _getPriceValue('weekendPrice');
    final peakPrice = _getPriceValue('peakPrice');
    final extraBedCharges = _getExtraBedCharges();
    final childPolicy = _getChildPolicy();
    final minimumStay = _getPriceValue('minimumStay');
    final advancePayment = _getAdvancePayment();
    // final cancellationPolicy = _getDocumentInfo('cancellationPolicy');
    final cancellationPolicy = _getCancellationPolicy();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Pricing Information',
            icon: Icons.attach_money,
            children: [
              _buildEditablePriceField(label: 'Base Price', value: basePrice, key: 'basePrice'),
              _buildEditablePriceField(label: 'Weekend Price', value: weekendPrice, key: 'weekendPrice'),
              if (_hasValue(peakPrice)) _buildEditablePriceField(label: 'Peak Season Price', value: peakPrice, key: 'peakPrice'),
              if (_hasValue(extraBedCharges)) _buildEditablePriceField(label: 'Extra Bed Charges', value: extraBedCharges, key: 'extraBedCharges'),
              if (_hasValue(childPolicy)) _buildInfoRow('Child Policy', childPolicy),
              _buildEditableIntegerField(label: 'Minimum Stay', value: minimumStay, key: 'minimumStay', suffix: ' nights'),
              if (_hasValue(advancePayment)) _buildEditableIntegerField(label: 'Advance Payment', value: advancePayment, key: 'advancePayment', suffix: '%'),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Check-in/Check-out Timings',
            icon: Icons.access_time,
            children: [
              _buildEditableTimeField(
                label: 'Check-in Time',
                controller: _checkInController,
                onChanged: (value) { setState(() { _checkInTime = value; _autoSaveTimes(); }); },
              ),
              const SizedBox(height: 16),
              _buildEditableTimeField(
                label: 'Check-out Time',
                controller: _checkOutController,
                onChanged: (value) { setState(() { _checkOutTime = value; _autoSaveTimes(); }); },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Availability & Booking Settings',
            icon: Icons.calendar_today,
            children: [
              _buildInfoRow('Instant Booking', _getInstantBooking()),
              _buildInfoRow('Manual Approval Required', _getManualApproval()),
              _buildInfoRow('Available From Date', _getAvailableFromDate() != null
                  ? '${_getAvailableFromDate()!.day}/${_getAvailableFromDate()!.month}/${_getAvailableFromDate()!.year}'
                  : 'Not set'),
              if (_getBlackoutDates().isNotEmpty) _buildInfoRow('Blackout Dates', _getBlackoutDates()),
              if (_getSeasonalPricing().isNotEmpty) _buildInfoRow('Seasonal Pricing', _getSeasonalPricing()),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Policy Documents',
            icon: Icons.description,
            children: [
              _buildEditableDocumentItem(docName: 'Cancellation Policy', docType: 'cancellationPolicy', fileInfo: cancellationPolicy),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getDocumentInfo(String key) {
    Map<String, dynamic> legalData = {};
    Map<String, dynamic> bankData = {};
    Map<String, dynamic> pricingData = {};

    if (_data.containsKey('legal') && _data['legal'] is Map) {
      legalData = Map<String, dynamic>.from(_data['legal']);
    }
    if (_data.containsKey('bank') && _data['bank'] is Map) {
      bankData = Map<String, dynamic>.from(_data['bank']);
    }
    if (_data.containsKey('pricing') && _data['pricing'] is Map) {
      pricingData = Map<String, dynamic>.from(_data['pricing']);
    }

    if (key == 'businessReg') return _data['businessReg'] ?? legalData['businessReg'] ?? {'uploaded': false};
    if (key == 'idProof') return _data['idProof'] ?? legalData['idProof'] ?? {'uploaded': false};
    if (key == 'ownershipProof') return _data['ownershipProof'] ?? legalData['ownershipProof'] ?? {'uploaded': false};
    if (key == 'fireSafety') return _data['fireSafety'] ?? legalData['fireSafety'] ?? {'uploaded': false};
    if (key == 'cancelledCheque') return _data['cancelledCheque'] ?? bankData['cancelledCheque'] ?? {'uploaded': false};
    if (key == 'cancellationPolicy') return _data['cancellationPolicy'] ?? pricingData['cancellationPolicy'] ?? {'uploaded': false};

    return {'uploaded': false};
  }

  Widget _buildEditablePriceField({required String label, required dynamic value, required String key}) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.15))),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500))),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_hasValue(value) ? '₹${_formatPrice(value)}' : 'Not set', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor, width: 1.5)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500))),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    hintText: 'Enter amount',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () { setState(() { _priceEditModes[key] = false; }); }, child: Text('Cancel', style: TextStyle(fontSize: 11))),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  double? newValue = double.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      _data[key] = newValue;
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }
                      _priceEditModes[key] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label updated to ₹${_formatPrice(newValue)}'), backgroundColor: primaryColor, duration: Duration(seconds: 2)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid amount'), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Save', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableIntegerField({required String label, required dynamic value, required String key, String suffix = ''}) {
    bool isEditing = _priceEditModes[key] ?? false;
    final TextEditingController controller = TextEditingController(text: value?.toString() ?? '');

    if (!isEditing) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor.withOpacity(0.15))),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 13, color: mediumText, fontWeight: FontWeight.w500))),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_hasValue(value) ? '${_formatInteger(value)}$suffix' : 'Not set', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priceEditModes.updateAll((k, v) => false);
                        _priceEditModes[key] = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.edit, size: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor, width: 1.5)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12, color: mediumText, fontWeight: FontWeight.w500))),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    suffixText: suffix,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  autofocus: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () { setState(() { _priceEditModes[key] = false; }); }, child: Text('Cancel', style: TextStyle(fontSize: 11))),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  int? newValue = int.tryParse(controller.text);
                  if (newValue != null && newValue > 0) {
                    setState(() {
                      _data[key] = newValue;
                      if (_data.containsKey('pricing') && _data['pricing'] is Map) {
                        final pricing = _data['pricing'] as Map;
                        pricing[key] = newValue;
                        _data['pricing'] = pricing;
                      }
                      _priceEditModes[key] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label updated to $newValue$suffix'), backgroundColor: primaryColor, duration: Duration(seconds: 2)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid number'), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Save', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTimeField({required String label, required TextEditingController controller, required ValueChanged<String> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: darkText)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectTime(context, controller, onChanged),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.text.isNotEmpty ? _formatTimeForDisplay(controller.text) : 'Select time', style: TextStyle(fontSize: 14, color: controller.text.isNotEmpty ? darkText : lightText)),
                Icon(Icons.access_time, size: 20, color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller, ValueChanged<String> onChanged) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (controller.text.isNotEmpty) {
      try {
        List<String> parts = controller.text.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1].substring(0, 2));
          initialTime = TimeOfDay(hour: hour, minute: minute);
        }
      } catch (e) { initialTime = TimeOfDay.now(); }
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!),
    );

    if (pickedTime != null) {
      String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      controller.text = formattedTime;
      onChanged(formattedTime);
    }
  }

  String _formatTimeForDisplay(String time24) {
    if (time24.isEmpty) return '';
    try {
      List<String> parts = time24.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1].substring(0, 2));
        String period = hour >= 12 ? 'PM' : 'AM';
        int hour12 = hour % 12;
        if (hour12 == 0) hour12 = 12;
        return '${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
    } catch (e) { return time24; }
    return time24;
  }

  Widget _buildEditableDocumentItem({required String docName, required String docType, required Map<String, dynamic> fileInfo}) {
    bool isUploaded = fileInfo['uploaded'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUploaded ? primarySoft : primaryMedium,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isUploaded ? primaryColor.withOpacity(0.3) : borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(docName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: darkText)),
              Container(),
            ],
          ),
          const SizedBox(height: 8),
          if (isUploaded)
            GestureDetector(
              onTap: () => _viewDocument(fileInfo, docName),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Icon(_getFileIcon(fileInfo['name'] ?? ''), size: 20, color: primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fileInfo['name'] ?? 'Document', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${(fileInfo['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20, color: lightText),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Row(
                children: [
                  Icon(Icons.file_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(child: Text('No file uploaded', style: TextStyle(fontSize: 12, color: lightText))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaAndVirtualTour() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMediaSection(),
          const SizedBox(height: 16),
          _buildVirtualTourSection(),
        ],
      ),
    );
  }

  Widget _buildVirtualTourSection() {
    final String virtualTourLink = _getVirtualTourLink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.videocam, size: 18, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Text(
                'Virtual Tour',
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
          if (virtualTourLink.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primarySoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.link, size: 18, color: primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      virtualTourLink,
                      style: TextStyle(fontSize: 12, color: darkText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _launchURL(virtualTourLink),
                    icon: Icon(Icons.open_in_new, size: 18, color: primaryColor),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No virtual tour link available',
                      style: TextStyle(fontSize: 12, color: lightText),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaSection() {
    final List<Widget> mediaWidgets = [];

    final mediaCategories = {
      'exterior': {'label': 'Resort Exterior Photos', 'maxLimit': 2},
      'reception': {'label': 'Reception & Lobby Photos', 'maxLimit': 2},
      'rooms': {'label': 'Room Photos', 'maxLimit': 2},
      'pool_amenities': {'label': 'Pool & Amenities Photos', 'maxLimit': 5},
      'restaurant': {'label': 'Restaurant Photos', 'maxLimit': 2},
      'short_video': {'label': 'Short Promotional Video', 'maxLimit': 1},
    };

    mediaCategories.forEach((key, data) {
      final files = _getMediaFiles(key);
      final label = data['label'] as String;
      final maxLimit = data['maxLimit'] as int;
      bool isEditing = _mediaEditModes[key] ?? false;

      mediaWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildEditableMediaSection(
            label: label,
            mediaKey: key,
            files: files,
            maxLimit: maxLimit,
            isEditing: isEditing,
            onEditToggle: () { setState(() { _mediaEditModes[key] = !isEditing; }); },
            onUpload: () => _uploadMediaFile(key, label, maxLimit),
            onView: (file) => _viewMediaFile(file, label),
            onRemove: (index) => _removeMediaFile(key, index, label),
            onReplace: (index) => _replaceMediaFile(key, index, label),
          ),
        ),
      );
    });

    if (mediaWidgets.isEmpty) return const SizedBox.shrink();

    return _buildGlassCard(
      title: 'Media & Virtual Tour',
      icon: Icons.photo_library,
      children: mediaWidgets,
    );
  }

  Widget _buildEditableMediaSection({
    required String label,
    required String mediaKey,
    required List<Map<String, dynamic>> files,
    required int maxLimit,
    required bool isEditing,
    required VoidCallback onEditToggle,
    required VoidCallback onUpload,
    required Function(Map<String, dynamic>) onView,
    required Function(int) onRemove,
    required Function(int) onReplace,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkText)),
            if (!isEditing && files.isNotEmpty)
              GestureDetector(
                onTap: onEditToggle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: primarySoft, borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.edit, size: 12, color: primaryColor),
                    const SizedBox(width: 4),
                    Text('Edit', style: TextStyle(fontSize: 10, color: primaryColor, fontWeight: FontWeight.w500)),
                  ]),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (isEditing) ...[
          if (files.length < maxLimit)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onUpload,
                icon: Icon(Icons.cloud_upload, size: 18),
                label: Text('Upload ${files.length + 1}/$maxLimit'),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              ),
            ),
          const SizedBox(height: 8),
          ...files.asMap().entries.map((entry) {
            int index = entry.key;
            var file = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(_getFileIcon(file['name'] ?? ''), size: 20, color: primaryColor)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(file['name'] ?? 'File', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onView(file),
                          icon: Icon(Icons.visibility, size: 16),
                          label: Text('View'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: primaryColor), foregroundColor: primaryColor, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onReplace(index),
                          icon: Icon(Icons.refresh, size: 16),
                          label: Text('Replace'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.orange), foregroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onRemove(index),
                          icon: Icon(Icons.delete, size: 16),
                          label: Text('Remove'),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red), foregroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onEditToggle, child: Text('Done', style: TextStyle(color: primaryColor))),
            ],
          ),
        ] else ...[
          if (files.isNotEmpty)
            ...files.map((file) => GestureDetector(
              onTap: () => onView(file),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                child: Row(
                  children: [
                    Container(width: 40, height: 40, decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(_getFileIcon(file['name'] ?? ''), size: 20, color: primaryColor)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(file['name'] ?? 'File', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkText), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${(file['size'] / 1024).toStringAsFixed(1)} KB', style: TextStyle(fontSize: 10, color: lightText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 20, color: lightText),
                  ],
                ),
              ),
            ))
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
              child: Row(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 20, color: lightText),
                  const SizedBox(width: 12),
                  Expanded(child: Text('No files uploaded. Tap Edit to add.', style: TextStyle(fontSize: 12, color: lightText))),
                ],
              ),
            ),
        ],
      ],
    );
  }

  // Widget _buildLegalBank() {
  //   final businessReg = _getDocumentInfo('businessReg');
  //   final idProof = _getDocumentInfo('idProof');
  //   final ownershipProof = _getDocumentInfo('ownershipProof');
  //   final fireSafety = _getDocumentInfo('fireSafety');
  //   final cancelledCheque = _getDocumentInfo('cancelledCheque');
  //
  //   Map<String, dynamic> legalData = {};
  //   Map<String, dynamic> bankData = {};
  //
  //   if (_data.containsKey('legal') && _data['legal'] is Map) legalData = Map<String, dynamic>.from(_data['legal']);
  //   if (_data.containsKey('bank') && _data['bank'] is Map) bankData = Map<String, dynamic>.from(_data['bank']);
  //
  //   final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
  //   final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];
  //   final fssaiLicense = legalData['fssaiLicense'] ?? _data['fssaiLicense'];
  //   final tourismApproval = legalData['tourismApproval'] ?? _data['tourismApproval'];
  //   final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
  //   final bankName = bankData['bankName'] ?? _data['bankName'];
  //   final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
  //   final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
  //   final upiId = bankData['upiId'] ?? _data['upiId'];
  //
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         _buildGlassCard(
  //           title: 'Legal & Verification',
  //           icon: Icons.gavel,
  //           children: [
  //             _buildEditableDocumentItem(docName: 'Business Registration', docType: 'businessReg', fileInfo: businessReg),
  //             if (_hasValue(gstNumber)) _buildInfoRow('GST Number', gstNumber),
  //             if (_hasValue(tradeLicense)) _buildInfoRow('Trade License', tradeLicense),
  //             if (_hasValue(fssaiLicense)) _buildInfoRow('FSSAI License', fssaiLicense),
  //             _buildEditableDocumentItem(docName: 'ID Proof', docType: 'idProof', fileInfo: idProof),
  //             _buildEditableDocumentItem(docName: 'Ownership Proof', docType: 'ownershipProof', fileInfo: ownershipProof),
  //             _buildEditableDocumentItem(docName: 'Fire Safety Certificate', docType: 'fireSafety', fileInfo: fireSafety),
  //             if (_hasValue(tourismApproval)) _buildInfoRow('Tourism Approval', tourismApproval),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _buildGlassCard(
  //           title: 'Bank Details',
  //           icon: Icons.account_balance,
  //           children: [
  //             if (_hasValue(accountHolder)) _buildInfoRow('Account Holder', accountHolder),
  //             if (_hasValue(bankName)) _buildInfoRow('Bank Name', bankName),
  //             if (_hasValue(accountNumber)) _buildInfoRow('Account Number', _maskAccountNumber(accountNumber.toString())),
  //             if (_hasValue(ifscCode)) _buildInfoRow('IFSC Code', ifscCode),
  //             if (_hasValue(upiId)) _buildInfoRow('UPI ID', upiId),
  //             _buildEditableDocumentItem(docName: 'Cancelled Cheque', docType: 'cancelledCheque', fileInfo: cancelledCheque),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLegalBank() {
    final businessReg = _getDocumentInfo('businessReg');
    final idProof = _getDocumentInfo('idProof');
    final ownershipProof = _getDocumentInfo('ownershipProof');
    final fireSafety = _getDocumentInfo('fireSafety');
    final cancelledCheque = _getDocumentInfo('cancelledCheque');
    final gstBillingDetails = _getGstBillingDetails();

    Map<String, dynamic> legalData = {};
    Map<String, dynamic> bankData = {};

    if (_data.containsKey('legal') && _data['legal'] is Map) legalData = Map<String, dynamic>.from(_data['legal']);
    if (_data.containsKey('bank') && _data['bank'] is Map) bankData = Map<String, dynamic>.from(_data['bank']);

    final gstNumber = legalData['gstNumber'] ?? _data['gstNumber'];
    final tradeLicense = legalData['tradeLicense'] ?? _data['tradeLicense'];
    final fssaiLicense = legalData['fssaiLicense'] ?? _data['fssaiLicense'];
    final tourismApproval = legalData['tourismApproval'] ?? _data['tourismApproval'];
    final accountHolder = bankData['accountHolder'] ?? _data['accountHolder'];
    final bankName = bankData['bankName'] ?? _data['bankName'];
    final accountNumber = bankData['accountNumber'] ?? _data['accountNumber'];
    final ifscCode = bankData['ifscCode'] ?? _data['ifscCode'];
    final upiId = bankData['upiId'] ?? _data['upiId'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildGlassCard(
            title: 'Legal & Verification',
            icon: Icons.gavel,
            children: [
              _buildEditableDocumentItem(docName: 'Business Registration', docType: 'businessReg', fileInfo: businessReg),
              if (_hasValue(gstNumber)) _buildInfoRow('GST Number', gstNumber),
              if (_hasValue(tradeLicense)) _buildInfoRow('Trade License', tradeLicense),
              if (_hasValue(fssaiLicense)) _buildInfoRow('FSSAI License', fssaiLicense),
              _buildEditableDocumentItem(docName: 'ID Proof', docType: 'idProof', fileInfo: idProof),
              _buildEditableDocumentItem(docName: 'Ownership Proof', docType: 'ownershipProof', fileInfo: ownershipProof),
              _buildEditableDocumentItem(docName: 'Fire Safety Certificate', docType: 'fireSafety', fileInfo: fireSafety),
              if (_hasValue(tourismApproval)) _buildInfoRow('Tourism Approval', tourismApproval),
            ],
          ),
          const SizedBox(height: 16),
          _buildGlassCard(
            title: 'Bank Details',
            icon: Icons.account_balance,
            children: [
              if (_hasValue(accountHolder)) _buildInfoRow('Account Holder', accountHolder),
              if (_hasValue(bankName)) _buildInfoRow('Bank Name', bankName),
              if (_hasValue(accountNumber)) _buildInfoRow('Account Number', _maskAccountNumber(accountNumber.toString())),
              if (_hasValue(ifscCode)) _buildInfoRow('IFSC Code', ifscCode),
              if (_hasValue(upiId)) _buildInfoRow('UPI ID', upiId),
              if (_hasValue(gstBillingDetails)) _buildInfoRow('GST Billing Details', gstBillingDetails),
              _buildEditableDocumentItem(docName: 'Cancelled Cheque', docType: 'cancelledCheque', fileInfo: cancelledCheque),
            ],
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return 'XXXX XXXX ${accountNumber.substring(accountNumber.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
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
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(child: Icon(Icons.nature_people, color: Colors.white, size: 32)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getResortName(),
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _getResortCategory(),
                                          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.qr_code, size: 14, color: Colors.white.withOpacity(0.7)),
                                      const SizedBox(width: 4),
                                      Text(
                                        'ID: ${_getRegistrationId()}',
                                        style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500),
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
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              GestureDetector(
                onTap: () => _showLogoutConfirmationDialog(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.logout, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              color: bgColor,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: shadowColor, blurRadius: 20, offset: const Offset(0, 8)),
                        BoxShadow(color: primaryColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.7)]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(18)),
                                  child: ClipRRect(borderRadius: BorderRadius.circular(18), child: _getOwnerPhotoWidget()),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickAndUploadPhoto,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                  child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserFullName(),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: darkText, letterSpacing: -0.3),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(child: _buildInfoChip(icon: Icons.phone_outlined, value: _getUserPhone())),
                                  const SizedBox(width: 8),
                                  Expanded(child: _buildInfoChip(icon: Icons.email_outlined, value: _getUserEmail())),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      boxShadow: [BoxShadow(color: shadowColor, blurRadius: 10, offset: const Offset(0, -2))],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: primaryColor,
                      unselectedLabelColor: lightText,
                      indicatorColor: primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      tabs: const [
                        Tab(text: 'Basic Info'),
                        Tab(text: 'Location'),
                        Tab(text: 'Property Details'),
                        Tab(text: 'Amenities'),
                        Tab(text: 'Pricing & Policies'),
                        Tab(text: 'Media & Virtual Tour'),
                        Tab(text: 'Legal & Bank'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildBasicInfo(),
                        _buildLocation(),
                        _buildPropertyDetails(),
                        _buildAmenities(),
                        _buildPricingPolicies(),
                        _buildMediaAndVirtualTour(),
                        _buildLegalBank(),
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

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }
}

