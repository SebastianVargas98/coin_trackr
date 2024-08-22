import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUseCase implements UseCaseAsync<User, RegisterParams> {
  final AuthRepository authRepository;
  const RegisterUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await authRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String userName;
  final DateTime birthDate;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.userName,
    required this.birthDate,
  });
}
