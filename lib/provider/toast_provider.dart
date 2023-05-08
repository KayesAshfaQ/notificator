import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../widgets/toast_widget.dart';

class ToastProvider with ChangeNotifier {
  final FToast _fToast = FToast(); // initialize instance of FToast
  late BuildContext _context; // save the current build context

  void initialize(BuildContext context) {
    _context = context;
    _fToast.init(_context);
  }

  /// show toast using FToast
  void showSuccessToast(String msg) {
    _fToast.showToast(
      child: ToastWidget(
        message: msg,
        iconData: Icons.check,
        backgroundColor: Colors.green,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void showErrorToast(String msg) {
    _fToast.showToast(
      child: ToastWidget(
        message: msg,
        iconData: Icons.highlight_remove,
        backgroundColor: Colors.red,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void showWarnToast(String msg) {
    _fToast.showToast(
      child: ToastWidget(
        message: msg,
        iconData: Icons.warning_amber,
        backgroundColor: Colors.yellow,
        color: Colors.grey[700],
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
