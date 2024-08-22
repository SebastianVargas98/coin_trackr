import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/features/auth/domain/repositories/auth_repository.dart';
import 'package:coin_trackr/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
Future<void> main() async {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(authRepository: mockAuthRepository);
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

  test('should return current user when login from the repository', () async {
    const String email = 'email@email.com';
    const String password = 'password';

    // Arrange
    when(mockAuthRepository.logIn(
      email: email,
      password: password,
    )).thenAnswer((_) async => Right(user));

    // Act
    final result = await useCase.call(LoginParams(
      email: email,
      password: password,
    ));

    // Assert
    expect(result, Right(user));
    verify(mockAuthRepository.logIn(
      email: email,
      password: password,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should Failure in login', () async {
    const String email = 'email@email.com';
    const String password = 'password';

    // Arrange
    when(mockAuthRepository.logIn(
      email: email,
      password: password,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(LoginParams(
      email: email,
      password: password,
    ));

    // Assert
    expect(result, Left(failure));
    verify(mockAuthRepository.logIn(
      email: email,
      password: password,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
