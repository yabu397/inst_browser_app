import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_project/shared/widgets/cst_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkFormBdy extends ConsumerWidget {
  const BookmarkFormBdy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(bookmarkNotifierProvider.notifier);
    return Column(
      children: [
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
      ],
    );
  }
}
