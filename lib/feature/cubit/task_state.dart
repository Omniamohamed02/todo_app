
import 'package:equatable/equatable.dart';
import'package:todo_app/feature/model/task.dart';

sealed class TaskState extends Equatable {

  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {
  TaskInitial();
}
final class TaskLoaded extends TaskState{
  final List<Task> tasks;
  TaskLoaded(this.tasks) ;
 @override
  List<Object> get props => [tasks];
}