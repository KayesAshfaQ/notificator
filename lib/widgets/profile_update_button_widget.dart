import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../util/utils.dart';

class ProfileUpdateButtonWidget extends StatelessWidget {

  final VoidCallback? onPress;

  const ProfileUpdateButtonWidget({
    super.key, this.onPress,
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
          SvgPicture.asset(
            Assets.svgIcSvgproEdit,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'Update',
            style: Utils.myTxtStyleBodySmall,
          ),
        ],
      ),
    );
  }
}
