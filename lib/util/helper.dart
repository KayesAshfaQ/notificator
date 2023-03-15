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
    return authProvider.userToken!;
  }
}
