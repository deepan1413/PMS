


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/features/active_task/presentation/components/add_edit_task_bottom_sheet.dart';
import 'package:pms/features/active_task/presentation/components/task_card.dart';
import 'package:pms/features/active_task/presentation/cubits/task_cubit.dart';
import 'package:pms/features/active_task/presentation/cubits/task_states.dart';
import 'package:pms/core/utils/my_log.dart';

class ActiveTaskPage extends StatefulWidget {
  const ActiveTaskPage({super.key});

  @override
  State<ActiveTaskPage> createState() => _ActiveTaskPageState();
}

class _ActiveTaskPageState extends State<ActiveTaskPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchActiveTasks(uid);
  }

  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddEditTaskBottomSheet(
        onSave: (title, desc, priority) {
          context.read<TaskCubit>().createTask(
                uid: uid,
                title: title,
                description: desc,
                priority: priority,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        title: const Text(
          "Active Tasks",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddSheet,
        
        child: const Icon(Icons.add, ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskError) {
            MyLog.error("Error loading tasks: ${state.message}");
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return TaskCard(
                  task: task,
                  onProgressChanged: (value) {
                    context.read<TaskCubit>().updateProgress(
                          uid: uid,
                          task: task,
                          progress: value,
                        );
                  },
                  onEdit: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) => AddEditTaskBottomSheet(
                        initialTitle: task.title,
                        initialDescription: task.description,
                        initialPriority: task.priority,
                        onSave: (title, desc, priority) {
                          context.read<TaskCubit>().editTask(
                                uid: uid,
                                task: task,
                                title: title,
                                description: desc,
                                priority: priority,
                              );
                        },
                      ),
                    );
                  },
                  onDelete: () => _confirmDelete(context, task.id),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            "No active tasks",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap + to create your first task",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            onPressed: () {
              context
                  .read<TaskCubit>()
                  .deleteTask(uid: uid, taskId: taskId);
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}