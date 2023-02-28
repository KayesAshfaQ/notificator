import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import 'round_icon_button_widget.dart';

class NotificationListItemWidget extends StatelessWidget {

  final VoidCallback? onPressed;

  const NotificationListItemWidget({
    super.key, this.onPressed,
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
                    const Text(
                      '7 days ago',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                        fontStyle: FontStyle.normal,
                        //overflow: TextOverflow.visible,

                        //fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: width - 96,
                      child: const Text(
                        'We have meeting today with US clients and they are very excited about our product.',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.deepPurple,
                          //fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: const TextSpan(
                        text: 'Sent To : ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          //fontFamily: 'BaiJamjuree',
                        ),
                        children: [
                          TextSpan(
                            text: 'Designer, Developer, Tester',
                            style: TextStyle(
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
