import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/use_cases/get_direction_use_case.dart';

abstract class MapsRemoteDataSource {
  Future<PlaceDirectionEntity> getDirection( {required GetDirectionParams params});
}
