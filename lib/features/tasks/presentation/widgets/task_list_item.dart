import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../cubit/tasks_cubit.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  Color _statusColor() {
    switch (task.status) {
      case TaskStatus.todo:
        return Colors.blue;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();
    return ListTile(
      leading: Checkbox(
        value: task.status == TaskStatus.done,
        onChanged: (_) => context.read<TasksCubit>().toggleTask(task),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.status == TaskStatus.done
              ? TextDecoration.lineThrough
              : null,
          color: task.status == TaskStatus.done ? Colors.grey : null,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          task.status.label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}