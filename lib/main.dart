import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<_Task> _tasks = [
    _Task('Design new landing page', 'In Progress', Colors.orange),
    _Task('Fix login bug', 'Done', Colors.green),
    _Task('Write unit tests', 'Todo', Colors.blue),
    _Task('Code review PR #42', 'In Progress', Colors.orange),
    _Task('Deploy to staging', 'Todo', Colors.blue),
  ];

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
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _NavItem(icon: Icons.home_outlined, label: 'Home', selected: _selectedIndex == 0, onTap: () => setState(() => _selectedIndex = 0)),
                _NavItem(icon: Icons.check_circle_outline, label: 'My Tasks', selected: _selectedIndex == 1, onTap: () => setState(() => _selectedIndex = 1)),
                _NavItem(icon: Icons.bar_chart_outlined, label: 'Analytics', selected: _selectedIndex == 2, onTap: () => setState(() => _selectedIndex = 2)),
                _NavItem(icon: Icons.settings_outlined, label: 'Settings', selected: _selectedIndex == 3, onTap: () => setState(() => _selectedIndex = 3)),
                const Spacer(),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 16, backgroundColor: Colors.deepPurple, child: Text('A', style: TextStyle(color: Colors.white, fontSize: 13))),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Admin', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                          Text('admin@taskflow.app', style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good morning, Admin 👋', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('You have 3 tasks in progress today.', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('New Task'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Stats cards
                  Row(
                    children: [
                      _StatCard(label: 'Total Tasks', value: '${_tasks.length}', icon: Icons.list_alt, color: Colors.deepPurple),
                      const SizedBox(width: 16),
                      _StatCard(label: 'In Progress', value: '${_tasks.where((t) => t.status == 'In Progress').length}', icon: Icons.timelapse, color: Colors.orange),
                      const SizedBox(width: 16),
                      _StatCard(label: 'Completed', value: '${_tasks.where((t) => t.status == 'Done').length}', icon: Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Task list
                  Text('Tasks', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: _tasks.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
                        itemBuilder: (context, index) {
                          final task = _tasks[index];
                          return ListTile(
                            leading: Checkbox(
                              value: task.status == 'Done',
                              onChanged: (v) => setState(() => task.status = v! ? 'Done' : 'Todo'),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.status == 'Done' ? TextDecoration.lineThrough : null,
                                color: task.status == 'Done' ? Colors.grey : null,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: task.color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(task.status, style: TextStyle(color: task.color, fontSize: 12, fontWeight: FontWeight.w600)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Task {
  final String title;
  String status;
  final Color color;
  _Task(this.title, this.status, this.color);
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = selected ? Theme.of(context).colorScheme.primary : Colors.grey;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(color: color, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
