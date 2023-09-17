import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'repository_model_item.g.dart';

@Collection(ignore: {'props'})
class RepositoryModel extends Equatable {
  final Id autoId = Isar.autoIncrement;
  @Index(
    unique: true,
  )
  final int id;
  final String name;
  final bool isFavorite;

  const RepositoryModel({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  static List<RepositoryModel> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList
        .map((r) => RepositoryModel(
              name: r['name'],
              isFavorite: false,
              id: r['id'],
            ))
        .toList();
  }

  @override
  List<Object?> get props => [name, isFavorite];
}
