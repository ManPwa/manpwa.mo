// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Manga> _$mangaSerializer = new _$MangaSerializer();

class _$MangaSerializer implements StructuredSerializer<Manga> {
  @override
  final Iterable<Type> types = const [Manga, _$Manga];
  @override
  final String wireName = 'Manga';

  @override
  Iterable<Object?> serialize(Serializers serializers, Manga object,
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
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.year;
    if (value != null) {
      result
        ..add('year')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.demographic;
    if (value != null) {
      result
        ..add('demographic')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cover_art_url;
    if (value != null) {
      result
        ..add('cover_art_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.author;
    if (value != null) {
      result
        ..add('author')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.original_language;
    if (value != null) {
      result
        ..add('original_language')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.following;
    if (value != null) {
      result
        ..add('following')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.average_rating;
    if (value != null) {
      result
        ..add('average_rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.latest_chapter;
    if (value != null) {
      result
        ..add('latest_chapter')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  Manga deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MangaBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'demographic':
          result.demographic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cover_art_url':
          result.cover_art_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'original_language':
          result.original_language = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
        case 'following':
          result.following = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'average_rating':
          result.average_rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'latest_chapter':
          result.latest_chapter = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$Manga extends Manga {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final int? year;
  @override
  final String? status;
  @override
  final String? demographic;
  @override
  final String? cover_art_url;
  @override
  final String? author;
  @override
  final BuiltList<String>? tags;
  @override
  final String? original_language;
  @override
  final DateTime? deleted;
  @override
  final DateTime? updated;
  @override
  final String? updater;
  @override
  final DateTime? created;
  @override
  final int? following;
  @override
  final double? average_rating;
  @override
  final double? latest_chapter;

  factory _$Manga([void Function(MangaBuilder)? updates]) =>
      (new MangaBuilder()..update(updates))._build();

  _$Manga._(
      {this.id,
      this.title,
      this.description,
      this.year,
      this.status,
      this.demographic,
      this.cover_art_url,
      this.author,
      this.tags,
      this.original_language,
      this.deleted,
      this.updated,
      this.updater,
      this.created,
      this.following,
      this.average_rating,
      this.latest_chapter})
      : super._();

  @override
  Manga rebuild(void Function(MangaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MangaBuilder toBuilder() => new MangaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Manga &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        year == other.year &&
        status == other.status &&
        demographic == other.demographic &&
        cover_art_url == other.cover_art_url &&
        author == other.author &&
        tags == other.tags &&
        original_language == other.original_language &&
        deleted == other.deleted &&
        updated == other.updated &&
        updater == other.updater &&
        created == other.created &&
        following == other.following &&
        average_rating == other.average_rating &&
        latest_chapter == other.latest_chapter;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, demographic.hashCode);
    _$hash = $jc(_$hash, cover_art_url.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, original_language.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, updater.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jc(_$hash, following.hashCode);
    _$hash = $jc(_$hash, average_rating.hashCode);
    _$hash = $jc(_$hash, latest_chapter.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Manga')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('year', year)
          ..add('status', status)
          ..add('demographic', demographic)
          ..add('cover_art_url', cover_art_url)
          ..add('author', author)
          ..add('tags', tags)
          ..add('original_language', original_language)
          ..add('deleted', deleted)
          ..add('updated', updated)
          ..add('updater', updater)
          ..add('created', created)
          ..add('following', following)
          ..add('average_rating', average_rating)
          ..add('latest_chapter', latest_chapter))
        .toString();
  }
}

class MangaBuilder implements Builder<Manga, MangaBuilder> {
  _$Manga? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _demographic;
  String? get demographic => _$this._demographic;
  set demographic(String? demographic) => _$this._demographic = demographic;

  String? _cover_art_url;
  String? get cover_art_url => _$this._cover_art_url;
  set cover_art_url(String? cover_art_url) =>
      _$this._cover_art_url = cover_art_url;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _original_language;
  String? get original_language => _$this._original_language;
  set original_language(String? original_language) =>
      _$this._original_language = original_language;

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

  int? _following;
  int? get following => _$this._following;
  set following(int? following) => _$this._following = following;

  double? _average_rating;
  double? get average_rating => _$this._average_rating;
  set average_rating(double? average_rating) =>
      _$this._average_rating = average_rating;

  double? _latest_chapter;
  double? get latest_chapter => _$this._latest_chapter;
  set latest_chapter(double? latest_chapter) =>
      _$this._latest_chapter = latest_chapter;

  MangaBuilder();

  MangaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _year = $v.year;
      _status = $v.status;
      _demographic = $v.demographic;
      _cover_art_url = $v.cover_art_url;
      _author = $v.author;
      _tags = $v.tags?.toBuilder();
      _original_language = $v.original_language;
      _deleted = $v.deleted;
      _updated = $v.updated;
      _updater = $v.updater;
      _created = $v.created;
      _following = $v.following;
      _average_rating = $v.average_rating;
      _latest_chapter = $v.latest_chapter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Manga other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Manga;
  }

  @override
  void update(void Function(MangaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Manga build() => _build();

  _$Manga _build() {
    _$Manga _$result;
    try {
      _$result = _$v ??
          new _$Manga._(
              id: id,
              title: title,
              description: description,
              year: year,
              status: status,
              demographic: demographic,
              cover_art_url: cover_art_url,
              author: author,
              tags: _tags?.build(),
              original_language: original_language,
              deleted: deleted,
              updated: updated,
              updater: updater,
              created: created,
              following: following,
              average_rating: average_rating,
              latest_chapter: latest_chapter);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Manga', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
