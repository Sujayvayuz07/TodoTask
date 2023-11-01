import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/data/model/result.dart';
import 'package:todo_app/data/model/todo_model.dart';

abstract class LocalDataSource {
  Future<Result> getTodoById(String id);
  Future<Result> insertTodo(TodoModel todo);
  Future<Result> updateTodo(TodoModel todo);
  Future<Result> removeTodo(TodoModel todo);
  Future<Result> getTaskList(String? filter);
}

class DefaulteLocalDataSource implements LocalDataSource {
  final HiveInterface? hiveInterface;

  DefaulteLocalDataSource(this.hiveInterface);

  @override
  Future<Result> getTodoById(String? id) async {
    final todoBox = await hiveInterface!.openBox("TodoBox");

    final todo = await todoBox.get(id);
    return Result.completed(todo as Todo?);
  }

  @override
  Future<Result> insertTodo(TodoModel todo) async {
    final todoBox = await hiveInterface!.openBox("TodoBox");
    todoBox.put(todo.id, todo);
    return Result.completed(todo.id);
  }

  @override
  Future<Result> updateTodo(TodoModel todo) async {
    final todoBox = await hiveInterface!.openBox("TodoBox");
    todoBox.put(todo.id, todo);
    return Result.completed(todo.id);
  }

  @override
  Future<Result> removeTodo(TodoModel todo) async {
    final todoBox = await hiveInterface!.openBox("TodoBox");

    await todoBox.delete(todo.id);
    return Result.completed("Todo has been well removed");
  }

  @override
  Future<Result> getTaskList(String? filter) async {
    final todoBox = await hiveInterface!.openBox("TodoBox");

    final todos = filter != null && filter.isNotEmpty
        ? todoBox.values.toList().cast<Todo>().where((element) =>
            (element.title?.contains(filter) ?? false) ||
            (element.description?.contains(filter) ?? false))
        : todoBox.values.toList().cast<Todo>();

    return Result.completed(todos);
  }
}
