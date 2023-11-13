import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_list.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_form_dialog.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  void _openBookmarkFormDialog(BuildContext context) async {
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return BookmarkFormDialog(
            mode: Mode.regist,
          );
        });
    notifier.resetState();
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
