import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/constants/app_info.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/app_provider.dart';
import 'package:notificator/provider/auth_provider.dart';
import 'package:notificator/provider/send_to_option_provider.dart';
import 'package:notificator/provider/setting_option_provider.dart';
import 'package:notificator/screens/SettingScreen.dart';
import 'package:notificator/screens/change_password_screen.dart';
import 'package:notificator/screens/create_employee_screen.dart';
import 'package:notificator/screens/create_notification_screen.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/forget_password_screen.dart';
import 'package:notificator/screens/group_screen.dart';
import 'package:notificator/screens/home_screen.dart';
import 'package:notificator/screens/login_screen.dart';
import 'package:notificator/screens/notification_details_screen.dart';
import 'package:notificator/screens/notification_screen.dart';
import 'package:notificator/screens/otp_screen.dart';
import 'package:notificator/screens/profile_screen.dart';
import 'package:notificator/screens/register_screen.dart';
import 'package:notificator/screens/splash_screen.dart';
import 'package:notificator/screens/update_profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // ensure bind
  WidgetsFlutterBinding.ensureInitialized();

  // run app with multi provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SendToOptionProvider()),
        ChangeNotifierProvider(create: (_) => SettingOptionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

        // textFiled customization app wide
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.lightOrange,
          selectionColor: Color(0x40FE9027),
          selectionHandleColor: AppColors.lightOrange,
        ),
      ),
      routes: {
        kRouteSplash: (context) => const SplashScreen(),
        kRouteLogin: (context) => const LoginScreen(),
        kRouteRegister: (context) => const RegisterScreen(),
        kRouteOtp: (context) => const OtpScreen(),
        kRouteForgetPassword: (context) => const ForgetPasswordScreen(),
        kRouteChangePass: (context) => const ChangePasswordScreen(),
        kRouteHome: (context) => const HomeScreen(),
        kRouteProfile: (context) => const ProfileScreen(),
        kRouteUpdateProfile: (context) => const UpdateProfileScreen(),
        kRouteGroups: (context) => const GroupScreen(),
        kRouteNotification: (context) => const NotificationScreen(),
        kRouteCreateNotification: (context) => const CreateNotificationScreen(),
        kRouteNotificationDetails: (context) =>
            const NotificationDetailsScreen(),
        kRouteEmployees: (context) => const EmployeeScreen(),
        kRouteCreateEmployee: (context) => const CreateEmployeeScreen(),
        kRouteSetting: (context) => const SettingScreen(),
      },
      initialRoute: kRouteSplash,
    );
  }
}
