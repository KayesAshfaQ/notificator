import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notificator/util/utils.dart';

import '../constants/app_colors.dart';
import '../constants/routes.dart';
import '../generated/assets.dart';
import '../widgets/app_alert_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingItemWidget(
            title: 'Receive notification to mail',
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 4,
          ),
          const SettingItemWidget(
            title: 'Receive push notifications',
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 4,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, kRouteSettingChangePass);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Change Password',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_right,
                      //size: 24,
                      //color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 4,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, kRouteEmailConfig);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Update Email Configuration',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_right,
                      //size: 24,
                      //color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 4,
          ),
          InkWell(
            onTap: onDeactivateAccount,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Deactivate your account',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                  SvgPicture.asset(
                    Assets.svgIcDelete,
                    height: 28,
                    width: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show dialog to confirm delete account
  void onDeactivateAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogWidget(
          content: 'Are you sure you want to Deactivate your account?',
          btnTitle: 'DELETE',
          onConfirm: () {
            //TODO: Perform delete account action here
          },
        );
      },
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  final String title;

  const SettingItemWidget({
    super.key,
    required this.title,
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
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
