import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/model/home_response_employee.dart';
import 'package:notificator/provider/home_employee_data_provider.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';
import 'package:provider/provider.dart';

import '../generated/assets.dart';
import '../model/notification_data.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
import '../widgets/employee_profile_card.dart';
import '../widgets/profile_group_item_widget.dart';
import '../widgets/profile_update_button_widget.dart';
import '../widgets/see_all_btn_widget.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  String? token;

  @override
  void initState() {
    // get data from server
    instantiate();

    super.initState();
  }

  Future<void> instantiate() async {
    // show overlay
    context.loaderOverlay.show();

    // instantiate provider
    final provider = context.read<HomeEmployeeDataProvider>();

    // get token
    token ??= await Helper.getToken(context);

    // call api through provider
    await provider.getData(token!);

    // when data is successfully fetched
    if (provider.success) {
      debugPrint('HOME_DATA::: success');

      // cache company id
      // TODO: this must be done in a better way (maybe in the login screen)
      if (provider.employee.companyId != null) {
        saveCompanyId(provider.employee.companyId!);
      }
    }

    // hide overlay
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  void saveCompanyId(String id) {
    // store the user type & id in shared-preferences
    final prefProvider = context.read<PreferenceProvider>();
    debugPrint('company id: $id');
    prefProvider.setData(Keys.userCompanyID, id);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = context.watch<HomeEmployeeDataProvider>();

    Employee employee = provider.employee;
    List<NotificationData> notifications = provider.notifications;
    List<Group> groups = provider.groups;

    return RefreshIndicator(
      onRefresh: instantiate,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Personal Information',
                style: Utils.myTxtStyleBodyMedium,
              ),
              ProfileUpdateButtonWidget(
                title: 'Update',
                iconPath: Assets.svgIcSvgproEdit,
                onPress: () {
                  Navigator.pushNamed(context, kRouteUpdateEmployeeProfile);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          EmployeeProfileCardWidget(
            employee: employee,
          ),
          const SizedBox(height: 32),

          // Recent Group Section
          const Text(
            'Recently Joined Groups',
            style: Utils.myTxtStyleBodyMedium,
          ),
          const SizedBox(height: 16),
          groups.isNotEmpty
              ? SizedBox(
                  height: 48,
                  child: ListView.builder(
                    itemCount: groups.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return ProfileGroupItemWidget(
                        title: groups[index].groupName ?? '',
                      );
                    },
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Group Assigned Yet'),
                ),
          const SizedBox(height: 32),

          const Text(
            'Recently Received Notifications',
            style: Utils.myTxtStyleBodyMedium,
          ),
          const SizedBox(height: 16),
          notifications.isNotEmpty
              ? ListView.builder(
                  itemCount: notifications.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationListItemWidget(
                      messageTitle: notifications[index].subject ?? '',
                      group: notifications[index].groupIndividual ?? '',
                      time: Helper.processDateTime(
                          (notifications[index].updatedAt)),
                    );
                  },
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Notifications Received Yet'),
                ),
        ],
      ),
    );
  }
}
