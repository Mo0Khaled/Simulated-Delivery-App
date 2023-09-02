import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulated_delivery_app/core/extensions/bottom_sheet.dart';
import 'package:simulated_delivery_app/core/extensions/toast.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/enums/areas.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/logic/map/map_cubit.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/driver_details_sheet.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/order_summary_sheet.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int _steps = 0;

  @override
  Widget build(BuildContext context) {
    final mapCubit = BlocProvider.of<MapCubit>(context);
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is DriverMoving) {
          final isPickUpArea = state.area == Areas.pickup;

          if (state.distance <= 5000 &&
              (!mapCubit.orderStatus.isNearPickupPoint && isPickUpArea ||
                  !isPickUpArea && !mapCubit.orderStatus.isNearDeliveryPoint)) {
            setState(() {
              _steps++;
            });
            mapCubit.orderStatus = mapCubit.orderStatus.copyWith(
              isNearPickupPoint: isPickUpArea,
              isNearDeliveryPoint: !isPickUpArea,
            );
            context.showToast(
              "Driver is 5 km away from the ${isPickUpArea ? "pickup" : "delivery"} point",
            );
          }
          if (state.distance <= 100 &&
              (!mapCubit.orderStatus.isArrivedToPickupPoint && isPickUpArea ||
                  !isPickUpArea &&
                      !mapCubit.orderStatus.isArrivedToDeliveryPoint)) {
            setState(() {
              _steps++;
            });

            mapCubit.orderStatus = mapCubit.orderStatus.copyWith(
              isArrivedToPickupPoint: isPickUpArea,
              isArrivedToDeliveryPoint: !isPickUpArea,
            );
            context.showToast(
              "Driver is 100 m away from the ${isPickUpArea ? "pickup" : "delivery"} point",
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: true,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                markers: Set<Marker>.of(mapCubit.markers.values),
                initialCameraPosition: mapCubit.pickupPoint,
                polylines: mapCubit.path,
                onMapCreated: (GoogleMapController controller) {
                  mapCubit.controller.complete(controller);
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _steps < 4
                    ? DriverDetailsSheet(
                        steps: _steps,
                      )
                    : const OrderSummarySheet(),
              ),
            ],
          ),
          floatingActionButton: AbsorbPointer(
            absorbing: state is DriverMoving,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  mapCubit.simulateDriverMoving();
                  _steps = 0;
                });
              },
              child: const Icon(Icons.repeat),
            ),
          ),
        );
      },
    );
  }
}
