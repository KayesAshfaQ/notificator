import 'package:flutter/material.dart';
import 'package:notificator/provider/group_chip_provider.dart';
import 'package:notificator/widgets/select_group_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../widgets/my_appbar_widget.dart';
import '../widgets/separated_labeled_text_field.dart';
import '../widgets/send_option_radio_widget.dart';

class CreateNotificationScreen extends StatefulWidget {
  const CreateNotificationScreen({Key? key}) : super(key: key);

  @override
  State<CreateNotificationScreen> createState() =>
      _CreateNotificationScreenState();
}

class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final groups = context.watch<GroupChipProvider>().groupList;

    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Create Notification',
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
                'Create Notification',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24.0),
              const SeparatedLabeledTextField(
                labelText: 'Subject',
                hintText: 'Notification Subject',
              ),
              const SizedBox(height: 16),
              const Text(
                'Message',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                onChanged: (value) {},
                maxLines: null,
                minLines: 5,
                style: const TextStyle(
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your message',
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
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Send To',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SendOptionRadioWidget(),
              const SizedBox(height: 4),
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onPressSendNotification,
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
                  'Send Notification',
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

  void onTapSelectGroup() {
    // show bottom sheet to select group or individual
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const SelectGroupBottomSheet();
      },
    );
  }

  void onPressSendNotification() {
    // send notification
  }
}
