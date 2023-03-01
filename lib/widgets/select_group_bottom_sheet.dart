import 'package:flutter/material.dart';
import 'package:notificator/widgets/multi_select_chip.dart';

import '../constants/app_colors.dart';
import 'separated_labeled_text_field.dart';

class SelectGroupBottomSheet extends StatelessWidget {
  const SelectGroupBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? v = false;
    //final myProvider = Provider.of<MyProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.65,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: Text(
                          'Choose Your Group *',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.deepPurple,
                            fontFamily: 'BaiJamjuree',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        controller: controller,
                        children: [
                          const SizedBox(height: 8),
                          const MultiSelectChip(),
                          CommonPurpleButtonWidget(
                            title: 'Submit',
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            onPress: () {},
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CommonPurpleButtonWidget extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPress;

  const CommonPurpleButtonWidget({
    super.key,
    required this.title,
    required this.padding,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepPurple,
        padding: padding,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: const Size(double.infinity, 0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontFamily: 'BaiJamjuree',
        ),
      ),
    );
  }
}
