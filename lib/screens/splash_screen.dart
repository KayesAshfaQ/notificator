import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/notification_count_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_info.dart';
import '../provider/preference_provider.dart';
import '../util/keys.dart';
import '../util/utils.dart';
import '../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  // this method will be called when the widget is loaded
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // TODO: Add on notification tap listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle background message
      _handleMessage(context, message);
    });

    final provider = context.read<AuthKeyProvider>();
    await provider.getUserToken();

    var routeName = kRouteLogin;

    if (kDebugMode) {
      print('userToken::: ${provider.userToken}');
    }

    // if user token exists, then navigate to home screen
    if (provider.userToken != null) {
      routeName = kRouteHome;

      // get the employee type
      initEmployeeTypeNotificationCount();
    } else {
      routeName = kRouteLogin;
    }

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        routeName,
      );
    });
  }

  void _handleMessage(BuildContext context, RemoteMessage message) {
    String screenName = message.data['screen_name'];
    String notificationId = message.data['notification_id'];
    Navigator.pushNamed(context, screenName, arguments: notificationId);
    // TODO: retrieve notification id and pass it to the notification details screen
  }

  /// this method is used to get the employee type from the shared preferences
  void initEmployeeTypeNotificationCount() async {
    // get the employee type form the shared preferences
    final provider = context.read<PreferenceProvider>();

    // get the employee type
    await provider.getData(Keys.userType);
    String? employeeType = provider.data;
    debugPrint('employeeType: ${provider.data}');

    // get the notification count for the employee type
    if (employeeType != null && employeeType == '2' && context.mounted) {
      final countProvider = context.read<NotificationCountProvider>();

      // get the user token
      String token = context.read<AuthKeyProvider>().userToken!;
      await countProvider.getCount(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Utils.backGroundImage,
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SvgPicture.asset(
                Assets.svgIconBellLarge,
                height: 72,
              ),
              const SizedBox(height: 12),
              Text(
                kAppTitle.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  color: AppColors.lightOrange,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Your personal reminder'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                height: 2.5,
                width: width * 0.2,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.lightOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
