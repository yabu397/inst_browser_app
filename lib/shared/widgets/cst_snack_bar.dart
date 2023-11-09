import 'package:flutter/material.dart';

class CstSnackBar extends SnackBar {
  CstSnackBar(BuildContext context, {String? text, super.key})
      : super(
          content: Row(
            children: [
              Expanded(child: Text(text ?? '')),
              InkWell(
                child: const Icon(Icons.clear, color: Colors.white),
                onTap: () =>
                    {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
              )
            ],
          ),
        );
}
