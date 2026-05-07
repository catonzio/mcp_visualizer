import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_model.freezed.dart';

@freezed
abstract class FieldModel with _$FieldModel {
  const factory FieldModel({
    required String name,
    required String type,
    @Default(false) bool isRequired,
    @Default(null) dynamic defaultValue,
  }) = _FieldModel;
}
