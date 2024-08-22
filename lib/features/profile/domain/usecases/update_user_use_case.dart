import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUserUseCase implements UseCaseAsync<bool, UpdateUserParams> {
  final ProfileRepository profileRepository;
  const UpdateUserUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateUserParams params) async {
    return await profileRepository.updateUser(
      userId: params.userId,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    );
  }
}

class UpdateUserParams {
  final String userId;
  final String name;
  final String lastName;
  final String userName;
  final DateTime birthDate;

  UpdateUserParams({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.userName,
    required this.birthDate,
  });
}
