import '../entities/task.dart';

abstract class TaskRepository {
  List<Task> getTasks();
  void addTask(String title);
  void updateTask(Task task);
}