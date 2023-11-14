import 'package:flutter_project/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:flutter_project/features/bookmark/data/repositories/bookmark_repository_impl.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/shared/data/local/bookmark_local_db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkDataSourceProvider =
    Provider.family<BookmarkDataSource, BookmarkLocalDBService>(
  (_, localDB) => BookmarkLocalDatasource(localDB),
);

final bookmarkLocalRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final localDB = BookmarkLocalDBService.instance;
  final datasource = ref.watch(bookmarkDataSourceProvider(localDB));

  final repository = BookmarkRepositoryImpl(datasource);

  return repository;
});
