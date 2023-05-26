import 'package:built_collection/built_collection.dart';

import '../../lib_wrappers/index.dart';
import '../entities/index.dart';

class TodoApi {
  final NetworkAccess access;

  TodoApi({required this.access});

  Future<BuiltList<Todo>> getTodoList() async {
    final response = await access.fetch('todos');
    return deserializeBuiltList<Todo>(response.data);
  }

  Future<Todo> getTodoItem({
    required String todoId,
  }) async {
    final response = await access.fetch('todos/$todoId');
    if (response.data == null) {
      throw Exception('todo not found.');
    }
    return Todo.fromJson(response.data);
  }
}
