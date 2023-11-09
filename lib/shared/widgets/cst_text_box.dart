import 'package:flutter/material.dart';

class CstTextBox extends StatelessWidget {
  const CstTextBox({Key? key, this.text, this.textStyle}) : super(key: key);

  final String? text;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          text ?? '',
          style: textStyle,
        ),
      ),
    );
  }
}
