// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServerProfile {

 String get id; String get name; TransportType get transportType;// STDIO fields
 String? get command; List<String> get args;// SSE / StreamableHTTP fields
 String? get url;// HTTP extra headers (non-sensitive keys only; values stored in secure storage)
 Map<String, String> get headers;// Key used to retrieve the auth token from flutter_secure_storage
 String? get authTokenKey;// Metadata
 DateTime? get lastConnectedAt;
/// Create a copy of ServerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerProfileCopyWith<ServerProfile> get copyWith => _$ServerProfileCopyWithImpl<ServerProfile>(this as ServerProfile, _$identity);

  /// Serializes this ServerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.transportType, transportType) || other.transportType == transportType)&&(identical(other.command, command) || other.command == command)&&const DeepCollectionEquality().equals(other.args, args)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.headers, headers)&&(identical(other.authTokenKey, authTokenKey) || other.authTokenKey == authTokenKey)&&(identical(other.lastConnectedAt, lastConnectedAt) || other.lastConnectedAt == lastConnectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,transportType,command,const DeepCollectionEquality().hash(args),url,const DeepCollectionEquality().hash(headers),authTokenKey,lastConnectedAt);

@override
String toString() {
  return 'ServerProfile(id: $id, name: $name, transportType: $transportType, command: $command, args: $args, url: $url, headers: $headers, authTokenKey: $authTokenKey, lastConnectedAt: $lastConnectedAt)';
}


}

/// @nodoc
abstract mixin class $ServerProfileCopyWith<$Res>  {
  factory $ServerProfileCopyWith(ServerProfile value, $Res Function(ServerProfile) _then) = _$ServerProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, TransportType transportType, String? command, List<String> args, String? url, Map<String, String> headers, String? authTokenKey, DateTime? lastConnectedAt
});




}
/// @nodoc
class _$ServerProfileCopyWithImpl<$Res>
    implements $ServerProfileCopyWith<$Res> {
  _$ServerProfileCopyWithImpl(this._self, this._then);

  final ServerProfile _self;
  final $Res Function(ServerProfile) _then;

/// Create a copy of ServerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? transportType = null,Object? command = freezed,Object? args = null,Object? url = freezed,Object? headers = null,Object? authTokenKey = freezed,Object? lastConnectedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,command: freezed == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String?,args: null == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as List<String>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,headers: null == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,authTokenKey: freezed == authTokenKey ? _self.authTokenKey : authTokenKey // ignore: cast_nullable_to_non_nullable
as String?,lastConnectedAt: freezed == lastConnectedAt ? _self.lastConnectedAt : lastConnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerProfile].
extension ServerProfilePatterns on ServerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerProfile() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerProfile value)  $default,){
final _that = this;
switch (_that) {
case _ServerProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _ServerProfile() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  TransportType transportType,  String? command,  List<String> args,  String? url,  Map<String, String> headers,  String? authTokenKey,  DateTime? lastConnectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerProfile() when $default != null:
return $default(_that.id,_that.name,_that.transportType,_that.command,_that.args,_that.url,_that.headers,_that.authTokenKey,_that.lastConnectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  TransportType transportType,  String? command,  List<String> args,  String? url,  Map<String, String> headers,  String? authTokenKey,  DateTime? lastConnectedAt)  $default,) {final _that = this;
switch (_that) {
case _ServerProfile():
return $default(_that.id,_that.name,_that.transportType,_that.command,_that.args,_that.url,_that.headers,_that.authTokenKey,_that.lastConnectedAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  TransportType transportType,  String? command,  List<String> args,  String? url,  Map<String, String> headers,  String? authTokenKey,  DateTime? lastConnectedAt)?  $default,) {final _that = this;
switch (_that) {
case _ServerProfile() when $default != null:
return $default(_that.id,_that.name,_that.transportType,_that.command,_that.args,_that.url,_that.headers,_that.authTokenKey,_that.lastConnectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerProfile implements ServerProfile {
  const _ServerProfile({required this.id, required this.name, required this.transportType, this.command, final  List<String> args = const [], this.url, final  Map<String, String> headers = const {}, this.authTokenKey, this.lastConnectedAt}): _args = args,_headers = headers;
  factory _ServerProfile.fromJson(Map<String, dynamic> json) => _$ServerProfileFromJson(json);

@override final  String id;
@override final  String name;
@override final  TransportType transportType;
// STDIO fields
@override final  String? command;
 final  List<String> _args;
@override@JsonKey() List<String> get args {
  if (_args is EqualUnmodifiableListView) return _args;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_args);
}

// SSE / StreamableHTTP fields
@override final  String? url;
// HTTP extra headers (non-sensitive keys only; values stored in secure storage)
 final  Map<String, String> _headers;
// HTTP extra headers (non-sensitive keys only; values stored in secure storage)
@override@JsonKey() Map<String, String> get headers {
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_headers);
}

// Key used to retrieve the auth token from flutter_secure_storage
@override final  String? authTokenKey;
// Metadata
@override final  DateTime? lastConnectedAt;

/// Create a copy of ServerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerProfileCopyWith<_ServerProfile> get copyWith => __$ServerProfileCopyWithImpl<_ServerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.transportType, transportType) || other.transportType == transportType)&&(identical(other.command, command) || other.command == command)&&const DeepCollectionEquality().equals(other._args, _args)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._headers, _headers)&&(identical(other.authTokenKey, authTokenKey) || other.authTokenKey == authTokenKey)&&(identical(other.lastConnectedAt, lastConnectedAt) || other.lastConnectedAt == lastConnectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,transportType,command,const DeepCollectionEquality().hash(_args),url,const DeepCollectionEquality().hash(_headers),authTokenKey,lastConnectedAt);

@override
String toString() {
  return 'ServerProfile(id: $id, name: $name, transportType: $transportType, command: $command, args: $args, url: $url, headers: $headers, authTokenKey: $authTokenKey, lastConnectedAt: $lastConnectedAt)';
}


}

/// @nodoc
abstract mixin class _$ServerProfileCopyWith<$Res> implements $ServerProfileCopyWith<$Res> {
  factory _$ServerProfileCopyWith(_ServerProfile value, $Res Function(_ServerProfile) _then) = __$ServerProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, TransportType transportType, String? command, List<String> args, String? url, Map<String, String> headers, String? authTokenKey, DateTime? lastConnectedAt
});




}
/// @nodoc
class __$ServerProfileCopyWithImpl<$Res>
    implements _$ServerProfileCopyWith<$Res> {
  __$ServerProfileCopyWithImpl(this._self, this._then);

  final _ServerProfile _self;
  final $Res Function(_ServerProfile) _then;

/// Create a copy of ServerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? transportType = null,Object? command = freezed,Object? args = null,Object? url = freezed,Object? headers = null,Object? authTokenKey = freezed,Object? lastConnectedAt = freezed,}) {
  return _then(_ServerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,command: freezed == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String?,args: null == args ? _self._args : args // ignore: cast_nullable_to_non_nullable
as List<String>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,headers: null == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>,authTokenKey: freezed == authTokenKey ? _self.authTokenKey : authTokenKey // ignore: cast_nullable_to_non_nullable
as String?,lastConnectedAt: freezed == lastConnectedAt ? _self.lastConnectedAt : lastConnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
