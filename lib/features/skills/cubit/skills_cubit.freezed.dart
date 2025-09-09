// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skills_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkillsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SkillsState()';
}


}

/// @nodoc
class $SkillsStateCopyWith<$Res>  {
$SkillsStateCopyWith(SkillsState _, $Res Function(SkillsState) __);
}


/// @nodoc


class _Initial implements SkillsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SkillsState.initial()';
}


}




/// @nodoc


class _Loading implements SkillsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SkillsState.loading()';
}


}




/// @nodoc


class _Loaded implements SkillsState {
  const _Loaded(final  List<Skill> skills): _skills = skills;
  

 final  List<Skill> _skills;
 List<Skill> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}


/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._skills, _skills));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_skills));

@override
String toString() {
  return 'SkillsState.loaded(skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SkillsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Skill> skills
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? skills = null,}) {
  return _then(_Loaded(
null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,
  ));
}


}

/// @nodoc


class _LoadedSingleSkill implements SkillsState {
  const _LoadedSingleSkill(this.skill);
  

 final  Skill skill;

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedSingleSkillCopyWith<_LoadedSingleSkill> get copyWith => __$LoadedSingleSkillCopyWithImpl<_LoadedSingleSkill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedSingleSkill&&(identical(other.skill, skill) || other.skill == skill));
}


@override
int get hashCode => Object.hash(runtimeType,skill);

@override
String toString() {
  return 'SkillsState.loadedSingleSkill(skill: $skill)';
}


}

/// @nodoc
abstract mixin class _$LoadedSingleSkillCopyWith<$Res> implements $SkillsStateCopyWith<$Res> {
  factory _$LoadedSingleSkillCopyWith(_LoadedSingleSkill value, $Res Function(_LoadedSingleSkill) _then) = __$LoadedSingleSkillCopyWithImpl;
@useResult
$Res call({
 Skill skill
});


$SkillCopyWith<$Res> get skill;

}
/// @nodoc
class __$LoadedSingleSkillCopyWithImpl<$Res>
    implements _$LoadedSingleSkillCopyWith<$Res> {
  __$LoadedSingleSkillCopyWithImpl(this._self, this._then);

  final _LoadedSingleSkill _self;
  final $Res Function(_LoadedSingleSkill) _then;

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? skill = null,}) {
  return _then(_LoadedSingleSkill(
null == skill ? _self.skill : skill // ignore: cast_nullable_to_non_nullable
as Skill,
  ));
}

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillCopyWith<$Res> get skill {
  
  return $SkillCopyWith<$Res>(_self.skill, (value) {
    return _then(_self.copyWith(skill: value));
  });
}
}

/// @nodoc


class _Error implements SkillsState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SkillsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SkillsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SkillsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
