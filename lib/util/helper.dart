import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_key_provider.dart';

class Helper {
  /// initialize token & fToast before using them
  static Future<String> getToken(BuildContext context) async {
    // get token from provider when token is empty
    final authProvider = context.read<AuthKeyProvider>();
    if (authProvider.userToken == null) {
      await authProvider.getUserToken();
    }
    return authProvider.userToken ?? '';
  }

  /// This method is used to process the date time
  static String processDate(DateTime? dateTime) {
    // get current date time
    DateTime now = DateTime.now();

    if(dateTime == null) {
      return 'unknown';
    }

    // calculate difference
    Duration difference = now.difference(dateTime);

    // print difference
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  /// This method is used to remove last comma from a string
  static String removeLastComma(String str) {
    return str.replaceFirst(RegExp(r',\s*$'), '');
  }

}
