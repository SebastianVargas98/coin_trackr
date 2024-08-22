import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/set_favorite_crypto_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'set_favorite_crypto_use_case_test.mocks.dart';

@GenerateMocks([CryptoRepository])
Future<void> main() async {
  late SetFavoriteCryptoUseCase useCase;
  late MockCryptoRepository mockCryptoRepository;

  setUp(() {
    mockCryptoRepository = MockCryptoRepository();
    useCase = SetFavoriteCryptoUseCase(cryptoRepository: mockCryptoRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  const String userId = "id";
  const String cryptoId = "bitcoin";

  provideDummy<Either<Failure, bool>>(const Right(true));

  SetFavoriteCryptoParams params = SetFavoriteCryptoParams(
    cryptoId: cryptoId,
    userId: userId,
  );

  test('should return true when crypto is added in favorites', () async {
    // Arrange
    when(mockCryptoRepository.setCryptoAsFavorite(
      params.userId,
      params.cryptoId,
    )).thenAnswer((_) async => const Right(true));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, const Right(true));
    verify(mockCryptoRepository.setCryptoAsFavorite(
      params.userId,
      params.cryptoId,
    ));
    verifyNoMoreInteractions(mockCryptoRepository);
  });

  test('should Failure in setting crypto as favorite', () async {
    // Arrange
    when(mockCryptoRepository.setCryptoAsFavorite(
      params.userId,
      params.cryptoId,
    )).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(params);

    // Assert
    expect(result, Left(failure));
    verify(
      mockCryptoRepository.setCryptoAsFavorite(
        params.userId,
        params.cryptoId,
      ),
    );
    verifyNoMoreInteractions(mockCryptoRepository);
  });
}
