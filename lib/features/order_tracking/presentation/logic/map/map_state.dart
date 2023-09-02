part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class DirectionsGotten extends MapState {}

class DriverMoving extends MapState {
  final double distance;
  final Areas area;

  DriverMoving({
    required this.distance,
    required this.area,
  });
}
class Delivered extends MapState {}
