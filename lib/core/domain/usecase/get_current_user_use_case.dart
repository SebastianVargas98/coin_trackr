import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/domain/repositories/user_repository.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  final UserRepository userRepository;
  const GetCurrentUserUseCase({required this.userRepository});

  @override
  Either<Failure, User> call(NoParams params) {
    return userRepository.getCurrentUser();
  }
}
