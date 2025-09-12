// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Application {

 int get id; int get applicationFormId; int get userId; int get opportunityId; ApplicationStatus get status; DateTime get submittedAt; DateTime? get reviewedAt; String? get reviewerNotes; Opportunity get opportunity; List<ApplicationResponse> get responses;
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationCopyWith<Application> get copyWith => _$ApplicationCopyWithImpl<Application>(this as Application, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Application&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationFormId, applicationFormId) || other.applicationFormId == applicationFormId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewerNotes, reviewerNotes) || other.reviewerNotes == reviewerNotes)&&(identical(other.opportunity, opportunity) || other.opportunity == opportunity)&&const DeepCollectionEquality().equals(other.responses, responses));
}


@override
int get hashCode => Object.hash(runtimeType,id,applicationFormId,userId,opportunityId,status,submittedAt,reviewedAt,reviewerNotes,opportunity,const DeepCollectionEquality().hash(responses));

@override
String toString() {
  return 'Application(id: $id, applicationFormId: $applicationFormId, userId: $userId, opportunityId: $opportunityId, status: $status, submittedAt: $submittedAt, reviewedAt: $reviewedAt, reviewerNotes: $reviewerNotes, opportunity: $opportunity, responses: $responses)';
}


}

/// @nodoc
abstract mixin class $ApplicationCopyWith<$Res>  {
  factory $ApplicationCopyWith(Application value, $Res Function(Application) _then) = _$ApplicationCopyWithImpl;
@useResult
$Res call({
 int id, int applicationFormId, int userId, int opportunityId, ApplicationStatus status, DateTime submittedAt, DateTime? reviewedAt, String? reviewerNotes, Opportunity opportunity, List<ApplicationResponse> responses
});


$OpportunityCopyWith<$Res> get opportunity;

}
/// @nodoc
class _$ApplicationCopyWithImpl<$Res>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._self, this._then);

  final Application _self;
  final $Res Function(Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationFormId = null,Object? userId = null,Object? opportunityId = null,Object? status = null,Object? submittedAt = null,Object? reviewedAt = freezed,Object? reviewerNotes = freezed,Object? opportunity = null,Object? responses = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,applicationFormId: null == applicationFormId ? _self.applicationFormId : applicationFormId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewerNotes: freezed == reviewerNotes ? _self.reviewerNotes : reviewerNotes // ignore: cast_nullable_to_non_nullable
as String?,opportunity: null == opportunity ? _self.opportunity : opportunity // ignore: cast_nullable_to_non_nullable
as Opportunity,responses: null == responses ? _self.responses : responses // ignore: cast_nullable_to_non_nullable
as List<ApplicationResponse>,
  ));
}
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpportunityCopyWith<$Res> get opportunity {
  
  return $OpportunityCopyWith<$Res>(_self.opportunity, (value) {
    return _then(_self.copyWith(opportunity: value));
  });
}
}


/// @nodoc


class _Application implements Application {
  const _Application({required this.id, required this.applicationFormId, required this.userId, required this.opportunityId, required this.status, required this.submittedAt, this.reviewedAt, this.reviewerNotes, required this.opportunity, required final  List<ApplicationResponse> responses}): _responses = responses;
  

@override final  int id;
@override final  int applicationFormId;
@override final  int userId;
@override final  int opportunityId;
@override final  ApplicationStatus status;
@override final  DateTime submittedAt;
@override final  DateTime? reviewedAt;
@override final  String? reviewerNotes;
@override final  Opportunity opportunity;
 final  List<ApplicationResponse> _responses;
@override List<ApplicationResponse> get responses {
  if (_responses is EqualUnmodifiableListView) return _responses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responses);
}


/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationCopyWith<_Application> get copyWith => __$ApplicationCopyWithImpl<_Application>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Application&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationFormId, applicationFormId) || other.applicationFormId == applicationFormId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opportunityId, opportunityId) || other.opportunityId == opportunityId)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewerNotes, reviewerNotes) || other.reviewerNotes == reviewerNotes)&&(identical(other.opportunity, opportunity) || other.opportunity == opportunity)&&const DeepCollectionEquality().equals(other._responses, _responses));
}


@override
int get hashCode => Object.hash(runtimeType,id,applicationFormId,userId,opportunityId,status,submittedAt,reviewedAt,reviewerNotes,opportunity,const DeepCollectionEquality().hash(_responses));

@override
String toString() {
  return 'Application(id: $id, applicationFormId: $applicationFormId, userId: $userId, opportunityId: $opportunityId, status: $status, submittedAt: $submittedAt, reviewedAt: $reviewedAt, reviewerNotes: $reviewerNotes, opportunity: $opportunity, responses: $responses)';
}


}

/// @nodoc
abstract mixin class _$ApplicationCopyWith<$Res> implements $ApplicationCopyWith<$Res> {
  factory _$ApplicationCopyWith(_Application value, $Res Function(_Application) _then) = __$ApplicationCopyWithImpl;
@override @useResult
$Res call({
 int id, int applicationFormId, int userId, int opportunityId, ApplicationStatus status, DateTime submittedAt, DateTime? reviewedAt, String? reviewerNotes, Opportunity opportunity, List<ApplicationResponse> responses
});


@override $OpportunityCopyWith<$Res> get opportunity;

}
/// @nodoc
class __$ApplicationCopyWithImpl<$Res>
    implements _$ApplicationCopyWith<$Res> {
  __$ApplicationCopyWithImpl(this._self, this._then);

  final _Application _self;
  final $Res Function(_Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationFormId = null,Object? userId = null,Object? opportunityId = null,Object? status = null,Object? submittedAt = null,Object? reviewedAt = freezed,Object? reviewerNotes = freezed,Object? opportunity = null,Object? responses = null,}) {
  return _then(_Application(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,applicationFormId: null == applicationFormId ? _self.applicationFormId : applicationFormId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,opportunityId: null == opportunityId ? _self.opportunityId : opportunityId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewerNotes: freezed == reviewerNotes ? _self.reviewerNotes : reviewerNotes // ignore: cast_nullable_to_non_nullable
as String?,opportunity: null == opportunity ? _self.opportunity : opportunity // ignore: cast_nullable_to_non_nullable
as Opportunity,responses: null == responses ? _self._responses : responses // ignore: cast_nullable_to_non_nullable
as List<ApplicationResponse>,
  ));
}

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpportunityCopyWith<$Res> get opportunity {
  
  return $OpportunityCopyWith<$Res>(_self.opportunity, (value) {
    return _then(_self.copyWith(opportunity: value));
  });
}
}

// dart format on
