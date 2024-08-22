import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseProfileDataSource {
  Future<bool> updatePassword({
    required String newPassword,
  });
}

class FirebaseProfileDataSourceImpl implements FirebaseProfileDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseProfileDataSourceImpl({required this.firebaseAuth});

  @override
  Future<bool> updatePassword({required String newPassword}) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
