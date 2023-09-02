import 'package:flutter/material.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/custom_row_title.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/driver_avatar.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/order_cost_card.dart';

class OrderSummarySheet extends StatelessWidget {
  const OrderSummarySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Mo Khaled",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // TODO: add stars to rate
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    CustomRowTitle(title: "Pickup time", subtitle: "10:00"),
                    SizedBox(
                      height: 10,
                    ),
                    CustomRowTitle(title: "Delivery time", subtitle: "10:30"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OrderCostCard(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        const DriverAvatar(),
      ],
    );
  }
}
