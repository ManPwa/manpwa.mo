import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'todo.g.dart';

abstract class Todo implements Built<Todo, TodoBuilder> {
  int get id;

  String get title;

  bool get completed;

  int get userId;

  // use when transform field from snack_case to camelCase
  // @BuiltValueField(wireName: 'first_name')
  // String get firstName;

  Todo._();
  factory Todo([void Function(TodoBuilder) updates]) = _$Todo;

  static Serializer<Todo> get serializer => _$todoSerializer;

  factory Todo.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Todo>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
