import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../onboarding_screen/choose_role_screen.dart';


class VillaBusinessDashboard extends StatefulWidget {
  final String villaName;
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
  final String panNumber;
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branch;
  final String accountType;
  final int totalVillas;
  final Map<String, dynamic> personPhotoInfo;
  final Map<String, dynamic> registrationData;

  const VillaBusinessDashboard({
    Key? key,
    required this.villaName,
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
    required this.aadharNumber,
    required this.panNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branch,
    required this.accountType,
    required this.totalVillas,
    required this.personPhotoInfo,
    required this.registrationData,
  }) : super(key: key);

  @override
  _VillaBusinessDashboardState createState() => _VillaBusinessDashboardState();
}

class _VillaBusinessDashboardState extends State<VillaBusinessDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = Color(0xFF2E7D32); // Forest Green for Villas
  final Color _primaryLight = Color(0xFF4CAF50);
  final Color _secondaryColor = Color(0xFF8B5A2B); // Wood/Brown
  final Color _accentColor = Color(0xFFFFD54F); // Gold/Yellow
  final Color _bgColor = Color(0xFFF9FAFB);
  final Color _cardBg = Colors.white;
  final Color _textDark = Color(0xFF111827);
  final Color _textLight = Color(0xFF6B7280);
  final Color _borderColor = Color(0xFFE5E7EB);
  final Color _successColor = Color(0xFF10B981);
  final Color _warningColor = Color(0xFFF59E0B);
  final Color _dangerColor = Color(0xFFEF4444);

  String _selectedMonth = 'January';
  String _selectedVillaType = 'All';
  String _selectedGraphFilter = 'Daily';
  List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];


  final List<String> _villaTypesList = [
    'Luxury Villa',
    'Beach Villa',
    'Pool Villa',
    'Farm House',
    'Budget Villa',
    'Service Apartment',
  ];

  DateTime _selectedStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now();

  List<Map<String, dynamic>> _villaTypeData = [];

  @override
  void initState() {
    super.initState();
    _initializeVillaData();
  }

  void _initializeVillaData() {
    final propertyDetails = widget.registrationData['propertyDetails'] as Map?;
    final villaTypes = propertyDetails?['villaTypes'] as List? ?? [];

    _villaTypeData.clear();

    if (villaTypes.isNotEmpty) {
      for (var villa in villaTypes) {
        if (villa is Map) {
          int totalUnits = int.tryParse(villa['totalUnits']?.toString() ?? '0') ?? 0;
          double price = double.tryParse(villa['price']?.toString() ?? '0') ?? 0;
          int bedrooms = int.tryParse(villa['bedrooms']?.toString() ?? '0') ?? 0;
          int bathrooms = int.tryParse(villa['bathrooms']?.toString() ?? '0') ?? 0;
          int capacity = int.tryParse(villa['guestCapacity']?.toString() ?? '0') ?? 0;

          int availableUnits = (totalUnits * 0.35).round();
          int occupiedUnits = (totalUnits * 0.55).round();
          int cancellationUnits = (totalUnits * 0.10).round();

          _villaTypeData.add({
            'type': villa['type']?.toString() ?? 'Villa',
            'total': totalUnits,
            'price': price,
            'bedrooms': bedrooms,
            'bathrooms': bathrooms,
            'capacity': capacity,
            'available': availableUnits,
            'occupied': occupiedUnits,
            'cancellation': cancellationUnits,
          });
        }
      }
    } else {

      _generateSampleVillaData();
    }
  }

  void _generateSampleVillaData() {
    _villaTypeData = [
      {
        'type': 'Luxury Villa',
        'total': 8,
        'price': 15000.0,
        'bedrooms': 5,
        'bathrooms': 6,
        'capacity': 12,
        'available': 3,
        'occupied': 4,
        'cancellation': 1,
      },
      {
        'type': 'Beach Villa',
        'total': 12,
        'price': 12000.0,
        'bedrooms': 4,
        'bathrooms': 4,
        'capacity': 10,
        'available': 5,
        'occupied': 6,
        'cancellation': 1,
      },
      {
        'type': 'Pool Villa',
        'total': 10,
        'price': 10000.0,
        'bedrooms': 3,
        'bathrooms': 3,
        'capacity': 8,
        'available': 4,
        'occupied': 5,
        'cancellation': 1,
      },
      {
        'type': 'Farm House',
        'total': 6,
        'price': 8000.0,
        'bedrooms': 3,
        'bathrooms': 3,
        'capacity': 8,
        'available': 2,
        'occupied': 3,
        'cancellation': 1,
      },
      {
        'type': 'Budget Villa',
        'total': 15,
        'price': 5000.0,
        'bedrooms': 2,
        'bathrooms': 2,
        'capacity': 6,
        'available': 6,
        'occupied': 7,
        'cancellation': 2,
      },
      {
        'type': 'Service Apartment',
        'total': 20,
        'price': 4000.0,
        'bedrooms': 2,
        'bathrooms': 2,
        'capacity': 5,
        'available': 8,
        'occupied': 9,
        'cancellation': 3,
      },
    ];
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
        onPressed: () => _addNewVilla(),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
          : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _cardBg,
      elevation: 1,
      shadowColor: Colors.black12,
      leading: Builder(
        builder: (context) => Container(
          margin: EdgeInsets.only(left: 5),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: _primaryColor, size: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Villa Business Dashboard',
                style: TextStyle(
                  color: _textDark,
                  fontSize: 16.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
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

  // Widget _buildBody(double w, double h, bool isTablet) {
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       await Future.delayed(Duration(seconds: 1));
  //       setState(() {
  //         _initializeVillaData();
  //       });
  //     },
  //     child: SingleChildScrollView(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildSummarySection(),
  //           SizedBox(height: 24),
  //           _buildVillaTypesTable(),
  //           SizedBox(height: 24),
  //           _buildBookingInsightsGraph(),
  //           SizedBox(height: 24),
  //           _buildMonthlyBookingStats(),
  //           SizedBox(height: 40),
  //           _buildPaymentOverview(),
  //           SizedBox(height: 24),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildBody(double w, double h, bool isTablet) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          _initializeVillaData();
        });
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            SizedBox(height: 24),
            _buildVillaTypesTable(),
            SizedBox(height: 24),
            _buildBookingInsightsGraph(),
            SizedBox(height: 24),
            _buildMonthlyBookingStats(),
            SizedBox(height: 40),
            _buildPaymentOverview(),
            SizedBox(height: 24),


            _buildGoToDashboardButton(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  Widget _buildSummarySection() {
    int totalRooms = _villaTypeData.fold<int>(0, (sum, item) => sum + (item['total'] as int));
    int totalAvailableRooms = _villaTypeData.fold<int>(0, (sum, item) => sum + (item['available'] as int));
    int totalOccupiedRooms = _villaTypeData.fold<int>(0, (sum, item) => sum + (item['occupied'] as int));
    int totalCancellationRooms = _villaTypeData.fold<int>(0, (sum, item) => sum + (item['cancellation'] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Villa Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)),
                  SizedBox(width: 6),
                  Text('Live Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
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
            _buildSummaryCard(title: 'Total Rooms', value: totalRooms.toString(), icon: Icons.house_rounded, color: _secondaryColor, subtitle: 'All villa rooms'),
            _buildSummaryCard(title: 'Available Rooms', value: totalAvailableRooms.toString(), icon: Icons.event_available_rounded, color: _successColor, subtitle: 'Ready for booking'),
            _buildSummaryCard(title: 'Occupied Rooms', value: totalOccupiedRooms.toString(), icon: Icons.bed_rounded, color: _primaryColor, subtitle: 'Currently booked'),
            _buildSummaryCard(title: 'Cancellation', value: totalCancellationRooms.toString(), icon: Icons.cancel_rounded, color: _dangerColor, subtitle: 'Cancelled bookings'),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Icon(icon, size: 24, color: color)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 11, color: _textLight)),
        ],
      ),
    );
  }

  // Widget _buildVillaTypesTable() {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: _cardBg,
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(color: _borderColor),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Villa Room Configuration',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  //               decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
  //               child: Row(
  //                 children: [
  //                   Icon(Icons.table_chart_rounded, size: 14, color: _primaryColor),
  //                   SizedBox(width: 6),
  //                   Text('Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
  //           decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: _borderColor)),
  //           child: Row(
  //             children: [
  //               Expanded(flex: 2, child: Text('Villa Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark))),
  //               Expanded(child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Beds', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Guests', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Available', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Occupied', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         ..._villaTypeData.map((villa) {
  //           return Container(
  //             margin: EdgeInsets.only(bottom: 8),
  //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //             decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: _borderColor)),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   flex: 2,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(villa['type'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
  //                       SizedBox(height: 2),
  //                       Text('${villa['bedrooms']}BHK', style: TextStyle(fontSize: 10, color: _textLight)),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     children: [
  //                       Text('${villa['total']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.blue)),
  //                       Text('Units', style: TextStyle(fontSize: 10, color: _textLight)),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
  //                       Text('${villa['price']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor)),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text('${villa['bedrooms']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green), textAlign: TextAlign.center),
  //                 ),
  //                 Expanded(
  //                   child: Text('${villa['capacity']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.orange), textAlign: TextAlign.center),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                     decoration: BoxDecoration(color: _successColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
  //                     child: Text('${villa['available']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor), textAlign: TextAlign.center),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                     decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
  //                     child: Text('${villa['occupied']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor), textAlign: TextAlign.center),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         SizedBox(height: 16),
  //         Container(
  //           padding: EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             color: _primaryColor.withOpacity(0.05),
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: _primaryColor.withOpacity(0.2)),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Summary:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark)),
  //               Row(
  //                 children: [
  //                   _buildSummaryItem('Total:', _villaTypeData.fold<int>(89, (sum, v) => sum + (v['total'] as int)).toString(), Colors.blue),
  //                   SizedBox(width: 16),
  //                   _buildSummaryItem('Available:', _villaTypeData.fold<int>(50, (sum, v) => sum + (v['available'] as int)).toString(), _successColor),
  //                   SizedBox(width: 16),
  //                   _buildSummaryItem('Occupied:', _villaTypeData.fold<int>(39, (sum, v) => sum + (v['occupied'] as int)).toString(), _primaryColor),
  //                   SizedBox(width: 16),
  //                   _buildSummaryItem('Cancellation:', _villaTypeData.fold<int>(0, (sum, v) => sum + (v['cancellation'] as int)).toString(), _dangerColor),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildVillaTypesTable() {

    int totalUnits = _villaTypeData.fold<int>(0, (sum, v) => sum + (v['total'] as int));
    int totalAvailable = _villaTypeData.fold<int>(0, (sum, v) => sum + (v['available'] as int));
    int totalOccupied = _villaTypeData.fold<int>(0, (sum, v) => sum + (v['occupied'] as int));
    int totalCancellation = _villaTypeData.fold<int>(0, (sum, v) => sum + (v['cancellation'] as int));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
                'Villa Room Configuration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.table_chart_rounded, size: 14, color: _primaryColor),
                    SizedBox(width: 6),
                    Text('Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 120, child: Text('Villa Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark))),
                        SizedBox(width: 70, child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 70, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 60, child: Text('Beds', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 70, child: Text('Guests', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 80, child: Text('Available', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 80, child: Text('Occupied', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Table rows
                  ..._villaTypeData.map((villa) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: _bgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  villa['type'],
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${villa['bedrooms']}BHK • ${villa['bathrooms']} Bath',
                                  style: TextStyle(fontSize: 10, color: _textLight),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Column(
                              children: [
                                Text(
                                  '${villa['total']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.blue),
                                ),
                                Text('Units', style: TextStyle(fontSize: 10, color: _textLight)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                                Text(
                                  '${villa['price']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${villa['bedrooms']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              '${villa['capacity']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.orange),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _successColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${villa['available']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${villa['occupied']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),


          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Summary:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark)),
                  SizedBox(width: 16),
                  _buildSummaryItem('Total:', totalUnits.toString(), Colors.blue),
                  SizedBox(width: 16),
                  _buildSummaryItem('Available:', totalAvailable.toString(), _successColor),
                  SizedBox(width: 16),
                  _buildSummaryItem('Occupied:', totalOccupied.toString(), _primaryColor),
                  SizedBox(width: 16),
                  _buildSummaryItem('Cancellation:', totalCancellation.toString(), _dangerColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: _textLight)),
        SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }

  Widget _buildBookingInsightsGraph() {
    Map<String, List<double>> _generateWaveData(String villaType) {
      Map<String, List<double>> data = {};
      for (String type in _villaTypesList) {
        if (villaType == 'All' || villaType == type) {
          List<double> wavePoints = [];
          int days = 30;
          for (int i = 0; i < days; i++) {
            double baseValue = 0;
            switch (type) {
              case 'Luxury Villa': baseValue = 15; break;
              case 'Beach Villa': baseValue = 12; break;
              case 'Pool Villa': baseValue = 10; break;
              case 'Farm House': baseValue = 8; break;
              case 'Budget Villa': baseValue = 6; break;
              case 'Service Apartment': baseValue = 5; break;
            }
            double variation = sin(i * 0.3) * 3 + cos(i * 0.5) * 2;
            double trend = i * 0.08;
            double noise = (Random().nextDouble() * 2) - 1;
            wavePoints.add(baseValue + variation + trend + noise);
          }
          data[type] = wavePoints;
        }
      }
      if (villaType == 'All') {
        List<double> combinedData = [];
        for (int i = 0; i < 30; i++) {
          double combinedValue = 0;
          data.forEach((type, wavePoints) { combinedValue += wavePoints[i]; });
          combinedData.add(combinedValue);
        }
        data['All'] = combinedData;
      }
      return data;
    }

    Map<String, List<double>> waveData = _generateWaveData(_selectedVillaType);
    List<double> currentWaveData = waveData[_selectedVillaType] ?? waveData['All'] ?? [];

    if (currentWaveData.isEmpty) {
      return SizedBox.shrink();
    }

    double maxValue = currentWaveData.reduce((a, b) => a > b ? a : b);
    double minValue = currentWaveData.reduce((a, b) => a < b ? a : b);
    double average = currentWaveData.isNotEmpty ? currentWaveData.reduce((a, b) => a + b) / currentWaveData.length : 0;
    double currentValue = currentWaveData.isNotEmpty ? currentWaveData.last : 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Trends Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
            ],
          ),
          SizedBox(height: 16),
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
                          Text('Villa Type', style: TextStyle(fontSize: 12, color: _textLight)),
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
                                value: _selectedVillaType,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down_rounded, color: _primaryColor),
                                items: [
                                  DropdownMenuItem(value: 'All', child: Text('All Villas')),
                                  ..._villaTypesList.map<DropdownMenuItem<String>>((String type) =>
                                      DropdownMenuItem(value: type, child: Text(type))
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedVillaType = value!;
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
                          Text('Date Range', style: TextStyle(fontSize: 12, color: _textLight)),
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
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 1, color: _borderColor, margin: EdgeInsets.symmetric(horizontal: 8)),
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
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
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
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  SizedBox(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 45,
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _getVillaTypeLabels(),
                          ),
                        ),
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
                                for (int i = 0; i <= 4; i++)
                                  Positioned(
                                    top: (200 * i / 4),
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 1,
                                      color: _borderColor.withOpacity(0.3),
                                    ),
                                  ),
                                CustomPaint(
                                  size: Size(double.infinity, 200),
                                  painter: _VillaBookingTrendGraphPainter(
                                    data: currentWaveData,
                                    maxValue: maxValue,
                                    minValue: minValue,
                                    primaryColor: _primaryColor,
                                    secondaryColor: _secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // X-axis labels
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: EdgeInsets.only(left: 45),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 1, color: _borderColor),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          SizedBox(height: 4),
                                          Text('0', style: TextStyle(fontSize: 9, color: _textLight)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          SizedBox(height: 4),
                                          Text('10', style: TextStyle(fontSize: 9, color: _textLight)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          SizedBox(height: 4),
                                          Text('20', style: TextStyle(fontSize: 9, color: _textLight)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          SizedBox(height: 4),
                                          Text('30', style: TextStyle(fontSize: 9, color: _textLight)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              'Days',
                              style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 16),
          // Stats row
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGraphStatItem(title: 'Current', value: currentValue.toStringAsFixed(1), color: _primaryColor),
                _buildGraphStatItem(title: 'Average', value: average.toStringAsFixed(1), color: _secondaryColor),
                _buildGraphStatItem(title: 'Maximum', value: maxValue.toStringAsFixed(1), color: _successColor),
                _buildGraphStatItem(title: 'Minimum', value: minValue.toStringAsFixed(1), color: _warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getVillaTypeLabels() {
    double itemHeight = 200 / _villaTypesList.length;

    if (_selectedVillaType == 'All') {
      return _villaTypesList.asMap().entries.map((entry) {
        String villaType = entry.value;
        return SizedBox(
          height: itemHeight,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                villaType,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList();
    } else {
      return [
        SizedBox(
          height: 200,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                _selectedVillaType,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ];
    }
  }

  Widget _buildGraphStatItem({required String title, required String value, required Color color}) {
    return Column(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _textDark)),
        Text(title, style: TextStyle(fontSize: 10, color: _textLight)),
      ],
    );
  }

  Future<void> _showStartDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2001),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark)), child: child!),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
        if (_selectedEndDate.isBefore(picked)) _selectedEndDate = picked;
      });
    }
  }

  Future<void> _showEndDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark)), child: child!),
    );
    if (picked != null) {
      setState(() { _selectedEndDate = picked; });
    }
  }

  Widget _buildMonthlyBookingStats() {
    Map<String, Map<String, dynamic>> monthlyStats = {
      'January': {'totalBookings': 89, 'confirmed': 38, 'pending': 10, 'cancelled': 6, 'completed': 35, 'revenue': 245000, 'occupancy': 72.5},
      'February': {'totalBookings': 102, 'confirmed': 45, 'pending': 12, 'cancelled': 8, 'completed': 37, 'revenue': 285000, 'occupancy': 75.3},
      'March': {'totalBookings': 95, 'confirmed': 42, 'pending': 9, 'cancelled': 5, 'completed': 39, 'revenue': 268000, 'occupancy': 73.8},
    };
    Map<String, dynamic> selectedStats = monthlyStats[_selectedMonth] ?? {'totalBookings': 0, 'confirmed': 0, 'pending': 0, 'cancelled': 0, 'completed': 0, 'revenue': 0, 'occupancy': 0};

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly Statistics ($_selectedMonth)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
                    items: _months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month, style: TextStyle(fontSize: 12)));
                    }).toList(),
                    onChanged: (value) { setState(() { _selectedMonth = value!; }); },
                  ),
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
              _buildStatCard(title: 'Total Bookings', value: selectedStats['totalBookings'].toString(), change: '+8%', isPositive: true, icon: Icons.calendar_month_rounded),
              _buildStatCard(title: 'Revenue', value: '₹${(selectedStats['revenue'] / 1000).toStringAsFixed(0)}K', change: '+10%', isPositive: true, icon: Icons.currency_rupee_rounded),
              _buildStatCard(title: 'Occupancy Rate', value: '${selectedStats['occupancy']}%', change: '+4%', isPositive: true, icon: Icons.bar_chart_rounded),
              _buildStatCard(title: 'Cancellation', value: '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%', change: '-1%', isPositive: false, icon: Icons.cancel_rounded),
            ],
          ),
          SizedBox(height: 20),
          Text('Booking Status Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _textDark)),
          SizedBox(height: 12),
          ..._bookingStatuses.map((status) {
            int count = selectedStats[status.toLowerCase()] ?? 0;
            double percentage = selectedStats['totalBookings'] > 0 ? (count / selectedStats['totalBookings']) * 100 : 0;
            Color statusColor = _getStatusColor(status);
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)), SizedBox(width: 10), Text(status, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark))]),
                    Text('$count (${percentage.toStringAsFixed(1)}%)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: statusColor)),
                  ]),
                  SizedBox(height: 8),
                  LinearProgressIndicator(value: count / selectedStats['totalBookings'], backgroundColor: _borderColor, color: statusColor, minHeight: 6, borderRadius: BorderRadius.circular(3)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, String? subValue, required String change, required bool isPositive, required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Icon(icon, size: 20, color: _primaryColor))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isPositive ? _successColor.withOpacity(0.1) : _dangerColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [Icon(isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, size: 12, color: isPositive ? _successColor : _dangerColor), SizedBox(width: 4), Text(change, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isPositive ? _successColor : _dangerColor))]),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark)),
          if (subValue != null && subValue.isNotEmpty) ...[SizedBox(height: 2), Text(subValue, style: TextStyle(fontSize: 11, color: _textLight, fontWeight: FontWeight.w600))],
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: _textLight)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return _successColor;
      case 'Pending': return _warningColor;
      case 'Cancelled': return _dangerColor;
      case 'Completed': return _secondaryColor;
      default: return _primaryColor;
    }
  }

  // Widget _buildPaymentOverview() {
  //   List<Map<String, dynamic>> paymentData = [];
  //
  //   for (var villa in _villaTypeData) {
  //     paymentData.add({
  //       'villaType': villa['type'],
  //       'bookedCount': villa['occupied'],
  //       'pricePerNight': villa['price'],
  //       'totalNights': 7,
  //       'totalAmount': (villa['occupied'] as int) * (villa['price'] as double) * 7,
  //       'paymentStatus': 'Paid',
  //       'paymentDate': '2024-01-15',
  //     });
  //   }
  //
  //   double totalProfit = paymentData.fold(0.0, (sum, item) => sum + (item['totalAmount'] as double));
  //
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(20),
  //     decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: _borderColor)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('Payment Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark)),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
  //               child: Row(children: [Icon(Icons.payment_rounded, size: 14, color: _primaryColor), SizedBox(width: 6), Text('Revenue Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor))]),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
  //           decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), border: Border.all(color: _borderColor)),
  //           child: Row(
  //             children: [
  //               Expanded(flex: 2, child: Text('Villa Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark))),
  //               Expanded(child: Text('Booked', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //               Expanded(child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
  //             ],
  //           ),
  //         ),
  //         ...paymentData.map((payment) {
  //           return Container(
  //             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
  //             decoration: BoxDecoration(color: _cardBg, border: Border(bottom: BorderSide(color: _borderColor), left: BorderSide(color: _borderColor), right: BorderSide(color: _borderColor))),
  //             child: Row(
  //               children: [
  //                 Expanded(flex: 2, child: Text(payment['villaType'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark))),
  //                 Expanded(child: Text('${payment['bookedCount']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor), textAlign: TextAlign.center)),
  //                 Expanded(
  //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //                     Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
  //                     Text('${payment['pricePerNight']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
  //                   ]),
  //                 ),
  //                 Expanded(
  //                   child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //                     Icon(Icons.currency_rupee_rounded, size: 14, color: _successColor),
  //                     Text('${payment['totalAmount']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _successColor)),
  //                   ]),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         Container(
  //           padding: EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //             color: _primaryColor.withOpacity(0.05),
  //             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
  //             border: Border.all(color: _primaryColor.withOpacity(0.2)),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('Overall', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
  //                 decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: _borderColor)),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.calendar_month_rounded, size: 14, color: _textLight),
  //                     SizedBox(width: 6),
  //                     Text('Jan 2024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _textDark)),
  //                     SizedBox(width: 4),
  //                     Icon(Icons.expand_more_rounded, size: 16, color: _textLight),
  //                     SizedBox(width: 8),
  //                     Container(height: 16, width: 1, color: _borderColor),
  //                     SizedBox(width: 8),
  //                     Row(
  //                       children: [
  //                         Text('Total Profit - ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _textLight)),
  //                         Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
  //                         Text('${totalProfit.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _successColor)),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildPaymentOverview() {
    List<Map<String, dynamic>> paymentData = [];

    for (var villa in _villaTypeData) {
      int occupiedCount = villa['occupied'] as int;
      double price = villa['price'] as double;
      double totalAmount = occupiedCount * price * 7;

      paymentData.add({
        'villaType': villa['type'],
        'bookedCount': occupiedCount,
        'pricePerNight': price,
        'totalNights': 7,
        'totalAmount': totalAmount,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-15',
      });
    }

    double totalProfit = paymentData.fold(0.0, (sum, item) => sum + (item['totalAmount'] as double));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
              Text('Payment Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.payment_rounded, size: 14, color: _primaryColor),
                    SizedBox(width: 6),
                    Text('Revenue Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                        SizedBox(width: 140, child: Text('Villa Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark))),
                        SizedBox(width: 80, child: Text('Booked', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 80, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                        SizedBox(width: 100, child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _textDark), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),

                  // Rows
                  ...paymentData.map((payment) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          SizedBox(
                            width: 140,
                            child: Text(
                              payment['villaType'] as String,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              '${payment['bookedCount']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
                                Text(
                                  '${payment['pricePerNight']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 14, color: _successColor),
                                Text(
                                  '${payment['totalAmount']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),


          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Overall', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 14, color: _textLight),
                        SizedBox(width: 6),
                        Text('Jan 2024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _textDark)),
                        SizedBox(width: 4),
                        Icon(Icons.expand_more_rounded, size: 16, color: _textLight),
                        SizedBox(width: 8),
                        Container(height: 16, width: 1, color: _borderColor),
                        SizedBox(width: 8),
                        Text('Total Profit - ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _textLight)),
                        Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                        Text(
                          '${totalProfit.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _successColor),
                        ),
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
              decoration: BoxDecoration(gradient: LinearGradient(colors: [_primaryColor, _primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.white.withOpacity(0.2), child: Icon(Icons.villa, size: 50, color: Colors.white)),
                  SizedBox(height: 16),
                  Text(widget.villaName, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4),
                  Text('Villa Owner', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildDrawerItem(Icons.dashboard_rounded, 'Dashboard', 0),
            _buildDrawerItem(Icons.house_rounded, 'Villa Manager', 1),
            _buildDrawerItem(Icons.calendar_month_rounded, 'Booking Calendar', 2),
            _buildDrawerItem(Icons.analytics_rounded, 'Revenue Analytics', 3),
            _buildDrawerItem(Icons.reviews_rounded, 'Guest Reviews', 4),
            _buildDrawerItem(Icons.people_alt_rounded, 'Staff Management', 5),
            _buildDrawerItem(Icons.inventory_rounded, 'Inventory', 6),
            Divider(indent: 20, endIndent: 20),
            _buildDrawerItem(Icons.settings_rounded, 'Villa Settings', 7),
            _buildDrawerItem(Icons.help_center_rounded, 'Help Center', 8),
            _buildDrawerItem(Icons.logout_rounded, 'Logout', 9),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Text('Villa Status: Active', style: TextStyle(fontWeight: FontWeight.w600, color: _primaryColor)),
                  SizedBox(height: 8),
                  LinearProgressIndicator(value: 0.85, backgroundColor: _borderColor, color: _successColor),
                  SizedBox(height: 4),
                  Text('85% units configured', style: TextStyle(fontSize: 11, color: _textLight)),
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
        width: 36, height: 36,
        decoration: BoxDecoration(color: _selectedIndex == index ? _primaryColor.withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: _selectedIndex == index ? _primaryColor : _textDark),
      ),
      title: Text(title, style: TextStyle(color: _selectedIndex == index ? _primaryColor : _textDark, fontWeight: _selectedIndex == index ? FontWeight.w700 : FontWeight.normal)),
      trailing: _selectedIndex == index ? Container(width: 6, height: 6, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)) : null,
      onTap: () { setState(() { _selectedIndex = index; }); Navigator.pop(context); },
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
      onTap: (index) { setState(() { _selectedIndex = index; }); },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), activeIcon: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.dashboard_rounded)), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.house_rounded), activeIcon: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.house_rounded)), label: 'Villas'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), activeIcon: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.calendar_month_rounded)), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), activeIcon: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.analytics_rounded)), label: 'Analytics'),
        BottomNavigationBarItem(icon: Icon(Icons.person_rounded), activeIcon: Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.person_rounded)), label: 'Profile'),
      ],
    );
  }

  void _addNewVilla() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Villa'),
        content: Text('Feature coming soon!'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  void _showProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile section coming soon'),
        backgroundColor: _primaryColor,
      ),
    );
  }

  void _navigateToOwnerDashboard() {

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerDashboardScreen(
          userData: widget.registrationData,
          userEmail: widget.email,
        ),
      ),
          (route) => false,
    );
  }

  Widget _buildGoToDashboardButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: _navigateToOwnerDashboard,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios_new, size: 20),
            SizedBox(width: 10),
            Text(
              'Go to Dashboard',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VillaBookingTrendGraphPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;
  final double minValue;
  final Color primaryColor;
  final Color secondaryColor;

  _VillaBookingTrendGraphPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    Paint linePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    Path linePath = Path();
    Path fillPath = Path();

    double stepX = size.width / (data.length - 1);
    double range = maxValue - minValue;
    if (range == 0) range = 1;

    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    Paint dotPaint = Paint()..color = primaryColor..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class ApartmentBusinessDashboard extends StatefulWidget {
  final String apartmentName;
  final String ownerName;
  final String mobileNumber;
  final String email;
  final String address;
  final String area;
  final String city;
  final String state;
  final String pincode;
  final String gstNumber;
  final String tradeLicense;
  final String policeVerification;
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String upiId;
  final Map<String, dynamic> ownerPhotoInfo;
  final Map<String, dynamic> registrationData;

  const ApartmentBusinessDashboard({
    Key? key,
    required this.apartmentName,
    required this.ownerName,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.gstNumber,
    required this.tradeLicense,
    required this.policeVerification,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiId,
    required this.ownerPhotoInfo,
    required this.registrationData,
  }) : super(key: key);

  @override
  _ApartmentBusinessDashboardState createState() => _ApartmentBusinessDashboardState();
}

class _ApartmentBusinessDashboardState extends State<ApartmentBusinessDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = const Color(0xFF5C6BC0); // Indigo for Apartments
  final Color _primaryLight = const Color(0xFF5C6BC0);
  final Color _secondaryColor = const Color(0xFF9C27B0); // Purple accent
  final Color _accentColor = const Color(0xFFFFD54F); // Gold/Yellow
  final Color _bgColor = const Color(0xFFF9FAFB);
  final Color _cardBg = Colors.white;
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _dangerColor = const Color(0xFFEF4444);

  String _selectedMonth = 'January';
  String _selectedUnitType = 'All';
  String _selectedGraphFilter = 'Daily';
  List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];


  final List<String> _apartmentTypesList = [
    'Service Apartment',
    'Studio Apartment',
    'Luxury Apartment',
    'Budget Apartment',
    'Entire Apartment',
    'Shared Apartment',
  ];

  DateTime _selectedStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now();

  List<Map<String, dynamic>> _apartmentTypeData = [];

  @override
  void initState() {
    super.initState();
    _initializeApartmentData();
  }

  void _initializeApartmentData() {
    final propertyDetails = widget.registrationData['propertyDetails'] as Map?;
    final bhkDetails = propertyDetails?['bhkDetails'] as List? ?? [];

    _apartmentTypeData.clear();

    if (bhkDetails.isNotEmpty) {
      for (var bhk in bhkDetails) {
        if (bhk is Map) {
          int totalUnits = int.tryParse(bhk['totalUnits']?.toString() ?? '0') ?? 0;
          double price = double.tryParse(widget.registrationData['pricing']?['basePrice']?.toString() ?? '0') ?? 0;
          int bedrooms = int.tryParse(bhk['totalBedrooms']?.toString() ?? '0') ?? 0;
          int bathrooms = int.tryParse(bhk['totalBathrooms']?.toString() ?? '0') ?? 0;
          int capacity = int.tryParse(bhk['guestCapacity']?.toString() ?? '0') ?? 0;

          int availableUnits = (totalUnits * 0.35).round();
          int occupiedUnits = (totalUnits * 0.55).round();
          int cancellationUnits = (totalUnits * 0.10).round();

          _apartmentTypeData.add({
            'type': bhk['type']?.toString() ?? 'Apartment',
            'total': totalUnits,
            'price': price,
            'bedrooms': bedrooms,
            'bathrooms': bathrooms,
            'capacity': capacity,
            'available': availableUnits,
            'occupied': occupiedUnits,
            'cancellation': cancellationUnits,
          });
        }
      }
    } else {

      _generateSampleApartmentData();
    }
  }

  void _generateSampleApartmentData() {
    _apartmentTypeData = [
      {
        'type': 'Service Apartment',
        'total': 15,
        'price': 3500.0,
        'bedrooms': 2,
        'bathrooms': 2,
        'capacity': 5,
        'available': 6,
        'occupied': 7,
        'cancellation': 2,
      },
      {
        'type': 'Studio Apartment',
        'total': 12,
        'price': 2800.0,
        'bedrooms': 1,
        'bathrooms': 1,
        'capacity': 3,
        'available': 5,
        'occupied': 6,
        'cancellation': 1,
      },
      {
        'type': 'Luxury Apartment',
        'total': 8,
        'price': 8000.0,
        'bedrooms': 3,
        'bathrooms': 3,
        'capacity': 7,
        'available': 3,
        'occupied': 4,
        'cancellation': 1,
      },
      {
        'type': 'Budget Apartment',
        'total': 20,
        'price': 2000.0,
        'bedrooms': 2,
        'bathrooms': 1,
        'capacity': 4,
        'available': 9,
        'occupied': 9,
        'cancellation': 2,
      },
      {
        'type': 'Entire Apartment',
        'total': 10,
        'price': 5000.0,
        'bedrooms': 3,
        'bathrooms': 2,
        'capacity': 6,
        'available': 4,
        'occupied': 5,
        'cancellation': 1,
      },
      {
        'type': 'Shared Apartment',
        'total': 25,
        'price': 1200.0,
        'bedrooms': 4,
        'bathrooms': 2,
        'capacity': 8,
        'available': 12,
        'occupied': 11,
        'cancellation': 2,
      },
    ];
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
        onPressed: () => _addNewUnit(),
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
          : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _cardBg,
      elevation: 1,
      shadowColor: Colors.black12,
      leading: Builder(
        builder: (context) => Container(
          margin: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: _primaryColor, size: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apartment Business Dashboard',
                style: TextStyle(
                  color: _textDark,
                  fontSize: 16.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
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
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _initializeApartmentData();
        });
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            const SizedBox(height: 24),
            _buildApartmentTypesTable(),
            const SizedBox(height: 24),
            _buildBookingInsightsGraph(),
            const SizedBox(height: 24),
            _buildMonthlyBookingStats(),
            const SizedBox(height: 40),
            _buildPaymentOverview(),
            const SizedBox(height: 24),
            _buildGoToDashboardButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _navigateToOwnerDashboard() {

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerDashboardScreen(
          userData: widget.registrationData,
          userEmail: widget.email,
        ),
      ),
          (route) => false,
    );
  }

  Widget _buildGoToDashboardButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: _navigateToOwnerDashboard,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios_new, size: 20),
            SizedBox(width: 10),
            Text(
              'Go to Dashboard',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    int totalRooms = _apartmentTypeData.fold<int>(0, (sum, item) => sum + (item['total'] as int));
    int totalAvailableRooms = _apartmentTypeData.fold<int>(0, (sum, item) => sum + (item['available'] as int));
    int totalOccupiedRooms = _apartmentTypeData.fold<int>(0, (sum, item) => sum + (item['occupied'] as int));
    int totalCancellationRooms = _apartmentTypeData.fold<int>(0, (sum, item) => sum + (item['cancellation'] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Apartment Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Live Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildSummaryCard(
              title: 'Total Units',
              value: totalRooms.toString(),
              icon: Icons.apartment_rounded,
              color: _secondaryColor,
              subtitle: 'All apartment units',
            ),
            _buildSummaryCard(
              title: 'Available Units',
              value: totalAvailableRooms.toString(),
              icon: Icons.event_available_rounded,
              color: _successColor,
              subtitle: 'Ready for booking',
            ),
            _buildSummaryCard(
              title: 'Occupied Units',
              value: totalOccupiedRooms.toString(),
              icon: Icons.bed_rounded,
              color: _primaryColor,
              subtitle: 'Currently booked',
            ),
            _buildSummaryCard(
              title: 'Cancellation',
              value: totalCancellationRooms.toString(),
              icon: Icons.cancel_rounded,
              color: _dangerColor,
              subtitle: 'Cancelled bookings',
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Icon(icon, size: 24, color: color)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 11, color: _textLight)),
        ],
      ),
    );
  }

  Widget _buildApartmentTypesTable() {
    int totalUnits = _apartmentTypeData.fold<int>(0, (sum, v) => sum + (v['total'] as int));
    int totalAvailable = _apartmentTypeData.fold<int>(0, (sum, v) => sum + (v['available'] as int));
    int totalOccupied = _apartmentTypeData.fold<int>(0, (sum, v) => sum + (v['occupied'] as int));
    int totalCancellation = _apartmentTypeData.fold<int>(0, (sum, v) => sum + (v['cancellation'] as int));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
                'Apartment Unit Configuration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.table_chart_rounded, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text('Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 120, child: Text('Unit Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)))),
                        const SizedBox(width: 70, child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 70, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 60, child: Text('Beds', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 70, child: Text('Guests', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Available', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Occupied', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  ..._apartmentTypeData.map((unit) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: _bgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  unit['type'],
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${unit['bedrooms']}BHK • ${unit['bathrooms']} Bath',
                                  style: TextStyle(fontSize: 10, color: _textLight),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Column(
                              children: [
                                Text(
                                  '${unit['total']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.blue),
                                ),
                                const Text('Units', style: TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                                Text(
                                  '${unit['price']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${unit['bedrooms']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              '${unit['capacity']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.orange),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _successColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${unit['available']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${unit['occupied']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Summary:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Total:', totalUnits.toString(), Colors.blue),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Available:', totalAvailable.toString(), _successColor),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Occupied:', totalOccupied.toString(), _primaryColor),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Cancellation:', totalCancellation.toString(), _dangerColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: _textLight)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }

  Widget _buildBookingInsightsGraph() {
    Map<String, List<double>> _generateWaveData(String unitType) {
      Map<String, List<double>> data = {};
      for (String type in _apartmentTypesList) {
        if (unitType == 'All' || unitType == type) {
          List<double> wavePoints = [];
          int days = 30;
          for (int i = 0; i < days; i++) {
            double baseValue = 0;
            switch (type) {
              case 'Service Apartment': baseValue = 15; break;
              case 'Studio Apartment': baseValue = 12; break;
              case 'Luxury Apartment': baseValue = 10; break;
              case 'Budget Apartment': baseValue = 8; break;
              case 'Entire Apartment': baseValue = 7; break;
              case 'Shared Apartment': baseValue = 5; break;
            }
            double variation = sin(i * 0.3) * 3 + cos(i * 0.5) * 2;
            double trend = i * 0.08;
            double noise = (Random().nextDouble() * 2) - 1;
            wavePoints.add(baseValue + variation + trend + noise);
          }
          data[type] = wavePoints;
        }
      }
      if (unitType == 'All') {
        List<double> combinedData = [];
        for (int i = 0; i < 30; i++) {
          double combinedValue = 0;
          data.forEach((type, wavePoints) { combinedValue += wavePoints[i]; });
          combinedData.add(combinedValue);
        }
        data['All'] = combinedData;
      }
      return data;
    }

    Map<String, List<double>> waveData = _generateWaveData(_selectedUnitType);
    List<double> currentWaveData = waveData[_selectedUnitType] ?? waveData['All'] ?? [];

    if (currentWaveData.isEmpty) {
      return const SizedBox.shrink();
    }

    double maxValue = currentWaveData.reduce((a, b) => a > b ? a : b);
    double minValue = currentWaveData.reduce((a, b) => a < b ? a : b);
    double average = currentWaveData.isNotEmpty ? currentWaveData.reduce((a, b) => a + b) / currentWaveData.length : 0;
    double currentValue = currentWaveData.isNotEmpty ? currentWaveData.last : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Trends Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
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
                          const Text('Unit Type', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _cardBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _borderColor),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedUnitType,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down_rounded, color: _primaryColor),
                                items: [
                                  const DropdownMenuItem(value: 'All', child: Text('All Units')),
                                  ..._apartmentTypesList.map<DropdownMenuItem<String>>((String type) =>
                                      DropdownMenuItem(value: type, child: Text(type))
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUnitType = value!;
                                  });
                                },
                              ),
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
                          const Text('Date Range', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: _cardBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _borderColor),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _showStartDatePicker(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.calendar_month_rounded, size: 12, color: _primaryColor),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${_selectedStartDate.day}/${_selectedStartDate.month}',
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 1, color: _borderColor, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _showEndDatePicker(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${_selectedEndDate.day}/${_selectedEndDate.month}',
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(width: 4),
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 45,
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _getUnitTypeLabels(),
                          ),
                        ),
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
                                for (int i = 0; i <= 4; i++)
                                  Positioned(
                                    top: (200 * i / 4),
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 1,
                                      color: _borderColor.withOpacity(0.3),
                                    ),
                                  ),
                                CustomPaint(
                                  size: Size(double.infinity, 200),
                                  painter: _ApartmentBookingTrendGraphPainter(
                                    data: currentWaveData,
                                    maxValue: maxValue,
                                    minValue: minValue,
                                    primaryColor: _primaryColor,
                                    secondaryColor: _secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 1, color: _borderColor),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('0', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('10', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('20', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('30', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text('Days', style: TextStyle(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGraphStatItem(title: 'Current', value: currentValue.toStringAsFixed(1), color: _primaryColor),
                _buildGraphStatItem(title: 'Average', value: average.toStringAsFixed(1), color: _secondaryColor),
                _buildGraphStatItem(title: 'Maximum', value: maxValue.toStringAsFixed(1), color: _successColor),
                _buildGraphStatItem(title: 'Minimum', value: minValue.toStringAsFixed(1), color: _warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getUnitTypeLabels() {
    double itemHeight = 200 / _apartmentTypesList.length;

    if (_selectedUnitType == 'All') {
      return _apartmentTypesList.asMap().entries.map((entry) {
        String unitType = entry.value;
        return SizedBox(
          height: itemHeight,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                unitType,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList();
    } else {
      return [
        SizedBox(
          height: 200,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                _selectedUnitType,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ];
    }
  }

  Widget _buildGraphStatItem({required String title, required String value, required Color color}) {
    return Column(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _textDark)),
        Text(title, style: TextStyle(fontSize: 10, color: _textLight)),
      ],
    );
  }

  Future<void> _showStartDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2001),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
        if (_selectedEndDate.isBefore(picked)) _selectedEndDate = picked;
      });
    }
  }

  Future<void> _showEndDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() { _selectedEndDate = picked; });
    }
  }

  Widget _buildMonthlyBookingStats() {
    Map<String, Map<String, dynamic>> monthlyStats = {
      'January': {'totalBookings': 89, 'confirmed': 38, 'pending': 10, 'cancelled': 6, 'completed': 35, 'revenue': 245000, 'occupancy': 72.5},
      'February': {'totalBookings': 102, 'confirmed': 45, 'pending': 12, 'cancelled': 8, 'completed': 37, 'revenue': 285000, 'occupancy': 75.3},
      'March': {'totalBookings': 95, 'confirmed': 42, 'pending': 9, 'cancelled': 5, 'completed': 39, 'revenue': 268000, 'occupancy': 73.8},
    };
    Map<String, dynamic> selectedStats = monthlyStats[_selectedMonth] ?? {'totalBookings': 0, 'confirmed': 0, 'pending': 0, 'cancelled': 0, 'completed': 0, 'revenue': 0, 'occupancy': 0};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly Statistics ($_selectedMonth)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
                    items: _months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month, style: const TextStyle(fontSize: 12)));
                    }).toList(),
                    onChanged: (value) { setState(() { _selectedMonth = value!; }); },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              _buildStatCard(title: 'Total Bookings', value: selectedStats['totalBookings'].toString(), change: '+8%', isPositive: true, icon: Icons.calendar_month_rounded),
              _buildStatCard(title: 'Revenue', value: '₹${(selectedStats['revenue'] / 1000).toStringAsFixed(0)}K', change: '+10%', isPositive: true, icon: Icons.currency_rupee_rounded),
              _buildStatCard(title: 'Occupancy Rate', value: '${selectedStats['occupancy']}%', change: '+4%', isPositive: true, icon: Icons.bar_chart_rounded),
              _buildStatCard(title: 'Cancellation', value: '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%', change: '-1%', isPositive: false, icon: Icons.cancel_rounded),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Booking Status Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
          const SizedBox(height: 12),
          ..._bookingStatuses.map((status) {
            int count = selectedStats[status.toLowerCase()] ?? 0;
            double percentage = selectedStats['totalBookings'] > 0 ? (count / selectedStats['totalBookings']) * 100 : 0;
            Color statusColor = _getStatusColor(status);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)), const SizedBox(width: 10), Text(status, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark))]),
                    Text('$count (${percentage.toStringAsFixed(1)}%)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: statusColor)),
                  ]),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: count / selectedStats['totalBookings'], backgroundColor: _borderColor, color: statusColor, minHeight: 6, borderRadius: BorderRadius.circular(3)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required String change, required bool isPositive, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Icon(icon, size: 20, color: _primaryColor))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isPositive ? _successColor.withOpacity(0.1) : _dangerColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [Icon(isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, size: 12, color: isPositive ? _successColor : _dangerColor), const SizedBox(width: 4), Text(change, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isPositive ? _successColor : _dangerColor))]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: _textLight)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return _successColor;
      case 'Pending': return _warningColor;
      case 'Cancelled': return _dangerColor;
      case 'Completed': return _secondaryColor;
      default: return _primaryColor;
    }
  }

  Widget _buildPaymentOverview() {
    List<Map<String, dynamic>> paymentData = [];

    for (var unit in _apartmentTypeData) {
      int occupiedCount = unit['occupied'] as int;
      double price = unit['price'] as double;
      double totalAmount = occupiedCount * price * 7;

      paymentData.add({
        'unitType': unit['type'],
        'bookedCount': occupiedCount,
        'pricePerNight': price,
        'totalNights': 7,
        'totalAmount': totalAmount,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-15',
      });
    }

    double totalProfit = paymentData.fold(0.0, (sum, item) => sum + (item['totalAmount'] as double));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              Text('Payment Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.payment_rounded, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text('Revenue Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 140, child: Text('Unit Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)))),
                        const SizedBox(width: 80, child: Text('Booked', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 100, child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),

                  ...paymentData.map((payment) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          SizedBox(
                            width: 140,
                            child: Text(
                              payment['unitType'] as String,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              '${payment['bookedCount']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
                                Text(
                                  '${payment['pricePerNight']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 14, color: _successColor),
                                Text(
                                  '${payment['totalAmount']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Overall', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 14, color: _textLight),
                        const SizedBox(width: 6),
                        const Text('Jan 2024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                        const SizedBox(width: 4),
                        Icon(Icons.expand_more_rounded, size: 16, color: Color(0xFF6B7280)),
                        const SizedBox(width: 8),
                        Container(height: 16, width: 1, color: _borderColor),
                        const SizedBox(width: 8),
                        const Text('Total Profit - ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
                        Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                        Text(
                          '${totalProfit.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _successColor),
                        ),
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
                    child: Icon(Icons.apartment, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.apartmentName,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text('Apartment Owner', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildDrawerItem(Icons.dashboard_rounded, 'Dashboard', 0),
            _buildDrawerItem(Icons.apartment_rounded, 'Unit Manager', 1),
            _buildDrawerItem(Icons.calendar_month_rounded, 'Booking Calendar', 2),
            _buildDrawerItem(Icons.analytics_rounded, 'Revenue Analytics', 3),
            _buildDrawerItem(Icons.reviews_rounded, 'Guest Reviews', 4),
            _buildDrawerItem(Icons.people_alt_rounded, 'Staff Management', 5),
            _buildDrawerItem(Icons.inventory_rounded, 'Inventory', 6),
            const Divider(indent: 20, endIndent: 20),
            _buildDrawerItem(Icons.settings_rounded, 'Apartment Settings', 7),
            _buildDrawerItem(Icons.help_center_rounded, 'Help Center', 8),
            _buildDrawerItem(Icons.logout_rounded, 'Logout', 9),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Apartment Status: Active', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF5C6BC0))),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.85,
                    backgroundColor: _borderColor,
                    color: _successColor,
                  ),
                  const SizedBox(height: 4),
                  Text('85% units configured', style: TextStyle(fontSize: 11, color: _textLight)),
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
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? _primaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _selectedIndex == index ? _primaryColor : _textDark),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? _primaryColor : _textDark,
          fontWeight: _selectedIndex == index ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      trailing: _selectedIndex == index ? Container(width: 6, height: 6, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)) : null,
      onTap: () { setState(() { _selectedIndex = index; }); Navigator.pop(context); },
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
      selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      onTap: (index) { setState(() { _selectedIndex = index; }); },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), activeIcon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
        const BottomNavigationBarItem(icon: Icon(Icons.apartment_rounded), activeIcon: Icon(Icons.apartment_rounded), label: 'Units'),
        const BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), activeIcon: Icon(Icons.calendar_month_rounded), label: 'Bookings'),
        const BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), activeIcon: Icon(Icons.analytics_rounded), label: 'Analytics'),
        const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    );
  }

  void _addNewUnit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Unit'),
        content: const Text('Feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile section coming soon'),
        backgroundColor: _primaryColor,
      ),
    );
  }
}

class _ApartmentBookingTrendGraphPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;
  final double minValue;
  final Color primaryColor;
  final Color secondaryColor;

  _ApartmentBookingTrendGraphPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    Paint linePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    Path linePath = Path();
    Path fillPath = Path();

    double stepX = size.width / (data.length - 1);
    double range = maxValue - minValue;
    if (range == 0) range = 1;

    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    Paint dotPaint = Paint()..color = primaryColor..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class ResortBusinessDashboard extends StatefulWidget {
  final String resortName;
  final String ownerName;
  final String contactPerson;
  final String mobileNumber;
  final String email;
  final String address;
  final String area;
  final String city;
  final String state;
  final String pincode;
  final String nearestAirport;
  final String nearestRailway;
  final String gstNumber;
  final String tradeLicense;
  final String fssaiLicense;
  final String tourismApproval;
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String upiId;
  final Map<String, dynamic> ownerPhotoInfo;
  final Map<String, dynamic> registrationData;
  // final Map<String, dynamic>? completeUserData; // Add this
  // final String? userEmail; // Add this

  const ResortBusinessDashboard({
    Key? key,
    required this.resortName,
    required this.ownerName,
    required this.contactPerson,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
    required this.nearestAirport,
    required this.nearestRailway,
    required this.gstNumber,
    required this.tradeLicense,
    required this.fssaiLicense,
    required this.tourismApproval,
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiId,
    required this.ownerPhotoInfo,
    required this.registrationData,
    // required this.completeUserData,
    // required this.userEmail,
  }) : super(key: key);

  @override
  _ResortBusinessDashboardState createState() => _ResortBusinessDashboardState();
}

