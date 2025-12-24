import 'package:flutter/material.dart';
import 'package:todo_app/data/task.dart';
import 'package:todo_app/utils/task_category.dart';
import 'package:todo_app/widgets/add_task_buttons.dart';
import 'package:todo_app/widgets/custom_from_field.dart';
import 'package:todo_app/widgets/title_text.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
final TextEditingController titleController =TextEditingController();
final TextEditingController noteController =TextEditingController();

TaskCategory? selectedCategory;
@override
   void dispose(){
     titleController.dispose();
     noteController.dispose();
     super.dispose();
   }
   void _saveTask(){
    if(titleController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter title')));
        return;
    }else if(noteController.text.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('please enter note')));
      return;
    }else if(selectedCategory==null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please select the category'))
        
      );
      return ;
    }
  
    final newTask= Task(
      id: DateTime.now().microsecondsSinceEpoch,
       note: noteController.text,
        title: titleController.text,
         category: selectedCategory!
         );
    Navigator.pop(context, newTask);     
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TitleText(title: 'Title',),
          ),
          SizedBox(height: 15,),
         CustomFormField(maxLines: 1, controller: titleController,),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TitleText(title: 'Category',),
          ),
           SizedBox(height: 15,),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:8 ,
              itemBuilder: (context,index){
                final category =TaskCategory.values[index];
                final iselected =selectedCategory==category;
                 return Padding(
                   padding: const EdgeInsets.all(15),
                   child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory=category;
                      });
                    },
                     child: Column(
                      children: [
                      Container(
                        height: iselected?35: 30,
                        width:  iselected?35: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:category.color.withValues(alpha: 0.5),
                          border: Border.all
                          (color: category.color,
                          width: iselected ?2:1 ) 
                        ),
                       
                        child: Icon(category.icon ,size: 20.0,),
                      ),
                      Text(category.name ,style: TextStyle(
                        fontSize: iselected?16:14 , 
                         fontWeight: iselected? FontWeight.bold: FontWeight.w500),)
                                     ],),
                   ),
                 );
              }),
          ),
          SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TitleText(title: 'Note',),
            ),
            SizedBox(height: 15,),
            CustomFormField(maxLines: 5, controller: noteController ,),
            SizedBox(height: 30,),
            AddTaskButtons(onSave: _saveTask,)
        ],
      ),
     ),
    );
  }  
}


