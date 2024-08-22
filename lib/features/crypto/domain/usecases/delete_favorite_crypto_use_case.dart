import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteFavoriteCryptoUseCase
    implements UseCaseAsync<bool, DeleteFavoriteCryptoParams> {
  final CryptoRepository cryptoRepository;
  const DeleteFavoriteCryptoUseCase({required this.cryptoRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteFavoriteCryptoParams params) async {
    return await cryptoRepository.deleteFavoriteCrypto(
      params.userId,
      params.cryptoId,
    );
  }
}

class DeleteFavoriteCryptoParams {
  final String userId;
  final String cryptoId;

  DeleteFavoriteCryptoParams({
    required this.userId,
    required this.cryptoId,
  });
}
