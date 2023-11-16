import 'package:flutter_project/features/bookmark/data/bookmark_local_datasource.dart';
import 'package:flutter_project/features/bookmark/data/bookmark_repository.dart';

// final bookmarkDataSourceProvider =
//     Provider.family<BookmarkDataSource, BookmarkLocalDBService>(
//   (_, localDB) => BookmarkLocalDatasource(localDB),
// );

// final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
//   final localDB = BookmarkLocalDBService.instance;
//   final datasource = ref.watch(bookmarkDataSourceProvider(localDB));

//   final repository = BookmarkRepository(datasource);

//   return repository;
// });

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_provider.g.dart';

@riverpod
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) {
  return BookmarkRepository(BookmarkLocalDatasource());
}
