import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import '../widgets/nav_item.dart';
import '../widgets/stat_card.dart';
import '../widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().loadTasks();
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task title'),
          onSubmitted: (_) {
            context.read<TasksCubit>().newTask(controller.text);
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<TasksCubit>().newTask(controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.bolt, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'TaskFlow',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                NavItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  selected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                NavItem(
                  icon: Icons.check_circle_outline,
                  label: 'My Tasks',
                  selected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                NavItem(
                  icon: Icons.bar_chart_outlined,
                  label: 'Analytics',
                  selected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                NavItem(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  selected: _selectedIndex == 3,
                  onTap: () => setState(() => _selectedIndex = 3),
                ),
                const Spacer(),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.deepPurple,
                        child: Text('A',
                            style: TextStyle(color: Colors.white, fontSize: 13)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Admin',
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          Text('admin@taskflow.app',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: BlocBuilder<TasksCubit, TasksState>(
                builder: (context, state) {
                  if (state is! TasksLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final tasks = state.tasks;
                  final inProgress = tasks
                      .where((t) => t.status == TaskStatus.inProgress)
                      .length;
                  final done =
                      tasks.where((t) => t.status == TaskStatus.done).length;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good morning, Admin 👋',
                                style: theme.textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'You have $inProgress tasks in progress today.',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          FilledButton.icon(
                            onPressed: _showAddTaskDialog,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('New Task'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Stats
                      Row(
                        children: [
                          StatCard(
                            label: 'Total Tasks',
                            value: '${tasks.length}',
                            icon: Icons.list_alt,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 16),
                          StatCard(
                            label: 'In Progress',
                            value: '$inProgress',
                            icon: Icons.timelapse,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 16),
                          StatCard(
                            label: 'Completed',
                            value: '$done',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Task list
                      Text(
                        'Tasks',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: tasks.length,
                            separatorBuilder: (_, __) => const Divider(
                                height: 1, indent: 16, endIndent: 16),
                            itemBuilder: (_, index) =>
                                TaskListItem(task: tasks[index]),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}