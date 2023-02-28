import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notificator/constants/routes.dart';

import '../constants/app_colors.dart';
import '../constants/app_info.dart';
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
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        kRouteLogin,
      );
    });
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
