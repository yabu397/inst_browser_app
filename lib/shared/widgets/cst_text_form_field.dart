import 'package:flutter/material.dart';
import 'package:flutter_project/shared/globals.dart';

class CstTextFormField extends StatelessWidget {
  const CstTextFormField(
      {Key? key, required this.label, this.onChanged, this.validator})
      : super(key: key);

  final String label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
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
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                vertical: Sizing.paddingSize,
                horizontal: Sizing.paddingSize,
              ),
              isDense: true,
            ),
            onChanged: onChanged,
            validator: validator,
          )
        ]));
  }
}
