import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/feedback_model.dart';
import 'all_users_screen.dart';

class OfficeDashboardScreen extends StatefulWidget {
  const OfficeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<OfficeDashboardScreen> createState() => _OfficeDashboardScreenState();
}

class _OfficeDashboardScreenState extends State<OfficeDashboardScreen> {
  int _selectedIndex = 0;
  bool _isMounted = true;

  final List<Widget> _screens = [
    const OfficeHomeScreen(),
    const BookingDetailsScreen(),
    const OfficeBookingManagementScreen(),
    const OfficeReminderScreen(),
    const CustomerFeedbackListScreen(),
  ];

  final List<String> _titles = [
    "Office Dashboard",
    "Booking Details",
    "Booking Confirmation",
    "Reminders",
    "Customer Feedback",
  ];

  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 19.5,
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
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF1E293B), size: 22),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildOfficeDrawer(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF3B82F6),
            unselectedItemColor: Colors.grey[400],
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              color: Colors.grey[400],
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded, size: 24),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel_rounded, size: 24),
                label: "Details",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_rounded, size: 24),
                label: "Confirmed",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded, size: 24),
                label: "Reminders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rate_review_rounded, size: 24),
                label: "Feedback",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfficeDrawer() {
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
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
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
                      Icons.business_center_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Office Panel',
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
                        'Online • Staff',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
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
                  _buildDrawerItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    index: 0,
                  ),
                  _buildDrawerItem(
                    icon: Icons.hotel_rounded,
                    title: 'Booking Details',
                    index: 1,
                  ),
                  _buildDrawerItem(
                    icon: Icons.check_circle_rounded,
                    title: 'Booking Confirmation',
                    index: 2,
                    count: '8',
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications_active_rounded,
                    title: 'Reminders',
                    index: 3,
                    count: '5',
                  ),

                  _buildDrawerItem(
                    icon: Icons.rate_review_rounded,
                    title: 'Customer Feedback',
                    count: '6',
                    index: 4,
                    // isFeedback: true,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
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
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildDrawerItem({
  //   required IconData icon,
  //   required String title,
  //   int? index,
  //   VoidCallback? onTap,
  //   String? count,
  //   bool isLogout = false,
  //   bool isFeedback = false,
  // }) {
  //   final isSelected = index != null && _selectedIndex == index;
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 8),
  //     decoration: BoxDecoration(
  //       color: isSelected
  //           ? const Color(0xFF3B82F6).withOpacity(0.1)
  //           : Colors.transparent,
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: ListTile(
  //       leading: Container(
  //         padding: const EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: isSelected
  //               ? const Color(0xFF3B82F6).withOpacity(0.2)
  //               : isFeedback
  //               ? const Color(0xFFFF5F6D).withOpacity(0.1)
  //               : Colors.grey[100],
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Icon(
  //           icon,
  //           color: isSelected
  //               ? const Color(0xFF3B82F6)
  //               : isLogout
  //               ? Colors.red
  //               : isFeedback
  //               ? const Color(0xFFFF5F6D)
  //               : Colors.grey[600],
  //           size: 20,
  //         ),
  //       ),
  //       title: Text(
  //         title,
  //         style: TextStyle(
  //           color: isSelected
  //               ? const Color(0xFF3B82F6)
  //               : isLogout
  //               ? Colors.red
  //               : isFeedback
  //               ? const Color(0xFFFF5F6D)
  //               : const Color(0xFF1E293B),
  //           fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
  //           fontSize: 15,
  //         ),
  //       ),
  //       trailing: count != null
  //           ? Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //               decoration: BoxDecoration(
  //                 color: isFeedback
  //                     ? const Color(0xFFFF5F6D).withOpacity(0.1)
  //                     : Colors.red.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Text(
  //                 count,
  //                 style: TextStyle(
  //                   color: isFeedback ? const Color(0xFFFF5F6D) : Colors.red,
  //                   fontSize: 11,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             )
  //           : null,
  //       selected: isSelected,
  //       onTap: () {
  //         if (index != null) {
  //           setState(() {
  //             _selectedIndex = index;
  //           });
  //         } else if (onTap != null) {
  //           onTap();
  //         }
  //         Navigator.pop(context);
  //       },
  //     ),
  //   );
  // }



  Widget _buildDrawerItem({
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
        color: isSelected
            ? const Color(0xFF3B82F6).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF3B82F6).withOpacity(0.2)
                : isLogout
                ? Colors.red.withOpacity(0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? const Color(0xFF3B82F6)
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
                ? const Color(0xFF3B82F6)
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
            color: isSelected
                ? const Color(0xFF3B82F6).withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count,
            style: TextStyle(
              color: isSelected ? const Color(0xFF3B82F6) : Colors.red,
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

class OfficeHomeScreen extends StatelessWidget {
  const OfficeHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickStat('Today\'s', '24', Icons.today_rounded),
                _buildQuickStat('Check-ins', '12', Icons.login_rounded),
                _buildQuickStat('Check-outs', '8', Icons.logout_rounded),
                _buildQuickStat('Occupancy', '78%', Icons.analytics_rounded),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Booking Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'This Month',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 12,
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
                  childAspectRatio: 1.3,

                  children: [
                    _buildBookingStatCard(
                      title: 'Total Booking',
                      value: '1,245',
                      icon: Icons.check_circle_rounded,
                      color: const Color(0xFF10B981),
                      subtitle: '+12.5%',
                    ),
                    _buildBookingStatCard(
                      title: 'Confirmed Booking',
                      value: '1,075',
                      icon: Icons.verified_rounded,
                      color: const Color(0xFF3B82F6),
                      subtitle: '+15.3%',
                    ),
                    _buildBookingStatCard(
                      title: 'Pending',
                      value: '128',
                      icon: Icons.pending_rounded,
                      color: const Color(0xFFF59E0B),
                      subtitle: '-5.2%',
                    ),
                    _buildBookingStatCard(
                      title: 'Cancellation',
                      value: '42',
                      icon: Icons.cancel_rounded,
                      color: const Color(0xFFEF4444),
                      subtitle: '-2.1%',
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Today\'s Schedule',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '20 bookings',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildScheduleSection(
                  'Check-ins',
                  '8 guests arriving',
                  Icons.login_rounded,
                  const Color(0xFF10B981),
                  [
                    {
                      'name': 'John Doe',
                      'time': '10:00 AM',
                      'hotel': 'Grand Hotel',
                      'room': '204',
                    },
                    {
                      'name': 'Sarah Smith',
                      'time': '12:30 PM',
                      'hotel': 'Beach Resort',
                      'room': '315',
                    },
                    {
                      'name': 'Mike Johnson',
                      'time': '02:00 PM',
                      'hotel': 'City Inn',
                      'room': '108',
                    },
                  ],
                ),

                const SizedBox(height: 16),

                _buildScheduleSection(
                  'Check-outs',
                  '6 guests departing',
                  Icons.logout_rounded,
                  const Color(0xFFEF4444),
                  [
                    {
                      'name': 'Emily Brown',
                      'time': '11:00 AM',
                      'hotel': 'Luxury Palace',
                      'room': '502',
                    },
                    {
                      'name': 'Robert Wilson',
                      'time': '01:00 PM',
                      'hotel': 'Business Hotel',
                      'room': '301',
                    },
                    {
                      'name': 'Alice Johnson',
                      'time': '03:00 PM',
                      'hotel': 'Grand Hotel',
                      'room': '210',
                    },
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Recent Bookings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildBookingCard(index),
                    );
                  },
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
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBookingStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    bool isPositive = !subtitle.contains('-');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 10,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 9,
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
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    List<Map<String, String>> items,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              item['hotel']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Rm ${item['room']!}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item['time']!,
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
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(int index) {
    final bookings = [
      {
        'customer': 'John Doe',
        'hotel': 'Grand Hotel Plaza',
        'room': '204',
        'time': '10:00 AM',

        'status': 'Confirmed',
        'guests': 2,
      },
      {
        'customer': 'Sarah Smith',
        'hotel': 'Beach Resort',
        'room': '315',
        'time': '12:30 PM',

        'status': 'Pending',
        'guests': 3,
      },
      {
        'customer': 'Mike Johnson',
        'hotel': 'City Inn',
        'room': '108',
        'time': '02:00 PM',

        'status': 'Checked-in',
        'guests': 1,
      },
      {
        'customer': 'Emily Brown',
        'hotel': 'Luxury Palace',
        'room': '502',
        'time': '04:00 PM',

        'status': 'Confirmed',
        'guests': 4,
      },
      {
        'customer': 'Robert Wilson',
        'hotel': 'Business Hotel',
        'room': '301',
        'time': '06:00 PM',

        'status': 'Cancelled',
        'guests': 1,
      },
    ];

    final booking = bookings[index % bookings.length];

    Color statusColor;
    switch (booking['status'].toString()) {
      case 'Confirmed':
        statusColor = const Color(0xFF10B981);
        break;
      case 'Pending':
        statusColor = const Color(0xFFF59E0B);
        break;
      case 'Checked-in':
        statusColor = const Color(0xFF3B82F6);
        break;
      case 'Cancelled':
        statusColor = const Color(0xFFEF4444);
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.hotel, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    booking['hotel'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${booking['customer']} • ${booking['guests']} guests',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.meeting_room_rounded,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Room ${booking['room']}',
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        booking['time'].toString(),
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    booking['status'].toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
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
    );
  }
}

class OfficeBookingManagementScreen extends StatefulWidget {
  const OfficeBookingManagementScreen({Key? key}) : super(key: key);

  @override
  State<OfficeBookingManagementScreen> createState() =>
      _OfficeBookingManagementScreenState();
}

class _OfficeBookingManagementScreenState
    extends State<OfficeBookingManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Map<String, dynamic>> get _allBookings {
    return [
      {
        'id': 'BK001',
        'customer': 'John Doe',
        'hotel': 'Grand Hotel Plaza',
        'checkIn': '20 Feb 2026',
        'checkOut': '22 Feb 2026',
        'amount': '\$450',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 3,
        'roomType': 'Deluxe Suite',
        'phone': '+91 9942523910',
        'email': 'john.doe@email.com',
      },
      {
        'id': 'BK005',
        'customer': 'Robert Wilson',
        'hotel': 'Business Hotel',
        'checkIn': '01 Mar 2024',
        'checkOut': '03 Mar 2024',
        'amount': '\$320',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 1,
        'roomType': 'Executive Room',
        'phone': '+1 234 567 894',
        'email': 'robert.wilson@email.com',
      },
      {
        'id': 'BK006',
        'customer': 'Alice Johnson',
        'hotel': 'Ocean View Resort',
        'checkIn': '22 Mar 2024',
        'checkOut': '25 Mar 2024',
        'amount': '\$680',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 3,
        'roomType': 'Family Suite',
        'phone': '+1 234 567 895',
        'email': 'alice.johnson@email.com',
      },
      {
        'id': 'BK007',
        'customer': 'David Wilson',
        'hotel': 'Mountain Lodge',
        'checkIn': '18 Mar 2024',
        'checkOut': '21 Mar 2024',
        'amount': '\$520',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 2,
        'roomType': 'Mountain View',
        'phone': '+1 234 567 896',
        'email': 'david.wilson@email.com',
      },
      {
        'id': 'BK008',
        'customer': 'Jennifer Lee',
        'hotel': 'Grand Hotel Plaza',
        'checkIn': '25 Mar 2024',
        'checkOut': '28 Mar 2024',
        'amount': '\$580',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 2,
        'roomType': 'Deluxe Room',
        'phone': '+1 234 567 897',
        'email': 'jennifer.lee@email.com',
      },
      {
        'id': 'BK009',
        'customer': 'Thomas Brown',
        'hotel': 'Beach Resort & Spa',
        'checkIn': '28 Mar 2024',
        'checkOut': '31 Mar 2024',
        'amount': '\$950',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 4,
        'roomType': 'Beach Front Suite',
        'phone': '+1 234 567 898',
        'email': 'thomas.brown@email.com',
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredBookings {
    if (_searchQuery.isEmpty) {
      return _allBookings;
    }

    return _allBookings.where((booking) {
      return booking['customer'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          booking['hotel'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          booking['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          booking['roomType'].toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Confirmed Bookings',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
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
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_filteredBookings.length} bookings',
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by customer, hotel or booking ID...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: const Color(0xFF10B981),
                        size: 22,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        _filteredBookings.isEmpty
            ? SliverToBoxAdapter(
                child: Container(
                  height: 300,
                  margin: const EdgeInsets.all(16),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 60,
                          color: const Color(0xFF10B981).withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No confirmed bookings found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'No results match your search'
                              : 'Check back later for new bookings',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: _buildConfirmedBookingCard(_filteredBookings[index]),
                  );
                }, childCount: _filteredBookings.length),
              ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildConfirmedBookingCard(Map<String, dynamic> booking) {
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
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _showBookingDetails(context, booking),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          booking['hotel'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${booking['id'].toString()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Confirmed',
                          style: TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
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
                  Icon(Icons.person_outline, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      booking['customer'].toString(),
                      style: const TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      booking['phone'].toString(),
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailChip(
                    Icons.calendar_today_rounded,
                    'Check In',
                    booking['checkIn'].toString(),
                  ),
                  const SizedBox(width: 8),
                  _buildDetailChip(
                    Icons.calendar_today_rounded,
                    'Check Out',
                    booking['checkOut'].toString(),
                  ),
                  const SizedBox(width: 8),
                  _buildDetailChip(
                    Icons.meeting_room_rounded,
                    'Room',
                    booking['roomType'].toString(),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      'View Details',
                      Icons.visibility_rounded,
                      const Color(0xFF3B82F6),
                      () => _showBookingDetails(context, booking),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionButton(
                      'Reschedule',
                      Icons.schedule_rounded,
                      const Color(0xFFF59E0B),
                      () => _rescheduleBooking(booking),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionButton(
                      'Cancel',
                      Icons.cancel_rounded,
                      const Color(0xFFEF4444),
                      () => _cancelBooking(booking),
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

  Widget _buildDetailChip(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: const Color(0xFF10B981)),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 8, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
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

  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [

                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF10B981),
                                            Color(0xFF059669),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            booking['hotel'].toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Booking #${booking['id'].toString()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: Color(0xFF10B981),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Confirmed',
                                        style: TextStyle(
                                          color: Color(0xFF10B981),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                _buildDetailSection(
                                  'Customer Details',
                                  Icons.person_rounded,
                                  [
                                    {
                                      'label': 'Name',
                                      'value': booking['customer'].toString(),
                                    },
                                    {
                                      'label': 'Email',
                                      'value': booking['email'].toString(),
                                    },
                                    {
                                      'label': 'Phone',
                                      'value': booking['phone'].toString(),
                                    },
                                  ],
                                ),

                                const SizedBox(height: 16),

                                _buildDetailSection(
                                  'Booking Details',
                                  Icons.book_online_rounded,
                                  [
                                    {
                                      'label': 'Check-in',
                                      'value': booking['checkIn'].toString(),
                                    },
                                    {
                                      'label': 'Check-out',
                                      'value': booking['checkOut'].toString(),
                                    },
                                    {
                                      'label': 'Room Type',
                                      'value': booking['roomType'].toString(),
                                    },
                                    {
                                      'label': 'Guests',
                                      'value':
                                          '${booking['guests'].toString()} guests',
                                    },
                                    {
                                      'label': 'Rooms',
                                      'value':
                                          '${booking['rooms'].toString()} rooms',
                                    },
                                  ],
                                ),

                                const SizedBox(height: 16),

                                _buildDetailSection(
                                  'Payment Details',
                                  Icons.payment_rounded,
                                  [
                                    {
                                      'label': 'Amount',
                                      'value': booking['amount'].toString(),
                                    },
                                    {'label': 'Status', 'value': 'Paid'},
                                  ],
                                ),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _rescheduleBooking(booking);
                                        },
                                        icon: const Icon(
                                          Icons.schedule_rounded,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          'Reschedule',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: const Color(
                                            0xFFF59E0B,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xFFF59E0B),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _cancelBooking(booking);
                                        },
                                        icon: const Icon(
                                          Icons.cancel_rounded,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFFEF4444,
                                          ),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
            );
          },
        );
      },
    );
  }

  Widget _buildDetailSection(
    String title,
    IconData icon,
    List<Map<String, String>> items,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF10B981)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      item['label']!.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text(': ', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Text(
                      item['value']!.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  void _rescheduleBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reschedule Booking', style: TextStyle(fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select new dates for ${booking['customer']}\'s booking',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Dates',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${booking['checkIn']} to ${booking['checkOut']}',
                        style: const TextStyle(
                          fontSize: 13,
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 13)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Booking rescheduled successfully',
                    style: TextStyle(fontSize: 13),
                  ),
                  backgroundColor: Color(0xFFF59E0B),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
            ),
            child: const Text('Reschedule', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cancel Booking', style: TextStyle(fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to cancel booking #${booking['id'].toString()}?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Reason for cancellation (optional)',
                hintStyle: const TextStyle(fontSize: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep It', style: TextStyle(fontSize: 13)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Booking cancelled',
                    style: TextStyle(fontSize: 13),
                  ),
                  backgroundColor: Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Yes, Cancel', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class OfficeReminderScreen extends StatefulWidget {
  const OfficeReminderScreen({Key? key}) : super(key: key);

  @override
  State<OfficeReminderScreen> createState() => _OfficeReminderScreenState();
}

class _OfficeReminderScreenState extends State<OfficeReminderScreen> {
  List<Map<String, dynamic>> get _confirmedBookings {
    return [
      {
        'id': 'BK001',
        'customer': 'John Doe',
        'hotel': 'Grand Hotel Plaza',
        'checkIn': '22 Feb 2026',
        'checkOut': '24 Feb 2026',
        'amount': '\$450',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 3,
        'roomType': 'Deluxe Suite',
        'phone': '+91 9942523910',
        'email': 'john.doe@email.com',
      },
      {
        'id': 'BK005',
        'customer': 'Robert Wilson',
        'hotel': 'Business Hotel',
        'checkIn': '01 Mar 2026',
        'checkOut': '03 Mar 2026',
        'amount': '\$320',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 1,
        'roomType': 'Executive Room',
        'phone': '+1 234 567 894',
        'email': 'robert.wilson@email.com',
      },
      {
        'id': 'BK006',
        'customer': 'Alice Johnson',
        'hotel': 'Ocean View Resort',
        'checkIn': '22 Mar 2026',
        'checkOut': '25 Mar 2026',
        'amount': '\$680',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 3,
        'roomType': 'Family Suite',
        'phone': '+1 234 567 895',
        'email': 'alice.johnson@email.com',
      },
      {
        'id': 'BK007',
        'customer': 'David Wilson',
        'hotel': 'Mountain Lodge',
        'checkIn': '18 Mar 2026',
        'checkOut': '21 Mar 2026',
        'amount': '\$520',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 2,
        'roomType': 'Mountain View',
        'phone': '+1 234 567 896',
        'email': 'david.wilson@email.com',
      },
      {
        'id': 'BK008',
        'customer': 'Jennifer Lee',
        'hotel': 'Grand Hotel Plaza',
        'checkIn': '25 Mar 2026',
        'checkOut': '28 Mar 2026',
        'amount': '\$580',
        'status': 'Confirmed',
        'rooms': 1,
        'guests': 2,
        'roomType': 'Deluxe Room',
        'phone': '+1 234 567 897',
        'email': 'jennifer.lee@email.com',
      },
      {
        'id': 'BK009',
        'customer': 'Thomas Brown',
        'hotel': 'Beach Resort & Spa',
        'checkIn': '28 Mar 2026',
        'checkOut': '31 Mar 2026',
        'amount': '\$950',
        'status': 'Confirmed',
        'rooms': 2,
        'guests': 4,
        'roomType': 'Beach Front Suite',
        'phone': '+1 234 567 898',
        'email': 'thomas.brown@email.com',
      },
    ];
  }

  DateTime _getBookingDate(String checkInDateStr) {
    DateTime checkIn = _parseDate(checkInDateStr);

    if (checkInDateStr.contains('20 Feb')) {
      return checkIn.subtract(const Duration(days: 35));
    } else if (checkInDateStr.contains('01 Mar')) {
      return checkIn.subtract(const Duration(days: 40));
    } else if (checkInDateStr.contains('22 Mar')) {
      return checkIn.subtract(const Duration(days: 50));
    } else if (checkInDateStr.contains('18 Mar')) {
      return checkIn.subtract(const Duration(days: 25));
    } else if (checkInDateStr.contains('25 Mar')) {
      return checkIn.subtract(const Duration(days: 15));
    } else if (checkInDateStr.contains('28 Mar')) {
      return checkIn.subtract(const Duration(days: 60));
    }
    return checkIn.subtract(const Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime(2026, 2, 20);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Remainder Schedule',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Smart reminders for upcoming confirmed bookings',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Active Reminders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_confirmedBookings.length} bookings',
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF3B82F6),
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
          delegate: SliverChildBuilderDelegate((context, index) {
            final booking = _confirmedBookings[index];
            DateTime checkInDate = _parseDate(booking['checkIn'].toString());
            DateTime bookingDate = _getBookingDate(
              booking['checkIn'].toString(),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: _buildReminderCard(
                booking,
                bookingDate,
                checkInDate,
                today,
              ),
            );
          }, childCount: _confirmedBookings.length),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  DateTime _parseDate(String dateStr) {
    try {
      List<String> parts = dateStr.split(' ');
      int day = int.parse(parts[0]);
      String monthStr = parts[1];
      int year = int.parse(parts[2]);

      Map<String, int> months = {
        'Jan': 1,
        'Feb': 2,
        'Mar': 3,
        'Apr': 4,
        'May': 5,
        'Jun': 6,
        'Jul': 7,
        'Aug': 8,
        'Sep': 9,
        'Oct': 10,
        'Nov': 11,
        'Dec': 12,
      };

      return DateTime(year, months[monthStr]!, day);
    } catch (e) {
      return DateTime.now();
    }
  }


  Widget _buildReminderCard(
      Map<String, dynamic> booking,
      DateTime bookingDate,
      DateTime checkInDate,
      DateTime today,
      ) {
    String reminderMessage = _getReminderMessage(
      bookingDate,
      checkInDate,
      today,
    );
    int daysUntilCheckIn = checkInDate.difference(today).inDays;


    int bookingAdvanceDays = checkInDate.difference(bookingDate).inDays;
    int bookingAdvanceWeeks = (bookingAdvanceDays / 7).floor();


    DateTime nextReminderDate;
    if (bookingAdvanceDays >= 60) {

      nextReminderDate = today.add(const Duration(days: 14));
    } else if (bookingAdvanceDays >= 30) {

      nextReminderDate = today.add(const Duration(days: 7));
    } else {

      nextReminderDate = today.add(const Duration(days: 1));
    }

    String formattedNextReminder = _formatDate(nextReminderDate);

    Color cardColor;
    IconData reminderIcon;
    bool isFinalWeek = false;

    if (reminderMessage.contains('Final week') ||
        reminderMessage.contains('Last minute') ||
        reminderMessage.contains('daily reminders') ||
        daysUntilCheckIn <= 7 && daysUntilCheckIn > 0) {
      cardColor = const Color(0xFFEF4444);
      reminderIcon = Icons.warning_rounded;
      isFinalWeek = true;
      print('FINAL WEEK DETECTED: $reminderMessage, days: $daysUntilCheckIn');
    } else if (reminderMessage.contains('TODAY')) {
      cardColor = const Color(0xFF10B981);
      reminderIcon = Icons.check_circle_rounded;
      isFinalWeek = true;
    } else if (reminderMessage.contains('Tomorrow') || daysUntilCheckIn <= 2) {
      cardColor = const Color(0xFFF59E0B);
      reminderIcon = Icons.access_alarm_rounded;
      isFinalWeek = true;
    } else {
      cardColor = const Color(0xFF3B82F6);
      reminderIcon = Icons.notifications_active_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: cardColor.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cardColor, cardColor.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      booking['customer'].toString()[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        booking['customer'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      GestureDetector(
                        onTap: () {
                          // _makePhoneCall(booking['phone'].toString());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 12,
                              color: cardColor,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                booking['phone'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: cardColor.withOpacity(0.3),
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
                ),
                // Booking ID chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking['id'].toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Confirm Date Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.event_available_rounded, size: 14, color: cardColor),
                  const SizedBox(width: 6),
                  Text(
                    'Confirmed: ${_formatDate(bookingDate)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$bookingAdvanceDays days / $bookingAdvanceWeeks weeks',
                      style: TextStyle(
                        fontSize: 10,
                        color: cardColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.login_rounded,
                            size: 12,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CHECK IN',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                booking['checkIn'].toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            size: 12,
                            color: Color(0xFFF59E0B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CHECK OUT',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                booking['checkOut'].toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

            const SizedBox(height: 14),

            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            //   decoration: BoxDecoration(
            //     color: cardColor.withOpacity(0.08),
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: cardColor.withOpacity(0.3), width: 1),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(reminderIcon, size: 18, color: cardColor),
            //       const SizedBox(width: 10),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               reminderMessage,
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: cardColor,
            //                 fontWeight: FontWeight.w600,
            //                 height: 1.3,
            //               ),
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             const SizedBox(height: 4),
            //             Text(
            //               'Next: $formattedNextReminder',
            //               style: TextStyle(
            //                 fontSize: 9,
            //                 color: cardColor.withOpacity(0.7),
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //
            //       // SHOW BOTH ICONS FOR ALL REMINDERS (including final week)
            //       Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               // _makePhoneCall(booking['phone'].toString());
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.all(8),
            //               decoration: BoxDecoration(
            //                 color: cardColor,
            //                 borderRadius: BorderRadius.circular(10),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: cardColor.withOpacity(0.3),
            //                     blurRadius: 4,
            //                     offset: const Offset(0, 2),
            //                   ),
            //                 ],
            //               ),
            //               child: const Icon(
            //                 Icons.phone_rounded,
            //                 size: 16,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 8),
            //           GestureDetector(
            //             onTap: () {
            //               // _openWhatsApp(booking['phone'].toString());
            //             },
            //             child: Container(
            //               padding: const EdgeInsets.all(8),
            //               decoration: BoxDecoration(
            //                 color: const Color(0xFF25D366),
            //                 borderRadius: BorderRadius.circular(10),
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: const Color(0xFF25D366).withOpacity(0.3),
            //                     blurRadius: 4,
            //                     offset: const Offset(0, 2),
            //                   ),
            //                 ],
            //               ),
            //               child: const Icon(
            //                 Icons.message_rounded,
            //                 size: 16,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cardColor.withOpacity(0.3), width: 1),
              ),
              child: Row(
                children: [
                  Icon(reminderIcon, size: 18, color: cardColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reminderMessage,
                          style: TextStyle(
                            fontSize: 12,
                            color: cardColor,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Only show "Next:" text if NOT in 2 days or less scenario
                        if (!(reminderMessage.contains('ONLY') ||
                            reminderMessage.contains('TODAY') ||
                            reminderMessage.contains('TOMORROW') ||
                            daysUntilCheckIn <= 2))
                          Text(
                            'Next: $formattedNextReminder',
                            style: TextStyle(
                              fontSize: 9,
                              color: cardColor.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),


                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // _makePhoneCall(booking['phone'].toString());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: cardColor.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.phone_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // _openWhatsApp(booking['phone'].toString());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25D366),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF25D366).withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.message_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.hotel_rounded, size: 10, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Text(
                  booking['hotel'].toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }


  // String _getReminderMessage(
  //   DateTime bookingDate,
  //   DateTime checkInDate,
  //   DateTime today,
  // ) {
  //   Duration difference = checkInDate.difference(today);
  //   Duration bookingToCheckIn = checkInDate.difference(bookingDate);
  //
  //   int daysUntilCheckIn = difference.inDays;
  //   int totalBookingDays = bookingToCheckIn.inDays;
  //
  //   if (totalBookingDays >= 60) {
  //     int weeksSinceBooking = ((today.difference(bookingDate).inDays) / 7)
  //         .floor();
  //     if (weeksSinceBooking % 2 == 0) {
  //       return "📅 2+ months advance booking - Bi-weekly reminder (Week ${weeksSinceBooking ~/ 2 + 1})";
  //     } else {
  //       return "⏰ Next reminder in ${(weeksSinceBooking % 2 == 0 ? 14 : 7)} days";
  //     }
  //   } else if (totalBookingDays >= 30) {
  //     int weeksSinceBooking = ((today.difference(bookingDate).inDays) / 7)
  //         .floor();
  //     if (daysUntilCheckIn > 7) {
  //       return "📅 1 month advance booking - Weekly reminder (Week ${weeksSinceBooking + 1})";
  //     } else {
  //       return "⚠️ FINAL WEEK - Daily reminders until check-in";
  //     }
  //   } else if (totalBookingDays >= 7) {
  //     if (daysUntilCheckIn <= 7 && daysUntilCheckIn > 0) {
  //       return "🔥 FINAL WEEK - Last minute booking preparation reminders";
  //     }
  //   }
  //
  //   if (daysUntilCheckIn > 30) {
  //     return "📅 ${daysUntilCheckIn} days until check-in - Monthly check";
  //   } else if (daysUntilCheckIn > 14) {
  //     return "📅 ${daysUntilCheckIn} days until check-in - Weekly updates";
  //   } else if (daysUntilCheckIn > 7) {
  //     return "⚠️ ${daysUntilCheckIn} days until check-in - Getting closer!";
  //   } else if (daysUntilCheckIn > 3) {
  //     return "🔥 FINAL WEEK - ${daysUntilCheckIn} days until check-in - Prepare documents";
  //   } else if (daysUntilCheckIn > 1) {
  //     return "⚡ FINAL WEEK - Only ${daysUntilCheckIn} days left! - Confirm details";
  //   } else if (daysUntilCheckIn == 1) {
  //     return "✨ FINAL WEEK - Tomorrow is the big day! - Final reminders";
  //   } else if (daysUntilCheckIn == 0) {
  //     return "✅ TODAY - Check-in TODAY! - Have a wonderful stay";
  //   } else {
  //     return "📋 Booking completed - Thank you for staying with us";
  //   }
  // }


  String _getReminderMessage(
      DateTime bookingDate,
      DateTime checkInDate,
      DateTime today,
      ) {
    Duration difference = checkInDate.difference(today);
    Duration bookingToCheckIn = checkInDate.difference(bookingDate);

    int daysUntilCheckIn = difference.inDays;
    int totalBookingDays = bookingToCheckIn.inDays;


    if (daysUntilCheckIn == 2) {
      return "⚡ 2 DAYS LEFT! Daily Remainder";
    }


    if (daysUntilCheckIn == 1) {
      return "✨ TOMORROW! - Final preparations needed";
    }


    if (daysUntilCheckIn == 0) {
      return "✅ TODAY - Check-in today! Have a great stay";
    }

    if (totalBookingDays >= 60) {
      int weeksSinceBooking = ((today.difference(bookingDate).inDays) / 7)
          .floor();
      if (weeksSinceBooking % 2 == 0) {
        return "📅 2+ months advance booking - Bi-weekly reminder (Week ${weeksSinceBooking ~/ 2 + 1})";
      } else {
        return "⏰ Next reminder in ${(weeksSinceBooking % 2 == 0 ? 14 : 7)} days";
      }
    } else if (totalBookingDays >= 30) {
      int weeksSinceBooking = ((today.difference(bookingDate).inDays) / 7)
          .floor();
      if (daysUntilCheckIn > 7) {
        return "📅 1 month advance booking - Weekly reminder (Week ${weeksSinceBooking + 1})";
      } else {
        return "⚠️ FINAL WEEK - Daily reminders until check-in";
      }
    } else if (totalBookingDays >= 7) {
      if (daysUntilCheckIn <= 7 && daysUntilCheckIn > 0) {
        return "🔥 FINAL WEEK - Last minute booking preparation reminders";
      }
    }

    if (daysUntilCheckIn > 30) {
      return "📅 ${daysUntilCheckIn} days until check-in - Monthly check";
    } else if (daysUntilCheckIn > 14) {
      return "📅 ${daysUntilCheckIn} days until check-in - Weekly updates";
    } else if (daysUntilCheckIn > 7) {
      return "⚠️ ${daysUntilCheckIn} days until check-in - Getting closer!";
    } else if (daysUntilCheckIn > 3) {
      return "🔥 ${daysUntilCheckIn} days until check-in - Prepare documents";
    } else if (daysUntilCheckIn > 2) {
      return "⚡ ${daysUntilCheckIn} days left! - Confirm details";
    } else {
      return "📋 Booking completed - Thank you for staying with us";
    }
  }
}

class CustomerFeedbackListScreen extends StatefulWidget {
  const CustomerFeedbackListScreen({super.key});

  @override
  State<CustomerFeedbackListScreen> createState() =>
      _CustomerFeedbackListScreenState();
}

class _CustomerFeedbackListScreenState
    extends State<CustomerFeedbackListScreen> {
  @override
  void initState() {
    super.initState();
    FeedbackStorage.addSampleData();
  }

  List<FeedbackModel> get _allFeedbacks {
    return FeedbackStorage.feedbacks;
  }

  Map<String, dynamic> get _stats {
    int total = FeedbackStorage.feedbacks.length;
    if (total == 0) {
      return {'average': 0.0, 'total': 0};
    }

    double totalRating = 0;
    for (var f in FeedbackStorage.feedbacks) {
      totalRating += f.rating;
    }

    return {'average': totalRating / total, 'total': total};
  }

  @override
  Widget build(BuildContext context) {
    final stats = _stats;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: _allFeedbacks.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFF8A5C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5F6D).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Average Rating',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                stats['average'].toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '/5',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total Reviews',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${stats['total']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'All Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),

                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF5F6D), Color(0xFFFF8A5C)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF5F6D).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerFeedbackFormScreen(),
                                ),
                              ).then((_) => setState(() {}));
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_comment_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Add Feedback',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5F6D).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_allFeedbacks.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFF5F6D),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _allFeedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = _allFeedbacks[index];
                      return _buildFeedbackCard(feedback);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5F6D), Color(0xFFFF8A5C)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5F6D).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.rate_review_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Feedback Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share your experience',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerFeedbackFormScreen(),
                ),
              ).then((_) => setState(() {}));
            },
            icon: const Icon(Icons.add_comment_rounded),
            label: const Text(''),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5F6D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(FeedbackModel feedback) {
    Color ratingColor = _getRatingColor(feedback.rating);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ratingColor, ratingColor.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      feedback.isAnonymous
                          ? 'A'
                          : feedback.customerName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              feedback.isAnonymous
                                  ? 'Anonymous'
                                  : feedback.customerName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          // Rating Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: ratingColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 14,
                                  color: ratingColor,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  feedback.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ratingColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            Icons.hotel_rounded,
                            size: 12,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              feedback.hotelName,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              feedback.bookingId,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                feedback.comment,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 12,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(feedback.date),
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
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

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return const Color(0xFF10B981);
    if (rating >= 3.5) return const Color(0xFF3B82F6);
    if (rating >= 2.5) return const Color(0xFFF59E0B);
    if (rating >= 1.5) return const Color(0xFFF97316);
    return const Color(0xFFEF4444);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else {
      return '${date.day} ${_getMonth(date.month)} ${date.year}';
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class CustomerFeedbackFormScreen extends StatefulWidget {
  const CustomerFeedbackFormScreen({super.key});

  @override
  State<CustomerFeedbackFormScreen> createState() =>
      _CustomerFeedbackFormScreenState();
}

class _CustomerFeedbackFormScreenState
    extends State<CustomerFeedbackFormScreen> {
  final _commentController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Feedback'),
        backgroundColor: const Color(0xFFFF5F6D),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Rate your experience'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_rating > 0 && _commentController.text.isNotEmpty) {
                  final feedback = FeedbackModel(
                    id: 'FB${DateTime.now().millisecondsSinceEpoch}',
                    customerName: 'Test User',
                    customerPhone: '+1234567890',
                    bookingId: 'BK001',
                    hotelName: 'Test Hotel',
                    rating: _rating,
                    comment: _commentController.text,
                    date: DateTime.now(),
                  );
                  FeedbackStorage.addFeedback(feedback);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5F6D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
