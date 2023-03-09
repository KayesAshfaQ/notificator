import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/group_provider.dart';
import 'package:notificator/widgets/toast_widget.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import 'separated_labeled_text_field.dart';

class UpdateGroupBottomSheet extends StatefulWidget {
  final int id;
  final String name;

  const UpdateGroupBottomSheet({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<UpdateGroupBottomSheet> createState() => _UpdateGroupBottomSheetState();
}

class _UpdateGroupBottomSheetState extends State<UpdateGroupBottomSheet> {
  late final FToast fToast;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _txtController;

  @override
  void initState() {
    super.initState();
    _txtController = TextEditingController(text: widget.name);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }

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
              'Update Group',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.deepPurple,
                fontFamily: 'BaiJamjuree',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24.0),
            Form(
              key: _formKey,
              child: SeparatedLabeledTextField(
                controller: _txtController,
                labelText: 'Group Name',
                hintText: 'Name of your group',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a group name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: updateGroup,
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
                'Update Group',
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

  void updateGroup() async {
    String name = _txtController.text.trim();

    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get token through provider
      final String? token = context.read<AuthKeyProvider>().userToken;

      // call the rest api through provider
      final provider = context.read<GroupProvider>();
      await provider.update(token!, widget.id, name);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        fToast.showToast(
          child: const ToastWidget(
            message: 'Group updated successfully',
            iconData: Icons.check,
            backgroundColor: Colors.green,
          ),
        );

        // hide the bottom sheet
        if (context.mounted) Navigator.pop(context);
      } else {
        // Display an error toast
        fToast.showToast(
          child: ToastWidget(
            message: provider.error,
            iconData: Icons.error_outline,
            backgroundColor: Colors.red,
          ),
          //toastDuration: const Duration(seconds: 20),
        );
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
