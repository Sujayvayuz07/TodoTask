import 'package:todo_app/data/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String? id,
    required String? title,
    required String? description,
    required String? createdAtDate,
  }) : super(
            id: id,
            title: title,
            description: description,
            createdAtDate: createdAtDate);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAtDate: json['createdAtDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAtDate": createdAtDate,
    };
  }
}
