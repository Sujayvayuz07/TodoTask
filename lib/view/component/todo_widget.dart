import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/controller/provider/provider/todo_provider.dart';
import 'package:todo_app/view/screen/add_data_screen.dart';
import 'package:todo_app/view/screen/task_details_screen.dart';

class TodoWidget extends StatelessWidget {
  final Todo? todo;
  const TodoWidget({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var changeNotifier =
        Provider.of<TodoListChangeNotifier>(context, listen: true);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TodoDetailsScreen(
                      todo: todo,
                    )));
      },
      child: Card(
        color: Colors.grey.shade300,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    todo?.title ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Provider.of<TodoListChangeNotifier>(context,
                              listen: false)
                          .removeData(TodoModel(
                              id: todo!.id,
                              title: todo!.title,
                              description: todo!.description,
                              createdAtDate: todo!.createdAtDate));
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      var response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDataScreen(
                            todo: todo,
                          ),
                        ),
                      );
                      if (response == true) {
                        await changeNotifier.getTodoList();
                      }
                    },
                    child: Icon(
                      Icons.edit_document,
                      size: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      todo?.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  todo?.createdAtDate ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
