part of 'repository_bloc.dart';

@immutable
sealed class RepositoryEvent extends Equatable {}

class NavigateToSearchScreenEvent extends RepositoryEvent {
  @override
  List<Object?> get props => [];
}

class PerformSearchEvent extends RepositoryEvent {
  final String queryString;

  PerformSearchEvent(this.queryString);

  @override
  List<Object?> get props => [queryString];
}

class AddRepositoryToFavoriteEvent extends RepositoryEvent {
  final RepositoryModel repository;

  AddRepositoryToFavoriteEvent(this.repository);

  @override
  List<Object?> get props => [];
}

class ClearFetchedRepositoriesEvent extends RepositoryEvent {
  @override
  List<Object?> get props => [];
}

class RemoveRepositoryHistoryItemEvent extends RepositoryEvent {
  final SearchRepositoryHistory searchRepositoryHistory;

  RemoveRepositoryHistoryItemEvent(this.searchRepositoryHistory);

  @override
  List<Object?> get props => [searchRepositoryHistory];
}

class AddRepositoryHistoryItemToFavoriteEvent extends RepositoryEvent {
  final SearchRepositoryHistory searchRepositoryHistory;

  AddRepositoryHistoryItemToFavoriteEvent(this.searchRepositoryHistory);

  @override
  List<Object?> get props => [searchRepositoryHistory];
}
