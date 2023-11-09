import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/cst_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistBookmarkModal extends ConsumerStatefulWidget {
  const RegistBookmarkModal({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistBookmarkModal> createState() =>
      _RegistBookmarkModalState();
}

class _RegistBookmarkModalState extends ConsumerState<RegistBookmarkModal> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookmarkNotifierProvider);
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    return Dialog(
      child: Padding(
        padding: Sizing.defaultInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            RESIST_BOOKMARK_MODAL_TITLE,
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizing.titleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          CstTextField(
            label: 'タイトル',
            onSubmitted: (String value) => notifier.setTitle(value),
          ),
          CstTextField(
            label: 'URL',
            onSubmitted: (String value) => notifier.setUrl(value),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Sizing.paddingSize,
              bottom: Sizing.paddingSize,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        notifier
                            .fetchBookmarks()
                            .then((value) => print(state.bookmarkList));
                      },
                      child: const Text('キャンセル'),
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        notifier.insertBookmark(state.bookmark).then((value) =>
                            notifier
                                .fetchBookmarks()
                                .then((value) => print(state.bookmarkList)));
                      },
                      child: const Text('登録'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
