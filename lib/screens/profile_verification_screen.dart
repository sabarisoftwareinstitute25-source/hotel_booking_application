// import 'package:flutter/material.dart';
// import '../models/user_model.dart';
// import '../theme/app_theme.dart';
//
// class ProfileVerificationScreen extends StatefulWidget {
//   const ProfileVerificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileVerificationScreen> createState() => _ProfileVerificationScreenState();
// }
//
// class _ProfileVerificationScreenState extends State<ProfileVerificationScreen> {
//   List<UserModel> pendingUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPendingUsers();
//   }
//
//   void _loadPendingUsers() {
//     pendingUsers = [
//       ...UserModel.demoCustomers().where((u) => u.verificationStatus == VerificationStatus.pending),
//       ...UserModel.demoVendors().where((u) => u.verificationStatus == VerificationStatus.pending),
//     ];
//   }
// //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pendingUsers.isEmpty
//           ? Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.verified_outlined,
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No pending verifications',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       )
//           : ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: pendingUsers.length,
//         itemBuilder: (context, index) {
//           final user = pendingUsers[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: user.userType == UserType.vendor
//                             ? AppTheme.secondaryColor.withOpacity(0.1)
//                             : AppTheme.accentColor.withOpacity(0.1),
//                         child: Icon(
//                           user.userType == UserType.vendor
//                               ? Icons.business
//                               : Icons.person,
//                           color: user.userType == UserType.vendor
//                               ? AppTheme.secondaryColor
//                               : AppTheme.accentColor,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               user.name,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               user.email,
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppTheme.warningColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 user.userType == UserType.vendor
//                                     ? 'Vendor'
//                                     : 'Customer',
//                                 style: TextStyle(
//                                   color: AppTheme.warningColor,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Verification Documents Preview
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.description_outlined,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             user.userType == UserType.vendor
//                                 ? 'Business License, Tax Certificate'
//                                 : 'ID Card, Address Proof',
//                             style: TextStyle(
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {},
//                           child: const Text('View'),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Action Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             _showVerificationDialog(context, user, true);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppTheme.accentColor,
//                           ),
//                           child: const Text('Approve'),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             _showVerificationDialog(context, user, false);
//                           },
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: AppTheme.dangerColor,
//                             side: const BorderSide(color: AppTheme.dangerColor),
//                           ),
//                           child: const Text('Reject'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showVerificationDialog(BuildContext context, UserModel user, bool isApprove) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(isApprove ? 'Approve User' : 'Reject User'),
//         content: Text(
//           isApprove
//               ? 'Are you sure you want to approve ${user.name}?'
//               : 'Please provide a reason for rejecting ${user.name}',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 user.verificationStatus = isApprove
//                     ? VerificationStatus.verified
//                     : VerificationStatus.rejected;
//                 pendingUsers.remove(user);
//               });
//               Navigator.pop(context);
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     isApprove
//                         ? 'User approved successfully'
//                         : 'User rejected',
//                   ),
//                   backgroundColor: isApprove ? AppTheme.accentColor : AppTheme.dangerColor,
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isApprove ? AppTheme.accentColor : AppTheme.dangerColor,
//             ),
//             child: Text(isApprove ? 'Approve' : 'Reject'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//









import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';

class ProfileVerificationScreen extends StatefulWidget {
  const ProfileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileVerificationScreen> createState() => _ProfileVerificationScreenState();
}

class _ProfileVerificationScreenState extends State<ProfileVerificationScreen> {
  List<UserModel> pendingUsers = [];
  List<UserModel> allVendors = [];

  String _selectedFilter = 'All';
  final List<String> _filterOptions = [ 'All', 'Pending', 'Verified', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    pendingUsers = [
      ...UserModel.demoCustomers().where((u) => u.verificationStatus == VerificationStatus.pending),
      ...UserModel.demoVendors().where((u) => u.verificationStatus == VerificationStatus.pending),
    ];

    allVendors = UserModel.demoVendors();
  }

