import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserState extends Equatable {
  final WebViewController? controller;
  final bool canGoBack;
  final bool canGoForward;

  const BrowserState(
      {this.controller, this.canGoBack = false, this.canGoForward = false});

  const BrowserState.initial(
      {this.controller, this.canGoBack = false, this.canGoForward = false});

  BrowserState copyWith(
      {WebViewController? controller, bool? canGoBack, bool? canGoForward}) {
    return BrowserState(
        controller: controller ?? this.controller,
        canGoBack: canGoBack ?? false,
        canGoForward: canGoForward ?? false);
  }

  @override
  List<Object?> get props => [controller];
}
