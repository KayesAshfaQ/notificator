import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';

class ElevatedCreateButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;
  final Color? color;

  const ElevatedCreateButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    required this.icon,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepPurple,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color ?? AppColors.white,
            size: size ?? 24,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
              fontFamily: 'BaiJamjuree',
            ),
          ),
        ],
      ),
    );
  }
}
