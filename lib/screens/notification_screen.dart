import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/notification_create_provider.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';
import 'package:notificator/widgets/search_notification_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/routes.dart';
import '../provider/notification_count_provider.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
import '../util/utils.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/outlined_button_widget.dart';
import '../widgets/popup_button_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationListProvider provider;
  late final String token;
  late final String employeeType;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    instantiate();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    debugPrint('token: $token');

    // reset the page number to 1 when fetching data for first time
    provider.resetCurrentPage();

    // get the employee type
    await initEmployeeType();

    // fetch the notification list data
    if (employeeType.isNotEmpty) {
      await provider.getList(token, employeeType);
    }

    // count the notification
    countUnreadNotification();

    // listeners for refresh the ui when item is created & updated
    notificationProvider.addListener(() {
      if (notificationProvider.success) {
        provider.getList(token, employeeType);
      }
    });
  }

  void countUnreadNotification() async {
    print('initNotificationCount() called');
    if (employeeType == '2') {
      final notifCountProvider = context.read<NotificationCountProvider>();
      await notifCountProvider.getCount(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () {
        // Refresh the notification count when the user pulls down
        countUnreadNotification();

        provider.resetCurrentPage();
        provider.resetSearch();

        // Refresh the list when the user pulls down
        return provider.resetNotificationList(token, employeeType);
      },
      child: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupButtonWidget(
                label: 'Sort By',
                icon: Icons.sort,
                sortOptions: Constants.sortOptions,
                onSelected: (String selectedItem) {
                  if (kDebugMode) {
                    print('Selected item: $selectedItem');
                  }

                  sortNotificationList(selectedItem);
                },
              ),
              const SizedBox(width: 4),
              OutlinedButtonWidget(
                label: 'Filter',
                icon: Icons.filter_list,
                onPressed: () {
                  print('OutlinedButtonWidget');
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const SearchNotificationBottomSheet(),
                        ),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              Consumer<PreferenceProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return value.data == '1'
                      ? ElevatedCreateButtonWidget(
                          title: 'Send Notification',
                          icon: Icons.circle_notifications_sharp,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, kRouteCreateNotification);
                          },
                        )
                      : const SizedBox();
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
                        //controller: _scrollController,
                        itemCount: (provider.data?.length)! + 1,
                        //+1 to reserve space for the loading indicator
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == provider.data?.length) {
                            return _buildProgressIndicator();
                          } else {
                            final notification = provider.data![index];

                            return NotificationListItemWidget(
                              id: notification.id.toString(),
                              messageTitle: notification.subject ?? '',
                              group: notification.groupIndividualName ?? '',
                              time: Helper.processDate(
                                (notification.updatedAt),
                              ),
                              readStatus: notification.readStatus ?? '',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  kRouteNotificationDetails,
                                  arguments: '${notification.id}',
                                );

                                // mark the notification as read when the user taps on it
                                if (notification.readStatus ==
                                    Constants.kStatusUnread) {
                                  provider.markAsRead(index);
                                }
                              },
                            );
                          }
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

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Check if there are more items to load
      if (provider.currentPage < provider.lastPage && !provider.isLoading) {
        provider.setLoading(true);
        provider.incrementPage();

        if (provider.isSearch) {
          await provider.notificationSearch(token);
        } else {
          await provider.getList(token, employeeType);
        }

        //delay the loading state to false
        Future.delayed(const Duration(milliseconds: 3000), () {
          provider.setLoading(false);
        });
      } /*else{
        Fluttertoast.showToast(
            msg: "Wait a sec",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xF443363F),
            textColor: Colors.white,
            fontSize: 12.0
        );
      }*/
    }
  }

  Widget _buildProgressIndicator() {
    print('_buildProgressIndicator');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: provider.isLoading
            ? const SpinKitCircle(
                color: AppColors.lightOrange,
                size: 32.0,
              )
            : !(provider.isLoading) && provider.currentPage >= provider.lastPage
                ? const Text('No more information to load',
                    style: Utils.myTxtStyleBodySmall)
                : const SizedBox(),
      ),
    );
  }

  void sortNotificationList(String selectedItem) async {
    provider.resetCurrentPage();
    String sortType = '';

    switch (selectedItem) {
      case Constants.asc:
        sortType = 'asc';
        break;
      case Constants.desc:
        sortType = 'desc';
        break;
    }

    provider.sortType = sortType;

    // show the loader overlay
    context.loaderOverlay.show();

    //final employeeSearchProvider = context.read<EmployeeSearchProvider>();
    await provider.notificationSearch(token);

    // if the search is successful
    if (provider.success) {
      provider.isSearch = true;
      print('search success');
    }

    // hide the loader overlay
    if (context.mounted) context.loaderOverlay.hide();
  }
}
