import 'package:flutter/material.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/pages/order_tracking_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulated Delivery app',
      theme: AppTheme.theme,
      home: const OrderTrackingPage(),
    );
  }
}
