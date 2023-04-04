import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notificator/constants/app_strings.dart';

import '../constants/app_colors.dart';
import '../util/my_text.dart';

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
              style: TextStyle(
                color: AppColors.deepPurple,
                fontSize: 32.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Container(width: 100, height: 3, color: AppColors.orange),
            const SizedBox(height: 15),
            Text("Version",
                style:
                    MyText.body1(context)!.copyWith(color: AppColors.grey_40)),
            Text("1.0.0",
                style:
                    MyText.medium(context).copyWith(color: AppColors.grey_90)),
            const SizedBox(height: 15),
            Text("Last Update",
                style:
                    MyText.body1(context)!.copyWith(color: AppColors.grey_40)),
            Text("April 2023",
                style:
                    MyText.medium(context).copyWith(color: AppColors.grey_90)),
            const SizedBox(height: 25),
            Text("Short Description",
                style:
                    MyText.body1(context)!.copyWith(color: AppColors.grey_40)),
            const SizedBox(height: 4),
            Text(AppStrings.appInfoShort,
                textAlign: TextAlign.justify,
                style:
                    MyText.medium(context).copyWith(color: AppColors.grey_90)),
          ],
        ),
      ),
    );
  }
}
