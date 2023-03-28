import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/logo_update_provider_company.dart';
import 'package:notificator/provider/company_update_provider.dart';
import 'package:notificator/provider/home_admin_data_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../model/company.dart';
import '../provider/image_pick_provider.dart';
import '../provider/preference_provider.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../util/keys.dart';
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

  String? token;
  ToastProvider? toastProvider;
  String? companyId;
  String? userId;
  String? imgUrl;

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
    final company = context.read<HomeAdminDataProvider>().company;

    _nameController.text = company.name ?? '';
    _emailController.text = company.email ?? '';
    _phoneController.text = company.phone ?? '';
    _addressController.text = company.address ?? '';

    imgUrl = company.logo ?? '';
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

    await prefProvider.getData(Keys.companyID);
    companyId = prefProvider.data!;
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
    final imgProvider = context.watch<ImagePickProvider>();

    final logoUpdateProvider = context.read<CompanyLogoUpdateProvider>();

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
                    image: imgProvider.image,
                    imageUrl: imgUrl,
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

                        if (token != null && companyId != null) {
                          await logoUpdateProvider.update(
                            token!,
                            companyId!,
                            imgProvider.image!,
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                SeparatedLabeledTextField(
                  controller: _nameController,
                  labelText: 'Company Name',
                  hintText: 'Your Company Name',
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'Your Company Email Address',
                ),
                const SizedBox(height: 16),
                SeparatedLabeledTextField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: 'Your Company Phone Number',
                ),
                const SizedBox(height: 16.0),
                SeparatedLabeledTextField(
                  controller: _addressController,
                  labelText: 'Address',
                  hintText: 'Your Company Address',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: updateCompanyInfo,
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

  void updateCompanyInfo() async {
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
      initToastProvider();

      // initialize token
      initToken();

      // initialize provider
      final provider = context.read<CompanyUpdateProvider>();

      // create company object
      Company company = Company(
        name: name,
        email: email,
        phone: phone,
        address: address,
      );

      // call the rest api through provider

      if (token != null && userId != null) {
        await provider.update(company, token!, userId!);

        // check if the submission was successful
        if (provider.success) {
          // Display a success toast
          toastProvider?.showSuccessToast('update successful');

          // save the user data in shared preferences when data is updated
          if (context.mounted) {
            final prefProvider = context.read<PreferenceProvider>();
            prefProvider.setData(Keys.userName, '${provider.data?.name}');
            prefProvider.setData(Keys.userEmail, '${provider.data?.email}');
            prefProvider.setData(Keys.userImg, '${provider.data?.logo}');
          }
        } else {
          // Display an error toast
          toastProvider?.showErrorToast(provider.error);
        }
      }
      // hide a progress loader
      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }
}
