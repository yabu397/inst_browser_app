import 'package:flutter_project/features/bookmark/domain/providers/bookmark_provider.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/state/bookmark_notifier.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/state/bookmark_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkNotifierProvider =
    StateNotifierProvider<BookmarkNotifier, BookmarkState>((ref) {
  final repository = ref.watch(bookmarkLocalRepositoryProvider);
  return BookmarkNotifier(repository)..fetchBookmarks();
});
