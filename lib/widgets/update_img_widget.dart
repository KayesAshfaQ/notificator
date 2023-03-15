import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_avatar/random_avatar.dart';

import '../generated/assets.dart';

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
