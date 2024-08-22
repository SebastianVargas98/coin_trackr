import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String userName,
    required DateTime birthDate,
  });
}
