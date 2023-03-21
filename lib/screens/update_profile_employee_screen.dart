import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/home_employee_data_provider.dart';
import 'package:notificator/provider/logo_update_provider_employee.dart';
import 'package:notificator/provider/toast_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../model/employee.dart';
import '../provider/employee_update_provider.dart';
import '../provider/image_pick_provider.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
import '../util/utils.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/update_img_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? token;
  ToastProvider? toastProvider;
  String? employeeId;
  String? userId;

  @override
  void initState() {
    // initialize data
    initTextFields();
    initToken();
    initToastProvider();
    fetchCachedData();

    super.initState();
  }

  /// initialize text fields
  void initTextFields() {
    // as the data is fetched from the server and stored in the provider in the previous screen
    final employee = context.read<HomeEmployeeDataProvider>().employee;

    _firstNameController.text = employee.firstName ?? '';
    _lastNameController.text = employee.lastName ?? '';
    _emailController.text = employee.email ?? '';
    _phoneController.text = employee.phone ?? '';
  }

  /// initialize token
  void initToken() async {
    token ??= await Helper.getToken(context);
  }

  /// initialize toast provider
  void initToastProvider() {
    if (toastProvider == null) {
      toastProvider = context.read<ToastProvider>();
      toastProvider?.initialize(context);
    }
  }

  /// fetch cached data from shared preferences
  void fetchCachedData() async {
    final prefProvider = context.read<PreferenceProvider>();

    await prefProvider.getData(Keys.userID);
    userId = prefProvider.data!;

    //await prefProvider.getData(Keys.userType);

    await prefProvider.getData(Keys.userID);

    employeeId = prefProvider.data!;
    print('employeeId:::$employeeId');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // image provider for the image picker
    final imgProvider = context.watch<ImagePickProvider>();

    final photoUpdateProvider = context.read<EmployeePhotoUpdateProvider>();

    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Update profile',
      ),
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
                /* const Text(
                  'Update Your Profile',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.deepPurple,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),*/
                Center(
                  child: UpdateImgWidget(
                    image: imgProvider.image,
                    onTap: () async {
                      // pick image from gallery though image picker
                      final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );

                      // when the image is picked set the image to the provider
                      if (pickedFile != null) {
                        debugPrint("IMAGE_PATH:::${pickedFile.path}");

                        imgProvider.setImage(File(pickedFile.path));

                        // after image shown in the widget
                        // upload it to the server

                        if (token != null && employeeId != null) {
                          await photoUpdateProvider.update(
                            token!,
                            employeeId!,
                            imgProvider.image!,
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                SeparatedLabeledTextField(
                  controller: _firstNameController,
                  labelText: 'First Name',
                  hintText: 'Your First Name',
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _lastNameController,
                  labelText: 'Last Name',
                  hintText: 'Your Last Name',
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'Your Email Address',
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: 'Your Phone Number',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: updateEmployeeInfo,
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
                    'Update Profile',
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

  /*void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("IMAGE_PATH:::" + pickedFile.path);

      setState(() {
        //_image = File(pickedFile.path);
      });
    }
  }*/

  /// update the employee
  void updateEmployeeInfo() async {
    // validate form
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get the filed texts
      String fName = _firstNameController.text.trim();
      String lName = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String phone = _phoneController.text.trim();
      //String password = _passwordController.text.trim();
      //String group = context.read<GroupChipProvider>().selectedGroupId;

      // create the employee obj
      Employee employee = Employee(
        firstName: fName,
        lastName: lName,
        email: email,
        phone: phone,
      );

      // initialize toast provider
      initToastProvider();

      // initialize token
      initToken();

      if (token == null || employeeId == null) {
        return;
      }
      // call the rest api through provider & send data through it
      final provider = context.read<EmployeeUpdateProvider>();
      await provider.updateByEmployee(employee, token!, employeeId!);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider?.showSuccessToast('new employee Updated successfully');

        // hide the bottom sheet
        if (context.mounted) Navigator.pop(context);
      } else {
        // Display an error toast
        toastProvider?.showErrorToast(provider.error);
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