  List<UserModel> get _filteredVendors {
    switch (_selectedFilter) {
      case 'Pending':
        return allVendors.where((v) => v.verificationStatus == VerificationStatus.pending).toList();
      case 'Verified':
        return allVendors.where((v) => v.verificationStatus == VerificationStatus.verified).toList();
      case 'Rejected':
        return allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).toList();
      default:
        return allVendors;
    }
  }

  int get _pendingCount => allVendors.where((v) => v.verificationStatus == VerificationStatus.pending).length;
  int get _verifiedCount => allVendors.where((v) => v.verificationStatus == VerificationStatus.verified).length;
  int get _rejectedCount => allVendors.where((v) => v.verificationStatus == VerificationStatus.rejected).length;
  int get _todayCount => allVendors.where((v) =>
  v.registrationDate.year == DateTime.now().year &&
      v.registrationDate.month == DateTime.now().month &&
      v.registrationDate.day == DateTime.now().day
  ).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      body: SafeArea(
        child: Column(
          children: [


            Container(
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  const SizedBox(height: 4),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickStat('Pending', _pendingCount.toString(), Icons.pending_actions_rounded),
                      _buildQuickStat('Verified Today', _todayCount.toString(), Icons.verified_rounded),
                      _buildQuickStat('Approved', _verifiedCount.toString(), Icons.check_circle_rounded),
                      _buildQuickStat('Rejected', _rejectedCount.toString(), Icons.cancel_rounded),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filterOptions.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text('$filter (${_getCountForFilter(filter)})'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: const Color(0xFF4157FF).withOpacity(0.1),
                        checkmarkColor: const Color(0xFF4157FF),
                        labelStyle: TextStyle(
                          color: isSelected ? const Color(0xFF4157FF) : const Color(0xFF64748B),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected ? const Color(0xFF4157FF) : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Vendors List',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4157FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_filteredVendors.length} vendors',
                      style: const TextStyle(
                        color: Color(0xFF4157FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),


            Expanded(
              child: _filteredVendors.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4157FF).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.business_outlined,
                        size: 60,
                        color: const Color(0xFF4157FF).withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No vendors found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No vendors in $_selectedFilter status',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _filteredVendors.length,
                itemBuilder: (context, index) {
                  final vendor = _filteredVendors[index];
                  return _buildVendorCard(vendor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
  Widget _buildOverviewCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
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

  Widget _buildVendorCard(UserModel vendor) {
    final statusColor = vendor.verificationStatus == VerificationStatus.verified
        ? const Color(0xFF10B981)
        : vendor.verificationStatus == VerificationStatus.pending
        ? const Color(0xFFF59E0B)
        : const Color(0xFFEF4444);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(Icons.business, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor.hotelName ?? vendor.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Owner: ${vendor.name}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),


            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(Icons.email_outlined, 'Email', vendor.email),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.phone_outlined, 'Phone', vendor.phone),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(Icons.calendar_today_outlined, 'Submitted',
                            '${vendor.registrationDate.day}/${vendor.registrationDate.month}/${vendor.registrationDate.year}'),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.confirmation_number_outlined, 'User ID', '#${vendor.id}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),


            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showVendorDetails(vendor),
                    icon: const Icon(Icons.visibility_rounded, size: 16),
                    label: const Text('View Details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4157FF),
                      side: const BorderSide(color: Color(0xFF4157FF)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),


                if (vendor.verificationStatus == VerificationStatus.pending) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showVerificationDialog(vendor, true),
                      icon: const Icon(Icons.check_circle_rounded, size: 16,color: Colors.white),
                      label: const Text('Approve',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showVerificationDialog(vendor, false),
                      icon: const Icon(Icons.cancel_rounded, size: 16,color: Colors.white,),
                      label: const Text('Reject',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showVendorDetails(UserModel vendor) {
    final statusColor = vendor.verificationStatus == VerificationStatus.verified
        ? const Color(0xFF10B981)
        : vendor.verificationStatus == VerificationStatus.pending
        ? const Color(0xFFF59E0B)
        : const Color(0xFFEF4444);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [

              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const SizedBox(height: 20),


              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 18, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [

                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4157FF), Color(0xFF6B7DFF)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.business, color: Colors.white, size: 50),
                        ),
                      ),
                      const SizedBox(height: 16),


                      Text(
                        vendor.hotelName ?? vendor.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),


                      Text(
                        'Owner: ${vendor.name}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

                      const SizedBox(height: 24),


                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            _buildDetailItem('Hotel Name', vendor.hotelName ?? 'N/A'),
                            _buildDetailItem('Owner Name', vendor.name),
                            _buildDetailItem('Email Address', vendor.email),
                            _buildDetailItem('Phone Number', vendor.phone),
                            _buildDetailItem('User ID', '#${vendor.id}'),
                            _buildDetailItem('Submitted Date',
                                '${vendor.registrationDate.day}/${vendor.registrationDate.month}/${vendor.registrationDate.year}'),
                            _buildDetailItem('Hotel Stars', vendor.hotelStar?.displayName ?? 'N/A'),
                            _buildDetailItem('Total Bookings', '${vendor.totalBookings}'),
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
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getCountForFilter(String filter) {
    switch (filter) {
      case 'Pending':
        return _pendingCount;
      case 'Verified':
        return _verifiedCount;
      case 'Rejected':
        return _rejectedCount;
      default:
        return allVendors.length;
    }
  }


  void _showVerificationDialog(UserModel vendor, bool isApprove) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(
          isApprove ? Icons.check_circle_rounded : Icons.warning_rounded,
          color: isApprove ? const Color(0xFF10B981) : const Color(0xFFEF4444),
          size: 50,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isApprove ? 'Approve Vendor' : 'Reject Vendor',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isApprove
                  ? 'Are you sure you want to approve ${vendor.hotelName}?'
                  : 'Please provide a reason for rejecting ${vendor.hotelName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
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
                    borderRadius: BorderRadius.circular(12),
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                vendor.verificationStatus = isApprove
                    ? VerificationStatus.verified
                    : VerificationStatus.rejected;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isApprove
                        ? 'Vendor approved successfully'
                        : 'Vendor rejected',
                  ),
                  backgroundColor: isApprove ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isApprove ? const Color(0xFF34DDA4) : const Color(
                  0xFFEA4D4D),
              foregroundColor: Colors.white,
            ),
            child: Text(isApprove ? 'Approve' : 'Reject', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}