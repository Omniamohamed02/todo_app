import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/cubit/task_cubit.dart';
import 'package:todo_app/feature/cubit/task_state.dart';
import 'package:todo_app/feature/model/task.dart';
import 'package:todo_app/feature/view/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Task',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final newTask = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          if (newTask != null) {
            context.read<TaskCubit>().addTask(newTask);
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
            if(state is TaskLoaded){
            final tasks=state.tasks;
            if (tasks.isEmpty) {
      return Center(
        child: Text(
          'there is no tasks yet',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }  return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  Future.microtask(
                    () => context.read<TaskCubit>().deleteTask(index),
                  );
                },
                key: Key(tasks[index].id.toString()),
                child: ListViewItem(task: tasks[index], index: index),
              );
            },
          );}  else{
             return Center(child: Text('some thing went wrong'));
      }
        }
      );
    }
  }


class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key, required this.task, required this.index});

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Icon(task.category.icon, color: task.category.color),
              title: Text(task.title),
              content: Text(task.note),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('close', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isComplete ? TextDecoration.lineThrough : null,
          decorationThickness: 2,
        ),
      ),
      subtitle: Text(task.note, style: TextStyle(fontSize: 13)),
      trailing: Checkbox(
        activeColor: Colors.blue,
        value: task.isComplete,
        onChanged: (bool? newValue) {
          context.read<TaskCubit>().toggleTaskCompletion(index);
        },
      ),
      leading: Icon(task.category.icon, color: task.category.color),
    );
  }
}
