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
//
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
//         bool isWinner= !isLive && data.currentBidUserId == FirebaseAuth.instance.currentUser?.uid;
//         if(isWinner){
//           Future.delayed(Duration.zero, () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => WinnerScreen(itemData: data),));
//           },);
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
//                                       CrossAxisAlignment.start,
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
//                                       CrossAxisAlignment.start,
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
//                                       CrossAxisAlignment.start,
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
//                                       CrossAxisAlignment.start,
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
//                         ExpansionTile(title: Text('steering'), children: [
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
//                         ExpansionTile(title: Text('interior'), children: [
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
//                         // 1. Controller se value nikal kar check karein ke khali to nahi
//                         if (bidcontroller.text.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content:
//                                 Text("Please enter a bid amount")),
//                           );
//                           return;
//                         }
//
//                         int enteredBid = int.parse(bidcontroller.text);
//
//                         // 2. Data current bid ko safe tareeke se parse karein
//                         double currentBidInDb =
//                             double.tryParse(data.currentBid.toString()) ??
//                                 0.0;
//
//                         if (enteredBid <= currentBidInDb) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                   "Bid must be higher than \$${data.currentBid}"),
//                             ),
//                           );
//                         } else {
//                           // 3. User ID ko variable mein lein
//                           String? currentVisitorId =
//                               FirebaseAuth.instance.currentUser?.uid;
//
//                           // Agar user login nahi hai to usay bid nahi karne dena chahiye
//                           if (currentVisitorId == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       "Please login to place a bid")),
//                             );
//                             return;
//                           }
//
//                           // 4. Firestore Update
//                           await FirebaseFirestore.instance
//                               .collection('itemModel')
//                               .doc(widget.itemId)
//                               .update({
//                             'currentBid': enteredBid,
//                             'currentBidUserId': currentVisitorId,
//                           });
//
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content: Text(
//                                     'Your bid of \$$enteredBid added successfully!')),
//                           );
//                           bidcontroller.clear();
//                         }
//                       }
//                           : null,
//                       child: Container(
//                         height: 45,
//                         padding: const EdgeInsets.symmetric(horizontal: 18),
//                         decoration: BoxDecoration(
//                           // COLOR LOGIC: Winner ke liye Green, Baqi sab ke liye Grey
//                           color: isLive
//                               ? Colors.blue
//                               : (data.currentBidUserId ==
//                               FirebaseAuth.instance.currentUser?.uid
//                               ? Colors.green
//                               : Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             isLive
//                                 ? 'Add Bid'
//                                 : (data.currentBidUserId ==
//                                 FirebaseAuth.instance.currentUser?.uid
//                                 ? 'YOU WON! 🎉'
//                                 : 'Auction Ended'),
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
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildQuickBidButton(500, bidcontroller),
//                     SizedBox(width: 10),
//                     _buildQuickBidButton(1000, bidcontroller),
//                     SizedBox(width: 10),
//                     _buildQuickBidButton(2000, bidcontroller),
//                   ],
//                 )
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
//       bidcontroller.text.isEmpty ? 0 : int.parse(bidcontroller.text);
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