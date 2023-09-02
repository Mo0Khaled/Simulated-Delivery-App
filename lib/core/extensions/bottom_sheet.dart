import 'package:flutter/material.dart';
import 'package:simulated_delivery_app/core/theme/app_theme.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

var _isOpened = false;

extension BottomSheet on BuildContext {
  void bottomSheet() {
    showSlidingBottomSheet(
      this,
      builder: (context) {
        return SlidingSheetDialog(
          isDismissable: false,
          dismissOnBackdropTap: true,
          backdropColor: Colors.transparent,
          cornerRadius: 25,
          snapSpec: const SnapSpec(
            snappings: [0.5, 0.7, 1.0],
          ),
          builder: (context, state) {
            return Stack(
              clipBehavior: Clip.none,
              children: [

                Material(
                  color:  AppTheme.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
