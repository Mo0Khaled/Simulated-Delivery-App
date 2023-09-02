import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable {
  final bool isNearPickupPoint;
  final bool isNearDeliveryPoint;
  final bool isArrivedToPickupPoint;
  final bool isArrivedToDeliveryPoint;

  const OrderStatus({
    this.isNearPickupPoint = false,
    this.isNearDeliveryPoint = false,
    this.isArrivedToPickupPoint = false,
    this.isArrivedToDeliveryPoint = false,
  });

  OrderStatus copyWith({
    bool? isNearPickupPoint,
    bool? isNearDeliveryPoint,
    bool? isArrivedToPickupPoint,
    bool? isArrivedToDeliveryPoint,
  }) {
    return OrderStatus(
      isNearPickupPoint: isNearPickupPoint ?? this.isNearPickupPoint,
      isNearDeliveryPoint: isNearDeliveryPoint ?? this.isNearDeliveryPoint,
      isArrivedToPickupPoint:
          isArrivedToPickupPoint ?? this.isArrivedToPickupPoint,
      isArrivedToDeliveryPoint:
          isArrivedToDeliveryPoint ?? this.isArrivedToDeliveryPoint,
    );
  }

  @override
  List<Object?> get props => [
        isNearPickupPoint,
        isNearDeliveryPoint,
        isArrivedToPickupPoint,
        isArrivedToDeliveryPoint,
      ];
}
