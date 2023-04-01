import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/setting_data_get_provider.dart';
import 'package:notificator/util/utils.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../constants/setting_constants.dart';
import '../generated/assets.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../widgets/app_alert_dialog.dart';
import '../widgets/setting_item_widget.dart';

class SettingAdminScreen extends StatefulWidget {
  const SettingAdminScreen({Key? key}) : super(key: key);

  @override
  State<SettingAdminScreen> createState() => _SettingAdminScreenState();
}

class _SettingAdminScreenState extends State<SettingAdminScreen> {
  String? token;

  @override
  void initState() {
    instantiate();
    super.initState();
  }

  Future<void> instantiate() async {
    // show overlay
    context.loaderOverlay.show();

    // instantiate provider
    final provider = context.read<SettingDataGetProvider>();

    // get token
    token ??= await Helper.getToken(context);

    // call api through provider
    await provider.getData(token!);

    // hide overlay
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;

    final provider = context.watch<SettingDataGetProvider>();

    return RefreshIndicator(
      onRefresh: () {
        final provider = context.read<SettingDataGetProvider>();
        return provider.getData(token!);
      },
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingItemWidget(
            title: 'Receive notifications on mail',
            switchValue: provider.mailNotification,
            onChanged: (value) => sendSettingsData(
              value,
              SettingConstants.keyReceiveMailNotification,
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 4,
          ),
          SettingItemWidget(
            title: 'Receive push notifications',
            switchValue: provider.pushNotification,
            onChanged: (value) => sendSettingsData(
              value,
              SettingConstants.keyReceivePushNotification,
            ),
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
                    'Update SMTP Configuration',
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

  /// send settings data to server
  void sendSettingsData(bool value, String key) async {
    debugPrint('value: $value, key: $key');

    // show progress loader
    context.loaderOverlay.show();

    // initialize toast provider
    final toastProvider = context.read<ToastProvider>();
    toastProvider.initialize(context);

    // call api through provider
    final provider = context.read<SettingDataGetProvider>();
    await provider.setData(
      token!,
      key,
      value ? SettingConstants.switchOn : SettingConstants.switchOff,
    );

    // show toast message
    if (provider.success) {
      // Display a success toast
      toastProvider.showSuccessToast('success');
    } else {
      // Display a success toast
      toastProvider.showErrorToast('error');
    }

    // hide progress loader
    if (context.mounted) context.loaderOverlay.hide();
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
