import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

class WhiteButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const WhiteButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
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
