// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$User {

 String get id; String get name; String get email; String? get avatar; String? get bio; DateTime? get birthdate; String? get phone; Location? get location; List<String>? get skills; List<String>? get volunteeringInterests; List<Organization>? get following;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.volunteeringInterests, volunteeringInterests)&&const DeepCollectionEquality().equals(other.following, following));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatar,bio,birthdate,phone,location,const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(volunteeringInterests),const DeepCollectionEquality().hash(following));

@override
String toString() {
  return 'User(id: $id, name: $name, email: $email, avatar: $avatar, bio: $bio, birthdate: $birthdate, phone: $phone, location: $location, skills: $skills, volunteeringInterests: $volunteeringInterests, following: $following)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String? avatar, String? bio, DateTime? birthdate, String? phone, Location? location, List<String>? skills, List<String>? volunteeringInterests, List<Organization>? following
});


$LocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? avatar = freezed,Object? bio = freezed,Object? birthdate = freezed,Object? phone = freezed,Object? location = freezed,Object? skills = freezed,Object? volunteeringInterests = freezed,Object? following = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location?,skills: freezed == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,volunteeringInterests: freezed == volunteeringInterests ? _self.volunteeringInterests : volunteeringInterests // ignore: cast_nullable_to_non_nullable
as List<String>?,following: freezed == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as List<Organization>?,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc


class _User implements User {
  const _User({required this.id, required this.name, required this.email, required this.avatar, required this.bio, required this.birthdate, this.phone, this.location, final  List<String>? skills, final  List<String>? volunteeringInterests, final  List<Organization>? following}): _skills = skills,_volunteeringInterests = volunteeringInterests,_following = following;
  

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String? avatar;
@override final  String? bio;
@override final  DateTime? birthdate;
@override final  String? phone;
@override final  Location? location;
 final  List<String>? _skills;
@override List<String>? get skills {
  final value = _skills;
  if (value == null) return null;
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _volunteeringInterests;
@override List<String>? get volunteeringInterests {
  final value = _volunteeringInterests;
  if (value == null) return null;
  if (_volunteeringInterests is EqualUnmodifiableListView) return _volunteeringInterests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Organization>? _following;
@override List<Organization>? get following {
  final value = _following;
  if (value == null) return null;
  if (_following is EqualUnmodifiableListView) return _following;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._volunteeringInterests, _volunteeringInterests)&&const DeepCollectionEquality().equals(other._following, _following));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatar,bio,birthdate,phone,location,const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_volunteeringInterests),const DeepCollectionEquality().hash(_following));

@override
String toString() {
  return 'User(id: $id, name: $name, email: $email, avatar: $avatar, bio: $bio, birthdate: $birthdate, phone: $phone, location: $location, skills: $skills, volunteeringInterests: $volunteeringInterests, following: $following)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String? avatar, String? bio, DateTime? birthdate, String? phone, Location? location, List<String>? skills, List<String>? volunteeringInterests, List<Organization>? following
});


@override $LocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? avatar = freezed,Object? bio = freezed,Object? birthdate = freezed,Object? phone = freezed,Object? location = freezed,Object? skills = freezed,Object? volunteeringInterests = freezed,Object? following = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location?,skills: freezed == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,volunteeringInterests: freezed == volunteeringInterests ? _self._volunteeringInterests : volunteeringInterests // ignore: cast_nullable_to_non_nullable
as List<String>?,following: freezed == following ? _self._following : following // ignore: cast_nullable_to_non_nullable
as List<Organization>?,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
