import 'package:flutter/material.dart';
import 'package:notificator/provider/employee_chip_provider.dart';
import 'package:notificator/widgets/multi_select_chip.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../util/helper.dart';

class SelectEmployeeBottomSheet extends StatefulWidget {
  final int count;

  const SelectEmployeeBottomSheet({Key? key, required this.count})
      : super(key: key);

  @override
  State<SelectEmployeeBottomSheet> createState() =>
      _SelectEmployeeBottomSheetState();
}

class _SelectEmployeeBottomSheetState extends State<SelectEmployeeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // calculate the height of the bottom sheet
    final chipHeight = ((widget.count / 3) * 50.0) + 200;
    final height = MediaQuery.of(context).size.height;

    final sheetHeight = chipHeight / height;
    debugPrint('chipHeight: $chipHeight');
    debugPrint('height: $height');
    debugPrint('height / chipHeight: ${chipHeight / height}');

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: sheetHeight,
            minChildSize: sheetHeight,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      controller: controller,
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.grey[600],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              'Select employee *',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.deepPurple,
                                fontFamily: 'BaiJamjuree',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const MultiSelectChip(
                          isGroup: false,
                        ),
                        //const SingleSelectChip(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CommonPurpleButtonWidget(
                        title: 'Submit',
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onPress: employeeSelectSubmit,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void employeeSelectSubmit() async {
    // when the submit button is pressed, the provider isSubmitted value is set to true
    final provider = context.read<EmployeeChipProvider>();

    //clear the selected group name and id
    provider.setSelectedEmplyeeName('');
    provider.setSelectedEmployeeId('');

    String selectedGroupNames = '';
    String selectedGroupId = '';

    // loop through the selected groups list and get the group names
    for (var employee in provider.selectedEmployee) {
      //debugPrint(group.name);
      selectedGroupNames += '${employee.firstName} ${employee.lastName}, ';
      selectedGroupId += '${employee.userId}, ';
    }

    // remove the last comma
    selectedGroupNames = Helper.removeLastComma(selectedGroupNames);
    selectedGroupId = Helper.removeLastComma(selectedGroupId);

    debugPrint(selectedGroupNames);
    // set the selected group name to the provider
    provider.setSelectedEmplyeeName(selectedGroupNames);

    debugPrint(selectedGroupId);

    // set the selected group id to the provider
    provider.setSelectedEmployeeId(selectedGroupId);

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
