import 'package:coin_trackr/core/data/entities/crypto.dart';
import 'package:coin_trackr/core/domain/usecase/use_case.dart';
import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:coin_trackr/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCryptoListUseCase implements UseCaseAsync<List<Crypto>, NoParams> {
  final CryptoRepository cryptoRepository;
  const GetCryptoListUseCase({required this.cryptoRepository});

  @override
  Future<Either<Failure, List<Crypto>>> call(NoParams params) async {
    return await cryptoRepository.getCryptoList();
  }
}
