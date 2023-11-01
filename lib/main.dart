import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/provider/provider/todo_provider.dart';
import 'package:todo_app/view/screen/home_screen.dart';
import 'controller/provider/service_locator.dart' as serviceLocator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => serviceLocator.sl<TodoListChangeNotifier>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
