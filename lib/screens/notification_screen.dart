import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/notification_create_provider.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/provider/notification_read_all_provider.dart';
import 'package:notificator/widgets/notification_list_item_widget.dart';
import 'package:notificator/widgets/search_notification_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/routes.dart';
import '../provider/notification_count_provider.dart';
import '../provider/preference_provider.dart';
import '../provider/toast_provider.dart';
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
  final ScrollController _scrollController = ScrollController();
  String? token;
  String? employeeType;

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
    // show loader overlay
    context.loaderOverlay.show();

    final notificationProvider = context.read<NotificationCreateProvider>();
    //final groupDeleteProvider = context.read<GroupDeleteProvider>();

    // initialize the notificationList provider
    provider = context.read<NotificationListProvider>();

    // initialize the user token
    token = await Helper.getToken(context);

    debugPrint('token: $token');

    // clear the data
    //provider.clearData();

    // reset the page number to 1 when fetching data for first time
    provider.resetCurrentPage();

    // get the employee type
    await initEmployeeType();

    // fetch the notification list data
    if (token != null && employeeType != null) {
      // new data will be fetched only if the data is empty or null
      if (provider.data == null || provider.data!.isEmpty) {
        await provider.getList(token!, employeeType!);
      }

      // listeners for refresh the ui when item is created & updated
      notificationProvider.addListener(() {
        if (notificationProvider.success) {
          provider.getList(token!, employeeType!);
        }
      });
    }

    // count the notification
    countUnreadNotification();

    // hide loader overlay
    if (context.mounted && context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  void countUnreadNotification() async {
    if (kDebugMode) {
      print('initNotificationCount() called');
    }
    if (employeeType == '2') {
      final notifCountProvider = context.read<NotificationCountProvider>();
      await notifCountProvider.getCount(token!);
    }
  }

  Future<void> refresh() async {
    // Refresh the notification count when the user pulls down
    countUnreadNotification();

    provider.resetCurrentPage();
    provider.resetSearch();

    // Refresh the list when the user pulls down
    await provider.resetNotificationList(token!, employeeType!);
  }

  // read all the notification when the user tap on the read all button
  void onNotificationReadAll() async {
    // show loader overlay
    context.loaderOverlay.show();

    // initialize toast provider
    final toastProvider = context.read<ToastProvider>();
    toastProvider.initialize(context);

    final provider = context.read<NotificationReadAllProvider>();

    // initialize the user token
    token = await Helper.getToken(context);

    if (token != null) {
      await provider.readAll(token!);

      if (provider.success) {
        toastProvider.showSuccessToast(provider.message);

        // refresh the notification list
        await refresh();
      } else {
        toastProvider.showWarnToast(provider.error);
      }
    } else {
      debugPrint('token is null');
    }

    // read all the notification
    await provider.readAll(token!);

    // hide loader overlay
    if (context.mounted && context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      //triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
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
              Consumer<NotificationListProvider>(
                builder: (context, value, child) => value.filterTxt.isEmpty
                    ? employeeType == '2'
                        ? PopupButtonWidget(
                            label: 'Filter',
                            icon: Icons.filter_list,
                            sortOptions: const [
                              'All',
                              'Unread',
                              'Read',
                              'Search'
                            ],
                            onSelected: (String selectedItem) {
                              if (kDebugMode) {
                                print('Selected item: $selectedItem');
                              }

                              filterNotificationList(selectedItem);
                            },
                          )
                        : OutlinedButtonWidget(
                            label: 'Filter',
                            icon: Icons.filter_list,
                            onPressed: () {
                              if (kDebugMode) {
                                print('OutlinedButtonWidget');
                              }
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child:
                                          const SearchNotificationBottomSheet(),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                    : OutlinedButton(
                        onPressed: refresh,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: AppColors.deepPurple, width: 0.7),
                          foregroundColor: AppColors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.clear,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: 48,
                              child: Text(
                                value.filterTxt,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.deepPurple,
                                  fontFamily: 'BaiJamjuree',
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      : ElevatedCreateButtonWidget(
                          title: 'Mark all as read',
                          icon: Icons.mark_chat_read,
                          onPressed: onNotificationReadAll,
                        );
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

                                  // decrease count by 1
                                  context
                                      .read<NotificationCountProvider>()
                                      .decrementCount();
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
          if (token != null) {
            await provider.notificationSearch(token!);
          }
        } else {
          if (token != null && employeeType != null) {
            await provider.getList(token!, employeeType!);
          }
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
    if (kDebugMode) {
      print('_buildProgressIndicator');
    }

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
                    style: Utils.myTxtStyleBodyExtraSmall)
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

    //clear data & then load the
    provider.clearData();
    if (token != null) {
      await provider.notificationSearch(token!);
    }

    // if the search is successful
    if (provider.success) {
      provider.isSearch = true;
      if (kDebugMode) {
        print('search success');
      }
    }

    // hide the loader overlay
    if (context.mounted) context.loaderOverlay.hide();
  }

  void filterNotificationList(String selectedItem) async {
    provider.resetCurrentPage();
    String? filterType;

    switch (selectedItem) {
      case Constants.kAll:
        filterType = null;
        break;
      case Constants.kRead:
        filterType = '1';
        break;
      case Constants.kUnread:
        filterType = '0';
        break;
      case Constants.kSearch:
        filterType = null;
        onFilterSearch();
        break;
    }

    provider.isRead = filterType;

    // show the loader overlay
    if (selectedItem != Constants.kSearch) {
      context.loaderOverlay.show();
    }

    //clear data & then load the
    provider.clearData();
    if (token != null) {
      await provider.notificationSearch(token!);
    }

    // if the search is successful
    if (provider.success) {
      provider.isSearch = true;
      if (kDebugMode) {
        print('search success');
      }
    }

    // hide the loader overlay
    if (context.mounted && context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  void onFilterSearch() {
    if (kDebugMode) {
      print('OutlinedButtonWidget');
    }
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
  }
}
