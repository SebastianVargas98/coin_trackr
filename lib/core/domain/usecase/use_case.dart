import 'package:coin_trackr/core/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCaseAsync<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

abstract interface class UseCase<SuccessType, Params> {
  Either<Failure, SuccessType> call(Params params);
}

class NoParams {}
