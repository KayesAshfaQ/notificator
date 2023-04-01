import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const OutlinedButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.deepPurple, width: 0.7),
        foregroundColor: AppColors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.black87,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.deepPurple,
              fontFamily: 'BaiJamjuree',
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
