import 'package:dartz/dartz.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/state/bookmark_state.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkNotifier extends StateNotifier<BookmarkState> {
  final BookmarkRepository bookmarkRepository;

  BookmarkNotifier(
    this.bookmarkRepository,
  ) : super(const BookmarkState.initial());

  Future<void> setTitle(String value) async {
    state = state.copyWith(
      title: value,
    );
  }

  Future<void> setUrl(String value) async {
    state = state.copyWith(
      url: value,
    );
  }

  Future<void> setBookmark(Bookmark bookmark) async {
    state = state.copyWith(
        id: bookmark.id, title: bookmark.title, url: bookmark.url);
  }

  Future<void> resetState() async {
    state = state.copyWith(
      id: null,
      title: null,
      url: null,
    );
  }

  Future<void> insertBookmark(Bookmark bookmark) async {
    await bookmarkRepository.insertBookmark(bookmark);
  }

  Future<void> fetchBookmarks() async {
    final response = await bookmarkRepository.fetchBookmarks();
    updateStateFromResponse(response);
  }

  Future<void> deleteBookmark(Bookmark bookmark) async {
    await bookmarkRepository.deleteBookmark(bookmark);
  }

  Future<void> updateBookmark(Bookmark bookmark) async {
    await bookmarkRepository.updateBookmark(bookmark);
  }

  void updateStateFromResponse(Either<AppException, List<Bookmark>> response) {
    response.fold((failure) {}, (data) {
      state = state.copyWith(
        bookmarkList: data,
      );
    });
  }
}
