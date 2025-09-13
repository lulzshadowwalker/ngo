// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Opportunity {

 String get id; String get title; String get description; String get cover; String? get aboutTheRole; int get duration; DateTime get expiryDate; String? get latitude; String? get longitude; String? get locationDescription; List<String> get tags;// Changed from List<String> to String
 List<String> get keyResponsibilities; List<String> get requiredSkills; List<String> get timeCommitment; List<String> get benefits; String? get extra; bool get isFeatured; OpportunityStatus get status; DateTime get createdAt; DateTime get updatedAt; Organization get organization; Sector get sector; int get locationId;// Changed from Location object to int
 int? get programId;// Added programId field
 Program? get program; ApplicationForm? get applicationForm;
/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpportunityCopyWith<Opportunity> get copyWith => _$OpportunityCopyWithImpl<Opportunity>(this as Opportunity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Opportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.aboutTheRole, aboutTheRole) || other.aboutTheRole == aboutTheRole)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.keyResponsibilities, keyResponsibilities)&&const DeepCollectionEquality().equals(other.requiredSkills, requiredSkills)&&const DeepCollectionEquality().equals(other.timeCommitment, timeCommitment)&&const DeepCollectionEquality().equals(other.benefits, benefits)&&(identical(other.extra, extra) || other.extra == extra)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.locationId, locationId) || other.locationId == locationId)&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.program, program) || other.program == program)&&(identical(other.applicationForm, applicationForm) || other.applicationForm == applicationForm));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,cover,aboutTheRole,duration,expiryDate,latitude,longitude,locationDescription,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(keyResponsibilities),const DeepCollectionEquality().hash(requiredSkills),const DeepCollectionEquality().hash(timeCommitment),const DeepCollectionEquality().hash(benefits),extra,isFeatured,status,createdAt,updatedAt,organization,sector,locationId,programId,program,applicationForm]);

@override
String toString() {
  return 'Opportunity(id: $id, title: $title, description: $description, cover: $cover, aboutTheRole: $aboutTheRole, duration: $duration, expiryDate: $expiryDate, latitude: $latitude, longitude: $longitude, locationDescription: $locationDescription, tags: $tags, keyResponsibilities: $keyResponsibilities, requiredSkills: $requiredSkills, timeCommitment: $timeCommitment, benefits: $benefits, extra: $extra, isFeatured: $isFeatured, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, organization: $organization, sector: $sector, locationId: $locationId, programId: $programId, program: $program, applicationForm: $applicationForm)';
}


}

/// @nodoc
abstract mixin class $OpportunityCopyWith<$Res>  {
  factory $OpportunityCopyWith(Opportunity value, $Res Function(Opportunity) _then) = _$OpportunityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String cover, String? aboutTheRole, int duration, DateTime expiryDate, String? latitude, String? longitude, String? locationDescription, List<String> tags, List<String> keyResponsibilities, List<String> requiredSkills, List<String> timeCommitment, List<String> benefits, String? extra, bool isFeatured, OpportunityStatus status, DateTime createdAt, DateTime updatedAt, Organization organization, Sector sector, int locationId, int? programId, Program? program, ApplicationForm? applicationForm
});


