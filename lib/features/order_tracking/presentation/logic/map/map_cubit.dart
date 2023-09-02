import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/enums/areas.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/order_status.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/entities/place_directions_entity.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/use_cases/get_direction_use_case.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetDirectionUseCase getDirectionUseCase;

  MapCubit({
    required this.getDirectionUseCase,
  }) : super(MapInitial());

  OrderStatus orderStatus = const OrderStatus();

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  Set<Polyline> path = {};
  final driverPosition = const LatLng(30.015912, 31.218560);
  final pickUpPosition = const LatLng(30.041427, 31.234820);
  final deliveryPosition = const LatLng(30.061502, 31.206366);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    const MarkerId('driver'): Marker(
      markerId: const MarkerId('driver'),
      position: const LatLng(30.015912, 31.218560),
      infoWindow: const InfoWindow(title: 'Driver'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ),
    const MarkerId('pickup'): Marker(
      markerId: const MarkerId('pickup'),
      position: const LatLng(30.041427, 31.234820),
      infoWindow: const InfoWindow(title: 'Pickup'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    const MarkerId('delivery'): Marker(
      markerId: const MarkerId('delivery'),
      position: const LatLng(30.061502, 31.206366),
      infoWindow: const InfoWindow(title: 'Delivery'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    ),
  };
  PlaceDirectionEntity? placeDirectionEntity;
  late List<LatLng> polylineCoordinates;
  final CameraPosition pickupPoint = const CameraPosition(
    target: LatLng(30.041427, 31.234820),
    zoom: 10.4746,
  );

  final CameraPosition deliveryPoint = const CameraPosition(
    target: LatLng(30.061502, 31.206366),
    zoom: 10.4746,
  );

  Future<void> getDirections() async {
    // get the position between driver and pickup first
    final firstDestination = await getDirectionUseCase(
      GetDirectionParams(
        origin: driverPosition,
        destination: pickUpPosition,
      ),
    );
    firstDestination.fold(
      (l) => null,
      (directions) {
        addPolyLine(
          polylineId: "firstDis",
          polylineCoordinates: directions.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        );
      },
    );

    // then get the position between pickup and drop-off
    final secondDestination = await getDirectionUseCase(
      GetDirectionParams(
        origin: pickUpPosition,
        destination: deliveryPosition,
      ),
    );
    secondDestination.fold(
      (l) => null,
      (directions) {
        addPolyLine(
          polylineId: "secDis",
          polylineCoordinates: directions.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        );
      },
    );
    emit(DirectionsGotten());
    simulateDriverMoving();
  }

  void addPolyLine({
    required String polylineId,
    required List<LatLng> polylineCoordinates,
  }) {
    path.add(
      Polyline(
        polylineId: PolylineId(polylineId),
        width: 2,
        points: polylineCoordinates,
        color: Colors.black,
      ),
    );
  }

  void animateCameraToDriverPos() async {
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: driverPosition,
        zoom: 12.0,
      ),
    ));
  }

  void simulateDriverMoving() async {
    animateCameraToDriverPos();
    final copiedPath = path;
    markers.remove("driver");
    for (int polylineIndex = 0;
        polylineIndex < copiedPath.length;
        polylineIndex++) {
      final polyline = copiedPath.elementAt(polylineIndex);
      for (int pointIndex = 0;
          pointIndex < polyline.points.length;
          pointIndex++) {
        await Future.delayed(const Duration(milliseconds: 500)).then(
          (value) {
            final point = polyline.points[pointIndex];
            final area = polylineIndex == 0 ? Areas.pickup : Areas.delivery;
            markers[const MarkerId("driver")] = Marker(
              markerId: const MarkerId('driver'),
              position: LatLng(point.latitude, point.longitude),
              infoWindow: const InfoWindow(title: 'Driver'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
            );
            final distance = getDistanceBetweenLocations(
              origin: point,
              destination:
                  (area == Areas.pickup) ? pickUpPosition : deliveryPosition,
            );
            emit(
              DriverMoving(
                distance: distance,
                area: area,
              ),
            );
          },
        );
      }
    }
    emit(
      Delivered(),
    );
  }

  double getDistanceBetweenLocations({
    required LatLng origin,
    required LatLng destination,
  }) {
    return Geolocator.distanceBetween(
      origin.latitude,
      origin.longitude,
      destination.latitude,
      destination.longitude,
    );
  }
}
