import 'package:pms/features/active_task/domain/entities/task.dart';

abstract class CompletedTaskState {}

class CompletedTaskInitial extends CompletedTaskState {}

class CompletedTaskLoading extends CompletedTaskState {}

class CompletedTaskLoaded extends CompletedTaskState {
  final List<Task> tasks;
  CompletedTaskLoaded(this.tasks);
}

class CompletedTaskError extends CompletedTaskState {
  final String message;
  CompletedTaskError(this.message);
}