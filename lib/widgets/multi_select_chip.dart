import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/employee_chip_provider.dart';
import '../provider/group_chip_provider.dart';

class MultiSelectChip extends StatefulWidget {
  final bool isGroup;

  const MultiSelectChip({super.key, required this.isGroup});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  _buildChips(BuildContext context) {
    // list for storing chip widgets
    List<Widget> chips = [];
    if (widget.isGroup) {
      final provider = context.watch<GroupChipProvider>();

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
    }
    else {
      final provider = context.watch<EmployeeChipProvider>();

      // creating chips widget with employee names
      for (var item in provider.employeeList) {
        chips.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text('${item.firstName} ${item.lastName}'),
              avatar: provider.selectedEmployee.contains(item)
                  ? const Icon(
                Icons.check,
                color: AppColors.white,
                size: 16.0,
              )
                  : null,
              labelStyle: TextStyle(
                color: provider.selectedEmployee.contains(item)
                    ? AppColors.white
                    : AppColors.deepPurple,
                fontFamily: 'BaiJamjuree',
              ),
              selected: provider.selectedEmployee.contains(item),
              selectedColor: AppColors.deepPurple.withOpacity(0.75),
              padding: const EdgeInsets.all(4.0),
              onSelected: (selected) {
                // checks if the group is already selected or not and adds or removes it from the list
                provider.selectedEmployee.contains(item)
                    ? provider.removeFromSelectedEmployee(item)
                    : provider.addToSelectedEmployee(item);
              },
            ),
          ),
        );
      }
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
