import 'package:flutter/material.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';

import '../constants/routes.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/outlined_button_widget.dart';

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
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const OutlinedButtonWidget(
              label: 'Sort By',
              icon: Icons.sort,
            ),
            const SizedBox(width: 4),
            const OutlinedButtonWidget(
              label: 'Filter',
              icon: Icons.filter_list,
            ),
            const Spacer(),
            ElevatedCreateButtonWidget(
              title: 'Send Notification',
              icon: Icons.circle_notifications_sharp,
              onPressed: () {
                Navigator.pushNamed(context, kRouteCreateNotification);
              },
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
    debugPrint('Employee clicked');

    Navigator.pushNamed(context, kRouteNotificationDetails);
  }
}
