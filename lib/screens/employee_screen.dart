import 'package:flutter/material.dart';
import 'package:notificator/constants/routes.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../util/navigate_util.dart';
import '../widgets/elevated_create_button.dart';
import '../widgets/employee_list_item_widget.dart';
import 'create_employee_screen.dart';

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
        Align(
          alignment: Alignment.topRight,
          child: ElevatedCreateButtonWidget(
            title: 'Create Employee',
            icon: Icons.add_circle_outline,
            onPressed: () {
              //navigatePush(context, const CreateEmployeeScreen());

              Navigator.pushNamed(context, kRouteCreateEmployee);
            },
          ),
        ),
        const SizedBox(height: 24.0),
        const Text(
          'Employees You have created',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24.0),
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
