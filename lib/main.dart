import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/feature/cubit/task_cubit.dart';
import 'package:todo_app/feature/model/task.dart';
import 'package:todo_app/feature/view/home_screen.dart';
import 'package:todo_app/core/utils/task_category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskCategoryAdapter());
  await Hive.openBox<Task>('tasks');
 

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
 
  @override
  Widget build(BuildContext context) {
     final taskBox= Hive.box<Task>('tasks');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TaskCubit(taskBox),
        child: HomeScreen(),
      ),
    );
  }
}
