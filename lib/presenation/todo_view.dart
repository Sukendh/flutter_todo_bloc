import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/models/todo_model.dart';
import 'package:flutter_todo_bloc/presenation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, List<Todo>>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 11,
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            shadowColor: Colors.deepPurpleAccent,
            flexibleSpace: Container(
              margin: EdgeInsets.only(top: 80.0, left: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Todo',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text(
                      "${state.where((element) => element.isCompleted == true).toList().length}/${state.length.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ListView.builder(
                itemCount: state.length, // Placeholder for the number of items
                itemBuilder: (context, index) {
                  final todoItem = state[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      context.read<TodoCubit>().deleteTodo(todoItem);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${todoItem.title} is deleted...')));
                    },
                    key: Key(todoItem.title!),
                    background: Container(padding: EdgeInsets.only(right: 20.0),alignment: Alignment.centerRight, color: Colors.red,child: Icon(Icons.delete),),
                    child: ListTile(
                      title: Text(
                        todoItem.title!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        todoItem.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: InkWell(
                        child: todoItem.isCompleted!
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Icon(Icons.check_box),
                          onTap: () => context.read<TodoCubit>().toggleCompletion(todoItem.key, todoItem),
                      ),
                      
                    ),
                  );
                },
              ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAnimatedDialog(context),
            tooltip: 'Increment',
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _showAnimatedDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final todoCubit = context.read<TodoCubit>();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Todo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter a title and description below',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            String title = titleController.text.trim();
                            String desc = descriptionController.text.trim();
                            if (title.isNotEmpty && desc.isNotEmpty) {
                              print("Title: $title\nDescription: $desc");
                              todoCubit.addTodo(title, desc);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, -1),
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}
