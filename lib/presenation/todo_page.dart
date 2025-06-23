import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/domain/repository/hive_todo_repo.dart';
import 'package:flutter_todo_bloc/presenation/todo_cubit.dart';
import 'package:flutter_todo_bloc/presenation/todo_view.dart';

class TodoPage extends StatelessWidget {

  final HiveTodoRepo todoRepo;
  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TodoCubit(todoRepo), child: TodoView(),);
  }
}