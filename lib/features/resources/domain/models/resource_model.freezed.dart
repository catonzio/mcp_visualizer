// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResourceModel {

 String get uri; String get name; String get description; String? get mimeType;
/// Create a copy of ResourceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceModelCopyWith<ResourceModel> get copyWith => _$ResourceModelCopyWithImpl<ResourceModel>(this as ResourceModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourceModel&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,uri,name,description,mimeType);

@override
String toString() {
  return 'ResourceModel(uri: $uri, name: $name, description: $description, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $ResourceModelCopyWith<$Res>  {
  factory $ResourceModelCopyWith(ResourceModel value, $Res Function(ResourceModel) _then) = _$ResourceModelCopyWithImpl;
@useResult
$Res call({
 String uri, String name, String description, String? mimeType
});




}
/// @nodoc
class _$ResourceModelCopyWithImpl<$Res>
    implements $ResourceModelCopyWith<$Res> {
  _$ResourceModelCopyWithImpl(this._self, this._then);

  final ResourceModel _self;
  final $Res Function(ResourceModel) _then;

/// Create a copy of ResourceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uri = null,Object? name = null,Object? description = null,Object? mimeType = freezed,}) {
  return _then(_self.copyWith(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResourceModel].
extension ResourceModelPatterns on ResourceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResourceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResourceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResourceModel value)  $default,){
final _that = this;
switch (_that) {
case _ResourceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResourceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResourceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uri,  String name,  String description,  String? mimeType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResourceModel() when $default != null:
return $default(_that.uri,_that.name,_that.description,_that.mimeType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uri,  String name,  String description,  String? mimeType)  $default,) {final _that = this;
switch (_that) {
case _ResourceModel():
return $default(_that.uri,_that.name,_that.description,_that.mimeType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uri,  String name,  String description,  String? mimeType)?  $default,) {final _that = this;
switch (_that) {
case _ResourceModel() when $default != null:
return $default(_that.uri,_that.name,_that.description,_that.mimeType);case _:
  return null;

}
}

}

/// @nodoc


class _ResourceModel implements ResourceModel {
  const _ResourceModel({required this.uri, required this.name, required this.description, this.mimeType});
  

@override final  String uri;
@override final  String name;
@override final  String description;
@override final  String? mimeType;

/// Create a copy of ResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourceModelCopyWith<_ResourceModel> get copyWith => __$ResourceModelCopyWithImpl<_ResourceModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResourceModel&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,uri,name,description,mimeType);

@override
String toString() {
  return 'ResourceModel(uri: $uri, name: $name, description: $description, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class _$ResourceModelCopyWith<$Res> implements $ResourceModelCopyWith<$Res> {
  factory _$ResourceModelCopyWith(_ResourceModel value, $Res Function(_ResourceModel) _then) = __$ResourceModelCopyWithImpl;
@override @useResult
$Res call({
 String uri, String name, String description, String? mimeType
});




}
/// @nodoc
class __$ResourceModelCopyWithImpl<$Res>
    implements _$ResourceModelCopyWith<$Res> {
  __$ResourceModelCopyWithImpl(this._self, this._then);

  final _ResourceModel _self;
  final $Res Function(_ResourceModel) _then;

/// Create a copy of ResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uri = null,Object? name = null,Object? description = null,Object? mimeType = freezed,}) {
  return _then(_ResourceModel(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
