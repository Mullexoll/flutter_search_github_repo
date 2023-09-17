import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'search_repository_history.g.dart';

@Collection(ignore: {'props'})
class SearchRepositoryHistory extends Equatable {
  final Id autoId = Isar.autoIncrement;
  @Index(
    unique: true,
  )
  final int id;
  final String name;
  final bool isFavorite;

  const SearchRepositoryHistory({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [id, name, isFavorite];
}
