import 'package:flutter_project/features/browser/presentation/providers/state/browser_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserNotifier extends StateNotifier<BrowserState> {
  BrowserNotifier() : super(const BrowserState.initial());

  Future<void> setController(
    WebViewController? controller,
  ) async {
    state = state.copyWith(
      controller: controller,
    );
  }

  Future<void> setCanState() async {
    state = state.copyWith(
      canGoBack: await state.controller?.canGoBack() ?? false,
      canGoForward: await state.controller?.canGoForward() ?? false,
    );
  }

  Future<void> goBack() async {
    state.controller?.goBack();
  }

  Future<void> goForward() async {
    state.controller?.goForward();
  }

  Future<void> reload() async {
    state.controller?.reload();
  }
}
