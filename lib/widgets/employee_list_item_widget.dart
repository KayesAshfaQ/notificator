import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import 'round_icon_button_widget.dart';

class EmployeeListItemWidget extends StatelessWidget {
  const EmployeeListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.deepPurple,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // SnackBar snackBar = const SnackBar(content: Text('Employee clicked'));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('Employee clicked');
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            //margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: const Color(0x4DEFDEFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20), // Image radius
                    child: RandomAvatar(
                      'name',
                    ), /*Image.network('imageUrl', fit: BoxFit.cover),*/
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Designer',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.deepPurple,
                        fontFamily: 'BaiJamjuree',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundIconButtonWidget(
                        icon: Icons.change_circle,
                        onPressed: () {
                          // SnackBar snackBar = const SnackBar(content: Text('Update clicked'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print('Update clicked');
                        },
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Update',
                        size: 24,
                        color: AppColors.orange,
                      ),
                      RoundIconButtonWidget(
                        icon: Icons.remove_circle,
                        onPressed: () {
                          // SnackBar snackBar = const SnackBar(content: Text('Remove clicked'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print('Remove clicked');
                        },
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Remove',
                        size: 24,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
