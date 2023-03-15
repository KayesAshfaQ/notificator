import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/company_update_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../model/company.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/update_img_widget.dart';

class UpdateAdminScreen extends StatefulWidget {
  const UpdateAdminScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAdminScreen> createState() => _UpdateAdminScreenState();
}

class _UpdateAdminScreenState extends State<UpdateAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Update Company info',
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
                //const SizedBox(height: 16.0),
                Center(
                  child: UpdateImgWidget(
                    image: _image,
                    onTap: pickImage,
                  ),
                ),
                const SizedBox(height: 16.0),
                const SeparatedLabeledTextField(
                  labelText: 'Company Name',
                  hintText: 'Your Company Name',
                ),
                const SizedBox(height: 16),
                const SeparatedLabeledTextField(
                  labelText: 'Email Address',
                  hintText: 'Your Company Email Address',
                ),
                const SizedBox(height: 16),
                const SeparatedLabeledTextField(
                  labelText: 'Phone Number',
                  hintText: 'Your Company Phone Number',
                ),
                const SizedBox(height: 16.0),
                const SeparatedLabeledTextField(
                  labelText: 'Address',
                  hintText: 'Your Company Address',
                ),
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
                    'Update',
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
        _image = File(pickedFile.path);
      });
    }
  }

  void updateEmployee() async {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get data form text field
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phoneController.text.trim();
      final address = _addressController.text.trim();

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // initialize provider
      final provider = context.read<CompanyUpdateProvider>();

      // get token
      final token = await Helper.getToken(context);

      // create company object
      Company company = Company(
        name: name,
        email: email,
        phone: phone,
        address: address,
      );

      //TODO: get the user id from the home screen
      // call the rest api through provider
      await provider.update(company, token, 1);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('successful');

        // Navigate to the previous/setting screen
        // if (context.mounted) {
        //   Navigator.pop(context);
        // }
      } else {
        // Display an error toast
        toastProvider.showErrorToast(provider.error);
      }
    }
  }
}
