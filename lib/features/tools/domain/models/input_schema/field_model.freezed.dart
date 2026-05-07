// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldModel {

 String get name; String get type; bool get isRequired; dynamic get defaultValue;
/// Create a copy of FieldModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldModelCopyWith<FieldModel> get copyWith => _$FieldModelCopyWithImpl<FieldModel>(this as FieldModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldModel&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,isRequired,const DeepCollectionEquality().hash(defaultValue));

@override
String toString() {
  return 'FieldModel(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class $FieldModelCopyWith<$Res>  {
  factory $FieldModelCopyWith(FieldModel value, $Res Function(FieldModel) _then) = _$FieldModelCopyWithImpl;
@useResult
$Res call({
 String name, String type, bool isRequired, dynamic defaultValue
});




}
/// @nodoc
class _$FieldModelCopyWithImpl<$Res>
    implements $FieldModelCopyWith<$Res> {
  _$FieldModelCopyWithImpl(this._self, this._then);

  final FieldModel _self;
  final $Res Function(FieldModel) _then;

/// Create a copy of FieldModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? isRequired = null,Object? defaultValue = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldModel].
extension FieldModelPatterns on FieldModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldModel value)  $default,){
final _that = this;
switch (_that) {
case _FieldModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldModel value)?  $default,){
final _that = this;
switch (_that) {
case _FieldModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String type,  bool isRequired,  dynamic defaultValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldModel() when $default != null:
return $default(_that.name,_that.type,_that.isRequired,_that.defaultValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String type,  bool isRequired,  dynamic defaultValue)  $default,) {final _that = this;
switch (_that) {
case _FieldModel():
return $default(_that.name,_that.type,_that.isRequired,_that.defaultValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String type,  bool isRequired,  dynamic defaultValue)?  $default,) {final _that = this;
switch (_that) {
case _FieldModel() when $default != null:
return $default(_that.name,_that.type,_that.isRequired,_that.defaultValue);case _:
  return null;

}
}

}

/// @nodoc


class _FieldModel implements FieldModel {
  const _FieldModel({required this.name, required this.type, this.isRequired = false, this.defaultValue = null});
  

@override final  String name;
@override final  String type;
@override@JsonKey() final  bool isRequired;
@override@JsonKey() final  dynamic defaultValue;

/// Create a copy of FieldModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldModelCopyWith<_FieldModel> get copyWith => __$FieldModelCopyWithImpl<_FieldModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldModel&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,isRequired,const DeepCollectionEquality().hash(defaultValue));

@override
String toString() {
  return 'FieldModel(name: $name, type: $type, isRequired: $isRequired, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class _$FieldModelCopyWith<$Res> implements $FieldModelCopyWith<$Res> {
  factory _$FieldModelCopyWith(_FieldModel value, $Res Function(_FieldModel) _then) = __$FieldModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String type, bool isRequired, dynamic defaultValue
});




}
/// @nodoc
class __$FieldModelCopyWithImpl<$Res>
    implements _$FieldModelCopyWith<$Res> {
  __$FieldModelCopyWithImpl(this._self, this._then);

  final _FieldModel _self;
  final $Res Function(_FieldModel) _then;

/// Create a copy of FieldModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? isRequired = null,Object? defaultValue = freezed,}) {
  return _then(_FieldModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
