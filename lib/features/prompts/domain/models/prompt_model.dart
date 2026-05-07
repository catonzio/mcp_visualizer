import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_model.freezed.dart';

@freezed
abstract class PromptArgumentModel with _$PromptArgumentModel {
  const factory PromptArgumentModel({
    required String name,
    String? description,
    @Default(false) bool required,
    String? defaultValue,
  }) = _PromptArgumentModel;
}

@freezed
abstract class PromptModel with _$PromptModel {
  const factory PromptModel({
    required String name,
    String? description,
    @Default([]) List<PromptArgumentModel> arguments,
  }) = _PromptModel;
}
