// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_project/shared/models/location_model.dart';

abstract class CustomColors {
  static const Color rectangle3600 = Color(0xFFE2F6C7);
  static const Color rectangle3601 = Color(0xFFFDE0D2);
  static const Color rectangle3602 = Color(0xFFFFD4E2);
}

const String APP_TITLE = 'Inst Browser App';
const String DATABASE_NAME = 'local_storage.db';
const String BOOKMARK_TABLE_NAME = 'bookmarks';
const String BOOKMARK_LOCAL_STRAGE_KEY = 'bookmark';
const String BOOKMARK_DEFAULT_TITLE = 'タイトル';
const String WHERE_ID = 'id = ?';

class Mode {
  static const String regist = 'REGIST';
  static const String update = 'UPDATE';
}

class Locations {
  static const Location home = Location(path: '/', name: 'bookmark');
  static const Location browser = Location(path: '/browser', name: 'browser');
}

abstract class Sizing {
  static const double titleSize = 24.0;
  static const double labelSize = 20.0;
  static const double textSize = 16.0;
  static const double paddingSize = 10.0;
  static const EdgeInsets defaultInsets = EdgeInsets.all(12.0);
}

class Style {
  static const boldStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

class Limits {
  static const int maxUrlLength = 200;
  static const int maxBookmarkCount = 20;
}

class BookmarkColumns {
  static String id = 'id';
  static String title = 'title';
  static String url = 'url';
}
