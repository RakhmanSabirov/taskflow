import '../../domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final TaskStatus status;

  const TaskModel({required this.id, required this.title, required this.status});

  Task toEntity() => Task(id: id, title: title, status: status);

  factory TaskModel.fromEntity(Task task) =>
      TaskModel(id: task.id, title: task.title, status: task.status);
}