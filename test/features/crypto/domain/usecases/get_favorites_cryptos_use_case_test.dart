import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/get_favorites_cryptos_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'get_favorites_cryptos_use_case_test.mocks.dart';

@GenerateMocks([CryptoRepository])
Future<void> main() async {
  late GetFavoritesCryptosUseCase useCase;
  late MockCryptoRepository mockCryptoRepository;

  setUp(() {
    mockCryptoRepository = MockCryptoRepository();
    useCase =
        GetFavoritesCryptosUseCase(cryptoRepository: mockCryptoRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  const String userId = "id";

  final List<String> cryptosList = [
    "bitcoin",
    "etherium",
  ];

  provideDummy<Either<Failure, List<String>>>(Right(cryptosList));

  test('should return favorites cryptos list from repository', () async {
    // Arrange
    when(mockCryptoRepository.getUserFavoritesCryptos(userId))
        .thenAnswer((_) async => Right(cryptosList));

    // Act
    final result = await useCase.call(userId);

    // Assert
    expect(result, Right(cryptosList));
    verify(mockCryptoRepository.getUserFavoritesCryptos(userId));
    verifyNoMoreInteractions(mockCryptoRepository);
  });

  test('should Failure in getting cryptos favorites list', () async {
    // Arrange
    when(mockCryptoRepository.getUserFavoritesCryptos(userId))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(userId);

    // Assert
    expect(result, Left(failure));
    verify(mockCryptoRepository.getUserFavoritesCryptos(userId));
    verifyNoMoreInteractions(mockCryptoRepository);
  });
}
