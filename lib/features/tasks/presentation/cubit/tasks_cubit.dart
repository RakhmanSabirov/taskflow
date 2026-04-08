import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;

  TasksCubit({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
  }) : super(const TasksInitial());

  void loadTasks() => emit(TasksLoaded(getTasks()));

  void toggleTask(Task task) {
    final newStatus =
        task.status == TaskStatus.done ? TaskStatus.todo : TaskStatus.done;
    updateTask(task.copyWith(status: newStatus));
    loadTasks();
  }

  void newTask(String title) {
    if (title.trim().isEmpty) return;
    addTask(title.trim());
    loadTasks();
  }
}