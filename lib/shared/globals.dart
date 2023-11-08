// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

abstract class CustomColors {
  static const Color rectangle3600 = Color(0xFFE2F6C7);
  static const Color rectangle3601 = Color(0xFFFDE0D2);
  static const Color rectangle3602 = Color(0xFFFFD4E2);
}

const String BOOKMARK_LOCAL_STRAGE_KEY = 'bookmark';
const String BOOKMARK_TITLE = 'ブックマーク一覧';
const String RESIST_BOOKMARK_MODAL_TITLE = 'ブックマーク登録';
const String BOOKMARK_DEFAULT_TITLE = 'タイトル';

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
