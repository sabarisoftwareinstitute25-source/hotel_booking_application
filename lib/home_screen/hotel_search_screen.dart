// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:carousel_slider/carousel_slider.dart';
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
// class _HotelSearchScreenState extends State<HotelSearchScreen> {
//   DateTime? _checkInDate;
//   DateTime? _checkOutDate;
//   int _roomCount = 1;
//   int _adultCount = 1;
//   int _childCount = 0;
//   String? _selectedPurpose;
//   Map<String, bool> _selectedFilters = {};
//
//   bool _showResults = false;
//
//   final List<String> _purposeOptions = [
//     'Work',
//     'Special Occasion',
//     'Transit',
//     'Holiday',
//   ];
//
//   final List<Map<String, dynamic>> _hotels = [
//     {
//       "image": "assets/images/img5.jpg",
//       "discount": "10% Off",
//       "name": "Hotel Paradise",
//       "location": "Chennai Central",
//       "price": "\$200",
//       "rating": 4.8,
//     },
//     {
//       "image": "assets/images/img6.jpg",
//       "discount": "15% Off",
//       "name": "Grand Residency",
//       "location": "T. Nagar",
//       "price": "\$120",
//       "rating": 4.6,
//     },
//     {
//       "image": "assets/images/img7.jpg",
//       "discount": "20% Off",
//       "name": "Sea View Resort",
//       "location": "Marina Beach",
//       "price": "\$180",
//       "rating": 4.9,
//     },
//   ];
//
//   Future<void> _selectDate(bool isCheckIn) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCheckIn
//           ? (_checkInDate ?? DateTime.now())
//           : (_checkOutDate ??
//                 (_checkInDate ?? DateTime.now()).add(const Duration(days: 1))),
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
//   Widget _buildCounter(
//     String label,
//     int value,
//     int min,
//     int max,
//     Function onMinus,
//     Function onPlus,
//   ) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove_circle),
//                 onPressed: value > min ? () => onMinus() : null,
//               ),
//               Text(
//                 "$value",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add_circle),
//                 onPressed: value < max ? () => onPlus() : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _openFilterSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return DraggableScrollableSheet(
//           expand: false,
//           initialChildSize: 0.9,
//           maxChildSize: 0.95,
//           minChildSize: 0.5,
//           builder: (context, scrollController) {
//             return SingleChildScrollView(
//               controller: scrollController,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSectionTitle("PRICE PER NIGHT"),
//                   _buildCheckbox("0 - 1500"),
//                   _buildCheckbox("1500 - 5000"),
//                   _buildCheckbox("5000 - 10000"),
//                   _buildCheckbox("10000+ above"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("STAR RATING"),
//                   _buildCheckbox("3 star hotel"),
//                   _buildCheckbox("4 star hotel"),
//                   _buildCheckbox("5 star hotel"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("MEALS OPTION"),
//                   _buildCheckbox("Breakfast+Lunch/Dinner Included"),
//                   _buildCheckbox("All Meals included"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("USER RATING"),
//                   _buildCheckbox("Good: 3+"),
//                   _buildCheckbox("Very Good: 3.5+"),
//                   _buildCheckbox("Excellent: 4.2+"),
//
//                   const Divider(),
//                   _buildSectionTitle("CANCELLATION POLICY"),
//                   _buildCheckbox("Free Cancellation"),
//
//                   const Divider(),
//                   _buildSectionTitle("STAY TYPE"),
//                   _buildCheckbox("Entire Villas & Apartments"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("PROPERTY TYPE"),
//                   _buildCheckbox("Hotel"),
//                   _buildCheckbox("Apartment"),
//                   _buildCheckbox("Villa"),
//                   _buildCheckbox("Homestay"),
//                   _buildCheckbox("Resort"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("PREVIOUSLY USED"),
//                   _buildCheckbox("Beach"),
//                   _buildCheckbox("Breakfast+Lunch/Dinner included"),
//                   _buildCheckbox("5 star hotel"),
//
//                   const Divider(),
//
//                   _buildSectionTitle("SUGGESTED FOR YOU"),
//                   _buildCheckbox("Last minute meal"),
//                   _buildCheckbox("Rated excellent by travellars"),
//                   _buildCheckbox("Rated very good by travellars"),
//                   _buildCheckbox("Rated good by travellars"),
//                   _buildCheckbox("5 star hotel"),
//                   _buildCheckbox("Near the airport"),
//                   _buildCheckbox("Beachfront"),
//                   _buildCheckbox("Free breakfast"),
//                   _buildCheckbox("4 star hotel"),
//                   _buildCheckbox("Resort"),
//                   _buildCheckbox("Egmore railway station"),
//                   _buildCheckbox("Allow unmarried couples"),
//                   _buildCheckbox("Entire property"),
//                   _buildCheckbox("T-nager popular shopping area"),
//                   _buildCheckbox("MMT valuestays-top rated & affortable"),
//                   const Divider(),
//                   _buildSectionTitle("EXCLUSIVE DEALS"),
//                   _buildCheckbox("Last minute deals"),
//                   _buildCheckbox("Rush deals"),
//                   const Divider(),
//                   _buildSectionTitle("ROOM VIEWS"),
//                   _buildCheckbox("Garden view"),
//                   _buildCheckbox("City view"),
//                   const Divider(),
//
//                   _buildSectionTitle("ROOM AMENITIES"),
//                   _buildCheckbox("Wi-Fi"),
//                   _buildCheckbox("Swimming pool"),
//                   _buildCheckbox("Jacuzzi"),
//                   _buildCheckbox("Private Pool"),
//                   _buildCheckbox("Bathtub"),
//                   _buildCheckbox("Balcony"),
//
//                   const Divider(),
//                   _buildSectionTitle("OTHER POPULAR AMENITIES"),
//                   _buildCheckbox("Wi-Fi"),
//                   _buildCheckbox("Swimming pool"),
//                   _buildCheckbox("Spa"),
//                   _buildCheckbox("Cafe"),
//                   const Divider(),
//                   _buildSectionTitle("HOTEL RULES"),
//                   _buildCheckbox("Pets allowed"),
//                   _buildCheckbox("Allow unmarried couples"),
//                   const Divider(),
//                   _buildSectionTitle("POPULAR BRANDS HOTEL"),
//                   _buildCheckbox("Fortune"),
//                   _buildCheckbox("Marriott,Westin"),
//                   _buildCheckbox("Hyatt"),
//
//                   const SizedBox(height: 20),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                           vertical: 14,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         "APPLY FILTERS",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget _buildCheckbox(String label) {
//     return StatefulBuilder(
//       builder: (context, setStateSB) {
//         return Row(
//           children: [
//             Checkbox(
//               value: _selectedFilters[label] ?? false,
//               onChanged: (val) {
//                 setStateSB(() {
//                   _selectedFilters[label] = val ?? false;
//                 });
//                 setState(() {});
//               },
//             ),
//             Expanded(child: Text(label)),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Container(
//             width: w,
//             padding: EdgeInsets.only(
//               top: h * 0.06,
//               left: 20,
//               right: 20,
//               bottom: 30,
//             ),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "Hotels & Homestay",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Discover your perfect stay with WanderStay ✨",
//                   style: TextStyle(fontSize: 14, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20),
//               child: _showResults ? _buildHotelResults() : _buildSearchForm(w),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchForm(double w) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Exclusive Offers",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         const SizedBox(height: 15),
//
//         CarouselSlider(
//           options: CarouselOptions(
//             height: 160,
//             enlargeCenterPage: true,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             viewportFraction: 0.9,
//           ),
//           items: [
//             _buildOfferCardModel(
//               title: "Unlock Your Special Offers",
//               subtitle: "Your perfect deals, handpicked!",
//               gradientColors: [Colors.orangeAccent, Colors.deepOrangeAccent],
//               imagePath: "assets/images/img4.webp",
//             ),
//             _buildOfferCardModel(
//               title: "Weekend Cashback",
//               subtitle: "Get ₹200 back on weekend stays",
//               gradientColors: [Colors.orangeAccent, Colors.deepOrangeAccent],
//               imagePath: "assets/images/img2.jpg",
//             ),
//             _buildOfferCardModel(
//               title: "Free Breakfast",
//               subtitle: "Available on select hotels",
//               gradientColors: [Colors.orangeAccent, Colors.deepOrangeAccent],
//               imagePath: "assets/images/img3.jpg",
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 20),
//
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey[300]!),
//           ),
//           child: const TextField(
//             decoration: InputDecoration(
//               hintText: "Where to?",
//               border: InputBorder.none,
//               icon: Icon(Icons.search, color: Colors.orange),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectDate(true),
//                 child: _buildDateCard("Check-in", _checkInDate),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectDate(false),
//                 child: _buildDateCard("Check-out", _checkOutDate),
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 20),
//
//         _buildCounter(
//           "Rooms",
//           _roomCount,
//           1,
//           5,
//           () => setState(() => _roomCount--),
//           () => setState(() => _roomCount++),
//         ),
//         _buildCounter(
//           "Adults",
//           _adultCount,
//           1,
//           10,
//           () => setState(() => _adultCount--),
//           () => setState(() => _adultCount++),
//         ),
//         _buildCounter(
//           "Children",
//           _childCount,
//           0,
//           5,
//           () => setState(() => _childCount--),
//           () => setState(() => _childCount++),
//         ),
//
//         const SizedBox(height: 20),
//
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Purpose of stay",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 15,
//           children: _purposeOptions.map((purpose) {
//             final isSelected = _selectedPurpose == purpose;
//             return ChoiceChip(
//               label: Text(purpose),
//               selected: isSelected,
//               selectedColor: const Color(0xFFFF7043),
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//               onSelected: (_) => setState(() => _selectedPurpose = purpose),
//             );
//           }).toList(),
//         ),
//
//         const SizedBox(height: 30),
//
//         Container(
//           width: w * 0.8,
//           height: 55,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFFFF7043), Color(0xFFFF8A65)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.orange.withOpacity(0.4),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: ElevatedButton(
//             onPressed: () => setState(() => _showResults = true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             child: const Text(
//               "SEARCH",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHotelResults() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               _filterChip("All filter", () => _openFilterSheet(context)),
//               _filterChip(
//                 "Price",
//                 () => _openSingleCategory(context, "PRICE PER NIGHT", [
//                   "0 - 1500",
//                   "1500 - 5000",
//                   "5000 - 10000",
//                   "10000+ above",
//                 ]),
//               ),
//               _filterChip(
//                 "Star Rating",
//                 () => _openSingleCategory(context, "STAR RATING", [
//                   "3 star hotel",
//                   "4 star hotel",
//                   "5 star hotel",
//                 ]),
//               ),
//               _filterChip(
//                 "Meals option",
//                 () => _openSingleCategory(context, "MEALS OPTION", [
//                   "Breakfast+Lunch/Dinner Included",
//                   "All Meals included",
//                 ]),
//               ),
//               _filterChip(
//                 "Property type",
//                 () => _openSingleCategory(context, "PROPERTY TYPE", [
//                   "Hotel",
//                   "Apartment",
//                   "Villa",
//                   "Homestay",
//                   "Resort",
//                 ]),
//               ),
//               _filterChip(
//                 "Amenities",
//                 () => _openSingleCategory(context, "ROOM AMENITIES", [
//                   "Wi-Fi",
//                   "Swimming pool",
//                   "Jacuzzi",
//                   "Private Pool",
//                   "Bathtub",
//                   "Balcony",
//                 ]),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 20),
//         const Text(
//           "Popular in Chennai",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//
//         const SizedBox(height: 15),
//
//         Column(children: _hotels.map((hotel) => _hotelCard(hotel)).toList()),
//       ],
//     );
//   }
//
//   Widget _filterChip(String label, [VoidCallback? onTap]) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: false,
//         onSelected: (_) => onTap?.call(),
//       ),
//     );
//   }
//
//   Widget _hotelCard(Map<String, dynamic> hotel) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: hotel)),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 15),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey[300]!),
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(
//                 hotel["image"],
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red[50],
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           hotel["discount"],
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       const Icon(
//                         Icons.favorite_border,
//                         size: 20,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     hotel["name"],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 14,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         hotel["location"],
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Text(
//                         hotel["price"],
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                       ),
//                       const Text(
//                         "/day +GST",
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       const Spacer(),
//                       const Icon(Icons.star, color: Colors.orange, size: 16),
//                       Text(
//                         hotel["rating"].toString(),
//                         style: const TextStyle(fontSize: 13),
//                       ),
//                     ],
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
//   Widget _buildOfferCardModel({
//     required String title,
//     required String subtitle,
//     required List<Color> gradientColors,
//     required String imagePath,
//   }) {
//     return Container(
//       width: 320,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: gradientColors,
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           Flexible(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   subtitle,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white.withOpacity(0.7),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           Flexible(
//             flex: 1,
//             child: Image.asset(imagePath, height: 90, fit: BoxFit.cover),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDateCard(String label, DateTime? date) {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
//           const SizedBox(height: 5),
//           Row(
//             children: [
//               const Icon(Icons.calendar_today, size: 18, color: Colors.orange),
//               const SizedBox(width: 8),
//               Text(
//                 date != null
//                     ? DateFormat('MMM dd, yyyy').format(date)
//                     : "Select date",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _openSingleCategory(
//     BuildContext context,
//     String title,
//     List<String> options,
//   ) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               ...options.map((opt) => _buildCheckbox(opt)).toList(),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepOrange,
//                   ),
//                   child: const Text("APPLY"),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
//



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';

import 'hotel_details_screen.dart';
// import 'food_court_screen.dart';

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

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> _purposeOptions = ['Work', 'Special Occasion', 'Transit', 'Holiday'];

  final List<Map<String, dynamic>> _hotels = [
    {
      "image": "assets/images/img5.jpg",
      "discount": "10% Off",
      "name": "Hotel Paradise",
      "location": "Chennai Central",
      "price": "\$200",
      "rating": 4.8,
      "reviews": 1247,
      "distance": "2.3 km from center",
      "tags": ["Free WiFi", "Pool", "Spa", "Breakfast Included"],
      "description": "Luxury hotel with premium amenities and excellent service in the heart of Chennai.",
      "amenities": ["Wi-Fi", "Swimming Pool", "Spa", "Gym", "Restaurant", "Bar"],
      "images": ["assets/images/img5.jpg", "assets/images/img6.jpg", "assets/images/img7.jpg"]
    },
    {
      "image": "assets/images/img6.jpg",
      "discount": "15% Off",
      "name": "Grand Residency",
      "location": "T. Nagar",
      "price": "\$120",
      "rating": 4.6,
      "reviews": 892,
      "distance": "1.8 km from center",
      "tags": ["Free Parking", "Gym", "Restaurant"],
      "description": "Comfortable stay with modern amenities in Chennai's prime shopping district.",
      "amenities": ["Wi-Fi", "Parking", "Gym", "Restaurant", "Room Service"],
      "images": ["assets/images/img6.jpg", "assets/images/img5.jpg", "assets/images/img7.jpg"]
    },
    {
      "image": "assets/images/img7.jpg",
      "discount": "20% Off",
      "name": "Sea View Resort",
      "location": "Marina Beach",
      "price": "\$180",
      "rating": 4.9,
      "reviews": 1563,
      "distance": "0.5 km from beach",
      "tags": ["Beach Front", "Luxury", "All Inclusive"],
      "description": "Beachfront luxury resort offering breathtaking views and premium services.",
      "amenities": ["Beach Access", "Pool", "Spa", "Fine Dining", "Water Sports"],
      "images": ["assets/images/img7.jpg", "assets/images/img5.jpg", "assets/images/img6.jpg"]
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
      width: 30, // bigger width
      height: 30, // bigger height
      decoration: BoxDecoration(
        color: isEnabled ? Color(0xFFFF7043) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 15), // bigger icon
        color: Colors.white,
        onPressed: onPressed,
        padding: EdgeInsets.all(0), // keep it centered
        constraints: BoxConstraints(), // let Container size control it
      ),
    );
  }


  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
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

                  _buildSectionTitle("PRICE PER NIGHT"),
                  _buildCheckbox("0 - 1500"),
                  _buildCheckbox("1500 - 5000"),
                  _buildCheckbox("5000 - 10000"),
                  _buildCheckbox("10000+ above"),

                  const Divider(),

                  _buildSectionTitle("STAR RATING"),
                  _buildCheckbox("3 star hotel"),
                  _buildCheckbox("4 star hotel"),
                  _buildCheckbox("5 star hotel"),

                  const Divider(),

                  _buildSectionTitle("MEALS OPTION"),
                  _buildCheckbox("Breakfast+Lunch/Dinner Included"),
                  _buildCheckbox("All Meals included"),

                  const Divider(),

                  _buildSectionTitle("USER RATING"),
                  _buildCheckbox("Good: 3+"),
                  _buildCheckbox("Very Good: 3.5+"),
                  _buildCheckbox("Excellent: 4.2+"),

                  const Divider(),
                  _buildSectionTitle("CANCELLATION POLICY"),
                  _buildCheckbox("Free Cancellation"),

                  const Divider(),
                  _buildSectionTitle("STAY TYPE"),
                  _buildCheckbox("Entire Villas & Apartments"),

                  const Divider(),

                  _buildSectionTitle("PROPERTY TYPE"),
                  _buildCheckbox("Hotel"),
                  _buildCheckbox("Apartment"),
                  _buildCheckbox("Villa"),
                  _buildCheckbox("Homestay"),
                  _buildCheckbox("Resort"),

                  const Divider(),

                  _buildSectionTitle("PREVIOUSLY USED"),
                  _buildCheckbox("Beach"),
                  _buildCheckbox("Breakfast+Lunch/Dinner included"),
                  _buildCheckbox("5 star hotel"),

                  const Divider(),

                  _buildSectionTitle("SUGGESTED FOR YOU"),
                  _buildCheckbox("Last minute meal"),
                  _buildCheckbox("Rated excellent by travellars"),
                  _buildCheckbox("Rated very good by travellars"),
                  _buildCheckbox("Rated good by travellars"),
                  _buildCheckbox("5 star hotel"),
                  _buildCheckbox("Near the airport"),
                  _buildCheckbox("Beachfront"),
                  _buildCheckbox("Free breakfast"),
                  _buildCheckbox("4 star hotel"),
                  _buildCheckbox("Resort"),
                  _buildCheckbox("Egmore railway station"),
                  _buildCheckbox("Allow unmarried couples"),
                  _buildCheckbox("Entire property"),
                  _buildCheckbox("T-nager popular shopping area"),
                  _buildCheckbox("MMT valuestays-top rated & affortable"),

                  const Divider(),
                  _buildSectionTitle("EXCLUSIVE DEALS"),
                  _buildCheckbox("Last minute deals"),
                  _buildCheckbox("Rush deals"),

                  const Divider(),
                  _buildSectionTitle("ROOM VIEWS"),
                  _buildCheckbox("Garden view"),
                  _buildCheckbox("City view"),

                  const Divider(),
                  _buildSectionTitle("ROOM AMENITIES"),
                  _buildCheckbox("Wi-Fi"),
                  _buildCheckbox("Swimming pool"),
                  _buildCheckbox("Jacuzzi"),
                  _buildCheckbox("Private Pool"),
                  _buildCheckbox("Bathtub"),
                  _buildCheckbox("Balcony"),

                  const Divider(),
                  _buildSectionTitle("OTHER POPULAR AMENITIES"),
                  _buildCheckbox("Wi-Fi"),
                  _buildCheckbox("Swimming pool"),
                  _buildCheckbox("Spa"),
                  _buildCheckbox("Cafe"),

                  const Divider(),
                  _buildSectionTitle("HOTEL RULES"),
                  _buildCheckbox("Pets allowed"),
                  _buildCheckbox("Allow unmarried couples"),

                  const Divider(),
                  _buildSectionTitle("POPULAR BRANDS HOTEL"),
                  _buildCheckbox("Fortune"),
                  _buildCheckbox("Marriott,Westin"),
                  _buildCheckbox("Hyatt"),

                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
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
                        "APPLY FILTERS",
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label) {
    return StatefulBuilder(
      builder: (context, setStateSB) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Checkbox(
                value: _selectedFilters[label] ?? false,
                onChanged: (val) {
                  setStateSB(() {
                    _selectedFilters[label] = val ?? false;
                  });
                  setState(() {});
                },
                activeColor: Color(0xFFFF7043),
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSingleCategory(BuildContext context, String title, List<String> options) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
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
                      onPressed: () => Navigator.pop(context),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          _buildHeader(),


          // Flexible(
          //   child: AnimatedSwitcher(
          //     duration: Duration(milliseconds: 500),
          //     child: _showResults ? _buildHotelResults() : _buildSearchForm(),
          //   ),
          // ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _showResults
                  ? Align(
                alignment: Alignment.topCenter, // force top alignment
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
              // IconButton(
              //   icon: Icon(Icons.restaurant, color: Colors.white),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => FoodCourtScreen()),
              //     );
              //   },
              //   tooltip: "Food Court",
              // ),
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

  // Widget _buildSearchForm() {
  //   return FadeTransition(
  //     opacity: _fadeAnimation,
  //     child: SlideTransition(
  //       position: _slideAnimation,
  //       child: SingleChildScrollView(
  //         padding: EdgeInsets.all(20),
  //         child: Column(
  //           children: [
  //             // Offers Carousel
  //             _buildOffersCarousel(),
  //             SizedBox(height: 30),
  //
  //             // Search Field
  //             _buildSearchField(),
  //             SizedBox(height: 20),
  //
  //             // Date Selection
  //             _buildDateSelection(),
  //             SizedBox(height: 20),
  //
  //             // Counters
  //             _buildCounters(),
  //             SizedBox(height: 20),
  //
  //             // Purpose Selection
  //             _buildPurposeSelection(),
  //             SizedBox(height: 30),
  //
  //             // Search Button
  //             _buildSearchButton(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

    // return Container(
    //   margin: EdgeInsets.symmetric(horizontal: 4),
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [offer["color"], offer["color"].withOpacity(0.8)],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     borderRadius: BorderRadius.circular(20),
    //     boxShadow: [
    //       BoxShadow(
    //         color: offer["color"].withOpacity(0.3),
    //         blurRadius: 15,
    //         offset: Offset(0, 8),
    //       ),
    //     ],
    //   ),
    //   child: Stack(
    //     children: [
    //       Positioned(
    //         right: -20,
    //         top: -20,
    //         child: Icon(offer["icon"], size: 100, color: Colors.white.withOpacity(0.1)),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(20),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               offer["title"],
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white,
    //               ),
    //             ),
    //             SizedBox(height: 5),
    //             Text(
    //               offer["subtitle"],
    //               style: TextStyle(
    //                 fontSize: 14,
    //                 color: Colors.white.withOpacity(0.9),
    //               ),
    //             ),
    //             SizedBox(height: 5),
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    //               decoration: BoxDecoration(
    //                 color: Colors.white.withOpacity(0.2),
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child: Text(
    //                 "Book Now",
    //                 style: TextStyle(color: Colors.white, fontSize: 12),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return Container(
      height: 140, // make sure it fits inside CarouselSlider
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12), // reduced padding
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
              size: 80, // reduced icon size
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
                  fontSize: 16, // slightly smaller font
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
                // Filter Chips
                _buildFilterChips(),
                SizedBox(height: 20),

                // Results Header
                Row(
                  children: [
                    Text(
                      "🏨 Popular in Chennai",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "${_hotels.length} properties",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Based on your preferences",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 20),

                // Hotel List
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

  Widget _buildFilterChips() {
    List<Map<String, dynamic>> filters = [
      {"label": "All Filters", "icon": Icons.filter_list, "onTap": () => _openFilterSheet(context)},
      {"label": "Price", "icon": Icons.attach_money, "onTap": () => _openSingleCategory(context, "PRICE PER NIGHT", ["0 - 1500", "1500 - 5000", "5000 - 10000", "10000+ above"])},
      {"label": "Rating", "icon": Icons.star, "onTap": () => _openSingleCategory(context, "STAR RATING", ["3 star hotel", "4 star hotel", "5 star hotel"])},
      {"label": "Amenities", "icon": Icons.wifi, "onTap": () => _openSingleCategory(context, "AMENITIES", ["Wi-Fi", "Swimming Pool", "Spa", "Gym", "Parking"])},
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

  Widget _hotelCard(Map<String, dynamic> hotel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HotelDetailsScreen(hotel: hotel)),
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