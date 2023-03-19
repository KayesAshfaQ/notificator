import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/update_img_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Update profile',
      ),
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
                'Update Your Profile',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: UpdateImgWidget(
                  image: _image,
                  onTap: pickImage,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
}
