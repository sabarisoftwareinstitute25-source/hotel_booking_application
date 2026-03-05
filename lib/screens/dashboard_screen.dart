// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import 'all_users_screen.dart';
// import 'profile_verification_screen.dart';
// import 'user_report_screen.dart';
// import 'admin_users_screen.dart';
// import '../widgets/stats_card.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _screens = [
//     const DashboardContent(),
//     const AllUsersScreen(),
//     const ProfileVerificationScreen(),
//     const UserReportScreen(),
//     const AdminUsersScreen(),
//   ];
//
//   final List<String> _titles = [
//     'Admin  Dashboard',
//     'All Users',
//     'Profile Verification',
//     'User Reports',
//     'Office & Admin User',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           _titles[_selectedIndex],
//           style: const TextStyle(
//             color: Color(0xFF1E293B),
//             fontSize: 21,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: false,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(
//                 Icons.menu_rounded,
//                 color: Color(0xFF1E293B),
//                 size: 22,
//               ),
//             ),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               icon: Stack(
//                 children: [
//                   const Icon(
//                     Icons.notifications_outlined,
//                     color: Color(0xFF1E293B),
//                     size: 22,
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Container(
//                       width: 8,
//                       height: 8,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFEF4444),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               onPressed: () {},
//             ),
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.person_rounded,
//               color: Color(0xFF1E293B),
//               size: 22,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       drawer: _buildPremiumDrawer(),
//       body: _screens[_selectedIndex],
//     );
//   }
//
//   Widget _buildPremiumDrawer() {
//     return Drawer(
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//
//             Container(
//               padding: const EdgeInsets.all(24),
//               height: 220,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.admin_panel_settings_rounded,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Admin Panel',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration: const BoxDecoration(
//                           color: Colors.green,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'Online • Administrator',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 children: [
//                   _buildPremiumDrawerItem(
//                     icon: Icons.dashboard_rounded,
//                     title: 'Dashboard',
//                     index: 0,
//                   ),
//                   _buildPremiumDrawerItem(
//                     icon: Icons.people_alt_rounded,
//                     title: 'All Users',
//                     index: 1,
//                     count: '12',
//                   ),
//                   _buildPremiumDrawerItem(
//                     icon: Icons.verified_rounded,
//                     title: 'Profile Verification',
//                     index: 2,
//                     count: '5',
//                   ),
//                   _buildPremiumDrawerItem(
//                     icon: Icons.assessment_rounded,
//                     title: 'User Reports',
//                     index: 3,
//                   ),
//                   _buildPremiumDrawerItem(
//                     icon: Icons.admin_panel_settings_rounded,
//                     title: 'Admin Users',
//                     index: 4,
//                   ),
//
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Divider(height: 1),
//                   ),
//
//                   _buildPremiumDrawerItem(
//                     icon: Icons.settings_rounded,
//                     title: 'Settings',
//                     onTap: () {},
//                   ),
//                   _buildPremiumDrawerItem(
//                     icon: Icons.logout_rounded,
//                     title: 'Logout',
//                     onTap: () {},
//                     isLogout: true,
//                   ),
//                 ],
//               ),
//             ),
//
//
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 6,
//                     height: 6,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[400],
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     'Version 1.0.0',
//                     style: TextStyle(
//                       color: Colors.grey[500],
//                       fontSize: 12,
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
//   Widget _buildPremiumDrawerItem({
//     required IconData icon,
//     required String title,
//     int? index,
//     VoidCallback? onTap,
//     String? count,
//     bool isLogout = false,
//   }) {
//     final isSelected = index != null && _selectedIndex == index;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF4157FF).withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? const Color(0xFF4157FF).withOpacity(0.2)
//                 : Colors.grey[100],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             icon,
//             color: isSelected
//                 ? const Color(0xFF4157FF)
//                 : isLogout
//                 ? Colors.red
//                 : Colors.grey[600],
//             size: 20,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: isSelected
//                 ? const Color(0xFF4157FF)
//                 : isLogout
//                 ? Colors.red
//                 : const Color(0xFF1E293B),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             fontSize: 15,
//           ),
//         ),
//         trailing: count != null
//             ? Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: Colors.red.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             count,
//             style: const TextStyle(
//               color: Colors.red,
//               fontSize: 11,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         )
//             : null,
//         selected: isSelected,
//         onTap: () {
//           if (index != null) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           } else if (onTap != null) {
//             onTap();
//           }
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
//
// class DashboardContent extends StatelessWidget {
//   const DashboardContent({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//
//           Container(
//             padding: const EdgeInsets.all(24),
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
//               ),
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF4157FF).withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 // Row(
//                 //   children: [
//                 //     // Expanded(
//                 //     //   child: Column(
//                 //     //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     //     children: [
//                 //     //       const Text(
//                 //     //         'Welcome back,',
//                 //     //         style: TextStyle(
//                 //     //           color: Colors.white70,
//                 //     //           fontSize: 14,
//                 //     //         ),
//                 //     //       ),
//                 //     //       const SizedBox(height: 4),
//                 //     //       const Text(
//                 //     //         'Admin User',
//                 //     //         style: TextStyle(
//                 //     //           color: Colors.white,
//                 //     //           fontSize: 24,
//                 //     //           fontWeight: FontWeight.bold,
//                 //     //         ),
//                 //     //       ),
//                 //     //       const SizedBox(height: 8),
//                 //     //       Container(
//                 //     //         padding: const EdgeInsets.symmetric(
//                 //     //           horizontal: 12,
//                 //     //           vertical: 6,
//                 //     //         ),
//                 //     //         decoration: BoxDecoration(
//                 //     //           color: Colors.white.withOpacity(0.2),
//                 //     //           borderRadius: BorderRadius.circular(20),
//                 //     //         ),
//                 //     //         child: const Text(
//                 //     //           'Last login: Today 09:45 AM',
//                 //     //           style: TextStyle(
//                 //     //             color: Colors.white,
//                 //     //             fontSize: 12,
//                 //     //           ),
//                 //     //         ),
//                 //     //       ),
//                 //     //     ],
//                 //     //   ),
//                 //     // ),
//                 //     // Container(
//                 //     //   width: 70,
//                 //     //   height: 70,
//                 //     //   decoration: BoxDecoration(
//                 //     //     color: Colors.white.withOpacity(0.2),
//                 //     //     shape: BoxShape.circle,
//                 //     //   ),
//                 //     //   child: const Icon(
//                 //     //     Icons.analytics_rounded,
//                 //     //     color: Colors.white,
//                 //     //     size: 35,
//                 //     //   ),
//                 //     // ),
//                 //   ],
//                 // ),
//
//                 const SizedBox(height: 4),
//
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _buildQuickStat('Users', '2.5k', Icons.people_rounded),
//                     _buildQuickStat('Vendors', '397', Icons.business_rounded),
//                     _buildQuickStat('Bookings', '1.8k', Icons.book_online_rounded),
//                     _buildQuickStat('Revenue', '\$45k', Icons.attach_money_rounded),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Overview',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF4157FF).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Text(
//                         'This Month',
//                         style: TextStyle(
//                           color: Color(0xFF4157FF),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Stats Grid
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 1.2,
//               children: [
//                 _buildPremiumStatCard(
//                   title: 'Total Users',
//                   value: '2,547',
//                   icon: Icons.people_alt_rounded,
//                   color: const Color(0xFF4157FF),
//                   trend: '+12.5%',
//                   trendUp: true,
//                 ),
//                 _buildPremiumStatCard(
//                   title: 'Active Vendors',
//                   value: '89',
//                   icon: Icons.business_center_rounded,
//                   color: const Color(0xFF10B981),
//                   trend: '+5.2%',
//                   trendUp: true,
//                 ),
//                 _buildPremiumStatCard(
//                   title: 'Pending',
//                   value: '23',
//                   icon: Icons.pending_actions_rounded,
//                   color: const Color(0xFFF59E0B),
//                   trend: '-2.1%',
//                   trendUp: false,
//                 ),
//                 _buildPremiumStatCard(
//                   title: 'Total Bookings',
//                   value: '1,892',
//                   icon: Icons.book_online_rounded,
//                   color: const Color(0xFF8B5CF6),
//                   trend: '+18.3%',
//                   trendUp: true,
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           // Charts & Activities Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 Container(
//                   width: 4,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
//                     ),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'Recent Activities',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Activity List
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 _buildActivityItem(
//                   'New customer registered',
//                   'John Doe created an account',
//                   '5 min ago',
//                   Icons.person_add_alt_1_rounded,
//                   const Color(0xFF4157FF),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildActivityItem(
//                   'Vendor approved',
//                   'Grand Hotel verification completed',
//                   '1 hour ago',
//                   Icons.check_circle_rounded,
//                   const Color(0xFF10B981),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildActivityItem(
//                   'New booking',
//                   'Beach Resort - 2 rooms booked',
//                   '3 hours ago',
//                   Icons.hotel_rounded,
//                   const Color(0xFF8B5CF6),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildActivityItem(
//                   'Profile pending',
//                   'City Inn requires verification',
//                   '5 hours ago',
//                   Icons.pending_rounded,
//                   const Color(0xFFF59E0B),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           // Quick Actions
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Quick Actions',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'View All',
//                     style: TextStyle(
//                       color: Color(0xFF4157FF),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           // Action Buttons
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: _buildActionButton(
//                     'Add User',
//                     Icons.person_add_alt_rounded,
//                     const Color(0xFF4157FF),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _buildActionButton(
//                     'Add Vendor',
//                     Icons.business_center_rounded,
//                     const Color(0xFF10B981),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _buildActionButton(
//                     'Generate Report',
//                     Icons.insert_drive_file_rounded,
//                     const Color(0xFF8B5CF6),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickStat(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 22),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPremiumStatCard({
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//     required String trend,
//     required bool trendUp,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: color, size: 20),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: trendUp
//                       ? Colors.green.withOpacity(0.1)
//                       : Colors.red.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       trendUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
//                       size: 10,
//                       color: trendUp ? Colors.green : Colors.red,
//                     ),
//                     const SizedBox(width: 2),
//                     Text(
//                       trend,
//                       style: TextStyle(
//                         color: trendUp ? Colors.green : Colors.red,
//                         fontSize: 9,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF1E293B),
//             ),
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActivityItem(String title, String subtitle, String time, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: color, size: 20),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               Text(
//                 time,
//                 style: TextStyle(
//                   fontSize: 11,
//                   color: Colors.grey[500],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton(String label, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 20),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               color: color,
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'all_users_screen.dart';
import 'profile_verification_screen.dart';
import 'user_report_screen.dart';
import 'admin_users_screen.dart';
import '../widgets/stats_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardContent(),
    const AllUsersScreen(),
    const ProfileVerificationScreen(),
    const UserReportScreen(),
    const AdminUsersScreen(),
  ];

  final List<String> _titles = [
    'Admin Dashboard',
    'All Users',
    'Profile Verification',
    'User Reports',
    'Office & Admin User',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.menu_rounded,
                color: Color(0xFF1E293B),
                size: 22,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF1E293B),
                    size: 22,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person_rounded,
              color: Color(0xFF1E293B),
              size: 22,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildPremiumDrawer(),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildPremiumDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Online • Administrator',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPremiumDrawerItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    index: 0,
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.people_alt_rounded,
                    title: 'All Users',
                    index: 1,
                    count: '12',
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.verified_rounded,
                    title: 'Profile Verification',
                    index: 2,
                    count: '5',
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.assessment_rounded,
                    title: 'User Reports',
                    index: 3,
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.admin_panel_settings_rounded,
                    title: 'Admin Users',
                    index: 4,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1),
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildPremiumDrawerItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    onTap: () {},
                    isLogout: true,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
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

  Widget _buildPremiumDrawerItem({
    required IconData icon,
    required String title,
    int? index,
    VoidCallback? onTap,
    String? count,
    bool isLogout = false,
  }) {
    final isSelected = index != null && _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4157FF).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4157FF).withOpacity(0.2)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? const Color(0xFF4157FF)
                : isLogout
                ? Colors.red
                : Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF4157FF)
                : isLogout
                ? Colors.red
                : const Color(0xFF1E293B),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: count != null
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
            : null,
        selected: isSelected,
        onTap: () {
          if (index != null) {
            setState(() {
              _selectedIndex = index;
            });
          } else if (onTap != null) {
            onTap();
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}





class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4157FF).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickStat('Total Users', '2.5k', Icons.people_rounded),
                _buildQuickStat('Total Vendors', '397', Icons.business_rounded),
                _buildQuickStat('Total Bookings', '1.8k', Icons.book_online_rounded),
                _buildQuickStat('Revenue', '\$45k', Icons.attach_money_rounded),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Customer Overview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4157FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'This Month',
                        style: TextStyle(
                          color: Color(0xFF4157FF),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),


                Row(
                  children: [

                    Expanded(
                      child: _buildCustomerStatCard(
                        title: 'Total Customers',
                        value: '2,547',
                        icon: Icons.people_alt_rounded,
                        color: const Color(0xFF4157FF),
                        trend: '+12.5%',
                        trendUp: true,
                      ),
                    ),
                    const SizedBox(width: 12),


                    Expanded(
                      child: _buildCustomerStatCard(
                        title: 'Booking Registered',
                        value: '1,892',
                        icon: Icons.book_online_rounded,
                        color: const Color(0xFF8B5CF6),
                        trend: '+18.3%',
                        trendUp: true,
                      ),
                    ),
                    const SizedBox(width: 12),


                    Expanded(
                      child: _buildCustomerStatCard(
                        title: 'Cancellation',
                        value: '48',
                        icon: Icons.cancel_rounded,
                        color: const Color(0xFFEF4444),
                        trend: '-5.2%',
                        trendUp: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF34D399)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Vendor Overview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'This Month',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
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
                  childAspectRatio: 1.4,
                  children: [
                    _buildVendorStatCard(
                      title: 'Active Vendors',
                      value: '89',
                      icon: Icons.business_center_rounded,
                      color: const Color(0xFF10B981),
                      trend: '+5.2%',
                      trendUp: true,
                    ),
                    _buildVendorStatCard(
                      title: 'Pending Verification',
                      value: '23',
                      icon: Icons.pending_actions_rounded,
                      color: const Color(0xFFF59E0B),
                      trend: '-2.1%',
                      trendUp: false,
                    ),
                    _buildVendorStatCard(
                      title: 'Rejected',
                      value: '12',
                      icon: Icons.cancel_rounded,
                      color: const Color(0xFFEF4444),
                      trend: '+1.3%',
                      trendUp: false,
                    ),
                    _buildVendorStatCard(
                      title: 'Cancellation',
                      value: '8',
                      icon: Icons.cancel_schedule_send_rounded,
                      color: const Color(0xFF6B7280),
                      trend: '-0.5%',
                      trendUp: true,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Recent Activities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildActivityItem(
                  'New customer registered',
                  'John Doe created an account',
                  '5 min ago',
                  Icons.person_add_alt_1_rounded,
                  const Color(0xFF4157FF),
                ),
                const SizedBox(height: 12),
                _buildActivityItem(
                  'Vendor approved',
                  'Grand Hotel verification completed',
                  '1 hour ago',
                  Icons.check_circle_rounded,
                  const Color(0xFF10B981),
                ),
                const SizedBox(height: 12),
                _buildActivityItem(
                  'Vendor pending',
                  'City Inn requires verification',
                  '3 hours ago',
                  Icons.pending_rounded,
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(height: 12),
                _buildActivityItem(
                  'New booking',
                  'Beach Resort - 2 rooms booked',
                  '5 hours ago',
                  Icons.hotel_rounded,
                  const Color(0xFF8B5CF6),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF4157FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),


                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        'Add User',
                        Icons.person_add_alt_rounded,
                        const Color(0xFF4157FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        'Add Vendor',
                        Icons.business_center_rounded,
                        const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        'Verify Vendor',
                        Icons.verified_rounded,
                        const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
    required bool trendUp,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: trendUp
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 8,
                      color: trendUp ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 1),
                    Text(
                      trend,
                      style: TextStyle(
                        color: trendUp ? Colors.green : Colors.red,
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildVendorStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
    required bool trendUp,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: trendUp
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trendUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 8,
                      color: trendUp ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 1),
                    Text(
                      trend,
                      style: TextStyle(
                        color: trendUp ? Colors.green : Colors.red,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}