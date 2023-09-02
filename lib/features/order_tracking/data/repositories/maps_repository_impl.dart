import 'package:dartz/dartz.dart';
import 'package:simulated_delivery_app/core/exceptions/failure.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/data_sources/maps_remote_data_source.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/repositories/maps_repository.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/use_cases/get_direction_use_case.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource remoteDataSource;

  MapsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PlaceDirectionEntity>> getDirection(
      {required GetDirectionParams params}) async{
    try {
      final direction = await remoteDataSource.getDirection(params: params);
      return Right(direction);
    }catch(e) {
      return const Left(ServerFailure());
    }
  }
}
