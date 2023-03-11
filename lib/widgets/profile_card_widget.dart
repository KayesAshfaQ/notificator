import 'package:flutter/material.dart';

import '../util/utils.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.width,
    required this.title,
    required this.data,
  });

  final double width;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.2,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Utils.myTxtStyleTitleSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              ':',
              style: Utils.myTxtStyleTitleSmall,
            ),
          ),
          SizedBox(
            width: width * 0.63,
            child: Text(data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Utils.myTxtStyleBodySmall),
          ),
        ],
      ),
    );
  }
}
