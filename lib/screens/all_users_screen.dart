// import 'package:flutter/material.dart';
// import '../models/user_model.dart';
// import '../theme/app_theme.dart';
// import '../widgets/user_tile.dart';
//
// class AllUsersScreen extends StatefulWidget {
//   const AllUsersScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AllUsersScreen> createState() => _AllUsersScreenState();
// }
//
// class _AllUsersScreenState extends State<AllUsersScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   HotelStar? _selectedStar;
//   DateTime? _selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Customers'),
//             Tab(text: 'Vendors'),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search users...',
//                       prefixIcon: const Icon(Icons.search),
//                       suffixIcon: _searchQuery.isNotEmpty
//                           ? IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           setState(() {
//                             _searchController.clear();
//                             _searchQuery = '';
//                           });
//                         },
//                       )
//                           : null,
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//
//                 Container(
//                   decoration: BoxDecoration(
//                     color: AppTheme.primaryColor,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.filter_list, color: Colors.white),
//                     onPressed: () => _showFilterDialog(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Active Filters
//           if (_selectedStar != null || _selectedDate != null)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Wrap(
//                 spacing: 8,
//                 children: [
//                   if (_selectedStar != null)
//                     Chip(
//                       label: Text('Star: ${_selectedStar!.displayName}'),
//                       onDeleted: () {
//                         setState(() {
//                           _selectedStar = null;
//                         });
//                       },
//                     ),
//                   if (_selectedDate != null)
//                     Chip(
//                       label: Text('Date: ${_selectedDate!.toString().split(' ')[0]}'),
//                       onDeleted: () {
//                         setState(() {
//                           _selectedDate = null;
//                         });
//                       },
//                     ),
//                 ],
//               ),
//             ),
//
//           const SizedBox(height: 8),
//
//           // Tab Views
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildCustomersList(),
//                 _buildVendorsList(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCustomersList() {
//     List<UserModel> customers = UserModel.demoCustomers();
//
//     // Apply filters
//     if (_searchQuery.isNotEmpty) {
//       customers = customers.where((customer) {
//         return customer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             customer.email.toLowerCase().contains(_searchQuery.toLowerCase());
//       }).toList();
//     }
//
//     if (_selectedDate != null) {
//       customers = customers.where((customer) {
//         return customer.registrationDate.year == _selectedDate!.year &&
//             customer.registrationDate.month == _selectedDate!.month &&
//             customer.registrationDate.day == _selectedDate!.day;
//       }).toList();
//     }
//
//     if (customers.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.people_outline,
//               size: 64,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No customers found',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: customers.length,
//       itemBuilder: (context, index) {
//         return UserTile(
//           user: customers[index],
//           onTap: () => _showUserDetails(context, customers[index]),
//         );
//       },
//     );
//   }
//
//   Widget _buildVendorsList() {
//     List<UserModel> vendors = UserModel.demoVendors();
//
//     // Apply filters
//     if (_searchQuery.isNotEmpty) {
//       vendors = vendors.where((vendor) {
//         return vendor.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             vendor.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//             (vendor.hotelName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
//       }).toList();
//     }
//
//     if (_selectedStar != null) {
//       vendors = vendors.where((vendor) {
//         return vendor.hotelStar == _selectedStar;
//       }).toList();
//     }
//
//     if (_selectedDate != null) {
//       vendors = vendors.where((vendor) {
//         return vendor.registrationDate.year == _selectedDate!.year &&
//             vendor.registrationDate.month == _selectedDate!.month &&
//             vendor.registrationDate.day == _selectedDate!.day;
//       }).toList();
//     }
//
//     if (vendors.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.business_outlined,
//               size: 64,
//               color: Colors.grey[400],
//             ),
//             Icon(
//               Icons.message_outlined ,
//               size:64,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No vendors found',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: vendors.length,
//       itemBuilder: (context, index) {
//         return UserTile(
//           user: vendors[index],
//           onTap: () => _showVendorDetails(context, vendors[index]),
//           showActions: true,
//         );
//       },
//     );
//   }
//
//   void _showFilterDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Filter Users',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Hotel Stars',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Wrap(
//                 spacing: 8,
//                 children: HotelStar.values.map((star) {
//                   return FilterChip(
//                     label: Text(star.displayName),
//                     selected: _selectedStar == star,
//                     onSelected: (selected) {
//                       setState(() {
//                         _selectedStar = selected ? star : null;
//                       });
//                       Navigator.pop(context);
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Registration Date',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: _selectedDate ?? DateTime.now(),
//                     firstDate: DateTime(2020),
//                     lastDate: DateTime.now(),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       _selectedDate = pickedDate;
//                     });
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Select Date'),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         setState(() {
//                           _selectedStar = null;
//                           _selectedDate = null;
//                         });
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Clear Filters'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showUserDetails(BuildContext context, UserModel user) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(user.name),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Email: ${user.email}'),
//             Text('Phone: ${user.phone}'),
//             Text('Joined: ${user.registrationDate.toString().split(' ')[0]}'),
//             Text('Total Bookings: ${user.totalBookings}'),
//             Text('Status: ${user.verificationStatus.toString().split('.').last}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showVendorDetails(BuildContext context, UserModel vendor) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(vendor.name),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Hotel: ${vendor.hotelName ?? 'N/A'}'),
//             Text('Star: ${vendor.hotelStar?.displayName ?? 'N/A'}'),
//             Text('Email: ${vendor.email}'),
//             Text('Phone: ${vendor.phone}'),
//             Text('Joined: ${vendor.registrationDate.toString().split(' ')[0]}'),
//             Text('Total Bookings: ${vendor.totalBookings}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';


