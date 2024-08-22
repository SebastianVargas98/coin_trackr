import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetFavoritesCryptosUseCase implements UseCaseAsync<List<String>, String> {
  final CryptoRepository cryptoRepository;
  const GetFavoritesCryptosUseCase({required this.cryptoRepository});

  @override
  Future<Either<Failure, List<String>>> call(String userId) async {
    return await cryptoRepository.getUserFavoritesCryptos(userId);
  }
}
