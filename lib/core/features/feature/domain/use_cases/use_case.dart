// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
import 'package:chegg/core/features/feature/data/models/params/params_model.dart';
import 'package:chegg/core/features/feature/domain/entities/entity.dart';
import 'package:chegg/core/features/feature/domain/entities/error_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<DataEntity extends Entity, Params extends ParamsModel> {
  Future<Either<ErrorEntity, DataEntity>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
