import 'package:flutter/material.dart';
import 'package:notificator/provider/employee_chip_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/group_chip_provider.dart';

class SingleSelectChip extends StatefulWidget {
  const SingleSelectChip({super.key});

  @override
  _SingleSelectChipState createState() => _SingleSelectChipState();
}

class _SingleSelectChipState extends State<SingleSelectChip> {
  _buildChips(BuildContext context) {
    final provider = context.watch<EmployeeChipProvider>();

    // list for storing chip widgets
    List<Widget> chips = [];

    // creating chips widget with group names
    for (var item in provider.employeeList) {
      chips.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            label: Text('${item.firstName} ${item.lastName}'),
            avatar: provider.selectedEmployee == item
                ? const Icon(
              Icons.check,
              color: AppColors.white,
              size: 16.0,
            )
                : null,
            labelStyle: TextStyle(
              color: provider.selectedEmployee == item
                  ? AppColors.white
                  : AppColors.deepPurple,
              fontFamily: 'BaiJamjuree',
            ),
            selected: provider.selectedEmployee == item,
            selectedColor: AppColors.deepPurple.withOpacity(0.75),
            padding: const EdgeInsets.all(4.0),
            onSelected: (selected) {
              if (selected) {
                // deselect previously selected group
                if (provider.selectedEmployee != null) {
                  provider.removeSelectedEmployee();
                }
                provider.setSelectedEmployee(item);
              } else {
                provider.removeSelectedEmployee();
              }
            },
          ),
        ),
      );
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChips(context),
    );
  }
}
