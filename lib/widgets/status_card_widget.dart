import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({
    super.key,
    required this.alignment,
    this.padding,
    required this.title,
    this.data = '0',
    this.icon,
  });

  final String title;
  final String data;
  final IconData? icon;
  final MainAxisAlignment alignment;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.purple_100,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.deepPurple.withOpacity(0.7),
              size: 24,
            ),
            SizedBox(width: padding ?? 4),
            Text(
              data,
              style: Utils.myTxtStyleTitleLarge.copyWith(
                color: Colors.orange,
                fontSize: 24,
              ),
            ),
            SizedBox(width: padding ?? 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Utils.myTxtStyleTitleExtraSmall,
                ),
                Text(
                  'You\'ve created Created',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Utils.myTxtStyleBodyExtraSmall.copyWith(fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
