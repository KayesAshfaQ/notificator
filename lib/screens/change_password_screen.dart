import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/generated/assets.dart';

import '../constants/app_info.dart';
import '../widgets/text_input_field.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';
import 'forget_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svgIconBellLarge,
                  height: 50,
                ),
                const SizedBox(height: 4),
                Text(
                  kAppTitle.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.lightOrange,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Your personal reminder'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldPasswordWidget(
                    hintText: 'Current Password',
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldPasswordWidget(
                    hintText: 'New Password',
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldPasswordWidget(
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: WhiteButtonWidget(
                    label: 'Update Password',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
