import 'package:flutter_todo_bloc/data/models/todo_model.dart';

abstract class TodoRepo {

  Future<List<Todo>> getTodos();

  Future<void> addTodo(Todo todo);

  Future<void> updateTodo(int key, Todo todo);

  Future<void> deleteTodo(Todo todo);
}
