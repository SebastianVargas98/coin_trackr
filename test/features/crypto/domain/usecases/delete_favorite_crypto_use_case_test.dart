import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/delete_favorite_crypto_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'delete_favorite_crypto_use_case_test.mocks.dart';

@GenerateMocks([CryptoRepository])
Future<void> main() async {
  late DeleteFavoriteCryptoUseCase useCase;
  late MockCryptoRepository mockCryptoRepository;

  setUp(() {
    mockCryptoRepository = MockCryptoRepository();
    useCase =
        DeleteFavoriteCryptoUseCase(cryptoRepository: mockCryptoRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  provideDummy<Either<Failure, bool>>(const Right(true));

  test('should return true when a favorite coin is deleted', () async {
    DeleteFavoriteCryptoParams params = DeleteFavoriteCryptoParams(
      userId: "id",
      cryptoId: "bitcoin",
    );
    // Arrange
    when(mockCryptoRepository.deleteFavoriteCrypto(
      params.userId,
      params.cryptoId,
    )).thenAnswer((_) async => const Right(true));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, const Right(true));
    verify(mockCryptoRepository.deleteFavoriteCrypto(
      params.userId,
      params.cryptoId,
    ));
    verifyNoMoreInteractions(mockCryptoRepository);
  });

  test('should Failure in register', () async {
    DeleteFavoriteCryptoParams params = DeleteFavoriteCryptoParams(
      userId: "id",
      cryptoId: "bitcoin",
    );

    // Arrange
    when(mockCryptoRepository.deleteFavoriteCrypto(
      params.userId,
      params.cryptoId,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, Left(failure));
    verify(mockCryptoRepository.deleteFavoriteCrypto(
      params.userId,
      params.cryptoId,
    ));
    verifyNoMoreInteractions(mockCryptoRepository);
  });
}
