import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/state/bookmark_state.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      id: '',
      title: '',
      url: '',
    );
  }

  Future<void> insertBookmark(Bookmark bookmark, BuildContext context) async {
    await bookmarkRepository.insertBookmark(bookmark).then((response) async {
      handleResponse(response, context);
      fetchBookmarks(context);
    });
  }

  Future<void> fetchBookmarks(BuildContext context) async {
    await bookmarkRepository
        .fetchBookmarks()
        .then((response) => updateStateFromResponse(response, context));
  }

  Future<void> deleteBookmark(Bookmark bookmark, BuildContext context) async {
    await bookmarkRepository.deleteBookmark(bookmark).then((response) async {
      handleResponse(response, context);
      fetchBookmarks(context);
    });
  }

  Future<void> updateBookmark(Bookmark bookmark, BuildContext context) async {
    await bookmarkRepository.updateBookmark(bookmark).then((response) async {
      handleResponse(response, context);
      fetchBookmarks(context);
    });
  }

  void handleResponse(
      Either<Object, int> response, BuildContext context) async {
    response.fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(
        context,
        text: L10n.of(context).errorMessage(failure.toString()),
      ));
    }, (r) {
      resetState();
    });
  }

  void updateStateFromResponse(
      Either<Object, List<Bookmark>> response, BuildContext context) {
    response.fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(
        context,
        text: L10n.of(context).errorMessage(failure.toString()),
      ));
    }, (data) {
      state = state.copyWith(
        bookmarkList: data,
      );
    });
  }
}
