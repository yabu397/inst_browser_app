import 'package:equatable/equatable.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkState extends Equatable {
  final List<Bookmark> bookmarkList;
  const BookmarkState({this.bookmarkList = const []});
  const BookmarkState.initial({this.bookmarkList = const []});
  BookmarkState copyWith({
    List<Bookmark>? bookmarkList,
  }) {
    return BookmarkState(
      bookmarkList: bookmarkList ?? this.bookmarkList,
    );
  }

  @override
  List<Object?> get props => [bookmarkList];
}
