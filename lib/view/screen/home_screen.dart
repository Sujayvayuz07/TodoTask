import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/view/component/custom_textfield.dart';
import 'package:todo_app/view/component/todo_widget.dart';
import 'package:todo_app/controller/provider/provider/todo_provider.dart';
import 'package:todo_app/view/screen/add_data_screen.dart';
import 'package:todo_app/view/apputils/date_conveter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<TodoListChangeNotifier>(context, listen: false).getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var changeNotifier =
        Provider.of<TodoListChangeNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataScreen(),
            ),
          );
          if (result == true) {
            await changeNotifier.getTodoList();
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchTextField(
              controller: searchController,
              hint: "Search",
              onChanged: (value) {
                if (value.isNotEmpty) {
                  changeNotifier.getTodoList(filter: value);
                } else {
                  changeNotifier.getTodoList();
                }
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<TodoListChangeNotifier>(
                builder: (context, notifier2, child) {
                  if (changeNotifier.taskList.isEmpty) {
                    return Center(
                      child: Text("No data Found"),
                    );
                  } else {
                    return StickyGroupedListView<Todo, String>(
                      elements: changeNotifier.taskList,
                      order: StickyGroupedListOrder.DESC,
                      groupBy: (Todo element) => DateConverter.groupFormator(
                          element.createdAtDate ?? ''),
                      groupComparator: (String value1, String value2) =>
                          value2.compareTo(value1),
                      itemComparator: (Todo element1, Todo element2) =>
                          DateConverter.groupFormator(
                                  element1.createdAtDate ?? '')
                              .compareTo(DateConverter.groupFormator(
                                  element2.createdAtDate ?? '')),
                      floatingHeader: true,
                      groupSeparatorBuilder: getGroup,
                      itemBuilder: (BuildContext context, todo) {
                        return TodoWidget(
                          todo: todo,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getGroup(Todo element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(
              color: Colors.yellow,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateConverter.groupFormator(element.createdAtDate ?? ''),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
