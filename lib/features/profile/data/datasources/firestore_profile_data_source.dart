import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/core/data/models/user_model.dart';

abstract class FirestoreProfileDataSource {
  Future<bool> updateUser({
    required String userId,
    required UserModel userModel,
  });
}

class FirestoreProfileDataSourceImpl implements FirestoreProfileDataSource {
  final FirebaseFirestore firestore;

  FirestoreProfileDataSourceImpl({required this.firestore});

  @override
  Future<bool> updateUser({
    required String userId,
    required UserModel userModel,
  }) async {
    try {
      Map<String, dynamic> userData = {
        'userName': userModel.userName,
        'name': userModel.name,
        'lastName': userModel.lastName,
        'birthDate': Timestamp.fromDate(userModel.birthDate),
      };
      DocumentReference userDoc = firestore.collection('users').doc(userId);
      await userDoc.update(userData);
      return true;
    } catch (e) {
      throw const ServerException('Failed to create user in Firestore');
    }
  }
}
