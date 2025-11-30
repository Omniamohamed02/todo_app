import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
    bool _isComplete =true;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title:  Text(
          'My Task',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context)=> const AddTaskScreen())
            );
        },
         child: Icon(Icons.add , color: Colors.white,),
      ),
      body: ListView.builder(
        itemCount: 8,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("data",style: TextStyle(
            decoration: _isComplete? TextDecoration.lineThrough:null,
            decorationThickness: 2
          ),),
          subtitle: Text('sub'),
          leading: Checkbox(
            activeColor: Colors.blue,
            value: _isComplete,
             onChanged: (bool ? newValue){
             setState(() {
               
               _isComplete=newValue??false;
             });
             }),
        );
      },
      ),
    );
  }
}
