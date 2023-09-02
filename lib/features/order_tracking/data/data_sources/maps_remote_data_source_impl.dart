import 'package:dio/dio.dart';
import 'package:simulated_delivery_app/core/constants/end_points.dart';
import 'package:simulated_delivery_app/core/exceptions/exceptions.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/data_sources/maps_remote_data_source.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/models/place_directions_model.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/use_cases/get_direction_use_case.dart';

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final Dio dio;

  MapsRemoteDataSourceImpl({required this.dio});

  @override
  Future<PlaceDirectionEntity> getDirection(
      {required GetDirectionParams params}) async {
    print("x");
    try {
      final Response response = await dio.get(
        EndPoints.directionsBaseUrl,
        queryParameters: {
          'origin': '${params.origin.latitude},${params.origin.longitude}',
          'destination':
              '${params.destination.latitude},${params.destination.longitude}',
          'key': EndPoints.googleAPIkey,
        },
      );
      if (response.statusCode == 200) {
        return PlaceDirectionModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException();
      }

    } catch (error) {
      print(error);
      throw ServerException();
    }
  }
}
