import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/features/browser/presentation/widgets/browser_button.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BrowserButtonBar extends ConsumerStatefulWidget {
  const BrowserButtonBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BrowserButtonBar> createState() => _BrowserButtonBarState();
}

class _BrowserButtonBarState extends ConsumerState<BrowserButtonBar> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(browserkNotifierProvider.notifier);
    return Row(children: [
      BrowserButton(
          text: L10n.of(context).goBackButton,
          onPressed: () => {notifier.goBack()}),
      BrowserButton(
          text: L10n.of(context).goForwardButton,
          onPressed: () => {notifier.goForward()}),
      BrowserButton(
          text: L10n.of(context).reload, onPressed: () => {notifier.reload()}),
      BrowserButton(
          text: L10n.of(context).end,
          onPressed: () => {context.go(Locations.home.path)})
    ]);
  }
}
