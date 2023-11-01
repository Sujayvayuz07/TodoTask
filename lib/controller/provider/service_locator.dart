import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:path_provider/path_provider.dart' as provider;
import 'package:todo_app/data/local/local_data_source.dart';
import 'package:todo_app/controller/provider/repo/todo_repository.dart';
import 'package:todo_app/controller/provider/repo/todo_repo.dart';
import 'package:todo_app/controller/provider/provider/todo_provider.dart';

final sl = GetIt.instance;
Future<void> init() async {
  Directory directory = await provider.getApplicationDocumentsDirectory();
// DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;
    hive.init(directory.path);
    hive.registerAdapter<Todo>(TodoAdapter());

    return hive;
  });

  //Change notifier
  sl.registerFactory(() => TodoListChangeNotifier(
        todoRepository: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<LocalDataSource>(
      () => DefaulteLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<TodoRepository>(() => DefaultTodoRepository(sl()));
}
