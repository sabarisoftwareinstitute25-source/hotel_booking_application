
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:hotel_booking_mobile_application/home_screen/payment_screen.dart';
// import 'food_details_screen.dart';
//
// class HotelDetailsScreen extends StatefulWidget {
//   final Map<String, dynamic> hotel;
//   final int starRating;
//
//   const HotelDetailsScreen({
//     super.key,
//     required this.hotel,
//     required this.starRating,
//   });
//
//   @override
//   State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
// }
//
// class _HotelDetailsScreenState extends State<HotelDetailsScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<Color?> _colorAnimation;
//
//   final ScrollController _scrollController = ScrollController();
//   double _scrollOffset = 0.0;
//   bool _showTitle = false;
//
//   int _selectedCategory = 0;
//   final List<String> _categories = ["All", "Veg", "Non veg"];
//
//   int _selectedRating = 0;
//
//   final Map<String, int> _cart = {};
//
//   final List<Map<String, dynamic>> _foodItems = [
//     {
//       "name": "Chicken Biryani",
//       "rating": 3.5,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 10.0,
//       "discount": 25.0,
//       "isVeg": false,
//       "image": "assets/images/chicken-biryani.jpg",
//     },
//     {
//       "name": "Crispy mozza burger",
//       "rating": 3.9,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 8.0,
//       "discount": 25.0,
//       "isVeg": false,
//       "image": "assets/images/burger.jpeg",
//     },
//     {
//       "name": "Sandwich",
//       "rating": 3.9,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 5.0,
//       "discount": 25.0,
//       "isVeg": true,
//       "image": "assets/images/paneer-sandwich.jpg",
//     },
//     {
//       "name": "Meals",
//       "rating": 3.9,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 5.0,
//       "discount": 25.0,
//       "isVeg": true,
//       "image": "assets/images/meals.jpg",
//     },
//     {
//       "name": "Mutton Briyani",
//       "rating": 3.9,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 5.0,
//       "discount": 25.0,
//       "isVeg": false,
//       "image": "assets/images/mutton-biryani.jpg",
//     },
//     {
//       "name": "Chappathi",
//       "rating": 3.9,
//       "reviews": 2001,
//       "description": "neque, amet blandit tincidunt vulputate",
//       "price": 5.0,
//       "discount": 25.0,
//       "isVeg": true,
//       "image": "assets/images/chapathi.webp",
//     },
//   ];
//
//
//   List<String> _getAmenitiesBasedOnStars(int stars) {
//     print("Getting amenities for $stars star hotel");
//
//     switch (stars) {
//       case 7:
//         return [
//           "⭐ Private Butler Service (24/7)",
//           "⭐ Smart Room Automation System",
//           "⭐ Panoramic Ocean/City Views",
//           "⭐ Gold-Plated Bathroom Fixtures",
//           "⭐ Private Jacuzzi in Every Room",
//           "⭐ Michelin-Star Restaurants (3+)",
//           "⭐ Personal Chef Available",
//           "⭐ Helicopter Transfers Airport",
//           "⭐ Infinity Pool with Butler Service",
//           "⭐ Luxury Spa with Global Treatments",
//           "⭐ Private Cinema Room",
//           "⭐ Biometric Security System",
//           "⭐ 24/7 Concierge & Personal Assistant",
//           "⭐ Private Beach Access",
//           "⭐ Fine Dining Restaurants (5+)",
//           "⭐ Champagne on Arrival",
//           "⭐ Personal Shopping Assistant",
//           "⭐ Limousine Service",
//           "⭐ Yacht Access (Complementary)",
//           "⭐ Diamond Tier Rewards Program",
//         ];
//       case 5:
//         return [
//           "✓ Luxury King Size Beds",
//           "✓ High-Speed Wi-Fi (Premium)",
//           "✓ Smart TV with Netflix",
//           "✓ Mini Bar (Stocked Daily)",
//           "✓ Nespresso Coffee Machine",
//           "✓ Marble Bathroom with Heated Floors",
//           "✓ Rain Shower & Deep Soaking Bathtub",
//           "✓ Premium Toiletries (L'Occitane)",
//           "✓ 24-Hour Room Dining",
//           "✓ Multiple Restaurants (International)",
//           "✓ Swimming Pool (Temperature Controlled)",
//           "✓ Spa & Wellness Center",
//           "✓ Fitness Center (24/7 Access)",
//           "✓ Concierge Service",
//           "✓ Valet Parking",
//           "✓ Business Center",
//           "✓ Meeting Rooms Available",
//           "✓ Kids Club",
//           "✓ Tennis Court",
//           "✓ Airport Shuttle Service",
//         ];
//       case 3:
//       default:
//         return [
//           "✓ Air Conditioning",
//           "✓ Free Wi-Fi",
//           "✓ TV with Cable Channels",
//           "✓ Comfortable Queen/King Bed",
//           "✓ Attached Bathroom",
//           "✓ Hot & Cold Water 24/7",
//           "✓ Basic Toiletries",
//           "✓ Restaurant (Breakfast Included)",
//           "✓ Complimentary Breakfast",
//           "✓ 24-Hour Front Desk",
//           "✓ Daily Housekeeping",
//           "✓ Parking (Free/Paid)",
//           "✓ Laundry Service",
//           "✓ CCTV Security",
//           "✓ Elevator/Lift",
//           "✓ Power Backup",
//           "✓ Luggage Storage",
//           "✓ Travel Desk",
//           "✓ Room Service (Limited Hours)",
//           "✓ Iron & Ironing Board (On Request)",
//         ];
//     }
//   }
//
//
//   String _getStarRatingText(int stars) {
//     switch (stars) {
//       case 7:
//         return "7-Star Luxury Hotel";
//       case 5:
//         return "5-Star Premium Hotel";
//       case 3:
//       default:
//         return "3-Star Comfort Hotel";
//     }
//   }
//
//
//   Color _getStarRatingColor(int stars) {
//     switch (stars) {
//       case 7:
//         return Color(0xFF9C27B0);
//       case 5:
//         return Color(0xFFFF9800);
//       case 3:
//       default:
//         return Color(0xFFFF5722);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     print("Hotel Details Screen initialized with star rating: ${widget.starRating}");
//     print("Hotel name: ${widget.hotel["name"]}");
//     print("Hotel star text: ${widget.hotel["star"]}");
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     _colorAnimation = ColorTween(begin: Colors.transparent, end: Colors.white)
//         .animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//       ),
//     );
//
//     _controller.forward();
//
//     _scrollController.addListener(() {
//       setState(() {
//         _scrollOffset = _scrollController.offset;
//         _showTitle = _scrollOffset > 180;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   // Widget build(BuildContext context) {
//   //
//   //   final int hotelStars = widget.starRating;
//   //   final amenities = _getAmenitiesBasedOnStars(hotelStars);
//   //   final starRatingText = _getStarRatingText(hotelStars);
//   //   final starRatingColor = _getStarRatingColor(hotelStars);
//   //
//   //
//   //   print("Building HotelDetailsScreen with $hotelStars stars");
//   //   print("Amenities count: ${amenities.length}");
//   //
//   //   return Scaffold(
//   //     backgroundColor: Colors.grey[50],
//   //     body: CustomScrollView(
//   //       controller: _scrollController,
//   //       slivers: [
//   //         SliverAppBar(
//   //           expandedHeight: 300,
//   //           pinned: true,
//   //           backgroundColor: Colors.white,
//   //           elevation: 2,
//   //           title: AnimatedOpacity(
//   //             opacity: _showTitle ? 1.0 : 0.0,
//   //             duration: const Duration(milliseconds: 200),
//   //             child: Align(
//   //               alignment: Alignment.topCenter,
//   //               child: Text(
//   //                 widget.hotel["name"] ?? "",
//   //                 style: const TextStyle(
//   //                   color: Colors.black,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //           iconTheme: const IconThemeData(color: Colors.white),
//   //           flexibleSpace: FlexibleSpaceBar(
//   //             collapseMode: CollapseMode.parallax,
//   //             title: AnimatedOpacity(
//   //               opacity: _showTitle ? 0.0 : 1.0,
//   //               duration: const Duration(milliseconds: 200),
//   //               child: Align(
//   //                 alignment: Alignment.centerLeft,
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     mainAxisSize: MainAxisSize.min,
//   //                     children: [
//   //                       Text(
//   //                         widget.hotel["name"] ?? "",
//   //                         style: const TextStyle(
//   //                           color: Colors.white,
//   //                           fontWeight: FontWeight.bold,
//   //                           fontSize: 16,
//   //                           shadows: [
//   //                             Shadow(
//   //                               color: Colors.black54,
//   //                               offset: Offset(1, 1),
//   //                               blurRadius: 10,
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                       SizedBox(height: 4),
//   //                       Container(
//   //                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//   //                         decoration: BoxDecoration(
//   //                           color: starRatingColor.withOpacity(0.8),
//   //                           borderRadius: BorderRadius.circular(4),
//   //                         ),
//   //                         child: Text(
//   //                           starRatingText,
//   //                           style: TextStyle(
//   //                             color: Colors.white,
//   //                             fontSize: 10,
//   //                             fontWeight: FontWeight.bold,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //             background: Stack(
//   //               children: [
//   //                 Hero(
//   //                   tag: widget.hotel["image"],
//   //                   child: Image.asset(
//   //                     widget.hotel["image"],
//   //                     fit: BoxFit.cover,
//   //                     height: double.infinity,
//   //                     width: double.infinity,
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   decoration: BoxDecoration(
//   //                     gradient: LinearGradient(
//   //                       begin: Alignment.topCenter,
//   //                       end: Alignment.bottomCenter,
//   //                       colors: [
//   //                         Colors.transparent,
//   //                         Colors.black.withOpacity(0.4),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //
//   //         SliverToBoxAdapter(
//   //           child: AnimatedBuilder(
//   //             animation: _controller,
//   //             builder: (context, child) {
//   //               return Transform.translate(
//   //                 offset: Offset(0, _slideAnimation.value),
//   //                 child: Opacity(opacity: _fadeAnimation.value, child: child),
//   //               );
//   //             },
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(16),
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   // Star Rating Banner
//   //                   Container(
//   //                     padding: const EdgeInsets.all(16),
//   //                     decoration: BoxDecoration(
//   //                       color: starRatingColor.withOpacity(0.1),
//   //                       borderRadius: BorderRadius.circular(16),
//   //                       border: Border.all(color: starRatingColor.withOpacity(0.3)),
//   //                     ),
//   //                     child: Row(
//   //                       children: [
//   //                         Container(
//   //                           padding: EdgeInsets.all(8),
//   //                           decoration: BoxDecoration(
//   //                             color: starRatingColor,
//   //                             shape: BoxShape.circle,
//   //                           ),
//   //                           child: Icon(
//   //                             Icons.star,
//   //                             color: Colors.white,
//   //                             size: 24,
//   //                           ),
//   //                         ),
//   //                         SizedBox(width: 12),
//   //                         Expanded(
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: [
//   //                               Text(
//   //                                 starRatingText,
//   //                                 style: TextStyle(
//   //                                   fontSize: 18,
//   //                                   fontWeight: FontWeight.bold,
//   //                                   color: starRatingColor,
//   //                                 ),
//   //                               ),
//   //                               SizedBox(height: 4),
//   //                               Text(
//   //                                 "Enjoy exclusive ${hotelStars}-star luxury amenities and premium services",
//   //                                 style: TextStyle(
//   //                                   fontSize: 12,
//   //                                   color: Colors.grey[700],
//   //                                 ),
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   SizedBox(height: 20),
//   //
//   //                   Container(
//   //                     padding: const EdgeInsets.all(16),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.white,
//   //                       borderRadius: BorderRadius.circular(16),
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           color: Colors.grey.withOpacity(0.1),
//   //                           blurRadius: 10,
//   //                           offset: const Offset(0, 5),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                     child: Row(
//   //                       children: [
//   //                         Container(
//   //                           padding: const EdgeInsets.symmetric(
//   //                             horizontal: 8,
//   //                             vertical: 4,
//   //                           ),
//   //                           decoration: BoxDecoration(
//   //                             color: Colors.orange[50],
//   //                             borderRadius: BorderRadius.circular(8),
//   //                           ),
//   //                           child: Row(
//   //                             children: [
//   //                               const Icon(
//   //                                 Icons.star,
//   //                                 color: Colors.orange,
//   //                                 size: 18,
//   //                               ),
//   //                               const SizedBox(width: 4),
//   //                               Text(
//   //                                 "${widget.hotel["rating"]}",
//   //                                 style: const TextStyle(
//   //                                   fontSize: 14,
//   //                                   fontWeight: FontWeight.bold,
//   //                                 ),
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                         const SizedBox(width: 10),
//   //                         const Text(
//   //                           "Very Good",
//   //                           style: TextStyle(fontSize: 14, color: Colors.grey),
//   //                         ),
//   //                         const Spacer(),
//   //                         Icon(
//   //                           Icons.location_on,
//   //                           color: Colors.grey[400],
//   //                           size: 18,
//   //                         ),
//   //                         const SizedBox(width: 4),
//   //                         Text(
//   //                           widget.hotel["location"],
//   //                           style: TextStyle(
//   //                             color: Colors.grey[600],
//   //                             fontSize: 14,
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   const SizedBox(height: 20),
//   //
//   //                   // Hotel Features based on star rating
//   //                   Container(
//   //                     padding: const EdgeInsets.all(16),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.white,
//   //                       borderRadius: BorderRadius.circular(16),
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           color: Colors.grey.withOpacity(0.1),
//   //                           blurRadius: 10,
//   //                           offset: const Offset(0, 5),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Row(
//   //                           children: [
//   //                             Icon(
//   //                               Icons.emoji_events,
//   //                               color: starRatingColor,
//   //                             ),
//   //                             SizedBox(width: 8),
//   //                             Text(
//   //                               "Premium Features",
//   //                               style: TextStyle(
//   //                                 fontSize: 18,
//   //                                 fontWeight: FontWeight.bold,
//   //                                 color: Colors.grey[800],
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                         SizedBox(height: 12),
//   //                         Text(
//   //                           "As a ${hotelStars}-star hotel, you'll enjoy:",
//   //                           style: TextStyle(
//   //                             fontSize: 14,
//   //                             color: Colors.grey[600],
//   //                           ),
//   //                         ),
//   //                         SizedBox(height: 12),
//   //                         ...amenities.take(3).map((amenity) {
//   //                           return Padding(
//   //                             padding: const EdgeInsets.symmetric(vertical: 4),
//   //                             child: Row(
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: [
//   //                                 Icon(
//   //                                   Icons.check_circle,
//   //                                   color: starRatingColor,
//   //                                   size: 16,
//   //                                 ),
//   //                                 SizedBox(width: 8),
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     amenity,
//   //                                     style: TextStyle(
//   //                                       fontSize: 14,
//   //                                       color: Colors.grey[700],
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           );
//   //                         }).toList(),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                   SizedBox(height: 20),
//   //
//   //                   Row(
//   //                     children: [
//   //                       Expanded(
//   //                         child: _infoButton(
//   //                           Icons.calendar_today,
//   //                           "Check-In",
//   //                           "12 Oct 2023",
//   //                         ),
//   //                       ),
//   //                       const SizedBox(width: 10),
//   //                       Expanded(
//   //                         child: _infoButton(Icons.people, "Guest", "2 Adults"),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   SizedBox(height: 20),
//   //
//   //                   _sectionCard(
//   //                     "Welcome Offer",
//   //                     "Get 20% off on your first stay. Use code WELCOME20 at checkout.",
//   //                     Icons.local_offer_outlined,
//   //                   ),
//   //                   SizedBox(height: 15),
//   //
//   //                   _sectionCard(
//   //                     "About this property",
//   //                     widget.hotel["description"] ?? "Premium hotel with excellent amenities and services.",
//   //                     Icons.info_outline,
//   //                   ),
//   //                   SizedBox(height: 15),
//   //
//   //
//   //                   Container(
//   //                     padding: const EdgeInsets.all(16),
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.white,
//   //                       borderRadius: BorderRadius.circular(16),
//   //                       boxShadow: [
//   //                         BoxShadow(
//   //                           color: Colors.grey.withOpacity(0.1),
//   //                           blurRadius: 10,
//   //                           offset: const Offset(0, 5),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text(
//   //                           "All ${hotelStars}-Star Amenities",
//   //                           style: TextStyle(
//   //                             fontSize: 18,
//   //                             fontWeight: FontWeight.bold,
//   //                             color: Colors.grey[800],
//   //                           ),
//   //                         ),
//   //                         SizedBox(height: 12),
//   //                         Text(
//   //                           "Complete list of amenities for your ${hotelStars}-star experience:",
//   //                           style: TextStyle(
//   //                             fontSize: 14,
//   //                             color: Colors.grey[600],
//   //                           ),
//   //                         ),
//   //                         SizedBox(height: 16),
//   //                         Column(
//   //                           children: amenities.map((amenity) {
//   //                             return Padding(
//   //                               padding: const EdgeInsets.symmetric(vertical: 8),
//   //                               child: Row(
//   //                                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                                 children: [
//   //                                   Container(
//   //                                     width: 24,
//   //                                     height: 24,
//   //                                     decoration: BoxDecoration(
//   //                                       color: starRatingColor.withOpacity(0.1),
//   //                                       shape: BoxShape.circle,
//   //                                     ),
//   //                                     child: Center(
//   //                                       child: Icon(
//   //                                         _getAmenityIcon(amenity),
//   //                                         size: 12,
//   //                                         color: starRatingColor,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(width: 12),
//   //                                   Expanded(
//   //                                     child: Text(
//   //                                       amenity,
//   //                                       style: TextStyle(
//   //                                         fontSize: 14,
//   //                                         color: Colors.grey[700],
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                             );
//   //                           }).toList(),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //
//   //                   const SizedBox(height: 30),
//   //                   _buildFoodCourtSection(),
//   //                   const SizedBox(height: 20),
//   //
//   //                   _reviewsSection(),
//   //                   const SizedBox(height: 30),
//   //
//   //                   SizedBox(
//   //                     width: double.infinity,
//   //                     child: ElevatedButton(
//   //                       onPressed: () {
//   //                         _showBookingDialog(context);
//   //                       },
//   //                       style: ElevatedButton.styleFrom(
//   //                         padding: const EdgeInsets.symmetric(
//   //                           horizontal: 50,
//   //                           vertical: 16,
//   //                         ),
//   //                         backgroundColor: Colors.deepOrange,
//   //                         shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(12),
//   //                         ),
//   //                         elevation: 2,
//   //                       ),
//   //                       child: const Text(
//   //                         "Book Now",
//   //                         style: TextStyle(
//   //                           fontSize: 18,
//   //                           fontWeight: FontWeight.bold,
//   //                           color: Colors.white,
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   const SizedBox(height: 30),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//
//     final int hotelStars = widget.starRating;
//     final amenities = _getAmenitiesBasedOnStars(hotelStars);
//     final starRatingText = _getStarRatingText(hotelStars);
//     final starRatingColor = _getStarRatingColor(hotelStars);
//
//
//     print("Building HotelDetailsScreen with $hotelStars stars");
//     print("Amenities count: ${amenities.length}");
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             backgroundColor: Colors.white,
//             elevation: 2,
//             title: AnimatedOpacity(
//               opacity: _showTitle ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 200),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Text(
//                   widget.hotel["name"] ?? "",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             iconTheme: const IconThemeData(color: Colors.white),
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.parallax,
//               title: AnimatedOpacity(
//                 opacity: _showTitle ? 0.0 : 1.0,
//                 duration: const Duration(milliseconds: 200),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           widget.hotel["name"] ?? "",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             shadows: [
//                               Shadow(
//                                 color: Colors.black54,
//                                 offset: Offset(1, 1),
//                                 blurRadius: 10,
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: starRatingColor.withOpacity(0.8),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Text(
//                             starRatingText,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               background: Stack(
//                 children: [
//                   Hero(
//                     tag: widget.hotel["image"],
//                     child: Image.asset(
//                       widget.hotel["image"],
//                       fit: BoxFit.cover,
//                       height: double.infinity,
//                       width: double.infinity,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.4),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           SliverToBoxAdapter(
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, _slideAnimation.value),
//                   child: Opacity(opacity: _fadeAnimation.value, child: child),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.calendar_today,
//                                       color: Colors.deepOrange,
//                                       size: 18,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Check-in",
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "12 Oct 2023",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.people,
//                                       color: Colors.deepOrange,
//                                       size: 18,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Guest",
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "2 Adults",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//
//
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: starRatingColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: starRatingColor.withOpacity(0.3)),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: starRatingColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.star,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   starRatingText,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: starRatingColor,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Enjoy exclusive ${hotelStars}-star luxury amenities and premium services",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[700],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.orange[50],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.star,
//                                   color: Colors.orange,
//                                   size: 18,
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   "${widget.hotel["rating"]}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Text(
//                             "Very Good",
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                           const Spacer(),
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.grey[400],
//                             size: 18,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             widget.hotel["location"],
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.emoji_events,
//                                 color: starRatingColor,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 "Premium Features",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey[800],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 12),
//                           Text(
//                             "As a ${hotelStars}-star hotel, you'll enjoy:",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           ...amenities.take(3).map((amenity) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 4),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Icon(
//                                     Icons.check_circle,
//                                     color: starRatingColor,
//                                     size: 16,
//                                   ),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                     child: Text(
//                                       amenity,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[700],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//
//
//                     _sectionCard(
//                       "Welcome Offer",
//                       "Get 20% off on your first stay. Use code WELCOME20 at checkout.",
//                       Icons.local_offer_outlined,
//                     ),
//                     SizedBox(height: 15),
//
//                     _sectionCard(
//                       "About this property",
//                       widget.hotel["description"] ?? "Premium hotel with excellent amenities and services.",
//                       Icons.info_outline,
//                     ),
//                     SizedBox(height: 15),
//
//
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "All ${hotelStars}-Star Amenities",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey[800],
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Text(
//                             "Complete list of amenities for your ${hotelStars}-star experience:",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           Column(
//                             children: amenities.map((amenity) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 8),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 24,
//                                       height: 24,
//                                       decoration: BoxDecoration(
//                                         color: starRatingColor.withOpacity(0.1),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Center(
//                                         child: Icon(
//                                           _getAmenityIcon(amenity),
//                                           size: 12,
//                                           color: starRatingColor,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 12),
//                                     Expanded(
//                                       child: Text(
//                                         amenity,
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey[700],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//                     _buildFoodCourtSection(),
//                     const SizedBox(height: 20),
//
//                     _reviewsSection(),
//                     const SizedBox(height: 30),
//
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           _showBookingDialog(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 50,
//                             vertical: 16,
//                           ),
//                           backgroundColor: Colors.deepOrange,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: const Text(
//                           "Book Now",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   IconData _getAmenityIcon(String amenity) {
//     final amenityLower = amenity.toLowerCase();
//     if (amenityLower.contains('butler') || amenityLower.contains('concierge')) return Icons.person;
//     if (amenityLower.contains('wi-fi') || amenityLower.contains('wifi')) return Icons.wifi;
//     if (amenityLower.contains('pool')) return Icons.pool;
//     if (amenityLower.contains('spa')) return Icons.spa;
//     if (amenityLower.contains('gym') || amenityLower.contains('fitness')) return Icons.fitness_center;
//     if (amenityLower.contains('restaurant') || amenityLower.contains('dining')) return Icons.restaurant;
//     if (amenityLower.contains('parking')) return Icons.local_parking;
//     if (amenityLower.contains('breakfast')) return Icons.free_breakfast;
//     if (amenityLower.contains('security')) return Icons.security;
//     if (amenityLower.contains('tv')) return Icons.tv;
//     if (amenityLower.contains('bed')) return Icons.bed;
//     if (amenityLower.contains('bath')) return Icons.bathtub;
//     if (amenityLower.contains('coffee')) return Icons.coffee;
//     if (amenityLower.contains('airport') || amenityLower.contains('shuttle')) return Icons.airport_shuttle;
//     if (amenityLower.contains('service')) return Icons.room_service;
//     if (amenityLower.contains('view')) return Icons.remove_red_eye;
//     if (amenityLower.contains('smart')) return Icons.smartphone;
//     if (amenityLower.contains('private')) return Icons.vpn_key;
//     return Icons.check_circle;
//   }
//
//   Widget _buildFoodCourtSection() {
//     double totalPrice = 0.0;
//     _cart.forEach((itemName, qty) {
//       final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
//       final discountedPrice =
//           foodItem["price"] * (1 - foodItem["discount"] / 100);
//       totalPrice += discountedPrice * qty;
//     });
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Food Court",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//
//         SizedBox(
//           height: 40,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: _categories.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12),
//                 child: FilterChip(
//                   label: Text(_categories[index]),
//                   selected: _selectedCategory == index,
//                   onSelected: (selected) {
//                     setState(() {
//                       _selectedCategory = index;
//                     });
//                   },
//                   selectedColor: Colors.deepOrange.withOpacity(0.2),
//                   labelStyle: TextStyle(
//                     color: _selectedCategory == index
//                         ? Colors.deepOrange
//                         : Colors.grey[700],
//                     fontWeight: _selectedCategory == index
//                         ? FontWeight.bold
//                         : FontWeight.normal,
//                   ),
//                   backgroundColor: Colors.grey[100],
//                   shape: StadiumBorder(
//                     side: BorderSide(
//                       color: _selectedCategory == index
//                           ? Colors.deepOrange
//                           : Colors.grey[300]!,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 20),
//
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: _foodItems.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 16),
//           itemBuilder: (context, index) {
//             final foodItem = _foodItems[index];
//
//             if (_selectedCategory == 1 && !foodItem["isVeg"]) {
//               return const SizedBox.shrink();
//             }
//             if (_selectedCategory == 2 && foodItem["isVeg"]) {
//               return const SizedBox.shrink();
//             }
//
//             return _buildFoodItemCard(context, foodItem);
//           },
//         ),
//
//         const SizedBox(height: 24),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Total price",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "\$${totalPrice.toStringAsFixed(2)}",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepOrange,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFoodItemCard(
//       BuildContext context,
//       Map<String, dynamic> foodItem,
//       ) {
//     final discountedPrice =
//         foodItem["price"] * (1 - foodItem["discount"] / 100);
//
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => FoodDetailsScreen(
//               foodItem: foodItem,
//               quantity: _cart[foodItem["name"]] ?? 1,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 foodItem["image"],
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(Icons.star, color: Colors.orange, size: 16),
//                       const SizedBox(width: 4),
//                       Text(
//                         "${foodItem["rating"]}",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         "Reviews (${foodItem["reviews"]})",
//                         style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//
//                   Text(
//                     foodItem["name"],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//
//                   Row(
//                     children: [
//                       Text(
//                         "\$${discountedPrice.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepOrange,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         "\$${foodItem["price"].toStringAsFixed(2)}",
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             Column(
//               children: [
//                 if (_cart[foodItem["name"]] != null &&
//                     _cart[foodItem["name"]]! > 0)
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.remove_circle_outline,
//                           color: Colors.deepOrange,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             if (_cart[foodItem["name"]]! > 1) {
//                               _cart[foodItem["name"]] =
//                                   _cart[foodItem["name"]]! - 1;
//                             } else {
//                               _cart.remove(foodItem["name"]);
//                             }
//                           });
//                         },
//                       ),
//                       Text(
//                         "${_cart[foodItem["name"]]}",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.add_circle_outline,
//                           color: Colors.deepOrange,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _cart[foodItem["name"]] =
//                                 (_cart[foodItem["name"]] ?? 0) + 1;
//                           });
//                         },
//                       ),
//                     ],
//                   )
//                 else
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepOrange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _cart[foodItem["name"]] = 1;
//                       });
//                     },
//                     child: const Text(
//                       "Add",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _reviewsSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey[200]!),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Reviews & Rating",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.orange[50],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   "4.1",
//                   style: TextStyle(
//                     color: Colors.orange[800],
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Very Good",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "Based on 124 reviews",
//                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           const TextField(
//             maxLines: 3,
//             decoration: InputDecoration(
//               hintText: "Add detailed review...",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(12)),
//               ),
//               contentPadding: EdgeInsets.all(16),
//             ),
//           ),
//           const SizedBox(height: 15),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               5,
//                   (index) => GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _selectedRating = index + 1;
//                   });
//                 },
//                 child: Icon(
//                   Icons.star,
//                   color: index < _selectedRating
//                       ? Colors.orange
//                       : Colors.grey.shade300,
//                   size: 32,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             _selectedRating == 0
//                 ? "Tap to rate"
//                 : "You rated $_selectedRating star(s)",
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoButton(IconData icon, String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.deepOrange, size: 20),
//           const SizedBox(height: 10),
//           Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionCard(String title, String content, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.deepOrange, size: 22),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: sectionTitleStyle),
//                 const SizedBox(height: 8),
//                 Text(
//                   content,
//                   style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showBookingDialog(BuildContext context) {
//     double totalPrice = 0.0;
//     _cart.forEach((itemName, qty) {
//       final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
//       final discountedPrice = foodItem["price"] * (1 - foodItem["discount"] / 100);
//       totalPrice += discountedPrice * qty;
//     });
//
//     double hotelPrice = 99.0;
//     double finalTotal = hotelPrice + totalPrice;
//
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
//           hotel: widget.hotel,
//           totalAmount: finalTotal,
//           cartItems: _cart,
//           foodItems: _foodItems,
//         ),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOut;
//           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           return SlideTransition(
//             position: animation.drive(tween),
//             child: child,
//           );
//         },
//         transitionDuration: const Duration(milliseconds: 500),
//       ),
//     );
//   }
// }
//
// const sectionTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

// Hotel Details Screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;
  final int starRating;

  const HotelDetailsScreen({
    Key? key,
    required this.hotel,
    required this.starRating,
  }) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late ScrollController _scrollController;

  double _scrollOffset = 0.0;
  bool _showTitle = false;
  int _selectedCategory = 0;
  int _selectedRating = 0;
  final Map<String, int> _cart = {};

  final List<String> _categories = ["All", "Veg", "Non veg"];
  final List<Map<String, dynamic>> _foodItems = [/* Your food items data */];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupScrollListener();
  }

  void _initializeControllers() {
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
        _showTitle = _scrollOffset > 180;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Amenities management based on star rating
  List<String> _getAmenitiesBasedOnStars(int stars) {
    switch (stars) {
      case 7:
        return _getSevenStarAmenities();
      case 6:
        return _getSixStarAmenities();
      case 5:
        return _getFiveStarAmenities();
      case 4:
        return _getFourStarAmenities();
      case 3:
        return _getThreeStarAmenities();
      case 2:
        return _getTwoStarAmenities();
      default:
        return _getBasicAmenities();
    }
  }

  List<String> _getSevenStarAmenities() {
    return [
      "✓ AI Butler with Personality Customization",
      "✓ Facial Recognition Access",
      "✓ Biometric Security Layers",
      "✓ Personal Butler per Guest",
      "✓ Dedicated Chef Brigade",
      "✓ Royal Wardrobe Styling Suite",
      "✓ Military Honor Reception (upon request)",
      "✓ Royal Guard Welcome",
      "✓ Red Carpet Orchestra Ceremony",
      "✓ Chauffeur Rolls-Royce Fleet",
    ];
  }

  List<String> _getSixStarAmenities() {
    return [
      "✓ Individual Climate Control",
      "✓ Ultra High-Speed Private Wi-Fi",
      "✓ Smart Automation System",
      "✓ Fully Stocked Premium Mini Bar",
      "✓ Jacuzzi / Private Pool Access",
      "✓ 24×7 Dedicated Butler",
      "✓ Grand Luxury Lobby",
      "✓ Helicopter / Yacht Access Available",
      "✓ Michelin-Level Fine Dining",
      "✓ Destination Spa & Wellness Retreat",
    ];
  }

  List<String> _getFiveStarAmenities() {
    return [
      "✓ Central Climate Control",
      "✓ Ultra High-Speed Wi-Fi",
      "✓ Smart TV with OTT Access",
      "✓ Premium Bedding & Pillow Menu",
      "✓ Mini Bar & Espresso Machine",
      "✓ Luxury Toiletries & Bath Amenities",
      "✓ 24-Hour Butler Service",
      "✓ Fine Dining Restaurants",
      "✓ Luxury Spa & Wellness Center",
      "✓ Swimming Pool & Fitness Center",
    ];
  }

  List<String> _getFourStarAmenities() {
    return [
      "✓ Central Air Conditioning",
      "✓ High-Speed Wi-Fi",
      "✓ Smart TV with Premium Channels",
      "✓ Mini Bar & Coffee Maker",
      "✓ Premium Toiletries",
      "✓ Bath Tub / Rain Shower",
      "✓ 24-Hour Room Service",
      "✓ Multi-Cuisine Restaurant",
      "✓ Fitness Center",
      "✓ Swimming Pool",

      "✓ Work Desk & Ergonomic Chair",
      "✓ Tea & Coffee Maker",
      "✓ In-Room Safe",
      "✓ Hair Dryer & Shaving Kit",
      "✓ 24-Hour Front Desk & Concierge",
      "✓ Valet Parking",
      "✓ Lift / Elevator",
      "✓ Power Backup",
      "✓ Daily Housekeeping",
      "✓ Luggage Storage",


      "✓ CCTV & Access Control",
      "✓ Fire Detection & Sprinkler System",
      "✓ Wheelchair-Friendly Access",
      "✓ All-Day Dining Café",
      "✓ Complimentary Breakfast Buffet",
      "✓ Bar / Lounge",
      "✓ Banquet Hal",
      "✓ Conference & Meeting Rooms",
      "✓ Outdoor Event / Lawn Space",
      "✓ Spa & Wellness Center",



      "✓ Yoga / Wellness Programs",
      "✓ Business Center",
      "✓ Secretarial Services",
      "✓ Airport Transfers",
      "✓ Travel Desk",
      "✓ Laundry & Dry Cleaning",
      "✓ Doctor on Call",
      "✓ Childcare / Babysitting",
      "✓ Currency Exchange",

    ];
  }




  List<String> _getThreeStarAmenities() {
    return [
      "✓ Air Conditioning",
      "✓ Free High-Speed Wi-Fi",
      "✓ LED TV with Cable",
      "✓ Tea / Coffee Maker",
      "✓ Attached Bathroom with Toiletries",
      "✓ 24-Hour Front Desk",
      "✓ Multi-Cuisine Restaurant",
      "✓ Complimentary Breakfast",
      "✓ Daily Housekeeping",
      "✓ Work Desk & Chair",

      "✓ Wardrobe / Closet",
      "✓ Mini Refrigerator",
      "✓ Electronic Safe",
      "✓ Hot & Cold Water",
      "✓ Power Backup",
      "✓ Lift / Elevator",
      "✓ Luggage Storage",
      "✓ CCTV Surveillance",

      "✓ Fire Safety System",
      "✓ Disabled-Friendly Access",
      "✓ In-Room Dining",
      "✓ Bar / Lounge",
      "✓ Banquet / Event Hall",
      "✓ Conference / Meeting Room",
      "✓ Business Center",
      "✓ Laundry / Dry Cleaning",
      "✓ Travel Desk / Taxi Service",
      "✓ Doctor on Call",
      "✓ Wake-Up Call",
      "✓ Concierge Service",
    ];
  }

  List<String> _getTwoStarAmenities() {
    return [
      "✓ Air Conditioning",
      "✓ Free Wi-Fi",
      "✓ Television with Cable",
      "✓ Attached Bathroom",
      "✓ Hot & Cold Water",
      "✓ 24-Hour Front Desk",
      "✓ Daily Housekeeping",
      "✓ In-House Restaurant",
      "✓ Room Service",
      "✓ Parking Facility",

      "✓ Wardrobe / Storage",
      "✓ Study Table & Chair",
      "✓ Power Backup",
      "✓ Lift / Elevator",
      "✓ CCTV Surveillance",
      "✓ Fire Safety Equipment",
      "✓ Complimentary Breakfast",
      "✓ Drinking Water (Complimentary)",
      "✓ Laundry / Ironing Service",
      "✓ Wake-up Call Service",
      "✓ Travel Desk / Taxi Assistance",
      "✓ Doctor on Call",
    ];
  }


  List<String> _getBasicAmenities() {
    return [
      "✓ Free Wi-Fi",
      "✓ Television",
      "✓ Air Conditioning",
      "✓ Attached Bathroom",
      "✓ Hot Water",
      "✓ 24-Hour Front Desk",
      "✓ Restaurant",
      "✓ Complimentary Breakfast",
      "✓ Parking Facility",
      "✓ CCTV Security",
      "✓ Room Service",
      "✓ Power Backup",
      "✓ Lift / Elevator",
      "✓ In-Room Dining",
      "✓ Tea / Coffee Maker",
      "✓ Laundry Service",
      "✓ Travel Desk",
      "✓ Conference / Meeting Room",
      "✓ Wheelchair Access",

    ];
  }







  String _getStarRatingText(int stars) {
    switch (stars) {
      case 7: return "7-Star Ultra Luxury Hotel";
      case 6: return "6-Star Signature Luxury Hotel";
      case 5: return "5-Star Premium Hotel";
      case 4: return "4-Star Deluxe Hotel";
      case 3: return "3-Star Comfort Hotel";
      case 2: return "2-Star Standard Hotel";
      default: return "Standard Hotel";
    }
  }

  Color _getStarRatingColor(int stars) {
    switch (stars) {
      case 7: return const Color(0xFF9C27B0); // Purple
      case 6: return const Color(0xFF673AB7); // Deep Purple
      case 5: return const Color(0xFFFF9800); // Orange
      case 4: return const Color(0xFF4CAF50); // Green
      case 3: return const Color(0xFFFF5722); // Deep Orange
      case 2: return const Color(0xFF2196F3); // Blue
      default: return const Color(0xFF757575); // Grey
    }
  }

  IconData _getAmenityIcon(String amenity) {
    final amenityLower = amenity.toLowerCase();
    if (amenityLower.contains('butler') || amenityLower.contains('concierge'))
      return Icons.person;
    if (amenityLower.contains('wi-fi') || amenityLower.contains('wifi'))
      return Icons.wifi;
    if (amenityLower.contains('pool'))
      return Icons.pool;
    if (amenityLower.contains('spa'))
      return Icons.spa;
    if (amenityLower.contains('gym') || amenityLower.contains('fitness'))
      return Icons.fitness_center;
    if (amenityLower.contains('restaurant') || amenityLower.contains('dining'))
      return Icons.restaurant;
    if (amenityLower.contains('parking'))
      return Icons.local_parking;
    if (amenityLower.contains('breakfast'))
      return Icons.free_breakfast;
    if (amenityLower.contains('security'))
      return Icons.security;
    if (amenityLower.contains('tv'))
      return Icons.tv;
    if (amenityLower.contains('bed'))
      return Icons.bed;
    if (amenityLower.contains('bath'))
      return Icons.bathtub;
    return Icons.check_circle;
  }

  // UI Building Methods
  @override
  Widget build(BuildContext context) {
    final int hotelStars = widget.starRating;
    final amenities = _getAmenitiesBasedOnStars(hotelStars);
    final starRatingText = _getStarRatingText(hotelStars);
    final starRatingColor = _getStarRatingColor(hotelStars);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(hotelStars, starRatingText, starRatingColor),
          SliverToBoxAdapter(
            child: _buildContentSection(amenities, starRatingText, starRatingColor, hotelStars),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(int hotelStars, String starRatingText, Color starRatingColor) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 2,
      title: AnimatedOpacity(
        opacity: _showTitle ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Text(
          widget.hotel["name"] ?? "",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: _buildFlexibleTitle(starRatingText, starRatingColor),
        background: _buildHeroImage(),
      ),
    );
  }

  Widget _buildFlexibleTitle(String starRatingText, Color starRatingColor) {
    return AnimatedOpacity(
      opacity: _showTitle ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.hotel["name"] ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: [Shadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 10)],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: starRatingColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                starRatingText,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        Hero(
          tag: widget.hotel["image"],
          child: Image.asset(
            widget.hotel["image"],
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(List<String> amenities, String starRatingText, Color starRatingColor, int hotelStars) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookingInfo(),
            const SizedBox(height: 20),
            _buildStarRatingBanner(starRatingText, starRatingColor, hotelStars),
            const SizedBox(height: 20),
            _buildRatingAndLocation(),
            const SizedBox(height: 20),
            _buildPremiumFeatures(amenities, starRatingColor, hotelStars),
            const SizedBox(height: 20),
            _buildOfferSection(),
            const SizedBox(height: 15),
            _buildAboutSection(),
            const SizedBox(height: 15),
            _buildAllAmenitiesSection(amenities, starRatingColor, hotelStars),
            const SizedBox(height: 30),
            _buildFoodCourtSection(),
            const SizedBox(height: 20),
            _buildReviewsSection(),
            const SizedBox(height: 30),
            _buildBookingButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Row(
      children: [
        Expanded(child: _buildInfoCard(Icons.calendar_today, "Check-in", "12 Oct 2023")),
        const SizedBox(width: 10),
        Expanded(child: _buildInfoCard(Icons.people, "Guest", "2 Adults")),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepOrange, size: 18),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStarRatingBanner(String starRatingText, Color starRatingColor, int hotelStars) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: starRatingColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: starRatingColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: starRatingColor, shape: BoxShape.circle),
            child: const Icon(Icons.star, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(starRatingText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: starRatingColor)),
                const SizedBox(height: 4),
                Text(
                  "Enjoy exclusive ${hotelStars}-star luxury amenities and premium services",
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingAndLocation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text("${widget.hotel["rating"]}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text("Very Good", style: TextStyle(fontSize: 14, color: Colors.grey)),
          const Spacer(),
          Icon(Icons.location_on, color: Colors.grey[400], size: 18),
          const SizedBox(width: 4),
          Text(widget.hotel["location"], style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildPremiumFeatures(List<String> amenities, Color starRatingColor, int hotelStars) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: starRatingColor),
              const SizedBox(width: 8),
              Text("Premium Features", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
            ],
          ),
          const SizedBox(height: 12),
          Text("As a ${hotelStars}-star hotel, you'll enjoy:", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 12),
          ...amenities.take(3).map((amenity) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: starRatingColor, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(amenity, style: TextStyle(fontSize: 14, color: Colors.grey[700]))),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildOfferSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.local_offer_outlined, color: Colors.deepOrange, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome Offer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  "Get 20% off on your first stay. Use code WELCOME20 at checkout.",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Colors.deepOrange, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("About this property", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  widget.hotel["description"] ?? "Premium hotel with excellent amenities and services.",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllAmenitiesSection(List<String> amenities, Color starRatingColor, int hotelStars) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("All ${hotelStars}-Star Amenities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
          const SizedBox(height: 12),
          Text("Complete list of amenities for your ${hotelStars}-star experience:", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 16),
          Column(
            children: amenities.map((amenity) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: starRatingColor.withOpacity(0.1), shape: BoxShape.circle),
                    child: Center(
                      child: Icon(_getAmenityIcon(amenity), size: 12, color: starRatingColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(amenity, style: TextStyle(fontSize: 14, color: Colors.grey[700]))),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCourtSection() {
    double totalPrice = _calculateTotalPrice();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Food Court", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildCategoryChips(),
        const SizedBox(height: 20),
        _buildFoodItemsList(),
        const SizedBox(height: 24),
        _buildTotalPriceCard(totalPrice),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(_categories[index]),
              selected: _selectedCategory == index,
              onSelected: (selected) => setState(() => _selectedCategory = index),
              selectedColor: Colors.deepOrange.withOpacity(0.2),
              labelStyle: TextStyle(
                color: _selectedCategory == index ? Colors.deepOrange : Colors.grey[700],
                fontWeight: _selectedCategory == index ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.grey[100],
              shape: StadiumBorder(
                side: BorderSide(color: _selectedCategory == index ? Colors.deepOrange : Colors.grey[300]!),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodItemsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _foodItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final foodItem = _foodItems[index];

        if (_selectedCategory == 1 && !foodItem["isVeg"]) return const SizedBox.shrink();
        if (_selectedCategory == 2 && foodItem["isVeg"]) return const SizedBox.shrink();

        return _buildFoodItemCard(foodItem);
      },
    );
  }

  Widget _buildFoodItemCard(Map<String, dynamic> foodItem) {
    final discountedPrice = foodItem["price"] * (1 - foodItem["discount"] / 100);

    return InkWell(
      onTap: () => _navigateToFoodDetails(foodItem),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(foodItem["image"], height: 80, width: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingRow(foodItem),
                  const SizedBox(height: 6),
                  Text(foodItem["name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  _buildPriceRow(foodItem, discountedPrice),
                ],
              ),
            ),
            _buildCartActions(foodItem),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(Map<String, dynamic> foodItem) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 16),
        const SizedBox(width: 4),
        Text("${foodItem["rating"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(width: 6),
        Text("Reviews (${foodItem["reviews"]})", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildPriceRow(Map<String, dynamic> foodItem, double discountedPrice) {
    return Row(
      children: [
        Text("\$${discountedPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        const SizedBox(width: 8),
        Text("\$${foodItem["price"].toStringAsFixed(2)}", style: const TextStyle(fontSize: 13, color: Colors.grey, decoration: TextDecoration.lineThrough)),
      ],
    );
  }

  Widget _buildCartActions(Map<String, dynamic> foodItem) {
    final quantity = _cart[foodItem["name"]] ?? 0;

    if (quantity > 0) {
      return Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.deepOrange),
            onPressed: () => _updateCartQuantity(foodItem, quantity - 1),
          ),
          Text("$quantity", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.deepOrange),
            onPressed: () => _updateCartQuantity(foodItem, quantity + 1),
          ),
        ],
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _updateCartQuantity(foodItem, 1),
      child: const Text("Add", style: TextStyle(color: Colors.white)),
    );
  }

  void _updateCartQuantity(Map<String, dynamic> foodItem, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _cart[foodItem["name"]] = newQuantity;
      } else {
        _cart.remove(foodItem["name"]);
      }
    });
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    _cart.forEach((itemName, qty) {
      final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
      final discountedPrice = foodItem["price"] * (1 - foodItem["discount"] / 100);
      total += discountedPrice * qty;
    });
    return total;
  }

  Widget _buildTotalPriceCard(double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Total price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("\$${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Reviews & Rating", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          _buildRatingSummary(),
          const SizedBox(height: 15),
          _buildReviewInput(),
          const SizedBox(height: 15),
          _buildStarRatingSelector(),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.orange[50], shape: BoxShape.circle),
          child: const Text("4.1", style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Very Good", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 4),
            Text("Based on 124 reviews", style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewInput() {
    return const TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Add detailed review...",
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        contentPadding: EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildStarRatingSelector() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => GestureDetector(
            onTap: () => setState(() => _selectedRating = index + 1),
            child: Icon(
              Icons.star,
              color: index < _selectedRating ? Colors.orange : Colors.grey.shade300,
              size: 32,
            ),
          )),
        ),
        const SizedBox(height: 10),
        Text(
          _selectedRating == 0 ? "Tap to rate" : "You rated $_selectedRating star(s)",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showBookingDialog(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: const Text("Book Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  void _navigateToFoodDetails(Map<String, dynamic> foodItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FoodDetailsScreen(
          foodItem: foodItem,
          quantity: _cart[foodItem["name"]] ?? 1,
        ),
      ),
    );
  }

  void _showBookingDialog() {
    double totalPrice = _calculateTotalPrice();
    double hotelPrice = 99.0;
    double finalTotal = hotelPrice + totalPrice;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(
          hotel: widget.hotel,
          totalAmount: finalTotal,
          cartItems: _cart,
          foodItems: _foodItems,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}


class FoodDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> foodItem;
  final int quantity;

  const FoodDetailsScreen({
    Key? key,
    required this.foodItem,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(foodItem["name"] ?? "Food Details")),
      body: Center(child: Text("Food Details Screen - Coming Soon")),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final double totalAmount;
  final Map<String, int> cartItems;
  final List<Map<String, dynamic>> foodItems;

  const PaymentScreen({
    Key? key,
    required this.hotel,
    required this.totalAmount,
    required this.cartItems,
    required this.foodItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(child: Text("Payment Screen - Coming Soon")),
    );
  }
}

















