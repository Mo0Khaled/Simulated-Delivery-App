import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simulated_delivery_app/features/order_tracking/order_tracking_di.dart';

class InjectionContainer {
  static GetIt locator = GetIt.instance;

  InjectionContainer._();
}

Future<void> setupLocator() async {
  final sl = InjectionContainer.locator;
  await OrderTrackingDi().init();
  sl.registerLazySingleton<Dio>(
    () => Dio(),
  );
}
