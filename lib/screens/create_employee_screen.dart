import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/provider/employee_create_provider.dart';
import 'package:provider/provider.dart';

import '../provider/auth_key_provider.dart';
import '../util/utils.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/toast_widget.dart';

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  late final FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Create Employee'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          //height: double.infinity,
          child: Form(
            key: _formKey,
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
                SeparatedLabeledTextField(
                  controller: _firstNameController,
                  labelText: 'First Name',
                  hintText: 'Employee First Name',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  hintText: 'Employee Last Name',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'Employee Email Address',
                  validator: (value) {
                    final bool emailValid = Utils.emailRegex.hasMatch(value);

                    if (value == null) {
                      return 'Please enter your email';
                    } else if (!emailValid) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _positionController,
                  labelText: 'Position',
                  hintText: 'Employee Position',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Employee Password',
                  isPassword: true,
                  validator: Utils.validatePassword,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: createEmployee,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
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
      ),
    );
  }

  void createEmployee() async {
    // validate form
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get the filed texts
      String fName = _firstNameController.text.trim();
      String lName = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String position = _positionController.text.trim();
      String password = _passwordController.text.trim();

      // create the employee obj
      Employee employee = Employee(
        firstName: fName,
        lastName: lName,
        email: email,
        position: position,
        password: password,
      );

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider & send data through it
      final provider = context.read<EmployeeCreateProvider>();
      await provider.create(employee, token!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        fToast.showToast(
          child: const ToastWidget(
            message: 'new employee created successfully',
            iconData: Icons.check,
            backgroundColor: Colors.green,
          ),
        );

        // hide the bottom sheet
        if (context.mounted) Navigator.pop(context);
      } else {
        // Display an error toast
        fToast.showToast(
          child: ToastWidget(
            message: provider.error,
            iconData: Icons.error_outline,
            backgroundColor: Colors.red,
          ),
          //toastDuration: const Duration(seconds: 20),
        );
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
