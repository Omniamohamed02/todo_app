import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'task_category.g.dart';
@HiveType(typeId: 1)
 enum TaskCategory  {
  @HiveField(0) 
 education(Icons.school, Colors.orange),
 @HiveField(1) 
 work(Icons.work, Colors.brown),
 @HiveField(2) 
 personal(Icons.person , Colors.purple),
 @HiveField(3) 
 home(Icons.home , Colors.yellow),
 @HiveField(4) 
 health(Icons.favorite , Colors.red),
 @HiveField(5) 
 shopping(Icons.shopping_bag , Colors.pink),
 @HiveField(6) 
 social(Icons.people , Colors.green),
 @HiveField(7) 
 travel(Icons.flight , Colors.blue),
 @HiveField(8) 
 others(Icons.calendar_month , Colors.blueGrey);



  final IconData icon;
  final Color color;
   const TaskCategory(this.icon,this.color);
}