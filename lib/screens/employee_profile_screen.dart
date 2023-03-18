import 'package:flutter/material.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';

import '../generated/assets.dart';
import '../widgets/employee_profile_card.dart';
import '../widgets/profile_group_item_widget.dart';
import '../widgets/profile_update_button_widget.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
        const EmployeeProfileCardWidget(),
        const SizedBox(height: 24),
        const Text(
          'Recent Groups',
          style: Utils.myTxtStyleBodyMedium,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return const ProfileGroupItemWidget(title: '');
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Recent Notifications',
          style: Utils.myTxtStyleBodyMedium,
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
}
