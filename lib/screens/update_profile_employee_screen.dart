import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notificator/provider/home_employee_data_provider.dart';
import 'package:notificator/provider/logo_update_provider_employee.dart';
import 'package:notificator/provider/toast_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/home_admin_data_provider.dart';
import '../provider/image_pick_provider.dart';
import '../provider/preference_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
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
                const SeparatedLabeledTextField(
                  labelText: 'First Name',
                  hintText: 'Your First Name',
                ),
                const SizedBox(height: 16),
                const SeparatedLabeledTextField(
                  labelText: 'Last Name',
                  hintText: 'Your Last Name',
                ),
                const SizedBox(height: 16),
                const SeparatedLabeledTextField(
                  labelText: 'Email Address',
                  hintText: 'Your Email Address',
                ),
                const SizedBox(height: 16),
                const SeparatedLabeledTextField(
                  labelText: 'Phone Number',
                  hintText: 'Your Phone Number',
                ),
                const SizedBox(height: 24),
                /* const Text(
                  'Profile Picture',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.deepPurple,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.camera_alt_outlined),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: pickImage,
                      child: const Text(
                        'Upload Profile Picture',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.deepPurple,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.file(
                  _image ?? File(Assets.imgBellImage),
                  fit: BoxFit.cover,
                  height: 100,
                ),*/
                ElevatedButton(
                  onPressed: () {},
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

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("IMAGE_PATH:::" + pickedFile.path);

      setState(() {
        //_image = File(pickedFile.path);
      });
    }
  }
}
