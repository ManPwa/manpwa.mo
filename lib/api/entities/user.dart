
import 'dart:ffi';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  String? get username;

  String? get email;

  bool? get is_admin;

  DateTime? get date_of_birth;

  String? get avatar_url;

  // use when transform field from snack_case to camelCase
  // @BuiltValueField(wireName: 'first_name')
  // String get firstName;

  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;

  static Serializer<User> get serializer => _$userSerializer;

  factory User.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<User>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
