// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Post {

 String get id; String get title; String get slug; String get content; String get cover; Organization? get organization; Sector? get sector; DateTime get createdAt; String get createdAtReadable; DateTime get updatedAt;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.content, content) || other.content == content)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdAtReadable, createdAtReadable) || other.createdAtReadable == createdAtReadable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,slug,content,cover,organization,sector,createdAt,createdAtReadable,updatedAt);

@override
String toString() {
  return 'Post(id: $id, title: $title, slug: $slug, content: $content, cover: $cover, organization: $organization, sector: $sector, createdAt: $createdAt, createdAtReadable: $createdAtReadable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String id, String title, String slug, String content, String cover, Organization? organization, Sector? sector, DateTime createdAt, String createdAtReadable, DateTime updatedAt
});


$OrganizationCopyWith<$Res>? get organization;$SectorCopyWith<$Res>? get sector;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? content = null,Object? cover = null,Object? organization = freezed,Object? sector = freezed,Object? createdAt = null,Object? createdAtReadable = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as Organization?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAtReadable: null == createdAtReadable ? _self.createdAtReadable : createdAtReadable // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationCopyWith<$Res>? get organization {
    if (_self.organization == null) {
    return null;
  }

  return $OrganizationCopyWith<$Res>(_self.organization!, (value) {
    return _then(_self.copyWith(organization: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorCopyWith<$Res>? get sector {
    if (_self.sector == null) {
    return null;
  }

  return $SectorCopyWith<$Res>(_self.sector!, (value) {
    return _then(_self.copyWith(sector: value));
  });
}
}


/// @nodoc


class _Post implements Post {
  const _Post({required this.id, required this.title, required this.slug, required this.content, required this.cover, required this.organization, required this.sector, required this.createdAt, required this.createdAtReadable, required this.updatedAt});
  

@override final  String id;
@override final  String title;
@override final  String slug;
@override final  String content;
@override final  String cover;
@override final  Organization? organization;
@override final  Sector? sector;
@override final  DateTime createdAt;
@override final  String createdAtReadable;
@override final  DateTime updatedAt;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.content, content) || other.content == content)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdAtReadable, createdAtReadable) || other.createdAtReadable == createdAtReadable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,slug,content,cover,organization,sector,createdAt,createdAtReadable,updatedAt);

@override
String toString() {
  return 'Post(id: $id, title: $title, slug: $slug, content: $content, cover: $cover, organization: $organization, sector: $sector, createdAt: $createdAt, createdAtReadable: $createdAtReadable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String slug, String content, String cover, Organization? organization, Sector? sector, DateTime createdAt, String createdAtReadable, DateTime updatedAt
});


@override $OrganizationCopyWith<$Res>? get organization;@override $SectorCopyWith<$Res>? get sector;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? content = null,Object? cover = null,Object? organization = freezed,Object? sector = freezed,Object? createdAt = null,Object? createdAtReadable = null,Object? updatedAt = null,}) {
  return _then(_Post(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as Organization?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAtReadable: null == createdAtReadable ? _self.createdAtReadable : createdAtReadable // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationCopyWith<$Res>? get organization {
    if (_self.organization == null) {
    return null;
  }

  return $OrganizationCopyWith<$Res>(_self.organization!, (value) {
    return _then(_self.copyWith(organization: value));
  });
}/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorCopyWith<$Res>? get sector {
    if (_self.sector == null) {
    return null;
  }

  return $SectorCopyWith<$Res>(_self.sector!, (value) {
    return _then(_self.copyWith(sector: value));
  });
}
}

// dart format on
