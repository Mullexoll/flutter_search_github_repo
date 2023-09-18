import 'package:isar/isar.dart';
import 'package:search_github_repo_flutter/domain/models/repository_model_item.dart';

class IsarInstanceUseCase {
  final IsarCollection<RepositoryModel> _storage;
  final Isar _isar;

  IsarInstanceUseCase(this._isar)
      : _storage = _isar.collection<RepositoryModel>();

  Future<bool> addRepositoryToIsar({
    required RepositoryModel repository,
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

  Future<List<RepositoryModel>> getAllRepositories() {
    final foundRepositories = _storage.where().findAll();

    return foundRepositories;
  }

  void deleteRepository(int id) async {
    await _isar.writeTxn(() async {
      final _ = await _storage.delete(id);
    });
  }
}
