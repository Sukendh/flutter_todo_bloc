import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool? isCompleted;

  Todo({this.id, this.title, this.description, this.isCompleted});

  Todo toggleCompletion() {
    return Todo(
      id: id,
      title: title,
      description: description,
      isCompleted: !isCompleted!,
    );
  }
}
