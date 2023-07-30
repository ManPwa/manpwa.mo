// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Chapter> _$chapterSerializer = new _$ChapterSerializer();

class _$ChapterSerializer implements StructuredSerializer<Chapter> {
  @override
  final Iterable<Type> types = const [Chapter, _$Chapter];
  @override
  final String wireName = 'Chapter';

  @override
  Iterable<Object?> serialize(Serializers serializers, Chapter object,
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
    value = object.chapter;
    if (value != null) {
      result
        ..add('chapter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.volumne;
    if (value != null) {
      result
        ..add('volumne')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pages;
    if (value != null) {
      result
        ..add('pages')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.read;
    if (value != null) {
      result
        ..add('read')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
  Chapter deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChapterBuilder();

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
        case 'chapter':
          result.chapter = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'volumne':
          result.volumne = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pages':
          result.pages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'read':
          result.read.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$Chapter extends Chapter {
  @override
  final String? id;
  @override
  final String? mangaId;
  @override
  final double? chapter;
  @override
  final String? title;
  @override
  final String? volumne;
  @override
  final int? pages;
  @override
  final BuiltList<String>? read;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;

  factory _$Chapter([void Function(ChapterBuilder)? updates]) =>
      (new ChapterBuilder()..update(updates))._build();

  _$Chapter._(
      {this.id,
      this.mangaId,
      this.chapter,
      this.title,
      this.volumne,
      this.pages,
      this.read,
      this.deleted,
      this.updated,
      this.updater,
      this.created})
      : super._();

  @override
  Chapter rebuild(void Function(ChapterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterBuilder toBuilder() => new ChapterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chapter &&
        id == other.id &&
        mangaId == other.mangaId &&
        chapter == other.chapter &&
        title == other.title &&
        volumne == other.volumne &&
        pages == other.pages &&
        read == other.read &&
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
    _$hash = $jc(_$hash, chapter.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, volumne.hashCode);
    _$hash = $jc(_$hash, pages.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Chapter')
          ..add('id', id)
          ..add('mangaId', mangaId)
          ..add('chapter', chapter)
          ..add('title', title)
          ..add('volumne', volumne)
          ..add('pages', pages)
          ..add('read', read)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created))
        .toString();
  }
}

class ChapterBuilder implements Builder<Chapter, ChapterBuilder> {
  _$Chapter? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _mangaId;
  String? get mangaId => _$this._mangaId;
  set mangaId(String? mangaId) => _$this._mangaId = mangaId;

  double? _chapter;
  double? get chapter => _$this._chapter;
  set chapter(double? chapter) => _$this._chapter = chapter;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _volumne;
  String? get volumne => _$this._volumne;
  set volumne(String? volumne) => _$this._volumne = volumne;

  int? _pages;
  int? get pages => _$this._pages;
  set pages(int? pages) => _$this._pages = pages;

  ListBuilder<String>? _read;
  ListBuilder<String> get read => _$this._read ??= new ListBuilder<String>();
  set read(ListBuilder<String>? read) => _$this._read = read;

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

  ChapterBuilder();

  ChapterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _mangaId = $v.mangaId;
      _chapter = $v.chapter;
      _title = $v.title;
      _volumne = $v.volumne;
      _pages = $v.pages;
      _read = $v.read?.toBuilder();
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Chapter other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Chapter;
  }

  @override
  void update(void Function(ChapterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Chapter build() => _build();

  _$Chapter _build() {
    _$Chapter _$result;
    try {
      _$result = _$v ??
          new _$Chapter._(
              id: id,
              mangaId: mangaId,
              chapter: chapter,
              title: title,
              volumne: volumne,
              pages: pages,
              read: _read?.build(),
              deleted: deleted,
              updated: updated,
              updater: updater,
              created: created);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'read';
        _read?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Chapter', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
