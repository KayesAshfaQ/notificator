import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Create Employee'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          //height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Employees',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24.0),
              const SeparatedLabeledTextField(
                labelText: 'First Name',
                hintText: 'Employee First Name',
              ),
              const SizedBox(height: 16),
              const SeparatedLabeledTextField(
                labelText: 'Last Name',
                hintText: 'Employee Last Name',
              ),
              const SizedBox(height: 16),
              const SeparatedLabeledTextField(
                labelText: 'Email Address',
                hintText: 'Employee Email Address',
              ),
              const SizedBox(height: 16),
              const SeparatedLabeledTextField(
                labelText: 'Position',
                hintText: 'Employee Position',
              ),
              const SizedBox(height: 16),
              const SeparatedLabeledTextField(
                labelText: 'Password',
                hintText: 'Employee Password',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text(
                  'Create Employee',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'BaiJamjuree',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
