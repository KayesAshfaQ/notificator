import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/model/employee.dart';
import 'package:notificator/provider/employee_create_provider.dart';
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

class CreateEmployeeScreen extends StatefulWidget {
  const CreateEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    instantiate();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _groupController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GroupChipProvider>();
    _groupController.text = provider.selectedGroupName;

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

  /// show bottom sheet to select group
  void onTapSelectGroup() {

    // get the number of chips
    int chipsCount = context.read<GroupChipProvider>().groupList.length;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return  SelectGroupBottomSheet(count: chipsCount,);
      },
    );
  }

  /// create new employee
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
      String group = context.read<GroupChipProvider>().selectedGroupId;

      // create the employee obj
      Employee employee = Employee(
        firstName: fName,
        lastName: lName,
        email: email,
        position: position,
        groupId: group,
        password: password,
      );

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider & send data through it
      final provider = context.read<EmployeeCreateProvider>();
      await provider.create(employee, token!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('new employee created successfully');

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

  /// fetch all groups
  void instantiate() async {
    // Display a progress loader
    context.loaderOverlay.show();

    // initialize provider
    final provider = context.read<GroupListProvider>();

    // initialize group chip provider
    final groupChipProvider = context.read<GroupChipProvider>();
    groupChipProvider.clearSelectedGroups();

    // add listener to the provider
    /* groupChipProvider.addListener(() {
      // check if the submission was successful
      if (groupChipProvider.selectedGroupName?.isNotEmpty ?? false) {
        */ /*String selectedGroupNames = '';

        // loop through the selected groups list and get the group names
        for (GroupListResponseData group
            in groupChipProvider.selectedGroupList) {
          debugPrint(group.name);
          selectedGroupNames += '${group.name}, ';
        }*/ /*

        // set the selected group name to the group text field
        _groupController.text = groupChipProvider.selectedGroupName!;
      }
    });*/

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
