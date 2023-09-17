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

  RepositoryLoaded({
    required this.fetchedRepositories,
    required this.favoriteRepositories,
    required this.repositoryHistory,
  });

  RepositoryLoaded copyWith({
    List<RepositoryModel>? fetchedRepositories,
    List<RepositoryModel>? favoriteRepositories,
    List<SearchRepositoryHistory>? repositoryHistory,
  }) {
    return RepositoryLoaded(
      fetchedRepositories: fetchedRepositories ?? this.fetchedRepositories,
      favoriteRepositories: favoriteRepositories ?? this.favoriteRepositories,
      repositoryHistory: repositoryHistory ?? this.repositoryHistory,
    );
  }

  @override
  List<Object?> get props => [
        identityHashCode(fetchedRepositories),
        identityHashCode(favoriteRepositories),
        identityHashCode(repositoryHistory),
      ];
}
