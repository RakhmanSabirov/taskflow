import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;
  UpdateTask(this.repository);

  void call(Task task) => repository.updateTask(task);
}