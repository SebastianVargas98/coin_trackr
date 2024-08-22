import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class CryptoRepository {
  Future<Either<Failure, List<Crypto>>> getCryptoList();

  Future<Either<Failure, bool>> setCryptoAsFavorite(
    String userId,
    String cryptoId,
  );

  Future<Either<Failure, List<String>>> getUserFavoritesCryptos(String userId);

  Future<Either<Failure, bool>> deleteFavoriteCrypto(
    String userId,
    String cryptoId,
  );
}
