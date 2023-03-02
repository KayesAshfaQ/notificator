import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

import '../constants/routes.dart';
import '../util/utils.dart';
import '../widgets/notification_list_item_widget.dart';
import '../widgets/profile_group_item_widget.dart';
import '../widgets/profile_update_button_widget.dart';
import '../widgets/see_all_btn_widget.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
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
              onPress: () {
                Navigator.pushNamed(context, kRouteUpdateEmployeeProfile);
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
          data: 'Mirpur, Dhaka',
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
        const StatusCardWidget(
          title: 'Notifications',
          data: '100',
          alignment: MainAxisAlignment.center,
          padding: 16,
          icon: Icons.notifications,
        ),

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
}

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({
    super.key,
    required this.alignment,
    this.padding,
    required this.title,
    this.data = '0',
    this.icon,
  });

  final String title;
  final String data;
  final IconData? icon;
  final MainAxisAlignment alignment;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.purple_100,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.deepPurple.withOpacity(0.7),
              size: 24,
            ),
            SizedBox(width: padding ?? 4),
            Text(
              data,
              style: Utils.myTxtStyleTitleLarge.copyWith(
                color: Colors.orange,
                fontSize: 24,
              ),
            ),
            SizedBox(width: padding ?? 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
      ),
    );
  }
}

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.width,
    required this.title,
    required this.data,
  });

  final double width;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.16,
            child: Text(
              title,
              style: Utils.myTxtStyleTitleSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              ':',
              style: Utils.myTxtStyleTitleSmall,
            ),
          ),
          Text(data, style: Utils.myTxtStyleBodySmall),
        ],
      ),
    );
  }
}
