import 'package:flutter/material.dart';
import 'package:flutter_project/features/browser/presentation/providers/browser_state_provider.dart';
import 'package:flutter_project/features/browser/presentation/widgets/browser_button_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends ConsumerWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(browserkNotifierProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: state.controller!,
              ),
            ),
            Stack(
              children: [
                SizedBox(
                    width: width,
                    height: height * 0.1,
                    child: const BrowserButtonBar())
              ],
            )
          ],
        ),
      ),
    );
  }
}
