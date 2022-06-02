import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showCustomDialog(
  BuildContext context, {
  String? title,
  String? subtitle,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: subtitle != null ? Text(subtitle) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }

      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: subtitle != null ? Text(subtitle) : null,
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
