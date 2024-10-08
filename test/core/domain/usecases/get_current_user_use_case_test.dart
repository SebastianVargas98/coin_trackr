import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/domain/repositories/user_repository.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coin_trackr/core/domain/usecase/get_current_user_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_failures.dart';
import 'get_current_user_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
Future<void> main() async {
  late GetCurrentUserUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetCurrentUserUseCase(userRepository: mockUserRepository);
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

  test('should return current user from the repository', () {
    // Arrange
    when(mockUserRepository.getCurrentUser()).thenReturn(Right(user));

    // Act
    final result = useCase.call(NoParams());

    // Assert
    expect(result, Right(user));
    verify(mockUserRepository.getCurrentUser());
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return Failure when repository returns Failure', () {
    // Arrange
    when(mockUserRepository.getCurrentUser()).thenReturn(Left(failure));

    // Act
    final result = useCase.call(NoParams());

    // Assert
    expect(result, Left(failure));
    verify(mockUserRepository.getCurrentUser());
    verifyNoMoreInteractions(mockUserRepository);
  });
}
