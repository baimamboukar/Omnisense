import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omnisense/src/features/auth/auth.dart';

class FirestoreAuthServices {
  Future<bool> saveUserDataToFirestore(OmnisenseUser user) async {
    try {
      final DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.id);
      await userRef.set(user.toMap());
      return true;
    } catch (err) {
      rethrow;
    }
  }

  Future<OmnisenseUser> getUserDataFromFirestore(String userId) async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null) {
          return OmnisenseUser.fromMap(userData);
        } else {
          throw Exception('The user has no data');
        }
      } else {
        throw Exception('The user is not found');
      }
    } catch (err) {
      rethrow;
    }
  }
}
