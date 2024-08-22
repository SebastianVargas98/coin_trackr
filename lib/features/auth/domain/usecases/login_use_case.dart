import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase implements UseCaseAsync<User, LoginParams> {
  final AuthRepository authRepository;
  const LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.logIn(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
