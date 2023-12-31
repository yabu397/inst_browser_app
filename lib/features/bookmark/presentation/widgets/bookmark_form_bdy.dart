import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/cst_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkFormBdy extends ConsumerWidget {
  const BookmarkFormBdy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(bookmarkNotifierProvider);
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    return Column(
      children: [
        CstTextFormField(
          initialValue: state.bookmark.title,
          label: L10n.of(context).titleLabel,
          onChanged: (String value) => notifier.setTitle(value),
        ),
        CstTextFormField(
          initialValue: state.bookmark.url,
          label: L10n.of(context).urlLabel,
          onChanged: (String value) => notifier.setUrl(value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return L10n.of(context).requiredText;
            }
            if (value.length > Limits.maxUrlLength) {
              return L10n.of(context).maxUrlLength(Limits.maxUrlLength);
            }
            try {
              WebViewController().loadRequest(
                Uri.parse(value),
              );
            } catch (e) {
              return L10n.of(context).inputValidUrl;
            }
            return null;
          },
        ),
      ],
    );
  }
}
