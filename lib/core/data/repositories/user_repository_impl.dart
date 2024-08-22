import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/data/datasources/user_local_data_source.dart';
import 'package:coin_trackr/core/domain/repositories/user_repository.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  const UserRepositoryImpl({
    required this.userLocalDataSource,
  });

  @override
  Either<Failure, User> getCurrentUser() {
    final user = userLocalDataSource.getCurrentUser();
    if (user != null) {
      return right(user);
    }
    return left(Failure('There is not current user'));
  }

  @override
  void saveCurrentUser({required User user}) {
    userLocalDataSource.saveCurrentUser(user: user);
  }
}
