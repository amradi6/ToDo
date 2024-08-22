import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

  Future<void> deleteTasks({required task}) async {
    await DBHelper.delete(task);
    getTasks();
  }

  Future<void> markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  addTask({required task}) {
    return DBHelper.insert(task);
  }

  deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }
}
