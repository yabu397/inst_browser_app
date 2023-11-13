import 'package:equatable/equatable.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkState extends Equatable {
  final Bookmark bookmark;
  final List<Bookmark> bookmarkList;

  const BookmarkState({required this.bookmark, this.bookmarkList = const []});

  const BookmarkState.initial(
      {this.bookmark = const Bookmark(id: '', title: '', url: ''),
      this.bookmarkList = const []});

  BookmarkState copyWith({
    String? id,
    String? title,
    String? url,
    List<Bookmark>? bookmarkList,
  }) {
    return BookmarkState(
      bookmark: Bookmark(
        id: id ?? bookmark.id,
        title: title ?? bookmark.title,
        url: url ?? bookmark.url,
      ),
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }

  @override
  List<Object?> get props => [bookmark, bookmarkList];
}
