import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/logout_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../provider/auth_key_provider.dart';
import '../util/utils.dart';
import 'app_alert_dialog.dart';

class AppDrawerWidget extends StatefulWidget {
  final double width;

  const AppDrawerWidget({
    super.key,
    required this.width,
  });

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.width * 0.65,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imgDrawerHeadBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(24), // Image radius
                      child: RandomAvatar(
                        Random().nextInt(1000).toString(),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Text(
                  //TODO: show user name
                  'User Name',
                  style:
                      Utils.myTxtStyleTitleMedium.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.orange,
            ),
            title: const Text('About', style: Utils.myTxtStyleBodySmall),
            onTap: () {
              // hide the drawer
              Navigator.pop(context);

              // navigate to about screen
              Navigator.pushNamed(context, kRouteMoreDetails);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.feedback_outlined,
              color: AppColors.orange,
            ),
            title: const Text('Feedback', style: Utils.myTxtStyleBodySmall),
            onTap: () {
              Fluttertoast.showToast(msg: 'this feature is not available yet');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share_outlined,
              color: AppColors.orange,
            ),
            title:
                const Text('Share this app', style: Utils.myTxtStyleBodySmall),
            onTap: () {
              Fluttertoast.showToast(msg: 'this feature is not available yet');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: AppColors.orange,
            ),
            title:
                const Text('Privacy policy', style: Utils.myTxtStyleBodySmall),
            onTap: () {
              Fluttertoast.showToast(msg: 'this feature is not available yet');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.insert_drive_file_outlined,
              color: AppColors.orange,
            ),
            title: const Text('Terms & Condition',
                style: Utils.myTxtStyleBodySmall),
            onTap: () {
              Fluttertoast.showToast(msg: 'this feature is not available yet');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rate_review_outlined,
              color: AppColors.orange,
            ),
            title: const Text('Rate Us', style: Utils.myTxtStyleBodySmall),
            onTap: () {
              Fluttertoast.showToast(msg: 'this feature is not available yet');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColors.orange,
            ),
            title: const Text('Logout', style: Utils.myTxtStyleBodySmall),
            onTap: () => // show dialog
                showDialog(
              context: context,
              builder: (_) => AppAlertDialogWidget(
                title: 'Logout',
                content: 'Are you sure you want to logout?',
                btnTitle: 'Logout',
                onConfirm: () => logout(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    // Display a progress loader
    context.loaderOverlay.show();
    final provider = context.read<LogoutProvider>();

    // get user token
    final authProvider = context.read<AuthKeyProvider>();
    await authProvider.getUserToken();
    String token = authProvider.userToken!;

    // logout user through provider
    await provider.logout(token);

    // show toast when removed
    if (provider.success) {
      // clear token
      authProvider.removeUserToken();

      // Display a logout success toast
      Fluttertoast.showToast(
          msg: provider.message, toastLength: Toast.LENGTH_LONG);

      // Hide the progress loader
      if (context.mounted) {
        context.loaderOverlay.hide();
      }

      // Navigate to login screen
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          kRouteLogin,
          (route) => false,
        );
      }
    } else {
      // Display a logout fail toast
      Fluttertoast.showToast(
          msg: provider.error, toastLength: Toast.LENGTH_LONG);

      // clearing token on next app open user have to login again
      // authProvider.removeUserToken();

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();

      // hide drawer
      if (context.mounted) Navigator.pop(context);
    }
  }
}
