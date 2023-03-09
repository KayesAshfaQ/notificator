import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/screens/SettingScreen.dart';
import 'package:notificator/screens/admin_profile_screen.dart';
import 'package:notificator/screens/create_employee_screen.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/group_screen.dart';
import 'package:notificator/screens/notification_screen.dart';
import 'package:notificator/screens/employee_profile_screen.dart';
import 'package:notificator/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../provider/app_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // bottom navigation bar titles list
  final List<String> _titles = const [
    'Home',
    'Groups',
    'Notifications',
    'Employees',
    'Settings',
  ];

  // bottom navigation bar screens list
  final List<Widget> _screens = const [
    //EmployeeProfileScreen(),
    AdminProfileScreen(),
    GroupScreen(),
    NotificationScreen(),
    EmployeeScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final currentIndex = appProvider.currentIndex;
    final title = appProvider.title;

    print('home_build');

    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w500,
          ),
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/img/appbar-background.png'),
          fit: BoxFit.cover,
        ),
       /* leading: const Icon(
          Icons.menu,
          color: AppColors.orange,
        ),*/
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(16), // Image radius
                child: RandomAvatar(
                  'name',
                  height: 50,
                  width: 50,
                ), /*Image.network('imageUrl', fit: BoxFit.cover),*/
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          appProvider.setCurrentIndex(index);
          appProvider.setTitle(_titles[index]);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.deepPurple,
        selectedItemColor: AppColors.orange,
        selectedFontSize: 10,
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedItemColor: Colors.grey.shade400,
        unselectedLabelStyle:
            const TextStyle(color: AppColors.white, fontSize: 8),
        items: const [
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
            icon: Icon(Icons.work),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // TODO: Add code to handle item 1 being tapped.
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // TODO: Add code to handle item 2 being tapped.
              },
            ),
          ],
        ),
      ),
    );
  }
}
