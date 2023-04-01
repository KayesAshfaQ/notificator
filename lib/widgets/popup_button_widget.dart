import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PopupButtonWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final List<String> sortOptions;
  final Function(String)? onSelected;

  const PopupButtonWidget({
    super.key,
    required this.label,
    this.icon,
    required this.sortOptions,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.orange.shade100,
        highlightColor: Colors.orange.withOpacity(0.1),
      ),
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return sortOptions.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList();
        },
        splashRadius: 100,
        onSelected: onSelected,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9.5),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.deepPurple,
              width: 0.7,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.black87,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.deepPurple,
                  fontFamily: 'BaiJamjuree',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
