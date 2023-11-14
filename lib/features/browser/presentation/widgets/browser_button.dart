import 'package:flutter/material.dart';
import 'package:flutter_project/shared/globals.dart';

class BrowserButton extends StatelessWidget {
  const BrowserButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black12),
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Style.boldStyle.copyWith(fontSize: Sizing.labelSize),
          ),
        ),
      ),
    );
  }
}
