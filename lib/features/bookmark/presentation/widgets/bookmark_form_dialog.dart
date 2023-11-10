import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_form_bdy.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_form_buttons.dart';
import 'package:flutter_project/shared/globals.dart';

class BookmarkFormDialog extends StatelessWidget {
  BookmarkFormDialog({Key? key, required this.mode}) : super(key: key);

  final String mode;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: Sizing.defaultInsets,
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                switch (mode) {
                  Mode.regist => L10n.of(context).bookmarkRegistDialogTitle,
                  Mode.update => L10n.of(context).bookmarkEditDialogTitle,
                  _ => ''
                },
                style: Style.boldStyle.copyWith(fontSize: Sizing.titleSize)),
            const BookmarkFormBdy(),
            BookmarkFormButtons(
              mode: mode,
              formKey: _formKey,
            ),
          ]),
        ),
      ),
    );
  }
}
