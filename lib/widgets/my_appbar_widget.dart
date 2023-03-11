import 'package:flutter/material.dart';
import 'package:notificator/util/utils.dart';

import '../constants/app_colors.dart';

class MyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  const MyAppBarWidget({
    Key? key,
    this.title = 'Notificator',
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.deepPurple,
      title: Text(
        title,
        style: Utils.myTxtStyleTitleMedium.copyWith(
          color: AppColors.white,
        ),
      ),
      flexibleSpace: const Image(
        image: AssetImage('assets/img/appbar-background.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
