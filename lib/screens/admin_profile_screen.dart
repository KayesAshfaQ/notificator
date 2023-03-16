import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/home_data_provider.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../generated/assets.dart';
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
  @override
  void initState() {
    // get data from server
    instantiate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Welcome,',
                  style: Utils.myTxtStyleBodySmall,
                ),
                Text(
                  // TODO: Replace with user name
                  'John Doe',
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
          data: 'John Doe',
        ),
        ProfileInfoWidget(
          width: width,
          title: 'Email',
          data: 'example@gmail.com',
        ),
        ProfileInfoWidget(
          width: width,
          title: 'Phone',
          data: '+880 1234567890',
        ),
        ProfileInfoWidget(
          width: width,
          title: 'Address',
          data: 'Street, City, Country.',
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            StatusCardWidget(
              alignment: MainAxisAlignment.spaceBetween,
              title: 'Groups',
              data: '21',
              icon: Icons.people_alt,
            ),
            SizedBox(width: 8),
            StatusCardWidget(
              title: 'Employees',
              data: '71',
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
                '100',
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
                    style: Utils.myTxtStyleBodyExtraSmall.copyWith(fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
        ), // notification count card
        const SizedBox(height: 24),
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
        SizedBox(
          height: 48,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return const ProfileGroupItemWidget();
            },
          ),
        ),
        const SizedBox(height: 24),
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
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return const NotificationListItemWidget();
          },
        ),
      ],
    );
  }

  void instantiate() async {
    // show overlay
    context.loaderOverlay.show();

    // instantiate provider
    final provider = context.read<HomeDataProvider>();

    // get token
    String token = await Helper.getToken(context);

    // call api through provider
    await provider.getData(token);

    if (provider.success) {
      debugPrint('HOME_DATA::: success');

      // cache company id
      if (provider.company.id != null) {
        saveCompanyId(provider.company.id!);
      }

      // update company ui data


      // update count ui data

      // update recent group ui data

      // update recent notification ui data
    }

    // hide overlay
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  void saveCompanyId(int id) {
    // store the user type & id in shared-preferences
    final prefProvider = context.read<PreferenceProvider>();
    debugPrint('company type: ${id}');
    prefProvider.setData(Keys.userCompanyID, '$id');
  }
}
