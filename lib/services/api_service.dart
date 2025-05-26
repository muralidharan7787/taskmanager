import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  final String url = "http://192.168.1.9:3000/tasks";

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print(data);
      return data.map((e) => Task.fromMap(e)).toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }
}
