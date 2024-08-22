import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/models/user_model.dart';
import 'package:coin_trackr/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:coin_trackr/features/auth/data/datasources/firestore_auth_data_source.dart';
import 'package:coin_trackr/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource authDataSource;
  final FirestoreUserDataSource userDataSource;

  const AuthRepositoryImpl({
    required this.authDataSource,
    required this.userDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authDataSource.login(
        email: email,
        password: password,
      );
      UserModel userModel = await userDataSource.getUserInFirestore(user.uid);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String userName,
    required DateTime birthDate,
  }) async {
    try {
      final user = await authDataSource.signUp(
        email: email,
        password: password,
      );
      final UserModel userModel = UserModel(
        id: user.uid,
        email: email,
        name: name,
        lastName: lastName,
        userName: userName,
        birthDate: birthDate,
      );
      await userDataSource.createUserInFirestore(user.uid, userModel);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
