import 'package:flutter_project/features/browser/presentation/providers/state/browser_notifier.dart';
import 'package:flutter_project/features/browser/presentation/providers/state/browser_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final browserkNotifierProvider =
    StateNotifierProvider<BrowserNotifier, BrowserState>((ref) {
  return BrowserNotifier();
});
