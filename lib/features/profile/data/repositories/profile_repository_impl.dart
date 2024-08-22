import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/models/user_model.dart';
import 'package:coin_trackr/features/profile/data/datasources/firebase_profile_data_source.dart';
import 'package:coin_trackr/features/profile/data/datasources/firestore_profile_data_source.dart';
import 'package:coin_trackr/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseProfileDataSource firebaseDataSource;
  final FirestoreProfileDataSource firestoreDataSource;

  const ProfileRepositoryImpl({
    required this.firebaseDataSource,
    required this.firestoreDataSource,
  });

  @override
  Future<Either<Failure, bool>> updatePassword(
      {required String newPassword}) async {
    try {
      final success =
          await firebaseDataSource.updatePassword(newPassword: newPassword);
      return right(success);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String name,
    required String lastName,
    required String userName,
    required DateTime birthDate,
  }) async {
    try {
      final UserModel userModel = UserModel(
        id: userId,
        email: '',
        name: name,
        lastName: lastName,
        userName: userName,
        birthDate: birthDate,
      );
      final success = await firestoreDataSource.updateUser(
        userId: userId,
        userModel: userModel,
      );
      return right(success);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
