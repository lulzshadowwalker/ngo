// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// @nodoc


class _Initial implements HomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class _Loading implements HomeState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class _FollowingLoaded implements HomeState {
  const _FollowingLoaded({required this.profileCompletion, required final  List<Post> posts, required final  List<Opportunity> opportunities}): _posts = posts,_opportunities = opportunities;
  

 final  int profileCompletion;
 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  List<Opportunity> _opportunities;
 List<Opportunity> get opportunities {
  if (_opportunities is EqualUnmodifiableListView) return _opportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunities);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowingLoadedCopyWith<_FollowingLoaded> get copyWith => __$FollowingLoadedCopyWithImpl<_FollowingLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowingLoaded&&(identical(other.profileCompletion, profileCompletion) || other.profileCompletion == profileCompletion)&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._opportunities, _opportunities));
}


@override
int get hashCode => Object.hash(runtimeType,profileCompletion,const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_opportunities));

@override
String toString() {
  return 'HomeState.followingLoaded(profileCompletion: $profileCompletion, posts: $posts, opportunities: $opportunities)';
}


}

/// @nodoc
abstract mixin class _$FollowingLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$FollowingLoadedCopyWith(_FollowingLoaded value, $Res Function(_FollowingLoaded) _then) = __$FollowingLoadedCopyWithImpl;
@useResult
$Res call({
 int profileCompletion, List<Post> posts, List<Opportunity> opportunities
});




}
/// @nodoc
class __$FollowingLoadedCopyWithImpl<$Res>
    implements _$FollowingLoadedCopyWith<$Res> {
  __$FollowingLoadedCopyWithImpl(this._self, this._then);

  final _FollowingLoaded _self;
  final $Res Function(_FollowingLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profileCompletion = null,Object? posts = null,Object? opportunities = null,}) {
  return _then(_FollowingLoaded(
profileCompletion: null == profileCompletion ? _self.profileCompletion : profileCompletion // ignore: cast_nullable_to_non_nullable
as int,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,opportunities: null == opportunities ? _self._opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<Opportunity>,
  ));
}


}

/// @nodoc


class _RecentLoaded implements HomeState {
  const _RecentLoaded({required final  List<Post> posts, required final  List<Opportunity> opportunities}): _posts = posts,_opportunities = opportunities;
  

 final  List<Post> _posts;
 List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  List<Opportunity> _opportunities;
 List<Opportunity> get opportunities {
  if (_opportunities is EqualUnmodifiableListView) return _opportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opportunities);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentLoadedCopyWith<_RecentLoaded> get copyWith => __$RecentLoadedCopyWithImpl<_RecentLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentLoaded&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._opportunities, _opportunities));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_opportunities));

@override
String toString() {
  return 'HomeState.recentLoaded(posts: $posts, opportunities: $opportunities)';
}


}

/// @nodoc
abstract mixin class _$RecentLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$RecentLoadedCopyWith(_RecentLoaded value, $Res Function(_RecentLoaded) _then) = __$RecentLoadedCopyWithImpl;
@useResult
$Res call({
 List<Post> posts, List<Opportunity> opportunities
});




}
/// @nodoc
class __$RecentLoadedCopyWithImpl<$Res>
    implements _$RecentLoadedCopyWith<$Res> {
  __$RecentLoadedCopyWithImpl(this._self, this._then);

  final _RecentLoaded _self;
  final $Res Function(_RecentLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? opportunities = null,}) {
  return _then(_RecentLoaded(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,opportunities: null == opportunities ? _self._opportunities : opportunities // ignore: cast_nullable_to_non_nullable
as List<Opportunity>,
  ));
}


}

/// @nodoc


class _Error implements HomeState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of HomeState
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
  return 'HomeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
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

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
