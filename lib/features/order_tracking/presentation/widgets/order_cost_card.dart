import 'package:flutter/material.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';

class OrderCostCard extends StatelessWidget {
  const OrderCostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Total",
            style: TextStyle(
              color: AppTheme.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
           const Padding(
             padding: EdgeInsets.symmetric(horizontal: 25),
             child: Text(
                "\$30.00",
                style: TextStyle(
                  color: AppTheme.accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
           ),
            const SizedBox(width: 80,),
            Expanded(
              child: Container(
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Submit",
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 50,),
                    Icon(Icons.arrow_forward,color: Colors.black,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
