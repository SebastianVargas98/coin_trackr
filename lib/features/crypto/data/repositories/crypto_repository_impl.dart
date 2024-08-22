import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:coin_trackr/core/common/error/exceptions.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/data/datasources/crypto_remote_datasource.dart';
import 'package:coin_trackr/features/crypto/data/datasources/firestore_crypto_data_source.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:fpdart/fpdart.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource cryptoRemoteDataSource;
  final FirestoreCryptoDataSource firestoreCryptoDataSource;

  CryptoRepositoryImpl({
    required this.cryptoRemoteDataSource,
    required this.firestoreCryptoDataSource,
  });

  @override
  Future<Either<Failure, List<Crypto>>> getCryptoList() async {
    try {
      final remoteCryptoList = await cryptoRemoteDataSource.getCryptoList();
      return Right(remoteCryptoList);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavoriteCrypto(
    String userId,
    String cryptoId,
  ) async {
    try {
      await firestoreCryptoDataSource.deleteFavoriteCrypto(userId, cryptoId);
      return const Right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserFavoritesCryptos(
    String userId,
  ) async {
    try {
      final favoriteCryptos =
          await firestoreCryptoDataSource.getUserFavoritesCryptos(userId);
      return Right(favoriteCryptos);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> setCryptoAsFavorite(
    String userId,
    String cryptoId,
  ) async {
    try {
      await firestoreCryptoDataSource.setCryptoAsFavorite(userId, cryptoId);
      return const Right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
