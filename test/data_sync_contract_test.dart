import 'package:flutter_test/flutter_test.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Models/item_model.dart';

void main() {
  group('Data Sync & Contract Alignment Tests', () {
    test('UserModel parses isBlocked and status safely with defaults', () {
      final user = UserModel.fromJson({
        'uid': 'test_uid_123',
        'name': 'Dealer Bob',
        'isVerified': true,
      });

      expect(user.uid, 'test_uid_123');
      expect(user.name, 'Dealer Bob');
      expect(user.isVerified, true);
      expect(user.isBlocked, false);
      expect(user.status, isNull);
    });

    test('UserModel parses blocked dealer status correctly', () {
      final user = UserModel.fromJson({
        'uid': 'blocked_uid',
        'name': 'Blocked Dealer',
        'isVerified': true,
        'isBlocked': true,
        'status': 'blocked',
      });

      expect(user.isBlocked, true);
      expect(user.status, 'blocked');
    });

    test('ItemModel parses ISO strings and null dates safely', () {
      final item = ItemModel.fromJson({
        'itemId': 'car_123',
        'title': 'Toyota Supra',
        'bidEndTime': '2026-12-31T23:59:59.000Z',
        'currentBid': 45000.0,
      });

      expect(item.itemId, 'car_123');
      expect(item.title, 'Toyota Supra');
      expect(item.bidEndTime, isNotNull);
      expect(item.currentBid, 45000.0);
    });

    test('ItemModel parses numbers given as Strings safely without TypeError', () {
      final item = ItemModel.fromJson({
        'itemId': 'car_456',
        'year': '2024',
        'sellerPrice': '50000',
        'minimumBid': '30000.50',
        'currentBid': '35000',
        'mileage': '12000',
        'keys': '2',
      });

      expect(item.year, 2024);
      expect(item.sellerPrice, 50000.0);
      expect(item.minimumBid, 30000.50);
      expect(item.currentBid, 35000.0);
      expect(item.mileage, 12000);
      expect(item.keys, 2);
    });

    test('ItemModel handles mock Timestamp objects via toDate safely', () {
      final mockTimestamp = _MockTimestamp(DateTime(2026, 11, 20, 10, 0));
      final item = ItemModel.fromJson({
        'itemId': 'car_ts',
        'bidEndTime': mockTimestamp,
        'createdAt': mockTimestamp,
        'auctionEndedAt': mockTimestamp,
      });

      expect(item.bidEndTime, DateTime(2026, 11, 20, 10, 0));
      expect(item.createdAt, DateTime(2026, 11, 20, 10, 0));
      expect(item.auctionEndedAt, DateTime(2026, 11, 20, 10, 0));
    });
  });
}

class _MockTimestamp {
  final DateTime _dateTime;
  _MockTimestamp(this._dateTime);
  DateTime toDate() => _dateTime;
}
