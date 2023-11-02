import 'package:flutter/material.dart';
import 'package:flutter_project/features/bookmark/presentation/screens/bookmark_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/',
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: '/',
      name: 'bookmark',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const BookmarkScreen(),
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
