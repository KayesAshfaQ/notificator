import 'package:flutter/material.dart';

import '../util/utils.dart';

class AppAlertDialogWidget extends StatelessWidget {
  final String? title;
  final String content;
  final String btnTitle;
  final Color? btnColor;

  final VoidCallback onConfirm;

  const AppAlertDialogWidget(
      {Key? key,
      required this.onConfirm,
      this.title,
      required this.content,
      required this.btnTitle,
      this.btnColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: (title != null)
          ? Text(title!, style: Utils.myTxtStyleTitleSmall)
          : null,
      content: Text(
        content,
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
            backgroundColor:
                MaterialStateProperty.all<Color>(btnColor ?? Colors.red),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(btnTitle),
        ),
      ],
    );
  }
}
