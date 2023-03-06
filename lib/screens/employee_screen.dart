import 'package:flutter/material.dart';
import 'package:notificator/constants/routes.dart';

import '../widgets/elevated_create_button.dart';
import '../widgets/employee_list_item_widget.dart';
import '../widgets/outlined_button_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    return ListView(
      padding: const EdgeInsets.all(20),
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const OutlinedButtonWidget(
              label: 'Sort By',
              icon: Icons.sort,
            ),
            const SizedBox(width: 4),
            const OutlinedButtonWidget(
              label: 'Filter',
              icon: Icons.filter_list,
            ),
            const Spacer(),
            ElevatedCreateButtonWidget(
              title: 'Create Employee',
              icon: Icons.add_circle_outline,
              onPressed: () {
                //navigatePush(context, const CreateEmployeeScreen());

                Navigator.pushNamed(context, kRouteCreateEmployee);
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ListView(
          shrinkWrap: true,
          cacheExtent: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            EmployeeListItemWidget(),
            EmployeeListItemWidget(),
            EmployeeListItemWidget(),
            EmployeeListItemWidget(),
            EmployeeListItemWidget(),
            EmployeeListItemWidget(),
          ],
        ),
      ],
    );
  }
}
