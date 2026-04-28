// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$McpConnectionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is McpConnectionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'McpConnectionState()';
}


}

/// @nodoc
class $McpConnectionStateCopyWith<$Res>  {
$McpConnectionStateCopyWith(McpConnectionState _, $Res Function(McpConnectionState) __);
}


/// Adds pattern-matching-related methods to [McpConnectionState].
extension McpConnectionStatePatterns on McpConnectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Disconnected value)?  disconnected,TResult Function( Connecting value)?  connecting,TResult Function( Connected value)?  connected,TResult Function( ConnectionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Disconnected() when disconnected != null:
return disconnected(_that);case Connecting() when connecting != null:
return connecting(_that);case Connected() when connected != null:
return connected(_that);case ConnectionError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Disconnected value)  disconnected,required TResult Function( Connecting value)  connecting,required TResult Function( Connected value)  connected,required TResult Function( ConnectionError value)  error,}){
final _that = this;
switch (_that) {
case Disconnected():
return disconnected(_that);case Connecting():
return connecting(_that);case Connected():
return connected(_that);case ConnectionError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Disconnected value)?  disconnected,TResult? Function( Connecting value)?  connecting,TResult? Function( Connected value)?  connected,TResult? Function( ConnectionError value)?  error,}){
final _that = this;
switch (_that) {
case Disconnected() when disconnected != null:
return disconnected(_that);case Connecting() when connecting != null:
return connecting(_that);case Connected() when connected != null:
return connected(_that);case ConnectionError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  disconnected,TResult Function()?  connecting,TResult Function( ServerInfo serverInfo)?  connected,TResult Function( McpFailure failure,  int reconnectAttempts)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Disconnected() when disconnected != null:
return disconnected();case Connecting() when connecting != null:
return connecting();case Connected() when connected != null:
return connected(_that.serverInfo);case ConnectionError() when error != null:
return error(_that.failure,_that.reconnectAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  disconnected,required TResult Function()  connecting,required TResult Function( ServerInfo serverInfo)  connected,required TResult Function( McpFailure failure,  int reconnectAttempts)  error,}) {final _that = this;
switch (_that) {
case Disconnected():
return disconnected();case Connecting():
return connecting();case Connected():
return connected(_that.serverInfo);case ConnectionError():
return error(_that.failure,_that.reconnectAttempts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  disconnected,TResult? Function()?  connecting,TResult? Function( ServerInfo serverInfo)?  connected,TResult? Function( McpFailure failure,  int reconnectAttempts)?  error,}) {final _that = this;
switch (_that) {
case Disconnected() when disconnected != null:
return disconnected();case Connecting() when connecting != null:
return connecting();case Connected() when connected != null:
return connected(_that.serverInfo);case ConnectionError() when error != null:
return error(_that.failure,_that.reconnectAttempts);case _:
  return null;

}
}

}

/// @nodoc


class Disconnected implements McpConnectionState {
  const Disconnected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Disconnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'McpConnectionState.disconnected()';
}


}




/// @nodoc


class Connecting implements McpConnectionState {
  const Connecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Connecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'McpConnectionState.connecting()';
}


}




/// @nodoc


class Connected implements McpConnectionState {
  const Connected({required this.serverInfo});
  

 final  ServerInfo serverInfo;

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectedCopyWith<Connected> get copyWith => _$ConnectedCopyWithImpl<Connected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Connected&&(identical(other.serverInfo, serverInfo) || other.serverInfo == serverInfo));
}


@override
int get hashCode => Object.hash(runtimeType,serverInfo);

@override
String toString() {
  return 'McpConnectionState.connected(serverInfo: $serverInfo)';
}


}

/// @nodoc
abstract mixin class $ConnectedCopyWith<$Res> implements $McpConnectionStateCopyWith<$Res> {
  factory $ConnectedCopyWith(Connected value, $Res Function(Connected) _then) = _$ConnectedCopyWithImpl;
@useResult
$Res call({
 ServerInfo serverInfo
});


$ServerInfoCopyWith<$Res> get serverInfo;

}
/// @nodoc
class _$ConnectedCopyWithImpl<$Res>
    implements $ConnectedCopyWith<$Res> {
  _$ConnectedCopyWithImpl(this._self, this._then);

  final Connected _self;
  final $Res Function(Connected) _then;

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serverInfo = null,}) {
  return _then(Connected(
serverInfo: null == serverInfo ? _self.serverInfo : serverInfo // ignore: cast_nullable_to_non_nullable
as ServerInfo,
  ));
}

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerInfoCopyWith<$Res> get serverInfo {
  
  return $ServerInfoCopyWith<$Res>(_self.serverInfo, (value) {
    return _then(_self.copyWith(serverInfo: value));
  });
}
}

/// @nodoc


class ConnectionError implements McpConnectionState {
  const ConnectionError({required this.failure, this.reconnectAttempts = 0});
  

 final  McpFailure failure;
@JsonKey() final  int reconnectAttempts;

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionErrorCopyWith<ConnectionError> get copyWith => _$ConnectionErrorCopyWithImpl<ConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionError&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.reconnectAttempts, reconnectAttempts) || other.reconnectAttempts == reconnectAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,failure,reconnectAttempts);

@override
String toString() {
  return 'McpConnectionState.error(failure: $failure, reconnectAttempts: $reconnectAttempts)';
}


}

/// @nodoc
abstract mixin class $ConnectionErrorCopyWith<$Res> implements $McpConnectionStateCopyWith<$Res> {
  factory $ConnectionErrorCopyWith(ConnectionError value, $Res Function(ConnectionError) _then) = _$ConnectionErrorCopyWithImpl;
@useResult
$Res call({
 McpFailure failure, int reconnectAttempts
});


$McpFailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ConnectionErrorCopyWithImpl<$Res>
    implements $ConnectionErrorCopyWith<$Res> {
  _$ConnectionErrorCopyWithImpl(this._self, this._then);

  final ConnectionError _self;
  final $Res Function(ConnectionError) _then;

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? reconnectAttempts = null,}) {
  return _then(ConnectionError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as McpFailure,reconnectAttempts: null == reconnectAttempts ? _self.reconnectAttempts : reconnectAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of McpConnectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$McpFailureCopyWith<$Res> get failure {
  
  return $McpFailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
