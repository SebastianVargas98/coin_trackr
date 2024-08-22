import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:fpdart/fpdart.dart';

class SetFavoriteCryptoUseCase
    implements UseCaseAsync<bool, SetFavoriteCryptoParams> {
  final CryptoRepository cryptoRepository;
  const SetFavoriteCryptoUseCase({required this.cryptoRepository});

  @override
  Future<Either<Failure, bool>> call(SetFavoriteCryptoParams params) async {
    return await cryptoRepository.setCryptoAsFavorite(
      params.userId,
      params.cryptoId,
    );
  }
}

class SetFavoriteCryptoParams {
  final String userId;
  final String cryptoId;

  SetFavoriteCryptoParams({
    required this.userId,
    required this.cryptoId,
  });
}
