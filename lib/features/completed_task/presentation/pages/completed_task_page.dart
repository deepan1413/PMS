import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/presentation/cubits/task_cubit.dart';
import 'package:pms/features/completed_task/presentation/components/completed_task_card.dart';
import 'package:pms/features/completed_task/presentation/cubits/completed_task_cubit.dart';
import 'package:pms/features/completed_task/presentation/cubits/completed_task_states.dart';

class CompletedTaskPage extends StatefulWidget {
  final String uid;

  const CompletedTaskPage({super.key, required this.uid});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  void initState() {
    super.initState();
    context.read<CompletedTaskCubit>().fetchCompletedTasks(widget.uid);
  }

  Future<void> _confirmDelete(BuildContext context, String taskId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Task'),
        content:
            const Text('Are you sure you want to permanently delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CompletedTaskCubit>().deleteTask(
            uid: widget.uid,
            taskId: taskId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Completed Tasks'),
        centerTitle: true,
      ),
      body: BlocBuilder<CompletedTaskCubit, CompletedTaskState>(
        builder: (context, state) {
           if (state is CompletedTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

           if (state is CompletedTaskError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<CompletedTaskCubit>()
                        .fetchCompletedTasks(widget.uid),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CompletedTaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.task_alt, size: 64, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'No completed tasks yet',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context
                  .read<CompletedTaskCubit>()
                  .fetchCompletedTasks(widget.uid),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return CompletedTaskCard(
                    task: task,
                    onDelete: () => _confirmDelete(context, task.id),
                    onReopen: () {
                      context.read<CompletedTaskCubit>().reopenTask(
                            uid: widget.uid,
                            task: task,
                          );
                        context
                          .read<TaskCubit>()
                          .fetchActiveTasks(widget.uid);
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}