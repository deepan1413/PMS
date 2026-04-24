import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/domain/entities/task.dart';
import 'package:pms/features/active_task/domain/repo/task_repo.dart';
import 'package:pms/features/active_task/presentation/cubits/task_states.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo taskRepo;

  TaskCubit({required this.taskRepo}) : super(TaskInitial());

  Future<void> fetchActiveTasks(String uid) async {
    try {
      emit(TaskLoading());
      final tasks = await taskRepo.fetchActiveTasks(uid);
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> createTask({
    required String uid,
    required String title,
    required String description,
    required String priority,
  }) async {
    try {
      final task = Task(
        id: FirebaseFirestore.instance.collection('tasks').doc().id,
        uid: uid,
        title: title,
        description: description,
        priority: priority,
        progress: 0.0,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await taskRepo.createTask(task);
      await fetchActiveTasks(uid);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateProgress({
    required String uid,
    required Task task,
    required double progress,
  }) async {
    try {
      final isCompleted = progress >= 1.0;
      final updated = task.copyWith(
        progress: progress,
        isCompleted: isCompleted,
      );

      await taskRepo.updateTask(updated);
      await fetchActiveTasks(uid);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> editTask({
    required String uid,
    required Task task,
    required String title,
    required String description,
    required String priority,
  }) async {
    try {
      final updated = task.copyWith(
        title: title,
        description: description,
        priority: priority,
      );

      await taskRepo.updateTask(updated);
      await fetchActiveTasks(uid);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    try {
      await taskRepo.deleteTask(taskId);
      await fetchActiveTasks(uid);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}