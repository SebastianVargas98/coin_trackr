import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:coin_trackr/features/crypto/domain/usecases/get_crypto_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_failures.dart';
import 'get_crypto__list_use_case_test.mocks.dart';

@GenerateMocks([CryptoRepository])
Future<void> main() async {
  late GetCryptoListUseCase useCase;
  late MockCryptoRepository mockCryptoRepository;

  setUp(() {
    mockCryptoRepository = MockCryptoRepository();
    useCase = GetCryptoListUseCase(cryptoRepository: mockCryptoRepository);
  });

  final TestFailureDefault failure = TestFailureDefault();

  final List<Crypto> cryptosList = [
    Crypto(
      id: "id",
      symbol: "symbol",
      name: "name",
      image: "image",
      price: 500.0,
    ),
  ];

  provideDummy<Either<Failure, List<Crypto>>>(Right(cryptosList));

  test('should return cryptos list from repository', () async {
    // Arrange
    when(mockCryptoRepository.getCryptoList())
        .thenAnswer((_) async => Right(cryptosList));

    // Act
    final result = await useCase.call(NoParams());

    // Assert
    expect(result, Right(cryptosList));
    verify(mockCryptoRepository.getCryptoList());
    verifyNoMoreInteractions(mockCryptoRepository);
  });

  test('should Failure in getting cryptos list', () async {
    // Arrange
    when(mockCryptoRepository.getCryptoList())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase.call(NoParams());

    // Assert
    expect(result, Left(failure));
    verify(mockCryptoRepository.getCryptoList());
    verifyNoMoreInteractions(mockCryptoRepository);
  });
}
