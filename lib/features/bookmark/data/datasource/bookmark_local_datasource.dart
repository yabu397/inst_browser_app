import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/data/local/bookmark_local_db_service.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BookmarkDataSource {
  Future<Either<AppException, List<Bookmark>>> fetchBookmarks();
  Future<int> insertBookmark(Bookmark bookmark);
}

class BookmarkColumns {
  static String id = 'id';
  static String title = 'title';
  static String url = 'url';
}

class BookmarkLocalDatasource extends BookmarkDataSource {
  final BookmarkLocalDBService localDB;
  BookmarkLocalDatasource(this.localDB);

  @override
  Future<Either<AppException, List<Bookmark>>> fetchBookmarks() async {
    final Database? db = await localDB.database;
    List<Map<String, dynamic>> results =
        await db!.query(BookmarkLocalDBService.table);
    if (results.isEmpty) {
      return Left(
        AppException(
          identifier: 'BookmarkLocalDatasource',
          statusCode: 404,
          message: 'Bookmark not found',
        ),
      );
    }
    List<Bookmark> bookmarkList = results
        .map((result) => Bookmark(
            id: result[BookmarkColumns.id].toString(),
            title: result[BookmarkColumns.title],
            url: result[BookmarkColumns.url]))
        .toList();
    return Right(bookmarkList);
  }

  @override
  Future<int> insertBookmark(Bookmark bookmark) async {
    final Database? db = await localDB.database;
    final String? title = (bookmark.title?.isNotEmpty == true)
        ? bookmark.title
        : BOOKMARK_DEFAULT_TITLE;
    Map<String, dynamic> row = {
      BookmarkColumns.title: title,
      BookmarkColumns.url: bookmark.url,
    };
    return await db!.insert(BookmarkLocalDBService.table, row);
  }
}
