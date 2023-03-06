import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../widgets/create_group_bottom_sheet.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/employee_list_item_widget.dart';
import '../widgets/group_list_item_widget.dart';
import '../widgets/separated_labeled_text_field.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    return ListView(
      padding: const EdgeInsets.all(20),
      //shrinkWrap: true,
      //physics: const NeverScrollableScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ElevatedCreateButtonWidget(
            title: 'Create Group',
            icon: Icons.add_circle_outline,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: const CreateGroupBottomSheet(),
                    ),
                  );
                },
              );
            },
          ),
        ),
        /*const SizedBox(height: 24.0),
        const Text(
          'Groups You have created',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w600,
          ),
        ),*/
        const SizedBox(height: 24.0),
        ListView(
          shrinkWrap: true,
          cacheExtent: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            GroupListItemWidget(),
            GroupListItemWidget(),
            GroupListItemWidget(),
            GroupListItemWidget(),
            GroupListItemWidget(),
            GroupListItemWidget(),
          ],
        ),
      ],
    );
  }
}
