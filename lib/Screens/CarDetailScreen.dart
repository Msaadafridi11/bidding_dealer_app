import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bidding_user/Models/item_model.dart';

import 'package:bidding_user/Screens/WinnerScreen.dart';
import 'package:bidding_user/Widgets/car_image_slider.dart';
/// ================= CONTROLLER =================

// import 'package:bidding_user/Models/item_model.dart';
// import 'package:bidding_user/Screens/WinnerScreen.dart';
// import 'package:bidding_user/Widgets/car_image_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Cardetailscreen extends StatefulWidget {
//   const Cardetailscreen({super.key, required this.itemId});
//   final String itemId;
//
//   @override
//   State<Cardetailscreen> createState() => _CardetailscreenState();
// }
//
// class _CardetailscreenState extends State<Cardetailscreen> {
//   final TextEditingController bidcontroller = TextEditingController();
//   bool isFirstTime = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance
//           .collection('itemModel')
//           .doc(widget.itemId)
//           .get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return const Scaffold(
//             body: Center(child: Text('Item not found')),
//           );
//         }
//
//         final data = ItemModel.fromJson(
//           snapshot.data!.data() as Map<String, dynamic>,
//         );
//
//         bool isTimeExpired = DateTime.now().isAfter(data.bidEndTime!);
//         bool isLive = (data.isActive ?? false) && !isTimeExpired;
//
//         if (isFirstTime) {
//           bidcontroller.text = data.currentBid.toString();
//           isFirstTime = false;
//         }
//
//         bool isWinner = !isLive &&
//             data.currentBidUserId == FirebaseAuth.instance.currentUser?.uid;
//         if (isWinner) {
//           Future.delayed(
//             Duration.zero,
//             () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => WinnerScreen(itemData: data),
//                   ));
//             },
//           );
//         }
//
//         return Scaffold(
//           backgroundColor: Colors.white,
//
//           /// BODY
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // IMAGE (START FROM TOP)
//
//                 CarImageSlider(imageUrls: data.imageUrls),
//
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       /// TITLE + HIGHEST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data.title ?? '',
//                             style: const TextStyle(fontSize: 25),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 '\$${data.currentBid ?? 0}',
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                               const Text('highest bid'),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       /// SELLER PRICE
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Seller price',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('\$${data.sellerPrice ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Minimum Bid',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('\$${data.minimumBid ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Your Last Bid',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('\$${data.currentBid ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const SizedBox(height: 20),
//                       // This is Listview
//                       SizedBox(
//                         height: 120,
//                         child: ListView(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   width: 100,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: Colors.grey.shade300)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 8.0, left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 10),
//                                         Icon(
//                                           Icons.speed,
//                                           color: Colors.blue,
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           '${data.mileage.toString()} km',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                         Text(
//                                           'Mileage',
//                                           style: TextStyle(
//                                               fontSize: 12, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   width: 100,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: Colors.grey.shade300)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 8.0, left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 10),
//                                         Icon(
//                                           Icons.location_on,
//                                           color: Colors.blue,
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           '${data.registeredIn.toString()} ',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                         Text(
//                                           'Registered ',
//                                           style: TextStyle(
//                                               fontSize: 12, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   width: 100,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: Colors.grey.shade300)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 8.0, left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 10),
//                                         Icon(
//                                           Icons.energy_savings_leaf_outlined,
//                                           color: Colors.blue,
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           '${data.engineSize.toString()} ',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                         Text(
//                                           'Engine Size',
//                                           style: TextStyle(
//                                               fontSize: 12, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   width: 100,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: Colors.grey.shade300)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 8.0, left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 10),
//                                         Icon(
//                                           Icons.format_color_fill_outlined,
//                                           color: Colors.blue,
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           '${data.exteriorColor.toString()} ',
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                         Text(
//                                           'Exterior Color',
//                                           style: TextStyle(
//                                               fontSize: 12, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: ExpansionTile(
//                             title: Text('Car Details'),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(data.description ?? ''),
//                               )
//                             ]),
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Make',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.make}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Model',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.model ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Trim',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.trim ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('year',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.year ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Mileage',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.mileage ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Register Emirates',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.registeredIn ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('interior type',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.interiorType ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('body type',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.bodyType ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('specipication',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.specification ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('exterior color',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.exteriorColor ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('enterior color',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.enteriorColor ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Keys',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.keys ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('first owner',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.firstOwner ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('engine size',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.engineSize ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('number of cylinders',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.numberOfCylinders ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('fuel type',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.fuelType ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('transmission',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.transmission ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// LAST BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('wheel type',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.wheelType ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('car option',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.carOptions ?? 0}',
//                               style: const TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       const Divider(),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       /// MINIMUM BID
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('safetybuilt status',
//                               style: TextStyle(color: Colors.grey)),
//                           Text('${data.safetyBeltStatus ?? 0}',
//                               style: const TextStyle(color: Colors.green)),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: ExpansionTile(
//                             title: Text('extirior condation'),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(data.exteriorCondition ?? ''),
//                               )
//                             ]),
//                       ),
//                       SizedBox(height: 5),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: ExpansionTile(title: Text('history'), children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(data.history ?? ''),
//                           )
//                         ]),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: ExpansionTile(
//                             title: Text('engine trenstion'),
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(data.engineSize ?? ''),
//                               )
//                             ]),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child:
//                             ExpansionTile(title: Text('steering'), children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(data.steering ?? ''),
//                           ),
//                         ]),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child:
//                             ExpansionTile(title: Text('interior'), children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(data.interior ?? ''),
//                           ),
//                         ]),
//                       ),
//
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: ExpansionTile(title: Text('specs'), children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(data.specs ?? ''),
//                           )
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           //bottomNavigation Bar
//
//           bottomNavigationBar: Container(
//             height: 120,
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// INPUT
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 45,
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: TextField(
//                           controller: bidcontroller,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             enabled: isLive,
//                             hintText: isLive ? "Enter bid" : "Bidding ended",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(width: 10),
//                     // ADD BID BUTTON
//                     GestureDetector(
//                       onTap: isLive
//                           ? () async {
//                               if (bidcontroller.text.isEmpty) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                           Text("Please enter a bid amount")),
//                                 );
//                                 return;
//                               }
//
//                               int enteredBid = int.parse(bidcontroller.text);
//                               double currentBidInDb =
//                                   double.tryParse(data.currentBid.toString()) ??
//                                       0.0;
//
//                               // 2. Amount Check
//                               if (enteredBid <= currentBidInDb) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Bid must be higher than \$${data.currentBid}")),
//                                 );
//                                 return; // Yahin se wapis chale jao
//                               }
//
//                               // 3. AGAR SAB SAHI HAI, TO DIALOG DIKHAO
//                               _showMyDialog(
//                                 context: context,
//                                 title: "Confirm Bid",
//                                 message: "place a bid of \$$enteredBid",
//                                 onConfirm: () async {
//                                   String? currentVisitorId = FirebaseAuth.instance.currentUser?.uid;
//
//                                   if (currentVisitorId == null) return;
//
//                                   try {
//                                     // 1. UPDATE MAIN ITEM (Taake sab ko pata chale latest bid kya hai)
//                                     await FirebaseFirestore.instance
//                                         .collection('itemModel') // Aapka main cars collection
//                                         .doc(widget.itemId)
//                                         .update({
//                                       'currentBid': enteredBid,
//                                       'currentBidUserId': currentVisitorId,
//
//                                     });
//
//                                     // 2. ADD SUB-COLLECTION (Dealer ki record ke liye usi item ke andar)
//                                     // Ye line aapka sub-collection banayegi
//
//                                     // await FirebaseFirestore.instance.collection('userModel') // Sub-collection ka naam
//                                     //     .doc(currentVisitorId) // Har user ka apna document taake data overwrite na ho
//                                     //
//                                     //     .collection('itemModel')
//                                     //     .doc(widget.itemId)
//                                     //     .set({
//                                     //   'bidAmount': enteredBid,
//                                     //   'dealerUid': currentVisitorId,
//                                     //   'itemId': widget.itemId,
//                                     //
//                                     // });
//
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('Your bid of \$$enteredBid added successfully!')),
//                                     );
//                                     bidcontroller.clear();
//                                   } catch (e) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text('Error: $e')),
//                                     );
//                                   }
//                                 },
//                               );
//                             }
//                           : null,
//                       child: Container(
//                         height: 45,
//                         padding: const EdgeInsets.symmetric(horizontal: 18),
//                         decoration: BoxDecoration(
//                           color: isLive
//                               ? Colors.blue
//                               : (data.currentBidUserId ==
//                                       FirebaseAuth.instance.currentUser?.uid
//                                   ? Colors.green
//                                   : Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             isLive
//                                 ? 'Add Bid'
//                                 : (data.currentBidUserId ==
//                                         FirebaseAuth.instance.currentUser?.uid
//                                     ? 'YOU WON! 🎉'
//                                     : 'Auction Ended'),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // child: Container(
//                     //   height: 45,
//                     //   padding: const EdgeInsets.symmetric(horizontal: 18),
//                     //   decoration: BoxDecoration(
//                     //     color: isLive ? Colors.blue : Colors.grey,
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     //   child: Center(
//                     //     child: Text(
//                     //       isLive ? 'Add Bid' : 'Auction Closed',
//                     //       style: TextStyle(color: Colors.white),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 // QUICK BID BUTTONS
//                 isLive
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildQuickBidButton(500, bidcontroller),
//                           SizedBox(width: 10),
//                           _buildQuickBidButton(1000, bidcontroller),
//                           SizedBox(width: 10),
//                           _buildQuickBidButton(2000, bidcontroller),
//                         ],
//                       )
//                     : Text(''),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // Helper widget code
// Widget _buildQuickBidButton(int amount, TextEditingController bidcontroller) {
//   return GestureDetector(
//     onTap: () {
//       int currentBid =
//           bidcontroller.text.isEmpty ? 0 : int.parse(bidcontroller.text);
//       int newBid = currentBid + amount;
//       bidcontroller.text = newBid.toString();
//     },
//     child: Container(
//       height: 40,
//       width: 50,
//       child: Center(child: Text('+$amount')),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           border: Border.all(color: Colors.grey.shade300)),
//     ),
//   );
// }
//
// void _showMyDialog({
//   required BuildContext context,
//   required String title,
//   required String message,
//   required VoidCallback onConfirm,
// }) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text("Are you sure you want to $message?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Closes the dialog
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               onConfirm(); // Executes your logic
//               Navigator.pop(context); // Closes the dialog
//             },
//             child: const Text("Confirm"),
//           ),
//         ],
//       );
//     },
//   );
// }

/// ==========================
/// Controller for Cardetail
/// ==========================
class CardetailController extends GetxController {
  final ItemModel itemData; // Original data from previous screen
  CardetailController(this.itemData);

  var currentBid = 0.obs;
  var isLive = false.obs;
  var isWinner = false.obs;
  var bidController = TextEditingController();
  StreamSubscription<DocumentSnapshot>? _itemSubscription;

  @override
  void onInit() {
    super.onInit();

    if (itemData.itemId != null && itemData.itemId!.isNotEmpty) {
      _itemSubscription = FirebaseFirestore.instance
          .collection('itemModel')
          .doc(itemData.itemId)
          .snapshots()
          .listen((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          if (Get.currentRoute == '/Cardetailscreen') {
            Get.back();
            Get.snackbar("Notice",
                "This vehicle listing has been removed by the administrator.");
          }
          return;
        }

        ItemModel updatedItem =
            ItemModel.fromJson(snapshot.data() as Map<String, dynamic>);

        currentBid.value = (updatedItem.currentBid ?? 0).toInt();

        bool expired = false;
        if (updatedItem.bidEndTime != null) {
          expired = DateTime.now().isAfter(updatedItem.bidEndTime!);
        }

        isLive.value = (updatedItem.isActive ?? true) && !expired;

        String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

        /// WINNER LOGIC
        if (expired) {
          if (updatedItem.currentBidUserId == currentUserId) {
            isWinner.value = true;

            /// 🔥 Navigate to Winner Screen ONLY ONCE
            Future.delayed(const Duration(milliseconds: 500), () {
              if (Get.currentRoute != '/WinnerScreen') {
                Get.to(() => WinnerScreen(itemData: updatedItem),
                    routeName: '/WinnerScreen');
              }
            });
          } else {
            isWinner.value = false;
          }
        }
      });
    }

    currentBid.value = (itemData.currentBid ?? 0).toInt();
    bidController.text = currentBid.value.toString();
  }

  @override
  void onClose() {
    _itemSubscription?.cancel();
    bidController.dispose();
    super.onClose();
  }

  /// Add bid logic
  Future<void> placeBid(int enteredBid) async {
    String? currentVisitorId = FirebaseAuth.instance.currentUser?.uid;
    if (currentVisitorId == null) return;

    if (enteredBid <= currentBid.value) {
      Get.snackbar("Error", "Bid must be higher than \$${currentBid.value}");
      return;
    }

    try {
      // Update Firestore
      await FirebaseFirestore.instance
          .collection('itemModel')
          .doc(itemData.itemId)
          .update({
        'currentBid': enteredBid,
        'currentBidUserId': currentVisitorId,
      });

      // Update local state
      currentBid.value = enteredBid;
      bidController.text = enteredBid.toString();
      Get.snackbar("Success", "Your bid of \$$enteredBid added!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void quickBid(int amount) {
    int newBid =
        (bidController.text.isEmpty ? 0 : int.parse(bidController.text)) +
            amount;
    bidController.text = newBid.toString();
  }
}

/// ==========================
/// Cardetail Screen
/// ==========================
class Cardetailscreen extends StatelessWidget {
  final ItemModel itemData;
  const Cardetailscreen({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CardetailController(itemData));


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [

                CarImageSlider(imageUrls: itemData.imageUrls),

                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // TITLE + HIGHEST BID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          itemData.title ?? '',
                          style: const TextStyle(fontSize: 25),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Obx(() => Text('\$${controller.currentBid.value}', style: const TextStyle(fontSize: 20))),
                          const Text('highest bid'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  /// Seller Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Seller price', style: TextStyle(color: Colors.grey)),
                      Text('\$${itemData.sellerPrice ?? 0}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const SizedBox(height: 5), const Divider(), const SizedBox(height: 5),
                  /// Minimum Bid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Minimum Bid', style: TextStyle(color: Colors.grey)),
                      Text('\$${itemData.minimumBid ?? 0}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 5), const Divider(), const SizedBox(height: 5),
                  /// Last Bid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your Last Bid', style: TextStyle(color: Colors.grey)),
                      Obx(() => Text('\$${controller.currentBid.value}', style: const TextStyle(color: Colors.grey))),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Specs horizontal list (mileage, registeredIn, etc.)
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _specItem(Icons.speed, '${itemData.mileage ?? 0} km', 'Mileage'),
                        _specItem(Icons.location_on, itemData.registeredIn ?? '', 'Registered'),
                        _specItem(Icons.energy_savings_leaf_outlined, itemData.engineSize ?? '', 'Engine Size'),
                        _specItem(Icons.format_color_fill_outlined, itemData.exteriorColor ?? '', 'Exterior Color'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Car Details Expansion
                  _expansionTile('Car Details', itemData.description ?? ''),
                  _expansionTile('Extirior Condition', itemData.exteriorCondition ?? ''),
                  _expansionTile('History', itemData.history ?? ''),
                  _expansionTile('Engine Trensition', itemData.engineSize ?? ''),
                  _expansionTile('Steering', itemData.steering ?? ''),
                  _expansionTile('Interior', itemData.interior ?? ''),
                  _expansionTile('Specs', itemData.specs ?? ''),

                  // Add your other fields exactly like your original code here...
                  // e.g., make, model, trim, year, mileage, fuelType, etc.
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Bid Section
      bottomNavigationBar: Container(
        height: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),),
                    child: Obx(() => TextFormField(
                      controller: controller.bidController,
                      keyboardType: TextInputType.number,
                      enabled: controller.isLive.value,
                      decoration: InputDecoration(
                        hintText: controller.isLive.value ? "Enter bid" : "Bidding ended",
                        border: InputBorder.none,
                      ),
                    )),
                  ),
                ),
                const SizedBox(width: 10),
                Obx(() => GestureDetector(
                  onTap: controller.isLive.value
                      ? () {
                    int enteredBid = int.tryParse(controller.bidController.text) ?? 0;
                    if (enteredBid == 0) {
                      Get.snackbar("Error", "Please enter a bid amount");
                      return;
                    }

                    _showMyDialog(
                      title: "Confirm Bid",
                      message: "place a bid of \$$enteredBid",
                      onConfirm: () => controller.placeBid(enteredBid),
                    );
                  }
                      : null,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: controller.isLive.value
                          ? Colors.blue
                          : (controller.isWinner.value ? Colors.green : Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        controller.isLive.value
                            ? 'Add Bid'
                            : (controller.isWinner.value ? 'YOU WON! 🎉' : 'Auction Ended'),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 10),
            // Quick Bid Buttons
            Obx(() => controller.isLive.value
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _quickBidButton(500, controller),
                const SizedBox(width: 10),
                _quickBidButton(1000, controller),
                const SizedBox(width: 10),
                _quickBidButton(2000, controller),
              ],
            )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}

/// ==========================
/// Helper Widgets
/// ==========================
Widget _specItem(IconData icon, String value, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

Widget _expansionTile(String title, String content) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ExpansionTile(
      title: Text(title),
      children: [Padding(padding: const EdgeInsets.all(8.0), child: Text(content))],
    ),
  );
}

Widget _quickBidButton(int amount, CardetailController controller) {
  return GestureDetector(
    onTap: () => controller.quickBid(amount),
    child: Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
      child: Center(child: Text('+$amount')),
    ),
  );
}

void _showMyDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  Get.dialog(AlertDialog(
    title: Text(title),
    content: Text("Are you sure you want to $message?"),
    actions: [
      TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
      ElevatedButton(
        onPressed: () {
          onConfirm();
          Get.back();
        },
        child: const Text("Confirm"),
      ),
    ],
  ));
}



