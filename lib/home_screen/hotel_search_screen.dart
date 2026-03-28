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


//////////////////////////////////////////////////////////////////////////////////////////////////////////



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'hotel_details_screen.dart';

class HotelSearchScreen extends StatefulWidget {
  final Map<String, dynamic>? searchParams;

  const HotelSearchScreen({Key? key, this.searchParams}) : super(key: key);
  // const HotelSearchScreen({super.key});

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

  Map<String, bool> _selectedFilters = {};
  bool _showResults = false;
  String? _expandedFilter;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String? _selectedPurpose;
  final List<String> _purposeOptions = [
    'Work',
    'Special Occasion',
    'Transit',
    'Holiday',
  ];
  final List<String> _singleSelectSections = [
    "PRICE PER NIGHT",
    "STAR RATING",
    "CANCELLATION POLICY",
    "PROPERTY TYPE",
    "CUSTOMER DEALS",
    "ROOM VIEWS",
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
      "description":
          "Luxury 5-star hotel with premium amenities and excellent service in the heart of Chennai.",
      "images": [
        "assets/images/img5.jpg",
        "assets/images/img6.jpg",
        "assets/images/img7.jpg",
      ],
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
      "description":
          "Comfortable 3-star stay with modern amenities in Chennai's prime shopping district.",
      "images": [
        "assets/images/img6.jpg",
        "assets/images/img5.jpg",
        "assets/images/img7.jpg",
      ],
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
      "description":
          "Beachfront luxury 7-star resort offering breathtaking views and premium services.",
      "images": [
        "assets/images/img7.jpg",
        "assets/images/img5.jpg",
        "assets/images/img6.jpg",
      ],
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
      "description":
          "Opulent 5-star hotel with royal treatment and world-class amenities.",
      "images": [
        "assets/images/img5.jpg",
        "assets/images/img6.jpg",
        "assets/images/img7.jpg",
      ],
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
      "description":
          "Affordable 3-star hotel with essential amenities for comfortable stay.",
      "images": [
        "assets/images/img6.jpg",
        "assets/images/img5.jpg",
        "assets/images/img7.jpg",
      ],
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
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

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
          : (_checkOutDate ??
                (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
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

  Widget _buildCounter(
    String label,
    int value,
    int min,
    int max,
    Function onMinus,
    Function onPlus,
  ) {
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

  // List<String> _getCurrentRoomAmenities() {
  //   final bool is3StarSelected = _selectedFilters["3 star hotel"] ?? false;
  //   final bool is5StarSelected = _selectedFilters["5 star hotel"] ?? false;
  //   final bool is7StarSelected = _selectedFilters["7 star hotel"] ?? false;
  //
  //   if (is7StarSelected) {
  //     return [
  //       "Private Butler Service",
  //       "Smart Room Automation",
  //       "Panoramic Views",
  //       "Gold-Plated Bathrooms",
  //       "Private Jacuzzi",
  //       "Michelin-Star Restaurants",
  //       "Personal Chef",
  //       "Helicopter Transfers",
  //       "Infinity Pool",
  //       "Luxury Spa",
  //       "Private Cinema",
  //       "Biometric Security",
  //     ];
  //   } else if (is5StarSelected) {
  //     return [
  //       "Luxury King Beds",
  //       "High-Speed Wi-Fi",
  //       "Smart TV",
  //       "Mini Bar",
  //       "Coffee Machine",
  //       "Marble Bathroom",
  //       "Rain Shower & Bathtub",
  //       "Premium Toiletries",
  //       "24-Hour Room Dining",
  //       "Multiple Restaurants",
  //       "Swimming Pool",
  //       "Spa & Wellness Center",
  //       "Fitness Center",
  //       "Concierge Service",
  //       "Valet Parking",
  //       "Business Center",
  //     ];
  //   } else if (is3StarSelected) {
  //     return [
  //       "Air Conditioning",
  //       "Free Wi-Fi",
  //       "TV with Cable",
  //       "Comfortable Bed",
  //       "Attached Bathroom",
  //       "Hot & Cold Water",
  //       "Basic Toiletries",
  //       "Restaurant",
  //       "Complimentary Breakfast",
  //       "24-Hour Front Desk",
  //       "Daily Housekeeping",
  //       "Parking",
  //       "Laundry Service",
  //       "CCTV Security",
  //       "Elevator",
  //       "Power Backup",
  //     ];
  //   } else {
  //     return [
  //       "Air Conditioning",
  //       "Free Wi-Fi",
  //       "Flat-screen TV / Cable TV",
  //       "Comfortable Bed & Linen",
  //       "Attached Bathroom",
  //       "Hot & Cold Water",
  //       "Towels",
  //       "Free Toiletries",
  //       "24-Hour Front Desk",
  //       "Daily Housekeeping",
  //       "Restaurant",
  //       "Parking",
  //     ];
  //   }
  // }
  List<String> _getCurrentRoomAmenities() {
    final bool is2StarSelected = _selectedFilters["2 star hotel"] ?? false;
    final bool is3StarSelected = _selectedFilters["3 star hotel"] ?? false;
    final bool is4StarSelected = _selectedFilters["4 star hotel"] ?? false;
    final bool is5StarSelected = _selectedFilters["5 star hotel"] ?? false;
    final bool is6StarSelected = _selectedFilters["6 star hotel"] ?? false;
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
        "Biometric Security",
      ];
    } else if (is6StarSelected) {
      return [
        "Personal Butler Service",
        "Smart Room Features",
        "Luxury Bathrooms",
        "Premium Bedding",
        "Fine Dining Restaurant",
        "Infinity Pool",
        "Spa & Wellness Center",
        "Fitness Center",
        "Business Center",
        "Valet Parking",
        "Airport Transfers",
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
        "Business Center",
      ];
    } else if (is4StarSelected) {
      return [
        "Comfortable Queen/King Beds",
        "High-Speed Wi-Fi",
        "Flat-screen TV",
        "Mini Fridge",
        "Tea/Coffee Maker",
        "Modern Bathroom",
        "Rain Shower",
        "Premium Toiletries",
        "24-Hour Room Service",
        "Restaurant",
        "Swimming Pool",
        "Fitness Center",
        "Concierge Service",
        "Parking",
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
        "Power Backup",
      ];
    } else if (is2StarSelected) {
      return [
        "Air Conditioning",
        "Free Wi-Fi",
        "TV",
        "Comfortable Bed",
        "Attached Bathroom",
        "Hot Water",
        "Basic Toiletries",
        "24-Hour Front Desk",
        "Daily Housekeeping",
        "Parking",
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
                              _buildFilterSection("PRICE PER NIGHT", [
                                "0 - 1500",
                                "1500 - 5000",
                                "5000 - 10000",
                                "10000+ above",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildMealsFilterSection("MEALS OPTION", [
                                "All meals with Tea/Coffee & Snacks included",
                                "Breakfast Included",
                                "Lunch Included",
                                "Dinner Included",
                                "Tea/Coffee & Snacks Included",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildPropertyTypeSection("PROPERTY TYPE", [
                                "Hotel",
                                "Service Apartment",
                                "Villa",
                                "Homestay",
                                "Resort",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildFilterSection("OTHER POPULAR AMENITIES", [
                                "AC",
                                "Non AC",
                                "Wi-Fi",
                                "Swimming pool",
                                "Restaurant",
                                "Parking",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildFilterSection("ROOM VIEWS", [
                                "Garden view",
                                "City view",
                                "Beach view",
                                "Farming view",
                                "Forest view",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildFilterSection("CUSTOMER DEALS", [
                                "Normal deals",
                                "Last minute deals",
                                "Rush deals",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildFilterSection("CANCELLATION POLICY", [
                                "Free Cancellation",
                                "Cancellation With Penalty",
                              ], setStateSB),
                              SizedBox(height: 12),

                              _buildHotelRulesSection(
                                "HOTEL RULES",
                                setStateSB,
                              ),
                              SizedBox(height: 12),

                              _buildFilterSection("FREQUENTLY USED", [
                                "Hotel",
                                "Service Apartment",
                                "Villa",
                                "Homestay",
                                "Resort",
                                "Beach",
                                "5 star hotel",
                              ], setStateSB),
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

  // String? _getSelectedStarRatingText() {
  //   if (_selectedFilters["3 star hotel"] ?? false) return "3 star hotel";
  //   if (_selectedFilters["5 star hotel"] ?? false) return "5 star hotel";
  //   if (_selectedFilters["7 star hotel"] ?? false) return "7 star hotel";
  //   return null;
  // }
  String? _getSelectedStarRatingText() {
    if (_selectedFilters["2 star hotel"] ?? false) return "2 star hotel";
    if (_selectedFilters["3 star hotel"] ?? false) return "3 star hotel";
    if (_selectedFilters["4 star hotel"] ?? false) return "4 star hotel";
    if (_selectedFilters["5 star hotel"] ?? false) return "5 star hotel";
    if (_selectedFilters["6 star hotel"] ?? false) return "6 star hotel";
    if (_selectedFilters["7 star hotel"] ?? false) return "7 star hotel";
    return null;
  }
  Widget _buildPropertyTypeSection(
    String title,
    List<String> options,
    StateSetter setStateSB,
  ) {
    final isExpanded = _expandedFilter == title;


    final List<String> allPropertyOptions = [
      "Hotel",
      "Service Apartment",
      "Villa",
      "Homestay",
      "Resort",
    ];


    final List<String> hotelStarOptions = [
      "Normal hotel",
      "2 star hotel",
      "3 star hotel",
      "4 star hotel",
      "5 star hotel",
      "6 star hotel",
      "7 star hotel",
    ];


    final List<String> resortTypeOptions = [
      "Beach Resort",
      "Farming Resort",
      "Forest Resort",
    ];


    String? _getSelectedPropertyType() {
      for (var option in allPropertyOptions) {
        if (_selectedFilters[option] == true) {
          return option;
        }
      }
      return null;
    }


    String? _getSelectedHotelStar() {
      for (var starOption in hotelStarOptions) {
        if (_selectedFilters[starOption] == true) {
          return starOption;
        }
      }
      return null;
    }


    String? _getSelectedResortType() {
      for (var resortType in resortTypeOptions) {
        if (_selectedFilters[resortType] == true) {
          return resortType;
        }
      }
      return null;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? Color(0xFFFF7043).withOpacity(0.3)
              : Colors.grey[200]!,
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
                color: isExpanded
                    ? Color(0xFFFF7043).withOpacity(0.05)
                    : Colors.white,
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
                        color: isExpanded
                            ? Color(0xFFFF7043)
                            : Colors.grey[800],
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

                  ...allPropertyOptions.map((propertyType) {
                    final bool isSelected =
                        _selectedFilters[propertyType] == true;

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Radio<String>(
                                value: propertyType,
                                groupValue: _getSelectedPropertyType(),
                                onChanged: (value) {
                                  setStateSB(() {

                                    for (var option in allPropertyOptions) {
                                      _selectedFilters[option] = false;
                                    }

                                    if (value != "Hotel") {
                                      for (var starOption in hotelStarOptions) {
                                        _selectedFilters[starOption] = false;
                                      }
                                    }

                                    if (value != "Resort") {
                                      for (var resortType
                                          in resortTypeOptions) {
                                        _selectedFilters[resortType] = false;
                                      }
                                    }

                                    _selectedFilters[value!] = true;
                                  });
                                },
                                activeColor: Color(0xFFFF7043),
                              ),
                              Expanded(
                                child: Text(
                                  propertyType,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),


                          if (isSelected && propertyType == "Hotel")
                            Padding(
                              padding: EdgeInsets.only(left: 32, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Star Rating (Optional):",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    children: hotelStarOptions.map((
                                      starOption,
                                    ) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Radio<String>(
                                              value: starOption,
                                              groupValue:
                                                  _getSelectedHotelStar(),
                                              onChanged: (value) {
                                                setStateSB(() {

                                                  for (var opt
                                                      in hotelStarOptions) {
                                                    _selectedFilters[opt] =
                                                        false;
                                                  }

                                                  _selectedFilters[value
                                                          as String] =
                                                      true;
                                                });
                                              },
                                              activeColor: Color(0xFFFF7043),
                                            ),
                                            Expanded(
                                              child: Text(
                                                starOption,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),


                          if (isSelected && propertyType == "Resort")
                            Padding(
                              padding: EdgeInsets.only(left: 32, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Resort Type (Optional):",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),


                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: "Beach Resort",
                                          groupValue: _getSelectedResortType(),
                                          onChanged: (value) {
                                            setStateSB(() {

                                              for (var opt
                                                  in resortTypeOptions) {
                                                _selectedFilters[opt] = false;
                                              }

                                              _selectedFilters[value
                                                      as String] =
                                                  true;
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
                                          groupValue: _getSelectedResortType(),
                                          onChanged: (value) {
                                            setStateSB(() {

                                              for (var opt
                                                  in resortTypeOptions) {
                                                _selectedFilters[opt] = false;
                                              }

                                              _selectedFilters[value
                                                      as String] =
                                                  true;
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
                                          groupValue: _getSelectedResortType(),
                                          onChanged: (value) {
                                            setStateSB(() {

                                              for (var opt
                                                  in resortTypeOptions) {
                                                _selectedFilters[opt] = false;
                                              }

                                              _selectedFilters[value
                                                      as String] =
                                                  true;
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
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Widget _buildPropertyTypeSection(String title, List<String> options, StateSetter setStateSB) {
  //   final isExpanded = _expandedFilter == title;
  //
  //   final List<String> allPropertyOptions = [
  //     "Hotel", "Service Apartment", "Villa", "Homestay", "Resort",
  //     "Beach Resort", "Farming Resort", "Forest Resort"
  //   ];
  //
  //   final List<String> hotelStarOptions = [
  //     "Normal hotel", "2 star hotel", "3 star hotel", "4 star hotel",
  //     "5 star hotel", "6 star hotel", "7 star hotel"
  //   ];
  //
  //   final List<String> resortTypeOptions = [
  //     "Beach Resort", "Farming Resort", "Forest Resort"
  //   ];
  //
  //   // Get selected hotel star rating (only one can be selected)
  //   String? _getSelectedHotelStar() {
  //     for (var starOption in hotelStarOptions) {
  //       if (_selectedFilters[starOption] == true) {
  //         return starOption;
  //       }
  //     }
  //     return null;
  //   }
  //
  //   // Get selected resort type (only one can be selected)
  //   String? _getSelectedResortType() {
  //     for (var resortType in resortTypeOptions) {
  //       if (_selectedFilters[resortType] == true) {
  //         return resortType;
  //       }
  //     }
  //     return null;
  //   }
  //
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(14),
  //       border: Border.all(
  //         color: isExpanded ? Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
  //         width: 1.5,
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             setStateSB(() {
  //               if (_expandedFilter == title) {
  //                 _expandedFilter = null;
  //               } else {
  //                 _expandedFilter = title;
  //               }
  //             });
  //           },
  //           child: Container(
  //             padding: EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: isExpanded ? Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
  //               borderRadius: BorderRadius.circular(14),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                       color: isExpanded ? Color(0xFFFF7043) : Colors.grey[800],
  //                     ),
  //                   ),
  //                 ),
  //                 Icon(
  //                   isExpanded ? Icons.expand_less : Icons.expand_more,
  //                   color: isExpanded ? Color(0xFFFF7043) : Colors.grey[500],
  //                   size: 22,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         if (isExpanded)
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //             decoration: BoxDecoration(
  //               border: Border(top: BorderSide(color: Colors.grey[100]!)),
  //             ),
  //             child: Column(
  //               children: [
  //                 // HOTEL - With single selection star rating
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 6),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Hotel checkbox
  //                       Row(
  //                         children: [
  //                           Checkbox(
  //                             value: _selectedFilters["Hotel"] ?? false,
  //                             onChanged: (value) {
  //                               setStateSB(() {
  //                                 _selectedFilters["Hotel"] = value ?? false;
  //                                 // If unchecking Hotel, also clear star ratings
  //                                 if (!(value ?? false)) {
  //                                   for (var starOption in hotelStarOptions) {
  //                                     _selectedFilters[starOption] = false;
  //                                   }
  //                                 }
  //                               });
  //                             },
  //                             activeColor: Color(0xFFFF7043),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(4),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Text(
  //                               "Hotel",
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Colors.grey[700],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //
  //                       // Show star rating options only when Hotel is selected - SINGLE SELECTION (Radio)
  //                       if ((_selectedFilters["Hotel"] ?? false))
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 32, top: 8),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Select Star Rating (Choose One):",
  //                                 style: TextStyle(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.grey[600],
  //                                 ),
  //                               ),
  //                               SizedBox(height: 8),
  //                               Column(
  //                                 children: hotelStarOptions.map((starOption) {
  //                                   bool isSelected = _selectedFilters[starOption] ?? false;
  //                                   return Container(
  //                                     margin: EdgeInsets.symmetric(vertical: 4),
  //                                     child: Row(
  //                                       children: [
  //                                         Radio(
  //                                           value: starOption,
  //                                           groupValue: _getSelectedHotelStar(),
  //                                           onChanged: (value) {
  //                                             setStateSB(() {
  //                                               // Clear all other star ratings first
  //                                               for (var opt in hotelStarOptions) {
  //                                                 _selectedFilters[opt] = false;
  //                                               }
  //                                               // Select the new one
  //                                               _selectedFilters[value as String] = true;
  //                                             });
  //                                           },
  //                                           activeColor: Color(0xFFFF7043),
  //                                         ),
  //                                         Expanded(
  //                                           child: Text(
  //                                             starOption,
  //                                             style: TextStyle(
  //                                               fontSize: 14,
  //                                               color: Colors.grey[700],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   );
  //                                 }).toList(),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // SERVICE APARTMENT - Checkbox
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 6),
  //                   child: Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _selectedFilters["Service Apartment"] ?? false,
  //                         onChanged: (value) {
  //                           setStateSB(() {
  //                             _selectedFilters["Service Apartment"] = value ?? false;
  //                           });
  //                         },
  //                         activeColor: Color(0xFFFF7043),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Text(
  //                           "Service Apartment",
  //                           style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.grey[700],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // VILLA - Checkbox
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 6),
  //                   child: Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _selectedFilters["Villa"] ?? false,
  //                         onChanged: (value) {
  //                           setStateSB(() {
  //                             _selectedFilters["Villa"] = value ?? false;
  //                           });
  //                         },
  //                         activeColor: Color(0xFFFF7043),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Text(
  //                           "Villa",
  //                           style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.grey[700],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // HOMESTAY - Checkbox
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 6),
  //                   child: Row(
  //                     children: [
  //                       Checkbox(
  //                         value: _selectedFilters["Homestay"] ?? false,
  //                         onChanged: (value) {
  //                           setStateSB(() {
  //                             _selectedFilters["Homestay"] = value ?? false;
  //                           });
  //                         },
  //                         activeColor: Color(0xFFFF7043),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: Text(
  //                           "Homestay",
  //                           style: TextStyle(
  //                             fontSize: 15,
  //                             color: Colors.grey[700],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // RESORT - With single selection resort type
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 6),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Resort checkbox
  //                       Row(
  //                         children: [
  //                           Checkbox(
  //                             value: _selectedFilters["Resort"] ?? false,
  //                             onChanged: (value) {
  //                               setStateSB(() {
  //                                 _selectedFilters["Resort"] = value ?? false;
  //                                 // If unchecking Resort, also clear resort types
  //                                 if (!(value ?? false)) {
  //                                   for (var resortType in resortTypeOptions) {
  //                                     _selectedFilters[resortType] = false;
  //                                   }
  //                                 }
  //                               });
  //                             },
  //                             activeColor: Color(0xFFFF7043),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(4),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Text(
  //                               "Resort",
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Colors.grey[700],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //
  //                       // Show resort type options only when Resort is selected - SINGLE SELECTION (Radio)
  //                       if ((_selectedFilters["Resort"] ?? false))
  //                         Padding(
  //                           padding: EdgeInsets.only(left: 32, top: 8),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Select Resort Type (Choose One):",
  //                                 style: TextStyle(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.grey[600],
  //                                 ),
  //                               ),
  //                               SizedBox(height: 8),
  //
  //                               // Beach Resort - Radio
  //                               Container(
  //                                 margin: EdgeInsets.symmetric(vertical: 4),
  //                                 child: Row(
  //                                   children: [
  //                                     Radio(
  //                                       value: "Beach Resort",
  //                                       groupValue: _getSelectedResortType(),
  //                                       onChanged: (value) {
  //                                         setStateSB(() {
  //                                           // Clear all other resort types first
  //                                           for (var opt in resortTypeOptions) {
  //                                             _selectedFilters[opt] = false;
  //                                           }
  //                                           // Select the new one
  //                                           _selectedFilters[value as String] = true;
  //                                         });
  //                                       },
  //                                       activeColor: Color(0xFFFF7043),
  //                                     ),
  //                                     Expanded(
  //                                       child: Text(
  //                                         "Beach Resort",
  //                                         style: TextStyle(
  //                                           fontSize: 14,
  //                                           color: Colors.grey[600],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //
  //                               // Farming Resort - Radio
  //                               Container(
  //                                 margin: EdgeInsets.symmetric(vertical: 4),
  //                                 child: Row(
  //                                   children: [
  //                                     Radio(
  //                                       value: "Farming Resort",
  //                                       groupValue: _getSelectedResortType(),
  //                                       onChanged: (value) {
  //                                         setStateSB(() {
  //                                           // Clear all other resort types first
  //                                           for (var opt in resortTypeOptions) {
  //                                             _selectedFilters[opt] = false;
  //                                           }
  //                                           // Select the new one
  //                                           _selectedFilters[value as String] = true;
  //                                         });
  //                                       },
  //                                       activeColor: Color(0xFFFF7043),
  //                                     ),
  //                                     Expanded(
  //                                       child: Text(
  //                                         "Farming Resort",
  //                                         style: TextStyle(
  //                                           fontSize: 14,
  //                                           color: Colors.grey[600],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //
  //                               // Forest Resort - Radio
  //                               Container(
  //                                 margin: EdgeInsets.symmetric(vertical: 4),
  //                                 child: Row(
  //                                   children: [
  //                                     Radio(
  //                                       value: "Forest Resort",
  //                                       groupValue: _getSelectedResortType(),
  //                                       onChanged: (value) {
  //                                         setStateSB(() {
  //                                           // Clear all other resort types first
  //                                           for (var opt in resortTypeOptions) {
  //                                             _selectedFilters[opt] = false;
  //                                           }
  //                                           // Select the new one
  //                                           _selectedFilters[value as String] = true;
  //                                         });
  //                                       },
  //                                       activeColor: Color(0xFFFF7043),
  //                                     ),
  //                                     Expanded(
  //                                       child: Text(
  //                                         "Forest Resort",
  //                                         style: TextStyle(
  //                                           fontSize: 14,
  //                                           color: Colors.grey[600],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    StateSetter setStateSB,
  ) {
    final isExpanded = _expandedFilter == title;
    final bool isSingleSelect = _singleSelectSections.contains(title);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? Color(0xFFFF7043).withOpacity(0.3)
              : Colors.grey[200]!,
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
                color: isExpanded
                    ? Color(0xFFFF7043).withOpacity(0.05)
                    : Colors.white,
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
                        color: isExpanded
                            ? Color(0xFFFF7043)
                            : Colors.grey[800],
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
                            groupValue: _getSelectedOptionForSingleSelect(
                              title,
                            ),
                            onChanged: (selectedValue) {
                              setStateSB(() {
                                for (var opt in options) {
                                  _selectedFilters[opt] = false;
                                }

                                _selectedFilters[selectedValue as String] =
                                    true;
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
      final List<String> priceOptions = [
        "0 - 1500",
        "1500 - 5000",
        "5000 - 10000",
        "10000+ above",
      ];
      for (var option in priceOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "STAR RATING") {
      final List<String> starOptions = [
        "Normal hotel",
        "2 star hotel",
        "3 star hotel",
        "4 star hotel",
        "5 star hotel",
        "6 star hotel",
        "7 star hotel",
      ];
      for (var option in starOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "CANCELLATION POLICY") {
      final List<String> cancelOptions = [
        "Free Cancellation",
        "Cancellation With Penalty",
      ];
      for (var option in cancelOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "PROPERTY TYPE") {
      final List<String> propertyOptions = [
        "Hotel",
        "Service Apartment",
        "Villa",
        "Homestay",
        "Resort",
        "Beach Resort",
        "Farming Resort",
        "Forest Resort",
      ];
      for (var option in propertyOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "CUSTOMER DEALS") {
      final List<String> dealOptions = [
        "Normal deals",
        "Last minute deals",
        "Rush deals",
      ];
      for (var option in dealOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "ROOM VIEWS") {
      final List<String> viewOptions = [
        "Garden view",
        "City view",
        "Beach view",
        "Farming view",
        "Forest view",
      ];
      for (var option in viewOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "HOTEL RULES") {
      final List<String> ruleOptions = [
        "Pets allowed",
        "Pets not allowed",
        "Smoking allowed",
        "Smoking not allowed",
        "Outside food allowed",
        "No outside food",
      ];
      for (var option in ruleOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    }
    return null;
  }

  void _openSingleCategory(
    BuildContext context,
    String title,
    List<String> options,
  ) {
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

                  ...options
                      .map(
                        (opt) => Container(
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
                        ),
                      )
                      .toList(),

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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "APPLY",
                        style: TextStyle(color: Colors.white),
                      ),
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
      {
        "label": "All Filters",
        "icon": Icons.filter_list,
        "onTap": () => _openAllFiltersSheet(context),
      },
      {
        "label": "Price",
        "icon": Icons.attach_money,
        "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", [
          "0 - 1500",
          "1500 - 5000",
          "5000 - 10000",
          "10000+ above",
        ]),
      },
      {
        "label": "Rating",
        "icon": Icons.star,
        "onTap": () => _openSingleCategory(context, "STAR RATING", [
          "Normal hotel",
          "2 star hotel",
          "3 star hotel",
          "4 star hotel",
          "5 star hotel",
          "6 star hotel",
          "7 star hotel",
        ]),
      },
      {
        "label": "Amenities",
        "icon": Icons.wifi,
        "onTap": () => _openSingleCategory(context, "OTHER POPULAR AMENITIES", [
          "Wi-Fi",
          "Swimming pool",
          "Spa",
          "Cafe",
          "Restaurant",
          "Gym",
          "Parking",
          "Airport Shuttle",
        ]),
      },
      {
        "label": "Distance",
        "icon": Icons.location_on,
        "onTap": () => _openSingleCategory(context, "DISTANCE", [
          "0-2 km",
          "2-5 km",
          "5-10 km",
          "10+ km",
        ]),
      },
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

  Widget _buildMealsFilterSection(
    String title,
    List<String> options,
    StateSetter setStateSB,
  ) {
    final isExpanded = _expandedFilter == title;
    final isAllMealsSelected =
        _selectedFilters["All meals with Tea/Coffee & Snacks included"] ??
        false;

    final bool isMealsOption = title == "MEALS OPTION";

    final List<String> mealTypeOptions = [
      "Breakfast Included",
      "Lunch Included",
      "Dinner Included",
      "Tea/Coffee & Snacks Included",
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? Color(0xFFFF7043).withOpacity(0.3)
              : Colors.grey[200]!,
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
                color: isExpanded
                    ? Color(0xFFFF7043).withOpacity(0.05)
                    : Colors.white,
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
                        color: isExpanded
                            ? Color(0xFFFF7043)
                            : Colors.grey[800],
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
                    if (option !=
                        "All meals with Tea/Coffee & Snacks included") {
                      isDisabled = true;
                    }
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isDisabled
                              ? false
                              : (_selectedFilters[option] ??
                                    false),
                          onChanged: isDisabled
                              ? null
                              : (val) {
                                  setStateSB(() {
                                    if (isMealsOption &&
                                        option ==
                                            "All meals with Tea/Coffee & Snacks  included") {
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
                              color: isDisabled
                                  ? Colors.grey[400]
                                  : Colors.grey[700],
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
          color: isExpanded
              ? Color(0xFFFF7043).withOpacity(0.3)
              : Colors.grey[200]!,
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
                color: isExpanded
                    ? Color(0xFFFF7043).withOpacity(0.05)
                    : Colors.white,
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
                        color: isExpanded
                            ? Color(0xFFFF7043)
                            : Colors.grey[800],
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
        if (_selectedFilters["Pets not allowed"] == true)
          return "Pets not allowed";
        return null;
      case "smoking":
        if (_selectedFilters["Smoking allowed"] == true)
          return "Smoking allowed";
        if (_selectedFilters["Smoking not allowed"] == true)
          return "Smoking not allowed";
        return null;
      case "outside_food":
        if (_selectedFilters["Outside food allowed"] == true)
          return "Outside food allowed";
        if (_selectedFilters["No outside food"] == true)
          return "No outside food";
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
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
        "icon": Icons.weekend,
      },
      {
        "title": "Long Stay Discount",
        "subtitle": "Special rates for 7+ nights",
        "color": Colors.purple,
        "icon": Icons.calendar_today,
      },
      {
        "title": "Early Bird Special",
        "subtitle": "Book 30 days in advance & save",
        "color": Colors.blue,
        "icon": Icons.alarm,
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
              date != null
                  ? DateFormat('MMM dd, yyyy').format(date)
                  : "Select date",
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
        _buildCounter(
          "Rooms",
          _roomCount,
          1,
          5,
          () => setState(() => _roomCount--),
          () => setState(() => _roomCount++),
        ),
        _buildCounter(
          "Adults",
          _adultCount,
          1,
          10,
          () => setState(() => _adultCount--),
          () => setState(() => _adultCount++),
        ),
        _buildCounter(
          "Children",
          _childCount,
          0,
          5,
          () => setState(() => _childCount--),
          () => setState(() => _childCount++),
        ),
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

  // Widget _buildSearchButton() {
  //   return Container(
  //     width: double.infinity,
  //     height: 60,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.orange.withOpacity(0.4),
  //           blurRadius: 15,
  //           offset: Offset(0, 8),
  //         ),
  //       ],
  //     ),
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         onTap: () {
  //           // Navigate to the Property Search Screen
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const PropertySearchScreen(),
  //             ),
  //           );
  //         },
  //         borderRadius: BorderRadius.circular(15),
  //         child: Center(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.search, color: Colors.white, size: 20),
  //               SizedBox(width: 10),
  //               Text(
  //                 "SEARCH HOTELS",
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                   letterSpacing: 1.1,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${_hotels.length} properties",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
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
            builder: (_) =>
                HotelDetailsScreen(hotel: hotel, starRating: starRating),
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                      children: (hotel["tags"] as List<String>)
                          .take(3)
                          .map(
                            (tag) => Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
                        Text(
                          "${hotel["reviews"]} reviews",
                          style: TextStyle(color: Colors.grey),
                        ),
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
      body: Center(child: Text("Food Court Content")),
    );
  }
}




// class PropertySearchScreen extends StatefulWidget {
//   const PropertySearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PropertySearchScreen> createState() => _PropertySearchScreenState();
// }
//
// class _PropertySearchScreenState extends State<PropertySearchScreen>
//     with SingleTickerProviderStateMixin {
//   String _selectedPropertyType = 'Hotel';
//   DateTime? _checkInDate;
//   DateTime? _checkOutDate;
//   int _roomCount = 1;
//   int _adultCount = 1;
//   int _childCount = 0;
//   String? _selectedPurpose;
//   final List<String> _purposeOptions = [
//     'Work',
//     'Special Occasion',
//     'Transit',
//     'Holiday',
//   ];
//
//   bool _showResults = false;
//   String? _searchQuery;
//   String? _expandedFilter;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
// // Add this with your other variables
//   late ScrollController _scrollController;
//   // Filters from HotelSearchScreen
//   Map<String, bool> _selectedFilters = {};
//   final List<String> _singleSelectSections = [
//     "PRICE PER NIGHT",
//     "STAR RATING",
//     "CANCELLATION POLICY",
//     "PROPERTY TYPE",
//     "CUSTOMER DEALS",
//     "ROOM VIEWS",
//   ];
//
//   // Hotel specific filters
//   String? _selectedHotelStarRating;
//
//   // Villa specific filters
//   String? _selectedVillaType;
//   int? _selectedBedrooms;
//
//   // Apartment specific filters
//   String? _selectedApartmentType;
//   String? _selectedBHKType;
//
//   // Resort specific filters
//   String? _selectedResortCategory;
//
//   // Common filters
//   String? _selectedPriceRange;
//
//   List<Map<String, dynamic>> _searchResults = [];
//
//   // Property data
//   final List<Map<String, dynamic>> _hotels = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "10% Off",
//       "name": "Hotel Paradise",
//       "location": "Chennai Central",
//       "price": "\$200",
//       "priceValue": 200,
//       "rating": 4.8,
//       "star": "5 star hotel",
//       "starRating": 5,
//       "reviews": 1247,
//       "distance": "2.3 km from center",
//       "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
//       "description": "Luxury 5-star hotel with premium amenities and excellent service.",
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "15% Off",
//       "name": "Grand Residency",
//       "location": "T. Nagar",
//       "price": "\$120",
//       "priceValue": 120,
//       "rating": 4.6,
//       "star": "3 star hotel",
//       "starRating": 3,
//       "reviews": 892,
//       "distance": "1.8 km from center",
//       "tags": ["Free Parking", "Gym", "Restaurant"],
//       "description": "Comfortable 3-star stay with modern amenities.",
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
//     },
//     {
//       "image": "assets/images/img7.jpg",
//       "discount": "20% Off",
//       "name": "Sea View Resort",
//       "location": "Marina Beach",
//       "price": "\$350",
//       "priceValue": 350,
//       "rating": 4.9,
//       "star": "7 star hotel",
//       "starRating": 7,
//       "reviews": 1563,
//       "distance": "0.5 km from beach",
//       "tags": ["Beach Front", "Luxury", "All Inclusive"],
//       "description": "Beachfront luxury 7-star resort.",
//       "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"],
//     },
//   ];
//
//   final List<Map<String, dynamic>> _villas = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "15% Off",
//       "name": "Luxury Beach Villa",
//       "location": "ECR, Chennai",
//       "price": "\$350",
//       "priceValue": 350,
//       "rating": 4.9,
//       "villaType": "Luxury Villa",
//       "bedrooms": 5,
//       "capacity": 12,
//       "reviews": 89,
//       "distance": "0.2 km from beach",
//       "tags": ["Private Pool", "Beach Access", "Butler Service"],
//       "description": "Ultra-luxury beachfront villa with private pool.",
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "10% Off",
//       "name": "Cozy Farm House",
//       "location": "Kelambakkam",
//       "price": "\$180",
//       "priceValue": 180,
//       "rating": 4.5,
//       "villaType": "Farm House",
//       "bedrooms": 3,
//       "capacity": 8,
//       "reviews": 45,
//       "distance": "12 km from city",
//       "tags": ["Organic Garden", "Bonfire", "BBQ"],
//       "description": "Peaceful farm stay with organic experience.",
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
//     },
//   ];
//
//   final List<Map<String, dynamic>> _apartments = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "12% Off",
//       "name": "Service Apartment - 2BHK",
//       "location": "OMR, Chennai",
//       "price": "\$120",
//       "priceValue": 120,
//       "rating": 4.6,
//       "apartmentType": "Service Apartment",
//       "bhkType": "2 BHK",
//       "bedrooms": 2,
//       "capacity": 5,
//       "reviews": 234,
//       "distance": "1.5 km from IT park",
//       "tags": ["Fully Furnished", "WiFi", "Kitchen"],
//       "description": "Fully furnished service apartment with modern amenities.",
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "8% Off",
//       "name": "Luxury Studio",
//       "location": "Adyar",
//       "price": "\$95",
//       "priceValue": 95,
//       "rating": 4.4,
//       "apartmentType": "Studio Apartment",
//       "bhkType": "Studio",
//       "bedrooms": 1,
//       "capacity": 3,
//       "reviews": 156,
//       "distance": "2 km from city center",
//       "tags": ["Smart TV", "AC", "Gym Access"],
//       "description": "Modern studio apartment with premium amenities.",
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
//     },
//   ];
//
//   final List<Map<String, dynamic>> _resorts = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "20% Off",
//       "name": "Luxury Beach Resort",
//       "location": "Mahabalipuram",
//       "price": "\$280",
//       "priceValue": 280,
//       "rating": 4.8,
//       "resortCategory": "Beach Resort",
//       "totalRooms": 45,
//       "capacity": 120,
//       "reviews": 567,
//       "distance": "0.5 km from beach",
//       "tags": ["Infinity Pool", "Spa", "Water Sports"],
//       "description": "Premium beach resort with water sports activities.",
//       "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "15% Off",
//       "name": "Eco Forest Resort",
//       "location": "Yelagiri",
//       "price": "\$150",
//       "priceValue": 150,
//       "rating": 4.6,
//       "resortCategory": "Eco Resort",
//       "totalRooms": 25,
//       "capacity": 75,
//       "reviews": 234,
//       "distance": "3 km from forest",
//       "tags": ["Nature Trails", "Organic Food", "Tree Houses"],
//       "description": "Eco-friendly resort amidst lush greenery.",
//       "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//
//     _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
//         .animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate(bool isCheckIn) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCheckIn
//           ? (_checkInDate ?? DateTime.now())
//           : (_checkOutDate ??
//           (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
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
//   List<String> _getCurrentRoomAmenities() {
//     final bool is3StarSelected = _selectedFilters["3 star hotel"] ?? false;
//     final bool is5StarSelected = _selectedFilters["5 star hotel"] ?? false;
//     final bool is7StarSelected = _selectedFilters["7 star hotel"] ?? false;
//
//     if (is7StarSelected) {
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
//         "Biometric Security",
//       ];
//     } else if (is5StarSelected) {
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
//         "Business Center",
//       ];
//     } else if (is3StarSelected) {
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
//         "Power Backup",
//       ];
//     } else {
//       return [
//         "Air Conditioning",
//         "Free Wi-Fi",
//         "Flat-screen TV / Cable TV",
//         "Comfortable Bed & Linen",
//         "Attached Bathroom",
//         "Hot & Cold Water",
//         "Towels",
//         "Free Toiletries",
//         "24-Hour Front Desk",
//         "Daily Housekeeping",
//         "Restaurant",
//         "Parking",
//       ];
//     }
//   }
//
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
//             borderRadius: const BorderRadius.only(
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
//                   return Column(
//                     children: [
//                       Center(
//                         child: Container(
//                           width: 50,
//                           height: 5,
//                           margin: const EdgeInsets.only(top: 12, bottom: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[400],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
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
//                       const SizedBox(height: 16),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           controller: scrollController,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Column(
//                             children: [
//                               _buildFilterSection("PRICE PER NIGHT", [
//                                 "0 - 1500",
//                                 "1500 - 5000",
//                                 "5000 - 10000",
//                                 "10000+ above",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildMealsFilterSection("MEALS OPTION", [
//                                 "All meals with Tea/Coffee & Snacks included",
//                                 "Breakfast Included",
//                                 "Lunch Included",
//                                 "Dinner Included",
//                                 "Tea/Coffee & Snacks Included",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildPropertyTypeSection("PROPERTY TYPE", [
//                                 "Hotel",
//                                 "Service Apartment",
//                                 "Villa",
//                                 "Homestay",
//                                 "Resort",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildFilterSection("OTHER POPULAR AMENITIES", [
//                                 "AC",
//                                 "Non AC",
//                                 "Wi-Fi",
//                                 "Swimming pool",
//                                 "Restaurant",
//                                 "Parking",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildFilterSection("ROOM VIEWS", [
//                                 "Garden view",
//                                 "City view",
//                                 "Beach view",
//                                 "Farming view",
//                                 "Forest view",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildFilterSection("CUSTOMER DEALS", [
//                                 "Normal deals",
//                                 "Last minute deals",
//                                 "Rush deals",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildFilterSection("CANCELLATION POLICY", [
//                                 "Free Cancellation",
//                                 "Cancellation With Penalty",
//                               ], setStateSB),
//                               const SizedBox(height: 12),
//                               _buildHotelRulesSection("HOTEL RULES", setStateSB),
//                               const SizedBox(height: 12),
//                               _buildFilterSection("FREQUENTLY USED", [
//                                 "Hotel",
//                                 "Service Apartment",
//                                 "Villa",
//                                 "Homestay",
//                                 "Resort",
//                                 "Beach",
//                                 "5 star hotel",
//                               ], setStateSB),
//                               const SizedBox(height: 30),
//                               Container(
//                                 width: double.infinity,
//                                 height: 54,
//                                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFFF7043),
//                                   borderRadius: BorderRadius.circular(14),
//                                 ),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.pop(context);
//                                     },
//                                     borderRadius: BorderRadius.circular(14),
//                                     child: const Center(
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
//                               const SizedBox(height: 30),
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
//   Widget _buildPropertyTypeSection(String title, List<String> options, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == title;
//
//     final List<String> allPropertyOptions = [
//       "Hotel",
//       "Service Apartment",
//       "Villa",
//       "Homestay",
//       "Resort",
//     ];
//
//     final List<String> hotelStarOptions = [
//       "Normal hotel",
//       "2 star hotel",
//       "3 star hotel",
//       "4 star hotel",
//       "5 star hotel",
//       "6 star hotel",
//       "7 star hotel",
//     ];
//
//     final List<String> resortTypeOptions = [
//       "Beach Resort",
//       "Farming Resort",
//       "Forest Resort",
//     ];
//
//     String? _getSelectedPropertyType() {
//       for (var option in allPropertyOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//       return null;
//     }
//
//     String? _getSelectedHotelStar() {
//       for (var starOption in hotelStarOptions) {
//         if (_selectedFilters[starOption] == true) return starOption;
//       }
//       return null;
//     }
//
//     String? _getSelectedResortType() {
//       for (var resortType in resortTypeOptions) {
//         if (_selectedFilters[resortType] == true) return resortType;
//       }
//       return null;
//     }
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
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
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
//                         color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 children: allPropertyOptions.map((propertyType) {
//                   final bool isSelected = _selectedFilters[propertyType] == true;
//
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Radio<String>(
//                               value: propertyType,
//                               groupValue: _getSelectedPropertyType(),
//                               onChanged: (value) {
//                                 setStateSB(() {
//                                   for (var option in allPropertyOptions) {
//                                     _selectedFilters[option] = false;
//                                   }
//                                   if (value != "Hotel") {
//                                     for (var starOption in hotelStarOptions) {
//                                       _selectedFilters[starOption] = false;
//                                     }
//                                   }
//                                   if (value != "Resort") {
//                                     for (var resortType in resortTypeOptions) {
//                                       _selectedFilters[resortType] = false;
//                                     }
//                                   }
//                                   _selectedFilters[value!] = true;
//                                 });
//                               },
//                               activeColor: const Color(0xFFFF7043),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 propertyType,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         if (isSelected && propertyType == "Hotel")
//                           Padding(
//                             padding: const EdgeInsets.only(left: 32, top: 8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Select Star Rating (Optional):",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Column(
//                                   children: hotelStarOptions.map((starOption) {
//                                     return Container(
//                                       margin: const EdgeInsets.symmetric(vertical: 4),
//                                       child: Row(
//                                         children: [
//                                           Radio<String>(
//                                             value: starOption,
//                                             groupValue: _getSelectedHotelStar(),
//                                             onChanged: (value) {
//                                               setStateSB(() {
//                                                 for (var opt in hotelStarOptions) {
//                                                   _selectedFilters[opt] = false;
//                                                 }
//                                                 _selectedFilters[value as String] = true;
//                                               });
//                                             },
//                                             activeColor: const Color(0xFFFF7043),
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               starOption,
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.grey[700],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         if (isSelected && propertyType == "Resort")
//                           Padding(
//                             padding: const EdgeInsets.only(left: 32, top: 8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Select Resort Type (Optional):",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 4),
//                                   child: Row(
//                                     children: [
//                                       Radio<String>(
//                                         value: "Beach Resort",
//                                         groupValue: _getSelectedResortType(),
//                                         onChanged: (value) {
//                                           setStateSB(() {
//                                             for (var opt in resortTypeOptions) {
//                                               _selectedFilters[opt] = false;
//                                             }
//                                             _selectedFilters[value as String] = true;
//                                           });
//                                         },
//                                         activeColor: const Color(0xFFFF7043),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Beach Resort",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 4),
//                                   child: Row(
//                                     children: [
//                                       Radio<String>(
//                                         value: "Farming Resort",
//                                         groupValue: _getSelectedResortType(),
//                                         onChanged: (value) {
//                                           setStateSB(() {
//                                             for (var opt in resortTypeOptions) {
//                                               _selectedFilters[opt] = false;
//                                             }
//                                             _selectedFilters[value as String] = true;
//                                           });
//                                         },
//                                         activeColor: const Color(0xFFFF7043),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Farming Resort",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 4),
//                                   child: Row(
//                                     children: [
//                                       Radio<String>(
//                                         value: "Forest Resort",
//                                         groupValue: _getSelectedResortType(),
//                                         onChanged: (value) {
//                                           setStateSB(() {
//                                             for (var opt in resortTypeOptions) {
//                                               _selectedFilters[opt] = false;
//                                             }
//                                             _selectedFilters[value as String] = true;
//                                           });
//                                         },
//                                         activeColor: const Color(0xFFFF7043),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           "Forest Resort",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
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
//   Widget _buildFilterSection(String title, List<String> options, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == title;
//     final bool isSingleSelect = _singleSelectSections.contains(title);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
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
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 children: options.map((option) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: Row(
//                       children: [
//                         if (isSingleSelect)
//                           Radio<String>(
//                             value: option,
//                             groupValue: _getSelectedOptionForSingleSelect(title),
//                             onChanged: (selectedValue) {
//                               setStateSB(() {
//                                 for (var opt in options) {
//                                   _selectedFilters[opt] = false;
//                                 }
//                                 _selectedFilters[selectedValue as String] = true;
//                               });
//                             },
//                             activeColor: const Color(0xFFFF7043),
//                           )
//                         else
//                           Checkbox(
//                             value: _selectedFilters[option] ?? false,
//                             onChanged: (val) {
//                               setStateSB(() {
//                                 _selectedFilters[option] = val ?? false;
//                               });
//                             },
//                             activeColor: const Color(0xFFFF7043),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
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
//   Widget _buildMealsFilterSection(String title, List<String> options, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == title;
//     final isAllMealsSelected = _selectedFilters["All meals with Tea/Coffee & Snacks included"] ?? false;
//     final bool isMealsOption = title == "MEALS OPTION";
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
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
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
//                         color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 children: options.map((option) {
//                   bool isDisabled = false;
//                   if (isMealsOption && isAllMealsSelected) {
//                     if (option != "All meals with Tea/Coffee & Snacks included") {
//                       isDisabled = true;
//                     }
//                   }
//
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     child: Row(
//                       children: [
//                         Checkbox(
//                           value: isDisabled ? false : (_selectedFilters[option] ?? false),
//                           onChanged: isDisabled
//                               ? null
//                               : (val) {
//                             setStateSB(() {
//                               _selectedFilters[option] = val ?? false;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                         Expanded(
//                           child: Text(
//                             option,
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: isDisabled ? Colors.grey[400] : Colors.grey[700],
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
//   Widget _buildHotelRulesSection(String title, StateSetter setStateSB) {
//     final isExpanded = _expandedFilter == title;
//
//     final String? selectedPets = _getSelectedRuleOption("pets");
//     final String? selectedSmoking = _getSelectedRuleOption("smoking");
//     final String? selectedOutsideFood = _getSelectedRuleOption("outside_food");
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
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
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
//                         color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     isExpanded ? Icons.expand_less : Icons.expand_more,
//                     color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
//                     size: 22,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: Colors.grey[100]!)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Pets",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Allowed"),
//                           value: "Pets allowed",
//                           groupValue: selectedPets,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Pets allowed"] = false;
//                               _selectedFilters["Pets not allowed"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Not Allowed"),
//                           value: "Pets not allowed",
//                           groupValue: selectedPets,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Pets allowed"] = false;
//                               _selectedFilters["Pets not allowed"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 20, color: Colors.grey),
//                   Text(
//                     "Smoking",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Allowed"),
//                           value: "Smoking allowed",
//                           groupValue: selectedSmoking,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Smoking allowed"] = false;
//                               _selectedFilters["Smoking not allowed"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Not Allowed"),
//                           value: "Smoking not allowed",
//                           groupValue: selectedSmoking,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Smoking allowed"] = false;
//                               _selectedFilters["Smoking not allowed"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 20, color: Colors.grey),
//                   Text(
//                     "Outside Food",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Allowed"),
//                           value: "Outside food allowed",
//                           groupValue: selectedOutsideFood,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Outside food allowed"] = false;
//                               _selectedFilters["No outside food"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                       Expanded(
//                         child: RadioListTile<String>(
//                           title: const Text("Not Allowed"),
//                           value: "No outside food",
//                           groupValue: selectedOutsideFood,
//                           onChanged: (value) {
//                             setStateSB(() {
//                               _selectedFilters["Outside food allowed"] = false;
//                               _selectedFilters["No outside food"] = false;
//                               _selectedFilters[value!] = true;
//                             });
//                           },
//                           activeColor: const Color(0xFFFF7043),
//                           contentPadding: EdgeInsets.zero,
//                           dense: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   String? _getSelectedRuleOption(String ruleType) {
//     switch (ruleType) {
//       case "pets":
//         if (_selectedFilters["Pets allowed"] == true) return "Pets allowed";
//         if (_selectedFilters["Pets not allowed"] == true) return "Pets not allowed";
//         return null;
//       case "smoking":
//         if (_selectedFilters["Smoking allowed"] == true) return "Smoking allowed";
//         if (_selectedFilters["Smoking not allowed"] == true) return "Smoking not allowed";
//         return null;
//       case "outside_food":
//         if (_selectedFilters["Outside food allowed"] == true) return "Outside food allowed";
//         if (_selectedFilters["No outside food"] == true) return "No outside food";
//         return null;
//       default:
//         return null;
//     }
//   }
//
//   String? _getSelectedOptionForSingleSelect(String title) {
//     if (title == "PRICE PER NIGHT") {
//       final List<String> priceOptions = [
//         "0 - 1500",
//         "1500 - 5000",
//         "5000 - 10000",
//         "10000+ above",
//       ];
//       for (var option in priceOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "STAR RATING") {
//       final List<String> starOptions = [
//         "Normal hotel",
//         "2 star hotel",
//         "3 star hotel",
//         "4 star hotel",
//         "5 star hotel",
//         "6 star hotel",
//         "7 star hotel",
//       ];
//       for (var option in starOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "CANCELLATION POLICY") {
//       final List<String> cancelOptions = [
//         "Free Cancellation",
//         "Cancellation With Penalty",
//       ];
//       for (var option in cancelOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "PROPERTY TYPE") {
//       final List<String> propertyOptions = [
//         "Hotel",
//         "Service Apartment",
//         "Villa",
//         "Homestay",
//         "Resort",
//         "Beach Resort",
//         "Farming Resort",
//         "Forest Resort",
//       ];
//       for (var option in propertyOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "CUSTOMER DEALS") {
//       final List<String> dealOptions = [
//         "Normal deals",
//         "Last minute deals",
//         "Rush deals",
//       ];
//       for (var option in dealOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "ROOM VIEWS") {
//       final List<String> viewOptions = [
//         "Garden view",
//         "City view",
//         "Beach view",
//         "Farming view",
//         "Forest view",
//       ];
//       for (var option in viewOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     } else if (title == "HOTEL RULES") {
//       final List<String> ruleOptions = [
//         "Pets allowed",
//         "Pets not allowed",
//         "Smoking allowed",
//         "Smoking not allowed",
//         "Outside food allowed",
//         "No outside food",
//       ];
//       for (var option in ruleOptions) {
//         if (_selectedFilters[option] == true) return option;
//       }
//     }
//     return null;
//   }
//
//   void _openSingleCategory(BuildContext context, String title, List<String> options) {
//     final bool isSingleSelect = _singleSelectSections.contains(title);
//
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateSB) {
//             String? selectedOption = _getSelectedOptionForSingleSelect(title);
//
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
//                       margin: const EdgeInsets.only(bottom: 16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...options.map(
//                         (opt) => Container(
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       child: Row(
//                         children: [
//                           if (isSingleSelect)
//                             Radio<String>(
//                               value: opt,
//                               groupValue: selectedOption,
//                               onChanged: (value) {
//                                 setStateSB(() {
//                                   selectedOption = value;
//                                 });
//                               },
//                               activeColor: const Color(0xFFFF7043),
//                             )
//                           else
//                             Checkbox(
//                               value: _selectedFilters[opt] ?? false,
//                               onChanged: (val) {
//                                 setStateSB(() {
//                                   _selectedFilters[opt] = val ?? false;
//                                 });
//                               },
//                               activeColor: const Color(0xFFFF7043),
//                             ),
//                           Expanded(child: Text(opt)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (isSingleSelect && selectedOption != null) {
//                           for (var opt in options) {
//                             _selectedFilters[opt] = false;
//                           }
//                           _selectedFilters[selectedOption!] = true;
//                         }
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF7043),
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         "APPLY",
//                         style: TextStyle(color: Colors.white),
//                       ),
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
//   void _performSearch() {
//     setState(() {
//       _showResults = true;
//       _searchResults = [];
//
//       List<Map<String, dynamic>> results = [];
//
//       switch (_selectedPropertyType) {
//         case 'Hotel':
//           results = _hotels.where((hotel) {
//             bool matches = true;
//
//             // Filter by star rating from global filters
//             if (_selectedFilters["2 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 2;
//             } else if (_selectedFilters["3 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 3;
//             } else if (_selectedFilters["4 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 4;
//             } else if (_selectedFilters["5 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 5;
//             } else if (_selectedFilters["6 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 6;
//             } else if (_selectedFilters["7 star hotel"] == true) {
//               matches = matches && hotel['starRating'] == 7;
//             } else if (_selectedHotelStarRating != null && _selectedHotelStarRating != 'All') {
//               int selectedStars = int.tryParse(_selectedHotelStarRating!.split('-')[0]) ?? 0;
//               matches = matches && hotel['starRating'] == selectedStars;
//             }
//
//             // Filter by price range
//             if (_selectedPriceRange != null && _selectedPriceRange != 'All') {
//               matches = matches && _checkPriceRange(hotel['priceValue']);
//             }
//
//             // Filter by global price filter
//             if (_selectedFilters["0 - 1500"] == true) {
//               matches = matches && hotel['priceValue'] <= 1500;
//             } else if (_selectedFilters["1500 - 5000"] == true) {
//               matches = matches && hotel['priceValue'] >= 1500 && hotel['priceValue'] <= 5000;
//             } else if (_selectedFilters["5000 - 10000"] == true) {
//               matches = matches && hotel['priceValue'] >= 5000 && hotel['priceValue'] <= 10000;
//             } else if (_selectedFilters["10000+ above"] == true) {
//               matches = matches && hotel['priceValue'] > 10000;
//             }
//
//             // Filter by search query
//             if (_searchQuery != null && _searchQuery!.isNotEmpty) {
//               matches = matches && hotel['name'].toLowerCase().contains(_searchQuery!.toLowerCase());
//             }
//
//             return matches;
//           }).toList();
//           break;
//
//         case 'Villa':
//           results = _villas.where((villa) {
//             bool matches = true;
//
//             if (_selectedVillaType != null && _selectedVillaType != 'All') {
//               matches = matches && villa['villaType'] == _selectedVillaType;
//             }
//
//             if (_selectedBedrooms != null && _selectedBedrooms != 0) {
//               matches = matches && villa['bedrooms'] >= _selectedBedrooms!;
//             }
//
//             if (_selectedPriceRange != null && _selectedPriceRange != 'All') {
//               matches = matches && _checkPriceRange(villa['priceValue']);
//             }
//
//             if (_searchQuery != null && _searchQuery!.isNotEmpty) {
//               matches = matches && villa['name'].toLowerCase().contains(_searchQuery!.toLowerCase());
//             }
//
//             return matches;
//           }).toList();
//           break;
//
//         case 'Apartment':
//           results = _apartments.where((apt) {
//             bool matches = true;
//
//             if (_selectedApartmentType != null && _selectedApartmentType != 'All') {
//               matches = matches && apt['apartmentType'] == _selectedApartmentType;
//             }
//
//             if (_selectedBHKType != null && _selectedBHKType != 'All') {
//               matches = matches && apt['bhkType'] == _selectedBHKType;
//             }
//
//             if (_selectedPriceRange != null && _selectedPriceRange != 'All') {
//               matches = matches && _checkPriceRange(apt['priceValue']);
//             }
//
//             if (_searchQuery != null && _searchQuery!.isNotEmpty) {
//               matches = matches && apt['name'].toLowerCase().contains(_searchQuery!.toLowerCase());
//             }
//
//             return matches;
//           }).toList();
//           break;
//
//         case 'Resort':
//           results = _resorts.where((resort) {
//             bool matches = true;
//
//             if (_selectedResortCategory != null && _selectedResortCategory != 'All') {
//               matches = matches && resort['resortCategory'] == _selectedResortCategory;
//             }
//
//             if (_selectedPriceRange != null && _selectedPriceRange != 'All') {
//               matches = matches && _checkPriceRange(resort['priceValue']);
//             }
//
//             if (_searchQuery != null && _searchQuery!.isNotEmpty) {
//               matches = matches && resort['name'].toLowerCase().contains(_searchQuery!.toLowerCase());
//             }
//
//             return matches;
//           }).toList();
//           break;
//       }
//
//       _searchResults = results;
//       _animationController.reset();
//       _animationController.forward();
//
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (_scrollController.hasClients) {
//           _scrollController.animateTo(
//             0,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//           );
//         }
//       });
//
//     });
//   }
//
//   bool _checkPriceRange(int price) {
//     switch (_selectedPriceRange) {
//       case 'Under ₹1000':
//         return price < 1000;
//       case '₹1000 - ₹2000':
//         return price >= 1000 && price <= 2000;
//       case '₹2000 - ₹5000':
//         return price >= 2000 && price <= 5000;
//       case '₹5000+':
//         return price > 5000;
//       default:
//         return true;
//     }
//   }
//
//   // Widget builders for UI components (same as before, but with the new filter methods integrated)
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: Column(
//         children: [
//           _buildHeader(),
//           Expanded(
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 500),
//               child: _showResults
//                   ? _buildResultsView()
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
//           colors: [const Color(0xFFFF7043), const Color(0xFFFF8A65)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.orange.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 // onPressed: () => Navigator.pop(context),
//                   onPressed: () =>    Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => PropertySearchScreen(
//
//                       ),
//                     ),
//                   )
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 "WanderStay",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             "Discover your perfect stay with exclusive deals ✨",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.white,
//             ),
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
//             padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).padding.bottom),
//             child: Column(
//               children: [
//                 _buildOffersCarousel(),
//                 const SizedBox(height: 30),
//                 _buildPropertyTypeSelector(),
//                 const SizedBox(height: 20),
//                 _buildSearchField(),
//                 const SizedBox(height: 20),
//                 _buildDateSelection(),
//                 const SizedBox(height: 20),
//                 _buildCounters(),
//                 const SizedBox(height: 20),
//                 _buildPropertySpecificFilters(),
//                 const SizedBox(height: 20),
//                 _buildPriceRangeFilter(),
//                 const SizedBox(height: 20),
//                 _buildPurposeSelection(),
//                 const SizedBox(height: 30),
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
//         const Text(
//           "🔥 Exclusive Offers",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 15),
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
//       {"title": "Weekend Getaway", "subtitle": "Up to 40% off on luxury stays", "color": Colors.orange, "icon": Icons.weekend},
//       {"title": "Long Stay Discount", "subtitle": "Special rates for 7+ nights", "color": Colors.purple, "icon": Icons.calendar_today},
//       {"title": "Early Bird Special", "subtitle": "Book 30 days in advance & save", "color": Colors.blue, "icon": Icons.alarm},
//     ];
//
//     var offer = offers[index - 1];
//
//     return Container(
//       height: 140,
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [offer["color"], offer["color"].withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: offer["color"].withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
//       ),
//       child: Stack(
//         children: [
//           Positioned(right: -20, top: -20, child: Icon(offer["icon"], size: 80, color: Colors.white.withOpacity(0.1))),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(offer["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//               const SizedBox(height: 4),
//               Text(offer["subtitle"], style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9))),
//               const SizedBox(height: 15),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
//                 child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 15)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPropertyTypeSelector() {
//     List<Map<String, dynamic>> propertyTypes = [
//       {"name": "Hotel", "icon": Icons.hotel, "color": Colors.orange},
//       {"name": "Villa", "icon": Icons.villa, "color": Colors.green},
//       {"name": "Apartment", "icon": Icons.apartment, "color": Colors.blue},
//       {"name": "Resort", "icon": Icons.beach_access, "color": Colors.purple},
//     ];
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: propertyTypes.map((type) {
//           bool isSelected = _selectedPropertyType == type["name"];
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedPropertyType = type["name"];
//                   _selectedHotelStarRating = null;
//                   _selectedVillaType = null;
//                   _selectedApartmentType = null;
//                   _selectedResortCategory = null;
//                   _selectedPriceRange = null;
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: isSelected ? (type["color"] as Color).withOpacity(0.1) : Colors.transparent,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(type["icon"], color: isSelected ? type["color"] : Colors.grey, size: 28),
//                     const SizedBox(height: 4),
//                     Text(
//                       type["name"],
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                         color: isSelected ? type["color"] : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildSearchField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
//       ),
//       child: TextField(
//         onChanged: (value) => _searchQuery = value,
//         decoration: InputDecoration(
//           hintText: "Where do you want to stay?",
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
//           prefixIcon: const Icon(Icons.search, color: Color(0xFFFF7043)),
//           contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateSelection() {
//     return Row(
//       children: [
//         Expanded(child: _buildDateCard("Check-in", _checkInDate, true)),
//         const SizedBox(width: 12),
//         Expanded(child: _buildDateCard("Check-out", _checkOutDate, false)),
//       ],
//     );
//   }
//
//   Widget _buildDateCard(String label, DateTime? date, bool isCheckIn) {
//     return GestureDetector(
//       onTap: () => _selectDate(isCheckIn),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 18, color: const Color(0xFFFF7043)),
//                 const SizedBox(width: 8),
//                 Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               date != null ? DateFormat('MMM dd, yyyy').format(date) : "Select date",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
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
//         _buildCounter("Rooms", _roomCount, 1, 5, () => setState(() => _roomCount--), () => setState(() => _roomCount++)),
//         _buildCounter("Adults", _adultCount, 1, 10, () => setState(() => _adultCount--), () => setState(() => _adultCount++)),
//         _buildCounter("Children", _childCount, 0, 5, () => setState(() => _childCount--), () => setState(() => _childCount++)),
//       ],
//     );
//   }
//
//   Widget _buildCounter(String label, int value, int min, int max, Function onMinus, Function onPlus) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[800])),
//           Row(
//             children: [
//               _buildIconButton(icon: Icons.remove, onPressed: value > min ? () => onMinus() : null, isEnabled: value > min),
//               Container(width: 40, alignment: Alignment.center, child: Text("$value", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFF7043)))),
//               _buildIconButton(icon: Icons.add, onPressed: value < max ? () => onPlus() : null, isEnabled: value < max),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIconButton({required IconData icon, required VoidCallback? onPressed, required bool isEnabled}) {
//     return Container(
//       width: 30,
//       height: 30,
//       decoration: BoxDecoration(color: isEnabled ? const Color(0xFFFF7043) : Colors.grey[300], shape: BoxShape.circle),
//       child: IconButton(
//         icon: Icon(icon, size: 15),
//         color: Colors.white,
//         onPressed: onPressed,
//         padding: EdgeInsets.zero,
//         constraints: const BoxConstraints(),
//       ),
//     );
//   }
//
//   Widget _buildPropertySpecificFilters() {
//     switch (_selectedPropertyType) {
//       case 'Hotel':
//         return _buildDropdownFilter(
//           "Star Rating",
//           ["All", "2-Star", "3-Star", "4-Star", "5-Star", "6-Star", "7-Star"],
//           _selectedHotelStarRating,
//               (value) => setState(() => _selectedHotelStarRating = value),
//         );
//       case 'Villa':
//         return Column(
//           children: [
//             _buildDropdownFilter("Villa Type", ["All", "Luxury Villa", "Beach Villa", "Pool Villa", "Farm House", "Budget Villa"], _selectedVillaType, (value) => setState(() => _selectedVillaType = value)),
//             const SizedBox(height: 12),
//             _buildDropdownFilter("Bedrooms", ["All", "1", "2", "3", "4", "5+"], _selectedBedrooms?.toString(), (value) => setState(() => _selectedBedrooms = value == "5+" ? 5 : int.tryParse(value ?? "0"))),
//           ],
//         );
//       case 'Apartment':
//         return Column(
//           children: [
//             _buildDropdownFilter("Apartment Type", ["All", "Service Apartment", "Studio Apartment", "Luxury Apartment", "Budget Apartment", "Entire Apartment", "Shared Apartment"], _selectedApartmentType, (value) => setState(() => _selectedApartmentType = value)),
//             const SizedBox(height: 12),
//             _buildDropdownFilter("BHK Type", ["All", "1 BHK", "2 BHK", "3 BHK", "4 BHK", "5 BHK+"], _selectedBHKType, (value) => setState(() => _selectedBHKType = value)),
//           ],
//         );
//       case 'Resort':
//         return _buildDropdownFilter("Resort Category", ["All", "Luxury", "Boutique", "Eco Resort", "Beach Resort", "Hill Resort", "Farm Resort"], _selectedResortCategory, (value) => setState(() => _selectedResortCategory = value));
//       default:
//         return const SizedBox.shrink();
//     }
//   }
//
//   Widget _buildDropdownFilter(String label, List<String> options, String? selectedValue, Function(String?) onChanged) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
//       child: Row(
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
//           const Spacer(),
//           DropdownButton<String>(
//             value: selectedValue ?? options.first,
//             underline: const SizedBox(),
//             items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
//             onChanged: onChanged,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPriceRangeFilter() {
//     List<String> priceRanges = ["All", "Under ₹1000", "₹1000 - ₹2000", "₹2000 - ₹5000", "₹5000+"];
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
//       child: Row(
//         children: [
//           const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w600)),
//           const Spacer(),
//           DropdownButton<String>(
//             value: _selectedPriceRange ?? priceRanges.first,
//             underline: const SizedBox(),
//             items: priceRanges.map((range) => DropdownMenuItem(value: range, child: Text(range))).toList(),
//             onChanged: (value) => setState(() => _selectedPriceRange = value),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPurposeSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Purpose of stay", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: _purposeOptions.map((purpose) {
//             final isSelected = _selectedPurpose == purpose;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               child: FilterChip(
//                 label: Text(purpose),
//                 selected: isSelected,
//                 selectedColor: const Color(0xFFFF7043),
//                 checkmarkColor: Colors.white,
//                 labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey[700], fontWeight: FontWeight.w500),
//                 onSelected: (_) => setState(() => _selectedPurpose = purpose),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
//         gradient: const LinearGradient(colors: [Color(0xFFFF7043), Color(0xFFFF8A65)], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: _performSearch,
//           borderRadius: BorderRadius.circular(15),
//           child: const Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.search, color: Colors.white, size: 20),
//                 SizedBox(width: 10),
//                 Text("SEARCH PROPERTIES", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildResultsView() {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: SingleChildScrollView(
//             controller: _scrollController,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildFilterChips(),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text("🏨 Popular in Chennai", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     const Spacer(),
//                     Text("${_searchResults.length} properties", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Text("Find the best ${_selectedPropertyType.toLowerCase()}s for your stay", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//                 const SizedBox(height: 20),
//                 Column(
//                   children: _searchResults.asMap().entries.map((entry) {
//                     final index = entry.key;
//                     final property = entry.value;
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 300 + (index * 100)),
//                       margin: const EdgeInsets.only(bottom: 16),
//                       child: _buildPropertyCard(property, index),
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
//
//   Widget _buildFilterChips() {
//     List<Map<String, dynamic>> filters = [
//       {"label": "All Filters", "icon": Icons.filter_list, "onTap": () => _openAllFiltersSheet(context)},
//       {"label": "Price", "icon": Icons.attach_money, "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"])},
//       {"label": "Rating", "icon": Icons.star, "onTap": () => _openSingleCategory(context, "STAR RATING", ["Normal hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel"])},
//       {"label": "Amenities", "icon": Icons.wifi, "onTap": () => _openSingleCategory(context, "OTHER POPULAR AMENITIES", ["Wi-Fi", "Swimming pool", "Spa", "Cafe", "Restaurant", "Gym", "Parking", "Airport Shuttle"])},
//       {"label": "Distance", "icon": Icons.location_on, "onTap": () => _openSingleCategory(context, "DISTANCE", ["0-2 km", "2-5 km", "5-10 km", "10+ km"])},
//     ];
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: filters.map((filter) {
//           return Container(
//             margin: const EdgeInsets.only(right: 10),
//             child: FilterChip(
//               label: Text(filter["label"]),
//               avatar: Icon(filter["icon"], size: 18),
//               onSelected: (_) => filter["onTap"](),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildPropertyCard(Map<String, dynamic> property, int index) {
//     int starRating = property["starRating"] ?? 3;
//
//     return GestureDetector(
//       onTap: () {
//         if (_selectedPropertyType == 'Hotel') {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: property, starRating: starRating)));
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("View ${property['name']} details"), backgroundColor: const Color(0xFFFF7043)));
//         }
//       },
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                     child: Image.asset(property["image"], height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 180, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image, size: 50)))),
//                   ),
//                   if (property.containsKey('discount'))
//                     Positioned(
//                       top: 12,
//                       left: 12,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
//                         child: Text(property["discount"], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                   Positioned(
//                     top: 12,
//                     right: 12,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white.withOpacity(0.9),
//                       child: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
//                     ),
//                   ),
//                   if (property.containsKey('starRating'))
//                     Positioned(
//                       bottom: 12,
//                       left: 12,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(color: _getStarColor(starRating).withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.star, size: 14, color: Colors.white),
//                             const SizedBox(width: 4),
//                             Text(property["star"] ?? "$starRating-star Hotel", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(child: Text(property["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
//                         Row(children: [const Icon(Icons.star, color: Colors.orange, size: 18), const SizedBox(width: 4), Text(property["rating"].toString())]),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(property["location"], style: TextStyle(color: Colors.grey, fontSize: 14))]),
//                     const SizedBox(height: 8),
//                     Text(property["distance"], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//                     const SizedBox(height: 12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: (property["tags"] as List<String>).take(3).map((tag) => Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
//                         child: Text(tag, style: TextStyle(color: Colors.blue[700], fontSize: 12)),
//                       )).toList(),
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Text(property["price"], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF7043))),
//                         const Text("/night", style: TextStyle(color: Colors.grey)),
//                         const Spacer(),
//                         Text("${property["reviews"]} reviews", style: TextStyle(color: Colors.grey)),
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
//
//   Color _getStarColor(int stars) {
//     switch (stars) {
//       case 7: return Colors.purple;
//       case 6: return Colors.deepPurple;
//       case 5: return Colors.amber;
//       case 4: return Colors.lightGreen;
//       case 3: return Colors.orange;
//       default: return Colors.orange;
//     }
//   }
// }










class PropertySearchScreen extends StatefulWidget {
  const PropertySearchScreen({Key? key}) : super(key: key);

  @override
  State<PropertySearchScreen> createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<PropertySearchScreen>
    with SingleTickerProviderStateMixin {

  // Search Parameters
  String _selectedPropertyType = 'Hotel';
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _roomCount = 1;
  int _adultCount = 1;
  int _childCount = 0;
  String? _selectedPurpose;
  String? _searchQuery;

  // Filters
  final List<String> _purposeOptions = [
    'Work', 'Special Occasion', 'Transit', 'Holiday',
  ];
  Map<String, bool> _selectedFilters = {};
  String? _expandedFilter;

  // Animation Controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late ScrollController _scrollController;

  // Results
  bool _showResults = false;
  List<Map<String, dynamic>> _searchResults = [];

  // Property-specific filters
  String? _selectedHotelStarRating;
  String? _selectedVillaType;
  int? _selectedBedrooms;
  String? _selectedApartmentType;
  String? _selectedBHKType;
  String? _selectedResortCategory;
  String? _selectedPriceRange;

  // Single select sections for filters
  final List<String> _singleSelectSections = [
    "PRICE PER NIGHT",
    "STAR RATING",
    "CANCELLATION POLICY",
    "PROPERTY TYPE",
    "CUSTOMER DEALS",
    "ROOM VIEWS",
  ];

  // Property Data Collections
  final List<Map<String, dynamic>> _hotels = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "10% Off",
      "name": "Hotel Paradise",
      "location": "Chennai Central",
      "price": "\$200",
      "priceValue": 200,
      "rating": 4.8,
      "star": "5 star hotel",
      "starRating": 5,
      "reviews": 1247,
      "distance": "2.3 km from center",
      "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
      "description": "Luxury 5-star hotel with premium amenities and excellent service.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "15% Off",
      "name": "Grand Residency",
      "location": "T. Nagar",
      "price": "\$120",
      "priceValue": 120,
      "rating": 4.6,
      "star": "3 star hotel",
      "starRating": 3,
      "reviews": 892,
      "distance": "1.8 km from center",
      "tags": ["Free Parking", "Gym", "Restaurant"],
      "description": "Comfortable 3-star stay with modern amenities.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
    },
    {
      "image": "assets/images/img7.jpg",
      "discount": "20% Off",
      "name": "Sea View Resort",
      "location": "Marina Beach",
      "price": "\$350",
      "priceValue": 350,
      "rating": 4.9,
      "star": "7 star hotel",
      "starRating": 7,
      "reviews": 1563,
      "distance": "0.5 km from beach",
      "tags": ["Beach Front", "Luxury", "All Inclusive"],
      "description": "Beachfront luxury 7-star resort.",
      "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"],
    },
  ];

  final List<Map<String, dynamic>> _villas = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "15% Off",
      "name": "Luxury Beach Villa",
      "location": "ECR, Chennai",
      "price": "\$350",
      "priceValue": 350,
      "rating": 4.9,
      "villaType": "Luxury Villa",
      "bedrooms": 5,
      "capacity": 12,
      "reviews": 89,
      "distance": "0.2 km from beach",
      "tags": ["Private Pool", "Beach Access", "Butler Service"],
      "description": "Ultra-luxury beachfront villa with private pool.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "10% Off",
      "name": "Cozy Farm House",
      "location": "Kelambakkam",
      "price": "\$180",
      "priceValue": 180,
      "rating": 4.5,
      "villaType": "Farm House",
      "bedrooms": 3,
      "capacity": 8,
      "reviews": 45,
      "distance": "12 km from city",
      "tags": ["Organic Garden", "Bonfire", "BBQ"],
      "description": "Peaceful farm stay with organic experience.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
    },
  ];

  final List<Map<String, dynamic>> _apartments = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "12% Off",
      "name": "Service Apartment - 2BHK",
      "location": "OMR, Chennai",
      "price": "\$120",
      "priceValue": 120,
      "rating": 4.6,
      "apartmentType": "Service Apartment",
      "bhkType": "2 BHK",
      "bedrooms": 2,
      "capacity": 5,
      "reviews": 234,
      "distance": "1.5 km from IT park",
      "tags": ["Fully Furnished", "WiFi", "Kitchen"],
      "description": "Fully furnished service apartment with modern amenities.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "8% Off",
      "name": "Luxury Studio",
      "location": "Adyar",
      "price": "\$95",
      "priceValue": 95,
      "rating": 4.4,
      "apartmentType": "Studio Apartment",
      "bhkType": "Studio",
      "bedrooms": 1,
      "capacity": 3,
      "reviews": 156,
      "distance": "2 km from city center",
      "tags": ["Smart TV", "AC", "Gym Access"],
      "description": "Modern studio apartment with premium amenities.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
    },
  ];

  final List<Map<String, dynamic>> _resorts = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "20% Off",
      "name": "Luxury Beach Resort",
      "location": "Mahabalipuram",
      "price": "\$280",
      "priceValue": 280,
      "rating": 4.8,
      "resortCategory": "Beach Resort",
      "totalRooms": 45,
      "capacity": 120,
      "reviews": 567,
      "distance": "0.5 km from beach",
      "tags": ["Infinity Pool", "Spa", "Water Sports"],
      "description": "Premium beach resort with water sports activities.",
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"],
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "15% Off",
      "name": "Eco Forest Resort",
      "location": "Yelagiri",
      "price": "\$150",
      "priceValue": 150,
      "rating": 4.6,
      "resortCategory": "Eco Resort",
      "totalRooms": 25,
      "capacity": 75,
      "reviews": 234,
      "distance": "3 km from forest",
      "tags": ["Nature Trails", "Organic Food", "Tree Houses"],
      "description": "Eco-friendly resort amidst lush greenery.",
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"],
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimations();
  }

  void _initializeControllers() {
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _initializeAnimations() {
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Core Search Logic
  void _performSearch() {
    setState(() {
      _showResults = true;
      _searchResults = _filterPropertiesByType();
    });

    _scrollToTop();
  }

  List<Map<String, dynamic>> _filterPropertiesByType() {
    List<Map<String, dynamic>> results = [];

    switch (_selectedPropertyType) {
      case 'Hotel':
        results = _filterHotels();
        break;
      case 'Villa':
        results = _filterVillas();
        break;
      case 'Apartment':
        results = _filterApartments();
        break;
      case 'Resort':
        results = _filterResorts();
        break;
    }

    return results;
  }

  List<Map<String, dynamic>> _filterHotels() {
    return _hotels.where((hotel) {
      bool matches = true;

      matches = matches && _applyStarRatingFilter(hotel);
      matches = matches && _applyPriceFilter(hotel['priceValue']);

      if (_searchQuery != null && _searchQuery!.isNotEmpty) {
        matches = matches && hotel['name']
            .toLowerCase()
            .contains(_searchQuery!.toLowerCase());
      }

      return matches;
    }).toList();
  }

  bool _applyStarRatingFilter(Map<String, dynamic> property) {
    final starFilters = {
      "2 star hotel": 2,
      "3 star hotel": 3,
      "4 star hotel": 4,
      "5 star hotel": 5,
      "6 star hotel": 6,
      "7 star hotel": 7,
    };

    for (var entry in starFilters.entries) {
      if (_selectedFilters[entry.key] == true) {
        return property['starRating'] == entry.value;
      }
    }

    if (_selectedHotelStarRating != null && _selectedHotelStarRating != 'All') {
      int selectedStars = int.tryParse(_selectedHotelStarRating!.split('-')[0]) ?? 0;
      return property['starRating'] == selectedStars;
    }

    return true;
  }

  bool _applyPriceFilter(int price) {
    if (_selectedFilters["0 - 1500"] == true) return price <= 1500;
    if (_selectedFilters["1500 - 5000"] == true) return price >= 1500 && price <= 5000;
    if (_selectedFilters["5000 - 10000"] == true) return price >= 5000 && price <= 10000;
    if (_selectedFilters["10000+ above"] == true) return price > 10000;

    if (_selectedPriceRange != null && _selectedPriceRange != 'All') {
      return _checkPriceRange(price);
    }

    return true;
  }

  bool _checkPriceRange(int price) {
    switch (_selectedPriceRange) {
      case 'Under ₹1000':
        return price < 1000;
      case '₹1000 - ₹2000':
        return price >= 1000 && price <= 2000;
      case '₹2000 - ₹5000':
        return price >= 2000 && price <= 5000;
      case '₹5000+':
        return price > 5000;
      default:
        return true;
    }
  }

  List<Map<String, dynamic>> _filterVillas() {
    return _villas.where((villa) {
      bool matches = true;

      if (_selectedVillaType != null && _selectedVillaType != 'All') {
        matches = matches && villa['villaType'] == _selectedVillaType;
      }

      if (_selectedBedrooms != null && _selectedBedrooms != 0) {
        matches = matches && villa['bedrooms'] >= _selectedBedrooms!;
      }

      matches = matches && _applyPriceFilter(villa['priceValue']);

      if (_searchQuery != null && _searchQuery!.isNotEmpty) {
        matches = matches && villa['name']
            .toLowerCase()
            .contains(_searchQuery!.toLowerCase());
      }

      return matches;
    }).toList();
  }

  List<Map<String, dynamic>> _filterApartments() {
    return _apartments.where((apt) {
      bool matches = true;

      if (_selectedApartmentType != null && _selectedApartmentType != 'All') {
        matches = matches && apt['apartmentType'] == _selectedApartmentType;
      }

      if (_selectedBHKType != null && _selectedBHKType != 'All') {
        matches = matches && apt['bhkType'] == _selectedBHKType;
      }

      matches = matches && _applyPriceFilter(apt['priceValue']);

      if (_searchQuery != null && _searchQuery!.isNotEmpty) {
        matches = matches && apt['name']
            .toLowerCase()
            .contains(_searchQuery!.toLowerCase());
      }

      return matches;
    }).toList();
  }

  List<Map<String, dynamic>> _filterResorts() {
    return _resorts.where((resort) {
      bool matches = true;

      if (_selectedResortCategory != null && _selectedResortCategory != 'All') {
        matches = matches && resort['resortCategory'] == _selectedResortCategory;
      }

      matches = matches && _applyPriceFilter(resort['priceValue']);

      if (_searchQuery != null && _searchQuery!.isNotEmpty) {
        matches = matches && resort['name']
            .toLowerCase()
            .contains(_searchQuery!.toLowerCase());
      }

      return matches;
    }).toList();
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _selectDate(bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? (_checkInDate ?? DateTime.now())
          : (_checkOutDate ??
          (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
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

  void _openAllFiltersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
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
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(top: 12, bottom: 12),
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
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              _buildFilterSection("PRICE PER NIGHT", [
                                "0 - 1500",
                                "1500 - 5000",
                                "5000 - 10000",
                                "10000+ above",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildMealsFilterSection("MEALS OPTION", [
                                "All meals with Tea/Coffee & Snacks included",
                                "Breakfast Included",
                                "Lunch Included",
                                "Dinner Included",
                                "Tea/Coffee & Snacks Included",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildPropertyTypeSection("PROPERTY TYPE", [
                                "Hotel",
                                "Service Apartment",
                                "Villa",
                                "Homestay",
                                "Resort",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildFilterSection("OTHER POPULAR AMENITIES", [
                                "AC",
                                "Non AC",
                                "Wi-Fi",
                                "Swimming pool",
                                "Restaurant",
                                "Parking",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildFilterSection("ROOM VIEWS", [
                                "Garden view",
                                "City view",
                                "Beach view",
                                "Farming view",
                                "Forest view",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildFilterSection("CUSTOMER DEALS", [
                                "Normal deals",
                                "Last minute deals",
                                "Rush deals",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildFilterSection("CANCELLATION POLICY", [
                                "Free Cancellation",
                                "Cancellation With Penalty",
                              ], setStateSB),
                              const SizedBox(height: 12),
                              _buildHotelRulesSection("HOTEL RULES", setStateSB),
                              const SizedBox(height: 12),
                              _buildFilterSection("FREQUENTLY USED", [
                                "Hotel",
                                "Service Apartment",
                                "Villa",
                                "Homestay",
                                "Resort",
                                "Beach",
                                "5 star hotel",
                              ], setStateSB),
                              const SizedBox(height: 30),
                              Container(
                                width: double.infinity,
                                height: 54,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF7043),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: const Center(
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
                              const SizedBox(height: 30),
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

  Widget _buildPropertyTypeSection(String title, List<String> options, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;

    final List<String> allPropertyOptions = [
      "Hotel",
      "Service Apartment",
      "Villa",
      "Homestay",
      "Resort",
    ];

    final List<String> hotelStarOptions = [
      "Normal hotel",
      "2 star hotel",
      "3 star hotel",
      "4 star hotel",
      "5 star hotel",
      "6 star hotel",
      "7 star hotel",
    ];

    final List<String> resortTypeOptions = [
      "Beach Resort",
      "Farming Resort",
      "Forest Resort",
    ];

    String? _getSelectedPropertyType() {
      for (var option in allPropertyOptions) {
        if (_selectedFilters[option] == true) return option;
      }
      return null;
    }

    String? _getSelectedHotelStar() {
      for (var starOption in hotelStarOptions) {
        if (_selectedFilters[starOption] == true) return starOption;
      }
      return null;
    }

    String? _getSelectedResortType() {
      for (var resortType in resortTypeOptions) {
        if (_selectedFilters[resortType] == true) return resortType;
      }
      return null;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
                        color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                children: allPropertyOptions.map((propertyType) {
                  final bool isSelected = _selectedFilters[propertyType] == true;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: propertyType,
                              groupValue: _getSelectedPropertyType(),
                              onChanged: (value) {
                                setStateSB(() {
                                  for (var option in allPropertyOptions) {
                                    _selectedFilters[option] = false;
                                  }
                                  if (value != "Hotel") {
                                    for (var starOption in hotelStarOptions) {
                                      _selectedFilters[starOption] = false;
                                    }
                                  }
                                  if (value != "Resort") {
                                    for (var resortType in resortTypeOptions) {
                                      _selectedFilters[resortType] = false;
                                    }
                                  }
                                  _selectedFilters[value!] = true;
                                });
                              },
                              activeColor: const Color(0xFFFF7043),
                            ),
                            Expanded(
                              child: Text(
                                propertyType,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isSelected && propertyType == "Hotel")
                          Padding(
                            padding: const EdgeInsets.only(left: 32, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Star Rating (Optional):",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: hotelStarOptions.map((starOption) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: starOption,
                                            groupValue: _getSelectedHotelStar(),
                                            onChanged: (value) {
                                              setStateSB(() {
                                                for (var opt in hotelStarOptions) {
                                                  _selectedFilters[opt] = false;
                                                }
                                                _selectedFilters[value as String] = true;
                                              });
                                            },
                                            activeColor: const Color(0xFFFF7043),
                                          ),
                                          Expanded(
                                            child: Text(
                                              starOption,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        if (isSelected && propertyType == "Resort")
                          Padding(
                            padding: const EdgeInsets.only(left: 32, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Resort Type (Optional):",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...resortTypeOptions.map((resortType) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: resortType,
                                          groupValue: _getSelectedResortType(),
                                          onChanged: (value) {
                                            setStateSB(() {
                                              for (var opt in resortTypeOptions) {
                                                _selectedFilters[opt] = false;
                                              }
                                              _selectedFilters[value as String] = true;
                                            });
                                          },
                                          activeColor: const Color(0xFFFF7043),
                                        ),
                                        Expanded(
                                          child: Text(
                                            resortType,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
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
                }).toList(),
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
          color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                children: options.map((option) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        if (isSingleSelect)
                          Radio<String>(
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
                            activeColor: const Color(0xFFFF7043),
                          )
                        else
                          Checkbox(
                            value: _selectedFilters[option] ?? false,
                            onChanged: (val) {
                              setStateSB(() {
                                _selectedFilters[option] = val ?? false;
                              });
                            },
                            activeColor: const Color(0xFFFF7043),
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

  Widget _buildMealsFilterSection(String title, List<String> options, StateSetter setStateSB) {
    final isExpanded = _expandedFilter == title;
    final isAllMealsSelected = _selectedFilters["All meals with Tea/Coffee & Snacks included"] ?? false;
    final bool isMealsOption = title == "MEALS OPTION";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
                        color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isDisabled ? false : (_selectedFilters[option] ?? false),
                          onChanged: isDisabled
                              ? null
                              : (val) {
                            setStateSB(() {
                              _selectedFilters[option] = val ?? false;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
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
          color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.3) : Colors.grey[200]!,
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded ? const Color(0xFFFF7043).withOpacity(0.05) : Colors.white,
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
                        color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[800],
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: isExpanded ? const Color(0xFFFF7043) : Colors.grey[500],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[100]!)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pets",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Allowed"),
                          value: "Pets allowed",
                          groupValue: selectedPets,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Pets allowed"] = false;
                              _selectedFilters["Pets not allowed"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Not Allowed"),
                          value: "Pets not allowed",
                          groupValue: selectedPets,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Pets allowed"] = false;
                              _selectedFilters["Pets not allowed"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey),
                  Text(
                    "Smoking",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Allowed"),
                          value: "Smoking allowed",
                          groupValue: selectedSmoking,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Smoking allowed"] = false;
                              _selectedFilters["Smoking not allowed"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Not Allowed"),
                          value: "Smoking not allowed",
                          groupValue: selectedSmoking,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Smoking allowed"] = false;
                              _selectedFilters["Smoking not allowed"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey),
                  Text(
                    "Outside Food",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Allowed"),
                          value: "Outside food allowed",
                          groupValue: selectedOutsideFood,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Outside food allowed"] = false;
                              _selectedFilters["No outside food"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text("Not Allowed"),
                          value: "No outside food",
                          groupValue: selectedOutsideFood,
                          onChanged: (value) {
                            setStateSB(() {
                              _selectedFilters["Outside food allowed"] = false;
                              _selectedFilters["No outside food"] = false;
                              _selectedFilters[value!] = true;
                            });
                          },
                          activeColor: const Color(0xFFFF7043),
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

  String? _getSelectedOptionForSingleSelect(String title) {
    if (title == "PRICE PER NIGHT") {
      final List<String> priceOptions = [
        "0 - 1500",
        "1500 - 5000",
        "5000 - 10000",
        "10000+ above",
      ];
      for (var option in priceOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "STAR RATING") {
      final List<String> starOptions = [
        "Normal hotel",
        "2 star hotel",
        "3 star hotel",
        "4 star hotel",
        "5 star hotel",
        "6 star hotel",
        "7 star hotel",
      ];
      for (var option in starOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "CANCELLATION POLICY") {
      final List<String> cancelOptions = [
        "Free Cancellation",
        "Cancellation With Penalty",
      ];
      for (var option in cancelOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "PROPERTY TYPE") {
      final List<String> propertyOptions = [
        "Hotel",
        "Service Apartment",
        "Villa",
        "Homestay",
        "Resort",
        "Beach Resort",
        "Farming Resort",
        "Forest Resort",
      ];
      for (var option in propertyOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "CUSTOMER DEALS") {
      final List<String> dealOptions = [
        "Normal deals",
        "Last minute deals",
        "Rush deals",
      ];
      for (var option in dealOptions) {
        if (_selectedFilters[option] == true) return option;
      }
    } else if (title == "ROOM VIEWS") {
      final List<String> viewOptions = [
        "Garden view",
        "City view",
        "Beach view",
        "Farming view",
        "Forest view",
      ];
      for (var option in viewOptions) {
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
                      margin: const EdgeInsets.only(bottom: 16),
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
                  ...options.map(
                        (opt) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          if (isSingleSelect)
                            Radio<String>(
                              value: opt,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setStateSB(() {
                                  selectedOption = value;
                                });
                              },
                              activeColor: const Color(0xFFFF7043),
                            )
                          else
                            Checkbox(
                              value: _selectedFilters[opt] ?? false,
                              onChanged: (val) {
                                setStateSB(() {
                                  _selectedFilters[opt] = val ?? false;
                                });
                              },
                              activeColor: const Color(0xFFFF7043),
                            ),
                          Expanded(child: Text(opt)),
                        ],
                      ),
                    ),
                  ),
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
                        backgroundColor: const Color(0xFFFF7043),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "APPLY",
                        style: TextStyle(color: Colors.white),
                      ),
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
          colors: [const Color(0xFFFF7043), const Color(0xFFFF8A65)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 10),
              const Text(
                "WanderStay",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Discover your perfect stay with exclusive deals ✨",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).padding.bottom),
            child: Column(
              children: [
                _buildOffersCarousel(),
                const SizedBox(height: 30),
                _buildPropertyTypeSelector(),
                const SizedBox(height: 20),
                _buildSearchField(),
                const SizedBox(height: 20),
                _buildDateSelection(),
                const SizedBox(height: 20),
                _buildCounters(),
                const SizedBox(height: 20),
                _buildPropertySpecificFilters(),
                const SizedBox(height: 20),
                _buildPriceRangeFilter(),
                const SizedBox(height: 20),
                _buildPurposeSelection(),
                const SizedBox(height: 30),
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
        const Text(
          "🔥 Exclusive Offers",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 15),
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
      {"title": "Weekend Getaway", "subtitle": "Up to 40% off on luxury stays", "color": Colors.orange, "icon": Icons.weekend},
      {"title": "Long Stay Discount", "subtitle": "Special rates for 7+ nights", "color": Colors.purple, "icon": Icons.calendar_today},
      {"title": "Early Bird Special", "subtitle": "Book 30 days in advance & save", "color": Colors.blue, "icon": Icons.alarm},
    ];

    var offer = offers[index - 1];

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [offer["color"], offer["color"].withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: offer["color"].withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(right: -20, top: -20, child: Icon(offer["icon"], size: 80, color: Colors.white.withOpacity(0.1))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(offer["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(offer["subtitle"], style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9))),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeSelector() {
    List<Map<String, dynamic>> propertyTypes = [
      {"name": "Hotel", "icon": Icons.hotel, "color": Colors.orange},
      {"name": "Villa", "icon": Icons.villa, "color": Colors.green},
      {"name": "Apartment", "icon": Icons.apartment, "color": Colors.blue},
      {"name": "Resort", "icon": Icons.beach_access, "color": Colors.purple},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: propertyTypes.map((type) {
          bool isSelected = _selectedPropertyType == type["name"];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPropertyType = type["name"];
                  _selectedHotelStarRating = null;
                  _selectedVillaType = null;
                  _selectedApartmentType = null;
                  _selectedResortCategory = null;
                  _selectedPriceRange = null;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? (type["color"] as Color).withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(type["icon"], color: isSelected ? type["color"] : Colors.grey, size: 28),
                    const SizedBox(height: 4),
                    Text(
                      type["name"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? type["color"] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TextField(
        onChanged: (value) => _searchQuery = value,
        decoration: InputDecoration(
          hintText: "Where do you want to stay?",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFFF7043)),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        Expanded(child: _buildDateCard("Check-in", _checkInDate, true)),
        const SizedBox(width: 12),
        Expanded(child: _buildDateCard("Check-out", _checkOutDate, false)),
      ],
    );
  }

  Widget _buildDateCard(String label, DateTime? date, bool isCheckIn) {
    return GestureDetector(
      onTap: () => _selectDate(isCheckIn),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: const Color(0xFFFF7043)),
                const SizedBox(width: 8),
                Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              date != null ? DateFormat('MMM dd, yyyy').format(date) : "Select date",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounters() {
    return Column(
      children: [
        _buildCounter("Rooms", _roomCount, 1, 5, () => setState(() => _roomCount--), () => setState(() => _roomCount++)),
        _buildCounter("Adults", _adultCount, 1, 10, () => setState(() => _adultCount--), () => setState(() => _adultCount++)),
        _buildCounter("Children", _childCount, 0, 5, () => setState(() => _childCount--), () => setState(() => _childCount++)),
      ],
    );
  }

  Widget _buildCounter(String label, int value, int min, int max, Function onMinus, Function onPlus) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[800])),
          Row(
            children: [
              _buildIconButton(icon: Icons.remove, onPressed: value > min ? () => onMinus() : null, isEnabled: value > min),
              Container(width: 40, alignment: Alignment.center, child: Text("$value", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFF7043)))),
              _buildIconButton(icon: Icons.add, onPressed: value < max ? () => onPlus() : null, isEnabled: value < max),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback? onPressed, required bool isEnabled}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: isEnabled ? const Color(0xFFFF7043) : Colors.grey[300], shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon, size: 15),
        color: Colors.white,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildPropertySpecificFilters() {
    switch (_selectedPropertyType) {
      case 'Hotel':
        return _buildDropdownFilter(
          "Star Rating",
          ["All", "2-Star", "3-Star", "4-Star", "5-Star", "6-Star", "7-Star"],
          _selectedHotelStarRating,
              (value) => setState(() => _selectedHotelStarRating = value),
        );
      case 'Villa':
        return Column(
          children: [
            _buildDropdownFilter("Villa Type", ["All", "Luxury Villa", "Beach Villa", "Pool Villa", "Farm House", "Budget Villa"], _selectedVillaType, (value) => setState(() => _selectedVillaType = value)),
            const SizedBox(height: 12),
            _buildDropdownFilter("Bedrooms", ["All", "1", "2", "3", "4", "5+"], _selectedBedrooms?.toString(), (value) => setState(() => _selectedBedrooms = value == "5+" ? 5 : int.tryParse(value ?? "0"))),
          ],
        );
      case 'Apartment':
        return Column(
          children: [
            _buildDropdownFilter("Apartment Type", ["All", "Service Apartment", "Studio Apartment", "Luxury Apartment", "Budget Apartment", "Entire Apartment", "Shared Apartment"], _selectedApartmentType, (value) => setState(() => _selectedApartmentType = value)),
            const SizedBox(height: 12),
            _buildDropdownFilter("BHK Type", ["All", "1 BHK", "2 BHK", "3 BHK", "4 BHK", "5 BHK+"], _selectedBHKType, (value) => setState(() => _selectedBHKType = value)),
          ],
        );
      case 'Resort':
        return _buildDropdownFilter("Resort Category", ["All", "Luxury", "Boutique", "Eco Resort", "Beach Resort", "Hill Resort", "Farm Resort"], _selectedResortCategory, (value) => setState(() => _selectedResortCategory = value));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDropdownFilter(String label, List<String> options, String? selectedValue, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          DropdownButton<String>(
            value: selectedValue ?? options.first,
            underline: const SizedBox(),
            items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeFilter() {
    List<String> priceRanges = ["All", "Under ₹1000", "₹1000 - ₹2000", "₹2000 - ₹5000", "₹5000+"];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        children: [
          const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w600)),
          const Spacer(),
          DropdownButton<String>(
            value: _selectedPriceRange ?? priceRanges.first,
            underline: const SizedBox(),
            items: priceRanges.map((range) => DropdownMenuItem(value: range, child: Text(range))).toList(),
            onChanged: (value) => setState(() => _selectedPriceRange = value),
          ),
        ],
      ),
    );
  }

  Widget _buildPurposeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Purpose of stay", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _purposeOptions.map((purpose) {
            final isSelected = _selectedPurpose == purpose;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: FilterChip(
                label: Text(purpose),
                selected: isSelected,
                selectedColor: const Color(0xFFFF7043),
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.grey[700], fontWeight: FontWeight.w500),
                onSelected: (_) => setState(() => _selectedPurpose = purpose),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        gradient: const LinearGradient(colors: [Color(0xFFFF7043), Color(0xFFFF8A65)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _performSearch,
          borderRadius: BorderRadius.circular(15),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text("SEARCH PROPERTIES", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsView() {
    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text("🏨 Popular in Chennai", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text("${_searchResults.length} properties", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 5),
                Text("Find the best ${_selectedPropertyType.toLowerCase()}s for your stay", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 20),
                Column(
                  children: _searchResults.asMap().entries.map((entry) {
                    final index = entry.key;
                    final property = entry.value;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: _buildPropertyCard(property, index),
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

  Widget _buildFilterChips() {
    List<Map<String, dynamic>> filters = [
      {"label": "All Filters", "icon": Icons.filter_list, "onTap": () => _openAllFiltersSheet(context)},
      {"label": "Price", "icon": Icons.attach_money, "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"])},
      {"label": "Rating", "icon": Icons.star, "onTap": () => _openSingleCategory(context, "STAR RATING", ["Normal hotel", "2 star hotel", "3 star hotel", "4 star hotel", "5 star hotel", "6 star hotel", "7 star hotel"])},
      {"label": "Amenities", "icon": Icons.wifi, "onTap": () => _openSingleCategory(context, "OTHER POPULAR AMENITIES", ["Wi-Fi", "Swimming pool", "Spa", "Cafe", "Restaurant", "Gym", "Parking", "Airport Shuttle"])},
      {"label": "Distance", "icon": Icons.location_on, "onTap": () => _openSingleCategory(context, "DISTANCE", ["0-2 km", "2-5 km", "5-10 km", "10+ km"])},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: FilterChip(
              label: Text(filter["label"]),
              avatar: Icon(filter["icon"], size: 18),
              onSelected: (_) => filter["onTap"](),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> property, int index) {
    int starRating = property["starRating"] ?? 3;

    return GestureDetector(
      onTap: () {
        if (_selectedPropertyType == 'Hotel') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: property, starRating: starRating)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("View ${property['name']} details"), backgroundColor: const Color(0xFFFF7043)));
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(property["image"], height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 180, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image, size: 50)))),
                  ),
                  if (property.containsKey('discount'))
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                        child: Text(property["discount"], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
                    ),
                  ),
                  if (property.containsKey('starRating'))
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: _getStarColor(starRating).withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(property["star"] ?? "$starRating-star Hotel", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(property["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        Row(children: [const Icon(Icons.star, color: Colors.orange, size: 18), const SizedBox(width: 4), Text(property["rating"].toString())]),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(property["location"], style: TextStyle(color: Colors.grey, fontSize: 14))]),
                    const SizedBox(height: 8),
                    Text(property["distance"], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (property["tags"] as List<String>).take(3).map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12)),
                        child: Text(tag, style: TextStyle(color: Colors.blue[700], fontSize: 12)),
                      )).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(property["price"], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF7043))),
                        const Text("/night", style: TextStyle(color: Colors.grey)),
                        const Spacer(),
                        Text("${property["reviews"]} reviews", style: TextStyle(color: Colors.grey)),
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
      case 7: return Colors.purple;
      case 6: return Colors.deepPurple;
      case 5: return Colors.amber;
      case 4: return Colors.lightGreen;
      case 3: return Colors.orange;
      default: return Colors.orange;
    }
  }

  String _getStarRatingText(int stars) {
    switch (stars) {
      case 7: return "7-Star Luxury Hotel";
      case 5: return "5-Star Premium Hotel";
      case 3: return "3-Star Comfort Hotel";
      default: return "${stars}-Star Hotel";
    }
  }

  // The missing build method - this is the main UI builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _showResults
                  ? _buildResultsView()
                  : _buildSearchForm(),
            ),
          ),
        ],
      ),
    );
  }
}



