import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/constants/app_info.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/app_provider.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/email_config_provider.dart';
import 'package:notificator/provider/employee_search_provider.dart';
import 'package:notificator/provider/forgot_code_provider.dart';
import 'package:notificator/provider/logo_update_provider_company.dart';
import 'package:notificator/provider/company_update_provider.dart';
import 'package:notificator/provider/employee_create_provider.dart';
import 'package:notificator/provider/employee_delete_provider.dart';
import 'package:notificator/provider/employee_list_provider.dart';
import 'package:notificator/provider/employee_update_provider.dart';
import 'package:notificator/provider/group_provider.dart';
import 'package:notificator/provider/forgot_pass_provider.dart';
import 'package:notificator/provider/group_delete_provider.dart';
import 'package:notificator/provider/group_list_provider.dart';
import 'package:notificator/provider/home_admin_data_provider.dart';
import 'package:notificator/provider/home_employee_data_provider.dart';
import 'package:notificator/provider/image_pick_provider.dart';
import 'package:notificator/provider/login_provider.dart';
import 'package:notificator/provider/group_chip_provider.dart';
import 'package:notificator/provider/logo_update_provider_employee.dart';
import 'package:notificator/provider/logout_provider.dart';
import 'package:notificator/provider/notification_create_provider.dart';
import 'package:notificator/provider/notification_get_provider.dart';
import 'package:notificator/provider/notification_list_provider.dart';
import 'package:notificator/provider/password_change_provider.dart';
import 'package:notificator/provider/preference_provider.dart';
import 'package:notificator/provider/send_to_option_provider.dart';
import 'package:notificator/provider/setting_data_get_provider.dart';
import 'package:notificator/provider/setting_data_post_provider.dart';
import 'package:notificator/provider/setting_option_provider.dart';
import 'package:notificator/provider/toast_provider.dart';
import 'package:notificator/provider/user_preference_provider.dart';
import 'package:notificator/screens/email_config_screen.dart';
import 'package:notificator/screens/setting_screen_admin.dart';
import 'package:notificator/screens/change_password_screen.dart';
import 'package:notificator/screens/change_password_setting_screen.dart';
import 'package:notificator/screens/employee_create_screen.dart';
import 'package:notificator/screens/notification_create_screen.dart';
import 'package:notificator/screens/employee_screen.dart';
import 'package:notificator/screens/forgot_password_screen.dart';
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
import 'package:rxdart/rxdart.dart';

import 'firebase_options.dart';

// TODO: Add stream controller
// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

// TODO: Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  // ensure bind
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: Request permission
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // TODO: Register with FCM
  // It requests a registration token for sending messages to users from your App server or other trusted server environment.
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  // TODO: Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });

  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        ChangeNotifierProvider(create: (_) => HomeAdminDataProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeUpdateProvider()),
        ChangeNotifierProvider(create: (_) => NotificationListProvider()),
        ChangeNotifierProvider(create: (_) => NotificationCreateProvider()),
        ChangeNotifierProvider(create: (_) => HomeEmployeeDataProvider()),
        ChangeNotifierProvider(create: (_) => EmployeePhotoUpdateProvider()),
        ChangeNotifierProvider(create: (_) => NotificationDetailsProvider()),
        ChangeNotifierProvider(create: (_) => EmailConfigProvider()),
        ChangeNotifierProvider(create: (_) => SettingDataGetProvider()),
        ChangeNotifierProvider(create: (_) => SettingDataSendProvider()),
        ChangeNotifierProvider(create: (_) => ForgotCodeProvider()),
        ChangeNotifierProvider(create: (_) => UserPreferenceProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeSearchProvider()),
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
    if (kDebugMode) {
      print('App started');
    }

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
          kRouteSetting: (context) => const SettingAdminScreen(),
          kRouteSettingChangePass: (context) =>
              const SettingChangePasswordScreen(),
          kRouteEmailConfig: (context) => const EmailConfigScreen(),
          kRouteMoreDetails: (context) => const MoreScreen(),
        },
        initialRoute: kRouteSplash,
      ),
    );
  }
}
