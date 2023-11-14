import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/widgets/bookmark_form_dialog.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
import 'package:flutter_project/shared/widgets/cst_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkList extends ConsumerStatefulWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  ConsumerState<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends ConsumerState<BookmarkList> {
  late RelativeRect position;

  @override
  void initState() {
    super.initState();
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    notifier.fetchBookmarks(context);
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      position = RelativeRect.fromLTRB(
          details.globalPosition.dx, details.globalPosition.dy, 0, 0);
    });
  }

  void _showMenu(BuildContext context, Bookmark bookmark) {
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    showMenu(
      context: context,
      position: position,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 1,
          child: Text(L10n.of(context).edit),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(L10n.of(context).delete),
        ),
      ],
    ).then((value) async {
      if (value == 1) {
        notifier.setBookmark(bookmark);
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return BookmarkFormDialog(
                mode: Mode.update,
              );
            });
        notifier.resetState();
      } else if (value == 2) {
        await notifier.deleteBookmark(bookmark, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookmarkNotifierProvider);
    final notifier = ref.watch(browserkNotifierProvider.notifier);
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: state.bookmarkList.length,
      itemBuilder: (context, index) {
        final bookmark = state.bookmarkList[index];
        return Card(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0.0),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
          ),
          child: InkWell(
            onTap: () {
              try {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                notifier.setController(WebViewController()
                  ..setNavigationDelegate(
                      NavigationDelegate(onUrlChange: (_) async {
                    notifier.setCanState();
                  }))
                  ..loadRequest(
                    Uri.parse(bookmark.url ?? ''),
                  ));
                context.push(Locations.browser.path);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(context,
                    text: L10n.of(context).invalidUrl(bookmark.url ?? '')));
              }
            },
            onLongPress: () {
              _showMenu(context, bookmark);
            },
            onTapDown: _handleTapDown,
            child: SizedBox(
              height: height * 0.1,
              child: Padding(
                padding: Sizing.defaultInsets,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CstTextBox(
                          text: bookmark.title,
                          textStyle: Style.boldStyle
                              .copyWith(fontSize: Sizing.labelSize)),
                      CstTextBox(
                          text: bookmark.url,
                          textStyle:
                              const TextStyle(fontSize: Sizing.textSize)),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