class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Select a user type to manage',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A1931),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFF818CF8)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [

                    Expanded(
                      child: _buildLuxuryCard(
                        title: 'Customers',
                        icon: Icons.people_alt_rounded,
                        count: '2,150',
                        gradientColors: const [
                          Color(0xFF4F46E5),
                          Color(0xFF7C3AED),
                        ],
                        shadowColor: const Color(0xFF4F46E5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomerManagementScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),


                    Expanded(
                      child: _buildLuxuryCard(
                        title: 'Vendors',
                        icon: Icons.business_center_rounded,
                        count: '397',
                        gradientColors: const [
                          Color(0xFFE9544A),
                          Color(0xFFF97316),
                        ],
                        shadowColor: const Color(0xFFE9544A),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VendorDashboardScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _buildGlassStatCard('Active Today', '342', Icons.trending_up_rounded),
                    const SizedBox(width: 12),
                    _buildGlassStatCard('New This Week', '128', Icons.fiber_new_rounded),
                    const SizedBox(width: 12),
                    _buildGlassStatCard('Pending', '23', Icons.pending_actions_rounded),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Activity',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A1931),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),


                    _buildPremiumActivityItem(
                      'New customer registered',
                      'John Doe • 2 min ago',
                      Icons.person_add_alt_1_rounded,
                      const Color(0xFF4F46E5),
                    ),
                    const SizedBox(height: 12),
                    _buildPremiumActivityItem(
                      'Vendor application',
                      'Grand Hotel • 1 hour ago',
                      Icons.business_center_rounded,
                      const Color(0xFFE9544A),
                    ),
                    const SizedBox(height: 12),
                    _buildPremiumActivityItem(
                      'Profile verified',
                      'City Inn • 3 hours ago',
                      Icons.verified_rounded,
                      const Color(0xFF10B981),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Colors.white,
              //           const Color(0xFFF8FAFF),
              //         ],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //       ),
              //       borderRadius: BorderRadius.circular(24),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.1),
              //           blurRadius: 20,
              //           offset: const Offset(0, 5),
              //         ),
              //         BoxShadow(
              //           color: const Color(0xFF4F46E5).withOpacity(0.05),
              //           blurRadius: 10,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //       border: Border.all(
              //         color: Colors.white.withOpacity(0.5),
              //       ),
              //     ),
              //     child: Row(
              //       children: [
              //
              //         Container(
              //           width: 45,
              //           height: 45,
              //           decoration: BoxDecoration(
              //             gradient: const LinearGradient(
              //               colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
              //             ),
              //             borderRadius: BorderRadius.circular(16),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: const Color(0xFF4F46E5).withOpacity(0.3),
              //                 blurRadius: 10,
              //                 offset: const Offset(0, 4),
              //               ),
              //             ],
              //           ),
              //           child: const Icon(
              //             Icons.people_rounded,
              //             color: Colors.white,
              //             size: 24,
              //           ),
              //         ),
              //         const SizedBox(width: 16),
              //         // Expanded(
              //         //   child: Column(
              //         //     crossAxisAlignment: CrossAxisAlignment.start,
              //         //     children: [
              //         //       const Text(
              //         //         'Total Users',
              //         //         style: TextStyle(
              //         //           fontSize: 13,
              //         //           color: Color(0xFF64748B),
              //         //         ),
              //         //       ),
              //         //       const SizedBox(height: 4),
              //         //       const Text(
              //         //         '2,547',
              //         //         style: TextStyle(
              //         //           fontSize: 28,
              //         //           fontWeight: FontWeight.bold,
              //         //           color: Color(0xFF0A1931),
              //         //         ),
              //         //       ),
              //         //     ],
              //         //   ),
              //         // ),
              //         Container(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 14,
              //             vertical: 8,
              //           ),
              //           decoration: BoxDecoration(
              //             color: const Color(0xFF4F46E5).withOpacity(0.1),
              //             borderRadius: BorderRadius.circular(30),
              //           ),
              //           child: Row(
              //             children: [
              //               Container(
              //                 width: 8,
              //                 height: 8,
              //                 decoration: const BoxDecoration(
              //                   color: Color(0xFF10B981),
              //                   shape: BoxShape.circle,
              //                 ),
              //               ),
              //               const SizedBox(width: 6),
              //               const Text(
              //                 '+12.5%',
              //                 style: TextStyle(
              //                   color: Color(0xFF10B981),
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 13,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLuxuryCard({
    required String title,
    required IconData icon,
    required String count,
    required List<Color> gradientColors,
    required Color shadowColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: shadowColor.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          children: [

            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),


                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 8),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                          color: Colors.white,
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


  Widget _buildGlassStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF4F46E5),
                size: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A1931),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPremiumActivityItem(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
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
                    color: Color(0xFF0A1931),
                  ),
                ),
                const SizedBox(height: 4),
                // Text(
                //   subtitle,
                //   style: TextStyle(
                //     fontSize: 13,
                //     color: Colors.grey[600],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}


class VendorListScreen extends StatefulWidget {
  const VendorListScreen({Key? key}) : super(key: key);

  @override
  State<VendorListScreen> createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  DateTime? _startDate;
  DateTime? _endDate;

  HotelStar? _selectedStar;

  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Verified', 'Pending', 'Rejected'];

  bool _showFilters = false;


  final Color _primaryColor = const Color(0xFFE9544A);
  final Color _primaryLight = const Color(0xFFE9EBFF);
  final Color _primaryDark = const Color(0xFFE9544A);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _errorColor = const Color(0xFFEF4444);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);

  List<UserModel> get _vendors {
    List<UserModel> vendors = UserModel.demoVendors();


    if (_searchQuery.isNotEmpty) {
      vendors = vendors.where((v) {
        return v.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            v.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (v.hotelName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (v.phone.toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }


    if (_startDate != null && _endDate != null) {
      vendors = vendors.where((v) {
        return v.registrationDate.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
            v.registrationDate.isBefore(_endDate!.add(const Duration(days: 1)));
      }).toList();
    } else if (_startDate != null) {
      vendors = vendors.where((v) {
        return v.registrationDate.year == _startDate!.year &&
            v.registrationDate.month == _startDate!.month &&
            v.registrationDate.day == _startDate!.day;
      }).toList();
    }


    if (_selectedStar != null) {
      vendors = vendors.where((v) => v.hotelStar == _selectedStar).toList();
    }


    if (_selectedFilter != 'All') {
      vendors = vendors.where((v) {
        return v.verificationStatus.toString().split('.').last.toLowerCase() ==
            _selectedFilter.toLowerCase();
      }).toList();
    }

    return vendors;
  }

  int get _activeFilterCount {
    int count = 0;
    if (_startDate != null || _endDate != null) count++;
    if (_selectedStar != null) count++;
    if (_selectedFilter != 'All') count++;
    return count;
  }

  void _clearAllFilters() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _selectedStar = null;
      _selectedFilter = 'All';
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _primaryColor,
                    _primaryDark,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Vendor Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),


                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search vendors, hotels or owners...',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.search_rounded,
                                  color: Colors.white.withOpacity(0.7)),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                icon: Icon(Icons.close_rounded,
                                    color: Colors.white.withOpacity(0.7)),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  });
                                },
                              )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: _showFilters
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _showFilters
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Icons.filter_list_rounded,
                                color: _showFilters ? _primaryColor : Colors.white,
                                size: 22,
                              ),
                            ),
                            if (_activeFilterCount > 0)
                              Positioned(
                                top: -5,
                                right: -5,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Text(
                                    '${_activeFilterCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
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


            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    if (_showFilters)
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Advanced Filters',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                if (_activeFilterCount > 0)
                                  TextButton(
                                    onPressed: _clearAllFilters,
                                    child: Text(
                                      'Clear All (${_activeFilterCount})',
                                      style: TextStyle(
                                        color: _primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Date Range Filter
                            const Text(
                              'Date Range',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Expanded(
                                  child: _buildDatePickerField(
                                    label: 'From',
                                    date: _startDate,
                                    onTap: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: _startDate ?? DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: _primaryColor,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _startDate = picked;
                                        });
                                      }
                                    },
                                    onClear: () {
                                      setState(() {
                                        _startDate = null;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildDatePickerField(
                                    label: 'To',
                                    date: _endDate,
                                    onTap: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: _endDate ?? DateTime.now(),
                                        firstDate: _startDate ?? DateTime(2020),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: _primaryColor,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _endDate = picked;
                                        });
                                      }
                                    },
                                    onClear: () {
                                      setState(() {
                                        _endDate = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),


                            const Text(
                              'Hotel Stars',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 12),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...HotelStar.values.map((star) {
                                    final isSelected = _selectedStar == star;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: FilterChip(
                                        label: Row(
                                          children: [
                                            ...List.generate(
                                              star.value,
                                                  (index) => const Icon(
                                                Icons.star,
                                                size: 12,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(star.displayName),
                                          ],
                                        ),
                                        selected: isSelected,
                                        onSelected: (selected) {
                                          setState(() {
                                            _selectedStar = selected ? star : null;
                                          });
                                        },
                                        backgroundColor: Colors.grey[100],
                                        selectedColor: _primaryLight,
                                        checkmarkColor: _primaryColor,
                                        labelStyle: TextStyle(
                                          color: isSelected ? _primaryColor : _textSecondary,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                          fontSize: 13,
                                        ),
                                        side: BorderSide(
                                          color: isSelected ? _primaryColor : Colors.grey.shade300,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),


                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 12),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _filterOptions.map((filter) {
                                  final isSelected = _selectedFilter == filter;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: Text(filter),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        setState(() {
                                          _selectedFilter = filter;
                                        });
                                      },
                                      backgroundColor: Colors.grey[100],
                                      selectedColor: _primaryLight,
                                      checkmarkColor: _primaryColor,
                                      labelStyle: TextStyle(
                                        color: isSelected ? _primaryColor : _textSecondary,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                        fontSize: 13,
                                      ),
                                      side: BorderSide(
                                        color: isSelected ? _primaryColor : Colors.grey.shade300,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            const SizedBox(height: 20),


                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showFilters = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _primaryColor,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Apply Filters',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    if (_startDate != null || _endDate != null || _selectedStar != null || _selectedFilter != 'All')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (_startDate != null && _endDate != null)
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    avatar: Icon(Icons.date_range, size: 14, color: _primaryColor),
                                    label: Text(
                                      '${_startDate!.day}/${_startDate!.month} - ${_endDate!.day}/${_endDate!.month}',
                                      style: TextStyle(fontSize: 12, color: _primaryColor),
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _startDate = null;
                                        _endDate = null;
                                      });
                                    },
                                    backgroundColor: _primaryLight,
                                    deleteIconColor: _primaryColor,
                                  ),
                                )
                              else if (_startDate != null)
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    avatar: Icon(Icons.calendar_today, size: 14, color: _primaryColor),
                                    label: Text(
                                      '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                                      style: TextStyle(fontSize: 12, color: _primaryColor),
                                    ),
                                    onDeleted: () {
                                      setState(() {
                                        _startDate = null;
                                      });
                                    },
                                    backgroundColor: _primaryLight,
                                    deleteIconColor: _primaryColor,
                                  ),
                                ),

                              if (_selectedStar != null)
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    avatar: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        _selectedStar!.value,
                                            (index) => const Icon(Icons.star, size: 12, color: Colors.amber),
                                      ),
                                    ),
                                    label: Text(_selectedStar!.displayName),
                                    onDeleted: () {
                                      setState(() {
                                        _selectedStar = null;
                                      });
                                    },
                                    backgroundColor: _primaryLight,
                                    deleteIconColor: _primaryColor,
                                  ),
                                ),

                              if (_selectedFilter != 'All')
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    label: Text(_selectedFilter),
                                    onDeleted: () {
                                      setState(() {
                                        _selectedFilter = 'All';
                                      });
                                    },
                                    backgroundColor: _primaryLight,
                                    deleteIconColor: _primaryColor,
                                    labelStyle: TextStyle(color: _primaryColor),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 22,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [_primaryColor, _primaryDark],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Results',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _primaryLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_vendors.length} found',
                              style: TextStyle(
                                color: _primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    _vendors.isEmpty
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: _primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.business_outlined,
                                size: 60,
                                color: _primaryColor.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No vendors found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            OutlinedButton.icon(
                              onPressed: _clearAllFilters,
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Clear Filters'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _primaryColor,
                                side: BorderSide(color: _primaryColor),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      itemCount: _vendors.length,
                      itemBuilder: (context, index) {
                        final vendor = _vendors[index];
                        return _buildPremiumVendorCard(vendor);
                      },
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

  Widget _buildDatePickerField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, size: 14, color: _primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                date == null ? label : '${date.day}/${date.month}/${date.year}',
                style: TextStyle(
                  color: date == null ? _textSecondary : _textPrimary,
                  fontSize: 12,
                  fontWeight: date == null ? FontWeight.normal : FontWeight.w600,
                ),
              ),
            ),
            if (date != null)
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close, size: 14, color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPremiumVendorCard(UserModel vendor) {
  //   final statusColor = _getStatusColor(vendor.verificationStatus);
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(25),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.08),
  //           blurRadius: 20,
  //           offset: const Offset(0, 5),
  //         ),
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(18),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 width: 65,
  //                 height: 65,
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     begin: Alignment.topLeft,
  //                     end: Alignment.bottomRight,
  //                     colors: [
  //                       _primaryColor,
  //                       _primaryDark,
  //                     ],
  //                   ),
  //                   borderRadius: BorderRadius.circular(22),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: _primaryColor.withOpacity(0.3),
  //                       blurRadius: 12,
  //                       offset: const Offset(0, 4),
  //                     ),
  //                   ],
  //                 ),
  //                 child: const Center(
  //                   child: Icon(
  //                     Icons.business,
  //                     color: Colors.white,
  //                     size: 30,
  //                   ),
  //                 ),
  //               ),
  //
  //               const SizedBox(width: 18),
  //
  //
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: Text(
  //                             vendor.name,
  //                             style: TextStyle(
  //                               fontSize: 17,
  //                               fontWeight: FontWeight.bold,
  //                               color: _textPrimary,
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 10,
  //                             vertical: 5,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: statusColor.withOpacity(0.1),
  //                             borderRadius: BorderRadius.circular(20),
  //                           ),
  //                           child: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Container(
  //                                 width: 6,
  //                                 height: 6,
  //                                 decoration: BoxDecoration(
  //                                   color: statusColor,
  //                                   shape: BoxShape.circle,
  //                                 ),
  //                               ),
  //                               const SizedBox(width: 5),
  //                               Text(
  //                                 vendor.verificationStatus.toString().split('.').last,
  //                                 style: TextStyle(
  //                                   color: statusColor,
  //                                   fontSize: 10,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     const SizedBox(height: 4),
  //
  //                     Text(
  //                       vendor.hotelName ?? 'No Hotel',
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: _primaryColor,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //
  //                     const SizedBox(height: 4),
  //
  //
  //                     Row(
  //                       children: [
  //                         Icon(Icons.person_outline, size: 12, color: Colors.grey[500]),
  //                         const SizedBox(width: 4),
  //                         Expanded(
  //                           child: Text(
  //                             'Owner: ${vendor.name}',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: _textSecondary,
  //                             ),
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     const SizedBox(height: 4),
  //
  //                     Row(
  //                       children: [
  //                         Icon(Icons.email_outlined, size: 12, color: Colors.grey[500]),
  //                         const SizedBox(width: 4),
  //                         Expanded(
  //                           child: Text(
  //                             vendor.email,
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: _textSecondary,
  //                             ),
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     const SizedBox(height: 4),
  //
  //
  //                     Row(
  //                       children: [
  //                         Icon(Icons.phone_outlined, size: 12, color: Colors.grey[500]),
  //                         const SizedBox(width: 4),
  //                         Expanded(
  //                           child: Text(
  //                             vendor.phone,
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: _textSecondary,
  //                             ),
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //
  //                     const SizedBox(height: 8),
  //
  //
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //
  //                         Row(
  //                           children: List.generate(
  //                             vendor.hotelStar?.value ?? 0,
  //                                 (index) => const Icon(
  //                               Icons.star,
  //                               color: Colors.amber,
  //                               size: 14,
  //                             ),
  //                           ),
  //                         ),
  //
  //
  //                         Row(
  //                           children: [
  //                             _buildInfoChip(
  //                               Icons.calendar_today_rounded,
  //                               '${vendor.registrationDate.day} ${_getMonth(vendor.registrationDate.month)}',
  //                             ),
  //                             const SizedBox(width: 8),
  //                             _buildInfoChip(
  //                               Icons.book_online_rounded,
  //                               '${vendor.totalBookings} bookings',
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //
  //           const SizedBox(height: 16),
  //
  //
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildActionButton(
  //                   icon: Icons.check_circle_rounded,
  //                   label: 'Approve',
  //                   color: _successColor,
  //                   onPressed: () => _showApprovalDialog(vendor, true),
  //                 ),
  //               ),
  //               const SizedBox(width: 8),
  //               Expanded(
  //                 child: _buildActionButton(
  //                   icon: Icons.cancel_rounded,
  //                   label: 'Reject',
  //                   color: _errorColor,
  //                   onPressed: () => _showApprovalDialog(vendor, false),
  //                 ),
  //               ),
  //               const SizedBox(width: 8),
  //               Expanded(
  //                 child: _buildActionButton(
  //                   icon: Icons.edit_rounded,
  //                   label: 'Edit',
  //                   color: _primaryColor,
  //                   onPressed: () => _showEditDialog(vendor),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  Widget _buildPremiumVendorCard(UserModel vendor) {
    final statusColor = _getStatusColor(vendor.verificationStatus);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _primaryColor,
                        _primaryDark,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                const SizedBox(width: 18),


                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              vendor.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: _textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  vendor.verificationStatus.toString().split('.').last,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        vendor.hotelName ?? 'No Hotel',
                        style: TextStyle(
                          fontSize: 15,
                          color: _primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),


                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Owner: ${vendor.name}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),


                      Row(
                        children: [
                          Icon(Icons.email_outlined, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              vendor.email,
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),


                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              vendor.phone,
                              style: TextStyle(
                                fontSize: 12,
                                color: _textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: List.generate(
                              vendor.hotelStar?.value ?? 0,
                                  (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ),
                          ),


                          Row(
                            children: [
                              _buildInfoChip(
                                Icons.calendar_today_rounded,
                                '${vendor.registrationDate.day} ${_getMonth(vendor.registrationDate.month)}',
                              ),
                              const SizedBox(width: 8),
                              _buildInfoChip(
                                Icons.book_online_rounded,
                                '${vendor.totalBookings} bookings',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),


            Row(
              children: [

                Expanded(
                  child: _buildActionButton(
                    icon: Icons.visibility_rounded,
                    label: 'View',
                    color: const Color(0xFF6B7280),
                    onPressed: () => _showVendorDetails(vendor),

                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.check_circle_rounded,
                    label: 'Approve',
                    color: _successColor,
                    onPressed: () => _showApprovalDialog(vendor, true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.cancel_rounded,
                    label: 'Reject',
                    color: _errorColor,
                    onPressed: () => _showApprovalDialog(vendor, false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.edit_rounded,
                    label: 'Edit',
                    color: _primaryColor,
                    onPressed: () => _showEditDialog(vendor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showVendorDetails(UserModel vendor) {
    final statusColor = _getStatusColor(vendor.verificationStatus);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 40),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [

                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [

                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        _primaryColor,
                                        _primaryDark,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _primaryColor.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.business,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),


                                Text(
                                  vendor.name,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 8),


                                Text(
                                  vendor.hotelName ?? 'No Hotel',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: _primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),


                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        vendor.verificationStatus == VerificationStatus.verified
                                            ? Icons.verified_rounded
                                            : vendor.verificationStatus == VerificationStatus.pending
                                            ? Icons.pending_rounded
                                            : Icons.warning_rounded,
                                        color: statusColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        vendor.verificationStatus.toString().split('.').last,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.5,
                            ),
                            delegate: SliverChildListDelegate([
                              _buildVendorDetailStatCard(
                                'Hotel Stars',
                                vendor.hotelStar?.displayName ?? 'Not Rated',
                                Icons.star_rounded,
                                Colors.amber,
                              ),
                              _buildVendorDetailStatCard(
                                'Total Bookings',
                                vendor.totalBookings.toString(),
                                Icons.book_online_rounded,
                                _primaryColor,
                              ),
                              _buildVendorDetailStatCard(
                                'Member Since',
                                '${vendor.registrationDate.day} ${_getMonth(vendor.registrationDate.month)} ${vendor.registrationDate.year}',
                                Icons.calendar_month_rounded,
                                const Color(0xFF10B981),
                              ),
                              _buildVendorDetailStatCard(
                                'Status',
                                vendor.verificationStatus.toString().split('.').last,
                                Icons.verified_rounded,
                                statusColor,
                              ),
                            ]),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),


                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Contact Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 16),


                                  _buildContactInfoRow(
                                    Icons.person_rounded,
                                    'Owner Name',
                                    vendor.name,
                                    _primaryColor,
                                  ),
                                  const SizedBox(height: 12),


                                  _buildContactInfoRow(
                                    Icons.email_rounded,
                                    'Email Address',
                                    vendor.email,
                                    _primaryColor,
                                  ),
                                  const SizedBox(height: 12),


                                  _buildContactInfoRow(
                                    Icons.phone_rounded,
                                    'Phone Number',
                                    vendor.phone,
                                    _primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),


                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hotel Details',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 16),


                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: _primaryLight,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.hotel_rounded,
                                          color: _primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Hotel Name',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              vendor.hotelName ?? 'No Hotel',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),


                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: _primaryLight,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Hotel Rating',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Row(
                                              children: List.generate(
                                                vendor.hotelStar?.value ?? 0,
                                                    (index) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 16,
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
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),


                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quick Actions',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildQuickActionButton(
                                        icon: Icons.check_circle_rounded,
                                        label: 'Approve',
                                        color: _successColor,
                                        onTap: () {
                                          Navigator.pop(context);
                                          _showApprovalDialog(vendor, true);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildQuickActionButton(
                                        icon: Icons.cancel_rounded,
                                        label: 'Reject',
                                        color: _errorColor,
                                        onTap: () {
                                          Navigator.pop(context);
                                          _showApprovalDialog(vendor, false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildQuickActionButton(
                                        icon: Icons.edit_rounded,
                                        label: 'Edit Vendor',
                                        color: _primaryColor,
                                        onTap: () {
                                          Navigator.pop(context);
                                          _showEditDialog(vendor);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildQuickActionButton(
                                        icon: Icons.message_rounded,
                                        label: 'Send Message',
                                        color: const Color(0xFF6B7280),
                                        onTap: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Message feature coming soon'),
                                              backgroundColor: _primaryColor,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContactInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
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


  Widget _buildVendorDetailStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: _primaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: _primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showApprovalDialog(UserModel vendor, bool isApprove) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isApprove ? _successColor.withOpacity(0.1) : _errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isApprove ? Icons.check_circle_rounded : Icons.warning_rounded,
                color: isApprove ? _successColor : _errorColor,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isApprove ? 'Approve Vendor' : 'Reject Vendor',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isApprove
                  ? 'Are you sure you want to approve ${vendor.name}?'
                  : 'Please provide a reason for rejecting ${vendor.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
            ),
            if (!isApprove) ...[
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter rejection reason...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: _textSecondary,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isApprove
                        ? 'Vendor approved successfully'
                        : 'Vendor rejected',
                  ),
                  backgroundColor: isApprove ? _successColor : _errorColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isApprove ? _successColor : _errorColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(isApprove ? 'Approve' : 'Reject'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(UserModel vendor) {
    String hotelName = vendor.hotelName ?? '';
    HotelStar? selectedStar = vendor.hotelStar;
    String ownerName = vendor.name;
    String email = vendor.email;
    String phone = vendor.phone;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text(
          'Edit Vendor',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.business, color: Color(0xFFE9544A), size: 40),
              ),
              const SizedBox(height: 20),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Hotel Name',
                  hintText: vendor.hotelName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  prefixIcon: Icon(Icons.hotel_rounded, color: _primaryColor),
                ),
                onChanged: (value) {
                  hotelName = value;
                },
              ),
              const SizedBox(height: 16),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Owner Name',
                  hintText: vendor.name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  prefixIcon: Icon(Icons.person_rounded, color: _primaryColor),
                ),
                onChanged: (value) {
                  ownerName = value;
                },
              ),
              const SizedBox(height: 16),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: vendor.email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  prefixIcon: Icon(Icons.email_rounded, color: _primaryColor),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 16),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: vendor.phone,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  prefixIcon: Icon(Icons.phone_rounded, color: _primaryColor),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  phone = value;
                },
              ),
              const SizedBox(height: 16),


              DropdownButtonFormField<HotelStar>(
                value: selectedStar,
                decoration: InputDecoration(
                  labelText: 'Hotel Star',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor),
                  ),
                  prefixIcon: Icon(Icons.star_rounded, color: _primaryColor),
                ),
                items: HotelStar.values.map((star) {
                  return DropdownMenuItem(
                    value: star,
                    child: Row(
                      children: [
                        ...List.generate(
                          star.value,
                              (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
                        ),
                        const SizedBox(width: 8),
                        Text(star.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedStar = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: _textSecondary,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Vendor details updated successfully'),
                  backgroundColor: const Color(0xFFE9544A),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Color _getStatusColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return _successColor;
      case VerificationStatus.pending:
        return _warningColor;
      case VerificationStatus.rejected:
        return _errorColor;
    }
  }
}



class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({Key? key}) : super(key: key);

  @override
  State<CustomerManagementScreen> createState() => _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Color _primaryColor = const Color(0xFF4157FF);
  final Color _primaryGradient1 = const Color(0xFF4157FF);
  final Color _primaryGradient2 = const Color(0xFF6B7DFF);
  final Color _primaryLight = const Color(0xFFE9EBFF);
  final Color _primaryDark = const Color(0xFF2A3FCC);
  final Color _accentColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _errorColor = const Color(0xFFEF4444);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [

            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _primaryGradient1,
                        _primaryGradient2,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _primaryColor.withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) => const LinearGradient(
                                        colors: [Colors.white, Color(0xFFE0E7FF)],
                                      ).createShader(bounds),
                                      child: const Text(
                                        'Customer Management',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 12,
                                    //     vertical: 5,
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white.withOpacity(0.15),
                                    //     borderRadius: BorderRadius.circular(30),
                                    //     border: Border.all(
                                    //       color: Colors.white.withOpacity(0.2),
                                    //     ),
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       Container(
                                    //         width: 6,
                                    //         height: 6,
                                    //         decoration: const BoxDecoration(
                                    //           color: Color(0xFF10B981),
                                    //           shape: BoxShape.circle,
                                    //         ),
                                    //       ),
                                    //       const SizedBox(width: 6),
                                    //       Text(
                                    //         'Total Customers: 2,547',
                                    //         style: TextStyle(
                                    //           color: Colors.white.withOpacity(0.9),
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),

                        // const Spacer(),
                        //
                        // // Premium Stats Cards
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: _buildGlassStatCard(
                        //           'Active',
                        //           '2,150',
                        //           Icons.verified_rounded,
                        //           _accentColor,
                        //         ),
                        //       ),
                        //       const SizedBox(width: 12),
                        //       Expanded(
                        //         child: _buildGlassStatCard(
                        //           'Bookings',
                        //           '1,892',
                        //           Icons.book_online_rounded,
                        //           const Color(0xFF8B5CF6),
                        //         ),
                        //       ),
                        //       const SizedBox(width: 12),
                        //       Expanded(
                        //         child: _buildGlassStatCard(
                        //           'New',
                        //           '128',
                        //           Icons.fiber_new_rounded,
                        //           _warningColor,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),


              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [_primaryGradient1, _primaryGradient2],
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(4),
                      labelColor: Colors.white,
                      unselectedLabelColor: _textSecondary,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _textSecondary,
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.book_online_rounded,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text('Booking Details'),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people_alt_rounded,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text('Customer Details'),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F7FA),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [

              const CustomerListScreen(),


              const BookingDetailsScreen(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildGlassStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({Key? key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final Color _primaryColor = const Color(0xFF4157FF);
  final Color _primaryLight = const Color(0xFFE9EBFF);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _errorColor = const Color(0xFFEF4444);

  @override
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search customers by name or email...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.search_rounded,
                      color: _primaryColor,
                      size: 22,
                    ),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? Container(
                    padding: const EdgeInsets.all(12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
        ),


        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPremiumCustomerCard(index),
                );
              },
              childCount: 10,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }

  Widget _buildPremiumCustomerCard(int index) {
    final List<Map<String, dynamic>> customers = [
      {
        'name': 'John Doe',
        'email': 'john.doe@email.com',
        'phone': '+1 234 567 890',
        'status': 'Verified',
        'bookings': 12,
        'joined': 'Jan 2024',
      },
      {
        'name': 'Sarah Smith',
        'email': 'sarah.smith@email.com',
        'phone': '+1 234 567 891',
        'status': 'Verified',
        'bookings': 8,
        'joined': 'Feb 2024',
      },
      {
        'name': 'Mike Johnson',
        'email': 'mike.j@email.com',
        'phone': '+1 234 567 892',
        'status': 'Pending',
        'bookings': 3,
        'joined': 'Mar 2024',
      },
      {
        'name': 'Emily Brown',
        'email': 'emily.b@email.com',
        'phone': '+1 234 567 893',
        'status': 'Verified',
        'bookings': 15,
        'joined': 'Dec 2023',
      },
    ];

    final customer = customers[index % customers.length];
    final statusColor = customer['status'] == 'Verified' ? _successColor : _warningColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showCustomerDetails(customer),
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _primaryColor,
                            const Color(0xFF6B7DFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: _primaryColor.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          customer['name'][0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),


                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.3,
                                ),
                                child: Text(
                                  customer['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      customer['status'],
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),


                          Row(
                            children: [
                              Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  customer['email'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),


                          Row(
                            children: [
                              Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
                              const SizedBox(width: 6),
                              Text(
                                customer['phone'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),


                Row(
                  children: [

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 12, color: _primaryColor),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Joined ${customer['joined']}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),


                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.book_online_rounded, size: 12, color: _primaryColor),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${customer['bookings']} Bookings',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),


                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Color(0xFF4157FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomerDetails(Map<String, dynamic> customer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 40),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 20,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [

                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [

                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        customer['name'][0].toUpperCase(),
                                        style: const TextStyle(
                                          color: Color(0xFF4157FF),
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  customer['name'],
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  customer['email'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),

                                const SizedBox(height: 16),


                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (customer['status'] == 'Verified'
                                        ? _successColor
                                        : _warningColor).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        customer['status'] == 'Verified'
                                            ? Icons.verified_rounded
                                            : Icons.pending_rounded,
                                        color: customer['status'] == 'Verified'
                                            ? _successColor
                                            : _warningColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        customer['status'],
                                        style: TextStyle(
                                          color: customer['status'] == 'Verified'
                                              ? _successColor
                                              : _warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.2,
                            ),
                            delegate: SliverChildListDelegate([
                              _buildDetailStatCard(
                                'Total Bookings',
                                customer['bookings'].toString(),
                                Icons.book_online_rounded,
                                _primaryColor,
                              ),
                              _buildDetailStatCard(
                                'Member Since',
                                customer['joined'],
                                Icons.calendar_month_rounded,
                                const Color(0xFF8B5CF6),
                              ),
                              _buildDetailStatCard(
                                'Phone Number',
                                customer['phone'],
                                Icons.phone_rounded,
                                _successColor,
                              ),
                              _buildDetailStatCard(
                                'Status',
                                customer['status'],
                                Icons.verified_rounded,
                                _warningColor,
                              ),
                            ]),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}



// class VendorDashboardScreen extends StatefulWidget {
//   const VendorDashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
// }
//
// class _VendorDashboardScreenState extends State<VendorDashboardScreen> with SingleTickerProviderStateMixin {
//   final Color _primaryColor = const Color(0xFFE9544A);
//   final Color _primaryLight = const Color(0xFFFFE5E0);
//   final Color _primaryDark = const Color(0xFFD43B2E);
//   final Color _successColor = const Color(0xFF10B981);
//   final Color _warningColor = const Color(0xFFF59E0B);
//   final Color _errorColor = const Color(0xFFEF4444);
//   final Color _infoColor = const Color(0xFF3B82F6);
//   final Color _purpleColor = const Color(0xFF8B5CF6);
//   final Color _amberColor = const Color(0xFFF59E0B);
//   final Color _textPrimary = const Color(0xFF1E293B);
//   final Color _textSecondary = const Color(0xFF64748B);
//
//   late TabController _tabController;
//   bool _isMounted = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _isMounted = true;
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _isMounted = false;
//     super.dispose();
//   }
//
//   void _showSafeSnackBar(String message, Color color) {
//     if (!_isMounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//
//   List<UserModel> get _allVendors => UserModel.demoVendors();
//
//
//   List<UserModel> get _activeVendors {
//     return _allVendors.where((v) => v.verificationStatus == VerificationStatus.verified).toList();
//   }
//
//   List<UserModel> get _pendingVendors {
//     return _allVendors.where((v) => v.verificationStatus == VerificationStatus.pending).toList();
//   }
//
//   List<UserModel> get _rejectedVendors {
//     return _allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).toList();
//   }
//
//   List<UserModel> get _cancelledVendors {
//
//     return _allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).toList().sublist(0, 1);
//   }
//
//
//   int get _totalHotels => _allVendors.length;
//   int get _totalRooms => _allVendors.fold(0, (sum, v) => sum + (v.totalBookings * 5));
//   int get _totalBookings => _allVendors.fold(0, (sum, v) => sum + v.totalBookings);
//   String get _totalRevenue {
//     final total = _allVendors.fold(0, (sum, v) => sum + (v.totalBookings * 250));
//     return '\$${total ~/ 1000}k';
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFE),
//       body: CustomScrollView(
//         slivers: [
//
//           SliverAppBar(
//             expandedHeight: 120,
//             pinned: true,
//             floating: true,
//             backgroundColor: Colors.transparent,
//             automaticallyImplyLeading: false,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 children: [
//
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           _primaryColor,
//                           _primaryDark,
//                         ],
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(40),
//                         bottomRight: Radius.circular(40),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: _primaryColor.withOpacity(0.4),
//                           blurRadius: 30,
//                           offset: const Offset(0, 15),
//                         ),
//                       ],
//                     ),
//                   ),
//
//
//                   Positioned(
//                     top: -50,
//                     right: -30,
//                     child: Container(
//                       width: 150,
//                       height: 150,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.1),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -40,
//                     left: -20,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.08),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 30,
//                     left: 50,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.15),
//                       ),
//                     ),
//                   ),
//
//                   SafeArea(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             children: [
//
//                               Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.white.withOpacity(0.3),
//                                       Colors.white.withOpacity(0.1),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                   ),
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () => Navigator.pop(context),
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(12),
//                                       child: const Icon(
//                                         Icons.arrow_back_ios_new_rounded,
//                                         color: Colors.white,
//                                         size: 18,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//
//
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Vendor Dashboard',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 22,
//                                         fontWeight: FontWeight.bold,
//                                         letterSpacing: -0.5,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     // Container(
//                                     //   padding: const EdgeInsets.symmetric(
//                                     //     horizontal: 10,
//                                     //     vertical: 3,
//                                     //   ),
//                                     //   decoration: BoxDecoration(
//                                     //     color: Colors.white.withOpacity(0.15),
//                                     //     borderRadius: BorderRadius.circular(20),
//                                     //   ),
//                                     //   child: Text(
//                                     //     '${_allVendors.length} Total Vendors',
//                                     //     style: TextStyle(
//                                     //       color: Colors.white.withOpacity(0.9),
//                                     //       fontSize: 11,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const Spacer(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 1.1,
//               ),
//               delegate: SliverChildListDelegate([
//                 _buildMainStatCard(
//                   'Total Hotels',
//                   '${_totalHotels}',
//                   Icons.hotel_rounded,
//                   _primaryColor,
//                   '+12',
//                   true,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const VendorListScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildMainStatCard(
//                   'Total Rooms',
//                   '${_totalRooms}',
//                   Icons.bed_rounded,
//                   _purpleColor,
//                   '+324',
//                   true,
//                 ),
//                 _buildMainStatCard(
//                   'Total Bookings',
//                   '${_totalBookings}',
//                   Icons.book_online_rounded,
//                   _successColor,
//                   '+18%',
//                   true,
//                 ),
//                 _buildMainStatCard(
//                   'Cancellation',
//                   _totalRevenue,
//                   Icons.cancel,
//                   _amberColor,
//                   '+12%',
//                   true,
//                 ),
//               ]),
//             ),
//           ),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 10)),
//
//
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 4,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [_primaryColor, _purpleColor],
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text(
//                         'Status Overview',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1E293B),
//                         ),
//                       ),
//                       const Spacer(),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: _primaryLight,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           'This Month',
//                           style: TextStyle(
//                             color: _primaryColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.08),
//                           blurRadius: 20,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         _buildStatusRow(
//                           'Active Hotels',
//                           _activeVendors.length.toString(),
//                           _successColor,
//                           _allVendors.isEmpty ? 0 : _activeVendors.length / _allVendors.length,
//                         ),
//                         const SizedBox(height: 16),
//                         _buildStatusRow(
//                           'Pending Verification',
//                           _pendingVendors.length.toString(),
//                           _warningColor,
//                           _allVendors.isEmpty ? 0 : _pendingVendors.length / _allVendors.length,
//                         ),
//                         const SizedBox(height: 16),
//                         _buildStatusRow(
//                           'Rejected',
//                           _rejectedVendors.length.toString(),
//                           _errorColor,
//                           _allVendors.isEmpty ? 0 : _rejectedVendors.length / _allVendors.length,
//                         ),
//                         const SizedBox(height: 16),
//                         _buildStatusRow(
//                           'Cancelled',
//                           _cancelledVendors.length.toString(),
//                           Colors.grey,
//                           _allVendors.isEmpty ? 0 : _cancelledVendors.length / _allVendors.length,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 20)),
//
//
//           if (_activeVendors.isNotEmpty) ...[
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 4,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [_successColor, _successColor.withOpacity(0.5)],
//                         ),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Text(
//                       'Active Vendors',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B),
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: _successColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         '${_activeVendors.length} Active',
//                         style: TextStyle(
//                           color: _successColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 12)),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                     child: _buildVendorCard(_activeVendors[index]),
//                   );
//                 },
//                 childCount: _activeVendors.length,
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 20)),
//           ],
//
//
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 4,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [_warningColor, _errorColor],
//                           ),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text(
//                         'Inactive Vendors',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1E293B),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//
//                   Container(
//                     height: 45,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       indicator: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         gradient: LinearGradient(
//                           colors: [_warningColor, _errorColor],
//                         ),
//                       ),
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       labelColor: Colors.white,
//                       unselectedLabelColor: _textSecondary,
//                       labelStyle: const TextStyle(
//                         fontSize: 12, // Reduced font size
//                         fontWeight: FontWeight.w600,
//                       ),
//                       unselectedLabelStyle: TextStyle(
//                         fontSize: 12, // Reduced font size
//                         fontWeight: FontWeight.w500,
//                         color: _textSecondary,
//                       ),
//                       tabs: [
//                         Tab(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.pending_rounded, size: 14),
//                               const SizedBox(width: 4),
//                               Flexible(
//                                 child: Text(
//                                   'Pending ${_pendingVendors.length}',
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Tab(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.cancel_rounded, size: 14),
//                               const SizedBox(width: 4),
//                               Flexible(
//                                 child: Text(
//                                   'Rejected ${_rejectedVendors.length}',
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Tab(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.cancel_presentation_sharp, size: 14),
//                               const SizedBox(width: 4),
//                               Flexible(
//                                 child: Text(
//                                   'Cancelled ${_cancelledVendors.length}',
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SliverToBoxAdapter(child: SizedBox(height: 16)),
//
//
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: _getTabViewHeight(),
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//
//                   _pendingVendors.isEmpty
//                       ? _buildEmptyState('No pending vendors', Icons.pending_rounded, _warningColor)
//                       : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _pendingVendors.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: _buildVendorCard(_pendingVendors[index]),
//                       );
//                     },
//                   ),
//
//
//
//                   _rejectedVendors.isEmpty
//                       ? _buildEmptyState('No rejected vendors', Icons.cancel_rounded, _errorColor)
//                       : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _rejectedVendors.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: _buildVendorCard(_rejectedVendors[index]),
//                       );
//                     },
//                   ),
//
//
//                   _cancelledVendors.isEmpty
//                       ? _buildEmptyState('No cancelled vendors', Icons.cancel_presentation_sharp, Colors.grey)
//                       : ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _cancelledVendors.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: _buildVendorCard(_cancelledVendors[index]),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//
//           const SliverToBoxAdapter(child: SizedBox(height: 30)),
//         ],
//       ),
//     );
//   }
//
//   double _getTabViewHeight() {
//     int maxCount = 0;
//     if (_tabController.index == 0) maxCount = _pendingVendors.length;
//     else if (_tabController.index == 1) maxCount = _rejectedVendors.length;
//     else maxCount = _cancelledVendors.length;
//
//     if (maxCount == 0) return 200;
//     return (maxCount * 100.0).clamp(100.0, 400.0);
//   }
//
//   Widget _buildEmptyState(String message, IconData icon, Color color) {
//     return Container(
//       height: 200,
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, size: 40, color: color.withOpacity(0.5)),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               message,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF1E293B),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildVendorCard(UserModel vendor) {
//     final statusColor = _getStatusColor(vendor.verificationStatus);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InkWell(
//         onTap: () {
//           _showSafeSnackBar('Viewing ${vendor.name}', _primaryColor);
//         },
//         borderRadius: BorderRadius.circular(20),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//
//               Container(
//                 width: 55,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [_primaryColor, _primaryDark],
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: _primaryColor.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const Center(
//                   child: Icon(Icons.business, color: Colors.white, size: 28),
//                 ),
//               ),
//               const SizedBox(width: 16),
//
//
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       vendor.name,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Color(0xFF1E293B),
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       vendor.hotelName ?? 'No Hotel',
//                       style: TextStyle(
//                         color: _primaryColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//
//                         Row(
//                           children: List.generate(
//                             vendor.hotelStar?.value ?? 0,
//                                 (index) => const Icon(Icons.star, size: 14, color: Colors.amber),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                           decoration: BoxDecoration(
//                             color: statusColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Container(
//                                 width: 6,
//                                 height: 6,
//                                 decoration: BoxDecoration(
//                                   color: statusColor,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 vendor.verificationStatus.toString().split('.').last,
//                                 style: TextStyle(
//                                   color: statusColor,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//
//               Container(
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: _primaryLight,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 12,
//                   color: _primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildMainStatCard(
//       String title,
//       String value,
//       IconData icon,
//       Color color,
//       String trend,
//       bool trendUp, {
//         VoidCallback? onTap,
//       }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, color: color, size: 20),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: trendUp ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         trendUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
//                         size: 14,
//                         color: trendUp ? Colors.green : Colors.red,
//                       ),
//                       const SizedBox(width: 2),
//                       Text(
//                         trend,
//                         style: TextStyle(
//                           color: trendUp ? Colors.green : Colors.red,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1E293B),
//               ),
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildStatusRow(String title, String value, Color color, double percentage) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 10,
//                   height: 10,
//                   decoration: BoxDecoration(
//                     color: color,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: color,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     '${(percentage * 100).toInt()}%',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: color,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: percentage.clamp(0.0, 1.0),
//             backgroundColor: Colors.grey[200],
//             valueColor: AlwaysStoppedAnimation<Color>(color),
//             minHeight: 6,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Color _getStatusColor(VerificationStatus status) {
//     switch (status) {
//       case VerificationStatus.verified:
//         return _successColor;
//       case VerificationStatus.pending:
//         return _warningColor;
//       case VerificationStatus.rejected:
//         return _errorColor;
//     }
//   }
// }

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> with SingleTickerProviderStateMixin {
  final Color _primaryColor = const Color(0xFFE9544A);
  final Color _primaryLight = const Color(0xFFFFE5E0);
  final Color _primaryDark = const Color(0xFFD43B2E);
  final Color _successColor = const Color(0xFF10B981);
  final Color _warningColor = const Color(0xFFF59E0B);
  final Color _errorColor = const Color(0xFFEF4444);
  final Color _infoColor = const Color(0xFF3B82F6);
  final Color _purpleColor = const Color(0xFF8B5CF6);
  final Color _amberColor = const Color(0xFFF59E0B);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);

  late TabController _tabController;
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _isMounted = false;
    super.dispose();
  }

  void _showSafeSnackBar(String message, Color color) {
    if (!_isMounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }


  List<UserModel> get _allVendors => UserModel.demoVendors();


  List<UserModel> get _activeVendors {
    return _allVendors.where((v) => v.verificationStatus == VerificationStatus.verified).toList();
  }

  List<UserModel> get _pendingVendors {
    return _allVendors.where((v) => v.verificationStatus == VerificationStatus.pending).toList();
  }

  List<UserModel> get _rejectedVendors {
    return _allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).toList();
  }

  List<UserModel> get _cancelledVendors {
    return _allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).toList().sublist(0, 1);
  }


  int get _totalHotels => _allVendors.length;
  int get _totalRooms => _allVendors.fold(0, (sum, v) => sum + (v.totalBookings * 5));
  int get _totalBookings => _allVendors.fold(0, (sum, v) => sum + v.totalBookings);
  int get _totalCancellations => _cancelledVendors.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            floating: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _primaryColor,
                          _primaryDark,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryColor.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                  ),


                  Positioned(
                    top: -50,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 50,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.3),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),


                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Vendor Dashboard',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Container(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 10,
                                    //     vertical: 3,
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white.withOpacity(0.15),
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    //   child: Text(
                                    //     '${_allVendors.length} Total Vendors',
                                    //     style: TextStyle(
                                    //       color: Colors.white.withOpacity(0.9),
                                    //       fontSize: 11,
                                    //     ),
                                    //   ),
                                    // ),
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
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildListDelegate([
                _buildMainStatCard(
                  'Total Hotels',
                  '${_totalHotels}',
                  Icons.hotel_rounded,
                  _primaryColor,
                  '+12',
                  true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VendorListScreen(),
                      ),
                    );
                  },
                ),
                _buildMainStatCard(
                  'Total Rooms',
                  '${_totalRooms}',
                  Icons.bed_rounded,
                  _purpleColor,
                  '+324',
                  true,
                ),
                _buildMainStatCard(
                  'Total Bookings',
                  '${_totalBookings}',
                  Icons.book_online_rounded,
                  _successColor,
                  '+18%',
                  true,
                ),
                _buildMainStatCard(
                  'Cancellations',
                  '${_totalCancellations}',
                  Icons.cancel_rounded,
                  _errorColor,
                  '-2%',
                  false,
                ),
              ]),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 10)),


          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_primaryColor, _purpleColor],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Status Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'This Month',
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),


                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildStatusRow(
                          'Active Hotels',
                          _activeVendors.length.toString(),
                          _successColor,
                          _allVendors.isEmpty ? 0 : _activeVendors.length / _allVendors.length,
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          'Pending Verification',
                          _pendingVendors.length.toString(),
                          _warningColor,
                          _allVendors.isEmpty ? 0 : _pendingVendors.length / _allVendors.length,
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          'Rejected',
                          _rejectedVendors.length.toString(),
                          _errorColor,
                          _allVendors.isEmpty ? 0 : _rejectedVendors.length / _allVendors.length,
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          'Cancelled',
                          _cancelledVendors.length.toString(),
                          Colors.grey,
                          _allVendors.isEmpty ? 0 : _cancelledVendors.length / _allVendors.length,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),


          if (_activeVendors.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_successColor, _successColor.withOpacity(0.5)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Active Vendors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_activeVendors.length} Active',
                        style: TextStyle(
                          color: _successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: _buildVendorCard(_activeVendors[index]),
                  );
                },
                childCount: _activeVendors.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],


          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_warningColor, _errorColor],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Inactive Vendors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),


                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [_warningColor, _errorColor],
                        ),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: _textSecondary,
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: _textSecondary,
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon(Icons.pending_rounded, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Pending ${_pendingVendors.length}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon(Icons.cancel_rounded, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Rejected ${_rejectedVendors.length}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon(Icons.cancel_presentation_sharp, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Cancelled ${_cancelledVendors.length}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
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

          const SliverToBoxAdapter(child: SizedBox(height: 16)),


          SliverToBoxAdapter(
            child: SizedBox(
              height: _getTabViewHeight(),
              child: TabBarView(
                controller: _tabController,
                children: [

                  _pendingVendors.isEmpty
                      ? _buildEmptyState('No pending vendors', Icons.pending_rounded, _warningColor)
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _pendingVendors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildVendorCard(_pendingVendors[index]),
                      );
                    },
                  ),



                  _rejectedVendors.isEmpty
                      ? _buildEmptyState('No rejected vendors', Icons.cancel_rounded, _errorColor)
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _rejectedVendors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildVendorCard(_rejectedVendors[index]),
                      );
                    },
                  ),


                  _cancelledVendors.isEmpty
                      ? _buildEmptyState('No cancelled vendors', Icons.cancel_presentation_sharp, Colors.grey)
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _cancelledVendors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildVendorCard(_cancelledVendors[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),


          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  double _getTabViewHeight() {
    int maxCount = 0;
    if (_tabController.index == 0) maxCount = _pendingVendors.length;
    else if (_tabController.index == 1) maxCount = _rejectedVendors.length;
    else maxCount = _cancelledVendors.length;

    if (maxCount == 0) return 200;
    return (maxCount * 100.0).clamp(100.0, 400.0);
  }

  Widget _buildEmptyState(String message, IconData icon, Color color) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: color.withOpacity(0.5)),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildVendorCard(UserModel vendor) {
    final statusColor = _getStatusColor(vendor.verificationStatus);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _showSafeSnackBar('Viewing ${vendor.name}', _primaryColor);
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [

              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.business, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 16),


              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vendor.hotelName ?? 'No Hotel',
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [

                        Row(
                          children: List.generate(
                            vendor.hotelStar?.value ?? 0,
                                (index) => const Icon(Icons.star, size: 14, color: Colors.amber),
                          ),
                        ),
                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                vendor.verificationStatus.toString().split('.').last,
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 10,
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


              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: _primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildMainStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      String trend,
      bool trendUp, {
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: trendUp ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                        size: 10,
                        color: trendUp ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 2),
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
            const SizedBox(height: 12),
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
      ),
    );
  }


  Widget _buildStatusRow(String title, String value, Color color, double percentage) {
    return Column(
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
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(percentage * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage.clamp(0.0, 1.0),
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return _successColor;
      case VerificationStatus.pending:
        return _warningColor;
      case VerificationStatus.rejected:
        return _errorColor;
    }
  }
}



class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  DateTime? _startDate;
  DateTime? _endDate;

  bool _showDateFilter = false;

  final Color _primaryColor = const Color(0xFF4F46E5);
  final Color _primaryLight = const Color(0xFFE9EBFF);

  List<Map<String, dynamic>> get _filteredBookings {
    List<Map<String, dynamic>> allBookings = _getAllBookings();

    if (_searchQuery.isNotEmpty) {
      allBookings = allBookings.where((booking) {
        return booking['customer'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            booking['hotel'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_startDate != null && _endDate != null) {
      return allBookings.where((booking) {
        DateTime checkIn = _parseDate(booking['checkIn']);
        return checkIn.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
            checkIn.isBefore(_endDate!.add(const Duration(days: 1)));
      }).toList();
    }

    return allBookings;
  }

  List<Map<String, dynamic>> _getAllBookings() {
    return [
      {
        'customer': 'John Doe',
        'hotel': 'Grand Hotel Plaza',
        'checkIn': '15 Mar 2024',
        'checkOut': '18 Mar 2024',
        'amount': '\$450',
        'status': 'Completed',
        'rooms': 2,
        'guests': 3,
      },
      {
        'customer': 'Sarah Smith',
        'hotel': 'Beach Resort & Spa',
        'checkIn': '20 Mar 2024',
        'checkOut': '25 Mar 2024',
        'amount': '\$1,250',
        'status': 'Upcoming',
        'rooms': 1,
        'guests': 2,
      },
      {
        'customer': 'Mike Johnson',
        'hotel': 'City Inn Express',
        'checkIn': '10 Mar 2024',
        'checkOut': '12 Mar 2024',
        'amount': '\$280',
        'status': 'Completed',
        'rooms': 1,
        'guests': 1,
      },
      {
        'customer': 'Emily Brown',
        'hotel': 'Luxury Palace',
        'checkIn': '05 Apr 2024',
        'checkOut': '08 Apr 2024',
        'amount': '\$890',
        'status': 'Upcoming',
        'rooms': 2,
        'guests': 4,
      },
      {
        'customer': 'Robert Wilson',
        'hotel': 'Business Hotel',
        'checkIn': '01 Mar 2024',
        'checkOut': '03 Mar 2024',
        'amount': '\$320',
        'status': 'Cancelled',
        'rooms': 1,
        'guests': 1,
      },
      {
        'customer': 'Alice Johnson',
        'hotel': 'Ocean View Resort',
        'checkIn': '28 Feb 2024',
        'checkOut': '02 Mar 2024',
        'amount': '\$680',
        'status': 'Completed',
        'rooms': 2,
        'guests': 3,
      },
      {
        'customer': 'David Wilson',
        'hotel': 'Mountain Lodge',
        'checkIn': '25 Mar 2024',
        'checkOut': '30 Mar 2024',
        'amount': '\$950',
        'status': 'Upcoming',
        'rooms': 2,
        'guests': 4,
      },
    ];
  }

  DateTime _parseDate(String dateStr) {
    List<String> parts = dateStr.split(' ');
    int day = int.parse(parts[0]);
    String month = parts[1];
    int year = int.parse(parts[2]);

    Map<String, int> months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };

    return DateTime(year, months[month]!, day);
  }

  int get _activeFilterCount {
    int count = 0;
    if (_startDate != null || _endDate != null) count++;
    return count;
  }

  void _clearDateFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _showDateFilter = false;
    });
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      body: Column(
        children: [

          Container(
            color: Colors.white,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.08),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search bookings...',
                                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                                  prefixIcon: Icon(Icons.search_rounded, color: _primaryColor, size: 20),
                                  suffixIcon: _searchQuery.isNotEmpty
                                      ? IconButton(
                                    icon: Icon(Icons.close_rounded, color: Colors.grey[600], size: 18),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        _searchQuery = '';
                                      });
                                    },
                                  )
                                      : null,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),


                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showDateFilter = !_showDateFilter;
                              });
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _showDateFilter ? _primaryColor : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: _showDateFilter ? _primaryColor : Colors.grey.shade300,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.filter_list_rounded,
                                    color: _showDateFilter ? Colors.white : _primaryColor,
                                    size: 20,
                                  ),
                                ),
                                if (_activeFilterCount > 0 && !_showDateFilter)
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      child: Text(
                                        '${_activeFilterCount}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),


                      if (_showDateFilter)
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
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
                                  const Text(
                                    'Select Date Range',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  if (_startDate != null || _endDate != null)
                                    TextButton(
                                      onPressed: _clearDateFilter,
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          color: _primaryColor,
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
                                    child: _buildDatePickerField(
                                      label: 'From',
                                      date: _startDate,
                                      icon: Icons.calendar_today_rounded,
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          initialDate: _startDate ?? DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: _primaryColor,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            _startDate = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),

                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      '→',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),


                                  Expanded(
                                    child: _buildDatePickerField(
                                      label: 'To',
                                      date: _endDate,
                                      icon: Icons.calendar_today_rounded,
                                      onTap: () async {
                                        DateTime? picked = await showDatePicker(
                                          context: context,
                                          initialDate: _endDate ?? DateTime.now(),
                                          firstDate: _startDate ?? DateTime(2020),
                                          lastDate: DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: _primaryColor,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            _endDate = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),


                              if (_startDate != null && _endDate != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: _primaryLight,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range, size: 16, color: _primaryColor),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${_startDate!.day} ${_getMonth(_startDate!.month)} ${_startDate!.year} - ${_endDate!.day} ${_getMonth(_endDate!.month)} ${_endDate!.year}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: _primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              if (_startDate != null && _endDate != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _showDateFilter = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _primaryColor,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: const Text(
                                        'Apply Filter',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),


                      if (_activeFilterCount > 0 && !_showDateFilter)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _primaryLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.date_range, size: 14, color: _primaryColor),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${_startDate!.day} ${_getMonth(_startDate!.month)} - ${_endDate!.day} ${_getMonth(_endDate!.month)} ${_endDate!.year}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: _clearDateFilter,
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 14,
                                        color: _primaryColor,
                                      ),
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


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Recent Bookings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_filteredBookings.length} bookings',
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),


          Expanded(
            child: _filteredBookings.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                      color: _primaryColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No bookings found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _startDate != null && _endDate != null
                        ? 'No bookings in selected date range'
                        : 'Try adjusting your search',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (_startDate != null && _endDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: OutlinedButton.icon(
                        onPressed: _clearDateFilter,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Clear Filters'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _primaryColor,
                          side: BorderSide(color: _primaryColor),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _filteredBookings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildBookingCard(_filteredBookings[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? date,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: _primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                date == null ? label : '${date.day} ${_getMonth(date.month)}',
                style: TextStyle(
                  color: date == null ? Colors.grey[600] : const Color(0xFF1E293B),
                  fontSize: 13,
                  fontWeight: date == null ? FontWeight.normal : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor;
    IconData statusIcon;

    switch (booking['status']) {
      case 'Completed':
        statusColor = const Color(0xFF10B981);
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Upcoming':
        statusColor = const Color(0xFFF59E0B);
        statusIcon = Icons.schedule_rounded;
        break;
      case 'Cancelled':
        statusColor = const Color(0xFFEF4444);
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showBookingDetails(context, booking),
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              Row(
                children: [

                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.hotel_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),


                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking['hotel'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                booking['customer'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 12, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          booking['status'],
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailItem(
                    Icons.calendar_today_rounded,
                    'Check In',
                    booking['checkIn'],
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  _buildDetailItem(
                    Icons.calendar_today_rounded,
                    'Check Out',
                    booking['checkOut'],
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  _buildDetailItem(
                    Icons.attach_money_rounded,
                    'Amount',
                    booking['amount'],
                  ),
                ],
              ),

              const SizedBox(height: 12),


              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.bed_rounded, size: 14, color: Color(0xFF4F46E5)),
                        const SizedBox(width: 4),
                        Text(
                          '${booking['rooms']} Room${booking['rooms'] > 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.people_rounded, size: 14, color: Color(0xFF4F46E5)),
                        const SizedBox(width: 4),
                        Text(
                          '${booking['guests']} Guest${booking['guests'] > 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: _primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios_rounded, size: 8, color: Color(0xFF4F46E5)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 14, color: _primaryColor),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    Color statusColor;
    IconData statusIcon;

    switch (booking['status']) {
      case 'Completed':
        statusColor = const Color(0xFF10B981);
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Upcoming':
        statusColor = const Color(0xFFF59E0B);
        statusIcon = Icons.schedule_rounded;
        break;
      case 'Cancelled':
        statusColor = const Color(0xFFEF4444);
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_rounded;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 40),
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [

                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4F46E5).withOpacity(0.3),
                                        blurRadius: 15,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.hotel_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  booking['hotel'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  'Booking #BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 12),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(statusIcon, size: 16, color: statusColor),
                                      const SizedBox(width: 8),
                                      Text(
                                        booking['status'],
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: _primaryLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Customer Information',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          color: Color(0xFF4F46E5),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Customer Name',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            booking['customer'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.email_rounded,
                                          color: Color(0xFF4F46E5),
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Email Address',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${booking['customer'].toLowerCase().replaceAll(' ', '.')}@email.com',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),


                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.8,
                            ),
                            delegate: SliverChildListDelegate([
                              _buildBookingDetailCard(
                                'Check In',
                                booking['checkIn'],
                                Icons.login_rounded,
                                const Color(0xFF4F46E5),
                              ),
                              _buildBookingDetailCard(
                                'Check Out',
                                booking['checkOut'],
                                Icons.logout_rounded,
                                const Color(0xFF4338CA),
                              ),
                              _buildBookingDetailCard(
                                'Rooms',
                                '${booking['rooms']} Room${booking['rooms'] > 1 ? 's' : ''}',
                                Icons.bed_rounded,
                                const Color(0xFF10B981),
                              ),
                              _buildBookingDetailCard(
                                'Guests',
                                '${booking['guests']} Guest${booking['guests'] > 1 ? 's' : ''}',
                                Icons.people_rounded,
                                const Color(0xFFF59E0B),
                              ),
                            ]),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),



                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Payment Details',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF10B981).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'Paid',
                                          style: TextStyle(
                                            color: Color(0xFF10B981),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Room Charges',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        booking['amount'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Amount',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        booking['amount'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F46E5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 30)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBookingDetailCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
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

