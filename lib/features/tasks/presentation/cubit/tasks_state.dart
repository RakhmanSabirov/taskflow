import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  const TasksLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}