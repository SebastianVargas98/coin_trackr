import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/profile/domain/repositories/profile_repository.dart';
import 'package:coin_trackr/features/profile/domain/usecases/update_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'update_user_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
Future<void> main() async {
  late UpdateUserUseCase useCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = UpdateUserUseCase(profileRepository: mockProfileRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  UpdateUserParams params = UpdateUserParams(
    userId: "userId",
    name: "name",
    lastName: "lastName",
    userName: "userName",
    birthDate: DateTime.now(),
  );

  provideDummy<Either<Failure, bool>>(const Right(true));

  test('should return true when user is updated', () async {
    // Arrange
    when(mockProfileRepository.updateUser(
      userId: params.userId,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    )).thenAnswer((_) async => const Right(true));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, const Right(true));
    verify(mockProfileRepository.updateUser(
      userId: params.userId,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    ));
    verifyNoMoreInteractions(mockProfileRepository);
  });

  test('should Failure when password is not updated', () async {
    // Arrange
    when(mockProfileRepository.updateUser(
      userId: params.userId,
      name: params.name,
      lastName: params.lastName,
      userName: params.userName,
      birthDate: params.birthDate,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, Left(failure));
    verify(
      mockProfileRepository.updateUser(
        userId: params.userId,
        name: params.name,
        lastName: params.lastName,
        userName: params.userName,
        birthDate: params.birthDate,
      ),
    );
    verifyNoMoreInteractions(mockProfileRepository);
  });
}
