import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final bool switchValue;

  final Function(bool) onChanged;

  const SettingItemWidget({
    super.key,
    required this.title,
    required this.switchValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 4),
        SizedBox(
          width: width - 108,
          child: Text(
            title,
            style: Utils.myTxtStyleBodySmall,
          ),
        ),
        Switch(
          activeColor: AppColors.deepPurple,
          value: switchValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
