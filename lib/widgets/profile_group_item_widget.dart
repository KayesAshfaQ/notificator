import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class ProfileGroupItemWidget extends StatelessWidget {
  const ProfileGroupItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple_100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Developers',
        style: Utils.myTxtStyleBodySmall,
      ),
    );
  }
}
