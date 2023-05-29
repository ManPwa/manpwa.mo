
import 'dart:ffi';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'manga.g.dart';

abstract class Manga implements Built<Manga, MangaBuilder> {
  @BuiltValueField(wireName: '_id')
  String? get id;

  String? get title;

  String? get description;

  int? get year;

  String? get status;

  String? get demographic;

  String? get cover_art_url;
  
  String? get author;

  BuiltList<String>? get tags;

  String? get original_language;

  @BuiltValueField(wireName: '_deleted')
  DateTime? get deleted;

  @BuiltValueField(wireName: '_updated')
  DateTime? get updated;

  @BuiltValueField(wireName: '_updater')
  String? get updater;

  @BuiltValueField(wireName: '_created')
  DateTime? get created;

  int? get following;
  
  double? get average_rating;

  double? get latest_chapter;

  // use when transform field from snack_case to camelCase
  // @BuiltValueField(wireName: 'first_name')
  // String get firstName;

  Manga._();
  factory Manga([void Function(MangaBuilder) updates]) = _$Manga;

  static Serializer<Manga> get serializer => _$mangaSerializer;

  factory Manga.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith<Manga>(serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(serializer, this)! as Map<String, dynamic>;
}
