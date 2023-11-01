import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/data/local/local_data_source.dart';
import 'package:todo_app/data/model/result.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/controller/provider/repo/todo_repo.dart';

class DefaultTodoRepository implements TodoRepository {
  final LocalDataSource? localDataSource;

  DefaultTodoRepository(this.localDataSource);

  @override
  Future<Result> getTodoById(String id) {
    return localDataSource!.getTodoById(id);
  }

  @override
  Future<Result> insertTodo(Todo todo) {
    return localDataSource!.insertTodo(todo as TodoModel);
  }

  @override
  Future<Result> updateTodo(Todo todo) {
    return localDataSource!.updateTodo(todo as TodoModel);
  }

  @override
  Future<Result> removeTodo(Todo todo) {
    return localDataSource!.removeTodo(todo as TodoModel);
  }

  @override
  Future<Result> getTaskList(String? filter) {
    return localDataSource!.getTaskList(filter);
  }
}
