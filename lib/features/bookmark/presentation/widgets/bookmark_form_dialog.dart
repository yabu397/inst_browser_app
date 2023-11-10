import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
import 'package:flutter_project/shared/widgets/cst_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkFormDialog extends ConsumerStatefulWidget {
  const BookmarkFormDialog({Key? key, required this.mode}) : super(key: key);

  final String mode;
  @override
  ConsumerState<BookmarkFormDialog> createState() => _BookmarkFormDialogState();
}

class _BookmarkFormDialogState extends ConsumerState<BookmarkFormDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookmarkNotifierProvider);
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    return Dialog(
      child: Padding(
        padding: Sizing.defaultInsets,
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                switch (widget.mode) {
                  Mode.regist => L10n.of(context).bookmarkRegistDialogTitle,
                  Mode.update => L10n.of(context).bookmarkEditDialogTitle,
                  _ => ''
                },
                style: Style.boldStyle.copyWith(fontSize: Sizing.titleSize)),
            CstTextFormField(
              label: L10n.of(context).titleLabel,
              onChanged: (String value) => notifier.setTitle(value),
            ),
            CstTextFormField(
                label: L10n.of(context).urlLabel,
                onChanged: (String value) => notifier.setUrl(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return L10n.of(context).requiredText;
                  }
                  try {
                    WebViewController().loadRequest(
                      Uri.parse(value),
                    );
                  } catch (e) {
                    return L10n.of(context).inputValidUrl;
                  }
                  return null;
                }),
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
                          switch (widget.mode) {
                            case Mode.regist:
                              if (state.bookmarkList.length >=
                                  Limits.maxBookmarkCount) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    CstSnackBar(context,
                                        text: L10n.of(context).maxBookmark(
                                            Limits.maxBookmarkCount)));
                                break;
                              }
                              if (_formKey.currentState!.validate()) {
                                notifier
                                    .insertBookmark(state.bookmark)
                                    .then((value) => notifier.fetchBookmarks());
                                Navigator.of(context).pop();
                              }
                              break;
                            case Mode.update:
                              if (_formKey.currentState!.validate()) {
                                notifier
                                    .updateBookmark(state.bookmark)
                                    .then((value) => notifier.fetchBookmarks());
                                Navigator.of(context).pop();
                              }
                              break;
                          }
                        },
                        child: Text(
                          switch (widget.mode) {
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
            )
          ]),
        ),
      ),
    );
  }
}
