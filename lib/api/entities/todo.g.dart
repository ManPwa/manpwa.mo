// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Todo> _$todoSerializer = new _$TodoSerializer();

class _$TodoSerializer implements StructuredSerializer<Todo> {
  @override
  final Iterable<Type> types = const [Todo, _$Todo];
  @override
  final String wireName = 'Todo';

  @override
  Iterable<Object?> serialize(Serializers serializers, Todo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'completed',
      serializers.serialize(object.completed,
          specifiedType: const FullType(bool)),
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Todo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TodoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'completed':
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Todo extends Todo {
  @override
  final int id;
  @override
  final String title;
  @override
  final bool completed;
  @override
  final int userId;

  factory _$Todo([void Function(TodoBuilder)? updates]) =>
      (new TodoBuilder()..update(updates))._build();

  _$Todo._(
      {required this.id,
      required this.title,
      required this.completed,
      required this.userId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Todo', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'Todo', 'title');
    BuiltValueNullFieldError.checkNotNull(completed, r'Todo', 'completed');
    BuiltValueNullFieldError.checkNotNull(userId, r'Todo', 'userId');
  }

  @override
  Todo rebuild(void Function(TodoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoBuilder toBuilder() => new TodoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
        id == other.id &&
        title == other.title &&
        completed == other.completed &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, completed.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Todo')
          ..add('id', id)
          ..add('title', title)
          ..add('completed', completed)
          ..add('userId', userId))
        .toString();
  }
}

class TodoBuilder implements Builder<Todo, TodoBuilder> {
  _$Todo? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  bool? _completed;
  bool? get completed => _$this._completed;
  set completed(bool? completed) => _$this._completed = completed;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  TodoBuilder();

  TodoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _completed = $v.completed;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Todo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Todo;
  }

  @override
  void update(void Function(TodoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Todo build() => _build();

  _$Todo _build() {
    final _$result = _$v ??
        new _$Todo._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Todo', 'id'),
            title:
                BuiltValueNullFieldError.checkNotNull(title, r'Todo', 'title'),
            completed: BuiltValueNullFieldError.checkNotNull(
                completed, r'Todo', 'completed'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Todo', 'userId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
