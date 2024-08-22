import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdatePasswordUseCase implements UseCaseAsync<bool, String> {
  final ProfileRepository profileRepository;
  const UpdatePasswordUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, bool>> call(String newPassword) async {
    return await profileRepository.updatePassword(
      newPassword: newPassword,
    );
  }
}
