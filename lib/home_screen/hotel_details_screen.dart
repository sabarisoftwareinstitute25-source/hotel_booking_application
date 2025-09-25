//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
//
// class HotelDetailsScreen extends StatefulWidget {
//   final Map<String, dynamic> hotel;
//
//   const HotelDetailsScreen({super.key, required this.hotel});
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
//   // Food court variables
//   int _selectedCategory = 0; // 0: All, 1: Veg, 2: Non-veg
//   final List<String> _categories = ["All", "Veg", "Non veg"];
//
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
//       "image": "assets/images/chicken-biryani.jpg", // 👈 Add image
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
//   @override
//   void initState() {
//     super.initState();
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
//     _colorAnimation = ColorTween(
//       begin: Colors.transparent,
//       end: Colors.white,
//     ).animate(
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
//   Widget build(BuildContext context) {
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
//                     padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
//                     child: Text(
//                       widget.hotel["name"] ?? "",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         shadows: [
//                           Shadow(
//                             color: Colors.black54,
//                             offset: Offset(1, 1),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
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
//
//           SliverToBoxAdapter(
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(0, _slideAnimation.value),
//                   child: Opacity(
//                     opacity: _fadeAnimation.value,
//                     child: child,
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Rating + Location
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
//                                 const Icon(Icons.star,
//                                     color: Colors.orange, size: 18),
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
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const Spacer(),
//                           Icon(Icons.location_on,
//                               color: Colors.grey[400], size: 18),
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
//                     // Travel Date & Guest
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _infoButton(Icons.calendar_today, "Check-In",
//                               "12 Oct 2023"),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: _infoButton(Icons.people, "Guest", "2 Adults"),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     // Welcome Offer
//                     _sectionCard(
//                       "Welcome Offer",
//                       "Get 20% off on your first stay. Use code WELCOME20 at checkout.",
//                       Icons.local_offer_outlined,
//                     ),
//                     const SizedBox(height: 15),
//                     // About this property
//                     _sectionCard(
//                       "About this property",
//                       "Luxury beachfront resort with stunning ocean views, premium amenities, and exceptional service for an unforgettable stay.",
//                       Icons.info_outline,
//                     ),
//                     const SizedBox(height: 15),
//                     // Amenities
//                     Text("Amenities for Families with Kids",
//                         style: sectionTitleStyle),
//                     const SizedBox(height: 10),
//                     GridView.count(
//                       crossAxisCount: 3,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       childAspectRatio: 2.5,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       children: [
//                         _amenityChip("Swimming Pool", Icons.pool),
//                         _amenityChip("Restaurant", Icons.restaurant),
//                         _amenityChip("Indoor Games", Icons.sports_esports),
//                         _amenityChip("Kids Club", Icons.child_care),
//                         _amenityChip("Playground", Icons.park),
//                         _amenityChip("Free WiFi", Icons.wifi),
//                       ],
//                     ),
//
//                     // FOOD COURT SECTION - ADDED HERE
//                     const SizedBox(height: 30),
//                     _buildFoodCourtSection(),
//                     const SizedBox(height: 20),
//
//                     // Reviews & Rating
//                     _reviewsSection(),
//                     const SizedBox(height: 30),
//                     // Book Now Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           _showBookingDialog(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 16),
//                           backgroundColor: Colors.deepOrange,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: const Text("Book Now",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white)),
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
//
//   // Food Court Section
//   Widget _buildFoodCourtSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section title
//         const Text(
//           "Food Court",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//
//         // Category filter
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
//         // Food items list
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: _foodItems.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 16),
//           itemBuilder: (context, index) {
//             final foodItem = _foodItems[index];
//
//             // Apply category filter
//             if (_selectedCategory == 1 && !foodItem["isVeg"]) {
//               return const SizedBox.shrink();
//             }
//             if (_selectedCategory == 2 && foodItem["isVeg"]) {
//               return const SizedBox.shrink();
//             }
//
//             return _buildFoodItemCard(foodItem);
//           },
//         ),
//
//         // Total price section
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
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Total price",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 "\$15",
//                 style: TextStyle(
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
//
//
//
//   Widget _buildFoodItemCard(Map<String, dynamic> item) {
//     final discountedPrice = item["price"] * (1 - item["discount"]/100);
//
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Food Image 👇
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               item["image"],
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 12),
//
//           // Food name and veg/non-veg indicator
//           Row(
//             children: [
//               Container(
//                 width: 16,
//                 height: 16,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: item["isVeg"] ? Colors.green : Colors.red,
//                   border: Border.all(
//                     color: item["isVeg"] ? Colors.green : Colors.red,
//                     width: 2,
//                   ),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 6,
//                     height: 6,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   item["name"],
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//
//           // Rating and reviews
//           Row(
//             children: [
//               const Icon(Icons.star, color: Colors.orange, size: 16),
//               const SizedBox(width: 4),
//               Text(
//                 "${item["rating"]}",
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 "Reviews (${item["reviews"]})",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//
//           // Description
//           Text(
//             item["description"],
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 12),
//
//           // Price and add button
//           Row(
//             children: [
//               // Discount badge
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.deepOrange.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   "${item["discount"].toInt()}% OFF",
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepOrange,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//
//               // Price
//               Text(
//                 "\$${discountedPrice.toStringAsFixed(2)}",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 4),
//
//               // Original price (strikethrough)
//               Text(
//                 "\$${item["price"].toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[500],
//                   decoration: TextDecoration.lineThrough,
//                 ),
//               ),
//               const Spacer(),
//
//               // Add button
//               Container(
//                 width: 80,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: Colors.deepOrange,
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "Add",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _infoButton(IconData icon, String label, String value) {
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
//         children: [
//           Icon(icon, size: 20, color: Colors.deepOrange),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionCard(String title, String description, IconData icon) {
//     return Container(
//       width: double.infinity,
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
//           Row(
//             children: [
//               Icon(icon, color: Colors.deepOrange, size: 20),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//               height: 1.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _amenityChip(String label, IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 16, color: Colors.deepOrange),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 12),
//           ),
//         ],
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
//           const Text("Reviews & Rating",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.orange[50],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text("4.1",
//                     style: TextStyle(
//                         color: Colors.orange[800],
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(width: 12),
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Very Good",
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                   SizedBox(height: 4),
//                   Text("Based on 124 reviews",
//                       style: TextStyle(color: Colors.grey, fontSize: 12)),
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
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               5,
//                   (index) => const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4.0),
//                 child: Icon(Icons.star, color: Colors.orange, size: 32),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Tap to rate",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showBookingDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 64,
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "Booking Successful!",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Your stay at ${widget.hotel["name"]} has been confirmed.",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       backgroundColor: Colors.deepOrange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Done",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   TextStyle get sectionTitleStyle => const TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: 16,
//   );
// }







//////////////////////////////////////////////////////////



import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:hotel_booking_mobile_application/home_screen/payment_screen.dart';

import 'food_details_screen.dart';

class HotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const HotelDetailsScreen({super.key, required this.hotel});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _showTitle = false;

  int _selectedCategory = 0;
  final List<String> _categories = ["All", "Veg", "Non veg"];

  int _selectedRating = 0;

  final Map<String, int> _cart = {};

  final List<Map<String, dynamic>> _foodItems = [
    {
      "name": "Chicken Biryani",
      "rating": 3.5,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 10.0,
      "discount": 25.0,
      "isVeg": false,
      "image": "assets/images/chicken-biryani.jpg",
    },
    {
      "name": "Crispy mozza burger",
      "rating": 3.9,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 8.0,
      "discount": 25.0,
      "isVeg": false,
      "image": "assets/images/burger.jpeg",
    },
    {
      "name": "Sandwich",
      "rating": 3.9,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 5.0,
      "discount": 25.0,
      "isVeg": true,
      "image": "assets/images/paneer-sandwich.jpg",
    },
    {
      "name": "Meals",
      "rating": 3.9,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 5.0,
      "discount": 25.0,
      "isVeg": true,
      "image": "assets/images/meals.jpg",
    },
    {
      "name": "Mutton Briyani",
      "rating": 3.9,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 5.0,
      "discount": 25.0,
      "isVeg": false,
      "image": "assets/images/mutton-biryani.jpg",
    },
    {
      "name": "Chappathi",
      "rating": 3.9,
      "reviews": 2001,
      "description": "neque, amet blandit tincidunt vulputate",
      "price": 5.0,
      "discount": 25.0,
      "isVeg": true,
      "image": "assets/images/chapathi.webp",
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _colorAnimation = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
          ),
        );

    _controller.forward();

    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
        _showTitle = _scrollOffset > 180;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 2,
            title: AnimatedOpacity(
              opacity: _showTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.hotel["name"] ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: AnimatedOpacity(
                opacity: _showTitle ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    child: Text(
                      widget.hotel["name"] ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              background: Stack(
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
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _controller,
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
                    // Rating + Location
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${widget.hotel["rating"]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Very Good",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.hotel["location"],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: _infoButton(
                            Icons.calendar_today,
                            "Check-In",
                            "12 Oct 2023",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _infoButton(Icons.people, "Guest", "2 Adults"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _sectionCard(
                      "Welcome Offer",
                      "Get 20% off on your first stay. Use code WELCOME20 at checkout.",
                      Icons.local_offer_outlined,
                    ),
                    const SizedBox(height: 15),

                    _sectionCard(
                      "About this property",
                      "Luxury beachfront resort with stunning ocean views, premium amenities, and exceptional service for an unforgettable stay.",
                      Icons.info_outline,
                    ),
                    const SizedBox(height: 15),

                    Text(
                      "Amenities for Families with Kids",
                      style: sectionTitleStyle,
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _amenityChip("Swimming Pool", Icons.pool),
                        _amenityChip("Restaurant", Icons.restaurant),
                        _amenityChip("Indoor Games", Icons.sports_esports),
                        _amenityChip("Kids Club", Icons.child_care),
                        _amenityChip("Playground", Icons.park),
                        _amenityChip("Free WiFi", Icons.wifi),
                      ],
                    ),

                    const SizedBox(height: 30),
                    _buildFoodCourtSection(),
                    const SizedBox(height: 20),

                    _reviewsSection(),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _showBookingDialog(context);
                          // Navigator.push(
                          //           context,
                          //           MaterialPageRoute(builder: (_) => PaymentScreen(totalAmount: 0, hotel: {},)),
                          //         );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 16,
                          ),
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCourtSection() {
    double totalPrice = 0.0;
    _cart.forEach((itemName, qty) {
      final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
      final discountedPrice =
          foodItem["price"] * (1 - foodItem["discount"] / 100);
      totalPrice += discountedPrice * qty;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Food Court",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        SizedBox(
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
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = index;
                    });
                  },
                  selectedColor: Colors.deepOrange.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _selectedCategory == index
                        ? Colors.deepOrange
                        : Colors.grey[700],
                    fontWeight: _selectedCategory == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  backgroundColor: Colors.grey[100],
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: _selectedCategory == index
                          ? Colors.deepOrange
                          : Colors.grey[300]!,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _foodItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final foodItem = _foodItems[index];

            if (_selectedCategory == 1 && !foodItem["isVeg"]) {
              return const SizedBox.shrink();
            }
            if (_selectedCategory == 2 && foodItem["isVeg"]) {
              return const SizedBox.shrink();
            }

            return _buildFoodItemCard(context, foodItem);
          },
        ),

        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total price",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodItemCard(
    BuildContext context,
    Map<String, dynamic> foodItem,
  ) {
    final discountedPrice =
        foodItem["price"] * (1 - foodItem["discount"] / 100);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetailsScreen(
              foodItem: foodItem,
              quantity: _cart[foodItem["name"]] ?? 1,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🍔 Food image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                foodItem["image"],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${foodItem["rating"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Reviews (${foodItem["reviews"]})",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Text(
                    foodItem["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        "\$${discountedPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${foodItem["price"].toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              children: [
                if (_cart[foodItem["name"]] != null &&
                    _cart[foodItem["name"]]! > 0)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_cart[foodItem["name"]]! > 1) {
                              _cart[foodItem["name"]] =
                                  _cart[foodItem["name"]]! - 1;
                            } else {
                              _cart.remove(foodItem["name"]);
                            }
                          });
                        },
                      ),
                      Text(
                        "${_cart[foodItem["name"]]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          setState(() {
                            _cart[foodItem["name"]] =
                                (_cart[foodItem["name"]] ?? 0) + 1;
                          });
                        },
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _cart[foodItem["name"]] = 1;
                      });
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _reviewsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Reviews & Rating",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "4.1",
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Very Good",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Based on 124 reviews",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Add detailed review...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 15),

          // ⭐ Now stars are clickable
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: index < _selectedRating
                      ? Colors.orange
                      : Colors.grey.shade300,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _selectedRating == 0
                ? "Tap to rate"
                : "You rated $_selectedRating star(s)",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _infoButton(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepOrange, size: 20),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepOrange, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: sectionTitleStyle),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amenityChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrange.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: Colors.deepOrange),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.deepOrange),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }



  // void _showBookingDialog(BuildContext context) {
  //   // Calculate total price for food items
  //   double totalPrice = 0.0;
  //   _cart.forEach((itemName, qty) {
  //     final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
  //     final discountedPrice = foodItem["price"] * (1 - foodItem["discount"] / 100);
  //     totalPrice += discountedPrice * qty;
  //   });
  //
  //   // Add hotel base price (you can modify this as needed)
  //   double hotelPrice = 99.0; // Base hotel price
  //   double finalTotal = hotelPrice + totalPrice;
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PaymentScreen(
  //         hotel: widget.hotel,
  //         totalAmount: finalTotal,
  //       ),
  //     ),
  //   );
  // }

  void _showBookingDialog(BuildContext context) {
    // Calculate total price for food items
    double totalPrice = 0.0;
    _cart.forEach((itemName, qty) {
      final foodItem = _foodItems.firstWhere((f) => f["name"] == itemName);
      final discountedPrice = foodItem["price"] * (1 - foodItem["discount"] / 100);
      totalPrice += discountedPrice * qty;
    });

    // Add hotel base price
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
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

const sectionTitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);






















