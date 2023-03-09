import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/group_delete_provider.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/widgets/toast_widget.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/auth_key_provider.dart';
import 'deactivate_account_dialog.dart';
import 'round_icon_button_widget.dart';

class GroupListItemWidget extends StatefulWidget {
  final String name;
  final int id;

  const GroupListItemWidget({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  State<GroupListItemWidget> createState() => _GroupListItemWidgetState();
}

class _GroupListItemWidgetState extends State<GroupListItemWidget> {
  String? token;
  FToast? fToast;

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            // SnackBar snackBar = const SnackBar(content: Text('Employee clicked'));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('Employee clicked');
          },
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
                Text(
                  widget.name,
                  style: Utils.myTxtStyleBodySmall,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundIconButtonWidget(
                        icon: Icons.change_circle,
                        onPressed: updateGroup,
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Update',
                        size: 24,
                        color: AppColors.orange,
                      ),
                      RoundIconButtonWidget(
                        icon: Icons.remove_circle,
                        onPressed: removeGroup,
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Remove',
                        size: 24,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }

  void removeGroup() {
    // Show dialog to confirm remove group
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogWidget(
          content: 'You sure you want to remove group ${widget.name}?',
          btnTitle: 'REMOVE',
          onConfirm: () async {
            // Display a progress loader
            context.loaderOverlay.show();
            await instiantiate();

            // delete group through provider
            final provider = context.read<GroupDeleteProvider>();
            provider.delete(widget.id, token!);

            // show toast when removed
            if (provider.success) {
              // Display a success toast
              fToast?.showToast(
                child: ToastWidget(
                  message: provider.message,
                  iconData: Icons.check,
                  backgroundColor: Colors.black87,
                ),
              );
            } else {
              // Display an error toast
              fToast?.showToast(
                child: ToastWidget(
                  message: provider.error,
                  iconData: Icons.error_outline,
                  backgroundColor: Colors.red,
                ),
                //toastDuration: const Duration(seconds: 20),
              );
            }

            // Hide the progress loader
            context.loaderOverlay.hide();
          },
        );
      },
    );
  }

  /// initialize token & fToast before using them
  Future<void> instiantiate() async {
    // initialize toast obj if empty
    if (fToast == null) {
      fToast = FToast();
      fToast?.init(context);
    }

    // get token from provider when token is empty
    if (token == null) {
      final authProvider = context.read<AuthKeyProvider>();
      await authProvider.getUserToken();
      token = authProvider.userToken!;
    }
  }

  void updateGroup() {
    // SnackBar snackBar = const SnackBar(content: Text('Update clicked'));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Update clicked');
  }
}
