import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/logic/map/map_cubit.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/pages/order_tracking_page.dart';
import 'package:simulated_delivery_app/injection_container.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InjectionContainer.locator<MapCubit>()..getDirections(),
        ),
      ],
      child: MaterialApp(
        title: 'Simulated Delivery app',
        theme: AppTheme.theme,
        home: const OrderTrackingPage(),
      ),
    );
  }
}
