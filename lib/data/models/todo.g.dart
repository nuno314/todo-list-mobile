// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: $enumDecodeNullable(_$TodoStatusEnumMap, json['status']) ??
          TodoStatus.inProgress,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'status': _$TodoStatusEnumMap[instance.status],
      'deadline': instance.deadline?.toIso8601String(),
    };

const _$TodoStatusEnumMap = {
  TodoStatus.inProgress: 'inProgress',
  TodoStatus.completed: 'completed',
  TodoStatus.expired: 'expired',
};
