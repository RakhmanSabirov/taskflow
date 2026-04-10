import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'features/tasks/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override


  Widget build(BuildContext context) {
    final repository = TaskRepositoryImpl();
    return BlocProvider(
      create: (_) => TasksCubit(
        getTasks: GetTasks(repository),
        addTask: AddTask(repository),
        updateTask: UpdateTask(repository),
      ),
      child: MaterialApp(
        title: 'TaskFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}