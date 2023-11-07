import 'package:flutter/material.dart';
import 'package:flutter_project/shared/globals.dart';

class InputTextBox extends StatelessWidget {
  const InputTextBox({Key? key, required this.title, required this.onSubmitted})
      : super(key: key);

  final String title;
  final Function(String) onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Size.defaultInsets,
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: Style.boldStyle.copyWith(fontSize: Size.labelSize),
            ),
          ),
          TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: Size.paddingSize,
                  horizontal: Size.paddingSize,
                ),
                isDense: true,
              ),
              onSubmitted: onSubmitted)
        ]));
  }
}
