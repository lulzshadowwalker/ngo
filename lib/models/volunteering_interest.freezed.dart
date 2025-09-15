// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volunteering_interest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VolunteeringInterest {

 String get id; String get name;
/// Create a copy of VolunteeringInterest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VolunteeringInterestCopyWith<VolunteeringInterest> get copyWith => _$VolunteeringInterestCopyWithImpl<VolunteeringInterest>(this as VolunteeringInterest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VolunteeringInterest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'VolunteeringInterest(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $VolunteeringInterestCopyWith<$Res>  {
  factory $VolunteeringInterestCopyWith(VolunteeringInterest value, $Res Function(VolunteeringInterest) _then) = _$VolunteeringInterestCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$VolunteeringInterestCopyWithImpl<$Res>
    implements $VolunteeringInterestCopyWith<$Res> {
  _$VolunteeringInterestCopyWithImpl(this._self, this._then);

  final VolunteeringInterest _self;
  final $Res Function(VolunteeringInterest) _then;

/// Create a copy of VolunteeringInterest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _VolunteeringInterest implements VolunteeringInterest {
  const _VolunteeringInterest({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of VolunteeringInterest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VolunteeringInterestCopyWith<_VolunteeringInterest> get copyWith => __$VolunteeringInterestCopyWithImpl<_VolunteeringInterest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VolunteeringInterest&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'VolunteeringInterest(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$VolunteeringInterestCopyWith<$Res> implements $VolunteeringInterestCopyWith<$Res> {
  factory _$VolunteeringInterestCopyWith(_VolunteeringInterest value, $Res Function(_VolunteeringInterest) _then) = __$VolunteeringInterestCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$VolunteeringInterestCopyWithImpl<$Res>
    implements _$VolunteeringInterestCopyWith<$Res> {
  __$VolunteeringInterestCopyWithImpl(this._self, this._then);

  final _VolunteeringInterest _self;
  final $Res Function(_VolunteeringInterest) _then;

/// Create a copy of VolunteeringInterest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_VolunteeringInterest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
