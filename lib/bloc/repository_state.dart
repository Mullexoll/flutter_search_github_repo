part of 'repository_bloc.dart';

@immutable
sealed class RepositoryState extends Equatable {}

final class RepositoryInitial extends RepositoryState {
  @override
  List<Object?> get props => [];
}

final class RepositoryLoading extends RepositoryState {
  @override
  List<Object?> get props => [];
}

final class RepositoryLoaded extends RepositoryState {
  final List<RepositoryModel> fetchedRepositories;
  final List<RepositoryModel> favoriteRepositories;
  final List<SearchRepositoryHistory> repositoryHistory;
  final bool isSearchStarted;

  RepositoryLoaded({
    required this.fetchedRepositories,
    required this.favoriteRepositories,
    required this.repositoryHistory,
    required this.isSearchStarted,
  });

  RepositoryLoaded copyWith({
    List<RepositoryModel>? fetchedRepositories,
    List<RepositoryModel>? favoriteRepositories,
    List<SearchRepositoryHistory>? repositoryHistory,
    bool? isSearchStarted,
  }) {
    return RepositoryLoaded(
      fetchedRepositories: fetchedRepositories ?? this.fetchedRepositories,
      favoriteRepositories: favoriteRepositories ?? this.favoriteRepositories,
      repositoryHistory: repositoryHistory ?? this.repositoryHistory,
      isSearchStarted: isSearchStarted ?? this.isSearchStarted,
    );
  }

  @override
  List<Object?> get props => [
        identityHashCode(fetchedRepositories),
        identityHashCode(favoriteRepositories),
        identityHashCode(repositoryHistory),
        identityHashCode(isSearchStarted),
      ];
}
