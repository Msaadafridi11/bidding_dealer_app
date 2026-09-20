//
// import 'package:bidding_user/Models/item_model.dart';
// import 'package:bidding_user/Screens/CarDetailScreen.dart';
// import 'package:bidding_user/utils/isAuctionLive.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Expiredcarsscreen extends StatelessWidget {
//   const Expiredcarsscreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Expired Cars'),
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
//           /// STEP 1: Convert Firestore docs → ItemModel
//           final allItems = snapshot.data!.docs
//               .map((doc) => ItemModel.fromJson(doc.data()))
//               .toList();
//
//           /// STEP 2: Filter ONLY expired cars
//           final expiredCars =
//               allItems.where((item) => !isAuctionLive(item)).toList();
//
//           if (expiredCars.isEmpty) {
//             return const Center(child: Text('No expired cars'));
//           }
//
//           /// STEP 3: Show UI
//           return ListView.builder(
//             itemCount: expiredCars.length,
//             itemBuilder: (context, index) {
//               final item = expiredCars[index];
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
//                               /// TITLE
//                               Text(
//                                 item.title ?? 'No Title',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                               const SizedBox(height: 6),
//
//                               /// INFO ROW
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
//                                   /// EXPIRED BADGE
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8, vertical: 4),
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: const Text(
//                                       'Expired',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//
//                                   const SizedBox(width: 10),
//
//                                   /// BID OFFER BUTTON (DISABLED)
//                                   Container(
//                                     width: 80,
//                                     height: 38,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade400,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: const Center(
//                                       child: Text(
//                                         'Bid Closed',
//                                         style: TextStyle(fontSize: 12),
//                                       ),
//                                     ),
//                                   ),
//
//                                   const Spacer(),
//
//                                   /// FINAL BID
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

import 'package:bidding_user/Models/item_model.dart';
import 'package:bidding_user/Screens/CarDetailScreen.dart';
import 'package:bidding_user/utils/isAuctionLive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ================= CONTROLLER =================
class ExpiredCarsController extends GetxController {
  var isLoading = true.obs;
  var expiredCars = <ItemModel>[].obs;

  @override
  void onInit() {
    fetchExpiredCars();
    super.onInit();
  }

  void fetchExpiredCars() {
    isLoading(true);

    expiredCars.bindStream(
      FirebaseFirestore.instance
          .collection('itemModel')
          .snapshots()
          .map((snapshot) {
        final allItems = snapshot.docs
            .map((doc) => ItemModel.fromJson(doc.data()))
            .toList();

        return allItems
            .where((item) => !isAuctionLive(item))
            .toList();
      }),
    );

    isLoading(false);
  }

}

/// ================= SCREEN =================
class Expiredcarsscreen extends StatelessWidget {
  const Expiredcarsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpiredCarsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expired Cars'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.expiredCars.isEmpty) {
          return const Center(child: Text('No expired cars'));
        }

        return ListView.builder(
          itemCount: controller.expiredCars.length,
          itemBuilder: (context, index) {
            final item = controller.expiredCars[index];

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
                          loadingBuilder:
                              (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 90,
                              width: 120,
                              color: Colors.grey[200],
                              child: const Center(
                                  child:
                                  CircularProgressIndicator(strokeWidth: 2)),
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) =>
                              Container(
                                height: 90,
                                width: 120,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image,
                                    color: Colors.grey),
                              ),
                        )
                            : Container(
                          height: 90,
                          width: 120,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE
                            Text(
                              item.title ?? 'No Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            /// INFO ROW
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
                                  /// EXPIRED BADGE
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'Expired',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  /// BID CLOSED BUTTON
                                  Container(
                                    width: 80,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Bid Closed',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  /// FINAL BID
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
