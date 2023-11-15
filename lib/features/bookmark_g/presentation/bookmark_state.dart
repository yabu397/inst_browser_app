import 'package:equatable/equatable.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkModel extends Equatable {
  final Bookmark bookmark;
  final List<Bookmark> bookmarkList;

  const BookmarkModel({required this.bookmark, this.bookmarkList = const []});

  const BookmarkModel.initial(
      {this.bookmark = const Bookmark(id: '', title: '', url: ''),
      this.bookmarkList = const []});

  BookmarkModel copyWith({
    String? id,
    String? title,
    String? url,
    List<Bookmark>? bookmarkList,
  }) {
    return BookmarkModel(
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
