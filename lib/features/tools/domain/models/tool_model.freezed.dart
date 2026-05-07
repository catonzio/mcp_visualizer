// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToolModel {

 String get name; String get description; Map<String, dynamic> get inputSchema;
/// Create a copy of ToolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolModelCopyWith<ToolModel> get copyWith => _$ToolModelCopyWithImpl<ToolModel>(this as ToolModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.inputSchema, inputSchema));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(inputSchema));

@override
String toString() {
  return 'ToolModel(name: $name, description: $description, inputSchema: $inputSchema)';
}


}

/// @nodoc
abstract mixin class $ToolModelCopyWith<$Res>  {
  factory $ToolModelCopyWith(ToolModel value, $Res Function(ToolModel) _then) = _$ToolModelCopyWithImpl;
@useResult
$Res call({
 String name, String description, Map<String, dynamic> inputSchema
});




}
/// @nodoc
class _$ToolModelCopyWithImpl<$Res>
    implements $ToolModelCopyWith<$Res> {
  _$ToolModelCopyWithImpl(this._self, this._then);

  final ToolModel _self;
  final $Res Function(ToolModel) _then;

/// Create a copy of ToolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? inputSchema = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,inputSchema: null == inputSchema ? _self.inputSchema : inputSchema // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolModel].
extension ToolModelPatterns on ToolModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolModel value)  $default,){
final _that = this;
switch (_that) {
case _ToolModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolModel value)?  $default,){
final _that = this;
switch (_that) {
case _ToolModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  Map<String, dynamic> inputSchema)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolModel() when $default != null:
return $default(_that.name,_that.description,_that.inputSchema);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  Map<String, dynamic> inputSchema)  $default,) {final _that = this;
switch (_that) {
case _ToolModel():
return $default(_that.name,_that.description,_that.inputSchema);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  Map<String, dynamic> inputSchema)?  $default,) {final _that = this;
switch (_that) {
case _ToolModel() when $default != null:
return $default(_that.name,_that.description,_that.inputSchema);case _:
  return null;

}
}

}

/// @nodoc


class _ToolModel implements ToolModel {
  const _ToolModel({required this.name, required this.description, required final  Map<String, dynamic> inputSchema}): _inputSchema = inputSchema;
  

@override final  String name;
@override final  String description;
 final  Map<String, dynamic> _inputSchema;
@override Map<String, dynamic> get inputSchema {
  if (_inputSchema is EqualUnmodifiableMapView) return _inputSchema;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_inputSchema);
}


/// Create a copy of ToolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolModelCopyWith<_ToolModel> get copyWith => __$ToolModelCopyWithImpl<_ToolModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolModel&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._inputSchema, _inputSchema));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(_inputSchema));

@override
String toString() {
  return 'ToolModel(name: $name, description: $description, inputSchema: $inputSchema)';
}


}

/// @nodoc
abstract mixin class _$ToolModelCopyWith<$Res> implements $ToolModelCopyWith<$Res> {
  factory _$ToolModelCopyWith(_ToolModel value, $Res Function(_ToolModel) _then) = __$ToolModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, Map<String, dynamic> inputSchema
});




}
/// @nodoc
class __$ToolModelCopyWithImpl<$Res>
    implements _$ToolModelCopyWith<$Res> {
  __$ToolModelCopyWithImpl(this._self, this._then);

  final _ToolModel _self;
  final $Res Function(_ToolModel) _then;

/// Create a copy of ToolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? inputSchema = null,}) {
  return _then(_ToolModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,inputSchema: null == inputSchema ? _self._inputSchema : inputSchema // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
