import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/widgets/my_appbar_widget.dart';

import '../util/utils.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  // TODO: get data from server

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Notification Details'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('20 February 2023, 10:00 AM',
              style: Utils.myTxtStyleBodyExtraSmall),
          const SizedBox(height: 4),
          const Text(
            'We have meeting with our client today with USA team',
            style: Utils.myTxtStyleTitleMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: 'Send To: ',
              style: Utils.myTxtStyleTitleExtraSmall,
              children: [
                TextSpan(
                  text: 'John Doe',
                  style: Utils.myTxtStyleBodyExtraSmall.copyWith(
                    color: AppColors.lightOrange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Linkify(
            onOpen: onTapLink,
            text: Utils.dummyText,
            style: Utils.myTxtStyleBodySmall.copyWith(
              fontSize: 14,
            ),
            linkStyle: Utils.myTxtStyleBodySmall.copyWith(
              fontSize: 14,
              color: AppColors.lightOrange,
            ),
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
