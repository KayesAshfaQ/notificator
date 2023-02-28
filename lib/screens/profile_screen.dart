import 'package:flutter/material.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';

import '../constants/app_colors.dart';
import '../widgets/profile_update_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              onPress: () {
                Navigator.pushNamed(context, kRouteUpdateProfile);
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
            return const RecentGroupListItemWidget();
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

class RecentGroupListItemWidget extends StatelessWidget {
  const RecentGroupListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple_100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Developers',
        style: Utils.myTxtStyleBodySmall,
      ),
    );
  }
}

class EmployeeProfileCardWidget extends StatelessWidget {
  const EmployeeProfileCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.purple_100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Name',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'John Doe',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Email',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'example@email.com',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Phone',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    '+880 17065-24797',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Position',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'Developer',
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
