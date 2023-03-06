import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

class WhiteButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  const WhiteButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.orange,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontFamily: 'BaiJamjuree',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