$OrganizationCopyWith<$Res> get organization;$SectorCopyWith<$Res> get sector;$ProgramCopyWith<$Res>? get program;$ApplicationFormCopyWith<$Res>? get applicationForm;

}
/// @nodoc
class _$OpportunityCopyWithImpl<$Res>
    implements $OpportunityCopyWith<$Res> {
  _$OpportunityCopyWithImpl(this._self, this._then);

  final Opportunity _self;
  final $Res Function(Opportunity) _then;

/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? cover = null,Object? aboutTheRole = freezed,Object? duration = null,Object? expiryDate = null,Object? latitude = freezed,Object? longitude = freezed,Object? locationDescription = freezed,Object? tags = null,Object? keyResponsibilities = null,Object? requiredSkills = null,Object? timeCommitment = null,Object? benefits = null,Object? extra = freezed,Object? isFeatured = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? organization = null,Object? sector = null,Object? locationId = null,Object? programId = freezed,Object? program = freezed,Object? applicationForm = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,aboutTheRole: freezed == aboutTheRole ? _self.aboutTheRole : aboutTheRole // ignore: cast_nullable_to_non_nullable
as String?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,locationDescription: freezed == locationDescription ? _self.locationDescription : locationDescription // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,keyResponsibilities: null == keyResponsibilities ? _self.keyResponsibilities : keyResponsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,requiredSkills: null == requiredSkills ? _self.requiredSkills : requiredSkills // ignore: cast_nullable_to_non_nullable
as List<String>,timeCommitment: null == timeCommitment ? _self.timeCommitment : timeCommitment // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,extra: freezed == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OpportunityStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as Organization,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,locationId: null == locationId ? _self.locationId : locationId // ignore: cast_nullable_to_non_nullable
as int,programId: freezed == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as int?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as Program?,applicationForm: freezed == applicationForm ? _self.applicationForm : applicationForm // ignore: cast_nullable_to_non_nullable
as ApplicationForm?,
  ));
}
/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationCopyWith<$Res> get organization {
  
  return $OrganizationCopyWith<$Res>(_self.organization, (value) {
    return _then(_self.copyWith(organization: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorCopyWith<$Res> get sector {
  
  return $SectorCopyWith<$Res>(_self.sector, (value) {
    return _then(_self.copyWith(sector: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgramCopyWith<$Res>? get program {
    if (_self.program == null) {
    return null;
  }

  return $ProgramCopyWith<$Res>(_self.program!, (value) {
    return _then(_self.copyWith(program: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationFormCopyWith<$Res>? get applicationForm {
    if (_self.applicationForm == null) {
    return null;
  }

  return $ApplicationFormCopyWith<$Res>(_self.applicationForm!, (value) {
    return _then(_self.copyWith(applicationForm: value));
  });
}
}


/// @nodoc


class _Opportunity implements Opportunity {
  const _Opportunity({required this.id, required this.title, required this.description, required this.cover, this.aboutTheRole, required this.duration, required this.expiryDate, this.latitude, this.longitude, this.locationDescription, required final  List<String> tags, required final  List<String> keyResponsibilities, required final  List<String> requiredSkills, required final  List<String> timeCommitment, required final  List<String> benefits, this.extra, required this.isFeatured, required this.status, required this.createdAt, required this.updatedAt, required this.organization, required this.sector, required this.locationId, this.programId, this.program, this.applicationForm}): _tags = tags,_keyResponsibilities = keyResponsibilities,_requiredSkills = requiredSkills,_timeCommitment = timeCommitment,_benefits = benefits;
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String cover;
@override final  String? aboutTheRole;
@override final  int duration;
@override final  DateTime expiryDate;
@override final  String? latitude;
@override final  String? longitude;
@override final  String? locationDescription;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

// Changed from List<String> to String
 final  List<String> _keyResponsibilities;
// Changed from List<String> to String
@override List<String> get keyResponsibilities {
  if (_keyResponsibilities is EqualUnmodifiableListView) return _keyResponsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyResponsibilities);
}

 final  List<String> _requiredSkills;
@override List<String> get requiredSkills {
  if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredSkills);
}

 final  List<String> _timeCommitment;
@override List<String> get timeCommitment {
  if (_timeCommitment is EqualUnmodifiableListView) return _timeCommitment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeCommitment);
}

 final  List<String> _benefits;
@override List<String> get benefits {
  if (_benefits is EqualUnmodifiableListView) return _benefits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_benefits);
}

@override final  String? extra;
@override final  bool isFeatured;
@override final  OpportunityStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  Organization organization;
@override final  Sector sector;
@override final  int locationId;
// Changed from Location object to int
@override final  int? programId;
// Added programId field
@override final  Program? program;
@override final  ApplicationForm? applicationForm;

/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpportunityCopyWith<_Opportunity> get copyWith => __$OpportunityCopyWithImpl<_Opportunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Opportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.aboutTheRole, aboutTheRole) || other.aboutTheRole == aboutTheRole)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationDescription, locationDescription) || other.locationDescription == locationDescription)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._keyResponsibilities, _keyResponsibilities)&&const DeepCollectionEquality().equals(other._requiredSkills, _requiredSkills)&&const DeepCollectionEquality().equals(other._timeCommitment, _timeCommitment)&&const DeepCollectionEquality().equals(other._benefits, _benefits)&&(identical(other.extra, extra) || other.extra == extra)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.locationId, locationId) || other.locationId == locationId)&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.program, program) || other.program == program)&&(identical(other.applicationForm, applicationForm) || other.applicationForm == applicationForm));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,cover,aboutTheRole,duration,expiryDate,latitude,longitude,locationDescription,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_keyResponsibilities),const DeepCollectionEquality().hash(_requiredSkills),const DeepCollectionEquality().hash(_timeCommitment),const DeepCollectionEquality().hash(_benefits),extra,isFeatured,status,createdAt,updatedAt,organization,sector,locationId,programId,program,applicationForm]);

