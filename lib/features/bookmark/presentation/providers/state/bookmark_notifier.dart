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

  Future<void> fetchBookmarks() async {
    final response = await bookmarkRepository.fetchBookmarks();
    updateStateFromResponse(response);
  }

  void updateStateFromResponse(Either<AppException, Bookmark> response) {
    response.fold((failure) {}, (data) {});
  }
}
