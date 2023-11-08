import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserState extends Equatable {
  final WebViewController? controller;

  const BrowserState({this.controller});

  const BrowserState.initial({this.controller});

  BrowserState copyWith(
      {WebViewController? controller, bool? canGoBack, bool? canGoForward}) {
    return BrowserState(controller: controller ?? this.controller);
  }

  @override
  List<Object?> get props => [controller];
}
