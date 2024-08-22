import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/features/auth/domain/repositories/auth_repository.dart';
import 'package:coin_trackr/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
Future<void> main() async {
  late RegisterUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = RegisterUseCase(authRepository: mockAuthRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  final User user = User(
    id: "id",
    email: "email@email.com",
    userName: "userName",
    name: "name",
    lastName: "lastName",
    birthDate: DateTime(2000, 01, 01),
  );

  provideDummy<Either<Failure, User>>(Right(user));

  test('should return current user when register from the repository',
      () async {
    RegisterParams params = RegisterParams(
      email: "email",
      password: "password",
      name: "name",
      lastName: "lastName",
      userName: "userName",
      birthDate: DateTime.now(),
    );
    // Arrange
    when(mockAuthRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    )).thenAnswer((_) async => Right(user));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, Right(user));
    verify(mockAuthRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should Failure in register', () async {
    RegisterParams params = RegisterParams(
      email: "email",
      password: "password",
      name: "name",
      lastName: "lastName",
      userName: "userName",
      birthDate: DateTime.now(),
    );

    // Arrange
    when(mockAuthRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, Left(failure));
    verify(mockAuthRepository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
