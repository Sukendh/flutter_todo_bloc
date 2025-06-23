import 'package:flutter_todo_bloc/data/models/todo_model.dart';
import 'package:flutter_todo_bloc/domain/repository/todo_repo.dart';
import 'package:hive/hive.dart';

class HiveTodoRepo implements TodoRepo{

  static const boxName = "todo_box";

  @override
  Future<void> addTodo(Todo todo)async {
    final todoBox = await Hive.openBox<Todo>(boxName);
    todoBox.add(todo);
  }

  @override
  Future<void> deleteTodo(Todo todo)async {
    final todoBox = await Hive.openBox<Todo>(boxName);
    todoBox.delete(todo.key);
  }

  @override
  Future<List<Todo>> getTodos()async {
    final todoBox = await Hive.openBox<Todo>(boxName);
    return todoBox.values.toList();

  }

  @override
  Future<void> updateTodo(int key, Todo todo)async  {
    final todoBox = await Hive.openBox<Todo>(boxName);
    print("KEY ==. ${key}");
    todoBox.put(key, todo);
  }



}