import 'package:flutter/material.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';
import 'package:simulated_delivery_app/features/order_tracking/presentation/widgets/driver_avatar.dart';

class DriverDetailsSheet extends StatelessWidget {
  final int steps;

  const DriverDetailsSheet({super.key, required this.steps});

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
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Mo Khaled",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 200,
                child: Stepper(
                  margin: EdgeInsets.zero,
                  controlsBuilder: (ctx, c) {
                    return Container(
                      height: 0.0,
                      margin: EdgeInsets.zero,
                    );
                  },
                  stepIconBuilder: (index, stepState) {
                    return Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: stepState == StepState.complete
                            ? Colors.black
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                  steps: <Step>[
                    Step(
                      title: const Text('On The Way'),
                      content: Container(),
                      isActive: true,
                      state:
                          steps >= 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Near Pickup Point'),
                      content: Container(),
                      isActive: true,
                      state:
                          steps >= 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Picked up delivery'),
                      isActive: true,
                      content: Container(),
                      state:
                          steps >= 2 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Near Delivery Point'),
                      isActive: true,
                      content: Container(),
                      state:
                          steps >= 3 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered Package'),
                      isActive: true,
                      content: Container(),
                      state:
                          steps >= 4 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        const DriverAvatar(),
      ],
    );
  }
}
