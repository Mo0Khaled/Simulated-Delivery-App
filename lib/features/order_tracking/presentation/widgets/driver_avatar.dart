import 'package:flutter/material.dart';

class DriverAvatar extends StatelessWidget {
  const DriverAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 0.1,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: const FlutterLogo(
            size: 70,
          ),
        ),
      ),
    );
  }
}
