import 'package:flutter/material.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';

import '../constants/app_colors.dart';
import '../constants/routes.dart';
import '../generated/assets.dart';
import '../widgets/elevated_create_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    return ListView(
      padding: const EdgeInsets.all(20),
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ElevatedCreateButtonWidget(
            title: 'Send Notification',
            icon: Icons.circle_notifications_sharp,
            onPressed: () {
              Navigator.pushNamed(context, kRouteCreateNotification);
            },
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Notifications You have sent',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            OutlinedButtonWidget(
              label: 'Sort By',
              icon: Icons.sort,
            ),
            SizedBox(width: 8),
            OutlinedButtonWidget(
              label: 'Filter',
              icon: Icons.filter_list,
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        //TODO: Add ListView.builder
        ListView(
          shrinkWrap: true,
          cacheExtent: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            NotificationListItemWidget(onPressed: onNotificationTap),
            NotificationListItemWidget(onPressed: onNotificationTap),
            NotificationListItemWidget(onPressed: onNotificationTap),
            NotificationListItemWidget(onPressed: onNotificationTap),
            NotificationListItemWidget(onPressed: onNotificationTap),
            NotificationListItemWidget(onPressed: onNotificationTap),
          ],
        ),
      ],
    );
  }

  void onNotificationTap() {
    // SnackBar snackBar = const SnackBar(content: Text('Employee clicked'));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Employee clicked');

    Navigator.pushNamed(context, kRouteNotificationDetails);
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  final String label;
  final IconData? icon;

  const OutlinedButtonWidget({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.orange,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.black87,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.deepPurple,
              fontFamily: 'BaiJamjuree',
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
