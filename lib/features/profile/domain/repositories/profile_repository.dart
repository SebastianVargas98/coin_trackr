import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, bool>> updatePassword({
    required String newPassword,
  });

  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String name,
    required String lastName,
    required String userName,
    required DateTime birthDate,
  });
}
