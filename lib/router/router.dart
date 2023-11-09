import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/presentation/screens/bookmark_screen.dart';
import 'package:flutter_project/features/browser/presentation/screens/browser_screen.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: Locations.home.path,
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: Locations.home.path,
      name: Locations.home.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const BookmarkScreen(),
        );
      },
    ),
    GoRoute(
      path: Locations.browser.path,
      name: Locations.browser.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const BrowserScreen(),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
