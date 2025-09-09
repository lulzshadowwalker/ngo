// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_ticket_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SupportTicketState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportTicketState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SupportTicketState()';
}


}

/// @nodoc
class $SupportTicketStateCopyWith<$Res>  {
$SupportTicketStateCopyWith(SupportTicketState _, $Res Function(SupportTicketState) __);
}


/// @nodoc


class _Initial implements SupportTicketState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SupportTicketState.initial()';
}


}




/// @nodoc


class _Loading implements SupportTicketState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SupportTicketState.loading()';
}


}




/// @nodoc


class _Error implements SupportTicketState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SupportTicketState
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
  return 'SupportTicketState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SupportTicketStateCopyWith<$Res> {
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

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TicketsLoaded implements SupportTicketState {
  const _TicketsLoaded(final  List<SupportTicket> tickets): _tickets = tickets;
  

 final  List<SupportTicket> _tickets;
 List<SupportTicket> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}


/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketsLoadedCopyWith<_TicketsLoaded> get copyWith => __$TicketsLoadedCopyWithImpl<_TicketsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketsLoaded&&const DeepCollectionEquality().equals(other._tickets, _tickets));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickets));

@override
String toString() {
  return 'SupportTicketState.ticketsLoaded(tickets: $tickets)';
}


}

/// @nodoc
abstract mixin class _$TicketsLoadedCopyWith<$Res> implements $SupportTicketStateCopyWith<$Res> {
  factory _$TicketsLoadedCopyWith(_TicketsLoaded value, $Res Function(_TicketsLoaded) _then) = __$TicketsLoadedCopyWithImpl;
@useResult
$Res call({
 List<SupportTicket> tickets
});




}
/// @nodoc
class __$TicketsLoadedCopyWithImpl<$Res>
    implements _$TicketsLoadedCopyWith<$Res> {
  __$TicketsLoadedCopyWithImpl(this._self, this._then);

  final _TicketsLoaded _self;
  final $Res Function(_TicketsLoaded) _then;

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tickets = null,}) {
  return _then(_TicketsLoaded(
null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<SupportTicket>,
  ));
}


}

/// @nodoc


class _TicketLoaded implements SupportTicketState {
  const _TicketLoaded(this.ticket);
  

 final  SupportTicket ticket;

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketLoadedCopyWith<_TicketLoaded> get copyWith => __$TicketLoadedCopyWithImpl<_TicketLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketLoaded&&(identical(other.ticket, ticket) || other.ticket == ticket));
}


@override
int get hashCode => Object.hash(runtimeType,ticket);

@override
String toString() {
  return 'SupportTicketState.ticketLoaded(ticket: $ticket)';
}


}

/// @nodoc
abstract mixin class _$TicketLoadedCopyWith<$Res> implements $SupportTicketStateCopyWith<$Res> {
  factory _$TicketLoadedCopyWith(_TicketLoaded value, $Res Function(_TicketLoaded) _then) = __$TicketLoadedCopyWithImpl;
@useResult
$Res call({
 SupportTicket ticket
});


$SupportTicketCopyWith<$Res> get ticket;

}
/// @nodoc
class __$TicketLoadedCopyWithImpl<$Res>
    implements _$TicketLoadedCopyWith<$Res> {
  __$TicketLoadedCopyWithImpl(this._self, this._then);

  final _TicketLoaded _self;
  final $Res Function(_TicketLoaded) _then;

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticket = null,}) {
  return _then(_TicketLoaded(
null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as SupportTicket,
  ));
}

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportTicketCopyWith<$Res> get ticket {
  
  return $SupportTicketCopyWith<$Res>(_self.ticket, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}
}

/// @nodoc


class _TicketCreated implements SupportTicketState {
  const _TicketCreated(this.ticket);
  

 final  SupportTicket ticket;

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCreatedCopyWith<_TicketCreated> get copyWith => __$TicketCreatedCopyWithImpl<_TicketCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketCreated&&(identical(other.ticket, ticket) || other.ticket == ticket));
}


@override
int get hashCode => Object.hash(runtimeType,ticket);

@override
String toString() {
  return 'SupportTicketState.ticketCreated(ticket: $ticket)';
}


}

/// @nodoc
abstract mixin class _$TicketCreatedCopyWith<$Res> implements $SupportTicketStateCopyWith<$Res> {
  factory _$TicketCreatedCopyWith(_TicketCreated value, $Res Function(_TicketCreated) _then) = __$TicketCreatedCopyWithImpl;
@useResult
$Res call({
 SupportTicket ticket
});


$SupportTicketCopyWith<$Res> get ticket;

}
/// @nodoc
class __$TicketCreatedCopyWithImpl<$Res>
    implements _$TicketCreatedCopyWith<$Res> {
  __$TicketCreatedCopyWithImpl(this._self, this._then);

  final _TicketCreated _self;
  final $Res Function(_TicketCreated) _then;

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticket = null,}) {
  return _then(_TicketCreated(
null == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as SupportTicket,
  ));
}

/// Create a copy of SupportTicketState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SupportTicketCopyWith<$Res> get ticket {
  
  return $SupportTicketCopyWith<$Res>(_self.ticket, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}
}

// dart format on
