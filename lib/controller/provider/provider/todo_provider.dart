import 'package:flutter/material.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/controller/provider/repo/todo_repo.dart';

class TodoListChangeNotifier extends ChangeNotifier {
  final TodoRepository? todoRepository;
  TodoListChangeNotifier({this.todoRepository});

  final List<Todo> _todoList = [];
  List<Todo> get taskList => _todoList;

  Future<void> getTodoList({String? filter}) async {
    var data = await todoRepository!.getTaskList(filter);
    _todoList.clear();
    _todoList.addAll(data.data);
    refresh();
  }

  Future<void> insertData(Todo todo) async {
    await todoRepository!.insertTodo(todo);
    refresh();
  }

  void removeFromList(Todo todo) {
    _todoList.removeWhere((element) => element.id == todo.id);
    notifyListeners();
  }

  Future<void> updateData(Todo todo) async {
    await todoRepository!.updateTodo(todo);
    refresh();
  }

  Future<void> removeData(Todo todo) async {
    await todoRepository!.removeTodo(todo);
    removeFromList(todo);
    refresh();
  }

  refresh() {
    notifyListeners();
  }
}
