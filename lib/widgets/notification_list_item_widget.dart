import 'package:flutter/material.dart';
import 'package:notificator/constants/constants.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import 'round_icon_button_widget.dart';

class NotificationListItemWidget extends StatelessWidget {
  final String id;
  final String? messageTitle;
  final String? time;
  final String? group;
  final String? readStatus;
  final VoidCallback? onPressed;

  const NotificationListItemWidget({
    super.key,
    required this.id,
    this.onPressed,
    this.messageTitle,
    this.time,
    this.readStatus,
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
                    Row(
                      children: [
                        Text(
                          time ?? 'few time ago',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.deepPurple,
                            fontFamily: 'BaiJamjuree',
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(width: width - 160),
                        readStatus == Constants.kStatusUnread
                            ? Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.orange,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.lightOrange.withOpacity(0.1),
                                      AppColors.orange,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2.5,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
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
