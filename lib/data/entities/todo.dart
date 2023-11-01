import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAtDate,
  });

  @HiveField(0)
  final String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? createdAtDate;

  /// create new Task
  factory Todo.create({
    required String? title,
    required String? subtitle,
    required String? createdAtDate,
  }) =>
      Todo(
        id: const Uuid().v1(),
        title: title ?? "",
        description: subtitle ?? "",
        createdAtDate: createdAtDate ?? "",
      );
}
