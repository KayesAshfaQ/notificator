import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../provider/send_to_option_provider.dart';

class SendOptionRadioWidget extends StatelessWidget {
  const SendOptionRadioWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SendToOptionProvider>(context);
    final selectedOption = provider.selectedOption;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioButtonWidget(
          label: 'individual',
          value: 1,
          selectedOption: selectedOption,
          provider: provider,
        ),
        RadioButtonWidget(
          label: 'Group',
          value: 2,
          selectedOption: selectedOption,
          provider: provider,
        ),

      ],
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({
    super.key,
    required this.label,
    required this.value,
    required int selectedOption,
    required SendToOptionProvider provider,
  })  : _selectedOption = selectedOption,
        _provider = provider;

  final int _selectedOption;
  final SendToOptionProvider _provider;
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          value: value,
          groupValue: _selectedOption,
          activeColor: AppColors.orange,
          fillColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.orange;
            } else {
              return AppColors.deepPurple;
            }
          }),
          //focusColor: AppColors.orange,
          onChanged: onChange,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        GestureDetector(
          onTap: () => onChange(value),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: _selectedOption == value
                  ? AppColors.orange
                  : AppColors.deepPurple,
              fontFamily: 'BaiJamjuree',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void onChange(value) {
    _provider.setSelectedOption(value!);
    print('sendTo::: ${_provider.selectedOption}');
    print('value: $value');
    print('provider_value: ${_provider.selectedOption}');
  }
}
