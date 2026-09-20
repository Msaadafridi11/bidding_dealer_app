// import 'package:bidding_user/Models/item_model.dart';
// import 'package:bidding_user/Screens/CarDetailScreen.dart';
// import 'package:bidding_user/utils/TimeUtils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Allcarsscree extends StatefulWidget {
//   const Allcarsscree({super.key});
//
//   @override
//   State<Allcarsscree> createState() => _AllcarsscreeState();
// }
//
// class _AllcarsscreeState extends State<Allcarsscree> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder(
//        future: FirebaseFirestore.instance.collection('itemModel').get(),
//       //future: FirebaseFirestore.instance.collection('itemModel').get(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return const Center(child: Text('Error fetching data'));
//         }
//
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             final data = ItemModel.fromJson(snapshot.data!.docs[index].data());
//             // this is veriable for decide live & expair & add bid & offer bid
//             bool isAdminDataActive = data.isActive ?? false;
//
//             // chack time is end or not
//             bool isTimeLeft = false;
//             if (data.bidEndTime != null) {
//               isTimeLeft = DateTime.now().isBefore(data.bidEndTime!);
//             }
//
//             bool isLive = isAdminDataActive && isTimeLeft;
//
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Cardetailscreen(
//                       itemId: data.itemId!,
//                     ),
//                   ),
//                 );
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // IMAGE
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: data.imageUrls!.isNotEmpty
//                             ? Image.network(
//                                 data.imageUrls![0],
//                                 // Shows the first image from your list
//                                 height: 90,
//                                 width: 120,
//                                 fit: BoxFit.cover,
//                                 // Shows a loading spinner while the image downloads from Supabase
//                                 loadingBuilder:
//                                     (context, child, loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Container(
//                                     height: 90,
//                                     width: 120,
//                                     color: Colors.grey[200],
//                                     child: const Center(
//                                         child: CircularProgressIndicator(
//                                             strokeWidth: 2)),
//                                   );
//                                 },
//                                 // Shows an error icon if the link is broken
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Container(
//                                   height: 90,
//                                   width: 120,
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.broken_image,
//                                       color: Colors.grey),
//                                 ),
//                               )
//                             : Container(
//                                 // Placeholder if there are ZERO images in the database
//                                 height: 90,
//                                 width: 120,
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.image_not_supported,
//                                     color: Colors.grey),
//                               ),
//                       ),
//
//                       const SizedBox(width: 12),
//
//                       /// TEXT DATA
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             /// TITLE and bid end time
//                             Row(
//                               children: [
//                                 Text(
//                                   data.title ?? 'No Title',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 if (isLive && data.bidEndTime != null)
//                                   Text(
//                                     formatRemainingTime(data.bidEndTime!),
//                                     style: TextStyle(
//                                         fontSize: 11.2, color: Colors.red),
//                                   ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 4),
//
//                             /// milage | registrein | FuleType
//                             Row(
//                               children: [
//                                 // this is for milage
//                                 Icon(Icons.speed, size: 16, color: Colors.blue),
//                                 const SizedBox(width: 4),
//                                 Text('${data.mileage ?? 0} km'),
//                                 const SizedBox(width: 12),
//
//                                 // this is for registeredIn
//                                 Icon(Icons.location_on,
//                                     size: 16, color: Colors.blue),
//                                 const SizedBox(width: 4),
//                                 Text(data.registeredIn ?? 'N/A'),
//                                 const SizedBox(width: 12),
//
//                                 // this is for fuelType
//                                 Icon(Icons.local_gas_station,
//                                     size: 16, color: Colors.blue),
//                                 const SizedBox(width: 4),
//                                 Text(data.fuelType ?? 'N/A'),
//                               ],
//                             ),
//
//                             const SizedBox(height: 6),
//
//                             Divider(color: Colors.grey.shade300),
//
//                             Row(
//                               children: [
//                                 // this custom container for live and expired button
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: isLive ? Colors.green : Colors.red,
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(
//                                         color:
//                                             isLive ? Colors.green : Colors.red),
//                                   ),
//                                   child: Text(
//                                     isLive ? 'Live' : 'Expair',
//                                   ),
//                                 ),
//
//                                 SizedBox(width: 10),
//                                 // this container for add bid
//                                 Container(
//                                   width: 70,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                       color: Colors.blue,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10))),
//                                   child: Center(
//                                       child: Text(
//                                     isLive ? 'Add Bid' : 'Bid offer',
//                                   )),
//                                 ),
//
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                   '\$${data.currentBid ?? 0}',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text('heigest bid'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     ));
//   }
// }

import 'dart:async';
import 'package:bidding_user/Screens/CarDetailScreen.dart';
import 'package:bidding_user/utils/TimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:bidding_user/Models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/// ================= CONTROLLER =================
class AllCarsController extends GetxController {
  var isLoading = true.obs;
  var carList = <ItemModel>[].obs;

  // ✅ Added for reactive time update
  var currentTime = DateTime.now().obs;
  Timer? _timer;

  @override
  void onInit() {
    fetchCars();

    // ✅ Timer updates every second (lightweight)
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

  void fetchCars() {
    isLoading(true);

    carList.bindStream(
      FirebaseFirestore.instance
          .collection('itemModel')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => ItemModel.fromJson(doc.data()))
            .toList();
      }),
    );

    isLoading(false);
  }
}

