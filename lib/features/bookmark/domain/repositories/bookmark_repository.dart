import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

abstract class BookmarkRepository {
  Future<Either<AppException, List<Bookmark>>> fetchBookmarks();
  Future<int> insertBookmark(Bookmark bookmark);
}
