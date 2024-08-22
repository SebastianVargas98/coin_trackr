import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseAuthDataSource {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> signUp({
    required String email,
    required String password,
  });
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl({required this.firebaseAuth});

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw const ServerException('User is null!');
      }
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw const ServerException('User is null!');
      }
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
