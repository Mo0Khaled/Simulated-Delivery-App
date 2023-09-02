import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension Toastt on BuildContext {
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
