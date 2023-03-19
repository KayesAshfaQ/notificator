import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/constants/app_info.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/app_provider.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/company_logo_update_provider.dart';
import 'package:notificator/provider/company_update_provider.dart';
import 'package:notificator/provider/employee_create_provider.dart';
import 'package:notificator/provider/employee_delete_provider.dart';
import 'package:notificator/provider/employee_list_provider.dart';
import 'package:notificator/provider/employee_update_provider.dart';
import 'package:notificator/provider/group_provider.dart';
import 'package:notificator/provider/forgot_pass_provider.dart';
import 'package:notificator/provider/group_delete_provider.dart';
import 'package:notificator/provider/group_list_provider.dart';
import 'package:notificator/provider/home_data_provider.dart';
import 'package:notificator/provider/image_pick_provider.dart';
import 'package:notificator/provider/login_provider.dart';
import 'package:notificator/provider/group_chip_provider.dart';
import 'package:notificator/provider/logout_provider.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/provider/password_change_provider.dart';
import 'package:notificator/provider/preference_provider.dart';
import 'package:notificator/provider/send_to_option_provider.dart';
import 'package:notificator/provider/setting_option_provider.dart';
import 'package:notificator/provider/toast_provider.dart';
import 'package:notificator/screens/setting_screen.dart';
import 'package:notificator/screens/change_password_screen.dart';
import 'package:notificator/screens/change_password_setting_screen.dart';
import 'package:notificator/screens/employee_create_screen.dart';
import 'package:notificator/screens/notification_create_screen.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/forget_password_screen.dart';
import 'package:notificator/screens/group_screen.dart';
import 'package:notificator/screens/main_screen.dart';
import 'package:notificator/screens/login_screen.dart';
import 'package:notificator/screens/more_details_screen.dart';
import 'package:notificator/screens/notification_details_screen.dart';
import 'package:notificator/screens/notification_screen.dart';
import 'package:notificator/screens/otp_screen.dart';
import 'package:notificator/screens/home_screen_employee.dart';
import 'package:notificator/screens/register_screen.dart';
import 'package:notificator/screens/splash_screen.dart';
import 'package:notificator/screens/update_profile_admin_screen.dart';
import 'package:notificator/screens/employee_update_screen.dart';
import 'package:notificator/screens/update_profile_employee_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // ensure bind
  WidgetsFlutterBinding.ensureInitialized();

  // run app with multi provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToastProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SendToOptionProvider()),
        ChangeNotifierProvider(create: (_) => SettingOptionProvider()),
        ChangeNotifierProvider(create: (_) => GroupChipProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AuthKeyProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPassProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => GroupListProvider()),
        ChangeNotifierProvider(create: (_) => GroupDeleteProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeCreateProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeListProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeDeleteProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        ChangeNotifierProvider(create: (_) => PassChangeProvider()),
        ChangeNotifierProvider(create: (_) => CompanyUpdateProvider()),
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider()),
        ChangeNotifierProvider(create: (_) => CompanyLogoUpdateProvider()),
        ChangeNotifierProvider(create: (_) => HomeDataProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeUpdateProvider()),
        ChangeNotifierProvider(create: (_) => NotificationListProvider()),
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
    return GlobalLoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.7),
      useDefaultLoading: false,
      closeOnBackButton: true,
      overlayWidget: const Center(
        child: SpinKitDoubleBounce(
          color: AppColors.lightOrange,
          size: 50.0,
        ),
      ),
      child: MaterialApp(
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
          kRouteEmployeeProfile: (context) => const EmployeeProfileScreen(),
          kRouteUpdateEmployeeProfile: (context) => const UpdateProfileScreen(),
          kRouteAdminProfile: (context) => const EmployeeProfileScreen(),
          kRouteUpdateAdminProfile: (context) => const UpdateAdminScreen(),
          kRouteGroups: (context) => const GroupScreen(),
          kRouteNotification: (context) => const NotificationScreen(),
          kRouteCreateNotification: (context) =>
              const CreateNotificationScreen(),
          kRouteNotificationDetails: (context) =>
              const NotificationDetailsScreen(),
          kRouteEmployees: (context) => const EmployeeScreen(),
          kRouteCreateEmployee: (context) => const CreateEmployeeScreen(),
          kRouteUpdateEmployee: (context) => const UpdateEmployeeScreen(),
          kRouteSetting: (context) => const SettingScreen(),
          kRouteSettingChangePass: (context) =>
              const SettingChangePasswordScreen(),
          kRouteMoreDetails: (context) => const MoreScreen(),
        },
        initialRoute: kRouteSplash,
      ),
    );
  }
}
