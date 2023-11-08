import 'package:flutter/material.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkList extends ConsumerWidget {
  const BookmarkList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: SizedBox(
              height: height * 0.1,
              child: Padding(
                padding: Size.defaultInsets,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          bookmark.title ?? '',
                          style: Style.boldStyle
                              .copyWith(fontSize: Size.labelSize),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bookmark.url ?? '',
                          style: const TextStyle(fontSize: Size.textSize),
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
