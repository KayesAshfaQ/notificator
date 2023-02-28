import 'package:flutter/material.dart';

import '../util/utils.dart';

class DeactivateAccountDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeactivateAccountDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Deactivate Account',
        style: Utils.myTxtStyleTitleSmall,
      ),
      content: const Text(
        'Are you sure you want to Deactivate your account?',
        style: Utils.myTxtStyleBodySmall,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('DELETE'),
        ),
      ],
    );
  }
}
