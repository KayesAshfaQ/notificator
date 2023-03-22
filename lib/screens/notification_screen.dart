import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/notification_create_provider.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
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
  late final String token;
  late final String employeeType;

  @override
  void initState() {
    instantiate();

    super.initState();
  }

  Future<void> initEmployeeType() async {
    // get the employee type form the shared preferences
    final provider = context.read<PreferenceProvider>();

    // get the employee type
    await provider.getData(Keys.userType);

    // set the employee type
    employeeType = provider.data ?? '';

    debugPrint('employeeType: $employeeType');
  }

  /// This method is for initializing the provider
  /// and getting the user token
  void instantiate() async {
    final notificationProvider = context.read<NotificationCreateProvider>();
    //final groupDeleteProvider = context.read<GroupDeleteProvider>();

    // initialize the notificationList provider
    provider = context.read<NotificationListProvider>();

    // initialize the user token
    token = await Helper.getToken(context);

    print('token: $token');

    // get the employee type
    await initEmployeeType();

    // fetch the notification list data
    if (employeeType.isNotEmpty) {
      await provider.getList(token, employeeType);
    }

    // listeners for refresh the ui when item is created & updated
    notificationProvider.addListener(() {
      if (notificationProvider.success) {
        provider.getList(token, employeeType);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () {
        // Refresh the list when the user pulls down
        return provider.getList(token, employeeType);
      },
      child: ListView(
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
                            id: notification.id.toString(),
                            messageTitle: notification.subject ?? '',
                            group: notification.groupIndividualName ?? '',
                            time: Helper.processDate(
                              (notification.updatedAt),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                kRouteNotificationDetails,
                                arguments: {
                                  'id': '${notification.id}',
                                  'userType': employeeType,
                                },
                              );
                            },
                          );
                        },
                      )
                    : SizedBox(
                        height: height * .6,
                        child: const Center(
                          child: Text(
                            'No Notification found.',
                            style: Utils.myTxtStyleBodySmall,
                          ),
                        ),
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