class _ResortBusinessDashboardState extends State<ResortBusinessDashboard> {
  int _selectedIndex = 0;
  final Color _primaryColor = const Color(0xFF2E7D32); // Forest Green for Resorts
  final Color _primaryLight = const Color(0xFF4CAF50);
  final Color _secondaryColor = const Color(0xFF2196F3); // Ocean Blue
  final Color _accentColor = const Color(0xFFFFD54F); // Gold/Yellow
  final Color _bgColor = const Color(0xFFF9FAFB);
  final Color _cardBg = Colors.white;
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _borderColor = const Color(0xFFE5E7EB);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _dangerColor = const Color(0xFFEF4444);

  String _selectedMonth = 'January';
  String _selectedResortCategory = 'All';
  String _selectedGraphFilter = 'Daily';
  List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];


  List<String> _resortCategoriesList = [];

  DateTime _selectedStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now();

  List<Map<String, dynamic>> _resortCategoryData = [];

  @override
  void initState() {
    super.initState();
    _initializeResortData();
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Luxury':
        return Icons.workspace_premium;
      case 'Boutique':
        return Icons.diamond;
      case 'Eco Resort':
        return Icons.eco;
      case 'Beach Resort':
        return Icons.beach_access;
      case 'Hill Resort':
        return Icons.terrain;
      case 'Farm Resort':
        return Icons.agriculture;
      default:
        return Icons.nature_people;
    }
  }


  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Luxury':
        return const Color(0xFFC71585);
      case 'Boutique':
        return const Color(0xFF9370DB);
      case 'Eco Resort':
        return const Color(0xFF2E7D32);
      case 'Beach Resort':
        return const Color(0xFF2196F3);
      case 'Hill Resort':
        return const Color(0xFF795548);
      case 'Farm Resort':
        return const Color(0xFFFF9800);
      default:
        return _primaryColor;
    }
  }

  void _initializeResortData() {
    final propertyDetails = widget.registrationData['propertyDetails'] as Map?;
    final resortCategoryDetails = propertyDetails?['resortCategoryDetails'] as List? ?? [];

    _resortCategoryData.clear();
    _resortCategoriesList.clear();

    if (resortCategoryDetails.isNotEmpty) {

      _resortCategoriesList.add('All');

      for (var category in resortCategoryDetails) {
        if (category is Map) {
          int totalRooms = int.tryParse(category['totalRooms']?.toString() ?? '0') ?? 0;
          int totalCapacity = int.tryParse(category['totalCapacity']?.toString() ?? '0') ?? 0;
          double price = double.tryParse(category['price']?.toString() ??
              widget.registrationData['pricing']?['basePrice']?.toString() ?? '0') ?? 0;


          final roomTypes = category['roomTypes'] as Map? ?? {};
          final selectedRoomTypes = roomTypes.entries
              .where((e) => e.value == true)
              .map((e) => e.key.toString())
              .toList();

          int availableUnits = (totalRooms * 0.35).round();
          int occupiedUnits = (totalRooms * 0.55).round();
          int cancellationUnits = (totalRooms * 0.10).round();

          _resortCategoryData.add({
            'type': category['type']?.toString() ?? 'Resort Category',
            'totalRooms': totalRooms,
            'totalCapacity': totalCapacity,
            'price': price,
            'roomTypes': selectedRoomTypes,
            'propertyArea': category['propertyArea']?.toString() ?? '',
            'yearEstablished': category['yearEstablished']?.toString() ?? '',
            'description': category['description']?.toString() ?? '',
            'available': availableUnits,
            'occupied': occupiedUnits,
            'cancellation': cancellationUnits,
          });

          _resortCategoriesList.add(category['type']?.toString() ?? 'Resort Category');
        }
      }
    } else {

      _generateSampleResortData();
    }
  }

  void _generateSampleResortData() {
    _resortCategoriesList = ['All', 'Luxury', 'Boutique', 'Eco Resort', 'Beach Resort', 'Hill Resort', 'Farm Resort'];

    _resortCategoryData = [
      {
        'type': 'Luxury',
        'totalRooms': 12,
        'totalCapacity': 36,
        'price': 15000.0,
        'roomTypes': ['Suite', 'Villa', 'Presidential'],
        'propertyArea': '15 acres',
        'yearEstablished': '2020',
        'description': 'Ultra-luxury resort with world-class amenities, private butler service, and exclusive experiences.',
        'available': 4,
        'occupied': 7,
        'cancellation': 1,
      },
      {
        'type': 'Boutique',
        'totalRooms': 8,
        'totalCapacity': 24,
        'price': 8500.0,
        'roomTypes': ['Deluxe', 'Signature'],
        'propertyArea': '3 acres',
        'yearEstablished': '2019',
        'description': 'Charming boutique resort with personalized service and unique architectural design.',
        'available': 3,
        'occupied': 4,
        'cancellation': 1,
      },
      {
        'type': 'Eco Resort',
        'totalRooms': 15,
        'totalCapacity': 45,
        'price': 6500.0,
        'roomTypes': ['Eco Hut', 'Tree House', 'Nature Suite'],
        'propertyArea': '25 acres',
        'yearEstablished': '2018',
        'description': 'Sustainable resort with eco-friendly practices, organic farming, and nature immersion.',
        'available': 6,
        'occupied': 8,
        'cancellation': 1,
      },
      {
        'type': 'Beach Resort',
        'totalRooms': 25,
        'totalCapacity': 75,
        'price': 9500.0,
        'roomTypes': ['Ocean View', 'Beachfront', 'Pool View'],
        'propertyArea': '10 acres',
        'yearEstablished': '2021',
        'description': 'Stunning beachfront resort with private beach access and water sports activities.',
        'available': 9,
        'occupied': 14,
        'cancellation': 2,
      },
      {
        'type': 'Hill Resort',
        'totalRooms': 10,
        'totalCapacity': 30,
        'price': 7500.0,
        'roomTypes': ['Mountain View', 'Valley View'],
        'propertyArea': '8 acres',
        'yearEstablished': '2020',
        'description': 'Scenic hill resort with breathtaking mountain views and trekking experiences.',
        'available': 4,
        'occupied': 5,
        'cancellation': 1,
      },
      {
        'type': 'Farm Resort',
        'totalRooms': 18,
        'totalCapacity': 54,
        'price': 5500.0,
        'roomTypes': ['Farm View', 'Garden Suite'],
        'propertyArea': '20 acres',
        'yearEstablished': '2017',
        'description': 'Rustic farm resort with organic farming, farm-to-table dining, and rural experiences.',
        'available': 7,
        'occupied': 9,
        'cancellation': 2,
      },
    ];
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
        onPressed: () => _addNewResortCategory(),
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
          : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _cardBg,
      elevation: 1,
      shadowColor: Colors.black12,
      leading: Builder(
        builder: (context) => Container(
          margin: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: _primaryColor, size: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resort Business Dashboard',
                style: TextStyle(
                  color: _textDark,
                  fontSize: 16.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
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
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _initializeResortData();
        });
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            const SizedBox(height: 24),
            _buildResortCategoryTable(),
            const SizedBox(height: 24),
            _buildBookingInsightsGraph(),
            const SizedBox(height: 24),
            _buildMonthlyBookingStats(),
            const SizedBox(height: 40),
            _buildPaymentOverview(),
            const SizedBox(height: 24),
            _buildGoToDashboardButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _navigateToOwnerDashboard() {

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerDashboardScreen(
          userData: widget.registrationData,
          userEmail: widget.email,
        ),
      ),
          (route) => false,
    );
  }
  Widget _buildGoToDashboardButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: _navigateToOwnerDashboard,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back_ios_new, size: 20),
            const SizedBox(width: 10),
            Text(
              'Go to Dashboard',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    int totalRooms = _resortCategoryData.fold<int>(0, (sum, item) => sum + (item['totalRooms'] as int));
    int totalCapacity = _resortCategoryData.fold<int>(0, (sum, item) => sum + (item['totalCapacity'] as int));
    int totalAvailableRooms = _resortCategoryData.fold<int>(0, (sum, item) => sum + (item['available'] as int));
    int totalOccupiedRooms = _resortCategoryData.fold<int>(0, (sum, item) => sum + (item['occupied'] as int));
    int totalCancellationRooms = _resortCategoryData.fold<int>(0, (sum, item) => sum + (item['cancellation'] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Resort Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text('Live Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildSummaryCard(title: 'Total Rooms', value: totalRooms.toString(), icon: Icons.meeting_room_rounded, color: _secondaryColor, subtitle: 'All resort rooms'),
            _buildSummaryCard(title: 'Available Rooms', value: totalAvailableRooms.toString(), icon: Icons.event_available_rounded, color: _successColor, subtitle: 'Ready for booking'),
            _buildSummaryCard(title: 'Occupied Rooms', value: totalOccupiedRooms.toString(), icon: Icons.bed_rounded, color: _warningColor, subtitle: 'Currently booked'),
            _buildSummaryCard(title: 'Cancellation', value: totalCancellationRooms.toString(), icon: Icons.cancel_rounded, color: _dangerColor, subtitle: 'Cancelled bookings'),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Icon(icon, size: 24, color: color)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 11, color: _textLight)),
        ],
      ),
    );
  }

  Widget _buildResortCategoryTable() {
    int totalRooms = _resortCategoryData.fold<int>(0, (sum, v) => sum + (v['totalRooms'] as int));
    int totalCapacity = _resortCategoryData.fold<int>(0, (sum, v) => sum + (v['totalCapacity'] as int));
    int totalAvailable = _resortCategoryData.fold<int>(0, (sum, v) => sum + (v['available'] as int));
    int totalOccupied = _resortCategoryData.fold<int>(0, (sum, v) => sum + (v['occupied'] as int));
    int totalCancellation = _resortCategoryData.fold<int>(0, (sum, v) => sum + (v['cancellation'] as int));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
                'Resort Category Configuration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.category, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text('Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 120, child: Text('Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)))),
                        const SizedBox(width: 70, child: Text('Rooms', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 70, child: Text('Capacity', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 70, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 100, child: Text('Room Types', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Available', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Occupied', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  ..._resortCategoryData.map((category) {
                    String roomTypesStr = (category['roomTypes'] as List).join(', ');
                    if (roomTypesStr.length > 20) roomTypesStr = '${roomTypesStr.substring(0, 17)}...';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: _bgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Icon(_getCategoryIcon(category['type']), size: 14, color: _getCategoryColor(category['type'])),
                                const SizedBox(width: 4),
                                Text(
                                  category['type'],
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _getCategoryColor(category['type'])),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              '${category['totalRooms']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              '${category['totalCapacity']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                                Text(
                                  '${category['price']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              roomTypesStr,
                              style: TextStyle(fontSize: 12, color: _textDark),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _successColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${category['available']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _successColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _warningColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${category['occupied']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _warningColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Summary:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Total Rooms:', totalRooms.toString(), Colors.blue),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Total Capacity:', totalCapacity.toString(), Colors.green),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Available:', totalAvailable.toString(), _successColor),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Occupied:', totalOccupied.toString(), _warningColor),
                  const SizedBox(width: 16),
                  _buildSummaryItem('Cancellation:', totalCancellation.toString(), _dangerColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: _textLight)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }

  Widget _buildBookingInsightsGraph() {
    Map<String, List<double>> _generateWaveData(String categoryType) {
      Map<String, List<double>> data = {};
      for (var category in _resortCategoryData) {
        String type = category['type'] as String;
        if (categoryType == 'All' || categoryType == type) {
          List<double> wavePoints = [];
          int days = 30;
          double baseValue = (category['totalRooms'] as int) / 2.0;
          for (int i = 0; i < days; i++) {
            double variation = sin(i * 0.3) * (baseValue * 0.2) + cos(i * 0.5) * (baseValue * 0.15);
            double trend = i * 0.05;
            double noise = (Random().nextDouble() * 2) - 1;
            wavePoints.add(baseValue + variation + trend + noise);
          }
          data[type] = wavePoints;
        }
      }
      if (categoryType == 'All') {
        List<double> combinedData = [];
        for (int i = 0; i < 30; i++) {
          double combinedValue = 0;
          data.forEach((type, wavePoints) { combinedValue += wavePoints[i]; });
          combinedData.add(combinedValue);
        }
        data['All'] = combinedData;
      }
      return data;
    }

    Map<String, List<double>> waveData = _generateWaveData(_selectedResortCategory);
    List<double> currentWaveData = waveData[_selectedResortCategory] ?? waveData['All'] ?? [];

    if (currentWaveData.isEmpty) {
      return const SizedBox.shrink();
    }

    double maxValue = currentWaveData.reduce((a, b) => a > b ? a : b);
    double minValue = currentWaveData.reduce((a, b) => a < b ? a : b);
    double average = currentWaveData.isNotEmpty ? currentWaveData.reduce((a, b) => a + b) / currentWaveData.length : 0;
    double currentValue = currentWaveData.isNotEmpty ? currentWaveData.last : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Trends Analysis',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
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
                          const Text('Resort Category', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: _cardBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _borderColor),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedResortCategory,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down_rounded, color: _primaryColor),
                                items: _resortCategoriesList.map<DropdownMenuItem<String>>((String type) =>
                                    DropdownMenuItem(value: type, child: Text(type))
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedResortCategory = value!;
                                  });
                                },
                              ),
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
                          const Text('Date Range', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              color: _cardBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _borderColor),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _showStartDatePicker(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.calendar_month_rounded, size: 12, color: _primaryColor),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${_selectedStartDate.day}/${_selectedStartDate.month}',
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 1, color: _borderColor, margin: const EdgeInsets.symmetric(horizontal: 8)),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => _showEndDatePicker(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${_selectedEndDate.day}/${_selectedEndDate.month}',
                                              style: TextStyle(fontSize: 10, color: _textDark, fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(width: 4),
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 45,
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _getResortCategoryLabels(),
                          ),
                        ),
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
                                for (int i = 0; i <= 4; i++)
                                  Positioned(
                                    top: (200 * i / 4),
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 1,
                                      color: _borderColor.withOpacity(0.3),
                                    ),
                                  ),
                                CustomPaint(
                                  size: Size(double.infinity, 200),
                                  painter: _ResortBookingTrendGraphPainter(
                                    data: currentWaveData,
                                    maxValue: maxValue,
                                    minValue: minValue,
                                    primaryColor: _primaryColor,
                                    secondaryColor: _secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(height: 1, color: _borderColor),
                                ),
                                Positioned.fill(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('0', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('10', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('20', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(width: 1, height: 6, color: _borderColor),
                                          const SizedBox(height: 4),
                                          const Text('30', style: TextStyle(fontSize: 9, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text('Days', style: TextStyle(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGraphStatItem(title: 'Current', value: currentValue.toStringAsFixed(1), color: _primaryColor),
                _buildGraphStatItem(title: 'Average', value: average.toStringAsFixed(1), color: _secondaryColor),
                _buildGraphStatItem(title: 'Maximum', value: maxValue.toStringAsFixed(1), color: _successColor),
                _buildGraphStatItem(title: 'Minimum', value: minValue.toStringAsFixed(1), color: _warningColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getResortCategoryLabels() {
    List<String> labels = _resortCategoryData.map((e) => e['type'] as String).toList();
    double itemHeight = 200 / labels.length;

    if (_selectedResortCategory == 'All') {
      return labels.asMap().entries.map((entry) {
        String label = entry.value;
        return SizedBox(
          height: itemHeight,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                label,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }).toList();
    } else {
      return [
        SizedBox(
          height: 200,
          child: Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                _selectedResortCategory,
                style: TextStyle(fontSize: 10, color: _textLight, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ];
    }
  }

  Widget _buildGraphStatItem({required String title, required String value, required Color color}) {
    return Column(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _textDark)),
        Text(title, style: TextStyle(fontSize: 10, color: _textLight)),
      ],
    );
  }

  Future<void> _showStartDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2001),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
        if (_selectedEndDate.isBefore(picked)) _selectedEndDate = picked;
      });
    }
  }

  Future<void> _showEndDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: _textDark),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() { _selectedEndDate = picked; });
    }
  }

  Widget _buildMonthlyBookingStats() {
    Map<String, Map<String, dynamic>> monthlyStats = {
      'January': {'totalBookings': 89, 'confirmed': 38, 'pending': 10, 'cancelled': 6, 'completed': 35, 'revenue': 245000, 'occupancy': 72.5},
      'February': {'totalBookings': 102, 'confirmed': 45, 'pending': 12, 'cancelled': 8, 'completed': 37, 'revenue': 285000, 'occupancy': 75.3},
      'March': {'totalBookings': 95, 'confirmed': 42, 'pending': 9, 'cancelled': 5, 'completed': 39, 'revenue': 268000, 'occupancy': 73.8},
    };
    Map<String, dynamic> selectedStats = monthlyStats[_selectedMonth] ?? {'totalBookings': 0, 'confirmed': 0, 'pending': 0, 'cancelled': 0, 'completed': 0, 'revenue': 0, 'occupancy': 0};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: _cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly Statistics ($_selectedMonth)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
                    items: _months.map((month) {
                      return DropdownMenuItem(value: month, child: Text(month, style: const TextStyle(fontSize: 12)));
                    }).toList(),
                    onChanged: (value) { setState(() { _selectedMonth = value!; }); },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              _buildStatCard(title: 'Total Bookings', value: selectedStats['totalBookings'].toString(), change: '+8%', isPositive: true, icon: Icons.calendar_month_rounded),
              _buildStatCard(title: 'Revenue', value: '₹${(selectedStats['revenue'] / 1000).toStringAsFixed(0)}K', change: '+10%', isPositive: true, icon: Icons.currency_rupee_rounded),
              _buildStatCard(title: 'Occupancy Rate', value: '${selectedStats['occupancy']}%', change: '+4%', isPositive: true, icon: Icons.bar_chart_rounded),
              _buildStatCard(title: 'Cancellation', value: '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%', change: '-1%', isPositive: false, icon: Icons.cancel_rounded),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Booking Status Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
          const SizedBox(height: 12),
          ..._bookingStatuses.map((status) {
            int count = selectedStats[status.toLowerCase()] ?? 0;
            double percentage = selectedStats['totalBookings'] > 0 ? (count / selectedStats['totalBookings']) * 100 : 0;
            Color statusColor = _getStatusColor(status);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)), const SizedBox(width: 10), Text(status, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _textDark))]),
                    Text('$count (${percentage.toStringAsFixed(1)}%)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: statusColor)),
                  ]),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: count / selectedStats['totalBookings'], backgroundColor: _borderColor, color: statusColor, minHeight: 6, borderRadius: BorderRadius.circular(3)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required String change, required bool isPositive, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: _borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Center(child: Icon(icon, size: 20, color: _primaryColor))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: isPositive ? _successColor.withOpacity(0.1) : _dangerColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [Icon(isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded, size: 12, color: isPositive ? _successColor : _dangerColor), const SizedBox(width: 4), Text(change, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isPositive ? _successColor : _dangerColor))]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _textDark)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: _textLight)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return _successColor;
      case 'Pending': return _warningColor;
      case 'Cancelled': return _dangerColor;
      case 'Completed': return _secondaryColor;
      default: return _primaryColor;
    }
  }

  Widget _buildPaymentOverview() {
    List<Map<String, dynamic>> paymentData = [];

    for (var category in _resortCategoryData) {
      int occupiedCount = category['occupied'] as int;
      double price = category['price'] as double;
      double totalAmount = occupiedCount * price * 7;

      paymentData.add({
        'category': category['type'],
        'icon': _getCategoryIcon(category['type']),
        'color': _getCategoryColor(category['type']),
        'bookedCount': occupiedCount,
        'pricePerNight': price,
        'totalNights': 7,
        'totalAmount': totalAmount,
        'paymentStatus': 'Paid',
        'paymentDate': '2024-01-15',
      });
    }

    double totalProfit = paymentData.fold(0.0, (sum, item) => sum + (item['totalAmount'] as double));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              Text('Payment Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: _primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(Icons.payment_rounded, size: 14, color: _primaryColor),
                    const SizedBox(width: 6),
                    Text('Revenue Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 140, child: Text('Resort Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)))),
                        const SizedBox(width: 80, child: Text('Booked', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 80, child: Text('Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                        const SizedBox(width: 100, child: Text('Total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),

                  ...paymentData.map((payment) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                          SizedBox(
                            width: 140,
                            child: Row(
                              children: [
                                Icon(payment['icon'], size: 14, color: payment['color']),
                                const SizedBox(width: 4),
                                Text(
                                  payment['category'] as String,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: payment['color']),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              '${payment['bookedCount']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 12, color: _textLight),
                                Text(
                                  '${payment['pricePerNight']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _textDark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee_rounded, size: 14, color: _successColor),
                                Text(
                                  '${payment['totalAmount']}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _successColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(color: _primaryColor.withOpacity(0.2)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Overall', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _bgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 14, color: _textLight),
                        const SizedBox(width: 6),
                        const Text('Jan 2024', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                        const SizedBox(width: 4),
                        Icon(Icons.expand_more_rounded, size: 16, color: Color(0xFF6B7280)),
                        const SizedBox(width: 8),
                        Container(height: 16, width: 1, color: _borderColor),
                        const SizedBox(width: 8),
                        const Text('Total Profit - ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
                        Icon(Icons.currency_rupee_rounded, size: 12, color: _successColor),
                        Text(
                          '${totalProfit.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _successColor),
                        ),
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
                    child: Icon(Icons.nature_people, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.resortName,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text('Resort Owner', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildDrawerItem(Icons.dashboard_rounded, 'Dashboard', 0),
            _buildDrawerItem(Icons.category_rounded, 'Resort Categories', 1),
            _buildDrawerItem(Icons.calendar_month_rounded, 'Booking Calendar', 2),
            _buildDrawerItem(Icons.analytics_rounded, 'Revenue Analytics', 3),
            _buildDrawerItem(Icons.reviews_rounded, 'Guest Reviews', 4),
            _buildDrawerItem(Icons.people_alt_rounded, 'Staff Management', 5),
            _buildDrawerItem(Icons.inventory_rounded, 'Inventory', 6),
            const Divider(indent: 20, endIndent: 20),
            _buildDrawerItem(Icons.settings_rounded, 'Resort Settings', 7),
            _buildDrawerItem(Icons.help_center_rounded, 'Help Center', 8),
            _buildDrawerItem(Icons.logout_rounded, 'Logout', 9),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Resort Status: Active', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2E7D32))),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.85,
                    backgroundColor: _borderColor,
                    color: _successColor,
                  ),
                  const SizedBox(height: 4),
                  Text('85% rooms configured', style: TextStyle(fontSize: 11, color: _textLight)),
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
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? _primaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: _selectedIndex == index ? _primaryColor : _textDark),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? _primaryColor : _textDark,
          fontWeight: _selectedIndex == index ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      trailing: _selectedIndex == index ? Container(width: 6, height: 6, decoration: BoxDecoration(color: _primaryColor, shape: BoxShape.circle)) : null,
      onTap: () { setState(() { _selectedIndex = index; }); Navigator.pop(context); },
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
      selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      onTap: (index) { setState(() { _selectedIndex = index; }); },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), activeIcon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
        const BottomNavigationBarItem(icon: Icon(Icons.category_rounded), activeIcon: Icon(Icons.category_rounded), label: 'Categories'),
        const BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), activeIcon: Icon(Icons.calendar_month_rounded), label: 'Bookings'),
        const BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), activeIcon: Icon(Icons.analytics_rounded), label: 'Analytics'),
        const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    );
  }

  void _addNewResortCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Resort Category'),
        content: const Text('Feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile section coming soon'),
        backgroundColor: _primaryColor,
      ),
    );
  }
}

class _ResortBookingTrendGraphPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;
  final double minValue;
  final Color primaryColor;
  final Color secondaryColor;

  _ResortBookingTrendGraphPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    Paint linePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint fillPaint = Paint()
      ..color = primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    Path linePath = Path();
    Path fillPath = Path();

    double stepX = size.width / (data.length - 1);
    double range = maxValue - minValue;
    if (range == 0) range = 1;

    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    Paint dotPaint = Paint()..color = primaryColor..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - ((data[i] - minValue) / range) * size.height;
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}