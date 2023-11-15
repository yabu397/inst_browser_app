import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/domain/providers/bookmark_provider.dart';
import 'package:flutter_project/features/bookmark/presentation/providers/bookmark_state.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:flutter_project/shared/widgets/cst_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final bookmarkNotifierProvider =
    NotifierProvider<BookmarkNotifier, BookmarkState>(BookmarkNotifier.new);

class BookmarkNotifier extends Notifier<BookmarkState> {
  @override
  BookmarkState build() {
    return const BookmarkState.initial();
  }

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
    final response =
        await ref.read(bookmarkRepositoryProvider).insertBookmark(bookmark);
    response.fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(
        context,
        text: L10n.of(context)
            .failureRegistration(state.bookmark.title ?? failure.toString()),
      ));
    }, (sucsess) {
      ScaffoldMessenger.of(context).showSnackBar(CstSnackBar(
        context,
        text: L10n.of(context)
            .successfulRegistration(state.bookmark.title ?? sucsess.toString()),
      ));
      fetchBookmarks(context);
      resetState();
    });
  }

  Future<void> fetchBookmarks(BuildContext context) async {
    await ref
        .read(bookmarkRepositoryProvider)
        .fetchBookmarks()
        .then((response) => updateStateFromResponse(response, context));
  }

  Future<void> deleteBookmark(Bookmark bookmark, BuildContext context) async {
    await ref
        .read(bookmarkRepositoryProvider)
        .deleteBookmark(bookmark)
        .then((response) async {
      handleResponse(response, context);
      fetchBookmarks(context);
    });
  }

  Future<void> updateBookmark(Bookmark bookmark, BuildContext context) async {
    await ref
        .read(bookmarkRepositoryProvider)
        .updateBookmark(bookmark)
        .then((response) async {
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
