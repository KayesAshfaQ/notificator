import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/notification_get_provider.dart';
import 'package:notificator/util/date_helper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/widgets/my_appbar_widget.dart';

import '../util/helper.dart';
import '../util/utils.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  int i = 0;
  NotificationDetailsProvider? provider;

  @override
  Widget build(BuildContext context) {
    // do the following only once
    if (i == 0) {
      // Get the current route's settings
      final settings = ModalRoute.of(context)?.settings;

      // Access the arguments property and cast it to the Person class
      final notificationId = settings?.arguments as String?;

      provider ??= context.watch<NotificationDetailsProvider>();

      // fetch the notification details data
      if (notificationId != null) {
        fetchNotificationDetails(notificationId, provider!);
      }

      i++;
      print('NotificationDetailsScreen: build()');
    }

    print(i);

    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Notification Details'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            DateTimeHelper.convertDatetime(provider?.data?.updatedAt),
            style: Utils.myTxtStyleBodyExtraSmall,
          ),
          const SizedBox(height: 4),
          Text(
            //'We have meeting with our client today with USA team',
            provider?.data?.subject ?? '',
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
                  text: provider?.data?.groupIndividualName ?? '',
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
            text: provider?.data?.message ?? '',
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

  fetchNotificationDetails(
    String id,
    NotificationDetailsProvider provider,
  ) async {
    // show overlay
    context.loaderOverlay.show();

    // get token
    String token = await Helper.getToken(context);

    // get data from server
    await provider.getData(
      token,
      id,
    );

    // hide overlay
    if (context.mounted) context.loaderOverlay.hide();
  }
}
