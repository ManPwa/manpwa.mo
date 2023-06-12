// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Comment> _$commentSerializer = new _$CommentSerializer();

class _$CommentSerializer implements StructuredSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];
  @override
  final String wireName = 'Comment';

  @override
  Iterable<Object?> serialize(Serializers serializers, Comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mangaId;
    if (value != null) {
      result
        ..add('manga_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatar_url;
    if (value != null) {
      result
        ..add('avatar_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.is_admin;
    if (value != null) {
      result
        ..add('is_admin')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.deleted;
    if (value != null) {
      result
        ..add('_deleted')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updated;
    if (value != null) {
      result
        ..add('_updated')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updater;
    if (value != null) {
      result
        ..add('_updater')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.created;
    if (value != null) {
      result
        ..add('_created')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  Comment deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '_id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'manga_id':
          result.mangaId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatar_url':
          result.avatar_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'is_admin':
          result.is_admin = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case '_deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case '_updated':
          result.updated = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case '_updater':
          result.updater = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case '_created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$Comment extends Comment {
  @override
  final String? id;
  @override
  final String? mangaId;
  @override
  final String? userId;
  @override
  final String? content;
  @override
  final String? username;
  @override
  final String? avatar_url;
  @override
  final bool? is_admin;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;

  factory _$Comment([void Function(CommentBuilder)? updates]) =>
      (new CommentBuilder()..update(updates))._build();

  _$Comment._(
      {this.id,
      this.mangaId,
      this.userId,
      this.content,
      this.username,
      this.avatar_url,
      this.is_admin,
      this.deleted,
      this.updated,
      this.updater,
      this.created})
      : super._();

  @override
  Comment rebuild(void Function(CommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        id == other.id &&
        mangaId == other.mangaId &&
        userId == other.userId &&
        content == other.content &&
        username == other.username &&
        avatar_url == other.avatar_url &&
        is_admin == other.is_admin &&
        deleted == other.deleted &&
        updated == other.updated &&
        updater == other.updater &&
        created == other.created;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, mangaId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, avatar_url.hashCode);
    _$hash = $jc(_$hash, is_admin.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Comment')
          ..add('id', id)
          ..add('mangaId', mangaId)
          ..add('userId', userId)
          ..add('content', content)
          ..add('username', username)
          ..add('avatar_url', avatar_url)
          ..add('is_admin', is_admin)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _mangaId;
  String? get mangaId => _$this._mangaId;
  set mangaId(String? mangaId) => _$this._mangaId = mangaId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _avatar_url;
  String? get avatar_url => _$this._avatar_url;
  set avatar_url(String? avatar_url) => _$this._avatar_url = avatar_url;

  bool? _is_admin;
  bool? get is_admin => _$this._is_admin;
  set is_admin(bool? is_admin) => _$this._is_admin = is_admin;

  DateTime? _deleted;
  DateTime? get deleted => _$this._deleted;
  set deleted(DateTime? deleted) => _$this._deleted = deleted;

  DateTime? _updated;
  DateTime? get updated => _$this._updated;
  set updated(DateTime? updated) => _$this._updated = updated;

  String? _updater;
  String? get updater => _$this._updater;
  set updater(String? updater) => _$this._updater = updater;

  DateTime? _created;
  DateTime? get created => _$this._created;
  set created(DateTime? created) => _$this._created = created;

  CommentBuilder();

  CommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _mangaId = $v.mangaId;
      _userId = $v.userId;
      _content = $v.content;
      _username = $v.username;
      _avatar_url = $v.avatar_url;
      _is_admin = $v.is_admin;
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Comment;
  }

  @override
  void update(void Function(CommentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Comment build() => _build();

  _$Comment _build() {
    final _$result = _$v ??
        new _$Comment._(
            id: id,
            mangaId: mangaId,
            userId: userId,
            content: content,
            username: username,
            avatar_url: avatar_url,
            is_admin: is_admin,
            deleted: deleted,
            updated: updated,
            updater: updater,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
