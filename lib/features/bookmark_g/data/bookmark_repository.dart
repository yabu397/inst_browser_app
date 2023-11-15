import 'package:dartz/dartz.dart';
import 'package:flutter_project/features/bookmark_g/data/bookmark_local_datasource.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

class BookmarkRepository {
  BookmarkRepository(this.dataSource);

  final BookmarkDataSource dataSource;

  Future<Either<Object, List<Bookmark>>> fetchBookmarks() {
    return dataSource.fetchBookmarks();
  }

  Future<Either<Object, int>> insertBookmark(Bookmark bookmark) {
    return dataSource.insertBookmark(bookmark);
  }

  Future<Either<Object, int>> deleteBookmark(Bookmark bookmark) {
    return dataSource.deleteBookmark(bookmark);
  }

  Future<Either<Object, int>> updateBookmark(Bookmark bookmark) {
    return dataSource.updateBookmark(bookmark);
  }
}
