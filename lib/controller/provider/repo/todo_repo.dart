import 'package:todo_app/data/model/result.dart';
import 'package:todo_app/data/entities/todo.dart';

abstract class TodoRepository {
  Future<Result> insertTodo(Todo todo);
  Future<Result> removeTodo(Todo todo);
  Future<Result> getTodoById(String id);
  Future<Result> getTaskList(String? filter);
  Future<Result> updateTodo(Todo todo);
}
