import 'package:flutter/material.dart';

void toast(BuildContext context, bool isError, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message),
      action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            scaffold.hideCurrentSnackBar;
          }),
    ),
  );
}
