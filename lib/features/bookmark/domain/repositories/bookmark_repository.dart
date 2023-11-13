import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

abstract class BookmarkRepository {
  Future<Either<Object, List<Bookmark>>> fetchBookmarks();
  Future<Either<Object, int>> insertBookmark(Bookmark bookmark);
  Future<Either<Object, int>> deleteBookmark(Bookmark bookmark);
  Future<Either<Object, int>> updateBookmark(Bookmark bookmark);
}
