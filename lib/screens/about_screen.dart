import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notificator/constants/app_strings.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              const Text("About", style: TextStyle(color: AppColors.grey_80)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.grey_80),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Notificator",
              style: Utils.myTxtStyleTitleLarge,
            ),
            const SizedBox(height: 5),
            Container(width: 72, height: 3, color: AppColors.orange),
            const SizedBox(height: 15),
            Text("Version",
                style: Utils.myTxtStyleBodySmall
                    .copyWith(color: AppColors.grey_40)),
            Text("1.0.0",
                style: Utils.myTxtStyleBodyMedium
                    .copyWith(color: AppColors.grey_90)),
            const SizedBox(height: 15),
            Text("Last Update",
                style: Utils.myTxtStyleBodySmall
                    .copyWith(color: AppColors.grey_40)),
            Text("April 2023",
                style: Utils.myTxtStyleBodyMedium
                    .copyWith(color: AppColors.grey_90)),
            const SizedBox(height: 25),
            Text("Short Description",
                style: Utils.myTxtStyleBodySmall
                    .copyWith(color: AppColors.grey_40)),
            const SizedBox(height: 4),
            Text(
              AppStrings.appInfoShort,
              textAlign: TextAlign.justify,
              style:
                  Utils.myTxtStyleBodyMedium.copyWith(color: AppColors.grey_90),
            ),
          ],
        ),
      ),
    );
  }
}
