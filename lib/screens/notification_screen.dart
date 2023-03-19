import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../provider/auth_key_provider.dart';
import '../util/helper.dart';
import '../util/utils.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/outlined_button_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationListProvider provider;

  @override
  void initState() {
    instantiate();

    super.initState();
  }

  /// This method is for initializing the provider
  /// and getting the user token
  void instantiate() async {
    //final groupProvider = context.read<GroupProvider>();
    //final groupDeleteProvider = context.read<GroupDeleteProvider>();

    // initialize the notificationList provider
    provider = context.read<NotificationListProvider>();

    // initialize the user token
    String token = await Helper.getToken(context);

    print('token: $token');

    // fetch the notification list data
    await provider.getList(token);

    // listeners for refresh the ui when item is removed
    /*  groupDeleteProvider.addListener(() {
      if (groupDeleteProvider.success) {
        provider.getList(token);
      }
    });*/

    // listeners for refresh the ui when item is created & updated
    /*groupProvider.addListener(() {
      if (groupProvider.success) {
        provider.getList(token);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
        Consumer<NotificationListProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              // show the loader overlay when the data is null
              context.loaderOverlay.show();

              return const SizedBox();
            } else {
              // hide the loader overlay
              context.loaderOverlay.hide();

              // if list is empty show no group text
              // else show the list of groups
              return provider.data!.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.data?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final notification = provider.data![index];

                        return NotificationListItemWidget(
                          messageTitle: notification.subject ?? '',
                          group: notification.groupIndividual ?? '',
                          time:
                              Helper.processDateTime((notification.updatedAt)),
                        );
                      },
                    )
                  : SizedBox(
                      height: height * .6,
                      child: const Center(
                        child: Text(
                          'No GROUPS found.',
                          style: Utils.myTxtStyleBodySmall,
                        ),
                      ),
                    );
            }
          },
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
