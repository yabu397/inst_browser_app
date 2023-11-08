import 'package:flutter/material.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/features/browser/presentation/widgets/browser_button.dart';
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
      BrowserButton(text: '< 戻る', onPressed: () => {notifier.goBack()}),
      BrowserButton(text: '進む >', onPressed: () => {notifier.goForward()}),
      BrowserButton(text: '更新', onPressed: () => {notifier.reload()}),
      BrowserButton(text: '終了', onPressed: () => {context.go('/')})
    ]);
  }
}
