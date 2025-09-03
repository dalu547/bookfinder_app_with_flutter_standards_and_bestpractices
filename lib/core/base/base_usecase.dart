import 'package:dartz/dartz.dart';
import 'package:bookfinder/domain/core/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> execute(Input input);
}
