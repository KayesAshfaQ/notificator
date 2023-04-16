import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/provider/employee_update_provider.dart';
import 'package:provider/provider.dart';

import '../model/group_list_response.dart';
import '../provider/auth_key_provider.dart';
import '../provider/group_chip_provider.dart';
import '../provider/group_list_provider.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../util/utils.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/select_group_bottom_sheet.dart';
import '../widgets/separated_labeled_text_field.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  const UpdateEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<UpdateEmployeeScreen> createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();

  int? employeeId;
  int i = 0;

  //final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // instantiate the controllers only once when the screen is loaded for the first time
    if (i == 0) {
      instantiate();
      i++;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _groupController.dispose();
    //_passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GroupChipProvider>();

    if (provider.selectedGroupName.isNotEmpty) {
      _groupController.text = provider.selectedGroupName;
    }

    print(
        'UpdateEmployee_ScreenSelectedGroupName::: ${provider.selectedGroupName}');

    return Scaffold(
      appBar: const MyAppBarWidget(title: 'Update Employee'),
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
                /*const Text(
                  'Update Employees',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.deepPurple,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w600,
                  ),
                ),*/
                const SizedBox(height: 8.0),
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

                // assign group field
                const SizedBox(height: 16),
                const Text(
                  'Group',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.deepPurple,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: onTapSelectGroup,
                  child: TextField(
                    controller: _groupController,
                    enabled: false,
                    style: const TextStyle(
                      color: AppColors.deepPurple,
                      fontFamily: 'BaiJamjuree',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Select Group',
                      hintStyle: TextStyle(
                        color: AppColors.deepPurple.withOpacity(0.5),
                        fontFamily: 'BaiJamjuree',
                      ),
                      filled: true,
                      fillColor: AppColors.deepPurple.withOpacity(0.1),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.deepPurple,
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 16),
                // SeparatedLabeledTextField(
                //   controller: _passwordController,
                //   labelText: 'Password',
                //   hintText: 'Employee Password',
                //   isPassword: true,
                //   validator: Utils.validatePassword,
                // ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: updateEmployee,
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
                    'Update Employee',
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

  /// show bottom sheet to select group
  void onTapSelectGroup() {
    // get the number of chips
    int chipsCount = context.read<GroupChipProvider>().groupList.length;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectGroupBottomSheet(
          count: chipsCount,
        );
      },
    );
  }

  /// update the employee
  void updateEmployee() async {
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
      //String password = _passwordController.text.trim();
      String group = context.read<GroupChipProvider>().selectedGroupId;

      // create the employee obj
      Employee employee = Employee(
        firstName: fName,
        lastName: lName,
        email: email,
        position: position,
        groupId: group,
      );

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider & send data through it
      final provider = context.read<EmployeeUpdateProvider>();
      await provider.updateByAdmin(employee, token!, employeeId!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('new employee Updated successfully');

        // hide the bottom sheet
        if (context.mounted) Navigator.pop(context);
      } else {
        // Display an error toast
        toastProvider.showErrorToast(provider.error);
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }

  /// instantiate the text fields with the employee data
  void instantiate() async {
    // Get the current route's settings
    final settings = ModalRoute.of(context)?.settings;

    // Access the arguments property and cast it to the Person class
    final employee = settings?.arguments as Employee?;

    employeeId = employee?.id;
    _firstNameController.text = employee?.firstName ?? '';
    _lastNameController.text = employee?.lastName ?? '';
    _emailController.text = employee?.email ?? '';
    _positionController.text = employee?.position ?? '';
    _groupController.text = employee?.groupName ?? '';
    print('UpdateEmployee_employee_groupName::: ${employee?.groupName}');
  }

  /// fetch all groups
  void fetchData() async {
    // Display a progress loader
    context.loaderOverlay.show();

    // initialize provider
    final provider = context.read<GroupListProvider>();

    // initialize group chip provider
    final groupChipProvider = context.read<GroupChipProvider>();
    groupChipProvider.clearSelectedGroups();

    // get token through provider
    String token = await Helper.getToken(context);

    //call the rest api to fetch groups
    await provider.getList(token);

    // check if the submission was successful
    if (provider.success) {
      debugPrint('groups fetched successfully');

      // initialize the global groups list with the fetched data
      List<GroupListResponseData>? groups = provider.data;

      if (groups != null && groups.isNotEmpty) {
        // populate the groups list of group chip provider
        groupChipProvider.setGroupList(groups);
      }
    } else {
      // Display an error toast
      debugPrint(provider.error);
    }

    // Hide the progress loader
    if (context.mounted) context.loaderOverlay.hide();
  }
}
