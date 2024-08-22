import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/core/data/models/user_model.dart';

abstract class FirestoreUserDataSource {
  Future<void> createUserInFirestore(
    String userId,
    UserModel userModel,
  );

  Future<UserModel> getUserInFirestore(String userId);
}

class FirestoreUserDataSourceImpl implements FirestoreUserDataSource {
  final FirebaseFirestore firestore;

  FirestoreUserDataSourceImpl({required this.firestore});

  @override
  Future<void> createUserInFirestore(String userId, UserModel userModel) async {
    try {
      Map<String, dynamic> userData = {
        'uid': userId,
        'email': userModel.email,
        'userName': userModel.userName,
        'name': userModel.name,
        'lastName': userModel.lastName,
        'birthDate': Timestamp.fromDate(userModel.birthDate),
      };
      await firestore.collection('users').doc(userId).set(userData);
    } catch (e) {
      throw const ServerException('Failed to create user in Firestore');
    }
  }

  @override
  Future<UserModel> getUserInFirestore(String userId) async {
    DocumentReference userDocRef = firestore.collection('users').doc(userId);
    try {
      DocumentSnapshot documentSnapshot = await userDocRef.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        DateTime birthDate = (data['birthDate'] as Timestamp).toDate();
        return UserModel(
          id: data['uid'],
          email: data['email'],
          userName: data['userName'],
          name: data['name'],
          lastName: data['lastName'],
          birthDate: birthDate,
        );
      }
      throw const ServerException('Document does not exist');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
