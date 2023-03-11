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

  static void showProgressLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(
              color: AppColors.lightOrange,
            ),
          ),
        );
      },
    );
  }

  static void hideProgressLoader(BuildContext context, {int delay = 2500}) {
    Future.delayed(
      Duration(milliseconds: delay),
      () {
        Navigator.of(context).pop();
      },
    );
  }

  static RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static String errorString(Map<String, dynamic> map) {
    return map.toString().replaceAll('{', '').replaceAll('}', '');
  }

  static String? validate(value) {
    if (value.isEmpty) {
      return 'Please enter some data';
    }
    return null;
  }

  static String? validatePassword(value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }


  /// This method is used to show a dialog box to confirm the exit of the app
  static Future<bool> closeConfirm(context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Do you want to exit the App?',
            style: Utils.myTxtStyleTitleSmall),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              //style: TextStyle(color: AppColors.orange),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Exit',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

// RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
