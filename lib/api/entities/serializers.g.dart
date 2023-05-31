// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Chapter.serializer)
      ..add(ChapterImage.serializer)
      ..add(Manga.serializer)
      ..add(MangaResponse.serializer)
      ..add(Todo.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Manga)]),
          () => new ListBuilder<Manga>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
