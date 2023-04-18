import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class SeeAllButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;

  const SeeAllButtonWidget({
    super.key,
    this.onPress,
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
        children: const [
          Text(
            'See all',
            style: Utils.myTxtStyleBodyExtraSmall,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.arrow_right_alt_rounded,
            size: 16,
            color: AppColors.orange,
          )
        ],
      ),
    );
  }
}
