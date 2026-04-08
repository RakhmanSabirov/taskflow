import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;
  AddTask(this.repository);

  void call(String title) => repository.addTask(title);
}