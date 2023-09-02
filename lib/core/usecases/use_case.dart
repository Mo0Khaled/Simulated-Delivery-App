import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:simulated_delivery_app/core/exceptions/failure.dart';
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}