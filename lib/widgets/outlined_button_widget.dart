import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String label;
  final IconData? icon;

  const OutlinedButtonWidget({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.orange,
        padding: EdgeInsets.symmetric(horizontal: 8),
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
