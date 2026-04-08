import 'package:equatable/equatable.dart';

enum TaskStatus { todo, inProgress, done }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'Todo';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }
}

class Task extends Equatable {
  final String id;
  final String title;
  final TaskStatus status;

  const Task({required this.id, required this.title, required this.status});

  Task copyWith({String? id, String? title, TaskStatus? status}) => Task(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [id, title, status];
}