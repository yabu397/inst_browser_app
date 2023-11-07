import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkList extends ConsumerWidget {
  const BookmarkList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookmarkNotifierProvider);
    return ListView.builder(
      itemCount: state.bookmarkList.length,
      itemBuilder: (context, index) {
        final myModel = state.bookmarkList[index];
        return ListTile(
          title: Text(myModel.title ?? ''),
        );
      },
    );
  }
}
