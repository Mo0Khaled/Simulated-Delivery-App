import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';

class PlaceDirectionModel extends PlaceDirectionEntity {
  const PlaceDirectionModel({
    required super.bounds,
    required super.polylinePoints,
    required super.totalDistance,
    required super.totalDuration,
  });

  factory PlaceDirectionModel.fromJson(Map<String, dynamic> json) {
    final data =
        Map<String, dynamic>.from(json['routes'][0] as Map<String, dynamic>);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'] as double, northeast['lng'] as double),
      southwest: LatLng(southwest['lat'] as double, southwest['lng'] as double),
    );

    late String distance;
    late String duration;

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'] as String;
      duration = leg['duration']['text'] as String;
    }

    return PlaceDirectionModel(
      bounds: bounds,
      polylinePoints: PolylinePoints()
          .decodePolyline(data['overview_polyline']['points'] as String),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
