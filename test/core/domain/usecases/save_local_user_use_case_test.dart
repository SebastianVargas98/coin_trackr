import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/user.dart';
import 'package:coin_trackr/core/domain/usecase/save_local_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coin_trackr/core/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_local_user_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late SaveLocalUserUseCase useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = SaveLocalUserUseCase(userRepository: mockUserRepository);
  });

  final User user = User(
    id: "id",
    email: "email@email.com",
    userName: "userName",
    name: "name",
    lastName: "lastName",
    birthDate: DateTime(2000, 01, 01),
  );

  provideDummy<Either<Failure, User>>(Right(user));

  test('should save current user into repository and return user', () {
    // Act
    final result = useCase.call(user);

    // Assert
    expect(result, Right(user));
    verify(mockUserRepository.saveCurrentUser(user: user));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
