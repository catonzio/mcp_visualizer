// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServerInfo {

 String get name; String get version; String get protocolVersion;
/// Create a copy of ServerInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerInfoCopyWith<ServerInfo> get copyWith => _$ServerInfoCopyWithImpl<ServerInfo>(this as ServerInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}


@override
int get hashCode => Object.hash(runtimeType,name,version,protocolVersion);

@override
String toString() {
  return 'ServerInfo(name: $name, version: $version, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class $ServerInfoCopyWith<$Res>  {
  factory $ServerInfoCopyWith(ServerInfo value, $Res Function(ServerInfo) _then) = _$ServerInfoCopyWithImpl;
@useResult
$Res call({
 String name, String version, String protocolVersion
});




}
/// @nodoc
class _$ServerInfoCopyWithImpl<$Res>
    implements $ServerInfoCopyWith<$Res> {
  _$ServerInfoCopyWithImpl(this._self, this._then);

  final ServerInfo _self;
  final $Res Function(ServerInfo) _then;

/// Create a copy of ServerInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? version = null,Object? protocolVersion = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerInfo].
extension ServerInfoPatterns on ServerInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerInfo value)  $default,){
final _that = this;
switch (_that) {
case _ServerInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ServerInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String version,  String protocolVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerInfo() when $default != null:
return $default(_that.name,_that.version,_that.protocolVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String version,  String protocolVersion)  $default,) {final _that = this;
switch (_that) {
case _ServerInfo():
return $default(_that.name,_that.version,_that.protocolVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String version,  String protocolVersion)?  $default,) {final _that = this;
switch (_that) {
case _ServerInfo() when $default != null:
return $default(_that.name,_that.version,_that.protocolVersion);case _:
  return null;

}
}

}

/// @nodoc


class _ServerInfo implements ServerInfo {
  const _ServerInfo({required this.name, required this.version, required this.protocolVersion});
  

@override final  String name;
@override final  String version;
@override final  String protocolVersion;

/// Create a copy of ServerInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerInfoCopyWith<_ServerInfo> get copyWith => __$ServerInfoCopyWithImpl<_ServerInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.version, version) || other.version == version)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}


@override
int get hashCode => Object.hash(runtimeType,name,version,protocolVersion);

@override
String toString() {
  return 'ServerInfo(name: $name, version: $version, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class _$ServerInfoCopyWith<$Res> implements $ServerInfoCopyWith<$Res> {
  factory _$ServerInfoCopyWith(_ServerInfo value, $Res Function(_ServerInfo) _then) = __$ServerInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String version, String protocolVersion
});




}
/// @nodoc
class __$ServerInfoCopyWithImpl<$Res>
    implements _$ServerInfoCopyWith<$Res> {
  __$ServerInfoCopyWithImpl(this._self, this._then);

  final _ServerInfo _self;
  final $Res Function(_ServerInfo) _then;

/// Create a copy of ServerInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? version = null,Object? protocolVersion = null,}) {
  return _then(_ServerInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
