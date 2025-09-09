// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sectors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Sector {

 String get id; String get name; String get description; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Sector
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorCopyWith<Sector> get copyWith => _$SectorCopyWithImpl<Sector>(this as Sector, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sector&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt);

@override
String toString() {
  return 'Sector(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SectorCopyWith<$Res>  {
  factory $SectorCopyWith(Sector value, $Res Function(Sector) _then) = _$SectorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SectorCopyWithImpl<$Res>
    implements $SectorCopyWith<$Res> {
  _$SectorCopyWithImpl(this._self, this._then);

  final Sector _self;
  final $Res Function(Sector) _then;

/// Create a copy of Sector
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _Sector implements Sector {
  const _Sector({required this.id, required this.name, required this.description, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String name;
@override final  String description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Sector
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorCopyWith<_Sector> get copyWith => __$SectorCopyWithImpl<_Sector>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sector&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt);

@override
String toString() {
  return 'Sector(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SectorCopyWith<$Res> implements $SectorCopyWith<$Res> {
  factory _$SectorCopyWith(_Sector value, $Res Function(_Sector) _then) = __$SectorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SectorCopyWithImpl<$Res>
    implements _$SectorCopyWith<$Res> {
  __$SectorCopyWithImpl(this._self, this._then);

  final _Sector _self;
  final $Res Function(_Sector) _then;

/// Create a copy of Sector
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Sector(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
