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
            width: width * 0.16,
            child: Text(
              title,
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
          Text(data, style: Utils.myTxtStyleBodySmall),
        ],
      ),
    );
  }
}
