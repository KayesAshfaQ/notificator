import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/group_chip_provider.dart';

class MultiSelectChip extends StatefulWidget {
  const MultiSelectChip({super.key});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChips(BuildContext context) {
    final provider = context.watch<GroupChipProvider>();

    // list for storing chip widgets
    List<Widget> chips = [];

    // creating chips widget with group names
    for (var item in provider.groupList) {
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            label: Text(item.name),
            avatar: provider.selectedGroupList.contains(item)
                ? const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 16.0,
                  )
                : null,
            labelStyle: TextStyle(
              color: provider.selectedGroupList.contains(item)
                  ? AppColors.white
                  : AppColors.deepPurple,
              fontFamily: 'BaiJamjuree',
            ),
            selected: provider.selectedGroupList.contains(item),
            selectedColor: AppColors.deepPurple.withOpacity(0.75),
            padding: const EdgeInsets.all(4.0),
            onSelected: (selected) {
              // checks if the group is already selected or not and adds or removes it from the list
              provider.selectedGroupList.contains(item)
                  ? provider.removeFromSelectedGroup(item)
                  : provider.addToSelectedGroup(item);
            },
          ),
        ),
      );
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    //final selectedGroups = context.watch<GroupChipProvider>().selectedGroupList;

    return Wrap(
      children: _buildChips(context),
    );
  }
}
