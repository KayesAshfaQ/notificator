import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'separated_labeled_text_field.dart';

class CreateGroupBottomSheet extends StatelessWidget {
  const CreateGroupBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final myProvider = Provider.of<MyProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: height * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Your Group',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.deepPurple,
                fontFamily: 'BaiJamjuree',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24.0),
            const SeparatedLabeledTextField(
              labelText: 'Group Name',
              hintText: 'Name of your group',
            ),
            const SizedBox(height: 24),
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
                'Create Group',
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'BaiJamjuree',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
