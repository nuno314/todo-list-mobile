import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../constants/server_constants.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String? title;
  String? description;
  TodoStatus? status;
  DateTime? deadline;

  Todo({
    this.title,
    this.description,
    this.status = TodoStatus.inProgress,
    this.deadline,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  static String encode(List<Todo> todos) => json.encode(
        todos.map((e) => e.toJson()).toList(),
      );

  static List<Todo> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<Todo>((item) => Todo.fromJson(item))
          .toList();

  DeadlineStatus get deadlineStatus => DateTime.now().day == deadline?.day
      ? DeadlineStatus.today
      : DeadlineStatus.upcoming;
}