@override
String toString() {
  return 'Opportunity(id: $id, title: $title, description: $description, cover: $cover, aboutTheRole: $aboutTheRole, duration: $duration, expiryDate: $expiryDate, latitude: $latitude, longitude: $longitude, locationDescription: $locationDescription, tags: $tags, keyResponsibilities: $keyResponsibilities, requiredSkills: $requiredSkills, timeCommitment: $timeCommitment, benefits: $benefits, extra: $extra, isFeatured: $isFeatured, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, organization: $organization, sector: $sector, locationId: $locationId, programId: $programId, program: $program, applicationForm: $applicationForm)';
}


}

/// @nodoc
abstract mixin class _$OpportunityCopyWith<$Res> implements $OpportunityCopyWith<$Res> {
  factory _$OpportunityCopyWith(_Opportunity value, $Res Function(_Opportunity) _then) = __$OpportunityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String cover, String? aboutTheRole, int duration, DateTime expiryDate, String? latitude, String? longitude, String? locationDescription, List<String> tags, List<String> keyResponsibilities, List<String> requiredSkills, List<String> timeCommitment, List<String> benefits, String? extra, bool isFeatured, OpportunityStatus status, DateTime createdAt, DateTime updatedAt, Organization organization, Sector sector, int locationId, int? programId, Program? program, ApplicationForm? applicationForm
});


@override $OrganizationCopyWith<$Res> get organization;@override $SectorCopyWith<$Res> get sector;@override $ProgramCopyWith<$Res>? get program;@override $ApplicationFormCopyWith<$Res>? get applicationForm;

}
/// @nodoc
class __$OpportunityCopyWithImpl<$Res>
    implements _$OpportunityCopyWith<$Res> {
  __$OpportunityCopyWithImpl(this._self, this._then);

  final _Opportunity _self;
  final $Res Function(_Opportunity) _then;

/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? cover = null,Object? aboutTheRole = freezed,Object? duration = null,Object? expiryDate = null,Object? latitude = freezed,Object? longitude = freezed,Object? locationDescription = freezed,Object? tags = null,Object? keyResponsibilities = null,Object? requiredSkills = null,Object? timeCommitment = null,Object? benefits = null,Object? extra = freezed,Object? isFeatured = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? organization = null,Object? sector = null,Object? locationId = null,Object? programId = freezed,Object? program = freezed,Object? applicationForm = freezed,}) {
  return _then(_Opportunity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,cover: null == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String,aboutTheRole: freezed == aboutTheRole ? _self.aboutTheRole : aboutTheRole // ignore: cast_nullable_to_non_nullable
as String?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String?,locationDescription: freezed == locationDescription ? _self.locationDescription : locationDescription // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,keyResponsibilities: null == keyResponsibilities ? _self._keyResponsibilities : keyResponsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,requiredSkills: null == requiredSkills ? _self._requiredSkills : requiredSkills // ignore: cast_nullable_to_non_nullable
as List<String>,timeCommitment: null == timeCommitment ? _self._timeCommitment : timeCommitment // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self._benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,extra: freezed == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OpportunityStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as Organization,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,locationId: null == locationId ? _self.locationId : locationId // ignore: cast_nullable_to_non_nullable
as int,programId: freezed == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as int?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as Program?,applicationForm: freezed == applicationForm ? _self.applicationForm : applicationForm // ignore: cast_nullable_to_non_nullable
as ApplicationForm?,
  ));
}

/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationCopyWith<$Res> get organization {
  
  return $OrganizationCopyWith<$Res>(_self.organization, (value) {
    return _then(_self.copyWith(organization: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SectorCopyWith<$Res> get sector {
  
  return $SectorCopyWith<$Res>(_self.sector, (value) {
    return _then(_self.copyWith(sector: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgramCopyWith<$Res>? get program {
    if (_self.program == null) {
    return null;
  }

  return $ProgramCopyWith<$Res>(_self.program!, (value) {
    return _then(_self.copyWith(program: value));
  });
}/// Create a copy of Opportunity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationFormCopyWith<$Res>? get applicationForm {
    if (_self.applicationForm == null) {
    return null;
  }

  return $ApplicationFormCopyWith<$Res>(_self.applicationForm!, (value) {
    return _then(_self.copyWith(applicationForm: value));
  });
}
}

// dart format on