/// ================= SCREEN =================
class Allcarsscree extends StatelessWidget {
  const Allcarsscree({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCarsController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchCars();
          },
          child: ListView.builder(
            itemCount: controller.carList.length,
            itemBuilder: (context, index) {
              final data = controller.carList[index];

              return Obx(() {
                controller.currentTime.value; // 🔥 trigger every second

                bool isAdminDataActive = data.isActive ?? false;

                bool isTimeLeft = false;
                if (data.bidEndTime != null) {
                  isTimeLeft =
                      DateTime.now().isBefore(data.bidEndTime!);
                }

                bool isLive = isAdminDataActive && isTimeLeft;

                return GestureDetector(
                  onTap: () {
                    Get.to(() => Cardetailscreen(
                      itemData: data,
                    ));
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          /// IMAGE
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(10),
                            child: data.imageUrls!.isNotEmpty
                                ? Image.network(
                              data.imageUrls![0],
                              height: 90,
                              width: 120,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              height: 90,
                              width: 120,
                              color: Colors.grey[300],
                              child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// TEXT DATA
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                /// TITLE and TIME
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.title ??
                                            'No Title',
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style:
                                        const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    if (isLive &&
                                        data.bidEndTime != null)
                                      Text(
                                        formatRemainingTime(
                                            data.bidEndTime!),
                                        style:
                                        const TextStyle(
                                          fontSize: 11.2,
                                          color: Colors.red,
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                /// INFO ROW
                                Row(
                                  children: [
                                    const Icon(Icons.speed,
                                        size: 16,
                                        color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text(
                                        '${data.mileage ?? 0} km'),
                                    const SizedBox(width: 12),

                                    const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text(data.registeredIn ??
                                        'N/A'),
                                    const SizedBox(width: 12),

                                    const Icon(
                                        Icons.local_gas_station,
                                        size: 16,
                                        color: Colors.blue),
                                    const SizedBox(width: 4),
                                    Text(data.fuelType ??
                                        'N/A'),
                                  ],
                                ),

                                const SizedBox(height: 6),
                                Divider(
                                    color:
                                    Colors.grey.shade300),

                                /// STATUS ROW
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                          horizontal: 8,
                                          vertical: 4),
                                      decoration:
                                      BoxDecoration(
                                        color: isLive
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius:
                                        BorderRadius
                                            .circular(5),
                                        border: Border.all(
                                            color: isLive
                                                ? Colors
                                                .green
                                                : Colors.red),
                                      ),
                                      child: Text(
                                          isLive
                                              ? 'Live'
                                              : 'Expair'),
                                    ),

                                    const SizedBox(width: 10),

                                    Container(
                                      width: 70,
                                      height: 40,
                                      decoration:
                                      const BoxDecoration(
                                          color:
                                          Colors.blue,
                                          borderRadius:
                                          BorderRadius
                                              .all(Radius.circular(10))),
                                      child: Center(
                                        child: Text(
                                          isLive
                                              ? 'Add Bid'
                                              : 'Bid offer',
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      '\$${data.currentBid ?? 0}',
                                      style:
                                      const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight
                                              .bold),
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: const [
                                    Text('heigest bid'),
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
              });
            },
          ),
        );
      }),
    );
  }
}