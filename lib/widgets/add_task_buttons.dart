
import 'package:flutter/material.dart';

class AddTaskButtons extends StatelessWidget {
  final VoidCallback onSave;
  const AddTaskButtons({
    super.key, required this.onSave,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: onSave, child: Text('Save',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),),
        SizedBox(width: 30,),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel',style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(backgroundColor: Colors.white)),
      ],);
  }
}