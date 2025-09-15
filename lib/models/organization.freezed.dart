// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Organization {

 String get id; String get name; String get slug; String get logo; String get sector; String get location; String? get bio; String? get website; DateTime get createdAt; DateTime get updatedAt; bool get isFollowed; List<Program> get programs;
/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationCopyWith<Organization> get copyWith => _$OrganizationCopyWithImpl<Organization>(this as Organization, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Organization&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.website, website) || other.website == website)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&const DeepCollectionEquality().equals(other.programs, programs));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,slug,logo,sector,location,bio,website,createdAt,updatedAt,isFollowed,const DeepCollectionEquality().hash(programs));

@override
String toString() {
  return 'Organization(id: $id, name: $name, slug: $slug, logo: $logo, sector: $sector, location: $location, bio: $bio, website: $website, createdAt: $createdAt, updatedAt: $updatedAt, isFollowed: $isFollowed, programs: $programs)';
}


}

/// @nodoc
abstract mixin class $OrganizationCopyWith<$Res>  {
  factory $OrganizationCopyWith(Organization value, $Res Function(Organization) _then) = _$OrganizationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String slug, String logo, String sector, String location, String? bio, String? website, DateTime createdAt, DateTime updatedAt, bool isFollowed, List<Program> programs
});




}
/// @nodoc
class _$OrganizationCopyWithImpl<$Res>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._self, this._then);

  final Organization _self;
  final $Res Function(Organization) _then;

/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? logo = null,Object? sector = null,Object? location = null,Object? bio = freezed,Object? website = freezed,Object? createdAt = null,Object? updatedAt = null,Object? isFollowed = null,Object? programs = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,programs: null == programs ? _self.programs : programs // ignore: cast_nullable_to_non_nullable
as List<Program>,
  ));
}

}


/// @nodoc


class _Organization implements Organization {
  const _Organization({required this.id, required this.name, required this.slug, required this.logo, required this.sector, required this.location, required this.bio, required this.website, required this.createdAt, required this.updatedAt, required this.isFollowed, required final  List<Program> programs}): _programs = programs;
  

@override final  String id;
@override final  String name;
@override final  String slug;
@override final  String logo;
@override final  String sector;
@override final  String location;
@override final  String? bio;
@override final  String? website;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool isFollowed;
 final  List<Program> _programs;
@override List<Program> get programs {
  if (_programs is EqualUnmodifiableListView) return _programs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_programs);
}


/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationCopyWith<_Organization> get copyWith => __$OrganizationCopyWithImpl<_Organization>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Organization&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.website, website) || other.website == website)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFollowed, isFollowed) || other.isFollowed == isFollowed)&&const DeepCollectionEquality().equals(other._programs, _programs));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,slug,logo,sector,location,bio,website,createdAt,updatedAt,isFollowed,const DeepCollectionEquality().hash(_programs));

@override
String toString() {
  return 'Organization(id: $id, name: $name, slug: $slug, logo: $logo, sector: $sector, location: $location, bio: $bio, website: $website, createdAt: $createdAt, updatedAt: $updatedAt, isFollowed: $isFollowed, programs: $programs)';
}


}

/// @nodoc
abstract mixin class _$OrganizationCopyWith<$Res> implements $OrganizationCopyWith<$Res> {
  factory _$OrganizationCopyWith(_Organization value, $Res Function(_Organization) _then) = __$OrganizationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String slug, String logo, String sector, String location, String? bio, String? website, DateTime createdAt, DateTime updatedAt, bool isFollowed, List<Program> programs
});




}
/// @nodoc
class __$OrganizationCopyWithImpl<$Res>
    implements _$OrganizationCopyWith<$Res> {
  __$OrganizationCopyWithImpl(this._self, this._then);

  final _Organization _self;
  final $Res Function(_Organization) _then;

/// Create a copy of Organization
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? logo = null,Object? sector = null,Object? location = null,Object? bio = freezed,Object? website = freezed,Object? createdAt = null,Object? updatedAt = null,Object? isFollowed = null,Object? programs = null,}) {
  return _then(_Organization(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,logo: null == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFollowed: null == isFollowed ? _self.isFollowed : isFollowed // ignore: cast_nullable_to_non_nullable
as bool,programs: null == programs ? _self._programs : programs // ignore: cast_nullable_to_non_nullable
as List<Program>,
  ));
}


}

// dart format on
