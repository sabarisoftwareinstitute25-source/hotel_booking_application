// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
//
// class UserReportScreen extends StatefulWidget {
//   const UserReportScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UserReportScreen> createState() => _UserReportScreenState();
// }
//
// class _UserReportScreenState extends State<UserReportScreen> {
//   String _selectedPeriod = 'Weekly';
//   final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Reports'),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'User Analytics',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: AppTheme.textPrimary,
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: _periods.map((period) {
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             _selectedPeriod = period;
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _selectedPeriod == period
//                                 ? AppTheme.primaryColor
//                                 : Colors.transparent,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             period,
//                             style: TextStyle(
//                               color: _selectedPeriod == period
//                                   ? Colors.white
//                                   : AppTheme.textSecondary,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'User Registration Trends',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppTheme.textPrimary,
//                           ),
//                         ),
//                         Icon(Icons.trending_up, color: AppTheme.accentColor),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//
//                     Container(
//                       height: 180,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           _buildBarChartItem('Mon', 5, Colors.blue),
//                           _buildBarChartItem('Tue', 8, Colors.blue),
//                           _buildBarChartItem('Wed', 6, Colors.blue),
//                           _buildBarChartItem('Thu', 10, Colors.blue),
//                           _buildBarChartItem('Fri', 7, Colors.blue),
//                           _buildBarChartItem('Sat', 12, Colors.blue),
//                           _buildBarChartItem('Sun', 9, Colors.blue),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildTrendStat('Total', '57', Icons.people, AppTheme.primaryColor),
//                         _buildTrendStat('Average', '8.1', Icons.show_chart, AppTheme.accentColor),
//                         _buildTrendStat('Peak', '12', Icons.trending_up, AppTheme.warningColor),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildStatCard(
//                     'Total Users',
//                     '2,547',
//                     Icons.people,
//                     AppTheme.primaryColor,
//                     '+12.5%',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _buildStatCard(
//                     'Active Today',
//                     '342',
//                     Icons.today,
//                     AppTheme.accentColor,
//                     '+5.2%',
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildStatCard(
//                     'Avg. Session',
//                     '12.4 min',
//                     Icons.timer,
//                     AppTheme.secondaryColor,
//                     '-2.1%',
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _buildStatCard(
//                     'Retention Rate',
//                     '78%',
//                     Icons.trending_up,
//                     AppTheme.warningColor,
//                     '+3.8%',
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'User Distribution',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//
//                     _buildDistributionBar('Customers', 2150, 2547, Colors.blue),
//                     const SizedBox(height: 12),
//                     _buildDistributionBar('Vendors', 397, 2547, Colors.green),
//
//                     const SizedBox(height: 16),
//
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildPieSegment(0.7, Colors.blue, 'Customers', '2,150'),
//                         const SizedBox(width: 20),
//                         _buildPieSegment(0.3, Colors.green, 'Vendors', '397'),
//                       ],
//                     ),
//
//                     const SizedBox(height: 16),
//
//
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade50,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.grey.shade200),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildSimpleStat('New Today', '24', Icons.fiber_new),
//                           _buildSimpleStat('This Week', '156', Icons.date_range),
//                           _buildSimpleStat('This Month', '423', Icons.calendar_month),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Export Reports',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildExportButton(
//                             'PDF',
//                             Icons.picture_as_pdf,
//                             AppTheme.dangerColor,
//                                 () => _showExportSuccess(context, 'PDF'),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: _buildExportButton(
//                             'Excel',
//                             Icons.table_chart,
//                             AppTheme.accentColor,
//                                 () => _showExportSuccess(context, 'Excel'),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     _buildExportButton(
//                       'CSV',
//                       Icons.file_copy,
//                       AppTheme.secondaryColor,
//                           () => _showExportSuccess(context, 'CSV'),
//                       isFullWidth: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildBarChartItem(String day, int value, Color color) {
//     double maxValue = 12.0;
//     double barHeight = (value / maxValue) * 120;
//
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             height: barHeight,
//             width: 20,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.7),
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(4),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 value.toString(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             day,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildTrendStat(String label, String value, IconData icon, Color color) {
//     return Column(
//       children: [
//         Icon(icon, color: color, size: 18),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppTheme.textPrimary,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildDistributionBar(String label, int count, int total, Color color) {
//     double percentage = count / total;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//             Text(
//               '$count (${(percentage * 100).toStringAsFixed(1)}%)',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         Stack(
//           children: [
//             Container(
//               height: 8,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             Container(
//               height: 8,
//               width: MediaQuery.of(context).size.width * 0.7 * percentage,
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildPieSegment(double percentage, Color color, String label, String value) {
//     return Column(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: color, width: 8),
//             color: Colors.transparent,
//           ),
//           child: Center(
//             child: Text(
//               '${(percentage * 100).toInt()}%',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: AppTheme.textPrimary,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildStatCard(String title, String value, IconData icon, Color color, String change) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(icon, color: color, size: 20),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: change.startsWith('+')
//                         ? Colors.green.withOpacity(0.1)
//                         : Colors.red.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     change,
//                     style: TextStyle(
//                       color: change.startsWith('+') ? Colors.green : Colors.red,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildSimpleStat(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Icon(icon, color: AppTheme.primaryColor, size: 18),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: AppTheme.textPrimary,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.grey[600],
//             fontSize: 10,
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildExportButton(String label, IconData icon, Color color, VoidCallback onPressed, {bool isFullWidth = false}) {
//     return OutlinedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 18),
//       label: Text(label),
//       style: OutlinedButton.styleFrom(
//         foregroundColor: color,
//         side: BorderSide(color: color),
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         minimumSize: isFullWidth ? const Size(double.infinity, 45) : null,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }
//
//   void _showExportSuccess(BuildContext context, String format) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Report exported as $format successfully'),
//         backgroundColor: AppTheme.accentColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
// }










import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({Key? key}) : super(key: key);

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  String _selectedPeriod = 'Weekly';
  final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];


  String _selectedHotelStar = 'All';
  String _selectedMonth = 'March';
  final List<String> _months = ['January', 'February', 'March', 'April', 'May', 'June'];


  final List<String> _hotelStars = ['1 Star', '2 Star', '3 Star', '4 Star', '5 Star', '6 Star', '7 Star'];
  final List<String> _bookingStatuses = ['Confirmed', 'Pending', 'Completed', 'Cancelled'];


  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }


  Map<String, List<double>> _generateWaveData(String hotelStar) {
    Map<String, List<double>> data = {};

    for (String star in _hotelStars) {
      if (hotelStar == 'All' || hotelStar == star) {
        List<double> wavePoints = [];
        int days = 30;

        for (int i = 0; i < days; i++) {

          double baseValue = 0;
          switch (star) {
            case '1 Star':
              baseValue = 5;
              break;
            case '2 Star':
              baseValue = 8;
              break;
            case '3 Star':
              baseValue = 12;
              break;
            case '4 Star':
              baseValue = 15;
              break;
            case '5 Star':
              baseValue = 10;
              break;
            case '6 Star':
              baseValue = 7;
              break;
            case '7 Star':
              baseValue = 4;
              break;
          }

          double variation = sin(i * 0.3) * 5 + cos(i * 0.5) * 3;
          double trend = i * 0.1;
          double noise = (Random().nextDouble() * 3) - 1.5;

          wavePoints.add(baseValue + variation + trend + noise);
        }
        data[star] = wavePoints;
      }
    }

    if (hotelStar == 'All') {
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

  // Monthly stats using hotel data
  Map<String, Map<String, dynamic>> _getMonthlyStats() {
    return {
      'January': {
        'totalBookings': 103,
        'confirmed': 45,
        'pending': 12,
        'cancelled': 8,
        'completed': 38,
        'revenue': 325000,
        'occupancy': 78.5,
        'hotelStars': {
          '1 Star': 12,
          '2 Star': 18,
          '3 Star': 25,
          '4 Star': 22,
          '5 Star': 15,
          '6 Star': 8,
          '7 Star': 3,
        }
      },
      'February': {
        'totalBookings': 122,
        'confirmed': 52,
        'pending': 15,
        'cancelled': 10,
        'completed': 45,
        'revenue': 385000,
        'occupancy': 82.3,
        'hotelStars': {
          '1 Star': 14,
          '2 Star': 20,
          '3 Star': 28,
          '4 Star': 24,
          '5 Star': 18,
          '6 Star': 10,
          '7 Star': 8,
        }
      },
      'March': {
        'totalBookings': 107,
        'confirmed': 48,
        'pending': 10,
        'cancelled': 7,
        'completed': 42,
        'revenue': 355000,
        'occupancy': 79.8,
        'hotelStars': {
          '1 Star': 13,
          '2 Star': 19,
          '3 Star': 26,
          '4 Star': 23,
          '5 Star': 16,
          '6 Star': 7,
          '7 Star': 3,
        }
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final monthlyStats = _getMonthlyStats();
    final selectedStats = monthlyStats[_selectedMonth] ?? monthlyStats['March']!;

    // Get graph data
    Map<String, List<double>> waveData = _generateWaveData(_selectedHotelStar);
    List<double> currentWaveData = waveData[_selectedHotelStar] ?? waveData['All'] ?? [];

    double maxValue = currentWaveData.isNotEmpty
        ? currentWaveData.reduce((a, b) => a > b ? a : b)
        : 0;
    double minValue = currentWaveData.isNotEmpty
        ? currentWaveData.reduce((a, b) => a < b ? a : b)
        : 0;
    double average = currentWaveData.isNotEmpty
        ? currentWaveData.reduce((a, b) => a + b) / currentWaveData.length
        : 0;
    double currentValue = currentWaveData.isNotEmpty ? currentWaveData.last : 0;

    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'User Performance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: _periods.map((period) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedPeriod = period;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedPeriod == period
                                ? AppTheme.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            period,
                            style: TextStyle(
                              color: _selectedPeriod == period
                                  ? Colors.white
                                  : AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SECTION 1: Hotel Booking Trends by Star Category
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hotel Booking Trends by Star',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Icon(Icons.trending_up, color: AppTheme.accentColor),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Filter Row with Hotel Star and Date Range
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hotel Star Category',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey[300]!),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedHotelStar,
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                                          items: [
                                            const DropdownMenuItem(
                                              value: 'All',
                                              child: Text('All Categories'),
                                            ),
                                            ..._hotelStars.map((star) {
                                              return DropdownMenuItem(
                                                value: star,
                                                child: Row(
                                                  children: [
                                                    Text(star),
                                                    const SizedBox(width: 4),
                                                    Icon(Icons.star, color: Colors.amber, size: 14),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedHotelStar = value!;
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
                                    const Text(
                                      'Date Range',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () => _selectDateRange(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey[300]!),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 14, color: AppTheme.primaryColor),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${_startDate.day}/${_startDate.month} - ${_endDate.day}/${_endDate.month}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
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

                    // Graph
                    Container(
                      height: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Container(
                            width: 40,
                            padding: const EdgeInsets.only(right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(maxValue.toStringAsFixed(0), style: const TextStyle(fontSize: 10)),
                                Text(((maxValue + minValue) / 2).toStringAsFixed(0), style: const TextStyle(fontSize: 10)),
                                Text(minValue.toStringAsFixed(0), style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),

                          // Graph area
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: CustomPaint(
                                size: Size(double.infinity, 200),
                                painter: _BookingTrendPainter(
                                  data: currentWaveData,
                                  maxValue: maxValue,
                                  minValue: minValue,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildGraphStat('Current', currentValue.toStringAsFixed(1), AppTheme.primaryColor),
                        _buildGraphStat('Average', average.toStringAsFixed(1), AppTheme.accentColor),
                        _buildGraphStat('Peak', maxValue.toStringAsFixed(1), AppTheme.warningColor),
                        _buildGraphStat('Low', minValue.toStringAsFixed(1), AppTheme.secondaryColor),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // // Legend for star categories when "All" is selected
                    // if (_selectedHotelStar == 'All')
                    //   Container(
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey[50],
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: Wrap(
                    //       spacing: 12,
                    //       runSpacing: 6,
                    //       children: [
                    //         _buildLegendItem('1-2 Star', Colors.blue.shade300),
                    //         _buildLegendItem('3-4 Star', Colors.green),
                    //         _buildLegendItem('5 Star', Colors.orange),
                    //         _buildLegendItem('6-7 Star', Colors.purple),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),


            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Monthly Hotel Statistics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedMonth,
                              icon: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                              items: _months.map((month) {
                                return DropdownMenuItem(
                                  value: month,
                                  child: Text(month, style: const TextStyle(fontSize: 13)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMonth = value!;
                                });
                              },
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
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildMonthStatCard(
                          'Total Bookings',
                          selectedStats['totalBookings'].toString(),
                          Icons.calendar_month,
                          AppTheme.primaryColor,
                          '+12%',
                        ),
                        _buildMonthStatCard(
                          'Revenue',
                          '₹${(selectedStats['revenue'] / 1000).toStringAsFixed(0)}K',
                          Icons.currency_rupee,
                          AppTheme.accentColor,
                          '+8%',
                        ),
                        _buildMonthStatCard(
                          'Occupancy',
                          '${selectedStats['occupancy']}%',
                          Icons.percent,
                          AppTheme.warningColor,
                          '+5%',
                        ),
                        _buildMonthStatCard(
                          'Cancellation',
                          '${((selectedStats['cancelled'] / selectedStats['totalBookings']) * 100).toStringAsFixed(1)}%',
                          Icons.cancel,
                          AppTheme.secondaryColor,
                          '-2%',
                          isPositive: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),


                    const Text(
                      'Booking Distribution by Star',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),


                    ..._hotelStars.map((star) {
                      int count = selectedStats['hotelStars'][star] ?? 0;
                      double percentage = (count / selectedStats['totalBookings']) * 100;
                      Color starColor = _getStarColor(star);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      star,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '$count (${percentage.toStringAsFixed(1)}%)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: starColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: count / selectedStats['totalBookings'],
                              backgroundColor: Colors.grey[200],
                              color: starColor,
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 20),


                    const Text(
                      'Booking Status',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ..._bookingStatuses.map((status) {
                      int count = selectedStats[status.toLowerCase()] ?? 0;
                      double percentage = (count / selectedStats['totalBookings']) * 100;
                      Color statusColor = _getStatusColor(status);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      status,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '$count (${percentage.toStringAsFixed(1)}%)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            LinearProgressIndicator(
                              value: count / selectedStats['totalBookings'],
                              backgroundColor: Colors.grey[200],
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
              ),
            ),

            const SizedBox(height: 20),

            // Your existing cards continue here...
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildStatCard(
            //         'Total Hotels',
            //         '156',
            //         Icons.business,
            //         AppTheme.primaryColor,
            //         '+12.5%',
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildStatCard(
            //         'Active Bookings',
            //         '342',
            //         Icons.book_online,
            //         AppTheme.accentColor,
            //         '+5.2%',
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 12),

            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildStatCard(
            //         'Avg. Rating',
            //         '4.2 ★',
            //         Icons.star,
            //         AppTheme.warningColor,
            //         '+0.3%',
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildStatCard(
            //         'Revenue',
            //         '₹45.2K',
            //         Icons.currency_rupee,
            //         AppTheme.primaryColor,
            //         '+8.2%',
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildGraphStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthStatCard(String title, String value, IconData icon, Color color, String change, {bool isPositive = true}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStarColor(String star) {
    switch (star) {
      case '1 Star':
      case '2 Star':
        return Colors.blue;
      case '3 Star':
      case '4 Star':
        return Colors.green;
      case '5 Star':
        return Colors.orange;
      case '6 Star':
      case '7 Star':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String change) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 20)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: change.startsWith('+') ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text(change, style: TextStyle(color: change.startsWith('+') ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the graph
class _BookingTrendPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;
  final double minValue;
  final Color color;

  _BookingTrendPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    double range = maxValue - minValue;
    if (range == 0) range = 1;

    double xStep = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      double x = i * xStep;
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < data.length; i += 3) {
      double x = i * xStep;
      double y = size.height - ((data[i] - minValue) / range) * size.height;

      canvas.drawCircle(Offset(x, y), 3, pointPaint);
      canvas.drawCircle(Offset(x, y), 3, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}