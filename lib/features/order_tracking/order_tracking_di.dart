import 'package:simulated_delivery_app/features/order_tracking/data/data_sources/maps_remote_data_source.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/data_sources/maps_remote_data_source_impl.dart';
import 'package:simulated_delivery_app/features/order_tracking/data/repositories/maps_repository_impl.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/repositories/maps_repository.dart';
import 'package:simulated_delivery_app/features/order_tracking/domain/use_cases/get_direction_use_case.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/logic/map/map_cubit.dart';
import 'package:simulated_delivery_app/injection_container.dart';

class OrderTrackingDi {
  Future<void> init() async {
    // Register services here
    final sl = InjectionContainer.locator;
    sl.registerFactory(
      () => MapCubit(
        getDirectionUseCase: sl(),
      ),
    );

    // use cases

    sl.registerLazySingleton(() => GetDirectionUseCase(sl()));

    // repositories
    sl.registerLazySingleton<MapsRepository>(() => MapsRepositoryImpl(sl()));

    // data sources

    sl.registerLazySingleton<MapsRemoteDataSource>(
      () => MapsRemoteDataSourceImpl(
        dio: sl(),
      ),
    );
  }
}
