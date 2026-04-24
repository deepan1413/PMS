import 'package:pms/features/active_task/domain/entities/task.dart';

abstract class TaskRepo {
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<List<Task>> fetchActiveTasks(String uid);
  Future<List<Task>> fetchCompletedTasks(String uid);
}