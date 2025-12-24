
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/core/utils/task_category.dart';
part 'task.g.dart'; 
@HiveType(typeId: 0)
class Task extends Equatable {
  @HiveField(0) 
  final int id;
  @HiveField(1) 
  final String title;
  @HiveField(2) 
  final String note;
  @HiveField(3) 
  final TaskCategory category;
  @HiveField(4) 
  final bool isComplete;
  const Task({
    required this.id,
    required this.note,
     required this.title,
      required this.category, 
       this.isComplete =false,});


     Task copyWith({
      int? id,
    String? title,
    String? note,
    TaskCategory? category,
    bool? isComplete,
     }) {
      return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      category: category ?? this.category,
      isComplete: isComplete ?? this.isComplete,
    );

     } 

  @override
  List<Object> get props => [id, title, note, category, isComplete];
}
 