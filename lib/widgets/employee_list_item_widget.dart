import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/util/helper.dart';
import 'package:notificator/widgets/toast_widget.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/employee_delete_provider.dart';
import 'app_alert_dialog.dart';
import 'round_icon_button_widget.dart';

class EmployeeListItemWidget extends StatefulWidget {
  final int id;
  final String firstName;
  final String lastName;
  final String position;
  final String? photo;
  final String? email;
  final String? groupId;

  const EmployeeListItemWidget({
    super.key,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    this.photo,
    this.email,
    this.groupId,
  });

  @override
  State<EmployeeListItemWidget> createState() => _EmployeeListItemWidgetState();
}

class _EmployeeListItemWidgetState extends State<EmployeeListItemWidget> {
  String? token;
  FToast? fToast;

  @override
  void initState() {
    instantiate();
    super.initState();
  }

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
                ClipOval(
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(20), // Image radius
                      child: CachedNetworkImage(
                        imageUrl: widget.photo ??
                            'https://eu.ui-avatars.com/api/?name=${widget.firstName}+${widget.lastName}&size=64',
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        '${widget.firstName} ${widget.lastName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.deepPurple,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      widget.position,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundIconButtonWidget(
                        icon: Icons.change_circle,
                        onPressed: updateEmployee,
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Update',
                        size: 24,
                        color: AppColors.orange,
                      ),
                      RoundIconButtonWidget(
                        icon: Icons.remove_circle,
                        onPressed: removeEmployee,
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

  // TODO: Update Employee
  void update() {}

  void removeEmployee() {
    // Show dialog to confirm remove employee
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialogWidget(
          content:
              'You sure you want to remove employee : ${widget.firstName} ${widget.lastName}?',
          btnTitle: 'REMOVE',
          onConfirm: () async {
            // Display a progress loader
            context.loaderOverlay.show();

            // get employee delete provider
            final provider = context.read<EmployeeDeleteProvider>();

            // initialize token & fToast if not initialized yet
            await instantiate();

            // delete group through provider
            await provider.delete(widget.id, token!);

            // show success message toast when removed
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
              // show error toast when failed to remove
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
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
          },
        );
      },
    );
  }

  /// initialize token & fToast before using them
  Future<void> instantiate() async {
    // initialize toast obj if empty
    if (fToast == null) {
      fToast = FToast();
      fToast?.init(context);
    }

    // get token from provider when token is empty
    token ??= await Helper.getToken(context);
  }

  void updateEmployee() {
    // route to the update employee screen
    Navigator.pushNamed(context, kRouteUpdateEmployee,
        arguments: Employee(
          id: widget.id,
          firstName: widget.firstName,
          lastName: widget.lastName,
          position: widget.position,
          email: widget.email,
        ));
  }
}
