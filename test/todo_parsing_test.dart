import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/data/models/todo.dart';

void main() {
  late List<Todo> todos;
  setUp(() {
    todos = [
      Todo(),
      Todo(),
      Todo(),
    ];
  });

  group('TodoList Parsing', () {
    test('test decoding an encoded todos list', () {
      // Given
      final encoded = json.encode(
        todos.map((e) => e.toJson()).toList(),
      );
      // When
      final decoded = (json.decode(encoded) as List<dynamic>)
          .map<Todo>((item) => Todo.fromJson(item))
          .toList();
      // Then
      expect(decoded.length, equals(todos.length));
      expect(decoded, isA<List<Todo>>());
    });
  });
}
