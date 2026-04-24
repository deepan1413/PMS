import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/domain/repo/task_repo.dart';
import 'package:pms/features/completed_task/presentation/cubits/completed_task_states.dart';

class CompletedTaskCubit extends Cubit<CompletedTaskState> {
  final TaskRepo taskRepo;

  CompletedTaskCubit({required this.taskRepo}) : super(CompletedTaskInitial());

  // ── Fetch ────────────────────────────────────────
  Future<void> fetchCompletedTasks(String uid) async {
    try {
      emit(CompletedTaskLoading());
      final tasks = await taskRepo.fetchCompletedTasks(uid);
      emit(CompletedTaskLoaded(tasks));
    } catch (e) {
      emit(CompletedTaskError(e.toString()));
    }
  }

  // ── Delete ───────────────────────────────────────
  Future<void> deleteTask({
    required String uid,
    required String taskId,
  }) async {
    try {
      await taskRepo.deleteTask(taskId);
      await fetchCompletedTasks(uid);
    } catch (e) {
      emit(CompletedTaskError(e.toString()));
    }
  }

  // ── Reopen (mark incomplete, reset progress) ─────
  Future<void> reopenTask({
    required String uid,
    required task,
  }) async {
    try {
      final reopened = task.copyWith(
        isCompleted: false,
        progress: 0.0,
      );
      await taskRepo.updateTask(reopened);
      await fetchCompletedTasks(uid);
    } catch (e) {
      emit(CompletedTaskError(e.toString()));
    }
  }
}