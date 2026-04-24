import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pms/features/active_task/domain/entities/task.dart';
import 'package:pms/features/active_task/domain/repo/task_repo.dart';

class FirebaseTaskRepo implements TaskRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tasks';

  @override
  Future<void> createTask(Task task) async {
    await _firestore
        .collection(_collection)
        .doc(task.id)
        .set(task.toJson());
  }

  @override
  Future<void> updateTask(Task task) async {
    await _firestore
        .collection(_collection)
        .doc(task.id)
        .update(task.toJson());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection(_collection).doc(taskId).delete();
  }

  @override
  Future<List<Task>> fetchActiveTasks(String uid) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Task.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<Task>> fetchCompletedTasks(String uid) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .where('isCompleted', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Task.fromJson(doc.data()))
        .toList();
  }
}