import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/data/local/bookmark_local_db_service.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BookmarkDataSource {
  Future<Either<Object, List<Bookmark>>> fetchBookmarks();
  Future<Either<Object, int>> insertBookmark(Bookmark bookmark);
  Future<Either<Object, int>> deleteBookmark(Bookmark bookmark);
  Future<Either<Object, int>> updateBookmark(Bookmark bookmark);
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
  Future<Either<Object, List<Bookmark>>> fetchBookmarks() async {
    final Database? db = await localDB.database;
    try {
      List<Map<String, dynamic>> results =
          await db!.query(BookmarkLocalDBService.table);
      List<Bookmark> bookmarkList = results
          .map((result) => Bookmark(
              id: result[BookmarkColumns.id].toString(),
              title: result[BookmarkColumns.title],
              url: result[BookmarkColumns.url]))
          .toList();
      return Right(bookmarkList);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Object, int>> insertBookmark(Bookmark bookmark) async {
    final Database? db = await localDB.database;
    try {
      final String? title = (bookmark.title?.isNotEmpty == true)
          ? bookmark.title
          : BOOKMARK_DEFAULT_TITLE;
      Map<String, dynamic> row = {
        BookmarkColumns.title: title,
        BookmarkColumns.url: bookmark.url,
      };
      return Right(await db!.insert(BookmarkLocalDBService.table, row));
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Object, int>> deleteBookmark(Bookmark bookmark) async {
    final Database? db = await localDB.database;
    try {
      return Right(await db!.delete(BookmarkLocalDBService.table,
          where: "id = ?", whereArgs: [bookmark.id]));
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Object, int>> updateBookmark(Bookmark bookmark) async {
    final Database? db = await localDB.database;
    try {
      Map<String, dynamic> row = {
        BookmarkColumns.id: bookmark.id,
        BookmarkColumns.title: bookmark.title,
        BookmarkColumns.url: bookmark.url,
      };
      return Right(await db!.update(BookmarkLocalDBService.table, row,
          where: "id = ?", whereArgs: [bookmark.id]));
    } catch (e) {
      return Left(e);
    }
  }
}
