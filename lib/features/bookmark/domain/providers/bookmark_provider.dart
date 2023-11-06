import 'package:flutter_project/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:flutter_project/features/bookmark/data/repositories/bookmark_repository_impl.dart';
import 'package:flutter_project/features/bookmark/domain/repositories/bookmark_repository.dart';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/providers/sharedpreferences_storage_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkDatasourceProvider =
    Provider.family<BookmarkDataSource, StroageService>(
  (_, networkService) => BookmarkLocalDatasource(networkService),
);

final bookmarkLocalRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final datasource = ref.watch(bookmarkDatasourceProvider(storageService));

  final respository = BookmarkRepositoryImpl(datasource);

  return respository;
});
