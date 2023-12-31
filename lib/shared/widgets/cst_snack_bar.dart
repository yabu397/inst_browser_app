import 'package:flutter/material.dart';

class CstSnackBar extends SnackBar {
  CstSnackBar(BuildContext context, {String? text, super.key})
      : super(
          content: Expanded(child: Text(text ?? '')),
          showCloseIcon: true,
          closeIconColor: Colors.white,
        );
}
