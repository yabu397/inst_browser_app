import 'package:flutter/material.dart';
import 'package:flutter_project/shared/globals.dart';

class CstTextField extends StatelessWidget {
  const CstTextField({Key? key, required this.label, required this.onSubmitted})
      : super(key: key);

  final String label;
  final Function(String) onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Sizing.defaultInsets,
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              label,
              style: Style.boldStyle.copyWith(fontSize: Sizing.labelSize),
            ),
          ),
          TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: Sizing.paddingSize,
                  horizontal: Sizing.paddingSize,
                ),
                isDense: true,
              ),
              onSubmitted: onSubmitted)
        ]));
  }
}
