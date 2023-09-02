import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulated_delivery_app/core/exceptions/failure.dart';
import 'package:simulated_delivery_app/core/usecases/use_case.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/repositories/maps_repository.dart';

class GetDirectionUseCase
    extends UseCase<PlaceDirectionEntity, GetDirectionParams> {
  final MapsRepository repository;

  GetDirectionUseCase(this.repository);

  @override
  Future<Either<Failure, PlaceDirectionEntity>> call(
      GetDirectionParams params) {
    return repository.getDirection(params: params);
  }
}

class GetDirectionParams extends Equatable {
  final LatLng origin;
  final LatLng destination;

  const GetDirectionParams({
    required this.origin,
    required this.destination,
  });

  @override
  List<Object?> get props => [
        origin,
        destination,
      ];
}
