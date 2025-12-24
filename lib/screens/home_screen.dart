import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/data/task.dart';
import 'package:todo_app/screens/add_task_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  late Box <Task> taskBox;
   @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }
  void _addTask( Task newTask){
    setState(() {
       taskBox.add(newTask);
    });
  }
  void _removeTask( int index){
    setState(() {
       taskBox.deleteAt(index);
    });
   
  }
  void _toggleTaskCompletion(int index) {
    final task = taskBox.getAt(index);
    if (task != null) {
      final updatedTask = task.copyWith(
        isComplete: !task.isComplete
      );
      taskBox.putAt(index, updatedTask);
    }
  }
   
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(title:  Text(
          'My Task',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),
        centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
        final newTask= await Navigator.push<Task>(
            context, 
            MaterialPageRoute(builder: (context)=>  AddTaskScreen()
            ));
            if(newTask!=null){
              _addTask(newTask);
            }
        },
         child: Icon(Icons.add , color: Colors.white,),
      ),
      body:ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          return HomeBody(
            toggle: _toggleTaskCompletion,
            delete: _removeTask,
            tasks: box.values.toList(),
          );
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
   const HomeBody({super.key, required this.toggle ,required this.delete, required this.tasks});
   final List<Task> tasks;
  final Function(int) toggle;
  final Function(int) delete;

  @override
  Widget build(BuildContext context) {
    if( tasks.isEmpty){
      
    return Center(child: Text('there is no tasks yet' ,style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold),),);}
      else{
     return  ListView.builder(
        itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.horizontal,
          onDismissed:(direction) {
            Future.microtask(()=> delete(index));
            },
          key:Key(tasks[index].id.toString()) ,
          child: ListViewItem(task:tasks[index], toggle: toggle,index: index,));
      },);
  }}
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key, required this.task ,required this.toggle, required this.index});

final Task task;
final int index;
final Function(int) toggle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
          onTap: () {
           showDialog(
            context: context, 
          builder: (BuildContext context){
            return AlertDialog(
               icon: Icon(task.category.icon , color: task.category.color),
                    title: Text(task.title),
                    content: Text(task.note),
                    actions: [
                      Center(child: ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('close',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),))
                    ],
            );
          });
          },
          title: Text(task.title,style: TextStyle(
            decoration: task.isComplete? TextDecoration.lineThrough:null,
            decorationThickness: 2
          ),),
          subtitle: Text(task.note, style: TextStyle(
            fontSize: 13
          ),),
          trailing: Checkbox(
            activeColor: Colors.blue,
            value: task.isComplete,
             onChanged: (bool ? newValue){
               toggle(index);
             }),
             leading: Icon(task.category.icon,color: task.category.color),
        );
  }
}
