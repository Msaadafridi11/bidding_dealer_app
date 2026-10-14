import 'package:flutter_test/flutter_test.dart';
import 'package:bidding_user/Models/user_model.dart';

void main() {
  group('Auth & UserModel Login Flow Tests', () {
    test('Existing account without isRole or with null isRole parses safely without crashing', () {
      final existingAccountData = {
        'uid': 'existing_user_001',
        'name': 'Existing Dealer',
        'email': 'existing@dealer.com',
        'isVerified': true,
        'compnyName': 'City Auto',
        'phoneNum': 1234567890,
        // isRole is null or absent in existing Firestore documents
        'isRole': null,
      };

      final user = UserModel.fromJson(existingAccountData);
      expect(user.uid, 'existing_user_001');
      expect(user.name, 'Existing Dealer');
      expect(user.isVerified, true);
      expect(user.isRole, false);
      expect(user.phoneNum, 1234567890);
    });

    test('Newly registered account parses safely with default false for isVerified and isRole', () {
      final newlyRegisteredData = {
        'uid': 'new_user_999',
        'name': 'New Dealer',
        'email': 'new@dealer.com',
        'isVerified': false,
        'compnyName': 'New Motors',
        'phoneNum': 987654321,
        'isRole': false,
      };

      final user = UserModel.fromJson(newlyRegisteredData);
      expect(user.uid, 'new_user_999');
      expect(user.isVerified, false);
      expect(user.isRole, false);
    });

    test('Missing profile fields or completely empty document parses safely without crashing', () {
      final emptyDoc = <String, dynamic>{};
      final user = UserModel.fromJson(emptyDoc);
      expect(user.uid, isNull);
      expect(user.isVerified, false);
      expect(user.isRole, false);
      expect(user.phoneNum, isNull);
    });

    test('Phone number as String is handled safely', () {
      final dataWithStringPhone = {
        'uid': 'user_str_phone',
        'name': 'String Phone User',
        'phoneNum': '03001234567',
      };
      final user = UserModel.fromJson(dataWithStringPhone);
      expect(user.phoneNum, 3001234567);
    });

    test('UserModel.fromJson handles null isRole and isVerified safely', () {
      final data = <String, dynamic>{
        'uid': 'gen_user',
        'isRole': null,
        'isVerified': null,
      };
      final user = UserModel.fromJson(data);
      expect(user.isRole, false);
      expect(user.isVerified, false);
    });
  });
}
