import 'package:flutter/material.dart';

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
            maxChildSize: 0.75,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: 100,
                        itemBuilder: (_, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: v,
                                onChanged: (value) {
                                  v = value!;
                                },
                              ),
                              Text('Group $index'),
                            ],
                          );
                        },
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
