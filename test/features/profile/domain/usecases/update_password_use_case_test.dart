import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/profile/domain/repositories/profile_repository.dart';
import 'package:coin_trackr/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'update_user_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
Future<void> main() async {
  late UpdatePasswordUseCase useCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = UpdatePasswordUseCase(profileRepository: mockProfileRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  const String newPassword = "password";

  provideDummy<Either<Failure, bool>>(const Right(true));

  test('should return true when password is updated', () async {
    // Arrange
    when(mockProfileRepository.updatePassword(
      newPassword: newPassword,
    )).thenAnswer((_) async => const Right(true));

    // Act
    final result = await useCase.call(newPassword);

    // Assert
    expect(result, const Right(true));
    verify(mockProfileRepository.updatePassword(
      newPassword: newPassword,
    ));
    verifyNoMoreInteractions(mockProfileRepository);
  });

  test('should Failure when password is not updated', () async {
    // Arrange
    when(mockProfileRepository.updatePassword(
      newPassword: newPassword,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(newPassword);

    // Assert
    expect(result, Left(failure));
    verify(
      mockProfileRepository.updatePassword(
        newPassword: newPassword,
      ),
    );
    verifyNoMoreInteractions(mockProfileRepository);
  });
}
