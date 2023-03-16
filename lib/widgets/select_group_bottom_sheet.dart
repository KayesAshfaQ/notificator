import 'package:flutter/material.dart';
import 'package:notificator/widgets/multi_select_chip.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../model/group_list_response.dart';
import '../provider/group_chip_provider.dart';
import 'separated_labeled_text_field.dart';

class SelectGroupBottomSheet extends StatefulWidget {
  const SelectGroupBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectGroupBottomSheet> createState() => _SelectGroupBottomSheetState();
}

class _SelectGroupBottomSheetState extends State<SelectGroupBottomSheet> {
  @override
  Widget build(BuildContext context) {
    bool? v = false;
    //final myProvider = Provider.of<MyProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.2,
            maxChildSize: 0.65,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: Text(
                          'Choose Your Group *',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.deepPurple,
                            fontFamily: 'BaiJamjuree',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        controller: controller,
                        children: [
                          const SizedBox(height: 8),
                          const MultiSelectChip(),
                          const SizedBox(height: 8),
                          CommonPurpleButtonWidget(
                            title: 'Submit',
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            onPress: groupSelectSubmit,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void groupSelectSubmit() async {
    // when the submit button is pressed, the provider isSubmitted value is set to true
    final provider = context.read<GroupChipProvider>();

    String selectedGroupNames = '';
    String selectedGroupId = '';

    // loop through the selected groups list and get the group names
    for (GroupListResponseData group in provider.selectedGroupList) {
      //debugPrint(group.name);
      selectedGroupNames += '${group.name}, ';
      selectedGroupId += '${group.id}, ';
    }
    debugPrint(selectedGroupNames);
    // set the selected group name to the provider
    provider.setSelectedGroupName(selectedGroupNames);

    debugPrint(selectedGroupId);

    // set the selected group id to the provider
    provider.setSelectedGroupId(selectedGroupId);

    // hide the bottom sheet
    Navigator.of(context).pop();
  }
}

class CommonPurpleButtonWidget extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPress;

  const CommonPurpleButtonWidget({
    super.key,
    required this.title,
    required this.padding,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepPurple,
        padding: padding,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontFamily: 'BaiJamjuree',
        ),
      ),
    );
  }
}
