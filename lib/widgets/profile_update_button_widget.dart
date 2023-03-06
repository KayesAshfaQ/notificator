import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../util/utils.dart';

class ProfileUpdateButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData? icon;
  final String? iconPath;
  final String title;

  const ProfileUpdateButtonWidget({
    super.key,
    this.onPress,
    this.icon,
    required this.title,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(
          AppColors.orange.withOpacity(0.20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null
              ? SvgPicture.asset(
                  iconPath ?? Assets.svgIcEdit, // as place holder
                  height: 24,
                  width: 24,
                )
              : Icon(
                  icon,
                  color: AppColors.orange,
                  size: 24,
                ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Utils.myTxtStyleBodySmall,
          ),
        ],
      ),
    );
  }
}
