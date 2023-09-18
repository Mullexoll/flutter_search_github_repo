import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/models/repository_model_item.dart';
import '../domain/models/search_repository_history.dart';
import '../domain/use_cases/open_isar_instance_history.use-case.dart';
import '../domain/use_cases/open_isar_instance_repository.use-case.dart';
import '../infrastructure/datasource/github_repositories.api.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  late Isar _isarRepository;

  RepositoryBloc() : super(RepositoryInitial()) {
    on<NavigateToSearchScreenEvent>(_navigateToSearchScreenEvent);
    on<PerformSearchEvent>(_performSearchEvent);
    on<AddRepositoryToFavoriteEvent>(_addRepositoryToFavoriteEvent);
    on<ClearFetchedRepositoriesEvent>(_clearFetchedRepositoriesEvent);
    on<RemoveRepositoryHistoryItemEvent>(_removeRepositoryHistoryItemEvent);
    on<AddRepositoryHistoryItemToFavoriteEvent>(
        _addRepositoryHistoryItemToFavoriteEvent);
  }

  FutureOr<void> _navigateToSearchScreenEvent(
    NavigateToSearchScreenEvent event,
    Emitter<RepositoryState> emit,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    _isarRepository = await Isar.open(
      [RepositoryModelSchema, SearchRepositoryHistorySchema],
      name: 'RepositoryIsarDB',
      directory: dir.path,
    );

    emit(RepositoryLoading());
    await Future.delayed(const Duration(seconds: 1));

    final List<RepositoryModel> favoriteRepositories =
        await IsarInstanceUseCase(_isarRepository).getAllRepositories();

    final List<SearchRepositoryHistory> searchHistory =
        await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
            .getAllRepositories();

    emit(RepositoryLoaded(
      fetchedRepositories: List.from([]),
      favoriteRepositories: favoriteRepositories,
      repositoryHistory: searchHistory,
      isSearchStarted: false,
    ));
  }

  FutureOr<void> _performSearchEvent(
    PerformSearchEvent event,
    Emitter<RepositoryState> emit,
  ) async {
    emit((state as RepositoryLoaded).copyWith(isSearchStarted: true));
    final repos = await Api.getRepositoriesWithSearchQuery(event.queryString);

    if (repos != null) {
      bool isDataWritten =
          await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
              .addRepositoryToIsar(
        repository: SearchRepositoryHistory(
          id: DateTime.now().millisecondsSinceEpoch,
          name: event.queryString,
          isFavorite: false,
        ),
      );

      if (isDataWritten) {
        final List<SearchRepositoryHistory> repositoryHistory =
            await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
                .getAllRepositories();

        emit((state as RepositoryLoaded).copyWith(
          fetchedRepositories: repos,
          repositoryHistory:
              repositoryHistory.isEmpty ? List.from([]) : repositoryHistory,
          isSearchStarted: false,
        ));
      }
    }
  }

  FutureOr<void> _addRepositoryToFavoriteEvent(
    AddRepositoryToFavoriteEvent event,
    Emitter<RepositoryState> emit,
  ) async {
    bool isDataWritten =
        await IsarInstanceUseCase(_isarRepository).addRepositoryToIsar(
            repository: RepositoryModel(
      id: event.repository.id,
      name: event.repository.name,
      isFavorite: true,
    ));

    if (isDataWritten) {
      final List<RepositoryModel> favoriteRepositories =
          await IsarInstanceUseCase(_isarRepository).getAllRepositories();

      emit(RepositoryLoaded(
        fetchedRepositories: (state as RepositoryLoaded).fetchedRepositories,
        favoriteRepositories: favoriteRepositories,
        repositoryHistory: (state as RepositoryLoaded).repositoryHistory,
        isSearchStarted: false,
      ));
    }
  }

  FutureOr<void> _clearFetchedRepositoriesEvent(
    ClearFetchedRepositoriesEvent event,
    Emitter<RepositoryState> emit,
  ) {
    emit(
      (state as RepositoryLoaded).copyWith(
        fetchedRepositories: [],
      ),
    );
  }

  FutureOr<void> _removeRepositoryHistoryItemEvent(
    RemoveRepositoryHistoryItemEvent event,
    Emitter<RepositoryState> emit,
  ) async {
    final _ = await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
        .deleteRepository(event.searchRepositoryHistory.id);

    final List<SearchRepositoryHistory> repositoryHistory =
        await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
            .getAllRepositories();

    emit(RepositoryLoaded(
      fetchedRepositories: (state as RepositoryLoaded).fetchedRepositories,
      favoriteRepositories: (state as RepositoryLoaded).favoriteRepositories,
      repositoryHistory: repositoryHistory,
      isSearchStarted: false,
    ));
  }

  FutureOr<void> _addRepositoryHistoryItemToFavoriteEvent(
    AddRepositoryHistoryItemToFavoriteEvent event,
    Emitter<RepositoryState> emit,
  ) async {
    bool isDataWritten =
        await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
            .addHistoryItemToFavorite(
      repositoryHistory: SearchRepositoryHistory(
        id: event.searchRepositoryHistory.id,
        name: event.searchRepositoryHistory.name,
        isFavorite: true,
      ),
    );

    if (isDataWritten) {
      final List<SearchRepositoryHistory> repositoryHistory =
          await RepositoryHistoryIsarInstanceUseCase(_isarRepository)
              .getAllRepositories();

      emit(RepositoryLoaded(
        fetchedRepositories: (state as RepositoryLoaded).fetchedRepositories,
        favoriteRepositories: (state as RepositoryLoaded).favoriteRepositories,
        repositoryHistory: repositoryHistory,
        isSearchStarted: false,
      ));
    }
  }
}
