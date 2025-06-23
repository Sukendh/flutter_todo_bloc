import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/models/todo_model.dart';
import 'package:flutter_todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{

  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }
  
  Future<void> loadTodos()async {
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  Future<void> addTodo(String title, String description, ) async {
    print(DateTime.now().millisecondsSinceEpoch);
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isCompleted: false
    );
    todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletion(int key, Todo todo)async {
    final updatedTodo = todo.toggleCompletion();
    todoRepo.updateTodo(todo.key,updatedTodo);
    loadTodos();
  }

  Future<void> updateTodo(int id, String title, String description, bool isCompleted) async {
     final newTodo = Todo(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted
    );
    todoRepo.addTodo(newTodo);
    loadTodos();
  }

  




}