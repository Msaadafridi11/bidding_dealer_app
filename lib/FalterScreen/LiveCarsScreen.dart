// import 'package:bidding_user/Models/item_model.dart';
// import 'package:bidding_user/Screens/CarDetailScreen.dart';
// import 'package:bidding_user/utils/TimeUtils.dart';
// import 'package:bidding_user/utils/isAuctionLive.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class LiveCarsScreen extends StatelessWidget {
//   const LiveCarsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Live Auctions'),
//       ),
//       body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         future: FirebaseFirestore.instance.collection('itemModel').get(),
//
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return const Center(child: Text('Something went wrong'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No data found'));
//           }
//
//           /// STEP 1: Firestore → Model
//           final allItems = snapshot.data!.docs
//               .map((doc) => ItemModel.fromJson(doc.data()))
//               .toList();
//
//           /// STEP 2: Filter ONLY LIVE auctions
//           final liveCars =
//               allItems.where((item) => isAuctionLive(item)).toList();
//
//           if (liveCars.isEmpty) {
//             return const Center(child: Text('No live auctions'));
//           }
//
//           /// STEP 3: UI
//           return ListView.builder(
//             itemCount: liveCars.length,
//             itemBuilder: (context, index) {
//               final item = liveCars[index];
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       // builder: (_) => Cardetailscreen(itemId: item.itemId!),
//                       builder: (_) => Cardetailscreen(itemData: item,),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /// IMAGE
//                         /// IMAGE
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: item.imageUrls!.isNotEmpty
//                               ? Image.network(
//                                   item.imageUrls![0], // Shows the first image from your list
//                                   height: 90,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                   // Shows a loading spinner while the image downloads from Supabase
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return Container(
//                                       height: 90,
//                                       width: 120,
//                                       color: Colors.grey[200],
//                                       child: const Center(
//                                           child: CircularProgressIndicator(
//                                               strokeWidth: 2)),
//                                     );
//                                   },
//                                   // Shows an error icon if the link is broken
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       Container(
//                                     height: 90,
//                                     width: 120,
//                                     color: Colors.grey[300],
//                                     child: const Icon(Icons.broken_image,
//                                         color: Colors.grey),
//                                   ),
//                                 )
//                               : Container(
//                                   // Placeholder if there are ZERO images in the database
//                                   height: 90,
//                                   width: 120,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.image_not_supported,
//                                       color: Colors.grey),
//                                 ),
//                         ),
//
//                         const SizedBox(width: 12),
//
//                         /// DETAILS
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               /// TITLE + TIMER
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       item.title ?? 'No Title',
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 6),
//                                   if (item.bidEndTime != null)
//                                     Text(
//                                       formatRemainingTime(item.bidEndTime!),
//                                       style: const TextStyle(
//                                         fontSize: 11,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//
//                               const SizedBox(height: 6),
//
//                               /// INFO
//                               Row(
//                                 children: [
//                                   const Icon(Icons.speed,
//                                       size: 16, color: Colors.blue),
//                                   const SizedBox(width: 4),
//                                   Text('${item.mileage ?? 0} km'),
//                                   const SizedBox(width: 12),
//                                   const Icon(Icons.location_on,
//                                       size: 16, color: Colors.blue),
//                                   const SizedBox(width: 4),
//                                   Text(item.registeredIn ?? 'N/A'),
//                                 ],
//                               ),
//
//                               const SizedBox(height: 6),
//                               Divider(color: Colors.grey.shade300),
//
//                               /// STATUS + BID
//                               Row(
//                                 children: [
//                                   /// LIVE BADGE
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     decoration: BoxDecoration(
//                                       color: Colors.green,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: const Text(
//                                       'Live',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//
//                                   const SizedBox(width: 10),
//
//                                   /// ADD BID BUTTON
//                                   Container(
//                                     width: 80,
//                                     height: 38,
//                                     decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: const Center(
//                                       child: Text(
//                                         'Add Bid',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//
//                                   const Spacer(),
//
//                                   /// CURRENT BID
//                                   Text(
//                                     '\$${item.currentBid ?? 0}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               const SizedBox(height: 4),
//
//                               const Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   'Highest Bid',
//                                   style: TextStyle(fontSize: 11),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:bidding_user/Models/item_model.dart';
import 'package:bidding_user/Screens/CarDetailScreen.dart';
import 'package:bidding_user/utils/TimeUtils.dart';
import 'package:bidding_user/utils/isAuctionLive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ================= CONTROLLER =================
class LiveCarsController extends GetxController {
  var isLoading = true.obs;
  var liveCars = <ItemModel>[].obs;

  // ✅ ADDED (for reactive timer)
  var currentTime = DateTime.now().obs;
  Timer? _timer;

  @override
  void onInit() {
    fetchLiveCars();

    // ✅ ADDED (updates every second but does NOT rebuild whole screen)
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime.value = DateTime.now();
    });

    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void fetchLiveCars() {
    liveCars.bindStream(
      FirebaseFirestore.instance
          .collection('itemModel')
          .snapshots()
          .map((snapshot) {
        final allItems = snapshot.docs
            .map((doc) => ItemModel.fromJson(doc.data()))
            .toList();

        return allItems
            .where((item) => isAuctionLive(item))
            .toList();
      }),
    );

    isLoading(false);
  }
}

/// ================= SCREEN =================
class LiveCarsScreen extends StatelessWidget {
  const LiveCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveCarsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Auctions'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.liveCars.isEmpty) {
          return const Center(child: Text('No live auctions'));
        }

        return ListView.builder(
          itemCount: controller.liveCars.length,
          itemBuilder: (context, index) {
            final item = controller.liveCars[index];

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => Cardetailscreen(itemData: item),
                  routeName: '/Cardetailscreen',
                );
              },
              child: Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: item.imageUrls!.isNotEmpty
                            ? Image.network(
                          item.imageUrls![0],
                          height: 90,
                          width: 120,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          height: 90,
                          width: 120,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE + TIMER
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title ?? 'No Title',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),

                                /// ✅ ONLY THIS PART WRAPPED WITH OBX
                                if (item.bidEndTime != null)
                                  Obx(() {
                                    controller.currentTime.value;

                                    final remaining =
                                    formatRemainingTime(
                                        item.bidEndTime!);

                                    return Text(
                                      remaining,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: remaining == "Expired"
                                            ? Colors.grey
                                            : Colors.red,
                                      ),
                                    );
                                  }),
                              ],
                            ),

                            const SizedBox(height: 6),

                            /// INFO
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Icon(Icons.speed,
                                      size: 16, color: Colors.blue),
                                  const SizedBox(width: 4),
                                  Text('${item.mileage ?? 0} km'),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.blue),
                                  const SizedBox(width: 4),
                                  Text(item.registeredIn ?? 'N/A'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 6),
                            Divider(color: Colors.grey.shade300),

                            /// STATUS + BID
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  /// LIVE / EXPIRED (auto update)
                                  Obx(() {
                                    controller.currentTime.value;

                                    final expired =
                                        formatRemainingTime(
                                            item.bidEndTime!) ==
                                            "Expired";

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: expired
                                            ? Colors.grey
                                            : Colors.green,
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),

                                      child: Text(
                                        expired ? 'Expired' : 'Live',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    );
                                  }),

                                  const SizedBox(width: 10),

                                  /// ADD BID (auto hide when expired)
                                  Obx(() {
                                    controller.currentTime.value;

                                    final expired =
                                        formatRemainingTime(
                                            item.bidEndTime!) ==
                                            "Expired";

                                    if (expired) {
                                      return const SizedBox();
                                    }

                                    return Container(
                                      width: 80,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Bid',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }),

                                  const SizedBox(width: 15),

                                  /// CURRENT BID
                                  Text(
                                    '\$${item.currentBid ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Highest Bid',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}