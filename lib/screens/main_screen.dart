import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/provider/preference_provider.dart';
import 'package:notificator/screens/SettingScreen.dart';
import 'package:notificator/screens/admin_home_screen.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/group_screen.dart';
import 'package:notificator/screens/notification_screen.dart';
import 'package:notificator/util/utils.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../util/keys.dart';
import '../widgets/app_drawer_widget.dart';
import 'employee_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? employeeType;

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
    //AdminProfileScreen(),
    //GroupScreen(),
    NotificationScreen(),
    //EmployeeScreen(),
    SettingScreen(),
  ];

  // bottom navigation bar screens list for admin
  final List<Widget> _screensAdmin = const [
    AdminProfileScreen(),
    GroupScreen(),
    NotificationScreen(),
    EmployeeScreen(),
    SettingScreen(),
  ];

  final _itemsEmployee = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Badge(
        label: Text('12'),
        child: Icon(Icons.notifications_none),
      ),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
    ),
  ];

  final _itemsAdmin = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_alt_outlined),
      label: 'Groups',
    ),
    BottomNavigationBarItem(
      icon: Badge(
        label: Text('12'),
        child: Icon(Icons.notifications_none),
      ),
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
  ];

  @override
  void initState() {
    initEmployeeType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final currentIndex = appProvider.currentIndex;
    final title = appProvider.title;
    final width = MediaQuery.of(context).size.width;

    debugPrint('home_build');

    return WillPopScope(
      onWillPop: () {
        return Utils.closeConfirm(context);
      },
      child: Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            title,
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
        body: Center(
          child: employeeType == '1'
              ? _screensAdmin[currentIndex]
              : _screensEmployee[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              appProvider.setCurrentIndex(index);
              appProvider.setTitle(
                employeeType == '1'
                    ? _titlesAdmin[currentIndex]
                    : _titlesEmployee[currentIndex],
              );
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.deepPurple,
            selectedItemColor: AppColors.orange,
            selectedFontSize: 10,
            selectedIconTheme: const IconThemeData(size: 28),
            unselectedItemColor: Colors.grey.shade300,
            unselectedLabelStyle:
                const TextStyle(color: AppColors.white, fontSize: 8),
            items: employeeType == '1' ? _itemsAdmin : _itemsEmployee),
      ),
    );
  }

  void initEmployeeType() async {
    // get the employee type form the shared preferences
    final provider = context.read<PreferenceProvider>();

    // get the employee type
    await provider.getData(Keys.userType);

    // set the employee type
    employeeType = provider.data ?? '';

    debugPrint('employeeType: $employeeType');
  }
}
