import 'package:flutter_test/flutter_test.dart';
import 'package:bidding_user/Models/user_model.dart';

void main() {
  test('reproduce TypeError: null: type Null is not a subtype of type bool', () {
    final Map<String, dynamic> firestoreUserData = {
      'uid': 'test_uid_123',
      'name': 'Dealer User',
      'email': 'dealer@example.com',
      'isVerified': false,
      'compnyName': 'ABC Motors',
      'phoneNum': 1234567890,
      // Note: isRole is null or missing, as created by RegistereScreen or existing in Firestore
      'isRole': null,
    };

    final user = UserModel.fromJson(firestoreUserData);
    expect(user.uid, 'test_uid_123');
  });
}
