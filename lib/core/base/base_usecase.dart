import 'package:dartz/dartz.dart';
import 'package:bookfinder/core/network/response_error.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<ResponseError, Output>> execute(Input input);
}
