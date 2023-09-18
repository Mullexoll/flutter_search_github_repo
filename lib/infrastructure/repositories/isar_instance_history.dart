import 'package:isar/isar.dart';
import 'package:search_github_repo_flutter/domain/models/search_repository_history.dart';

class RepositoryHistoryIsarInstanceUseCase {
  final IsarCollection<SearchRepositoryHistory> _storage;
  final Isar _isar;

  RepositoryHistoryIsarInstanceUseCase(this._isar)
      : _storage = _isar.collection<SearchRepositoryHistory>();

  Future<bool> addRepositoryToIsar({
    required SearchRepositoryHistory repository,
  }) async {
    final foundRepository = await _storage.getById(repository.id);

    if (foundRepository == null) {
      await _isar.writeTxn(() async => await _storage.put(repository));
    } else {
      if (foundRepository.isFavorite && foundRepository.id == repository.id) {
        await _isar
            .writeTxn(() async => await _storage.deleteById(repository.id));
      }
    }

    return true;
  }

  Future<bool> addHistoryItemToFavorite({
    required SearchRepositoryHistory repositoryHistory,
  }) async {
    final foundRepository = await _storage.getById(repositoryHistory.id);

    if (foundRepository != null && !foundRepository.isFavorite) {
      await _isar.writeTxn(
        () async => await _storage.deleteById(repositoryHistory.id),
      );
      await _isar.writeTxn(() async => await _storage.put(repositoryHistory));
    } else {
      await _isar.writeTxn(
        () async => await _storage.deleteById(repositoryHistory.id),
      );
      await _isar.writeTxn(
        () async => await _storage.put(
          SearchRepositoryHistory(
            id: repositoryHistory.id,
            name: repositoryHistory.name,
            isFavorite: false,
          ),
        ),
      );
    }

    return true;
  }

  Future<List<SearchRepositoryHistory>> getAllRepositories() {
    final foundRepositories = _storage.where().findAll();

    return foundRepositories;
  }

  Future<bool> deleteRepository(int id) async {
    await _isar.writeTxn(() async {
      final _ = await _storage.deleteById(id);
    });

    return true;
  }
}
