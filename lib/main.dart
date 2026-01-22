import 'package:flutter/material.dart';
import 'package:hotel_booking_mobile_application/home_screen/hotel_search_screen.dart';


import 'package:hotel_booking_mobile_application/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HotelSearchScreen(),
    );
  }
}
