import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<TaskModel> _tasks = [
    TaskModel(id: '1', title: 'Design new landing page', status: TaskStatus.inProgress),
    TaskModel(id: '2', title: 'Fix login bug', status: TaskStatus.done),
    TaskModel(id: '3', title: 'Write unit tests', status: TaskStatus.todo),
    TaskModel(id: '4', title: 'Code review PR #42', status: TaskStatus.inProgress),
    TaskModel(id: '5', title: 'Deploy to staging', status: TaskStatus.todo),
  ];

  @override
  List<Task> getTasks() => _tasks.map((m) => m.toEntity()).toList();

  @override
  void addTask(String title) {
    _tasks.add(TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      status: TaskStatus.todo,
    ));
  }

  @override
  void updateTask(Task task) {
    final index = _tasks.indexWhere((m) => m.id == task.id);
    if (index != -1) _tasks[index] = TaskModel.fromEntity(task);
  }
}