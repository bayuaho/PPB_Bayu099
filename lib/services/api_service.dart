import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class ApiService {
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/todos';

  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data: ${response.statusCode}');
    }
  }
}