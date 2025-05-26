import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DBService _dbService = DBService();
  final ApiService _apiService = ApiService();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _dbService.getTasks();
    notifyListeners();
  }

  Future<void> fetchFromAPI() async {
    List<Task> apiTasks = await _apiService.fetchTasks();
    for (var task in apiTasks) {
      await _dbService.insertTask(task);
    }
    await loadTasks();
  }

  Future<void> addTask(Task task) async {
    await _dbService.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbService.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbService.deleteTask(id);
    await loadTasks();
  }
}
