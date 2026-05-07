// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToolResultModel {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolResultModel);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ToolResultModel()';
}


}

/// @nodoc
class $ToolResultModelCopyWith<$Res>  {
$ToolResultModelCopyWith(ToolResultModel _, $Res Function(ToolResultModel) __);
}


/// Adds pattern-matching-related methods to [ToolResultModel].
extension ToolResultModelPatterns on ToolResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ToolResultText value)?  text,TResult Function( ToolResultImage value)?  image,TResult Function( ToolResultError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ToolResultText() when text != null:
return text(_that);case ToolResultImage() when image != null:
return image(_that);case ToolResultError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ToolResultText value)  text,required TResult Function( ToolResultImage value)  image,required TResult Function( ToolResultError value)  error,}){
final _that = this;
switch (_that) {
case ToolResultText():
return text(_that);case ToolResultImage():
return image(_that);case ToolResultError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ToolResultText value)?  text,TResult? Function( ToolResultImage value)?  image,TResult? Function( ToolResultError value)?  error,}){
final _that = this;
switch (_that) {
case ToolResultText() when text != null:
return text(_that);case ToolResultImage() when image != null:
return image(_that);case ToolResultError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  text,TResult Function( String? data,  String? url,  String mimeType)?  image,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ToolResultText() when text != null:
return text(_that.value);case ToolResultImage() when image != null:
return image(_that.data,_that.url,_that.mimeType);case ToolResultError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  text,required TResult Function( String? data,  String? url,  String mimeType)  image,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ToolResultText():
return text(_that.value);case ToolResultImage():
return image(_that.data,_that.url,_that.mimeType);case ToolResultError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  text,TResult? Function( String? data,  String? url,  String mimeType)?  image,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ToolResultText() when text != null:
return text(_that.value);case ToolResultImage() when image != null:
return image(_that.data,_that.url,_that.mimeType);case ToolResultError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ToolResultText implements ToolResultModel {
  const ToolResultText({required this.value});
  

 final  String value;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolResultTextCopyWith<ToolResultText> get copyWith => _$ToolResultTextCopyWithImpl<ToolResultText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolResultText&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ToolResultModel.text(value: $value)';
}


}

/// @nodoc
abstract mixin class $ToolResultTextCopyWith<$Res> implements $ToolResultModelCopyWith<$Res> {
  factory $ToolResultTextCopyWith(ToolResultText value, $Res Function(ToolResultText) _then) = _$ToolResultTextCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ToolResultTextCopyWithImpl<$Res>
    implements $ToolResultTextCopyWith<$Res> {
  _$ToolResultTextCopyWithImpl(this._self, this._then);

  final ToolResultText _self;
  final $Res Function(ToolResultText) _then;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ToolResultText(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToolResultImage implements ToolResultModel {
  const ToolResultImage({this.data, this.url, required this.mimeType});
  

 final  String? data;
// base64
 final  String? url;
 final  String mimeType;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolResultImageCopyWith<ToolResultImage> get copyWith => _$ToolResultImageCopyWithImpl<ToolResultImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolResultImage&&(identical(other.data, data) || other.data == data)&&(identical(other.url, url) || other.url == url)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,data,url,mimeType);

@override
String toString() {
  return 'ToolResultModel.image(data: $data, url: $url, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $ToolResultImageCopyWith<$Res> implements $ToolResultModelCopyWith<$Res> {
  factory $ToolResultImageCopyWith(ToolResultImage value, $Res Function(ToolResultImage) _then) = _$ToolResultImageCopyWithImpl;
@useResult
$Res call({
 String? data, String? url, String mimeType
});




}
/// @nodoc
class _$ToolResultImageCopyWithImpl<$Res>
    implements $ToolResultImageCopyWith<$Res> {
  _$ToolResultImageCopyWithImpl(this._self, this._then);

  final ToolResultImage _self;
  final $Res Function(ToolResultImage) _then;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? url = freezed,Object? mimeType = null,}) {
  return _then(ToolResultImage(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToolResultError implements ToolResultModel {
  const ToolResultError({required this.message});
  

 final  String message;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolResultErrorCopyWith<ToolResultError> get copyWith => _$ToolResultErrorCopyWithImpl<ToolResultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolResultError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ToolResultModel.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ToolResultErrorCopyWith<$Res> implements $ToolResultModelCopyWith<$Res> {
  factory $ToolResultErrorCopyWith(ToolResultError value, $Res Function(ToolResultError) _then) = _$ToolResultErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ToolResultErrorCopyWithImpl<$Res>
    implements $ToolResultErrorCopyWith<$Res> {
  _$ToolResultErrorCopyWithImpl(this._self, this._then);

  final ToolResultError _self;
  final $Res Function(ToolResultError) _then;

/// Create a copy of ToolResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ToolResultError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
