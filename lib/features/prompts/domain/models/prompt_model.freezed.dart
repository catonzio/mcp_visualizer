// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prompt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PromptArgumentModel {

 String get name; String? get description; bool get required; String? get defaultValue;
/// Create a copy of PromptArgumentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromptArgumentModelCopyWith<PromptArgumentModel> get copyWith => _$PromptArgumentModelCopyWithImpl<PromptArgumentModel>(this as PromptArgumentModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromptArgumentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.required, required) || other.required == required)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,required,defaultValue);

@override
String toString() {
  return 'PromptArgumentModel(name: $name, description: $description, required: $required, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class $PromptArgumentModelCopyWith<$Res>  {
  factory $PromptArgumentModelCopyWith(PromptArgumentModel value, $Res Function(PromptArgumentModel) _then) = _$PromptArgumentModelCopyWithImpl;
@useResult
$Res call({
 String name, String? description, bool required, String? defaultValue
});




}
/// @nodoc
class _$PromptArgumentModelCopyWithImpl<$Res>
    implements $PromptArgumentModelCopyWith<$Res> {
  _$PromptArgumentModelCopyWithImpl(this._self, this._then);

  final PromptArgumentModel _self;
  final $Res Function(PromptArgumentModel) _then;

/// Create a copy of PromptArgumentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? required = null,Object? defaultValue = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PromptArgumentModel].
extension PromptArgumentModelPatterns on PromptArgumentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromptArgumentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromptArgumentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromptArgumentModel value)  $default,){
final _that = this;
switch (_that) {
case _PromptArgumentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromptArgumentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PromptArgumentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  bool required,  String? defaultValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromptArgumentModel() when $default != null:
return $default(_that.name,_that.description,_that.required,_that.defaultValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  bool required,  String? defaultValue)  $default,) {final _that = this;
switch (_that) {
case _PromptArgumentModel():
return $default(_that.name,_that.description,_that.required,_that.defaultValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  bool required,  String? defaultValue)?  $default,) {final _that = this;
switch (_that) {
case _PromptArgumentModel() when $default != null:
return $default(_that.name,_that.description,_that.required,_that.defaultValue);case _:
  return null;

}
}

}

/// @nodoc


class _PromptArgumentModel implements PromptArgumentModel {
  const _PromptArgumentModel({required this.name, this.description, this.required = false, this.defaultValue});
  

@override final  String name;
@override final  String? description;
@override@JsonKey() final  bool required;
@override final  String? defaultValue;

/// Create a copy of PromptArgumentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromptArgumentModelCopyWith<_PromptArgumentModel> get copyWith => __$PromptArgumentModelCopyWithImpl<_PromptArgumentModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromptArgumentModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.required, required) || other.required == required)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,required,defaultValue);

@override
String toString() {
  return 'PromptArgumentModel(name: $name, description: $description, required: $required, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class _$PromptArgumentModelCopyWith<$Res> implements $PromptArgumentModelCopyWith<$Res> {
  factory _$PromptArgumentModelCopyWith(_PromptArgumentModel value, $Res Function(_PromptArgumentModel) _then) = __$PromptArgumentModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, bool required, String? defaultValue
});




}
/// @nodoc
class __$PromptArgumentModelCopyWithImpl<$Res>
    implements _$PromptArgumentModelCopyWith<$Res> {
  __$PromptArgumentModelCopyWithImpl(this._self, this._then);

  final _PromptArgumentModel _self;
  final $Res Function(_PromptArgumentModel) _then;

/// Create a copy of PromptArgumentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? required = null,Object? defaultValue = freezed,}) {
  return _then(_PromptArgumentModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PromptModel {

 String get name; String? get description; List<PromptArgumentModel> get arguments;
/// Create a copy of PromptModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromptModelCopyWith<PromptModel> get copyWith => _$PromptModelCopyWithImpl<PromptModel>(this as PromptModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromptModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.arguments, arguments));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(arguments));

@override
String toString() {
  return 'PromptModel(name: $name, description: $description, arguments: $arguments)';
}


}

/// @nodoc
abstract mixin class $PromptModelCopyWith<$Res>  {
  factory $PromptModelCopyWith(PromptModel value, $Res Function(PromptModel) _then) = _$PromptModelCopyWithImpl;
@useResult
$Res call({
 String name, String? description, List<PromptArgumentModel> arguments
});




}
/// @nodoc
class _$PromptModelCopyWithImpl<$Res>
    implements $PromptModelCopyWith<$Res> {
  _$PromptModelCopyWithImpl(this._self, this._then);

  final PromptModel _self;
  final $Res Function(PromptModel) _then;

/// Create a copy of PromptModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? arguments = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,arguments: null == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as List<PromptArgumentModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [PromptModel].
extension PromptModelPatterns on PromptModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromptModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromptModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromptModel value)  $default,){
final _that = this;
switch (_that) {
case _PromptModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromptModel value)?  $default,){
final _that = this;
switch (_that) {
case _PromptModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  List<PromptArgumentModel> arguments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromptModel() when $default != null:
return $default(_that.name,_that.description,_that.arguments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  List<PromptArgumentModel> arguments)  $default,) {final _that = this;
switch (_that) {
case _PromptModel():
return $default(_that.name,_that.description,_that.arguments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  List<PromptArgumentModel> arguments)?  $default,) {final _that = this;
switch (_that) {
case _PromptModel() when $default != null:
return $default(_that.name,_that.description,_that.arguments);case _:
  return null;

}
}

}

/// @nodoc


class _PromptModel implements PromptModel {
  const _PromptModel({required this.name, this.description, final  List<PromptArgumentModel> arguments = const []}): _arguments = arguments;
  

@override final  String name;
@override final  String? description;
 final  List<PromptArgumentModel> _arguments;
@override@JsonKey() List<PromptArgumentModel> get arguments {
  if (_arguments is EqualUnmodifiableListView) return _arguments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arguments);
}


/// Create a copy of PromptModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromptModelCopyWith<_PromptModel> get copyWith => __$PromptModelCopyWithImpl<_PromptModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromptModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._arguments, _arguments));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(_arguments));

@override
String toString() {
  return 'PromptModel(name: $name, description: $description, arguments: $arguments)';
}


}

/// @nodoc
abstract mixin class _$PromptModelCopyWith<$Res> implements $PromptModelCopyWith<$Res> {
  factory _$PromptModelCopyWith(_PromptModel value, $Res Function(_PromptModel) _then) = __$PromptModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, List<PromptArgumentModel> arguments
});




}
/// @nodoc
class __$PromptModelCopyWithImpl<$Res>
    implements _$PromptModelCopyWith<$Res> {
  __$PromptModelCopyWithImpl(this._self, this._then);

  final _PromptModel _self;
  final $Res Function(_PromptModel) _then;

/// Create a copy of PromptModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? arguments = null,}) {
  return _then(_PromptModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,arguments: null == arguments ? _self._arguments : arguments // ignore: cast_nullable_to_non_nullable
as List<PromptArgumentModel>,
  ));
}


}

// dart format on
