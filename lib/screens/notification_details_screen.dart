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
  late final NotificationDetailsProvider provider;

  @override
  void initState() {
    // initialize the provider
    provider = context.read<NotificationDetailsProvider>();

    // clear the data when the screen is initialized
    provider.clearData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    instantiate();
    super.didChangeDependencies();
  }

  void instantiate() async {
    // Get the current route's settings
    final settings = ModalRoute.of(context)?.settings;

    // Access the arguments property and cast it to the Person class
    final String id = settings?.arguments as String;

    // get token
    String token = await Helper.getToken(context);

    // fetch the notification details data from server
    if (id != null) {

      // String id = data['id'] ?? '';
      // String userType = data['userType'] ?? '';

      await provider.getData(token, id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Notification Details'),
      body: Consumer<NotificationDetailsProvider>(
          builder: (context, provider, child) {
        if (provider.data == null) {
          // show the loader overlay when the data is null
          context.loaderOverlay.show();

          return const SizedBox();
        } else {
          // hide the loader overlay
          context.loaderOverlay.hide();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                DateTimeHelper.convertDatetime(provider.data?.updatedAt),
                style: Utils.myTxtStyleBodyExtraSmall,
              ),
              const SizedBox(height: 4),
              Text(
                //'We have meeting with our client today with USA team',
                provider.data?.subject ?? '',
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
                      text: provider.data?.groupIndividualName ?? '',
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
                text: provider.data?.message ?? '',
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
          );
        }
      }),
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
