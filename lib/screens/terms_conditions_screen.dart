import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_strings.dart';
import 'package:notificator/provider/notification_get_provider.dart';
import 'package:notificator/util/date_helper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/widgets/my_appbar_widget.dart';

import '../util/helper.dart';
import '../util/utils.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Terms & Conditions'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /*RichText(
            text: TextSpan(
              text: 'Effective Date: ',
              style: Utils.myTxtStyleTitleExtraSmall,
              children: [
                TextSpan(
                  text: '21st April 2023',
                  style: Utils.myTxtStyleBodyExtraSmall.copyWith(
                    color: AppColors.lightOrange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),*/
           Text(
            AppStrings.termsOfServiceHead,
            style: Utils.myTxtStyleBodySmall.copyWith(color: AppColors.grey_90),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AppStrings.termsList.length,
            itemBuilder: (BuildContext context, int index) {
              return RichText(
                text: TextSpan(
                  text: '${index + 1}. ',
                  style: Utils.myTxtStyleTitleSmall.copyWith(
                    color: AppColors.grey_80,
                  ),
                  children: [
                    TextSpan(
                      text: '${AppStrings.termsList[index]} \n',
                      style: Utils.myTxtStyleBodySmall.copyWith(
                        color: AppColors.grey_60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );

              return ListTile(
                leading: const Icon(Icons.circle, size: 16),
                // Use any bullet icon you like
                title: Text(AppStrings.privacyList[index]),
              );
            },
          ),
          const SizedBox(height: 8),
           Text(
            AppStrings.termsOfServiceTail,
            style: Utils.myTxtStyleBodySmall.copyWith(color: AppColors.grey_90),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  void onTapLink(link) async {
    final linkUri = Uri.parse(link.url);

    if (await canLaunchUrl(linkUri)) {
      await launchUrl(
        linkUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $link';
    }
  }
}
