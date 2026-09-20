import 'package:bidding_user/Models/item_model.dart';

bool isAuctionLive(ItemModel item) {
  // 1️⃣ Admin switch OFF
  if (item.isActive != true) return false;

  // 2️⃣ Time missing
  if (item.bidEndTime == null) return false;

  // 3️⃣ Time expired
  if (DateTime.now().isAfter(item.bidEndTime!)) return false;

  // 4️⃣ Everything OK
  return true;
}
