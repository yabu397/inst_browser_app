import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_list.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_form_dialog.dart';
import 'package:flutter_project/shared/globals.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  void _openBookmarkFormDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return BookmarkFormDialog(
            mode: Mode.regist,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).bookmarkListTitle,
            style: Style.boldStyle.copyWith(fontSize: Sizing.titleSize)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: const BookmarkList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBookmarkFormDialog(context),
        tooltip: L10n.of(context).bookmarkRegistDialogTitle,
        child: const Icon(Icons.add),
      ),
    );
  }
}
