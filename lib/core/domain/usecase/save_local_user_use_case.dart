import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/domain/repositories/user_repository.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

class SaveLocalUserUseCase implements UseCase<void, User> {
  final UserRepository userRepository;
  const SaveLocalUserUseCase({required this.userRepository});

  @override
  Either<Failure, User> call(User user) {
    userRepository.saveCurrentUser(user: user);
    return right(user);
  }
}
