import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

import '../generated/assets.dart';

class Utils {
  static const dummyText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tincidunt efficitur orci a rhoncus. https://stackoverflow.com/ Maecenas tempor ligula justo, non egestas odio imperdiet ac. Nam maximus nunc quis ante pellentesque aliquam. Proin vestibulum, nisi in tincidunt aliquet, justo mauris tempus tortor, at maximus turpis massa ac sem. Nam porttitor, nunc pharetra tempus vehicula, massa enim auctor lectus, volutpat posuere neque ante a sem. Donec suscipit mauris odio, non eleifend libero gravida a. https://www.google.com/ Vestibulum pharetra vestibulum nisl eu facilisis. Vestibulum sagittis lectus vitae porta tempus. Pellentesque vel semper lacus. Suspendisse et sollicitudin est. Aenean egestas felis a justo auctor sollicitudin. Sed cursus mattis massa. In hac habitasse platea dictumst. Integer porta sollicitudin laoreet. Morbi id ornare magna. Proin id risus ex. Ut quam nisl, ultrices ac ligula vel, dictum dictum sapien. Donec a sollicitudin mi. Ut id diam magna. Curabitur eget placerat quam. Aenean porta risus ut enim hendrerit dapibus. In luctus nibh vitae orci dictum, ut hendrerit risus scelerisque. Donec quis tortor ac lorem mattis dictum in ac mauris. Fusce laoreet ex nec est fringilla commodo. Praesent dapibus elementum elit, a aliquet sapien faucibus eu. Fusce gravida, ligula id bibendum eleifend, nisl leo auctor ex, vel eleifend elit ex vel dolor.';

  static const backGroundImage = AssetImage(Assets.imgBackground);

  static const myTxtStyleBodyLarge = TextStyle(
    fontSize: 24,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w500,
  );

  static const myTxtStyleBodyMedium = TextStyle(
    fontSize: 20,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w500,
  );

  static const myTxtStyleBodySmall = TextStyle(
    fontSize: 16,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w500,
  );

  static const myTxtStyleBodyExtraSmall = TextStyle(
    fontSize: 12,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w500,
  );

  static const myTxtStyleTitleLarge = TextStyle(
    fontSize: 24,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w600,
  );

  static const myTxtStyleTitleMedium = TextStyle(
    fontSize: 20,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w600,
  );

  static const myTxtStyleTitleSmall = TextStyle(
    fontSize: 16,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w600,
  );

  static const myTxtStyleTitleExtraSmall = TextStyle(
    fontSize: 12,
    color: AppColors.deepPurple,
    fontFamily: 'BaiJamjuree',
    fontWeight: FontWeight.w600,
  );
}
