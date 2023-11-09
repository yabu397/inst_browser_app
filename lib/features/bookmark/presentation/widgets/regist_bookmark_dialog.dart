import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
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
          Text(L10n.of(context).registBookmarkModalTitle,
              style: Style.boldStyle.copyWith(fontSize: Sizing.titleSize)),
          CstTextField(
            label: L10n.of(context).titleLabel,
            onSubmitted: (String value) => notifier.setTitle(value),
          ),
          CstTextField(
            label: L10n.of(context).urlLabel,
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
                        notifier.fetchBookmarks();
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
                        if (state.bookmarkList.length >=
                            Limits.maxBookmarkCount) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CstSnackBar(context,
                                  text: L10n.of(context)
                                      .maxBookmark(Limits.maxBookmarkCount)));
                        } else {
                          notifier
                              .insertBookmark(state.bookmark)
                              .then((value) => notifier.fetchBookmarks());
                        }
                      },
                      child: Text(L10n.of(context).regist),
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
