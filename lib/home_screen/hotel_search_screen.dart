// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/animation.dart';
//
// import 'hotel_details_screen.dart';
//
// class HotelSearchScreen extends StatefulWidget {
//   const HotelSearchScreen({super.key});
//
//   @override
//   State<HotelSearchScreen> createState() => _HotelSearchScreenState();
// }
//
// class _HotelSearchScreenState extends State<HotelSearchScreen>
//     with SingleTickerProviderStateMixin {
//   DateTime? _checkInDate;
//   DateTime? _checkOutDate;
//   int _roomCount = 1;
//   int _adultCount = 1;
//   int _childCount = 0;
//   String? _selectedPurpose;
//   Map<String, bool> _selectedFilters = {};
//   bool _showResults = false;
//   String? _expandedFilter;
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   final List<String> _purposeOptions = ['Work', 'Special Occasion', 'Transit', 'Holiday'];
//
//   // final List<Map<String, dynamic>> _hotels = [
//   //   {
//   //     "image": "assets/images/img5.jpg",
//   //     "discount": "10% Off",
//   //     "name": "Hotel Paradise",
//   //     "location": "Chennai Central",
//   //     "price": "\$200",
//   //     "rating": 4.8,
//   //     "reviews": 1247,
//   //     "distance": "2.3 km from center",
//   //     "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
//   //     "description": "Luxury hotel with premium amenities and excellent service in the heart of Chennai.",
//   //     "amenities": ["Wi-Fi", "Swimming Pool", "Spa", "Gym", "Restaurant", "Bar"],
//   //     "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
//   //   },
//   //   {
//   //     "image": "assets/images/img6.jpg",
//   //     "discount": "15% Off",
//   //     "name": "Grand Residency",
//   //     "location": "T. Nagar",
//   //     "price": "\$120",
//   //     "rating": 4.6,
//   //     "reviews": 892,
//   //     "distance": "1.8 km from center",
//   //     "tags": ["Free Parking", "Gym", "Restaurant"],
//   //     "description": "Comfortable stay with modern amenities in Chennai's prime shopping district.",
//   //     "amenities": ["Wi-Fi", "Parking", "Gym", "Restaurant", "Room Service"],
//   //     "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
//   //   },
//   //   {
//   //     "image": "assets/images/img7.jpg",
//   //     "discount": "20% Off",
//   //     "name": "Sea View Resort",
//   //     "location": "Marina Beach",
//   //     "price": "\$180",
//   //     "rating": 4.9,
//   //     "reviews": 1563,
//   //     "distance": "0.5 km from beach",
//   //     "tags": ["Beach Front", "Luxury", "All Inclusive"],
//   //     "description": "Beachfront luxury resort offering breathtaking views and premium services.",
//   //     "amenities": ["Beach Access", "Pool", "Spa", "Fine Dining", "Water Sports"],
//   //     "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"]
//   //   },
//   // ];
//   final List<Map<String, dynamic>> _hotels = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "10% Off",
//       "name": "Hotel Paradise",
//       "location": "Chennai Central",
//       "price": "\$200",
//       "rating": 4.8,
//       "star": "5 star hotel", // Added star rating
//       "reviews": 1247,
//       "distance": "2.3 km from center",
//       "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
//       "description": "Luxury 5-star hotel with premium amenities and excellent service in the heart of Chennai.",
//       "amenities": ["Wi-Fi", "Swimming Pool", "Spa", "Gym", "Restaurant", "Bar"],
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "15% Off",
//       "name": "Grand Residency",
//       "location": "T. Nagar",
//       "price": "\$120",
//       "rating": 4.6,
//       "star": "3 star hotel", // Added star rating
//       "reviews": 892,
//       "distance": "1.8 km from center",
//       "tags": ["Free Parking", "Gym", "Restaurant"],
//       "description": "Comfortable 3-star stay with modern amenities in Chennai's prime shopping district.",
//       "amenities": ["Wi-Fi", "Parking", "Gym", "Restaurant", "Room Service"],
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
//     },
//     {
//       "image": "assets/images/img7.jpg",
//       "discount": "20% Off",
//       "name": "Sea View Resort",
//       "location": "Marina Beach",
//       "price": "\$350",
//       "rating": 4.9,
//       "star": "7 star hotel", // Added star rating
//       "reviews": 1563,
//       "distance": "0.5 km from beach",
//       "tags": ["Beach Front", "Luxury", "All Inclusive"],
//       "description": "Beachfront luxury 7-star resort offering breathtaking views and premium services.",
//       "amenities": ["Beach Access", "Pool", "Spa", "Fine Dining", "Water Sports"],
//       "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"]
//     },
//     // Add more hotels to show 5 properties
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "25% Off",
//       "name": "Royal Palace Hotel",
//       "location": "Anna Nagar",
//       "price": "\$280",
//       "rating": 4.7,
//       "star": "5 star hotel",
//       "reviews": 1050,
//       "distance": "3.1 km from center",
//       "tags": ["Luxury Spa", "Fine Dining", "Rooftop Pool"],
//       "description": "Opulent 5-star hotel with royal treatment and world-class amenities.",
//       "amenities": ["Butler Service", "Private Pool", "Helipad", "Wine Cellar"],
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "30% Off",
//       "name": "Budget Stay Inn",
//       "location": "Koyambedu",
//       "price": "\$80",
//       "rating": 4.2,
//       "star": "3 star hotel",
//       "reviews": 650,
//       "distance": "4.5 km from center",
//       "tags": ["Budget Friendly", "Free Breakfast", "Airport Shuttle"],
//       "description": "Affordable 3-star hotel with essential amenities for comfortable stay.",
//       "amenities": ["AC Rooms", "Free Parking", "24/7 Reception"],
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
//     },
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0.0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate(bool isCheckIn) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCheckIn
//           ? (_checkInDate ?? DateTime.now())
//           : (_checkOutDate ?? (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(DateTime.now().year + 1),
//     );
//
//     if (picked != null) {
//       setState(() {
//         if (isCheckIn) {
//           _checkInDate = picked;
//           if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
//             _checkOutDate = picked.add(const Duration(days: 1));
//           }
//         } else {
//           _checkOutDate = picked;
//         }
//       });
//     }
//   }
//
//   Widget _buildCounter(String label, int value, int min, int max, Function onMinus, Function onPlus) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//               color: Colors.grey[800],
//             ),
//           ),
//           Row(
//             children: [
//               _buildIconButton(
//                 icon: Icons.remove,
//                 onPressed: value > min ? () => onMinus() : null,
//                 isEnabled: value > min,
//               ),
//               Container(
//                 width: 40,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "$value",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Color(0xFFFF7043),
//                   ),
//                 ),
//               ),
//               _buildIconButton(
//                 icon: Icons.add,
//                 onPressed: value < max ? () => onPlus() : null,
//                 isEnabled: value < max,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconButton({
//     required IconData icon,
//     required VoidCallback? onPressed,
//     required bool isEnabled,
//   }) {
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(
//         color: isEnabled ? Color(0xFFFF7043) : Colors.grey[300],
//         shape: BoxShape.circle,
//       ),
//       child: IconButton(
//         icon: Icon(icon, size: 15),
//         color: Colors.white,
//         onPressed: onPressed,
//         padding: EdgeInsets.all(0),
//         constraints: BoxConstraints(),
//       ),
//     );
//   }
//
//   // Method to get current room amenities based on selected star rating
//   List<String> _getCurrentRoomAmenities() {
//     // Check which star ratings are selected
//     final bool is3StarSelected = _selectedFilters["3 star hotel"] ?? false;
//     final bool is5StarSelected = _selectedFilters["5 star hotel"] ?? false;
//     final bool is7StarSelected = _selectedFilters["7 star hotel"] ?? false;
//
//     if (is7StarSelected) {
//       // 7-Star Hotel Amenities
//       return [
//         "Private Butler Service",
//         "Smart Room Automation",
//         "Panoramic Views",
//         "Gold-Plated Bathrooms",
//         "Private Jacuzzi",
//         "Michelin-Star Restaurants",
//         "Personal Chef",
//         "Helicopter Transfers",
//         "Infinity Pool",
//         "Luxury Spa",
//         "Private Cinema",
//         "Biometric Security"
//       ];
//     } else if (is5StarSelected) {
//       // 5-Star Hotel Amenities
//       return [
//         "Luxury King Beds",
//         "High-Speed Wi-Fi",
//         "Smart TV",
//         "Mini Bar",
//         "Coffee Machine",
//         "Marble Bathroom",
//         "Rain Shower & Bathtub",
//         "Premium Toiletries",
//         "24-Hour Room Dining",
//         "Multiple Restaurants",
//         "Swimming Pool",
//         "Spa & Wellness Center",
//         "Fitness Center",
//         "Concierge Service",
//         "Valet Parking",
//         "Business Center"
//       ];
//     } else if (is3StarSelected) {
//       // 3-Star Hotel Amenities
//       return [
//         "Air Conditioning",
//         "Free Wi-Fi",
//         "TV with Cable",
//         "Comfortable Bed",
//         "Attached Bathroom",
//         "Hot & Cold Water",
//         "Basic Toiletries",
//         "Restaurant",
//         "Complimentary Breakfast",
//         "24-Hour Front Desk",
//         "Daily Housekeeping",
//         "Parking",
//         "Laundry Service",
//         "CCTV Security",
//         "Elevator",
//         "Power Backup"
//       ];
//     } else {
//       // Default amenities
//       // return [
//       //   "Wi-Fi",
//       //   "Swimming pool",
//       //   "Jacuzzi",
//       //   "Private Pool",
//       //   "Bathtub",
//       //   "Balcony"
//       return [
//         // Room Amenities
//         "Air Conditioning",
//         "Free Wi-Fi",
//         "Flat-screen TV / Cable TV",
//         "Comfortable Bed & Linen",
//         "Wardrobe / Closet",
//         "Work Desk & Chair",
//         "Telephone",
//         "Mini Fridge",
//         "Electric Kettle / Tea & Coffee Maker",
//         "Room Service",
//         "Safe Locker",
//         "Balcony (selected rooms)",
//
//         // Bathroom Amenities
//         "Attached Bathroom",
//         "Hot & Cold Water",
//         "Towels",
//         "Free Toiletries",
//         "Hair Dryer",
//         "Shower / Bathtub",
//         "Mirror",
//         "Slippers",
//
//         // Food & Dining
//         "In-house Restaurant",
//         "Complimentary Breakfast",
//         "Room Dining",
//         "Bar / Lounge",
//         "Café",
//         "Special Diet Meals (on request)",
//
//         // Hotel Services
//         "24-Hour Front Desk",
//         "Daily Housekeeping",
//         "Laundry Service",
//         "Luggage Storage",
//         "Wake-up Call",
//         "Concierge Service",
//         "Travel Desk / Tour Assistance",
//
//         // Parking & Transport
//         "Free Parking",
//         "Paid Parking",
//         "Airport Shuttle (Paid/Free)",
//         "Taxi Service",
//         "Car Rental Assistance",
//
//         // Leisure & Wellness
//         "Swimming Pool",
//         "Fitness Center / Gym",
//         "Spa & Massage",
//         "Sauna / Steam Room",
//         "Garden / Terrace",
//         "Kids Play Area",
//
//         // Business & Events
//         "Business Center",
//         "Meeting / Conference Hall",
//         "Banquet Hall",
//         "Printer / Photocopier",
//         "High-speed Internet",
//
//         // Accessibility & Safety
//         "Wheelchair Accessible",
//         "Elevator / Lift",
//         "CCTV Surveillance",
//         "Fire Extinguishers",
//         "Smoke Detectors",
//         "Security Staff",
//         "First Aid Kit",
//
//         // Other Facilities
//         "Family Rooms",
//         "Non-Smoking Rooms",
//         "Pet-Friendly (on request)",
//         "Smoking Area",
//
//         // Common Filters for Booking Apps
//         "Free Breakfast",
//         "AC Rooms",
//         "Parking Available",
//         "Swimming Pool",
//         "Couple-Friendly"
//       ];
//     }
//   }
//
//   // Method to get the selected star rating text
//   String? _getSelectedStarRatingText() {
//     if (_selectedFilters["3 star hotel"] ?? false) return "3 star hotel";
//     if (_selectedFilters["5 star hotel"] ?? false) return "5 star hotel";
//     if (_selectedFilters["7 star hotel"] ?? false) return "7 star hotel";
//     return null;
//   }
//
//   void _openAllFiltersSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24),
//             ),
//           ),
//           child: DraggableScrollableSheet(
//             expand: false,
//             initialChildSize: 0.9,
//             maxChildSize: 0.95,
//             minChildSize: 0.5,
//             builder: (context, scrollController) {
//               return StatefulBuilder(
//                 builder: (context, setStateSB) {
//                   // Rebuild room amenities whenever state changes
//                   final roomAmenities = _getCurrentRoomAmenities();
//                   final selectedStarRating = _getSelectedStarRatingText();
//
//                   return Column(
//                     children: [
//                       // Drag handle
//                       Center(
//                         child: Container(
//                           width: 50,
//                           height: 5,
//                           margin: EdgeInsets.only(top: 12, bottom: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[400],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//
//                       // Header
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "All Filters",
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.grey[900],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => Navigator.pop(context),
//                               child: Container(
//                                 width: 36,
//                                 height: 36,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.close,
//                                   size: 20,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       SizedBox(height: 16),
//
//                       Expanded(
//                         child: SingleChildScrollView(
//                           controller: scrollController,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             children: [
//                               // All filter boxes
//                               _buildFilterSection("PRICE PER NIGHT",
//                                   ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"], setStateSB),
//                               SizedBox(height: 12),
//
//                               // Star Rating section - this affects room amenities
//                               _buildFilterSection("STAR RATING",
//                                   ["1 star hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel", "8 star hotel", "9 star hotel", "10 star hotel"],
//                                   setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("MEALS OPTION",
//                                   ["Breakfast Included", "Lunch Included", "Dinner Included", "Tea/Coffee & Snacks Included"],
//                                   setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("CANCELLATION POLICY",
//                                   ["Free Cancellation", "Cancellation Penalty"], setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("PROPERTY TYPE",
//                                   ["Hotel", "Apartment", "Villa", "Homestay", "Resort", "Beach Resort", "Farming Resort", "Forest Resort"],
//                                   setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("PREVIOUSLY USED",
//                                   ["Beach", "Breakfast+Lunch/Dinner included", "5 star hotel"], setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("EXCLUSIVE DEALS",
//                                   ["Normal deals", "Last minute deals", "Rush deals"], setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("ROOM VIEWS",
//                                   ["Garden view", "City view", "Beach view", "Farming view", "Forest view"],
//                                   setStateSB),
//                               SizedBox(height: 12),
//
//                               // Room Amenities section - dynamic based on star rating
//                               _buildDynamicRoomAmenitiesSection(roomAmenities, selectedStarRating, setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("OTHER POPULAR AMENITIES",
//                                   ["Wi-Fi", "Swimming pool", "Spa", "Cafe"], setStateSB),
//                               SizedBox(height: 12),
//
//                               _buildFilterSection("HOTEL RULES",
//                                   ["Pets allowed", "Allow unmarried couples"], setStateSB),
//
//                               SizedBox(height: 30),
//
//                               // Apply Button
//                               Container(
//                                 width: double.infinity,
//                                 height: 54,
//                                 margin: EdgeInsets.symmetric(horizontal: 4),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFFF7043),
//                                   borderRadius: BorderRadius.circular(14),
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                     },
//                                     borderRadius: BorderRadius.circular(14),
//                                     child: Center(
//                                       child: Text(
//                                         "APPLY ALL FILTERS",
//                                         style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                               SizedBox(height: 30),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//
//
//   Widget _buildDynamicRoomAmenitiesSection(List<String> amenities, String? selectedStarRating, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == "ROOM AMENITIES";
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title header
//           GestureDetector(
//             onTap: () {
//               setStateSB(() {
//                 if (_expandedFilter == "ROOM AMENITIES") {
//                   _expandedFilter = null;
//                 } else {
//                   _expandedFilter = "ROOM AMENITIES";
//                 }
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "ROOM AMENITIES",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           selectedStarRating != null
//                               ? "Showing ${selectedStarRating} amenities"
//                               : "Default star rating",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: selectedStarRating != null ? Color(0xFFFF7043) : Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Options when expanded
//           if (isExpanded)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Show a note about star rating
//                   if (selectedStarRating != null)
//                     // Container(
//                     //   margin: EdgeInsets.only(bottom: 12),
//                     //   padding: EdgeInsets.all(12),
//                     //   decoration: BoxDecoration(
//                     //     color: Color(0xFFFF7043).withOpacity(0.1),
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       Icon(Icons.star, size: 18, color: Color(0xFFFF7043)),
//                     //       SizedBox(width: 8),
//                     //       Expanded(
//                     //         child: Text(
//                     //           "Amenities for $selectedStarRating",
//                     //           style: TextStyle(
//                     //             fontSize: 13,
//                     //             fontWeight: FontWeight.w600,
//                     //             color: Color(0xFFFF7043),
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//
//                   ...amenities.map((option) {
//                     return Container(
//                       margin: EdgeInsets.symmetric(vertical: 6),
//                       child: Row(
//                         children: [
//                           Checkbox(
//                             value: _selectedFilters[option] ?? false,
//                             onChanged: (val) {
//                               setStateSB(() {
//                                 _selectedFilters[option] = val ?? false;
//                               });
//                             },
//                             activeColor: Color(0xFFFF7043),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               option,
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterSection(String title, List<String> options, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == title;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title header
//           GestureDetector(
//             onTap: () {
//               setStateSB(() {
//                 if (_expandedFilter == title) {
//                   _expandedFilter = null;
//                 } else {
//                   _expandedFilter = title;
//                 }
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Options when expanded
//           if (isExpanded)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 children: options.map((option) {
//                   return Container(
//                     margin: EdgeInsets.symmetric(vertical: 6),
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           value: _selectedFilters[option] ?? false,
//                           onChanged: (val) {
//                             setStateSB(() {
//                               _selectedFilters[option] = val ?? false;
//                               // Force rebuild when star rating changes
//                               if (title == "STAR RATING" && (option == "3 star hotel" || option == "5 star hotel" || option == "7 star hotel")) {
//                                 setStateSB(() {});
//                               }
//                             });
//                           },
//                           activeColor: Color(0xFFFF7043),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             option,
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//
//
//   void _openSingleCategory(BuildContext context, String title, List<String> options) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateSB) {
//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       margin: EdgeInsets.only(bottom: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//                   ...options.map((opt) => Container(
//                     margin: EdgeInsets.symmetric(vertical: 4),
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           value: _selectedFilters[opt] ?? false,
//                           onChanged: (val) {
//                             setStateSB(() {
//                               _selectedFilters[opt] = val ?? false;
//                             });
//                           },
//                           activeColor: Color(0xFFFF7043),
//                         ),
//                         Expanded(child: Text(opt)),
//                       ],
//                     ),
//                   )).toList(),
//
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFFFF7043),
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text("APPLY", style: TextStyle(color: Colors.white)),
//                     ),
//                   ),
//                   SizedBox(height: MediaQuery.of(context).padding.bottom),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildFilterChips() {
//     List<Map<String, dynamic>> filters = [
//       {"label": "All Filters", "icon": Icons.filter_list, "onTap": () => _openAllFiltersSheet(context)},
//       {"label": "Price", "icon": Icons.attach_money, "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"])},
//       {"label": "Rating", "icon": Icons.star, "onTap": () => _openSingleCategory(context, "STAR RATING", ["3 star hotel", "4 star hotel", "5 star hotel"])},
//       {"label": "Amenities", "icon": Icons.wifi, "onTap": () => _openSingleCategory(context, "AMENITIES", ["Wi-Fi", "Swimming Pool", "Spa", "Gym", "Parking"])},
//       {"label": "Distance", "icon": Icons.location_on, "onTap": () => _openSingleCategory(context, "DISTANCE", ["0-2 km", "2-5 km", "5-10 km", "10+ km"])},
//     ];
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: filters.map((filter) {
//           return Container(
//             margin: EdgeInsets.only(right: 10),
//             child: FilterChip(
//               label: Text(filter["label"]),
//               avatar: Icon(filter["icon"], size: 18),
//               onSelected: (_) => filter["onTap"](),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: Column(
//         children: [
//           _buildHeader(),
//           Expanded(
//             child: AnimatedSwitcher(
//               duration: Duration(milliseconds: 500),
//               child: _showResults
//                   ? Align(
//                 alignment: Alignment.topCenter,
//                 child: _buildHotelResults(),
//               )
//                   : _buildSearchForm(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).padding.top + 20,
//         left: 24,
//         right: 24,
//         bottom: 30,
//       ),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.orange.withOpacity(0.3),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.hotel, color: Colors.white, size: 28),
//               SizedBox(width: 10),
//               Text(
//                 "WanderStay",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Spacer(),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Discover your perfect stay with exclusive deals ✨",
//             style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchForm() {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.fromLTRB(
//               20,
//               20,
//               20,
//               20 + MediaQuery.of(context).padding.bottom,
//             ),
//             child: Column(
//               children: [
//                 _buildOffersCarousel(),
//                 SizedBox(height: 30),
//                 _buildSearchField(),
//                 SizedBox(height: 20),
//                 _buildDateSelection(),
//                 SizedBox(height: 20),
//                 _buildCounters(),
//                 SizedBox(height: 20),
//                 _buildPurposeSelection(),
//                 SizedBox(height: 30),
//                 _buildSearchButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOffersCarousel() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "🔥 Exclusive Offers",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[800],
//           ),
//         ),
//         SizedBox(height: 15),
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 140,
//             enlargeCenterPage: true,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             viewportFraction: 0.60,
//           ),
//           items: [1, 2, 3].map((i) => _buildOfferCard(i)).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOfferCard(int index) {
//     List<Map<String, dynamic>> offers = [
//       {
//         "title": "Weekend Getaway",
//         "subtitle": "Up to 40% off on luxury stays",
//         "color": Colors.orange,
//         "icon": Icons.weekend
//       },
//       {
//         "title": "Long Stay Discount",
//         "subtitle": "Special rates for 7+ nights",
//         "color": Colors.purple,
//         "icon": Icons.calendar_today
//       },
//       {
//         "title": "Early Bird Special",
//         "subtitle": "Book 30 days in advance & save",
//         "color": Colors.blue,
//         "icon": Icons.alarm
//       },
//     ];
//
//     var offer = offers[index - 1];
//
//     return Container(
//       height: 140,
//       margin: EdgeInsets.symmetric(horizontal: 4),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [offer["color"], offer["color"].withOpacity(0.8)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: offer["color"].withOpacity(0.3),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: -20,
//             top: -20,
//             child: Icon(
//               offer["icon"],
//               size: 80,
//               color: Colors.white.withOpacity(0.1),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 offer["title"],
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 offer["subtitle"],
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.white.withOpacity(0.9),
//                 ),
//               ),
//               SizedBox(height: 15),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   "Book Now",
//                   style: TextStyle(color: Colors.white, fontSize: 15),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Where do you want to stay?",
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           prefixIcon: Icon(Icons.search, color: Color(0xFFFF7043)),
//           contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateSelection() {
//     return Row(
//       children: [
//         Expanded(child: _buildDateCard("Check-in", _checkInDate, true)),
//         SizedBox(width: 12),
//         Expanded(child: _buildDateCard("Check-out", _checkOutDate, false)),
//       ],
//     );
//   }
//
//   Widget _buildDateCard(String label, DateTime? date, bool isCheckIn) {
//     return GestureDetector(
//       onTap: () => _selectDate(isCheckIn),
//       child: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 18, color: Color(0xFFFF7043)),
//                 SizedBox(width: 8),
//                 Text(
//                   label,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               date != null ? DateFormat('MMM dd, yyyy').format(date) : "Select date",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCounters() {
//     return Column(
//       children: [
//         _buildCounter("Rooms", _roomCount, 1, 5,
//                 () => setState(() => _roomCount--), () => setState(() => _roomCount++)),
//         _buildCounter("Adults", _adultCount, 1, 10,
//                 () => setState(() => _adultCount--), () => setState(() => _adultCount++)),
//         _buildCounter("Children", _childCount, 0, 5,
//                 () => setState(() => _childCount--), () => setState(() => _childCount++)),
//       ],
//     );
//   }
//
//   Widget _buildPurposeSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Purpose of stay",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey[800],
//           ),
//         ),
//         SizedBox(height: 12),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: _purposeOptions.map((purpose) {
//             final isSelected = _selectedPurpose == purpose;
//             return AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               child: FilterChip(
//                 label: Text(purpose),
//                 selected: isSelected,
//                 selectedColor: Color(0xFFFF7043),
//                 checkmarkColor: Colors.white,
//                 labelStyle: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey[700],
//                   fontWeight: FontWeight.w500,
//                 ),
//                 onSelected: (_) => setState(() => _selectedPurpose = purpose),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSearchButton() {
//     return Container(
//       width: double.infinity,
//       height: 60,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.orange.withOpacity(0.4),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             setState(() {
//               _showResults = true;
//               _animationController.reset();
//               _animationController.forward();
//             });
//           },
//           borderRadius: BorderRadius.circular(15),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search, color: Colors.white, size: 20),
//                 SizedBox(width: 10),
//                 Text(
//                   "SEARCH HOTELS",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildHotelResults() {
//   //   return Align(
//   //     alignment: Alignment.topCenter,
//   //     child: FadeTransition(
//   //       opacity: _fadeAnimation,
//   //       child: SlideTransition(
//   //         position: _slideAnimation,
//   //         child: SingleChildScrollView(
//   //           padding: EdgeInsets.all(20),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //
//   //               _buildFilterChips(),
//   //               SizedBox(height: 20),
//   //
//   //               Row(
//   //                 children: [
//   //                   Text(
//   //                     "🏨 Popular in Chennai",
//   //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   //                   ),
//   //                   Spacer(),
//   //                   Text(
//   //                     "${_hotels.length} properties",
//   //                     style: TextStyle(color: Colors.grey[600]),
//   //                   ),
//   //                 ],
//   //               ),
//   //               SizedBox(height: 5),
//   //               Text(
//   //                 "Based on your preferences",
//   //                 style: TextStyle(color: Colors.grey[600]),
//   //               ),
//   //               SizedBox(height: 20),
//   //               Column(
//   //                 children: _hotels.asMap().entries.map((entry) {
//   //                   final index = entry.key;
//   //                   final hotel = entry.value;
//   //                   return AnimatedContainer(
//   //                     duration: Duration(milliseconds: 300 + (index * 100)),
//   //                     margin: EdgeInsets.only(bottom: 16),
//   //                     child: _hotelCard(hotel, index),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Widget _hotelCard(Map<String, dynamic> hotel, int index) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: hotel)),
//   //       );
//   //     },
//   //     child: Card(
//   //       elevation: 4,
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//   //       child: Container(
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(20),
//   //           color: Colors.white,
//   //         ),
//   //         child: Column(
//   //           children: [
//   //             Stack(
//   //               children: [
//   //                 ClipRRect(
//   //                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//   //                   child: Image.asset(
//   //                     hotel["image"],
//   //                     height: 180,
//   //                     width: double.infinity,
//   //                     fit: BoxFit.cover,
//   //                   ),
//   //                 ),
//   //                 Positioned(
//   //                   top: 12,
//   //                   left: 12,
//   //                   child: Container(
//   //                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.red,
//   //                       borderRadius: BorderRadius.circular(8),
//   //                     ),
//   //                     child: Text(
//   //                       hotel["discount"],
//   //                       style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 Positioned(
//   //                   top: 12,
//   //                   right: 12,
//   //                   child: CircleAvatar(
//   //                     backgroundColor: Colors.white.withOpacity(0.9),
//   //                     child: Icon(Icons.favorite_border, color: Colors.red, size: 20),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //             Padding(
//   //               padding: EdgeInsets.all(16),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Row(
//   //                     children: [
//   //                       Expanded(
//   //                         child: Text(
//   //                           hotel["name"],
//   //                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//   //                         ),
//   //                       ),
//   //                       Row(
//   //                         children: [
//   //                           Icon(Icons.star, color: Colors.orange, size: 18),
//   //                           SizedBox(width: 4),
//   //                           Text(
//   //                             hotel["rating"].toString(),
//   //                             style: TextStyle(fontWeight: FontWeight.bold),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                   Row(
//   //                     children: [
//   //                       Icon(Icons.location_on, size: 14, color: Colors.grey),
//   //                       SizedBox(width: 4),
//   //                       Text(
//   //                         hotel["location"],
//   //                         style: TextStyle(color: Colors.grey, fontSize: 14),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   SizedBox(height: 8),
//   //                   Text(
//   //                     hotel["distance"],
//   //                     style: TextStyle(color: Colors.grey[600], fontSize: 13),
//   //                   ),
//   //                   SizedBox(height: 12),
//   //                   Wrap(
//   //                     spacing: 8,
//   //                     runSpacing: 8,
//   //                     children: (hotel["tags"] as List<String>).take(3).map((tag) => Container(
//   //                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//   //                       decoration: BoxDecoration(
//   //                         color: Colors.blue[50],
//   //                         borderRadius: BorderRadius.circular(12),
//   //                       ),
//   //                       child: Text(
//   //                         tag,
//   //                         style: TextStyle(color: Colors.blue[700], fontSize: 12),
//   //                       ),
//   //                     )).toList(),
//   //                   ),
//   //                   SizedBox(height: 12),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         hotel["price"],
//   //                         style: TextStyle(
//   //                           fontSize: 22,
//   //                           fontWeight: FontWeight.bold,
//   //                           color: Color(0xFFFF7043),
//   //                         ),
//   //                       ),
//   //                       Text("/night", style: TextStyle(color: Colors.grey)),
//   //                       Spacer(),
//   //                       Text("${hotel["reviews"]} reviews", style: TextStyle(color: Colors.grey)),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildHotelResults() {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 _buildFilterChips(),
//                 SizedBox(height: 20),
//
//                 Row(
//                   children: [
//                     Text(
//                       "🏨 Popular in Chennai",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Spacer(),
//                     Text(
//                       "${_hotels.length} properties",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Mixed star ratings: 3-star, 5-star & 7-star hotels",
//                   style: TextStyle(color: Colors.grey[600], fontSize: 13),
//                 ),
//                 SizedBox(height: 20),
//                 Column(
//                   children: _hotels.asMap().entries.map((entry) {
//                     final index = entry.key;
//                     final hotel = entry.value;
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 300 + (index * 100)),
//                       margin: EdgeInsets.only(bottom: 16),
//                       child: _hotelCard(hotel, index),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _hotelCard(Map<String, dynamic> hotel, int index) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: hotel)),
//         );
//       },
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white,
//           ),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                     child: Image.asset(
//                       hotel["image"],
//                       height: 180,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     top: 12,
//                     left: 12,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         hotel["discount"],
//                         style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 12,
//                     right: 12,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white.withOpacity(0.9),
//                       child: Icon(Icons.favorite_border, color: Colors.red, size: 20),
//                     ),
//                   ),
//                   // Star rating badge
//                   Positioned(
//                     bottom: 12,
//                     left: 12,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.star, size: 14, color: Colors.white),
//                           SizedBox(width: 4),
//                           Text(
//                             hotel["star"] ?? "Hotel",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             hotel["name"],
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.orange, size: 18),
//                             SizedBox(width: 4),
//                             Text(
//                               hotel["rating"].toString(),
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, size: 14, color: Colors.grey),
//                         SizedBox(width: 4),
//                         Text(
//                           hotel["location"],
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       hotel["distance"],
//                       style: TextStyle(color: Colors.grey[600], fontSize: 13),
//                     ),
//                     SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: (hotel["tags"] as List<String>).take(3).map((tag) => Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           tag,
//                           style: TextStyle(color: Colors.blue[700], fontSize: 12),
//                         ),
//                       )).toList(),
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Text(
//                           hotel["price"],
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFFFF7043),
//                           ),
//                         ),
//                         Text("/night", style: TextStyle(color: Colors.grey)),
//                         Spacer(),
//                         Text("${hotel["reviews"]} reviews", style: TextStyle(color: Colors.grey)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FoodCourtScreen extends StatelessWidget {
//   const FoodCourtScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Food Court"),
//         backgroundColor: Color(0xFFFF7043),
//       ),
//       body: Center(
//         child: Text("Food Court Content"),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'hotel_details_screen.dart';


