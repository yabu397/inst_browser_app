import 'package:dartz/dartz.dart';
import 'package:flutter_project/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  BookmarkRepositoryImpl(this.dataSource);

  final BookmarkDataSource dataSource;

  @override
  Future<bool> deleteBookmark() {
    return dataSource.deleteBookmark();
  }

  @override
  Future<Either<AppException, Bookmark>> fetchBookmarks() {
    return dataSource.fetchBookmarks();
  }

  @override
  Future<bool> saveBookmark({required Bookmark bookmark}) {
    return dataSource.saveBookmark(bookmark: bookmark);
  }

  @override
  Future<bool> hasBookmark() {
    return dataSource.hasBookmark();
  }
}
