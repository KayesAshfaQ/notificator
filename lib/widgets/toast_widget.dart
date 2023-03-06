import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? color;

  const ToastWidget({
    super.key,
    required this.message,
    this.iconData,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: backgroundColor ?? Colors.grey[800],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: color ?? Colors.white,
          ),
          const SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: color ?? Colors.white),
          ),
        ],
      ),
    );
  }
}
