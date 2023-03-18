import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import 'round_icon_button_widget.dart';

class NotificationListItemWidget extends StatelessWidget {
  final String? messageTitle;
  final String? time;
  final String? group;
  final VoidCallback? onPressed;

  const NotificationListItemWidget({
    super.key,
    this.onPressed,
    this.messageTitle,
    this.time,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.deepPurple,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            //margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: const Color(0x4DEFDEFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.asset(
                    Assets.imgBellImage,
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time ?? '7 days ago',
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: width - 96,
                      child: Text(
                        messageTitle ?? '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.deepPurple,
                          //fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'Sent To : ',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          //fontFamily: 'BaiJamjuree',
                        ),
                        children: [
                          TextSpan(
                            text: group ?? '_ _ _ _ _ _',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.orange,
                              fontWeight: FontWeight.normal,
                              //fontFamily: 'BaiJamjuree',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
