import 'package:dartz/dartz.dart';
import 'package:flutter_project/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  BookmarkRepositoryImpl(this.dataSource);

  final BookmarkDataSource dataSource;

  @override
  Future<Either<Object, List<Bookmark>>> fetchBookmarks() {
    return dataSource.fetchBookmarks();
  }

  @override
  Future<Either<Object, int>> insertBookmark(Bookmark bookmark) {
    return dataSource.insertBookmark(bookmark);
  }

  @override
  Future<Either<Object, int>> deleteBookmark(Bookmark bookmark) {
    return dataSource.deleteBookmark(bookmark);
  }

  @override
  Future<Either<Object, int>> updateBookmark(Bookmark bookmark) {
    return dataSource.updateBookmark(bookmark);
  }
}