class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({super.key});

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen>
    with SingleTickerProviderStateMixin {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _roomCount = 1;
  int _adultCount = 1;
  int _childCount = 0;
  String? _selectedPurpose;
  Map<String, bool> _selectedFilters = {};
  bool _showResults = false;
  String? _expandedFilter;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> _purposeOptions = ['Work', 'Special Occasion', 'Transit', 'Holiday'];

  final List<String> _singleSelectSections = [
    "PRICE PER NIGHT",
    "STAR RATING",
    "CANCELLATION POLICY",
    "PROPERTY TYPE",
    "EXCLUSIVE DEALS",
    "ROOM VIEWS"
  ];

  final List<Map<String, dynamic>> _hotels = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "10% Off",
      "name": "Hotel Paradise",
      "location": "Chennai Central",
      "price": "\$200",
      "rating": 4.8,
      "star": "5 star hotel",
      "stars": 5,
      "starRating": 5,
      "reviews": 1247,
      "distance": "2.3 km from center",
      "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
      "description": "Luxury 5-star hotel with premium amenities and excellent service in the heart of Chennai.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "15% Off",
      "name": "Grand Residency",
      "location": "T. Nagar",
      "price": "\$120",
      "rating": 4.6,
      "star": "3 star hotel",
      "stars": 3,
      "starRating": 3,
      "reviews": 892,
      "distance": "1.8 km from center",
      "tags": ["Free Parking", "Gym", "Restaurant"],
      "description": "Comfortable 3-star stay with modern amenities in Chennai's prime shopping district.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
    },
    {
      "image": "assets/images/img7.jpg",
      "discount": "20% Off",
      "name": "Sea View Resort",
      "location": "Marina Beach",
      "price": "\$350",
      "rating": 4.9,
      "star": "7 star hotel",
      "stars": 7,
      "starRating": 7,
      "reviews": 1563,
      "distance": "0.5 km from beach",
      "tags": ["Beach Front", "Luxury", "All Inclusive"],
      "description": "Beachfront luxury 7-star resort offering breathtaking views and premium services.",
      "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"]
    },
    {
      "image": "assets/images/img5.jpg",
      "discount": "25% Off",
      "name": "Royal Palace Hotel",
      "location": "Anna Nagar",
      "price": "\$280",
      "rating": 4.7,
      "star": "5 star hotel",
      "stars": 5,
      "starRating": 5,
      "reviews": 1050,
      "distance": "3.1 km from center",
      "tags": ["Luxury Spa", "Fine Dining", "Rooftop Pool"],
      "description": "Opulent 5-star hotel with royal treatment and world-class amenities.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "30% Off",
      "name": "Budget Stay Inn",
      "location": "Koyambedu",
      "price": "\$80",
      "rating": 4.2,
      "star": "3 star hotel",
      "stars": 3,
      "starRating": 3,
      "reviews": 650,
      "distance": "4.5 km from center",
      "tags": ["Budget Friendly", "Free Breakfast", "Airport Shuttle"],
      "description": "Affordable 3-star hotel with essential amenities for comfortable stay.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? (_checkInDate ?? DateTime.now())
          : (_checkOutDate ?? (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
            _checkOutDate = picked.add(const Duration(days: 1));
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  Widget _buildCounter(String label, int value, int min, int max, Function onMinus, Function onPlus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
          Row(
            children: [
              _buildIconButton(
                icon: Icons.remove,
                onPressed: value > min ? () => onMinus() : null,
                isEnabled: value > min,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  "$value",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFFFF7043),
                  ),
                ),
              ),
              _buildIconButton(
                icon: Icons.add,
                onPressed: value < max ? () => onPlus() : null,
                isEnabled: value < max,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isEnabled,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isEnabled ? Color(0xFFFF7043) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 15),
        color: Colors.white,
        onPressed: onPressed,
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints(),
      ),
    );
  }

  List<String> _getCurrentRoomAmenities() {

    final bool is3StarSelected = _selectedFilters["3 star hotel"] ?? false;
    final bool is5StarSelected = _selectedFilters["5 star hotel"] ?? false;
    final bool is7StarSelected = _selectedFilters["7 star hotel"] ?? false;

    if (is7StarSelected) {

      return [
        "Private Butler Service",
        "Smart Room Automation",
        "Panoramic Views",
        "Gold-Plated Bathrooms",
        "Private Jacuzzi",
        "Michelin-Star Restaurants",
        "Personal Chef",
        "Helicopter Transfers",
        "Infinity Pool",
        "Luxury Spa",
        "Private Cinema",
        "Biometric Security"
      ];
    } else if (is5StarSelected) {

      return [
        "Luxury King Beds",
        "High-Speed Wi-Fi",
        "Smart TV",
        "Mini Bar",
        "Coffee Machine",
        "Marble Bathroom",
        "Rain Shower & Bathtub",
        "Premium Toiletries",
        "24-Hour Room Dining",
        "Multiple Restaurants",
        "Swimming Pool",
        "Spa & Wellness Center",
        "Fitness Center",
        "Concierge Service",
        "Valet Parking",
        "Business Center"
      ];
    } else if (is3StarSelected) {

      return [
        "Air Conditioning",
        "Free Wi-Fi",
        "TV with Cable",
        "Comfortable Bed",
        "Attached Bathroom",
        "Hot & Cold Water",
        "Basic Toiletries",
        "Restaurant",
        "Complimentary Breakfast",
        "24-Hour Front Desk",
        "Daily Housekeeping",
        "Parking",
        "Laundry Service",
        "CCTV Security",
        "Elevator",
        "Power Backup"
      ];
    } else {

      return [
        "Air Conditioning",
        "Free Wi-Fi",
        "Flat-screen TV / Cable TV",
        "Comfortable Bed & Linen",
        "Attached Bathroom",
        "Hot & Cold Water",
        "Towels",
        "Free Toiletries",
        "24-Hour Front Desk",
        "Daily Housekeeping",
        "Restaurant",
        "Parking",
      ];
    }
  }


  void _openAllFiltersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return StatefulBuilder(
                builder: (context, setStateSB) {
                  final roomAmenities = _getCurrentRoomAmenities();
                  final selectedStarRating = _getSelectedStarRatingText();

                  return Column(
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: EdgeInsets.only(top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Filters",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [

                              _buildFilterSection("PRICE PER NIGHT",
                                  ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"], setStateSB),
                              SizedBox(height: 12),


                              _buildMealsFilterSection("MEALS OPTION",
                                  [
                                    "All meals with Tea/Coffee & Snacks included",
                                    "Breakfast Included",
                                    "Lunch Included",
                                    "Dinner Included",
                                    "Tea/Coffee & Snacks Included"
                                  ],
                                  setStateSB),
                              SizedBox(height: 12),


                              _buildPropertyTypeSection("PROPERTY TYPE",
                                  ["Hotel", "Service Apartment", "Villa", "Homestay", "Resort"],
                                  setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("STAR RATING",
                                  ["1 star hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel", "8 star hotel", "9 star hotel", "10 star hotel"],
                                  setStateSB),
                              SizedBox(height: 12),


                              _buildDynamicRoomAmenitiesSection(roomAmenities, selectedStarRating, setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("OTHER POPULAR AMENITIES",
                                  ["Wi-Fi", "Swimming pool", "Spa", "Cafe", "Restaurant", "Gym", "Parking", "Airport Shuttle"], setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("ROOM VIEWS",
                                  ["Garden view", "City view", "Beach view", "Farming view", "Forest view"],
                                  setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("EXCLUSIVE DEALS",
                                  ["Normal deals", "Last minute deals", "Rush deals"], setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("CANCELLATION POLICY",
                                  ["Free Cancellation", "Cancellation With Penalty"], setStateSB),
                              SizedBox(height: 12),


                              _buildHotelRulesSection("HOTEL RULES", setStateSB),
                              SizedBox(height: 12),


                              _buildFilterSection("PREVIOUSLY USED",
                                  ["Beach", "Breakfast+Lunch/Dinner included", "5 star hotel"], setStateSB),
                              SizedBox(height: 12),

                              SizedBox(height: 30),

                              Container(
                                width: double.infinity,
                                height: 54,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF7043),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: Center(
                                      child: Text(
                                        "APPLY ALL FILTERS",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
  String? _getSelectedStarRatingText() {
    if (_selectedFilters["3 star hotel"] ?? false) return "3 star hotel";
    if (_selectedFilters["5 star hotel"] ?? false) return "5 star hotel";
    if (_selectedFilters["7 star hotel"] ?? false) return "7 star hotel";
    return null;
  }

  Widget _buildDynamicRoomAmenitiesSection(List<String> amenities, String? selectedStarRating, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == "ROOM AMENITIES";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setStateSB(() {
                if (_expandedFilter == "ROOM AMENITIES") {
                  _expandedFilter = null;
                } else {
                  _expandedFilter = "ROOM AMENITIES";
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ROOM AMENITIES",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          selectedStarRating != null
                              ? "Showing ${selectedStarRating} amenities"
                              : "Default amenities",
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedStarRating != null ? Color(0xFFFF7043) : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...amenities.map((option) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _selectedFilters[option] ?? false,
                            onChanged: (val) {
                              setStateSB(() {
                                _selectedFilters[option] = val ?? false;
                              });
                            },
                            activeColor: Color(0xFFFF7043),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
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
        ],
      ),
    );
  }

  Widget _buildPropertyTypeSection(String title, List<String> options, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;

    final List<String> allPropertyOptions = [
      "Hotel", "Service Apartment", "Villa", "Homestay", "Resort",
      "Beach Resort", "Farming Resort", "Forest Resort"
    ];


    String? selectedOption;
    for (var option in allPropertyOptions) {
      if (_selectedFilters[option] == true) {
        selectedOption = option;
        break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setStateSB(() {
                if (_expandedFilter == title) {
                  _expandedFilter = null;
                } else {
                  _expandedFilter = title;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                children: [

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Hotel",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setStateSB(() {

                              for (var opt in allPropertyOptions) {
                                _selectedFilters[opt] = false;
                              }

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                        ),
                        Expanded(
                          child: Text(
                            "Hotel",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Service Apartment",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setStateSB(() {

                              for (var opt in allPropertyOptions) {
                                _selectedFilters[opt] = false;
                              }

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                        ),
                        Expanded(
                          child: Text(
                            "Service Apartment",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Villa",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setStateSB(() {

                              for (var opt in allPropertyOptions) {
                                _selectedFilters[opt] = false;
                              }

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                        ),
                        Expanded(
                          child: Text(
                            "Villa",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Homestay",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setStateSB(() {

                              for (var opt in allPropertyOptions) {
                                _selectedFilters[opt] = false;
                              }

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                        ),
                        Expanded(
                          child: Text(
                            "Homestay",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Resort",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setStateSB(() {

                              for (var opt in allPropertyOptions) {
                                _selectedFilters[opt] = false;
                              }

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                        ),
                        Expanded(
                          child: Text(
                            "Resort",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  if (selectedOption == "Resort" ||
                      selectedOption == "Beach Resort" ||
                      selectedOption == "Farming Resort" ||
                      selectedOption == "Forest Resort")
                    Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Beach Resort",
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setStateSB(() {

                                      for (var opt in allPropertyOptions) {
                                        _selectedFilters[opt] = false;
                                      }

                                      _selectedFilters[value!] = true;
                                    });
                                  },
                                  activeColor: Color(0xFFFF7043),
                                ),
                                Expanded(
                                  child: Text(
                                    "Beach Resort",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Farming Resort",
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setStateSB(() {

                                      for (var opt in allPropertyOptions) {
                                        _selectedFilters[opt] = false;
                                      }

                                      _selectedFilters[value!] = true;
                                    });
                                  },
                                  activeColor: Color(0xFFFF7043),
                                ),
                                Expanded(
                                  child: Text(
                                    "Farming Resort",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Forest Resort",
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setStateSB(() {

                                      for (var opt in allPropertyOptions) {
                                        _selectedFilters[opt] = false;
                                      }

                                      _selectedFilters[value!] = true;
                                    });
                                  },
                                  activeColor: Color(0xFFFF7043),
                                ),
                                Expanded(
                                  child: Text(
                                    "Forest Resort",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
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
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;
    final bool isSingleSelect = _singleSelectSections.contains(title);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setStateSB(() {
                if (_expandedFilter == title) {
                  _expandedFilter = null;
                } else {
                  _expandedFilter = title;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                children: options.map((option) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [

                        if (isSingleSelect)
                          Radio(
                            value: option,
                            groupValue: _getSelectedOptionForSingleSelect(title),
                            onChanged: (selectedValue) {
                              setStateSB(() {

                                for (var opt in options) {
                                  _selectedFilters[opt] = false;
                                }

                                _selectedFilters[selectedValue as String] = true;
                              });
                            },
                            activeColor: Color(0xFFFF7043),
                          )
                        else

                          Checkbox(
                            value: _selectedFilters[option] ?? false,
                            onChanged: (val) {
                              setStateSB(() {
                                _selectedFilters[option] = val ?? false;
                              });
                            },
                            activeColor: Color(0xFFFF7043),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
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
    );
  }



  String? _getSelectedOptionForSingleSelect(String title) {

    if (title == "PRICE PER NIGHT") {
      final List<String> priceOptions = ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"];
      for (var option in priceOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "STAR RATING") {
      final List<String> starOptions = ["1 star hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel", "8 star hotel", "9 star hotel", "10 star hotel"];
      for (var option in starOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "CANCELLATION POLICY") {
      final List<String> cancelOptions = ["Free Cancellation", "Cancellation With Penalty"];
      for (var option in cancelOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "PROPERTY TYPE") {

      final List<String> propertyOptions = [
        "Hotel", "Service Apartment", "Villa", "Homestay", "Resort",
        "Beach Resort", "Farming Resort", "Forest Resort"
      ];
      for (var option in propertyOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "EXCLUSIVE DEALS") {
      final List<String> dealOptions = ["Normal deals", "Last minute deals", "Rush deals"];
      for (var option in dealOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "ROOM VIEWS") {
      final List<String> viewOptions = ["Garden view", "City view", "Beach view", "Farming view", "Forest view"];
      for (var option in viewOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "HOTEL RULES") {
      // Check rule options (only one per rule type should be selected)
      final List<String> ruleOptions = [
        "Pets allowed", "Pets not allowed",
        "Smoking allowed", "Smoking not allowed",
        "Outside food allowed", "No outside food"
      ];
      for (var option in ruleOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    }
    return null;
  }

  void _openSingleCategory(BuildContext context, String title, List<String> options) {
    final bool isSingleSelect = _singleSelectSections.contains(title);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            String? selectedOption = _getSelectedOptionForSingleSelect(title);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...options.map((opt) => Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        if (isSingleSelect)
                          Radio(
                            value: opt,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setStateSB(() {
                                selectedOption = value as String;
                              });
                            },
                            activeColor: Color(0xFFFF7043),
                          )
                        else
                          Checkbox(
                            value: _selectedFilters[opt] ?? false,
                            onChanged: (val) {
                              setStateSB(() {
                                _selectedFilters[opt] = val ?? false;
                              });
                            },
                            activeColor: Color(0xFFFF7043),
                          ),
                        Expanded(child: Text(opt)),
                      ],
                    ),
                  )).toList(),

                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isSingleSelect && selectedOption != null) {

                          for (var opt in options) {
                            _selectedFilters[opt] = false;
                          }
                          _selectedFilters[selectedOption!] = true;
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF7043),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("APPLY", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChips() {
    List<Map<String, dynamic>> filters = [
      {"label": "All Filters", "icon": Icons.filter_list, "onTap": () => _openAllFiltersSheet(context)},
      {"label": "Price", "icon": Icons.attach_money, "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"])},
      {"label": "Rating", "icon": Icons.star, "onTap": () => _openSingleCategory(context, "STAR RATING", ["1 star hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel", "8 star hotel", "9 star hotel", "10 star hotel"])},
      {"label": "Amenities", "icon": Icons.wifi, "onTap": () => _openSingleCategory(context, "OTHER POPULAR AMENITIES", ["Wi-Fi", "Swimming pool", "Spa", "Cafe", "Restaurant", "Gym", "Parking", "Airport Shuttle"])},
      {"label": "Distance", "icon": Icons.location_on, "onTap": () => _openSingleCategory(context, "DISTANCE", ["0-2 km", "2-5 km", "5-10 km", "10+ km"])},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(filter["label"]),
              avatar: Icon(filter["icon"], size: 18),
              onSelected: (_) => filter["onTap"](),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMealsFilterSection(String title, List<String> options, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;
    final isAllMealsSelected = _selectedFilters["All meals with Tea/Coffee & Snacks included"] ?? false;


    final bool isMealsOption = title == "MEALS OPTION";

    final List<String> mealTypeOptions = [
      "Breakfast Included",
      "Lunch Included",
      "Dinner Included",
      "Tea/Coffee & Snacks Included"
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setStateSB(() {
                if (_expandedFilter == title) {
                  _expandedFilter = null;
                } else {
                  _expandedFilter = title;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                children: options.map((option) {

                  bool isDisabled = false;
                  if (isMealsOption && isAllMealsSelected) {

                    if (option != "All meals with Tea/Coffee & Snacks included") {
                      isDisabled = true;
                    }
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isDisabled ? false : (_selectedFilters[option] ?? false), // When disabled, always show as unchecked
                          onChanged: isDisabled ? null : (val) {
                            setStateSB(() {
                              if (isMealsOption && option == "All meals with Tea/Coffee & Snacks  included") {

                                _selectedFilters[option] = val ?? false;


                              } else {

                                _selectedFilters[option] = val ?? false;
                              }
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDisabled ? Colors.grey[400] : Colors.grey[700],
                            ),
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
    );
  }

  Widget _buildHotelRulesSection(String title, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;


    final String? selectedPets = _getSelectedRuleOption("pets");
    final String? selectedSmoking = _getSelectedRuleOption("smoking");
    final String? selectedOutsideFood = _getSelectedRuleOption("outside_food");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setStateSB(() {
                if (_expandedFilter == title) {
                  _expandedFilter = null;
                } else {
                  _expandedFilter = title;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pets Rule
                  Text(
                    "Pets",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Allowed"),
                          value: "Pets allowed",
                          groupValue: selectedPets,
                          onChanged: (value) {
                            setStateSB(() {
                              // Clear all pet options
                              _selectedFilters["Pets allowed"] = false;
                              _selectedFilters["Pets not allowed"] = false;
                              // Set selected option
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Not Allowed"),
                          value: "Pets not allowed",
                          groupValue: selectedPets,
                          onChanged: (value) {
                            setStateSB(() {

                              _selectedFilters["Pets allowed"] = false;
                              _selectedFilters["Pets not allowed"] = false;

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 20, color: Colors.grey[200]),


                  Text(
                    "Smoking",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Allowed"),
                          value: "Smoking allowed",
                          groupValue: selectedSmoking,
                          onChanged: (value) {
                            setStateSB(() {

                              _selectedFilters["Smoking allowed"] = false;
                              _selectedFilters["Smoking not allowed"] = false;

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Not Allowed"),
                          value: "Smoking not allowed",
                          groupValue: selectedSmoking,
                          onChanged: (value) {
                            setStateSB(() {

                              _selectedFilters["Smoking allowed"] = false;
                              _selectedFilters["Smoking not allowed"] = false;

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 20, color: Colors.grey[200]),


                  Text(
                    "Outside Food",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Allowed"),
                          value: "Outside food allowed",
                          groupValue: selectedOutsideFood,
                          onChanged: (value) {
                            setStateSB(() {

                              _selectedFilters["Outside food allowed"] = false;
                              _selectedFilters["No outside food"] = false;

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text("Not Allowed"),
                          value: "No outside food",
                          groupValue: selectedOutsideFood,
                          onChanged: (value) {
                            setStateSB(() {

                              _selectedFilters["Outside food allowed"] = false;
                              _selectedFilters["No outside food"] = false;

                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
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


  String? _getSelectedRuleOption(String ruleType) {
    switch (ruleType) {
      case "pets":
        if (_selectedFilters["Pets allowed"] == true) return "Pets allowed";
        if (_selectedFilters["Pets not allowed"] == true) return "Pets not allowed";
        return null;
      case "smoking":
        if (_selectedFilters["Smoking allowed"] == true) return "Smoking allowed";
        if (_selectedFilters["Smoking not allowed"] == true) return "Smoking not allowed";
        return null;
      case "outside_food":
        if (_selectedFilters["Outside food allowed"] == true) return "Outside food allowed";
        if (_selectedFilters["No outside food"] == true) return "No outside food";
        return null;
      default:
        return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _showResults
                  ? Align(
                alignment: Alignment.topCenter,
                child: _buildHotelResults(),
              )
                  : _buildSearchForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 24,
        right: 24,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hotel, color: Colors.white, size: 28),
              SizedBox(width: 10),
              Text(
                "WanderStay",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Discover your perfect stay with exclusive deals ✨",
            style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchForm() {
    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              20 + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                _buildOffersCarousel(),
                SizedBox(height: 30),
                _buildSearchField(),
                SizedBox(height: 20),
                _buildDateSelection(),
                SizedBox(height: 20),
                _buildCounters(),
                SizedBox(height: 20),
                _buildPurposeSelection(),
                SizedBox(height: 30),
                _buildSearchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffersCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🔥 Exclusive Offers",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(
            height: 140,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 0.60,
          ),
          items: [1, 2, 3].map((i) => _buildOfferCard(i)).toList(),
        ),
      ],
    );
  }

  Widget _buildOfferCard(int index) {
    List<Map<String, dynamic>> offers = [
      {
        "title": "Weekend Getaway",
        "subtitle": "Up to 40% off on luxury stays",
        "color": Colors.orange,
        "icon": Icons.weekend
      },
      {
        "title": "Long Stay Discount",
        "subtitle": "Special rates for 7+ nights",
        "color": Colors.purple,
        "icon": Icons.calendar_today
      },
      {
        "title": "Early Bird Special",
        "subtitle": "Book 30 days in advance & save",
        "color": Colors.blue,
        "icon": Icons.alarm
      },
    ];

    var offer = offers[index - 1];

    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [offer["color"], offer["color"].withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: offer["color"].withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              offer["icon"],
              size: 80,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                offer["title"],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                offer["subtitle"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Book Now",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10,
    offset: Offset(0, 5),
    ),
    ],
    ),
    child: TextField(
    decoration: InputDecoration(
    hintText: "Where do you want to stay?",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
    ),
    prefixIcon: Icon(Icons.search, color: Color(0xFFFF7043)),
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
    ),
    );
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        Expanded(child: _buildDateCard("Check-in", _checkInDate, true)),
        SizedBox(width: 12),
        Expanded(child: _buildDateCard("Check-out", _checkOutDate, false)),
      ],
    );
  }

  Widget _buildDateCard(String label, DateTime? date, bool isCheckIn) {
    return GestureDetector(
      onTap: () => _selectDate(isCheckIn),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
              children: [
                Icon(Icons.calendar_today, size: 18, color: Color(0xFFFF7043)),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              date != null ? DateFormat('MMM dd, yyyy').format(date) : "Select date",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounters() {
    return Column(
      children: [
        _buildCounter("Rooms", _roomCount, 1, 5,
                () => setState(() => _roomCount--), () => setState(() => _roomCount++)),
        _buildCounter("Adults", _adultCount, 1, 10,
                () => setState(() => _adultCount--), () => setState(() => _adultCount++)),
        _buildCounter("Children", _childCount, 0, 5,
                () => setState(() => _childCount--), () => setState(() => _childCount++)),
      ],
    );
  }

  Widget _buildPurposeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Purpose of stay",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _purposeOptions.map((purpose) {
            final isSelected = _selectedPurpose == purpose;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: FilterChip(
                label: Text(purpose),
                selected: isSelected,
                selectedColor: Color(0xFFFF7043),
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                onSelected: (_) => setState(() => _selectedPurpose = purpose),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _showResults = true;
              _animationController.reset();
              _animationController.forward();
            });
          },
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text(
                  "SEARCH HOTELS",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHotelResults() {
    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips(),
                SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      "🏨 Popular in Chennai",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "${_hotels.length} properties",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Mixed star ratings: 3-star, 5-star & 7-star hotels",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                SizedBox(height: 20),
                Column(
                  children: _hotels.asMap().entries.map((entry) {
                    final index = entry.key;
                    final hotel = entry.value;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      margin: EdgeInsets.only(bottom: 16),
                      child: _hotelCard(hotel, index),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hotelCard(Map<String, dynamic> hotel, int index) {

    int starRating = hotel["starRating"] ?? 3;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsScreen(
              hotel: hotel,
              starRating: starRating,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      hotel["image"],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hotel["discount"],
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Icon(Icons.favorite_border, color: Colors.red, size: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStarColor(starRating).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            hotel["star"] ?? "$starRating-star Hotel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            hotel["name"],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 18),
                            SizedBox(width: 4),
                            Text(
                              hotel["rating"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          hotel["location"],
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      hotel["distance"],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (hotel["tags"] as List<String>).take(3).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(color: Colors.blue[700], fontSize: 12),
                        ),
                      )).toList(),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          hotel["price"],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7043),
                          ),
                        ),
                        Text("/night", style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Text("${hotel["reviews"]} reviews", style: TextStyle(color: Colors.grey)),
                      ],
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

  Color _getStarColor(int stars) {
    switch (stars) {
      case 7:
        return Colors.purple;
      case 5:
        return Colors.amber;
      case 3:
      default:
        return Colors.orange;
    }
  }
}

class FoodCourtScreen extends StatelessWidget {
  const FoodCourtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Court"),
        backgroundColor: Color(0xFFFF7043),
      ),
      body: Center(
        child: Text("Food Court Content"),
      ),
    );
  }
}