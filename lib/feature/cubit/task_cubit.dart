import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/feature/cubit/task_state.dart';
import 'package:todo_app/feature/model/task.dart';


class TaskCubit extends Cubit<TaskState> {
  final Box <Task> taskBox;
  TaskCubit(this.taskBox) : super(TaskLoaded(taskBox.values.toList()));

  
  void _loadTasks() {
    emit(TaskLoaded(taskBox.values.toList()));
  }
  void addTask(Task newTask){
    taskBox.add(newTask);
   _loadTasks();
  }
  void deleteTask(int index){
    taskBox.deleteAt(index);
   _loadTasks();
  }
  void toggleTaskCompletion(int index){
    final task=taskBox.getAt(index);
    if(task !=null){
      final updateTask=task.copyWith(
        isComplete: !task.isComplete
      );
      taskBox.putAt(index, updateTask);
      _loadTasks();
    }
  }
 
}
