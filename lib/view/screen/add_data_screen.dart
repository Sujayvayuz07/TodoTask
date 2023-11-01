import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/entities/todo.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/view/component/custom_textfield.dart';
import 'package:todo_app/controller/provider/provider/todo_provider.dart';
import 'package:todo_app/view/apputils/date_conveter.dart';
import 'package:uuid/uuid.dart';

class AddDataScreen extends StatefulWidget {
  final Todo? todo;
  const AddDataScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? date;
  final FocusNode _title = FocusNode();
  final FocusNode _description = FocusNode();
  bool isTitleFilled = false;
  var titleValidationError = '';

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateController.text = DateConverter.formatDate(DateTime.now());
    if (widget.todo != null) {
      titleController.text = widget.todo?.title ?? '';
      descriptionController.text = widget.todo?.description ?? '';
      dateController.text = widget.todo?.createdAtDate ??
          DateConverter.formatDate(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    var changeNotifier = Provider.of<TodoListChangeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            CustumTextField(
              label: "Title",
              hint: "Enter Title",
              controller: titleController,
              focusNode: _title,
              nextFocus: _description,
              inputType: TextInputType.text,
              maxLength: 50,
              validate: isTitleFilled,
              errorLabel: titleValidationError,
              maxLines: 1,
            ),
            SizedBox(
              height: 15,
            ),
            CustumTextField(
              hint: "Enter  Description",
              label: "Description(Optional)",
              focusNode: _description,
              controller: descriptionController,
              inputType: TextInputType.multiline,
            ),
            SizedBox(
              height: 15,
            ),
            CustumTextField(
              hint: "Select Date",
              label: "Date",
              controller: dateController,
              readOnly: true,
              onTap: () => showDatePicker(),
              inputType: TextInputType.datetime,
            ),
            SizedBox(height: 10),
            Spacer(),
            TextButton(
              onPressed: () {
                addList(changeNotifier);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
                height: 50,
                child: Center(
                    child: Text(
                  widget.todo != null ? "Update Task" : "Add Task",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2035, 3, 5),
        onChanged: (_) {}, onConfirm: (selectedDatee) {
      setState(() {
        if (widget.todo?.createdAtDate == null) {
          date = selectedDatee;
        } else {
          widget.todo!.createdAtDate = DateConverter.formatDate(selectedDatee);
        }
        dateController.text = DateConverter.formatDate(selectedDatee);
      });
      FocusManager.instance.primaryFocus?.unfocus();
    }, currentTime: showDateAsDateTime(date));
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.todo?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return DateConverter.changeStringTodateTime(
          widget.todo!.createdAtDate ?? '');
    }
  }

  void addList(TodoListChangeNotifier changeNotifier) async {
    var title = titleController.text.trim();
    isTitleFilled = false;
    if (title.isEmpty) {
      setState(() {
        titleValidationError = 'Enter task title';
        isTitleFilled = true;
      });
    } else {
      if (widget.todo != null) {
        widget.todo!.title = title;
        widget.todo!.description = descriptionController.text;
        widget.todo!.save();
      } else {
        TodoModel todo = TodoModel(
          id: Uuid().v1(),
          title: titleController.text,
          description: descriptionController.text,
          createdAtDate: dateController.text,
        );
        await changeNotifier.insertData(todo);
      }
      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }
}
