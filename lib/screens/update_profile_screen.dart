import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/app_colors.dart';
import '../generated/assets.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';

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

class UpdateImgWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final File? image;

  const UpdateImgWidget({Key? key, this.onTap, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: ClipOval(
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  )
                : ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(60), // Image radius
                      child: RandomAvatar(
                        Random(10).toString(),
                      ),
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                Assets.svgIcEdit,
                color: Colors.white,
                height: 20,
                width: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
