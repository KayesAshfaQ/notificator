import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/home_admin_data_provider.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../generated/assets.dart';
import '../model/company.dart';
import '../model/home_response_admin.dart';
import '../model/notification_data.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
import '../util/utils.dart';
import '../widgets/notification_list_item_widget.dart';
import '../widgets/profile_card_widget.dart';
import '../widgets/profile_group_item_widget.dart';
import '../widgets/profile_update_button_widget.dart';
import '../widgets/see_all_btn_widget.dart';
import '../widgets/status_card_widget.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  String? token;

  @override
  void initState() {
    // get data from server
    instantiate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = context.watch<HomeAdminDataProvider>();

    Company company = provider.company;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome,',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                  Text(
                    (company.name?.isEmpty ?? true)
                        ? '. . . . . . .'
                        : company.name!,
                    style: Utils.myTxtStyleTitleMedium,
                  ),
                ],
              ),
              ProfileUpdateButtonWidget(
                title: 'Update',
                iconPath: Assets.svgIcSvgproEdit,
                onPress: () {
                  Navigator.pushNamed(context, kRouteUpdateAdminProfile);
                },
              ),
            ],
          ), // First Row welcome section
          const SizedBox(height: 16),

          ProfileInfoWidget(
            width: width,
            title: 'Name',
            data:
                (company.name?.isEmpty ?? true) ? '_ _ _ _ _ _' : company.name!,
          ),
          ProfileInfoWidget(
            width: width,
            title: 'Email',
            data: (company.email?.isEmpty ?? true)
                ? '_ _ _ _ _ _'
                : company.email!,
          ),
          ProfileInfoWidget(
            width: width,
            title: 'Phone',
            data: (company.phone?.isEmpty ?? true)
                ? '_ _ _ _ _ _'
                : company.phone!,
          ),
          ProfileInfoWidget(
            width: width,
            title: 'Address',
            data: (company.address?.isEmpty ?? true)
                ? '_ _ _ _ _ _'
                : company.address!,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusCardWidget(
                alignment: MainAxisAlignment.spaceBetween,
                title: 'Groups',
                data: provider.totalGroup.toString(),
                icon: Icons.people_alt,
              ),
              const SizedBox(width: 8),
              StatusCardWidget(
                title: 'Employees',
                data: provider.totalEmployee.toString(),
                alignment: MainAxisAlignment.spaceAround,
                icon: Icons.work,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.purple_100,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications,
                  color: AppColors.deepPurple.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  provider.totalNotifications.toString(),
                  style: Utils.myTxtStyleTitleLarge.copyWith(
                    color: Colors.orange,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notifications',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Utils.myTxtStyleTitleExtraSmall,
                    ),
                    Text(
                      'You\'ve created Created',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          Utils.myTxtStyleBodyExtraSmall.copyWith(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
          ), // notification count card
          const SizedBox(height: 24),

          // Recent Group Section
          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Groups',
                style: Utils.myTxtStyleTitleSmall,
              ),
              SeeAllButtonWidget(
                onPress: () {
                  //Navigator.pushNamed(context, kRouteUpdateEmployeeProfile);
                },
              ),
            ],
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
                        title: groups[index].name ?? '',
                      );
                    },
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Group Created Yet'),
                ),
          const SizedBox(height: 24),

          // Recent Notifications Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Notifications',
                style: Utils.myTxtStyleTitleSmall,
              ),
              SeeAllButtonWidget(
                onPress: () {
                  //Navigator.pushNamed(context, kRouteUpdateEmployeeProfile);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            itemCount: notifications.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return NotificationListItemWidget(
                id: notifications[index].id.toString(),
                messageTitle: notifications[index].subject ?? '',
                group: notifications[index].groupIndividualName ?? '',
                time: Helper.processDate((notifications[index].updatedAt)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    kRouteNotificationDetails,
                    arguments: '${notifications[index].id}',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> instantiate() async {
    // show overlay
    context.loaderOverlay.show();

    // instantiate provider
    final provider = context.read<HomeAdminDataProvider>();

    // get token
    token ??= await Helper.getToken(context);

    // call api through provider
    await provider.getData(token!);

    // when data is successfully fetched
    if (provider.success) {
      debugPrint('HOME_DATA::: success');

      // TODO: this must be done in a better way (maybe in the login screen)
      // cache company id
      if (provider.company.id != null) {
        saveCompanyId(provider.company.id!);
      }
    }

    // hide overlay
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  void saveCompanyId(int id) {
    // store the user type & id in shared-preferences
    final prefProvider = context.read<PreferenceProvider>();
    debugPrint('company id: $id');
    prefProvider.setData(Keys.userCompanyID, '$id');
  }
}
