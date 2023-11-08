import 'package:flutter/material.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
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
        const PopupMenuItem(
          value: 1,
          child: Text('編集'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('削除'),
        ),
      ],
    ).then((value) async {
      if (value == 1) {
        print('メニューアイテム 1 が選択されました');
      } else if (value == 2) {
        await notifier.deleteBookmark(bookmark);
        await notifier.fetchBookmarks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookmarkNotifierProvider);
    final notifier = ref.read(browserkNotifierProvider.notifier);
    final height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: state.bookmarkList.length,
      itemBuilder: (context, index) {
        final bookmark = state.bookmarkList[index];
        return Card(
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
          ),
          child: InkWell(
            onTap: () {
              notifier.setController(WebViewController()
                ..loadRequest(
                  Uri.parse(bookmark.url ?? ''),
                ));
              context.go('/browser');
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
                      Expanded(
                        child: Text(
                          bookmark.title ?? '',
                          style: Style.boldStyle
                              .copyWith(fontSize: Sizing.labelSize),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bookmark.url ?? '',
                          style: const TextStyle(fontSize: Sizing.textSize),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
