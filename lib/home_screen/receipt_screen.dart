// import 'package:flutter/material.dart';
//
// class ReceiptScreen extends StatelessWidget {
//   final Map<String, dynamic> hotel;
//   final double totalAmount;
//   final String paymentMethod;
//
//   const ReceiptScreen({
//     super.key,
//     required this.hotel,
//     required this.totalAmount,
//     required this.paymentMethod,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Receipt"),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   "RECEIPT",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepOrange[800],
//                   ),
//                 ),
//               ),
//               const Divider(height: 30, thickness: 1),
//               Text("Hotel: ${hotel["name"]}",
//                   style: const TextStyle(fontSize: 16)),
//               Text("Location: ${hotel["location"]}",
//                   style: const TextStyle(fontSize: 16)),
//               Text("Date: ${DateTime.now().toString().split(" ")[0]}",
//                   style: const TextStyle(fontSize: 16)),
//               Text("Payment Method: $paymentMethod",
//                   style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 10),
//               const Divider(height: 20, thickness: 1),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Total Amount:",
//                       style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text(
//                     "\$${totalAmount.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepOrange),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Center(
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepOrange,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.check, color: Colors.white),
//                   label: const Text("Close",
//                       style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
