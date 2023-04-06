import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/util/utils.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../generated/assets.dart';
import '../provider/auth_key_provider.dart';
import '../provider/loader_provider.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  NoInternetScreenState createState() => NoInternetScreenState();
}

class NoInternetScreenState extends State<NoInternetScreen> {
  LoaderProvider? provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<LoaderProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(color: Colors.white),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 280,
          child: Stack(
            children: <Widget>[
              provider?.finishLoading ?? true
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(Assets.imgNoInternet,
                            width: 250, height: 250),
                        Text("Whoops!",
                            style: Utils.myTxtStyleTitleMedium.copyWith(
                                color: AppColors.deepPurple,
                                fontWeight: FontWeight.bold)),
                        Container(height: 10),
                        Text(
                            "No internet connections found. Check your connection or try again",
                            textAlign: TextAlign.center,
                            style: Utils.myTxtStyleBodySmall
                                .copyWith(color: AppColors.deepPurple)),
                        Container(height: 25),
                        SizedBox(
                          width: 180,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text("RETRY",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              provider?.setLoading(false);
                              delayShowingContent();
                            },
                          ),
                        )
                      ],
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void delayShowingContent() {
    Future.delayed(const Duration(seconds: 2), () async {
      String? routeName = await instantiate();

      if (routeName != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(
            context,
            routeName,
          );
        });
      }

      provider?.setLoading(true);
    });
  }

  Future<String?> instantiate() async {
    final provider = context.read<AuthKeyProvider>();

    // get the user token
    await provider.getUserToken();

    String? routeName;

    if (kDebugMode) {
      print('userToken::: ${provider.userToken}');
    }

    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      // if user token exists, then navigate to home screen
      if (provider.userToken != null) {
        routeName = kRouteHome;
      } else {
        routeName = kRouteLogin;
      }
    }

    return routeName;
  }
}
