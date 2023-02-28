import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../constants/app_info.dart';
import '../constants/routes.dart';
import '../generated/assets.dart';
import '../util/utils.dart';
import '../widgets/text_input_field.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                  'Create an account',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  //width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldWidget(hintText: 'Company Name'),
                ),
                const SizedBox(height: 12),
                Container(
                  //width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldWidget(hintText: 'First Name'),
                ),
                const SizedBox(height: 12),
                Container(
                  //width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldWidget(hintText: 'Last Name'),
                ),
                const SizedBox(height: 12),
                Container(
                  //width: 300,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldWidget(hintText: 'Email Address'),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const TextFieldPasswordWidget(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.orange;
                            } else {
                              return AppColors.white;
                            }
                          },
                        ),
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        width: width - 96,
                        child: const Text(
                          'I agree to the Terms of Service and Privacy Policy',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BaiJamjuree',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: WhiteButtonWidget(
                    label: 'Register',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'BaiJamjuree',
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, kRouteLogin);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BaiJamjuree',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
