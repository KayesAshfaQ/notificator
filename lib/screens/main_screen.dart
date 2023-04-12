import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/notification_count_provider.dart';
import 'package:notificator/provider/preference_provider.dart';
import 'package:notificator/provider/user_preference_provider.dart';
import 'package:notificator/screens/setting_screen_admin.dart';
import 'package:notificator/screens/home_screen_admin.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/group_screen.dart';
import 'package:notificator/screens/notification_screen.dart';
import 'package:notificator/screens/setting_screen_employee.dart';
import 'package:notificator/util/utils.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../util/keys.dart';
import '../widgets/app_drawer_widget.dart';
import 'home_screen_employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? employeeType;
  String? token;
  int notificationCount = 0;

  // bottom navigation bar titles list for employee
  final List<String> _titlesEmployee = const [
    'Home',
    'Notifications',
    'Settings',
  ];

  // bottom navigation bar titles list for admin
  final List<String> _titlesAdmin = const [
    'Home',
    'Groups',
    'Notifications',
    'Employees',
    'Settings',
  ];

  // bottom navigation bar screens list for employee
  final List<Widget> _screensEmployee = const [
    EmployeeProfileScreen(),
    NotificationScreen(),
    SettingEmployeeScreen(),
  ];

  // bottom navigation bar screens list for admin
  final List<Widget> _screensAdmin = const [
    AdminProfileScreen(),
    GroupScreen(),
    NotificationScreen(),
    EmployeeScreen(),
    SettingAdminScreen(),
  ];

  int i = 0;

  @override
  void didChangeDependencies() {
    if (employeeType == null) {
      //initToken();
      initEmployeeType();
    }

    print(i++);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final width = MediaQuery.of(context).size.width;

    // notification count
    initNotificationCount();

    debugPrint('home_build');

    return WillPopScope(
      onWillPop: () {
        return Utils.closeConfirm(context);
      },
      child: Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            appProvider.title,
            style: Utils.myTxtStyleTitleMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/img/appbar-background.png'),
            fit: BoxFit.cover,
          ),
          leading: Builder(
            builder: (context) => IconButton(
              splashRadius: 24,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.orange,
              ),
            ),
          ),
        ),
        drawer: AppDrawerWidget(width: width),
        body: employeeType == null
            ? const SizedBox()
            : Center(
                child: employeeType == '1'
                    ? _screensAdmin[appProvider.currentIndex]
                    : _screensEmployee[appProvider.currentIndex],
              ),
        bottomNavigationBar: employeeType == null
            ? null
            : BottomNavigationBar(
                currentIndex: appProvider.currentIndex,
                onTap: (index) {
                  appProvider.setCurrentIndex(index);
                  appProvider.setTitle(
                    employeeType == '1'
                        ? _titlesAdmin[appProvider.currentIndex]
                        : _titlesEmployee[appProvider.currentIndex],
                  );
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.deepPurple,
                selectedItemColor: AppColors.orange,
                selectedFontSize: 10,
                selectedIconTheme: const IconThemeData(size: 28),
                unselectedItemColor: Colors.grey.shade300,
                unselectedLabelStyle: const TextStyle(
                  color: AppColors.white,
                  fontSize: 8,
                ),
                items: employeeType == '1'
                    ? const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.people_alt_outlined),
                          label: 'Groups',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.notifications_none),
                          label: 'Notifications',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.work_outline),
                          label: 'Employees',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings_outlined),
                          label: 'Settings',
                        ),
                      ]
                    : [
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: notificationCount > 0
                              ? Badge(
                                  label: Text(
                                    '$notificationCount',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  child: const Icon(Icons.notifications_none),
                                )
                              : const Icon(Icons.notifications_none),
                          label: 'Notifications',
                        ),
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.settings_outlined),
                          label: 'Settings',
                        ),
                      ],
              ),
      ),
    );
  }

  void initEmployeeType() async {
    // get the employee type form the shared preferences
    final provider = context.watch<PreferenceProvider>();

    // get the employee type
    await provider.getData(Keys.userType);

    // set the employee type
    employeeType = provider.data ?? '';

    if (context.mounted) {
      await context
          .read<UserPreferenceProvider>()
          .getData(Keys.userName, Keys.userImg);
    }

    debugPrint('employeeType: $employeeType');
  }

  void initNotificationCount() async {
    final notificationCountProvider =
        context.watch<NotificationCountProvider>();

    if (employeeType == '2') {
      notificationCount = notificationCountProvider.count;
    }
  }
}
