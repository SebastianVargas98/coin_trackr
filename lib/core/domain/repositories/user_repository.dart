import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Either<Failure, User> getCurrentUser();
  void saveCurrentUser({required User user});
}
