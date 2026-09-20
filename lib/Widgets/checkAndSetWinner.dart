// import 'package:bidding_user/Models/item_model.dart';
// import 'package:bidding_user/utils/isAuctionLive.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> checkAndSetWinner(ItemModel item)async{
//       if(item.winnerUserId != null) return;
//       if(!isAuctionLive(item)){
//         await FirebaseFirestore.instance.collection('itemModel').doc(item.itemId).update(
//       {
//       'winnerUserId': item.currentBidUserId,
//       'winnerBidAmount': item.currentBid,
//       'auctionEndedAt': DateTime.now(),
//       'isActive': false,
//            }
//         );
//       }
//     }

    