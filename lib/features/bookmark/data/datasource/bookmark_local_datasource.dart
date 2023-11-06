import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/models/bookmark_model.dart';

abstract class BookmarkDataSource {
  String get storageKey;

  Future<Either<AppException, Bookmark>> fetchBookmarks();
  Future<bool> saveBookmark({required Bookmark bookmark});
  Future<bool> deleteBookmark();
  Future<bool> hasBookmark();
}

class BookmarkLocalDatasource extends BookmarkDataSource {
  BookmarkLocalDatasource(this.stroageService);

  final StroageService stroageService;

  @override
  String get storageKey => BOOKMARK_LOCAL_STRAGE_KEY;

  @override
  Future<Either<AppException, Bookmark>> fetchBookmarks() async {
    final data = await stroageService.get(storageKey);
    if (data == null) {
      return Left(
        AppException(
          identifier: 'BookmarkLocalDatasource',
          statusCode: 404,
          message: 'Bookmark not found',
        ),
      );
    }
    final bookmarkJson = jsonDecode(data.toString());

    return Right(Bookmark.fromJson(bookmarkJson));
  }

  @override
  Future<bool> saveBookmark({required Bookmark bookmark}) async {
    
    return await stroageService.set(storageKey, jsonEncode(bookmark.toJson()));
  }

  @override
  Future<bool> deleteBookmark() async {
    return await stroageService.remove(storageKey);
  }

  @override
  Future<bool> hasBookmark() async {
    return await stroageService.has(storageKey);
  }
}
