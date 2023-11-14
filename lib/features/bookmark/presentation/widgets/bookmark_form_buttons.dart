import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarkFormButtons extends ConsumerWidget {
  const BookmarkFormButtons(
      {Key? key, required this.mode, required this.formKey})
      : super(key: key);

  final String mode;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookmarkNotifierProvider);
    final notifier = ref.watch(bookmarkNotifierProvider.notifier);
    return Padding(
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
                  notifier.resetState();
                  Navigator.of(context).pop();
                },
                child: Text(L10n.of(context).cancel),
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
                  switch (mode) {
                    case Mode.regist:
                      if (state.bookmarkList.length >=
                          Limits.maxBookmarkCount) {
                        ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(
                            context,
                            text: L10n.of(context)
                                .maxBookmark(Limits.maxBookmarkCount)));
                        break;
                      }
                      if (formKey.currentState!.validate()) {
                        notifier
                            .insertBookmark(state.bookmark, context)
                            .then((value) => Navigator.of(context).pop());
                      }
                      break;
                    case Mode.update:
                      if (formKey.currentState!.validate()) {
                        notifier
                            .updateBookmark(state.bookmark, context)
                            .then((value) => Navigator.of(context).pop());
                      }
                      break;
                  }
                },
                child: Text(
                  switch (mode) {
                    Mode.regist => L10n.of(context).regist,
                    Mode.update => L10n.of(context).update,
                    _ => ''
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
