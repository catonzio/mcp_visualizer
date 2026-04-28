// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mcp_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$McpFailure {

 String get message; Object? get cause;
/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$McpFailureCopyWith<McpFailure> get copyWith => _$McpFailureCopyWithImpl<McpFailure>(this as McpFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is McpFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $McpFailureCopyWith<$Res>  {
  factory $McpFailureCopyWith(McpFailure value, $Res Function(McpFailure) _then) = _$McpFailureCopyWithImpl;
@useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$McpFailureCopyWithImpl<$Res>
    implements $McpFailureCopyWith<$Res> {
  _$McpFailureCopyWithImpl(this._self, this._then);

  final McpFailure _self;
  final $Res Function(McpFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}

}


/// Adds pattern-matching-related methods to [McpFailure].
extension McpFailurePatterns on McpFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TransportFailure value)?  transport,TResult Function( ProtocolFailure value)?  protocol,TResult Function( SerializationFailure value)?  serialization,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TransportFailure() when transport != null:
return transport(_that);case ProtocolFailure() when protocol != null:
return protocol(_that);case SerializationFailure() when serialization != null:
return serialization(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TransportFailure value)  transport,required TResult Function( ProtocolFailure value)  protocol,required TResult Function( SerializationFailure value)  serialization,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TransportFailure():
return transport(_that);case ProtocolFailure():
return protocol(_that);case SerializationFailure():
return serialization(_that);case UnknownFailure():
return unknown(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TransportFailure value)?  transport,TResult? Function( ProtocolFailure value)?  protocol,TResult? Function( SerializationFailure value)?  serialization,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TransportFailure() when transport != null:
return transport(_that);case ProtocolFailure() when protocol != null:
return protocol(_that);case SerializationFailure() when serialization != null:
return serialization(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  Object? cause)?  network,TResult Function( String message,  Object? cause)?  transport,TResult Function( String message,  int? code,  Object? cause)?  protocol,TResult Function( String message,  Object? cause)?  serialization,TResult Function( String message,  Object? cause)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case TransportFailure() when transport != null:
return transport(_that.message,_that.cause);case ProtocolFailure() when protocol != null:
return protocol(_that.message,_that.code,_that.cause);case SerializationFailure() when serialization != null:
return serialization(_that.message,_that.cause);case UnknownFailure() when unknown != null:
return unknown(_that.message,_that.cause);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  Object? cause)  network,required TResult Function( String message,  Object? cause)  transport,required TResult Function( String message,  int? code,  Object? cause)  protocol,required TResult Function( String message,  Object? cause)  serialization,required TResult Function( String message,  Object? cause)  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that.message,_that.cause);case TransportFailure():
return transport(_that.message,_that.cause);case ProtocolFailure():
return protocol(_that.message,_that.code,_that.cause);case SerializationFailure():
return serialization(_that.message,_that.cause);case UnknownFailure():
return unknown(_that.message,_that.cause);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  Object? cause)?  network,TResult? Function( String message,  Object? cause)?  transport,TResult? Function( String message,  int? code,  Object? cause)?  protocol,TResult? Function( String message,  Object? cause)?  serialization,TResult? Function( String message,  Object? cause)?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case TransportFailure() when transport != null:
return transport(_that.message,_that.cause);case ProtocolFailure() when protocol != null:
return protocol(_that.message,_that.code,_that.cause);case SerializationFailure() when serialization != null:
return serialization(_that.message,_that.cause);case UnknownFailure() when unknown != null:
return unknown(_that.message,_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure implements McpFailure {
  const NetworkFailure({required this.message, this.cause});
  

@override final  String message;
@override final  Object? cause;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure.network(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $McpFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(NetworkFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class TransportFailure implements McpFailure {
  const TransportFailure({required this.message, this.cause});
  

@override final  String message;
@override final  Object? cause;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportFailureCopyWith<TransportFailure> get copyWith => _$TransportFailureCopyWithImpl<TransportFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure.transport(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $TransportFailureCopyWith<$Res> implements $McpFailureCopyWith<$Res> {
  factory $TransportFailureCopyWith(TransportFailure value, $Res Function(TransportFailure) _then) = _$TransportFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$TransportFailureCopyWithImpl<$Res>
    implements $TransportFailureCopyWith<$Res> {
  _$TransportFailureCopyWithImpl(this._self, this._then);

  final TransportFailure _self;
  final $Res Function(TransportFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(TransportFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class ProtocolFailure implements McpFailure {
  const ProtocolFailure({required this.message, this.code, this.cause});
  

@override final  String message;
 final  int? code;
@override final  Object? cause;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProtocolFailureCopyWith<ProtocolFailure> get copyWith => _$ProtocolFailureCopyWithImpl<ProtocolFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProtocolFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,code,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure.protocol(message: $message, code: $code, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $ProtocolFailureCopyWith<$Res> implements $McpFailureCopyWith<$Res> {
  factory $ProtocolFailureCopyWith(ProtocolFailure value, $Res Function(ProtocolFailure) _then) = _$ProtocolFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, int? code, Object? cause
});




}
/// @nodoc
class _$ProtocolFailureCopyWithImpl<$Res>
    implements $ProtocolFailureCopyWith<$Res> {
  _$ProtocolFailureCopyWithImpl(this._self, this._then);

  final ProtocolFailure _self;
  final $Res Function(ProtocolFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,Object? cause = freezed,}) {
  return _then(ProtocolFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class SerializationFailure implements McpFailure {
  const SerializationFailure({required this.message, this.cause});
  

@override final  String message;
@override final  Object? cause;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SerializationFailureCopyWith<SerializationFailure> get copyWith => _$SerializationFailureCopyWithImpl<SerializationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SerializationFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure.serialization(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $SerializationFailureCopyWith<$Res> implements $McpFailureCopyWith<$Res> {
  factory $SerializationFailureCopyWith(SerializationFailure value, $Res Function(SerializationFailure) _then) = _$SerializationFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$SerializationFailureCopyWithImpl<$Res>
    implements $SerializationFailureCopyWith<$Res> {
  _$SerializationFailureCopyWithImpl(this._self, this._then);

  final SerializationFailure _self;
  final $Res Function(SerializationFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(SerializationFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class UnknownFailure implements McpFailure {
  const UnknownFailure({required this.message, this.cause});
  

@override final  String message;
@override final  Object? cause;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'McpFailure.unknown(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $McpFailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of McpFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(UnknownFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

// dart format on
